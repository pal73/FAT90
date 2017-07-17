//#include "main.h"
#include "stm8s.h"
#include "modem.h"
#include <stdio.h>

char modemStatCnt0;

signed char modemPowerStatCnt;						//Счетчик антидребезга светодиода питания модема
enum_modemPowerState modemPowerState=MPS_POWEROFF;	//Состояние питания модема
signed char net_l_cnt_up,net_l_cnt_down;			//Счетчики антидребезга светодиода линка
short net_l_cnt_one, net_l_cnt_zero, net_l_cnt_one_temp; 	//Счетчики свечения светодиода линка
enum_modemLinkState modemLinkState=MLS_UNKNOWN;		//Состояние подключения к провайдеру модема
enum_modemState modemState=MS_UNKNOWN;				//Состояние модема

signed char modemDrvPowerStartCnt=0;					//Счетчик 100мС-интервалов от включения питания 
signed short modemDrvInitStepCnt=0;						//Счетчик 100мС-шагов инициализации модема

//-----------------------------------------------
void modem_gpio_init(void)
{
//Статус питания модема - вход с подтяжкой
GPIOE->DDR&=~(1<<6);		
GPIOE->CR1|=(1<<6);		
GPIOE->CR2&=~(1<<6);
GPIOE->ODR&=~(1<<6);	

//Статус сети модема - вход с подтяжкой
GPIOE->DDR&=~(1<<7);		
GPIOE->CR1|=(1<<7);		
GPIOE->CR2&=~(1<<7);
GPIOE->ODR&=~(1<<7);

//Управление сбросом модема - выход
GPIOD->DDR|=(1<<0);		
GPIOD->CR1|=(1<<0);		
GPIOD->CR2&=~(1<<0);
GPIOD->ODR&=~(1<<0);

//Управление питанием модема - выход
GPIOA->DDR|=(1<<3);		
GPIOA->CR1|=(1<<3);		
GPIOA->CR2&=~(1<<3);
GPIOA->ODR&=~(1<<3);
}

//-----------------------------------------------
//оценка текущего состояния модема
void modem_stat_drv(void)
{
signed short temp_SS;
bool net_l,net_l_old;
  
if(modemStatCnt0<10)
	{
    modemStatCnt0++;
    if(modemStatCnt0>=10)
		{
		modemStatCnt0=0;
		
		if(!(GPIOE->IDR&(1<<6)))//если светодиод POWER горит
			{
			if(modemPowerStatCnt<5)
				{
				modemPowerStatCnt++;	
				}
			else 
				{
				modemPowerState=MPS_POWERON;
				}
			}
		else //если светодиод POWER не горит
			{
			if(modemPowerStatCnt>0)
				{
				modemPowerStatCnt--;	
				}
			else 
				{
				modemPowerState=MPS_POWEROFF;
				}
			}
		}
    }

if(!(GPIOE->IDR&(1<<7))) //если светодиод LINK горит
    {
    net_l_cnt_down=0;
    if(net_l_cnt_up<3)
		{
		net_l_cnt_up++;
		if(net_l_cnt_up==3)
			{
			if((net_l_cnt_one_temp>4) && (net_l_cnt_one_temp<8))
				{
				if((net_l_cnt_zero>70) && (net_l_cnt_zero<90))			modemLinkState=MLS_UNLINKED; 
				else if((net_l_cnt_zero>250) && (net_l_cnt_zero<350))	modemLinkState=MLS_LINKED;  
				else if((net_l_cnt_zero>25) && (net_l_cnt_zero<35))		modemLinkState=MLS_GPRS; 
				else 													modemLinkState=MLS_UNKNOWN;
				}
				
			net_l_cnt_zero=0;   
			}
		}
    if(net_l_cnt_one<1000)
		{
		net_l_cnt_one++;  
		}      
    }
else  //если светодиод LINK не горит
    {
    net_l_cnt_up=0; 
    if(net_l_cnt_down<3)
		{
		net_l_cnt_down++;
		if(net_l_cnt_down==3)
			{
			net_l_cnt_one_temp=net_l_cnt_one;
			net_l_cnt_one=0;   
			}
		}
    if(net_l_cnt_zero<1000)
		{
		net_l_cnt_zero++;  
		}
    }

if(modemPowerState==MPS_POWEROFF)										modemState=MS_POWEROFF;
else if(modemLinkState==MLS_UNLINKED)									modemState=MS_UNLINKED;
else if(modemLinkState==MLS_LINKED)										modemState=MS_LINKED;
else if(modemLinkState==MLS_GPRS)										modemState=MS_GPRS;
else 																	modemState=MS_UNKNOWN;
}

//-----------------------------------------------
void modem_drv(void)
{
if(modemDrvPowerStartCnt<70)
	{
	modemDrvPowerStartCnt++;	
	}
else
	{
	if(modemState!=MS_LINKED)
		{
		if(modemDrvInitStepCnt==0)modemDrvInitStepCnt=1;	
		}
	else 
		{
		if(modemDrvInitStepCnt==0)modemDrvInitStepCnt=26;	
			
		}
		
	if(modemDrvInitStepCnt)
		{
		if(modemDrvInitStepCnt==5)
			{
			GPIOD->ODR|=(1<<0);			//Сброс
			modemDrvInitStepCnt++;
			}
			
		else if(modemDrvInitStepCnt==7)
			{
			GPIOD->ODR&=~(1<<0);		//Конец сброса
			modemDrvInitStepCnt++;
			}	

		else if(modemDrvInitStepCnt==20)
			{
			GPIOA->ODR|=(1<<3);			//Воздействие на вход управления питанием модема
			modemDrvInitStepCnt++;
			}	
			
		else if(modemDrvInitStepCnt==25)
			{
			GPIOA->ODR&=~(1<<3);		//Конец воздействия на вход управления питанием модема
			modemDrvInitStepCnt++;
			}

		else if(modemDrvInitStepCnt==30)
			{
			if(modemState==MS_LINKED)modemDrvInitStepCnt++;
			}
			
		else if(modemDrvInitStepCnt==35)
			{
			//printf("AT+COPS?\r\n");
			printf("ATE0\r\n");
			modemDrvInitStepCnt++;
			}

		else if(modemDrvInitStepCnt==45)
			{
			printf("AT+CMGF=1\r\n");
			modemDrvInitStepCnt++;
			}

		else if(modemDrvInitStepCnt==55)
			{
			printf("AT+IFC=0, 0\r");
			modemDrvInitStepCnt++;
			}
			
		else if(modemDrvInitStepCnt==65)
			{
			printf("AT+CPBS=\"SM\"\r");
			modemDrvInitStepCnt++;
			}

		else if(modemDrvInitStepCnt==75)
			{
			printf("AT+CNMI=1,2,2,1,0\r");
			modemDrvInitStepCnt++;
			}

		else if(modemDrvInitStepCnt==80)
			{
			modemState=MS_LINKED_INITIALIZED;
			modemDrvInitStepCnt++;
			}


		else if(modemDrvInitStepCnt==100)
			{
			modemState=MS_LINKED_INITIALIZED;
			modemDrvInitStepCnt++;
			}

		else
			{
			if(modemDrvInitStepCnt<1000)	modemDrvInitStepCnt++;
			}
		}
	}
}
