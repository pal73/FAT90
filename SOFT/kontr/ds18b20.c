#include "stm8s.h"
#include "main.h"
#include "ds18b20.h"


char wire1_in[10];

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------
void ds18b20_temper_drv(void)
{
static char bCONV;

if(!bCONV)
	{
	bCONV=1;
	if(wire1_polling())
		{
		wire1_send_byte(0xCC);
		wire1_send_byte(0x44);
		}			
	}
else 
	{
	bCONV=0;
	if(wire1_polling())
		{
		wire1_send_byte(0xCC);
		wire1_send_byte(0xBE);
		wire1_in[0]=wire1_read_byte();
		wire1_in[1]=wire1_read_byte();
		wire1_in[2]=wire1_read_byte();
		wire1_in[3]=wire1_read_byte();
		wire1_in[4]=wire1_read_byte();
		wire1_in[5]=wire1_read_byte();
		wire1_in[6]=wire1_read_byte();
		wire1_in[7]=wire1_read_byte();
		wire1_in[8]=wire1_read_byte();
		}			
	}
}

//-----------------------------------------------
char wire1_w1ts(void)
{
short i,ii,num_out;
DS18B20PORT->DDR|=(1<<DS18B20PIN);
DS18B20PORT->ODR&=~(1<<DS18B20PIN);

//импульс 10мкс
for(i=0;i<10;i++)
	{
	nop();
	}
DS18B20PORT->ODR|=(1<<DS18B20PIN);

//выдержка 90мкс
for(i=0;i<90;i++)
	{
	nop();
	}
}

//-----------------------------------------------
char wire1_w0ts(void)
{
short i,ii,num_out;
DS18B20PORT->DDR|=(1<<DS18B20PIN);
DS18B20PORT->ODR&=~(1<<DS18B20PIN);

//импульс 90мкс
for(i=0;i<90;i++)
	{
	nop();
	}
DS18B20PORT->ODR|=(1<<DS18B20PIN);

//выдержка 10мкс
for(i=0;i<10;i++)
	{
	nop();
	}
}

//-----------------------------------------------
void wire1_send_byte(char in)
{
char i,ii;
ii=in;

for(i=0;i<8;i++)
	{
	if(ii&0x01)wire1_w1ts();
	else wire1_w0ts();
	ii>>=1;
	}
}

//-----------------------------------------------
char wire1_read_byte(void)
{
char i,ii;
ii=0;

for(i=0;i<8;i++)
	{
	ii>>=1;
	if(wire1_rts())ii|=0x80;
	else ii&=0x7f;
	}
return ii;
}

//-----------------------------------------------
char wire1_rts(void)
{
short i,ii,num_out;

DS18B20PORT->DDR|=(1<<DS18B20PIN);
DS18B20PORT->ODR&=~(1<<DS18B20PIN);

//импульс 10мкс
for(i=0;i<2;i++)
	{
	nop();
	}

DS18B20PORT->ODR|=(1<<4);
//импульс 20мкс
for(i=0;i<10;i++)
	{
	nop();
	}
if(DS18B20PORT->IDR&(1<<DS18B20PIN))	ii=1;
else ii=0;

//выдержка 30мкс
for(i=0;i<50;i++)
	{
	nop();
	}
return ii;
}
//-----------------------------------------------
char wire1_polling(void)
{
short i,ii,num_out;
DS18B20PORT->CR1&=~(1<<DS18B20PIN);
DS18B20PORT->CR2&=~(1<<DS18B20PIN);
DS18B20PORT->DDR|=(1<<DS18B20PIN);


DS18B20PORT->ODR&=~(1<<4);

//импульс сброса 600мкс
for(i=0;i<600;i++)
	{
	nop();
	}
DS18B20PORT->ODR|=(1<<DS18B20PIN);

//выдержка 15мкс
for(i=0;i<15;i++)
	{
	nop();
	}

//еще 45мкс ждем сигнала от таблетки
for(i=0;i<20;i++)
	{
	nop();
	nop();
	nop();
	if(!(DS18B20PORT->IDR&(1<<DS18B20PIN)))goto ibatton_polling_lbl_000;
	}
goto ibatton_polling_lbl_zero_exit;

ibatton_polling_lbl_000:

//измеряем длительность ответного импульса не дольше 300мкс
for(i=0;i<220;i++)
	{
	if(DS18B20PORT->IDR&(1<<DS18B20PIN))
		{
		nop();
		nop();
		num_out=10;
		goto ibatton_polling_lbl_001;	//continue;
		}
	}
num_out=5;
goto ibatton_polling_lbl_zero_exit;

ibatton_polling_lbl_001:
//выдержка 15мкс
for(i=0;i<30;i++)
	{
	nop();
	}
ibatton_polling_lbl_success_exit:
return 1;
ibatton_polling_lbl_zero_exit:
return 0;
}