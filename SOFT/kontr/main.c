#include "stm8s.h"
#include "main.h"
#include "lowlev.h"
#include "ds18b20.h"
#include "uart3.h"
#include "ds1307.h"
#include <iostm8s.h>

//-----------------------------------------------
//Переменные в EEPROM
@eeprom signed short	HUMAN_SET_EE 					@0x4004;	//подпись человека (0x1234)
@eeprom signed char	  	NECC_TEMPER_AIR_EE 				@0x4010;	//температура поддержания воздуха
@eeprom signed char		NECC_TEMPER_WATER_EE 			@0x4011;	//температура поддержания воды
@eeprom signed char 	MODE_EE							@0x4012;	//режим работы устройства (1 - по воде, 2 - по воздуху, 3 - по графику) 
@eeprom signed char 	MAX_POWER_EE					@0x4013;	//максимальная мощность нагревания 
@eeprom unsigned char 	TABLE_TIME_EE[7][5]				@0x4020;	//таблица временных меток для семи дней недели, временная метка 
																	//выражается в десятках минут
@eeprom signed char 	TABLE_TEMPER_EE[7][5]			@0x4048;	//таблица температурных меток для семи дней недели, температурная метка  
																	//выражается в градусах со знаком


//-----------------------------------------------
//Порядок включения ТЭНов в зависимости от случайного числа
const char warmOrder[6][3]={ 								{0,1,2},
															{0,2,1},
															{1,0,2},
															{1,2,0},
															{2,0,1},
															{2,1,0}
														};
char currRandom,fiksRandom;

//-----------------------------------------------
//Временная сетка
bool b100Hz=0,b10Hz=0,b5Hz=0,b2Hz=0,b1Hz=0;
char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;
signed char mainCnt;
//-----------------------------------------------
//Индикация
char ind_cnt;
char ind_outB[12];
char ind_outC[12]={0x00,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
char ind_outG[12]={0x00,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff};
const char ind_strob[12]={0b11011111,0b11101111,0b11110111,0b11111011,0b11011111,0b11011111,0b11011111,0b11011111,0b11011111,0b11111111,0b11011111,0b11111111};
char dig[10];
char ind_out_[5];
const char DIGISYM[30]={	0b11000000,0b11111001,0b10100100,0b10110000,0b10011001,0b10010010,0b10000010,0b11111000,0b10000000,0b10010000,
					0b00010001,0b00000111,0b10001101,0b01000011,0b00000111,0b00001111,0b11111111,0b11111111,0b11111111,0b11111111,
					0b11111111,0b11111101,0b11111011,0b11110111,0b11101111,0b11011111,0b10111111,0b01111111};
					
struct_ind a_ind,b_ind[10],c_ind;
signed char ind_pointer=0;
bool zero_on;
bool bFL5,bFL2,bFL1,bFL_;
char led_ind_out1,led_ind_out2;

//-----------------------------------------------
//Управление выходом
enum_out_stat out_stat[3],out_mode=osOFF;

//-----------------------------------------------
//Температура
signed char temperOfWater;
signed char	temperOfAir;
signed char temperToReg;
signed char temperRegTo;

//-----------------------------------------------
//Время
char buff_for_time[10];
char time_sec;
char time_min;
char time_hour;
char time_day_of_week;
char time_date;
char time_month;
char time_year;

//-----------------------------------------------
//Константы для определения границ установки времени в таблице
const unsigned char TABLE_TIME_EE_MIN[5]={0,36,72,108,126};
const unsigned char TABLE_TIME_EE_MAX[5]={35,71,107,125,143};

//-----------------------------------------------
//Регулирование мощности
signed char powerNecc=0,powerNeccOld=0;
signed char powerNeccDelta;

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//отладка
//char random_plazma;
unsigned char tempUC;
//@near signed char 	TABLE_TEMPER_EE[7][5];
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


//-----------------------------------------------
void time_drv(void)
{
_ds1307_read_time(buff_for_time);

time_sec=(((buff_for_time[0]&0x70)>>4)*10)+(buff_for_time[0]&0x0f);
time_min=(((buff_for_time[1]&0x70)>>4)*10)+(buff_for_time[1]&0x0f);
time_hour=(((buff_for_time[2]&0x30)>>4)*10)+(buff_for_time[2]&0x0f);
time_date=(((buff_for_time[4]&0x30)>>4)*10)+(buff_for_time[4]&0x0f);
time_month=(((buff_for_time[5]&0x10)>>4)*10)+(buff_for_time[5]&0x0f);
time_year=(((buff_for_time[6]&0xf0)>>4)*10)+(buff_for_time[6]&0x0f);
time_day_of_week=(buff_for_time[3]&0x07);
}

//-----------------------------------------------
void power_hndl(void)
{
disableInterrupts();	
if((powerNecc)&&(powerNeccOld==0))
	{
	fiksRandom=currRandom;
	}
	
if(!powerNecc)
	{
	out_stat[0]=osOFF;
	out_stat[1]=osOFF;
	out_stat[2]=osOFF;
	}
else 
	{
	char i;
	for(i=0;i<3;i++)
		{
		if((i<powerNecc)&&(i<MAX_POWER_EE))		out_stat[warmOrder[fiksRandom][i]]=osON;
		else									out_stat[warmOrder[fiksRandom][i]]=osOFF;
		}
	}
	
powerNeccOld=powerNecc;
enableInterrupts();
}

//-----------------------------------------------
void power_necc_hndl(void)
{

if(temperToReg>=temperRegTo)
	{
	powerNecc=0;	
	}
else if(temperToReg<temperRegTo)
	{
	powerNeccDelta=temperRegTo-temperToReg;
	powerNecc=0;
	if(powerNeccDelta>=2) powerNecc=1;
	if(powerNeccDelta>=3) powerNecc=2;
	if(powerNeccDelta>=4) powerNecc=3;
	}

}

//-----------------------------------------------
void matemath(void)
{
char temperOfWaterTemp; 
if((wire1_in[1]&0xf0)==0)
	{
	temperOfWaterTemp=((wire1_in[0]&0xf0)>>4)+((wire1_in[1]&0x0f)<<4);
	temperOfWater=(signed short)temperOfWaterTemp;
	}
if(MODE_EE==1)
	{
	temperToReg=temperOfWater;
	temperRegTo=NECC_TEMPER_WATER_EE;
	}
else if(MODE_EE==2)
	{
	temperToReg=temperOfAir;
	temperRegTo=NECC_TEMPER_AIR_EE;
	}
else if(MODE_EE==3)
	{
	temperToReg=temperOfAir;
	temperRegTo=NECC_TEMPER_AIR_EE;
	}
}

//-----------------------------------------------
void ind_hndl(void)
{
char i;

if(ind==iMn)
	{
	int2indII_slkuf(time_hour,2, 2, 0, 0, 0);
	int2indII_slkuf(time_min,0, 2, 0, 0, 0);
	if(bFL2)	ind_outG[2]&=0b11111110;
	//int2indII_slkuf(time_sec,0, 2, 0, 0, 0);
	//else 		int2indII_slkuf(time_sec,0, 2, 1, 0, 0);
	
	if(temperToReg>=0)
		{
		int2indI_slkuf(temperToReg,2, 2, 0, 1, 0);
		ind_outB[1]=0b10011100;
		}
	else 
		{
		if(-temperToReg<10)
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-temperToReg,2, 1, 0, 1, 0);
			ind_outB[1]=0b10011100;
			}
		else
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-temperToReg,1, 2, 0, 1, 0);
			}
		}
	
//	int2indI_slkuf(random_plazma,3, 1, 0, 1, 0);
	
	led_mask_off(0x00);
	if(out_mode==osON)led_on(MODE_EE);
	if((out_mode==osON)&&(out_stat[0]==osON))led_on(4);
	if((out_mode==osON)&&(out_stat[1]==osON))led_on(5);
	if((out_mode==osON)&&(out_stat[2]==osON))led_on(6);
	//led_set(2,0);
	//led_set(3,2);
	}
else if(ind==iDate_W)
	{
	if(sub_ind==0)
		{
		int2indI_slkuf(12,1, 2, 0, 1, 0);
		int2indII_slkuf(time_date,2, 2, 0, 1, 0);
		int2indII_slkuf(time_month,0, 2, 0, 1, 0);
		ind_outG[2]&=0b11111110;		
		}
	else if(sub_ind==1)
		{
		int2indI_slkuf(13,1, 2, 0, 1, 0);
		int2indII_slkuf(time_year,2, 2, 0, 1, 0);
		int2indII_slkuf(time_day_of_week,0, 2, 0, 1, 0);		
		}		
	}
else if(ind==iSet)
	{
	int2indI_slkuf(sub_ind+1,1, 2, 0, 1, 1);
	ind_outB[3]=0b10010001;	
	
	if(sub_ind==0)
		{
		int2indII_slkuf(MODE_EE,0, 2, 0, 1, 0);
		}
	else if(sub_ind==1)
		{
		int2indII_slkuf(NECC_TEMPER_AIR_EE,0, 2, 0, 1, 0);
		}	
	else if(sub_ind==2)
		{
		int2indII_slkuf(NECC_TEMPER_WATER_EE,0, 2, 0, 1, 0);
		}
	else if(sub_ind==3)
		{
		int2indII_slkuf(MAX_POWER_EE,0, 2, 0, 1, 0);
		}	
	else if(sub_ind==4)
		{
		int2indII_slkuf(time_year,0, 2, 0, 1, 0);
		}	
	else if(sub_ind==5)
		{
		int2indII_slkuf(time_month,0, 2, 0, 1, 0);
		}
	else if(sub_ind==6)
		{
		int2indII_slkuf(time_date,0, 2, 0, 1, 0);
		int2indII_slkuf(time_day_of_week,2, 2, 0, 1, 0);
		}	
	else if(sub_ind==7)
		{
		int2indII_slkuf(time_hour,0, 2, 0, 1, 0);
		}	
	else if(sub_ind==8)
		{
		int2indII_slkuf(time_min,0, 2, 0, 1, 0);
		}
	else if(sub_ind==9)
		{
		int2indII_slkuf(time_day_of_week,0, 2, 0, 1, 0);
		//int2indII_slkuf(time_day_of_week,2, 2, 0, 1, 0);
		}			
	}
else if(ind==iSet_)
	{
	int2indI_slkuf(sub_ind+1,1, 2, 0, 1, 0);
	ind_outB[3]=0b10010001;	
	
	if(sub_ind==0)
		{
		int2indII_slkuf(MODE_EE,0, 2, 0, 1, 1);
		}
	else if(sub_ind==1)
		{
		int2indII_slkuf(NECC_TEMPER_AIR_EE,0, 2, 0, 1, 1);
		}	
	else if(sub_ind==2)
		{
		int2indII_slkuf(NECC_TEMPER_WATER_EE,0, 2, 0, 1, 0);
		}
	else if(sub_ind==3)
		{
		int2indII_slkuf(MAX_POWER_EE,0, 2, 0, 1, 1);
		}	
	else if(sub_ind==4)
		{
		int2indII_slkuf(time_year,0, 2, 0, 1, 1);
		}
	else if(sub_ind==5)
		{
		int2indII_slkuf(time_month,0, 2, 0, 1, 1);
		}
	else if(sub_ind==6)
		{
		int2indII_slkuf(time_date,0, 2, 0, 1, 1);
		int2indII_slkuf(time_day_of_week,2, 2, 0, 1, 0);
		}	
	else if(sub_ind==7)
		{
		int2indII_slkuf(time_hour,0, 2, 0, 1, 1);
		}	
	else if(sub_ind==8)
		{
		int2indII_slkuf(time_min,0, 2, 0, 1, 1);
		}
	else if(sub_ind==9)
		{
		int2indII_slkuf(time_day_of_week,0, 2, 0, 1, 1);
		//int2indII_slkuf(time_day_of_week,2, 2, 0, 1, 0);
		}
	}
else if(ind==iSetTable)
	{
	ind_outB[3]=0b11001110;
	int2indI_slkuf(((sub_ind/5)+1)*10 + ((sub_ind)%5)+1,1, 2, 1, 0, 1);

	if(sub_ind1==0) 
		{
		int2indII_slkuf((TABLE_TIME_EE[sub_ind/5][sub_ind%5]*10)/60,2, 2, 0, 1, 0);
		int2indII_slkuf((TABLE_TIME_EE[sub_ind/5][sub_ind%5]*10)%60,0, 2, 0, 0, 0);
		ind_outG[2]&=0b11111110;
		}
	else 
		{
		int2indII_slkuf(TABLE_TEMPER_EE[sub_ind/5][sub_ind%5],1, 2, 0, 1, 0);
		ind_outC[0]=0b00111000;
		}
	
	}

else if(ind==iSetTable_)
	{
	ind_outB[3]=0b11001110;
	int2indI_slkuf(((sub_ind/5)+1)*10 + ((sub_ind)%5)+1,1, 2, 1, 0, 0);

	if(sub_ind1==0) 
		{
		int2indII_slkuf((TABLE_TIME_EE[sub_ind/5][sub_ind%5]*10)/60,2, 2, 0, 1, 1);
		int2indII_slkuf((TABLE_TIME_EE[sub_ind/5][sub_ind%5]*10)%60,0, 2, 0, 0, 1);
		if(!bFL2)	ind_outG[2]&=0b11111110;
		else 		ind_outG[2]|=0b00000001;
		}
	else 
		{
		int2indII_slkuf(TABLE_TEMPER_EE[sub_ind/5][sub_ind%5],1, 2, 0, 1, 1);
		ind_outC[0]=0b00111000;
		}
	
	}

else if(ind==iDeb)
	{
	led_mask_off(0x00);
	led_on(sub_ind+1);
	
	if(sub_ind==0)
		{
		int2indI_slkuf(temperRegTo,1, 2, 0, 0, 0);
		int2indII_slkuf(temperToReg,0, 2, 0, 0, 0);
		}
	else if(sub_ind==1)
		{
		int2indI_slkuf(MAX_POWER_EE,1, 2, 0, 0, 0);
		int2indII_slkuf(powerNeccDelta,2, 2, 0, 0, 0);
		int2indII_slkuf(powerNecc,0, 2, 0, 0, 0);
		}
	else if(sub_ind==2)
		{
		int2indI_slkuf(temperToReg,2, 2, 0, 0, 0);	
		int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(out_stat[0],3, 1, 0, 0, 0);
		int2indII_slkuf(out_stat[1],2, 1, 0, 0, 0);
		int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		int2indII_slkuf(fiksRandom,0, 1, 0, 0, 0);
		}		
	}
	
else if(ind==iTemperSet)
	{
	led_mask_off(0x00);
	if(out_mode==osON)led_on(MODE_EE);
	if((out_mode==osON)&&(out_stat[0]==osON))led_on(4);
	if((out_mode==osON)&&(out_stat[1]==osON))led_on(5);
	if((out_mode==osON)&&(out_stat[2]==osON))led_on(6);

	if(temperToReg>=0)
		{
		int2indI_slkuf(temperToReg,2, 2, 0, 1, 0);
		ind_outB[1]=0b10011100;
		}
	else 
		{
		if(-temperToReg<10)
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-temperToReg,2, 1, 0, 1, 0);
			ind_outB[1]=0b10011100;
			}
		else
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-temperToReg,1, 2, 0, 1, 0);
			}
		}

	int2indII_slkuf(temperRegTo,1, 2, 0, 1, MODE_EE==3?0:0);
	if((bFL2)&&(MODE_EE!=3))	ind_outC[0]=0b11111111;
	else 						ind_outC[0]=0b00111000;

	}	

if(bFL5)
	{
	ind_outB[0]=led_ind_out1;
	ind_outB[4]=led_ind_out1;
	ind_outB[5]=led_ind_out1;
	ind_outB[6]=led_ind_out1;
	ind_outB[7]=led_ind_out1;
	ind_outB[8]=led_ind_out1;
	ind_outB[9]=led_ind_out1;
	}
else 
	{
	ind_outB[0]=led_ind_out2;
	ind_outB[4]=led_ind_out2;
	ind_outB[5]=led_ind_out2;
	ind_outB[6]=led_ind_out2;
	ind_outB[7]=led_ind_out2;
	ind_outB[8]=led_ind_out2;
	ind_outB[9]=led_ind_out2;
	}	
}



//-----------------------------------------------
void but_an(void)
{
if(!n_but) return;
n_but=0;

if(but==butON)
	{
	if(out_mode==osON)	out_mode=osOFF;
	else 				out_mode=osON;
	}



if(ind==iMn)
	{
	if(but==butM_)
		{
		tree_up(iSet,0,0,0);
		}
	else if(but==butM)
		{
		tree_up(iTemperSet,0,0,0);
		ret_ind(5,0);
		}		
	else if(but==butU)
		{
		tree_up(iDate_W,0,0,0);
		ret_ind(4,0);
		}
	else if(but==butD_)
		{
		tree_up(iDeb,0,0,0);
		}
	}

else if(ind==iTemperSet)
	{
	if(but==butM)
		{
		tree_down(0,0);
		ret_ind(0,0);
		}
	else if(MODE_EE==1)
		{
		ret_ind(4,0);
		if((but==butU)||(but==butU_))
			{
			NECC_TEMPER_WATER_EE++;
			gran_char(&NECC_TEMPER_WATER_EE,5,85);
			speed=1;
			}
		if((but==butD)||(but==butD_))
			{
			NECC_TEMPER_WATER_EE--;
			gran_char(&NECC_TEMPER_WATER_EE,5,85);
			speed=1;
			}				
		}
	else if(MODE_EE==2)
		{
		ret_ind(4,0);
		if((but==butU)||(but==butU_))
			{
			NECC_TEMPER_AIR_EE++;
			gran_char(&NECC_TEMPER_AIR_EE,5,35);
			speed=1;
			}
		if((but==butD)||(but==butD_))
			{
			NECC_TEMPER_AIR_EE--;
			gran_char(&NECC_TEMPER_AIR_EE,5,35);
			speed=1;
			}				
		}		
	}
else if(ind==iDate_W)
	{
	if(but==butU)
		{
		if(sub_ind==0)
			{
			sub_ind=1;
			ret_ind(4,0);
			clear_ind();
			ind_hndl();			
			}
		else if(sub_ind==1)
			{
			tree_down(0,0);	
			}
		}		
	}
else if(ind==iSet)
	{
	if((but==butU)||(but==butU_))
		{
		sub_ind++;
		gran_char(&sub_ind,0,11);
		clear_ind();
		ind_hndl();
		}
	else if((but==butD)||(but==butD_))
		{
		sub_ind--;
		gran_char(&sub_ind,0,11);
		clear_ind();
		ind_hndl();
		}
	else if(but==butM_)
		{
		if(sub_ind==11) //Выход 
			{
			tree_down(0,0);
			}
		else if(sub_ind==10) //Вход в установку графика
			{
			tree_up(iSetTable,0,0,0);
			}			
		else
			{
			tree_up(iSet_,sub_ind,0,0);
			}
		}
	}
else if(ind==iSet_)
	{
	if(but==butM_)
		{
		tree_down(0,0);
		}
	else
		{
		if(sub_ind==0)
			{
			if((but==butU)||(but==butU_))
				{
				MODE_EE++;
				gran_char(&MODE_EE,1,3);
				}
			if((but==butD)||(but==butD_))
				{
				MODE_EE--;
				gran_char(&MODE_EE,1,3);
				}				
			}
		else if(sub_ind==1)
			{
			if((but==butU)||(but==butU_))
				{
				NECC_TEMPER_AIR_EE++;
				gran_char(&NECC_TEMPER_AIR_EE,5,35);
				speed=1;
				}
			if((but==butD)||(but==butD_))
				{
				NECC_TEMPER_AIR_EE--;
				gran_char(&NECC_TEMPER_AIR_EE,5,35);
				speed=1;
				}				
			}			
		else if(sub_ind==2)
			{
			if((but==butU)||(but==butU_))
				{
				NECC_TEMPER_WATER_EE++;
				gran_char(&NECC_TEMPER_WATER_EE,5,85);
				speed=1;
				}
			if((but==butD)||(but==butD_))
				{
				NECC_TEMPER_WATER_EE--;
				gran_char(&NECC_TEMPER_WATER_EE,5,85);
				speed=1;
				}				
			}			
		else if(sub_ind==3)
			{
			if((but==butU)||(but==butU_))
				{
				MAX_POWER_EE++;
				gran_char(&MAX_POWER_EE,1,3);
				speed=1;
				}
			if((but==butD)||(but==butD_))
				{
				MAX_POWER_EE--;
				gran_char(&MAX_POWER_EE,1,3);
				speed=1;
				}				
			}	
		else if(sub_ind==4)
			{
			signed char temp;
			temp=time_year;
			
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_char(&temp,0,99);
				_ds1307_write_byte(6,((temp/10)<<4)+(temp%10));
				
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_char(&temp,0,99);
				_ds1307_write_byte(6,((temp/10)<<4)+(temp%10));
				}				
			}	
		else if(sub_ind==5)
			{
			signed char temp;
			temp=time_month;
			
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_ring_char(&temp,1,12);
				_ds1307_write_byte(5,((temp/10)<<4)+(temp%10));
				
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_ring_char(&temp,1,12);
				_ds1307_write_byte(5,((temp/10)<<4)+(temp%10));
				}				
			}	
		else if(sub_ind==6)
			{
			signed char temp;
			temp=time_date;
			
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_ring_char(&temp,1,31);
				_ds1307_write_byte(4,((temp/10)<<4)+(temp%10));
				
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_ring_char(&temp,1,31);
				_ds1307_write_byte(4,((temp/10)<<4)+(temp%10));
				}				
			}				
		else if(sub_ind==7)
			{
			signed char temp;
			temp=time_hour;
			
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_ring_char(&temp,0,23);
				_ds1307_write_byte(2,(((temp/10)<<4)+(temp%10))&0b10111111);
				
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_ring_char(&temp,0,23);
				_ds1307_write_byte(2,(((temp/10)<<4)+(temp%10))&0b10111111);
				}				
			}			
		else if(sub_ind==8)
			{
			signed char temp;
			temp=time_min;
			
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_ring_char(&temp,0,59);
				_ds1307_write_byte(1,((temp/10)<<4)+(temp%10));
				_ds1307_write_byte(0,0);
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_ring_char(&temp,0,59);
				_ds1307_write_byte(1,((temp/10)<<4)+(temp%10));
				_ds1307_write_byte(0,0);
				}				
			}		
		else if(sub_ind==9)
			{
			signed char temp;
			temp=time_day_of_week;
			
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_ring_char(&temp,1,7);
				_ds1307_write_byte(3,temp&0x07);
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_ring_char(&temp,1,7);
				_ds1307_write_byte(3,temp&0x07);
				}				
			}		
		}
	}	
else if(ind==iSetTable)
	{
	if((but==butU)||(but==butU_))
		{
		sub_ind++;
		gran_char(&sub_ind,0,34);
		clear_ind();
		ind_hndl();
		}
	else if((but==butD)||(but==butD_))
		{
		sub_ind--;
		gran_char(&sub_ind,0,34);
		clear_ind();
		ind_hndl();
		}
	else if(but==butM)
		{
		if(sub_ind1==0)sub_ind1=1;
		else sub_ind1=0;
		clear_ind();
		ind_hndl();
		}		
	else if(but==butUD_)
		{
		TABLE_TIME_EE[0][0]=0;
		TABLE_TEMPER_EE[0][0]=23;	
		TABLE_TIME_EE[0][1]=36;
		TABLE_TEMPER_EE[0][1]=23;	
		TABLE_TIME_EE[0][2]=66;
		TABLE_TEMPER_EE[0][2]=23;	
		TABLE_TIME_EE[0][3]=96;
		TABLE_TEMPER_EE[0][3]=23;	
		TABLE_TIME_EE[0][4]=126;
		TABLE_TEMPER_EE[0][4]=23;
		
		TABLE_TIME_EE[1][0]=0;
		TABLE_TEMPER_EE[1][0]=23;	
		TABLE_TIME_EE[1][1]=36;
		TABLE_TEMPER_EE[1][1]=23;	
		TABLE_TIME_EE[1][2]=66;
		TABLE_TEMPER_EE[1][2]=23;	
		TABLE_TIME_EE[1][3]=96;
		TABLE_TEMPER_EE[1][3]=23;	
		TABLE_TIME_EE[1][4]=126;
		TABLE_TEMPER_EE[1][4]=23;	
				
		TABLE_TIME_EE[2][0]=0;
		TABLE_TEMPER_EE[2][0]=23;	
		TABLE_TIME_EE[2][1]=36;
		TABLE_TEMPER_EE[2][1]=23;	
		TABLE_TIME_EE[2][2]=66;
		TABLE_TEMPER_EE[2][2]=23;	
		TABLE_TIME_EE[2][3]=96;
		TABLE_TEMPER_EE[2][3]=23;	
		TABLE_TIME_EE[2][4]=126;
		TABLE_TEMPER_EE[2][4]=23;
		
		TABLE_TIME_EE[3][0]=0;
		TABLE_TEMPER_EE[3][0]=23;	
		TABLE_TIME_EE[3][1]=36;
		TABLE_TEMPER_EE[3][1]=23;	
		TABLE_TIME_EE[3][2]=66;
		TABLE_TEMPER_EE[3][2]=23;	
		TABLE_TIME_EE[3][3]=96;
		TABLE_TEMPER_EE[3][3]=23;	
		TABLE_TIME_EE[3][4]=126;
		TABLE_TEMPER_EE[3][4]=23;
		
		TABLE_TIME_EE[4][0]=0;
		TABLE_TEMPER_EE[4][0]=23;	
		TABLE_TIME_EE[4][1]=36;
		TABLE_TEMPER_EE[4][1]=23;	
		TABLE_TIME_EE[4][2]=66;
		TABLE_TEMPER_EE[4][2]=23;	
		TABLE_TIME_EE[4][3]=96;
		TABLE_TEMPER_EE[4][3]=23;	
		TABLE_TIME_EE[4][4]=126;
		TABLE_TEMPER_EE[4][4]=23;
				
		TABLE_TIME_EE[5][0]=0;
		TABLE_TEMPER_EE[5][0]=23;	
		TABLE_TIME_EE[5][1]=36;
		TABLE_TEMPER_EE[5][1]=23;	
		TABLE_TIME_EE[5][2]=66;
		TABLE_TEMPER_EE[5][2]=23;	
		TABLE_TIME_EE[5][3]=96;
		TABLE_TEMPER_EE[5][3]=23;	
		TABLE_TIME_EE[5][4]=126;
		TABLE_TEMPER_EE[5][4]=23;
				
		TABLE_TIME_EE[6][0]=0;
		TABLE_TEMPER_EE[6][0]=23;	
		TABLE_TIME_EE[6][1]=36;
		TABLE_TEMPER_EE[6][1]=23;	
		TABLE_TIME_EE[6][2]=66;
		TABLE_TEMPER_EE[6][2]=23;	
		TABLE_TIME_EE[6][3]=96;
		TABLE_TEMPER_EE[6][3]=23;	
		TABLE_TIME_EE[6][4]=126;
		TABLE_TEMPER_EE[6][4]=23;
		
		}
	else if(but==butM_)
		{
		tree_up(iSetTable_,sub_ind,0,sub_ind1);
		}
	else if(but==butMD_)
		{
		tree_down(0,0);
		}		
	}
else if(ind==iSetTable_)
	{
	if(but==butM_)
		{
		tree_down(0,0);
		}
	else if(but==butM)
		{
		if(sub_ind1==1)sub_ind1=0;
		else sub_ind1=1;
		clear_ind();
		ind_hndl();
		}	
	else if(sub_ind1==0)
		{
		char num_of_day;
		char num_of_set;
		char i;
		num_of_day=sub_ind/5;
		num_of_set=sub_ind%5;
		
		if((but==butU)||(but==butU_))
			{
			tempUC=TABLE_TIME_EE[num_of_day][num_of_set];
			tempUC++;
			if(tempUC>TABLE_TIME_EE_MAX[num_of_set])tempUC=TABLE_TIME_EE_MAX[num_of_set];
			if(tempUC<TABLE_TIME_EE_MIN[num_of_set])tempUC=TABLE_TIME_EE_MIN[num_of_set];
			if(TABLE_TIME_EE[num_of_day][num_of_set]!=tempUC)TABLE_TIME_EE[num_of_day][num_of_set]=tempUC;
			speed=1;
			}
		if((but==butD)||(but==butD_))
			{
			tempUC=TABLE_TIME_EE[num_of_day][num_of_set];
			if(tempUC)tempUC--;
			if(tempUC>TABLE_TIME_EE_MAX[num_of_set])tempUC=TABLE_TIME_EE_MAX[num_of_set];
			if(tempUC<TABLE_TIME_EE_MIN[num_of_set])tempUC=TABLE_TIME_EE_MIN[num_of_set];
			if(TABLE_TIME_EE[num_of_day][num_of_set]!=tempUC)TABLE_TIME_EE[num_of_day][num_of_set]=tempUC;
			speed=1;
			}				
		}
	else if(sub_ind1==1)
		{
		char num_of_day;
		char num_of_set;
		char i;
		num_of_day=sub_ind/5;
		num_of_set=sub_ind%5;
		
		if((but==butU)||(but==butU_))
			{
			tempUC=TABLE_TEMPER_EE[num_of_day][num_of_set];
			if(tempUC)tempUC++;
			if(tempUC>35)tempUC=35;
			if(tempUC<5)tempUC=5;
			if(TABLE_TEMPER_EE[num_of_day][num_of_set]!=tempUC)TABLE_TEMPER_EE[num_of_day][num_of_set]=tempUC;
			speed=1;
			}
		if((but==butD)||(but==butD_))
			{
			tempUC=TABLE_TEMPER_EE[num_of_day][num_of_set];
			if(tempUC)tempUC--;
			if(tempUC>35)tempUC=35;
			if(tempUC<5)tempUC=5;
			if(TABLE_TEMPER_EE[num_of_day][num_of_set]!=tempUC)TABLE_TEMPER_EE[num_of_day][num_of_set]=tempUC;
			speed=1;
			}					
		}
	}
else if(ind==iDeb)
	{
	if(but==butU)
		{
		sub_ind++;
		gran_char(&sub_ind,0,11);
		clear_ind();
		ind_hndl();
		}
	else if(but==butD)
		{
		sub_ind--;
		gran_char(&sub_ind,0,11);
		clear_ind();
		ind_hndl();
		}
	else if(but==butD_)
		{
		tree_down(0,0);
		}
	}
}
//-----------------------------------------------
void t4_init(void)
{
TIM4->PSCR = 6;
TIM4->ARR= 158;
TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt

TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{
//должно быть 300 раз в секунду
GPIOD->ODR|=0b00111100;
ind_cnt++;
if(ind_cnt>=10)
	{
	ind_cnt=0;
	but_new=GPIOB->IDR;
	}
GPIOB->ODR=ind_outB[ind_cnt];
GPIOC->ODR=ind_outC[ind_cnt];
GPIOG->ODR|=0x01;
GPIOG->ODR&=ind_outG[ind_cnt];
if(ind_cnt==9)GPIOB->DDR=0x00;
else GPIOB->DDR=0xff;
GPIOD->ODR&=ind_strob[ind_cnt];

if(++t0_cnt0>=10)
	{
  t0_cnt0=0;
  b100Hz=1;

	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;
		bFL5=!bFL5;
		}
		
	if(++t0_cnt3>=50)
		{
		t0_cnt3=0;
		b2Hz=1;
		bFL2=!bFL2;
		}		
	if(++t0_cnt4>=100)
		{
		t0_cnt4=0;
		b1Hz=1;
		bFL1=!bFL1;
		}
	}
TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
return;
}

//===============================================
//===============================================
//===============================================
//===============================================
main()
{
CLK->ECKR|=1;
while((CLK->ECKR & 2) == 0);
CLK->SWCR|=2;
CLK->SWR=0xB4;	

CLK->CKDIVR=0;

FLASH_DUKR=0xae;
FLASH_DUKR=0x56;

//Инициализация индикации
GPIOD->DDR|=0b00111100;		//PD2-PD5 выходы открытый коллектор
GPIOD->CR1&=0b11000011;		//....
GPIOD->CR2&=0b11000011;		//....
GPIOB->DDR|=0b11111111;		//PORTB все выходы ТТЛ
GPIOB->CR1|=0b11111111;		//....
GPIOB->CR2&=0b00000000;		//....
GPIOC->DDR|=0b11111111;		//PORTC все выходы открытый коллектор
GPIOC->CR1&=0b00000000;		//....
GPIOC->CR2&=0b00000000;		//....
GPIOG->DDR|=0b00000001;		//PG0 выход открытый коллектор
GPIOG->CR1&=0b11111110;		//....
GPIOG->CR2&=0b11111110;		//....
t4_init();
uart3_init();

enableInterrupts();

clear_ind();
ind=iMn;

out_mode=osOFF;

while (1)
	{
	if(b100Hz)
		{
		b100Hz=0;
		
		but_drv();
		but_an();
		GPIOD->DDR|=0b00000001;		
		GPIOD->CR1|=0b00000001;		
		GPIOD->CR2&=0b11111110;
		GPIOD->ODR^=0b00000001;
		}
	if(b10Hz)
		{
		b10Hz=0;
		//ind_outB[2]=DIGISYM[3];
		//int2indI_slkuf(time_sec,1, 3, 0, 1, 0);
		ind_hndl();
		//int2indI_slkuf(but,1, 3, 0, 1, 0);
		//int2indII_slkuf(time_min,2, 2, 0, 0, 0);
		//int2indII_slkuf(time_sec,0, 2, 0, 0, 0);
		
		uart3_in_an();
		out_drv();
		}
	if(b5Hz)
		{
		b5Hz=0;

		}
	if(b2Hz)
		{
		b2Hz=0;
		
		time_drv();
		}
	if(b1Hz)
		{
		b1Hz=0;
		
		if(mainCnt<10)
			{
			mainCnt++;
			if(mainCnt==3)out_mode=osON;
			}
		matemath();
		ds18b20_temper_drv();
		ret_ind_hndl();
		random_gen();
		power_necc_hndl();
		power_hndl();
		}		
	};
}