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

//-----------------------------------------------
//Временная сетка
bool b100Hz=0,b10Hz=0,b5Hz=0,b2Hz=0,b1Hz=0;
char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;

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

//-----------------------------------------------
//Управление выходом
char out_stat[3];

//-----------------------------------------------
//Температура
signed short temperWater;

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

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//отладка

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
void time_drv(void)
{
_ds1307_read_time(buff_for_time);

time_sec=(((buff_for_time[0]&0x70)>>4)*10)+(buff_for_time[0]&0x0f);
time_min=(((buff_for_time[1]&0x70)>>4)*10)+(buff_for_time[1]&0x0f);
time_hour=(((buff_for_time[2]&0x30)>>4)*10)+(buff_for_time[2]&0x0f);
time_month=(((buff_for_time[5]&0x10)>>4)*10)+(buff_for_time[5]&0x0f);
time_year=(((buff_for_time[6]&0xf0)>>4)*10)+(buff_for_time[6]&0x0f);
}

//-----------------------------------------------
void matemath(void)
{
char temperWaterTemp; 
if((wire1_in[1]&0xf0)==0)
	{
	temperWaterTemp=((wire1_in[0]&0xf0)>>4)+((wire1_in[1]&0x0f)<<4);
	temperWater=(signed short)temperWaterTemp;
	}
}

//-----------------------------------------------
void ind_hndl(void)
{
if(ind==iMn)
	{
	int2indII_slkuf(time_min,2, 2, 0, 0, 0);
	if(bFL2)	int2indII_slkuf(time_sec,0, 2, 0, 0, 0);
	else 		int2indII_slkuf(time_sec,0, 2, 1, 0, 0);
	
		
	
	int2indI_slkuf(time_month,1, 2, 0, 1, 0);
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
		int2indII_slkuf(NECC_TEMPER_WATER_EE,0, 2, 0, 1, 1);
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
	}	
}



//-----------------------------------------------
void but_an(void)
{
if(!n_but) return;
n_but=0;
if(ind==iMn)
	{
	if(but==butM_)
		{
		tree_up(iSet,0,0,0);
		}
	}
else if(ind==iSet)
	{
	if((but==butU)||(but==butU_))
		{
		sub_ind--;
		gran_char(&sub_ind,0,10);
		clear_ind();
		ind_hndl();
		}
	else if((but==butD)||(but==butD_))
		{
		sub_ind++;
		gran_char(&sub_ind,0,10);
		clear_ind();
		ind_hndl();
		}
	else if(but==butM_)
		{
		if(sub_ind==10) //Выход 
			{
			tree_down(0,0);
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
		}
	}	
//if(but==254)
	//{
	//_ds1307_write_byte(0,0);
	//_ds1307_write_byte(2,0);	
	//}
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
		
		matemath();
		ds18b20_temper_drv();
		//wire1_polling();
		}		
	};
}