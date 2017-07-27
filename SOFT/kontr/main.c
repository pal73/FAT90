//ветка модем

#include "stm8s.h"
#include "main.h"
#include "lowlev.h"
#include "ds18b20.h"
#include "uart3.h"
#include "uart1.h"
#include "ds1307.h"
#include "modem.h"
#include <iostm8s.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//-----------------------------------------------
//Переменные в EEPROM

@eeprom char					MAIN_NUMBER[10]						@0x4002;	//Ячейка для хранения номера мастера
@eeprom char					AUTH_NUMBER_1[10]					@0x400C;	//Ячейка для хранения номера первого авторизованого телефона
@eeprom signed short	HUMAN_SET_EE 							@0x401E;	//подпись человека (0x1234)
@eeprom unsigned char TABLE_TIME_EE[7][5]				@0x4020;	//таблица временных меток для семи дней недели, временная метка 
//выражается в десятках минут

@eeprom signed char	  NECC_TEMPER_AIR_EE 				@0x4044;	//температура поддержания воздуха
@eeprom signed char		NECC_TEMPER_WATER_EE 			@0x4045;	//температура поддержания воды
@eeprom signed char 	MODE_EE										@0x4046;	//режим работы устройства (1 - по воде, 2 - по воздуху, 3 - по графику) 
@eeprom signed char 	MAX_POWER_EE							@0x4047;	//максимальная мощность 							нагревания																	
@eeprom signed char 	TABLE_TEMPER_EE[7][5]			@0x4048;	//таблица температурных меток для семи дней недели, температурная метка  выражается в градусах со знаком
@eeprom char					AUTH_NUMBER_2[10]					@0x406B;	//Ячейка для хранения номера второго авторизованого телефона
@eeprom char					AUTH_NUMBER_3[10]					@0x4075;	//Ячейка для хранения номера третьего авторизованого телефона
@eeprom char					AUTH_NUMBER_FLAGS					@0x407F;	//Ячейка флагов обозначающих наличие установленных телефонных номеров
																													//0b00000001 - установлен главный телефон
																													//0b00000010 - установлен первый неглавный телефон
																													//0b00000100 - установлен второй неглавный телефон
																													//0b00001000 - установлен третий неглавный телефон

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
signed char temperRegToSheduler;
enumTemperOfAirErrorStat airSensorErrorStat=taesNORM;



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
//Работа по расписанию
unsigned char day_sheduler_time;


//-----------------------------------------------
//Константы для определения границ установки времени в таблице
const unsigned char TABLE_TIME_EE_MIN[5]={0,36,72,108,126};
const unsigned char TABLE_TIME_EE_MAX[5]={35,71,107,125,143};

//-----------------------------------------------
//Регулирование мощности
signed char powerNecc=0,powerNeccOld=0;
signed char powerNeccDelta;

//-----------------------------------------------
//Зуммер
signed char beep_drv_cnt;

//-----------------------------------------------
//Ошибки
bool bERR;	//серьезная ошибка
bool bWARN; //предупреждение

//-----------------------------------------------
//Исправность линии воздушного датчика
char cntAirSensorLineErrorLo;
char cntAirSensorLineErrorHi;

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//отладка
//char random_plazma;
unsigned char tempUC;
//@near signed char 	TABLE_TEMPER_EE[7][5];
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



//-----------------------------------------------
void error_warn_hndl(void)
{
if(mainCnt<3)return;	
if(MODE_EE==1)
	{
	if(waterSensorErrorStat!=dsesNORM)bWARN=1;
	else bWARN=0;
	}
else if((MODE_EE==2)||(MODE_EE==3))
	{
	if((airSensorErrorStat!=taesNORM)||(waterSensorErrorStat!=dsesNORM))bWARN=1;
	else bWARN=0;
	}
	
if((waterSensorErrorStat==dsesNORM)&&((temperOfWater<=3)||(temperOfWater>=90)))bERR=1;	
else bERR=0;
}

//-----------------------------------------------
void airSensorLineErrorDrv(void)
{
if(GPIOD->IDR&(1<<6)) 
	{
	if(cntAirSensorLineErrorLo<10)
		{
		cntAirSensorLineErrorLo++;
		if(cntAirSensorLineErrorLo>=10)
			{
			airSensorErrorStat=taesLLO;	
			}
		}
	}
else 
	{
	if(cntAirSensorLineErrorHi<10)
		{
		cntAirSensorLineErrorHi++;
		if(cntAirSensorLineErrorHi>=10)
			{
			airSensorErrorStat=taesLHI;	
			}
		}
	}	
}

//-----------------------------------------------
void beep_drv(void)
{
GPIOG->DDR|=0b00000010;
GPIOG->CR1&=0b11111101;
GPIOG->CR2&=0b11111101;



if(bERR)
	{
	if(++beep_drv_cnt>=15)beep_drv_cnt=0;
	if(beep_drv_cnt<5)
		{
		GPIOG->ODR&=0b11111101;
		}
	else GPIOG->ODR|=0b00000010;
	}
else if(bWARN)
	{
	if(++beep_drv_cnt>=100)beep_drv_cnt=0;
	if((beep_drv_cnt<5)||((beep_drv_cnt>=15)&&(beep_drv_cnt<20))||((beep_drv_cnt>=30)&&(beep_drv_cnt<35)))
		{
		GPIOG->ODR&=0b11111101;
		}
	else GPIOG->ODR|=0b00000010;
	}
else GPIOG->ODR|=0b00000010;
}

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
void sheduler_hndl(void)
{
char i;

day_sheduler_time=(unsigned char)(((((unsigned)time_hour)*60)+((unsigned)time_min))/10);

if((day_sheduler_time>=0)&&(day_sheduler_time<TABLE_TIME_EE[time_day_of_week-1][0]))
	{
	if(time_day_of_week==1)	temperRegToSheduler=TABLE_TEMPER_EE[6][4];
	else 					temperRegToSheduler=TABLE_TEMPER_EE[time_day_of_week-2][4];
	}
else if((day_sheduler_time>=TABLE_TIME_EE[time_day_of_week-1][0])&&(day_sheduler_time<TABLE_TIME_EE[time_day_of_week-1][1]))
	{
	temperRegToSheduler=TABLE_TEMPER_EE[time_day_of_week-1][0];
	}
else if((day_sheduler_time>=TABLE_TIME_EE[time_day_of_week-1][1])&&(day_sheduler_time<TABLE_TIME_EE[time_day_of_week-1][2]))
	{
	temperRegToSheduler=TABLE_TEMPER_EE[time_day_of_week-1][1];
	}
else if((day_sheduler_time>=TABLE_TIME_EE[time_day_of_week-1][2])&&(day_sheduler_time<TABLE_TIME_EE[time_day_of_week-1][3]))
	{
	temperRegToSheduler=TABLE_TEMPER_EE[time_day_of_week-1][2];
	}
else if((day_sheduler_time>=TABLE_TIME_EE[time_day_of_week-1][3])&&(day_sheduler_time<TABLE_TIME_EE[time_day_of_week-1][4]))
	{
	temperRegToSheduler=TABLE_TEMPER_EE[time_day_of_week-1][3];
	}
else if((day_sheduler_time>=TABLE_TIME_EE[time_day_of_week-1][4])&&(day_sheduler_time<144))
	{
	temperRegToSheduler=TABLE_TEMPER_EE[time_day_of_week-1][4];
	}	
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

if((temperToReg>=temperRegTo)||(temperOfWater>=90))
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
	//temperOfWater=92;
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
	temperRegTo=temperRegToSheduler;
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
	if(out_mode==osON)
		{
		if(MODE_EE==1)led_on(1);
		else if(MODE_EE==2) led_on(2);
		else if(MODE_EE==3)
			{
			led_on(2);
			led_on(3);
			}
		}
	if((out_mode==osON)&&(out_stat[0]==osON))led_on(4);
	if((out_mode==osON)&&(out_stat[1]==osON))led_on(5);
	if((out_mode==osON)&&(out_stat[2]==osON))led_on(6);
	
	if(bERR)led_on(7);
	else if(bWARN)led_flash(7);
	//led_set(2,0);
	//led_set(3,2);
	}
else if(ind==iDate_W)
	{
	if(sub_ind==0)
		{
		//int2indI_slkuf(12,1, 2, 0, 1, 0);
		int2indI_slkuf(time_date,1, 2, 0, 1, 0);
		int2indII_slkuf(time_month,0, 2, 0, 1, 0);
		//ind_outG[2]&=0b11111110;		
		}
	else if(sub_ind==1)
		{
		//int2indI_slkuf(13,1, 2, 0, 1, 0);
		int2indI_slkuf(time_year,1, 2, 0, 1, 0);
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
		int2indII_slkuf(NECC_TEMPER_WATER_EE,0, 2, 0, 1, 0);
		}	
	else if(sub_ind==2)
		{
		int2indII_slkuf(NECC_TEMPER_AIR_EE,0, 2, 0, 1, 0);
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
		//int2indII_slkuf(time_day_of_week,2, 2, 0, 1, 0);
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
		//int2indII_slkuf(time_day_of_week,2, 2, 0, 1, 0);
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
	else if(sub_ind==3)
		{
		int2indI_slkuf(temperRegToSheduler,1, 2, 0, 0, 0);	
		//int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(time_day_of_week,3, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[1],2, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		int2indII_slkuf(day_sheduler_time,0, 3, 0, 0, 0);
		}			
	}

else if(ind==iModem_deb)
	{
	led_mask_off(0x00);
	led_on(1);
	led_on(2);
	
	if(sub_ind==0)
		{
		int2indI_slkuf(modemState,3, 1, 0, 0, 0);
		int2indI_slkuf(modem_plazma,1, 1, 0, 0, 0);
		int2indI_slkuf(modem_plazma1,2, 1, 0, 0, 0);
		//int2indI_slkuf(modemLinkState,1, 1, 0, 0, 0);
		int2indII_slkuf(modemDrvPDUSMSSendStepCnt,2, 2, 0, 0, 0);
		int2indII_slkuf(modemDrvInitStepCnt,0, 2, 0, 0, 0);
		if(AUTH_NUMBER_FLAGS&0x01)led_on(8);
		if(AUTH_NUMBER_FLAGS&0x02)led_on(7);
		if(AUTH_NUMBER_FLAGS&0x04)led_on(6);
		if(AUTH_NUMBER_FLAGS&0x08)led_on(5);
		
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
	else if(sub_ind==3)
		{
		int2indI_slkuf(temperRegToSheduler,1, 2, 0, 0, 0);	
		//int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(time_day_of_week,3, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[1],2, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		int2indII_slkuf(day_sheduler_time,0, 3, 0, 0, 0);
		}			
	}
	
else if(ind==iTemperSet)
	{
/*	led_mask_off(0x00);
	if(out_mode==osON)led_on(MODE_EE);
	if((out_mode==osON)&&(out_stat[0]==osON))led_on(4);
	if((out_mode==osON)&&(out_stat[1]==osON))led_on(5);
	if((out_mode==osON)&&(out_stat[2]==osON))led_on(6);
*/

	led_mask_off(0x00);
	if(out_mode==osON)
		{
		if(MODE_EE==1)led_on(1);
		else if(MODE_EE==2) led_on(2);
		else if(MODE_EE==3)
			{
			led_on(2);
			led_on(3);
			}
		}
	if((out_mode==osON)&&(out_stat[0]==osON))led_on(4);
	if((out_mode==osON)&&(out_stat[1]==osON))led_on(5);
	if((out_mode==osON)&&(out_stat[2]==osON))led_on(6);
	
	if(bERR)led_on(7);
	else if(bWARN)led_flash(7);

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

	int2indII_slkuf(temperRegTo,1, 2, 0, 1, MODE_EE==3?0:1);
	if((bFL2)&&(MODE_EE!=3))	ind_outC[0]=0b11111111;
	else 						ind_outC[0]=0b00111000;

	}	

else if(ind==iDefSet)
	{
	led_mask_off(0x00);

	int2indI_slkuf(123,1, 3, 0, 0, 0);
	int2indII_slkuf(4567,0, 4, 0, 0, 0);
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
	else if(but==butOND_)
		{
		tree_up(iDefSet,0,0,0);
		ret_ind(5,0);
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
		else if(sub_ind==2)
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
	if((but==butU)/*||(but==butU_)*/)
		{
		sub_ind++;
		gran_char(&sub_ind,0,34);
		clear_ind();
		ind_hndl();
		}
	else if((but==butD)/*||(but==butD_)*/)
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
	else if((but==butD_)/*||(but==butD_)*/)
		{
		tree_down(0,0);
		clear_ind();
		ind_hndl();
		}
	else if(but==butUD_)
		{
		TABLE_TIME_EE[0][0]=3;
		TABLE_TEMPER_EE[0][0]=20;	
		TABLE_TIME_EE[0][1]=39;
		TABLE_TEMPER_EE[0][1]=21;	
		TABLE_TIME_EE[0][2]=75;
		TABLE_TEMPER_EE[0][2]=22;	
		TABLE_TIME_EE[0][3]=111;
		TABLE_TEMPER_EE[0][3]=23;	
		TABLE_TIME_EE[0][4]=129;
		TABLE_TEMPER_EE[0][4]=24;
		
		TABLE_TIME_EE[1][0]=9;
		TABLE_TEMPER_EE[1][0]=25;	
		TABLE_TIME_EE[1][1]=45;
		TABLE_TEMPER_EE[1][1]=26;	
		TABLE_TIME_EE[1][2]=81;
		TABLE_TEMPER_EE[1][2]=27;	
		TABLE_TIME_EE[1][3]=117;
		TABLE_TEMPER_EE[1][3]=28;	
		TABLE_TIME_EE[1][4]=135;
		TABLE_TEMPER_EE[1][4]=29;	
				
		TABLE_TIME_EE[2][0]=15;
		TABLE_TEMPER_EE[2][0]=30;	
		TABLE_TIME_EE[2][1]=51;
		TABLE_TEMPER_EE[2][1]=31;	
		TABLE_TIME_EE[2][2]=87;
		TABLE_TEMPER_EE[2][2]=32;	
		TABLE_TIME_EE[2][3]=123;
		TABLE_TEMPER_EE[2][3]=33;	
		TABLE_TIME_EE[2][4]=141;
		TABLE_TEMPER_EE[2][4]=34;
		
		TABLE_TIME_EE[3][0]=21;
		TABLE_TEMPER_EE[3][0]=35;	
		TABLE_TIME_EE[3][1]=57;
		TABLE_TEMPER_EE[3][1]=5;	
		TABLE_TIME_EE[3][2]=93;
		TABLE_TEMPER_EE[3][2]=6;	
		TABLE_TIME_EE[3][3]=112;
		TABLE_TEMPER_EE[3][3]=7;	
		TABLE_TIME_EE[3][4]=130;
		TABLE_TEMPER_EE[3][4]=8;
		
		TABLE_TIME_EE[4][0]=27;
		TABLE_TEMPER_EE[4][0]=9;	
		TABLE_TIME_EE[4][1]=63;
		TABLE_TEMPER_EE[4][1]=10;	
		TABLE_TIME_EE[4][2]=99;
		TABLE_TEMPER_EE[4][2]=11;	
		TABLE_TIME_EE[4][3]=118;
		TABLE_TEMPER_EE[4][3]=12;	
		TABLE_TIME_EE[4][4]=136;
		TABLE_TEMPER_EE[4][4]=13;
				
		TABLE_TIME_EE[5][0]=33;
		TABLE_TEMPER_EE[5][0]=14;	
		TABLE_TIME_EE[5][1]=69;
		TABLE_TEMPER_EE[5][1]=15;	
		TABLE_TIME_EE[5][2]=105;
		TABLE_TEMPER_EE[5][2]=16;	
		TABLE_TIME_EE[5][3]=124;
		TABLE_TEMPER_EE[5][3]=17;	
		TABLE_TIME_EE[5][4]=142;
		TABLE_TEMPER_EE[5][4]=18;
				
		TABLE_TIME_EE[6][0]=4;
		TABLE_TEMPER_EE[6][0]=19;	
		TABLE_TIME_EE[6][1]=40;
		TABLE_TEMPER_EE[6][1]=20;	
		TABLE_TIME_EE[6][2]=76;
		TABLE_TEMPER_EE[6][2]=21;	
		TABLE_TIME_EE[6][3]=113;
		TABLE_TEMPER_EE[6][3]=22;	
		TABLE_TIME_EE[6][4]=131;
		TABLE_TEMPER_EE[6][4]=23;
		
		}
	else if(but==butM_)
		{
		tree_up(iSetTable_,sub_ind,0,sub_ind1);
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
	
else if(ind==iModem_deb)
	{
	if(but==butU)
		{
		//modemDrvSMSSendStepCnt=1;
		
//		modem_send_sms('p', "9139294352", "Мама1 \r\nМама2");
		
		sprintf(textToSendPDUSMS,"Мама1 %d \r\nМама2 %d",123,456);
		//sprintf(textToSendPDUSMS,"Мама мыла раму, у шуры шары. It is OK?");
		//sprintf(textToSendPDUSMS,);
		modem_send_sms('p', "9139294352", textToSendPDUSMS);
		}
	else if(but==butD)
		{
		char puts_bufer[100];
		
		//modem_send_sms('p',"9139294352","ОТПРАВЬТЕ В ОТВЕТНОМ СМС 7 ЦИФР ВЫВЕДЕННЫХ НА ИНДИКАТОР УСТРОЙСТВА "); //
		//modem_send_sms('p',"9139294352","ВАШ ТЕЛЕФОН УСТАНОВЛЕН КАК ГЛАВНЫЙ ДЛЯ ДАННОГО КОНТРОЛЛЕРА ");
		//printf("ATD*100#;\r");
		}
/*		
		+CUSD: 0,"0421043F0430044104380431043E0020043704300020043E04310440043004490435043D0438043500210020041C044B0020043D0430043F0440043004320438043C0020043E04420432043504420020043D04300020041204300448002004370430043F0440043E04410020043200200053004D0053",72

+CMT: "Balance
","","17/07/26,17:28:08+28"
04110430043B0430043D0441003A00360035002C003600310440002C041B0438043C04380442003A003300300030044000200421043B0443044804300439044204350020043800200441043A0430044704380432043004390442043500200431043504370020043E043304400430043D043804470435043D043804390020002D0020043B0443

+CMT: "Balance
","","17/07/26,17:28:08+28"
044704480430044F0020043C04430437044B043A0430043B044C043D0430044F0020043F043E04340431043E0440043A04300020043F043504410435043D0020043E04420020041C0422042100200437043000200036002C003700370020044004430431002E002F044104430442002E00210020041D0430043104350440043804420435003A

+CMT: "Balance
","","17/07/26,17:28:08+28"
0020002A003500350035002A0031003300320023*/
	
	else if(but==butD_)
		{
		AUTH_NUMBER_FLAGS=0;
		memcpy(MAIN_NUMBER,"xxxxxxxxxx",10);
		memcpy(AUTH_NUMBER_1,"xxxxxxxxxx",10);
		memcpy(AUTH_NUMBER_2,"xxxxxxxxxx",10);
		memcpy(AUTH_NUMBER_3,"xxxxxxxxxx",10);
		}
	else if(but==butU_)
		{
		AUTH_NUMBER_FLAGS=0x07;
		memcpy(MAIN_NUMBER,"9139294352",10);
		memcpy(AUTH_NUMBER_1,"9134863890",10);
		memcpy(AUTH_NUMBER_2,"9237328354",10);
		memcpy(AUTH_NUMBER_3,"xxxxxxxxxx",10);
		}		
	}
	
else if(ind==iDefSet)
	{
	if(but==butMU_)
		{
		TABLE_TIME_EE[0][0]=0;
		TABLE_TEMPER_EE[0][0]=20;	
		TABLE_TIME_EE[0][1]=36;
		TABLE_TEMPER_EE[0][1]=20;	
		TABLE_TIME_EE[0][2]=72;
		TABLE_TEMPER_EE[0][2]=20;	
		TABLE_TIME_EE[0][3]=108;
		TABLE_TEMPER_EE[0][3]=20;	
		TABLE_TIME_EE[0][4]=126;
		TABLE_TEMPER_EE[0][4]=20;
		
		TABLE_TIME_EE[1][0]=0;
		TABLE_TEMPER_EE[1][0]=20;	
		TABLE_TIME_EE[1][1]=36;
		TABLE_TEMPER_EE[1][1]=20;	
		TABLE_TIME_EE[1][2]=72;
		TABLE_TEMPER_EE[1][2]=20;	
		TABLE_TIME_EE[1][3]=108;
		TABLE_TEMPER_EE[1][3]=20;	
		TABLE_TIME_EE[1][4]=126;
		TABLE_TEMPER_EE[1][4]=20;	
				
		TABLE_TIME_EE[2][0]=0;
		TABLE_TEMPER_EE[2][0]=20;	
		TABLE_TIME_EE[2][1]=36;
		TABLE_TEMPER_EE[2][1]=20;	
		TABLE_TIME_EE[2][2]=72;
		TABLE_TEMPER_EE[2][2]=20;	
		TABLE_TIME_EE[2][3]=108;
		TABLE_TEMPER_EE[2][3]=20;	
		TABLE_TIME_EE[2][4]=126;
		TABLE_TEMPER_EE[2][4]=20;
		
		TABLE_TIME_EE[3][0]=0;
		TABLE_TEMPER_EE[3][0]=20;	
		TABLE_TIME_EE[3][1]=36;
		TABLE_TEMPER_EE[3][1]=20;	
		TABLE_TIME_EE[3][2]=72;
		TABLE_TEMPER_EE[3][2]=20;	
		TABLE_TIME_EE[3][3]=108;
		TABLE_TEMPER_EE[3][3]=20;	
		TABLE_TIME_EE[3][4]=126;
		TABLE_TEMPER_EE[3][4]=20;
		
		TABLE_TIME_EE[4][0]=0;
		TABLE_TEMPER_EE[4][0]=20;	
		TABLE_TIME_EE[4][1]=36;
		TABLE_TEMPER_EE[4][1]=20;	
		TABLE_TIME_EE[4][2]=72;
		TABLE_TEMPER_EE[4][2]=20;	
		TABLE_TIME_EE[4][3]=108;
		TABLE_TEMPER_EE[4][3]=20;	
		TABLE_TIME_EE[4][4]=126;
		TABLE_TEMPER_EE[4][4]=20;
				
		TABLE_TIME_EE[5][0]=0;
		TABLE_TEMPER_EE[5][0]=20;	
		TABLE_TIME_EE[5][1]=36;
		TABLE_TEMPER_EE[5][1]=20;	
		TABLE_TIME_EE[5][2]=72;
		TABLE_TEMPER_EE[5][2]=20;	
		TABLE_TIME_EE[5][3]=108;
		TABLE_TEMPER_EE[5][3]=20;	
		TABLE_TIME_EE[5][4]=126;
		TABLE_TEMPER_EE[5][4]=20;
				
		TABLE_TIME_EE[6][0]=0;
		TABLE_TEMPER_EE[6][0]=20;	
		TABLE_TIME_EE[6][1]=36;
		TABLE_TEMPER_EE[6][1]=20;	
		TABLE_TIME_EE[6][2]=72;
		TABLE_TEMPER_EE[6][2]=20;	
		TABLE_TIME_EE[6][3]=108;
		TABLE_TEMPER_EE[6][3]=20;	
		TABLE_TIME_EE[6][4]=126;
		TABLE_TEMPER_EE[6][4]=20;
		
		MODE_EE=1;
		NECC_TEMPER_WATER_EE=50;
		NECC_TEMPER_AIR_EE=20;
		MAX_POWER_EE=3;
		
		tree_down(0,0);
		ret_ind(0,0);
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
uart1_init();
modem_gpio_init();

enableInterrupts();

clear_ind();
ind=iModem_deb;//iMn;

out_mode=osOFF;

bERR=0;
bWARN=0;

memcpy(AUTH_NUMBER_3,"9139294352",10);
memcpy(AUTH_NUMBER_2,"9139294355",10);
memcpy(AUTH_NUMBER_1,"9139294354",10);
memcpy(MAIN_NUMBER,"9139294353",10);

//PDU2text("043E0442043F044004300432044C0442043500200441043C04410031003200330034");

while (1)
	{
	if(b100Hz)
		{
		b100Hz=0;
		
		but_drv();
		but_an();
		beep_drv();
		modem_stat_drv();
		uart1_in_an();
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
		matemath();
		
		modem_drv();
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
		
		ds18b20_temper_drv();
		ret_ind_hndl();
		random_gen();
		power_necc_hndl();
		power_hndl();
		sheduler_hndl();
		error_warn_hndl();
		airSensorLineErrorDrv();
		
		//printf("%s \r", MAIN_NUMBER);
		//printf("OK%dCRC%d\n",13,14);
		
		//GPIOA->ODR^=0b00100000;
		//UART1->DR=0x55;
		}		
	};
}