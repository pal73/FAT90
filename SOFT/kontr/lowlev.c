#include "stm8s.h"
#include "main.h"
#include "lowlev.h"

//-----------------------------------------------
//Состояние питающего напряжения
enum_power_stat power_stat=psOFF,power_stat_old=psOFF;
char power_stat_cnt;


//-----------------------------------------------
void out_drv(void)
{
GPIOE->DDR|=0b00101001;
GPIOE->CR1&=0b11010110;
GPIOE->CR2&=0b11010110;

if(out_stat[0])	GPIOE->ODR|=0b00000001;
else 						GPIOE->ODR&=0b11111110;
if(out_stat[1])	GPIOE->ODR|=0b00001000;
else 						GPIOE->ODR&=0b11110111;
if(out_stat[2])	GPIOE->ODR|=0b00100000;
else 						GPIOE->ODR&=0b11011111;
}

//-----------------------------------------------
void power_stat_drv(void)
{
GPIOA->DDR&=(1<<6);				//PA6 вход
GPIOA->CR1&=(1<<6);				//без подтяжки
GPIOA->CR2&=(1<<6);				//и без прерывания

if(GPIOA->IDR&0b01000000)
	{
	if(power_stat_cnt<50)
		{
		power_stat_cnt++;
		if(power_stat_cnt==50)
			{
			power_stat=psON;
			}
		}
	}
else
	{
	if(power_stat_cnt)
		{
		power_stat_cnt--;
		if(power_stat_cnt==0)
			{
			power_stat=psOFF;
			}
		}
	}
if(power_stat!=power_stat_old)
	{
	//TODO прописать обработку включени и выключения питания
	}
	
power_stat_old=power_stat;
}

//-----------------------------------------------
void delay_us(short num_of_delay)
{
short i;
for(i==0;i<num_of_delay;i++)
	{
	nop();
	}
}