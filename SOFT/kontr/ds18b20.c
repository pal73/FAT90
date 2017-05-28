#include "stm8s.h"
#include "main.h"
#include "ds18b20.h"


char wire1_in[10];		//���������� ������, ����� 1wire
char ds18b20ErrorHiCnt; //������� ������ �� ��������� ����� � "+" (��� ���������� �������)
char ds18b20ErrorLoCnt;	//������� ������ �� ��������� ����� � "-" 
char ds18b20ErrorOffCnt;//������� ���������� ������� �������
enumDsErrorStat waterSensorErrorStat = esNORM;

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------
void ds18b20_temper_drv(void)
{
static char bCONV;

if(!bCONV)
	{
	char temp;
	bCONV=1;
	temp=wire1_polling();
	if(temp==1)
		{
		wire1_send_byte(0xCC);
		wire1_send_byte(0x44);
		
		ds18b20ErrorHiCnt=0;
		ds18b20ErrorLoCnt=0;
		waterSensorErrorStat=esNORM;		
		}
	else
		{
		if(temp==0)
			{
			if(ds18b20ErrorHiCnt<10)
				{
				ds18b20ErrorHiCnt++;
				if(ds18b20ErrorHiCnt>=10)
					{
					waterSensorErrorStat=esHI;	
					}
				}
			ds18b20ErrorLoCnt=0;
			//ds18b20ErrorOffCnt=0;			
			}
		if(temp==5)
			{
			if(ds18b20ErrorLoCnt<10)
				{
				ds18b20ErrorLoCnt++;
				if(ds18b20ErrorLoCnt>=10)
					{
					waterSensorErrorStat=esLO;	
					}
				}
			ds18b20ErrorHiCnt=0;
			//ds18b20ErrorOffCnt=0;			
			}			
		}
	}
else 
	{
	char temp;
	bCONV=0;
	temp=wire1_polling();
	if(temp==1)
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
		
		ds18b20ErrorHiCnt=0;
		ds18b20ErrorLoCnt=0;
		waterSensorErrorStat=esNORM;
		}
	else
		{
		if(temp==0)
			{
			if(ds18b20ErrorHiCnt<10)
				{
				ds18b20ErrorHiCnt++;
				if(ds18b20ErrorHiCnt>=10)
					{
					waterSensorErrorStat=esHI;	
					}
				}
			ds18b20ErrorLoCnt=0;
			//ds18b20ErrorOffCnt=0;			
			}
		if(temp==5)
			{
			if(ds18b20ErrorLoCnt<10)
				{
				ds18b20ErrorLoCnt++;
				if(ds18b20ErrorLoCnt>=10)
					{
					waterSensorErrorStat=esLO;	
					}
				}
			ds18b20ErrorHiCnt=0;
			//ds18b20ErrorOffCnt=0;			
			}			
		}
	}
}

//-----------------------------------------------
char wire1_w1ts(void)
{
short i,ii,num_out;
DS18B20PORT->DDR|=(1<<DS18B20PIN);
DS18B20PORT->ODR&=~(1<<DS18B20PIN);

//������� 10���
for(i=0;i<6;i++)
	{
	nop();
	}
DS18B20PORT->ODR|=(1<<DS18B20PIN);

//�������� 90���
for(i=0;i<60;i++)
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

//������� 90���
for(i=0;i<60;i++)
	{
	nop();
	}
DS18B20PORT->ODR|=(1<<DS18B20PIN);

//�������� 10���
for(i=0;i<6;i++)
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

//������� 10���
for(i=0;i<2;i++)
	{
	nop();
	}

DS18B20PORT->ODR|=(1<<DS18B20PIN);
//������� 20���
for(i=0;i<6;i++)
	{
	nop();
	}
if(DS18B20PORT->IDR&(1<<DS18B20PIN))	ii=1;
else ii=0;

//�������� 30���
for(i=0;i<33;i++)
	{
	nop();
	}
return ii;
}
//-----------------------------------------------
char wire1_polling(void)
{
short i,ii,num_out;
DS18B20PORT->DDR|=(1<<DS18B20PIN);
DS18B20PORT->CR1&=~(1<<DS18B20PIN);
DS18B20PORT->CR2|=(1<<DS18B20PIN);



DS18B20PORT->ODR&=~(1<<DS18B20PIN);

//������� ������ 600���
for(i=0;i<400;i++)
	{
	nop();
	}
DS18B20PORT->ODR|=(1<<DS18B20PIN);

//�������� 15���
for(i=0;i<10;i++)
	{
	nop();
	}

//��� 45��� ���� ������� �� ��������
for(i=0;i<13;i++)
	{
	nop();
	nop();
	nop();
	if(!(DS18B20PORT->IDR&(1<<DS18B20PIN)))goto ibatton_polling_lbl_000;
	}
/*goto ibatton_polling_lbl_zero_exit;*/
return 0;

ibatton_polling_lbl_000:

//�������� ������������ ��������� �������� �� ������ 300���
for(i=0;i<146;i++)
	{
	if(DS18B20PORT->IDR&(1<<DS18B20PIN))
		{
		nop();
		nop();
		num_out=10;
		goto ibatton_polling_lbl_001;	//continue;
		}
	}
/*num_out=5;
goto ibatton_polling_lbl_zero_exit;*/
return 5;

ibatton_polling_lbl_001:
//�������� 15���
for(i=0;i<10;i++)
	{
	nop();
	}
ibatton_polling_lbl_success_exit:
return 1;
ibatton_polling_lbl_zero_exit:
return 0;
}