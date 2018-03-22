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
#include "watchdog.h"
#include "next_version.h"

//-----------------------------------------------
//Переменные в EEPROM

@eeprom char			MAIN_NUMBER[10]				@0x4002;	//Ячейка для хранения номера мастера
@eeprom char			AUTH_NUMBER_1[10]			@0x400C;	//Ячейка для хранения номера первого авторизованого телефона
@eeprom char 			powerAlarm					@0x401C;	//Статус аварийности сети
@eeprom enumOutMode		outMode					@0x401D;	//Термостат включен-выключен
@eeprom signed short	HUMAN_SET_EE 				@0x401E;	//подпись человека (0x1234)
@eeprom unsigned char 	TABLE_TIME_EE[7][5]			@0x4020;	//таблица временных меток для семи дней недели, временная метка 
//выражается в десятках минут

@eeprom signed char	  	NECC_TEMPER_AIR_EE 			@0x4044;	//температура поддержания воздуха
@eeprom signed char		NECC_TEMPER_WATER_EE 		@0x4045;	//температура поддержания воды
@eeprom signed char 	MODE_EE						@0x4046;	//режим работы устройства (1 - по воде, 2 - по воздуху, 3 - по графику) 
@eeprom signed char 	MAX_POWER_EE				@0x4047;	//максимальная мощность 							нагревания																	
@eeprom signed char 	TABLE_TEMPER_EE[7][5]		@0x4048;	//таблица температурных меток для семи дней недели, температурная метка  выражается в градусах со знаком
@eeprom char			AUTH_NUMBER_2[10]			@0x406B;	//Ячейка для хранения номера второго авторизованого телефона
@eeprom char			AUTH_NUMBER_3[10]			@0x4075;	//Ячейка для хранения номера третьего авторизованого телефона
@eeprom char			AUTH_NUMBER_FLAGS			@0x407F;	//Ячейка флагов обозначающих наличие установленных телефонных номеров
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
signed short mainCnt;
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
enum_out_stat out_stat[3];
@near char optr_stat;
@near char optr_kontr_cnt;

//-----------------------------------------------
//Температура
signed char temperOfWater;
signed char	temperOfAir;
signed char aktualTemper;
signed char targetTemper;
signed char temperRegToSheduler;
enumTemperOfAirErrorStat airSensorErrorStat=taesNORM, airSensorErrorStatOld=taesNORM;



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
signed char powerEnabled;

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

//-----------------------------------------------
//Аварийный перегрев или охлаждение системы
enumWaterTemperAlarm waterTemperAlarm=wtaNORM, waterTemperAlarmOld=wtaNORM;
@near signed char waterTemperAlarmCnt;

//-----------------------------------------------
//Случайные числа для запоминания главного номера
@near char rand_dig[7];
@near char rand_dig_str[8]="0000000";

//-----------------------------------------------
//Статус питающей сети
@near short power_in_drv_off_cnt=5;
@near short power_in_drv_alarm_cnt=30;
enumPowerStat powerStat=psOFF;

//-----------------------------------------------
//Выключение по разряду аккумулятора
@near short main_power_off_hndl_cnt;
@near char cbcSystemRequ;
@near char cbc_temp[15];							//Буфер для хранения информации о напряжении питания модема
@near char cbc_temp1[15];							//Буфер для хранения информации о напряжении питания модема
@near short cbcVoltage;								//Напряжение батареи в милливольтах
@near char bCBC_SELF;												//модем ответил CBC

//-----------------------------------------------
//Проверка звука
@near char beepTestCnt;

//-----------------------------------------------
//Проверка индикации
@near short ind_check_cnt;
@near short ind_check_cnt1;

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//отладка
//char random_plazma;
unsigned char tempUC;
//@near signed char 	TABLE_TEMPER_EE[7][5];
bool bWATCHDOG_REFRESH=1;
bool bDEB;
@near char version_show_cnt=10;
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


//-----------------------------------------------
//Статус питающей сети
void power_in_drv(void)
{
//Статус сети 
GPIOA->DDR&=~(1<<6);		
GPIOA->CR1&=~(1<<6);		
GPIOA->CR2&=~(1<<6);
GPIOA->ODR&=~(1<<6);

if(!((GPIOA->IDR)&(1<<6)))
	{
	if(power_in_drv_off_cnt<10)
		{
		power_in_drv_off_cnt++;	
		}
	else
		{
		powerStat=psOFF;
		}
	
	if(power_in_drv_alarm_cnt<60)
		{
		power_in_drv_alarm_cnt++;	
		if((power_in_drv_alarm_cnt>=60)&&(powerAlarm!=paALARM))
			{
			powerAlarm=paALARM;
			
			strcpy(tempRussianText,"Электричество отключено"); 
#ifdef FINAL_RELEASE						
			if(AUTH_NUMBER_FLAGS&0x01) //если установлен главный номер
				{
				modem_send_sms('p',MAIN_NUMBER,tempRussianText);
				}
			if(AUTH_NUMBER_FLAGS&0x02) //если установлен главный номер
				{
				modem_send_sms('p',AUTH_NUMBER_1,tempRussianText);
				}	
			if(AUTH_NUMBER_FLAGS&0x04) //если установлен главный номер
				{
				modem_send_sms('p',AUTH_NUMBER_2,tempRussianText);
				}	
			if(AUTH_NUMBER_FLAGS&0x08) //если установлен главный номер
				{
				modem_send_sms('p',AUTH_NUMBER_3,tempRussianText);
				}
#endif				
			}
		}		
	}
else
	{
	if(power_in_drv_off_cnt)
		{
		power_in_drv_off_cnt--;
		version_show_cnt=10;			
		}
	else
		{
		powerStat=psON;
		}
	
	if(power_in_drv_alarm_cnt)
		{
		power_in_drv_alarm_cnt--;	
		if((power_in_drv_alarm_cnt==0)&&(powerAlarm!=paNORM))
			{
			powerAlarm=paNORM;
#ifdef FINAL_RELEASE			
			strcpy(tempRussianText,"Электричество включено"); 
						
			if(AUTH_NUMBER_FLAGS&0x01) //если установлен главный номер
				{
				modem_send_sms('p',MAIN_NUMBER,tempRussianText);
				}
			if(AUTH_NUMBER_FLAGS&0x02) //если установлен главный номер
				{
				modem_send_sms('p',AUTH_NUMBER_1,tempRussianText);
				}	
			if(AUTH_NUMBER_FLAGS&0x04) //если установлен главный номер
				{
				modem_send_sms('p',AUTH_NUMBER_2,tempRussianText);
				}	
			if(AUTH_NUMBER_FLAGS&0x08) //если установлен главный номер
				{
				modem_send_sms('p',AUTH_NUMBER_3,tempRussianText);
				}
#endif
			}
		}		
	}
}

//-----------------------------------------------
//Статус питающей сети (разовый, при старте)
short power_in_test(void)
{
//Статус сети 
GPIOA->DDR&=~(1<<6);		
GPIOA->CR1&=~(1<<6);		
GPIOA->CR2&=~(1<<6);
GPIOA->ODR&=~(1<<6);

power_in_drv_off_cnt=500;

while(1)
	{
	if(!((GPIOA->IDR)&(1<<6)))
		{
		power_in_drv_off_cnt++;	
		if(power_in_drv_off_cnt>1000) return 0;
		}
	else 
		{
		power_in_drv_off_cnt--;	
		if(power_in_drv_off_cnt==0) return 1;		
		}
	}
}
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
	
if((waterSensorErrorStat==dsesNORM)&&((waterTemperAlarm==wtaCOOL/*temperOfWater<=3*/)||(waterTemperAlarm==wtaHEAT/*temperOfWater>=90*/)))bERR=1;	
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

if((airSensorErrorStat!=taesNORM)&&(airSensorErrorStatOld==taesNORM))
	{
	strcpy(tempRussianText,"Неисправность датчика температуры воздуха"); 

#ifdef FINAL_RELEASE
	if(AUTH_NUMBER_FLAGS&0x01) //если установлен главный номер
		{
		modem_send_sms('p',MAIN_NUMBER,tempRussianText);
		}
	if(AUTH_NUMBER_FLAGS&0x02) //если установлен главный номер
		{
		modem_send_sms('p',AUTH_NUMBER_1,tempRussianText);
		}	
	if(AUTH_NUMBER_FLAGS&0x04) //если установлен главный номер
		{
		modem_send_sms('p',AUTH_NUMBER_2,tempRussianText);
		}	
	if(AUTH_NUMBER_FLAGS&0x08) //если установлен главный номер
		{
		modem_send_sms('p',AUTH_NUMBER_3,tempRussianText);
		}	
#endif		
	}
airSensorErrorStatOld=airSensorErrorStat;
}

//-----------------------------------------------
void waterTemperAlarmHndl(void)
{
if((waterSensorErrorStat==dsesNORM)&&((temperOfWater<3)||(temperOfWater>90))&&(mainCnt>60))
	{
	if(waterTemperAlarmCnt<15)waterTemperAlarmCnt++;//=wtaCOOL;	
	}
/*else if((waterSensorErrorStat==dsesNORM)&&(temperOfWater>90)&&(mainCnt>60))
	{
	waterTemperAlarm=wtaHEAT;	
	}*/
else if((waterSensorErrorStat==dsesNORM)&&(temperOfWater>=10)&&(temperOfWater<=80))
	{
	if(waterTemperAlarmCnt)waterTemperAlarmCnt--;//waterTemperAlarm=wtaNORM;	
	}
//gran_char(&waterTemperAlarmCnt);	
if(waterTemperAlarmCnt>14)
	{
	if(temperOfWater<3)waterTemperAlarm=wtaCOOL;
	else if(temperOfWater>90)waterTemperAlarm=wtaHEAT;
	}
else if(waterTemperAlarmCnt<1)
	{
	waterTemperAlarm=wtaNORM;	
	}
	
if((waterTemperAlarm!=wtaNORM)&&(waterTemperAlarmOld==wtaNORM))
	{
	if(waterTemperAlarm==wtaCOOL) strcpy(tempRussianText,"Температура воды в системе ниже 3 гр.Ц."); 
	else if(waterTemperAlarm==wtaHEAT) strcpy(tempRussianText,"Температура воды в системе выше 90 гр.Ц."); 


	if(AUTH_NUMBER_FLAGS&0x01) //если установлен главный номер
		{
		modem_send_sms('p',MAIN_NUMBER,tempRussianText);
		}
#ifdef FINAL_RELEASE	
	if(AUTH_NUMBER_FLAGS&0x02) //если установлен главный номер
		{
		modem_send_sms('p',AUTH_NUMBER_1,tempRussianText);
		}	
	if(AUTH_NUMBER_FLAGS&0x04) //если установлен главный номер
		{
		modem_send_sms('p',AUTH_NUMBER_2,tempRussianText);
		}	
	if(AUTH_NUMBER_FLAGS&0x08) //если установлен главный номер
		{
		modem_send_sms('p',AUTH_NUMBER_3,tempRussianText);
		}	
#endif		
	}
waterTemperAlarmOld=waterTemperAlarm;
}

//-----------------------------------------------
void beep_drv(void)
{
GPIOG->DDR|=0b00000010;
GPIOG->CR1|=0b00000010;
GPIOG->CR2&=0b11111101;



if(bERR)
	{
	if(++beep_drv_cnt>=15)beep_drv_cnt=0;
	if(beep_drv_cnt<5)
		{
		GPIOG->ODR|=0b00000010;
		}
	else GPIOG->ODR&=0b11111101;
	}
else if(bWARN)
	{
	if(++beep_drv_cnt>=100)beep_drv_cnt=0;
	if((beep_drv_cnt<5)||((beep_drv_cnt>=15)&&(beep_drv_cnt<20))||((beep_drv_cnt>=30)&&(beep_drv_cnt<35)))
		{
		GPIOG->ODR|=0b00000010;
		}
	else GPIOG->ODR&=0b11111101;
	}
else if(beepTestCnt)
	{
	beepTestCnt--;
	GPIOG->ODR|=0b00000010;
	}
else GPIOG->ODR&=0b11111101;
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
void power_off_hndl(void)
{
if(powerStat==psON)
	{
	main_power_off_hndl_cnt=0;
	return;
	}
if(main_power_off_hndl_cnt<POWER_OFF_HNDL_PERIOD_IN_SEC)
	{
	main_power_off_hndl_cnt++;
	}
if(main_power_off_hndl_cnt==POWER_OFF_HNDL_PERIOD_IN_SEC)
	{
	printf("AT + CBC \r");
	cbcSystemRequ++;
	if(cbcSystemRequ>=4)
		{
		GPIOD->ODR|=0b00111100;
		halt();
		}
	main_power_off_hndl_cnt=0;
	bCBC_SELF=1;
	}
if(bCBC_SELF==2)
	{
	bCBC_SELF=0;
	
	cbcSystemRequ=0;
	if(cbcVoltage<3500)
		{
		modemDrvPowerDownStepCnt=1;	
		}
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

powerEnabled=0;
if((out_stat[0]==osON)&&(outMode==omON))powerEnabled++;
if((out_stat[1]==osON)&&(outMode==omON))powerEnabled++;
if((out_stat[2]==osON)&&(outMode==omON))powerEnabled++;

enableInterrupts();
}

//-----------------------------------------------
void power_necc_hndl(void)
{

if((aktualTemper>=targetTemper)||(temperOfWater>=90)||(mainCnt<3)||(powerStat==psOFF))
	{
	powerNecc=0;	
	}
else if(aktualTemper<targetTemper)
	{
	powerNeccDelta=targetTemper-aktualTemper;
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
	if(bDEB)temperOfWater=1;
	}
if(MODE_EE==1)
	{
	aktualTemper=temperOfWater;
	targetTemper=NECC_TEMPER_WATER_EE;
	}
else if(MODE_EE==2)
	{
	aktualTemper=temperOfAir;
	targetTemper=NECC_TEMPER_AIR_EE;
	}
else if(MODE_EE==3)
	{
	aktualTemper=temperOfAir;
	targetTemper=temperRegToSheduler;
	}
}

//-----------------------------------------------
void ind_hndl(void)
{
char i;

if(version_show_cnt)
	{
	int2indII_slkuf(VERSION,3, 1, 1, 0, 0);
	int2indII_slkuf(BUILD,0, 3, 0, 0, 0);
	ind_outG[3]&=0xfe;	
	}
else if(powerStat==psOFF)
	{
	int2indII_slkuf(cbcVoltage,0, 4, 3, 0, 0);
	}
else if(ind==iMn)
	{
	int2indII_slkuf(time_hour,2, 2, 0, 0, 0);
	int2indII_slkuf(time_min,0, 2, 0, 0, 0);
	//int2indII_slkuf(power_in_drv_off_cnt,2, 2, 0, 0, 0);
	//int2indII_slkuf(power_in_drv_alarm_cnt,0, 2, 0, 0, 0);
	if(bFL2)	ind_outG[2]&=0b11111110;
	//int2indII_slkuf(time_sec,0, 2, 0, 0, 0);
	//else 		int2indII_slkuf(time_sec,0, 2, 1, 0, 0);
	
	if(aktualTemper>=0)
		{
		int2indI_slkuf(aktualTemper,2, 2, 0, 1, 0);
		ind_outB[1]=0b10011100;
		}
	else 
		{
		if(-aktualTemper<10)
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-aktualTemper,2, 1, 0, 1, 0);
			ind_outB[1]=0b10011100;
			}
		else
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-aktualTemper,1, 2, 0, 1, 0);
			}
		}
	
	//int2indI_slkuf(powerStat,3, 1, 0, 1, 0);
	//int2indI_slkuf(powerAlarm,1, 1, 0, 1, 0);
	
	led_mask_off(0x00);
	if(outMode==omON)
		{
		if(MODE_EE==1)led_on(1);
		else if(MODE_EE==2) led_on(2);
		else if(MODE_EE==3)
			{
			led_on(2);
			led_on(3);
			}
		}
	if(!optr_kontr_cnt)
		{
		if((outMode==omON)&&(out_stat[0]==osON))led_on(4);
		if((outMode==omON)&&(out_stat[1]==osON))led_on(5);
		if((outMode==omON)&&(out_stat[2]==osON))led_on(6);
		}
	else 
		{
		if(((optr_kontr_cnt)&&(optr_stat&0x01)))led_on(4);
		if(((optr_kontr_cnt)&&(optr_stat&0x02)))led_on(5);
		if(((optr_kontr_cnt)&&(optr_stat&0x04)))led_on(6);
		}

	if(bERR)led_on(7);
	else if(bWARN)led_flash(7);
	

	//led_set(2,0);
	//led_set(3,2);
	if(modemState==MS_LINKED_INITIALIZED)	led_on(8);
	else 									led_off(8);
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
		int2indII_slkuf(NECC_TEMPER_WATER_EE,0, 2, 0, 1, 1);
		}	
	else if(sub_ind==2)
		{
		int2indII_slkuf(NECC_TEMPER_AIR_EE,0, 2, 0, 1, 1);
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
		int2indI_slkuf(targetTemper,1, 2, 0, 0, 0);
		int2indII_slkuf(aktualTemper,0, 2, 0, 0, 0);
		}
	
	else if(sub_ind==1)
		{
		int2indI_slkuf(temperOfWater,1, 2, 0, 0, 0);
		int2indII_slkuf(temperOfAir,0, 2, 0, 0, 0);
		}
		
	else if(sub_ind==2)
		{
		int2indI_slkuf(MAX_POWER_EE,1, 2, 0, 0, 0);
		int2indII_slkuf(powerNeccDelta,2, 2, 0, 0, 0);
		int2indII_slkuf(powerNecc,0, 2, 0, 0, 0);
		}
	else if(sub_ind==3)
		{
		int2indI_slkuf(aktualTemper,2, 2, 0, 0, 0);	
		int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(out_stat[0],3, 1, 0, 0, 0);
		int2indII_slkuf(out_stat[1],2, 1, 0, 0, 0);
		int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		int2indII_slkuf(fiksRandom,0, 1, 0, 0, 0);
		}	
	else if(sub_ind==4)
		{
		int2indI_slkuf(temperRegToSheduler,1, 2, 0, 0, 0);	
		//int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(time_day_of_week,3, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[1],2, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		int2indII_slkuf(day_sheduler_time,0, 3, 0, 0, 0);
		}	

	else if(sub_ind==5)
		{
		int2indI_slkuf(modemDrvPDUSMSSendStepCnt,1, 3, 0, 0, 0);	
		//int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(modemDrvWatchDogCnt,0, 3, 0, 0, 0);
		//int2indII_slkuf(out_stat[1],2, 1, 0, 0, 0);
		//int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		int2indII_slkuf(4,3, 1, 0, 0, 1);
		}
	else if(sub_ind==6)
		{
		int2indI_slkuf(main_power_off_hndl_cnt,1, 3, 0, 0, 0);	
		//int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(cbcSystemRequ,0, 1, 0, 0, 0);
		int2indII_slkuf(modemDrvPowerDownStepCnt,2, 2, 0, 0, 0);
		//int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		//int2indII_slkuf(4,3, 1, 0, 0, 1);
		}

	else if(sub_ind==7)
		{
		int2indI_slkuf(tx_counter1,1, 3, 0, 0, 0);	
		//int2indI_slkuf(powerNecc,1, 1, 0, 0, 0);
		int2indII_slkuf(tx_wr_index1,0, 3, 0, 0, 0);
		//int2indII_slkuf(modemDrvPowerDownStepCnt,2, 2, 0, 0, 0);
		//int2indII_slkuf(out_stat[2],1, 1, 0, 0, 0);
		//int2indII_slkuf(4,3, 1, 0, 0, 1);
		}
	else if(sub_ind==8)
		{
		//Физическая проверка индикации. Поочередное зажигание всех еденичных 
		//элементов индикации
		//@near static short ind_check_cnt;
		//@near static short ind_check_cnt1;
		if(++ind_check_cnt1>=5)
			{
			ind_check_cnt1=0;
			if(++ind_check_cnt>=64)ind_check_cnt=0;
			}
		ind_outB[0]=0xff;
		ind_outB[1]=0xff;
		ind_outB[2]=0xff;
		ind_outB[3]=0xff;
		ind_outC[0]=0xff;
		ind_outC[1]=0xff;
		ind_outC[2]=0xff;
		ind_outC[3]=0xff;
		ind_outG[0]=0xff;
		ind_outG[1]=0xff;
		ind_outG[2]=0xff;
		ind_outG[3]=0xff;
		//ind_outB[3]=0xff;
		if(ind_check_cnt<=7)
			{
			ind_outB[3]&=(~(1<<ind_check_cnt));	
			}
		else if(ind_check_cnt<=15)
			{
			ind_outB[2]&=(~(1<<(ind_check_cnt-8)));	
			}
		else if(ind_check_cnt<=23)
			{
			ind_outB[1]&=(~(1<<(ind_check_cnt-16)));	
			}
		else if(ind_check_cnt<=30)
			{
			ind_outC[3]&=(~(1<<(ind_check_cnt-23)));	
			}	
		else if(ind_check_cnt==31)
			{
			ind_outG[3]&=0xfe;	
			}			
		else if(ind_check_cnt<=38)
			{
			ind_outC[2]&=(~(1<<(ind_check_cnt-31)));	
			}	
		else if(ind_check_cnt==39)
			{
			ind_outG[2]&=0xfe;	
			}			
		else if(ind_check_cnt<=46)
			{
			ind_outC[1]&=(~(1<<(ind_check_cnt-39)));	
			}	
		else if(ind_check_cnt==47)
			{
			ind_outG[1]&=0xfe;	
			}			
		else if(ind_check_cnt<=54)
			{
			ind_outC[0]&=(~(1<<(ind_check_cnt-47)));	
			}	
		else if(ind_check_cnt==55)
			{
			ind_outG[0]&=0xfe;	
			}
		else if(ind_check_cnt<=64)
			{	
			led_mask_off(0x00);
			led_on(ind_check_cnt-55);	
			}
		}
	else if(sub_ind==9)
		{
		int2indI_slkuf(waterTemperAlarmCnt,1, 3, 0, 0, 0);
		int2indII_slkuf(mainCnt,0, 2, 0, 0, 0);
		int2indII_slkuf(temperOfWater,2, 2, 0, 0, 0);
		}
	else if(sub_ind==10)
		{
		int2indI_slkuf(waterTemperAlarm,1, 1, 0, 0, 0);
		int2indI_slkuf(waterTemperAlarmOld,3, 1, 0, 0, 0);
		int2indII_slkuf(mainCnt,0, 2, 0, 0, 0);
		int2indII_slkuf(temperOfWater,2, 2, 0, 0, 0);
		}
	else if(sub_ind==11)
		{
		int2indI_slkuf(optr_stat,1, 3, 0, 0, 0);
		int2indII_slkuf(optr_kontr_cnt,0, 3, 0, 0, 0);
		}	
	else if(sub_ind==12)
		{
		int2indI_slkuf(cntAirSensorLineErrorLo,1, 1, 0, 0, 0);
		int2indI_slkuf(cntAirSensorLineErrorHi,3, 1, 0, 0, 0);
		int2indII_slkuf(airSensorErrorStat,0, 2, 0, 0, 0);
		int2indII_slkuf(airSensorErrorStatOld,2, 2, 0, 0, 0);
		
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
		int2indI_slkuf(aktualTemper,2, 2, 0, 0, 0);	
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
	if(outMode==osON)led_on(MODE_EE);
	if((outMode==osON)&&(out_stat[0]==osON))led_on(4);
	if((outMode==osON)&&(out_stat[1]==osON))led_on(5);
	if((outMode==osON)&&(out_stat[2]==osON))led_on(6);
*/

	led_mask_off(0x00);
	if(outMode==omON)
		{
		if(MODE_EE==1)led_on(1);
		else if(MODE_EE==2) led_on(2);
		else if(MODE_EE==3)
			{
			led_on(2);
			led_on(3);
			}
		}
	if((outMode==omON)&&(out_stat[0]==osON))led_on(4);
	if((outMode==omON)&&(out_stat[1]==osON))led_on(5);
	if((outMode==omON)&&(out_stat[2]==osON))led_on(6);
	
	if(bERR)led_on(7);
	else if(bWARN)led_flash(7);

	if(aktualTemper>=0)
		{
		int2indI_slkuf(aktualTemper,2, 2, 0, 1, 0);
		ind_outB[1]=0b10011100;
		}
	else 
		{
		if(-aktualTemper<10)
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-aktualTemper,2, 1, 0, 1, 0);
			ind_outB[1]=0b10011100;
			}
		else
			{
			ind_outB[3]=0b10111111;
			int2indI_slkuf(-aktualTemper,1, 2, 0, 1, 0);
			}
		}

	int2indII_slkuf(targetTemper,1, 2, 0, 1, MODE_EE==3?0:1);
	if((bFL2)&&(MODE_EE!=3))	ind_outC[0]=0b11111111;
	else 						ind_outC[0]=0b00111000;

	}	

else if(ind==iDefSet)
	{
	led_mask_off(0x00);

	int2indI_slkuf(123,1, 3, 0, 0, 0);
	int2indII_slkuf(4567,0, 4, 0, 0, 0);
	}
else if(ind==iMn_number)
	{
	led_mask_off(0x00);

	int2indI_slkuf(rand_dig[0], 3, 1, 0, 0, 0);
	int2indI_slkuf(rand_dig[1], 2, 1, 0, 0, 0);
	int2indI_slkuf(rand_dig[2], 1, 1, 0, 0, 0);
	int2indII_slkuf(rand_dig[3], 3, 1, 0, 0, 0);
	int2indII_slkuf(rand_dig[4], 2, 1, 0, 0, 0);
	int2indII_slkuf(rand_dig[5], 1, 1, 0, 0, 0);
	int2indII_slkuf(rand_dig[6], 0, 1, 0, 0, 0);
	}	

else if(ind==iAfterReset)
	{
	led_mask_off(0x00);

	int2indI_slkuf(mainCnt, 1, 3, 0, 0, 0);
	}	

else if(ind==iWater)
	{
	led_mask_off(0x00);

	int2indI_slkuf(temperOfWater,1, 3, 0, 0, 0);
	//int2indII_slkuf(4567,0, 4, 0, 0, 0);
	}

else if(ind==iAir)
	{
	led_mask_off(0x00);

	int2indI_slkuf(temperOfAir,1, 3, 0, 0, 0);
	//int2indII_slkuf(4567,0, 4, 0, 0, 0);
	}
	
else if(ind==iInterf)
	{
	//Физическая проверка индикации. Поочередное зажигание всех еденичных 
	//элементов индикации
//	@near static short ind_check_cnt;
//	@near static short ind_check_cnt1;
	if(++ind_check_cnt1>=5)
		{
		ind_check_cnt1=0;
		if(++ind_check_cnt>=64)ind_check_cnt=0;
		}
	ind_outB[0]=0xff;
	ind_outB[1]=0xff;
	ind_outB[2]=0xff;
	ind_outB[3]=0xff;
	ind_outC[0]=0xff;
	ind_outC[1]=0xff;
	ind_outC[2]=0xff;
	ind_outC[3]=0xff;
	ind_outG[0]=0xff;
	ind_outG[1]=0xff;
	ind_outG[2]=0xff;
	ind_outG[3]=0xff;
	led_mask_off(0x00);
	//ind_outB[3]=0xff;
	if(ind_check_cnt<=7)
		{
		ind_outB[3]&=(~(1<<ind_check_cnt));	
		}
	else if(ind_check_cnt<=15)
		{
		ind_outB[2]&=(~(1<<(ind_check_cnt-8)));	
		}
	else if(ind_check_cnt<=23)
		{
		ind_outB[1]&=(~(1<<(ind_check_cnt-16)));	
		}
	else if(ind_check_cnt<=30)
		{
		ind_outC[3]&=(~(1<<(ind_check_cnt-23)));	
		}	
	else if(ind_check_cnt==31)
		{
		ind_outG[3]&=0xfe;	
		}			
	else if(ind_check_cnt<=38)
		{
		ind_outC[2]&=(~(1<<(ind_check_cnt-31)));	
		}	
	else if(ind_check_cnt==39)
		{
		ind_outG[2]&=0xfe;	
		}			
	else if(ind_check_cnt<=46)
		{
		ind_outC[1]&=(~(1<<(ind_check_cnt-39)));	
		}	
	else if(ind_check_cnt==47)
		{
		ind_outG[1]&=0xfe;	
		}			
	else if(ind_check_cnt<=54)
		{
		ind_outC[0]&=(~(1<<(ind_check_cnt-47)));	
		}	
	else if(ind_check_cnt==55)
		{
		ind_outG[0]&=0xfe;	
		}
	else if(ind_check_cnt<=64)
		{	
		led_mask_off(0x00);
		led_on(ind_check_cnt-55);	
		}
	}

if(powerStat==psOFF)
	{
	led_set(1,0);
	led_set(2,0);
	led_set(3,0);
	led_set(4,0);
	led_set(5,0);
	led_set(6,0);
	led_set(7,0);
	led_set(8,2);
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
		//modemDrvSMSSendStepCnt=1;
		
		//modem_send_sms('t', "9139294352", "Мама1 \r\nМама2");
		}
		
	else if(but==butD)
		{
		//bWATCHDOG_REFRESH=0;
		//printf("AT + CPOWD = 1 \r");
		//printf("AT + CBC \r");
		//halt();
		//bDEB=!bDEB;
		}	

	else if(but==butU_)
		{
		//printf("AT + CPAS \r");	
		}
	else if(but==butON)
		{
		if(outMode==omON)	outMode=omOFF;
		else 				outMode=omON;
		HUMAN_SET_EE=1;
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
			HUMAN_SET_EE=1;
			}
		if((but==butD)||(but==butD_))
			{
			NECC_TEMPER_WATER_EE--;
			gran_char(&NECC_TEMPER_WATER_EE,5,85);
			speed=1;
			HUMAN_SET_EE=1;
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
			HUMAN_SET_EE=1;
			}
		if((but==butD)||(but==butD_))
			{
			NECC_TEMPER_AIR_EE--;
			gran_char(&NECC_TEMPER_AIR_EE,5,35);
			speed=1;
			HUMAN_SET_EE=1;
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
				HUMAN_SET_EE=1;
				}
			if((but==butD)||(but==butD_))
				{
				MODE_EE--;
				gran_char(&MODE_EE,1,3);
				HUMAN_SET_EE=1;
				}				
			}
		else if(sub_ind==1)
			{
			if((but==butU)||(but==butU_))
				{
				NECC_TEMPER_WATER_EE++;
				gran_char(&NECC_TEMPER_WATER_EE,5,85);
				speed=1;
				HUMAN_SET_EE=1;
				}
			if((but==butD)||(but==butD_))
				{
				NECC_TEMPER_WATER_EE--;
				gran_char(&NECC_TEMPER_WATER_EE,5,85);
				speed=1;
				HUMAN_SET_EE=1;
				}				
			}			
		else if(sub_ind==2)
			{
			if((but==butU)||(but==butU_))
				{
				NECC_TEMPER_AIR_EE++;
				gran_char(&NECC_TEMPER_AIR_EE,5,35);
				speed=1;
				HUMAN_SET_EE=1;
				}
			if((but==butD)||(but==butD_))
				{
				NECC_TEMPER_AIR_EE--;
				gran_char(&NECC_TEMPER_AIR_EE,5,35);
				speed=1;
				HUMAN_SET_EE=1;
				}				
			}			
		
		else if(sub_ind==3)
			{
			if((but==butU)||(but==butU_))
				{
				MAX_POWER_EE++;
				gran_char(&MAX_POWER_EE,1,3);
				speed=1;
				HUMAN_SET_EE=1;
				}
			if((but==butD)||(but==butD_))
				{
				MAX_POWER_EE--;
				gran_char(&MAX_POWER_EE,1,3);
				speed=1;
				HUMAN_SET_EE=1;
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
			signed char temp,max_day;
			temp=time_date;
			max_day=31;
			if((time_month==4)||(time_month==6)||(time_month==9)||(time_month==11))max_day=30;
			else if(time_month==2)
				{
				if((time_year%4)==0)max_day=29;
				else max_day=28;
				}
			if((but==butU)||(but==butU_))
				{
				temp++;
				gran_ring_char(&temp,1,max_day);
				_ds1307_write_byte(4,((temp/10)<<4)+(temp%10));
				
				}
			if((but==butD)||(but==butD_))
				{
				temp--;
				gran_ring_char(&temp,1,max_day);
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
			/*
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
		*/
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
			HUMAN_SET_EE=1;
			}
		if((but==butD)||(but==butD_))
			{
			tempUC=TABLE_TIME_EE[num_of_day][num_of_set];
			if(tempUC)tempUC--;
			if(tempUC>TABLE_TIME_EE_MAX[num_of_set])tempUC=TABLE_TIME_EE_MAX[num_of_set];
			if(tempUC<TABLE_TIME_EE_MIN[num_of_set])tempUC=TABLE_TIME_EE_MIN[num_of_set];
			if(TABLE_TIME_EE[num_of_day][num_of_set]!=tempUC)TABLE_TIME_EE[num_of_day][num_of_set]=tempUC;
			speed=1;
			HUMAN_SET_EE=1;
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
		gran_char(&sub_ind,0,12);
		clear_ind();
		ind_hndl();
		}
	else if(but==butD)
		{
		sub_ind--;
		gran_char(&sub_ind,0,12);
		clear_ind();
		ind_hndl();
		}
	else if(but==butD_)
		{
		tree_down(-1,0);
		}
	else if(but==butM)
		{
		tree_up(iModem_deb,0,0,0);
		//modemDrvSMSSendStepCnt=1;
		
		//modem_send_sms('p', "9139294352", "Мама1 \r\nМама2");
		}
	else if(sub_ind==8)
		{
		if((but==butU)||(but==butD)||(but==butM)||(but==butON))	
			{
			beepTestCnt=10;
			ind_check_cnt=0;
			}
		}
	}
	
else if(ind==iModem_deb)
	{
	if(but==butU)
		{
		//modemDrvSMSSendStepCnt=1;
		
		//modem_send_sms('p', "9139294352", "Мама1 \r\nМама2");
		
		//sprintf(textToSendPDUSMS,"Мама1 %d \r\nМама2 %d",123,456);
		//sprintf(textToSendPDUSMS,"Мама мыла раму, у шуры шары. It is OK?");
		//sprintf(textToSendPDUSMS,);
		//modem_send_sms('p', "9139294352", textToSendPDUSMS);
		}
	else if(but==butD)
		{
		//char puts_bufer[100];
		
		//modem_send_sms('p',"9139294352","ОТПРАВЬТЕ В ОТВЕТНОМ СМС 7 ЦИФР ВЫВЕДЕННЫХ НА ИНДИКАТОР УСТРОЙСТВА "); //
		//modem_send_sms('p',MAIN_NUMBER,"ВАШ ТЕЛЕФОН УСТАНОВЛЕН КАК ГЛАВНЫЙ ДЛЯ ДАННОГО КОНТРОЛЛЕРА ");
		//printf("ATD*100#;\r");
		}
	else if(but==butUD_)
		{
		tree_down(0,0);
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
		//memcpy(MAIN_NUMBER,"xxxxxxxxxx",10);
		//memcpy(AUTH_NUMBER_1,"xxxxxxxxxx",10);
		//memcpy(AUTH_NUMBER_2,"xxxxxxxxxx",10);
		//memcpy(AUTH_NUMBER_3,"xxxxxxxxxx",10);
		HUMAN_SET_EE=1;
		}
	else if(but==butU_)
		{
		AUTH_NUMBER_FLAGS&=0x01;
		//memcpy(MAIN_NUMBER,"9139294352",10);
		//memcpy(AUTH_NUMBER_1,"9134863890",10);
		//memcpy(AUTH_NUMBER_2,"9237328354",10);
		//memcpy(AUTH_NUMBER_3,"xxxxxxxxxx",10);
		HUMAN_SET_EE=1;
		}	
	else if(but==butUD_)
		{
		AUTH_NUMBER_FLAGS=0x0f;
		memcpy(MAIN_NUMBER,"9139294352",10);
		memcpy(AUTH_NUMBER_1,"9134863890",10);
		memcpy(AUTH_NUMBER_2,"9237328354",10);
		memcpy(AUTH_NUMBER_3,"11234567890",10);
		HUMAN_SET_EE=1;
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
		HUMAN_SET_EE=1;
		}
	}	
	
else if(ind==iInterf)
	{
	if((but==butU)||(but==butD)||(but==butM)||(but==butON))	
		{
		beepTestCnt=10;
		ind_check_cnt=0;
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
if(powerStat==psOFF)GPIOC->ODR=0xff;
GPIOG->ODR|=0x01;
GPIOG->ODR&=ind_outG[ind_cnt];
if(ind_cnt==9)GPIOB->DDR=0x00;
else GPIOB->DDR=0xff;
if(powerStat==psOFF)
	{
	GPIOD->ODR|=0b00111100;
	if((ind_cnt==0)||(ind_cnt>3))GPIOD->ODR&=ind_strob[0];
	}
else GPIOD->ODR&=ind_strob[ind_cnt];

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
ind=iMn;//iModem_deb;
//tree_up(iAfterReset,0,0,0);
//tree_up(iDeb,6,0,0);
//ret_ind(10,0);
//outMode=osOFF;

bERR=0;
bWARN=0;

modemDrvInitStepCnt=1;

//PDU2text("043E0442043F044004300432044C0442043500200441043C04410031003200330034");
//ODE_EE=1;

watchdog_enable();

if(power_in_test()==0)
	{
	GPIOD->ODR|=0b00111100;
	halt();
	}

while (1)
	{
	uart1_in_an();
	if(b100Hz)
		{
		b100Hz=0;
		
		but_drv();
		but_an();
		beep_drv();
		modem_stat_drv();
		
		}
	if(b10Hz)
		{
		b10Hz=0;

		if(bWATCHDOG_REFRESH)watchdog_reset();
		ind_hndl();
		uart3_in_an();
		out_drv();
		matemath();
		modem_drv();
		sms_fifo_drv();
		power_in_drv();
		}
	if(b5Hz)
		{
		b5Hz=0;

		if(version_show_cnt)version_show_cnt--;
		}
	if(b2Hz)
		{
		b2Hz=0;
		
		time_drv();
		}
	if(b1Hz)
		{
		b1Hz=0;
		
		if(mainCnt<1000)
			{
			mainCnt++;
			//if(mainCnt==3)outMode=osON;
			}
		
		ds18b20_temper_drv();
		ret_ind_hndl();
		random_gen();
		power_necc_hndl();
		power_hndl();
		sheduler_hndl();
		error_warn_hndl();
		airSensorLineErrorDrv();
		waterTemperAlarmHndl();
		power_off_hndl();
		
		//printf("%s \r", MAIN_NUMBER);
		//printf("OK%dCRC%d\n",13,14);
		
		//GPIOA->ODR^=0b00100000;
		//UART1->DR=0x55;
		}		
	};
}