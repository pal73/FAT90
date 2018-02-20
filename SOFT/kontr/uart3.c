#include "stm8s.h"
#include "main.h"
#include "uart3.h"
#include "ds1307.h"
#include "lowlev.h"
#include <string.h>
#include <stdlib.h>
#include "modem.h"

//-----------------------------------------------
@near char rxBuffer3[RX_BUFFER_3_SIZE];			//Приемный буфер UART3
@near short rx_wr_index3;						//Указатель на следующий принимаемый байт
@near char uart3_an_buffer[100];				//Буфер для анализа принятых по UART3 строк
@near char bRXIN3;								//Индикатор принятой строки в uart3_an_buffer

//-----------------------------------------------
//Отладка
char uart3_plazma;
char *ptr1;
char *ptr2;
char *digi;

//-----------------------------------------------
void uart3_init (void)
{
UART3->CR1&=~UART3_CR1_M;					
UART3->CR3|= (0<<4) & UART3_CR3_STOP;	
UART3->BRR2= 0x02;//0x03;
UART3->BRR1= 0x41;//0x68;
UART3->CR2|= /*UART3_CR2_TEN | */UART3_CR2_REN | UART3_CR2_RIEN;	
}

//***********************************************
@far @interrupt void UART3RxInterrupt (void) 
{
char rx_status3=UART3->SR;
char rx_data3=UART3->DR;
	
if (rx_status3 & (UART3_SR_RXNE))
	{
	rxBuffer3[rx_wr_index3++]=rx_data3;
	if(rx_data3=='\n')
		{
			//TODO Обработка конца посылки
		memset(uart3_an_buffer,'\0',100);
		memcpy(uart3_an_buffer,rxBuffer3,rx_wr_index3);
		bRXIN3=1;
		rx_wr_index3=0;
		}
	else
		{
		if(rx_wr_index3>=RX_BUFFER_3_SIZE)
			{
			rx_wr_index3=0;	
			}
		}
	cntAirSensorLineErrorHi=0;
	cntAirSensorLineErrorLo=0;
	if(airSensorErrorStat==taesLHI)airSensorErrorStat=taesNORM;
	if(airSensorErrorStat==taesLLO)airSensorErrorStat=taesNORM;
	}
}

//-----------------------------------------------
void uart3_in_an (void)
{
int tempIN[6],tempCRC;

	disableInterrupts();
if(bRXIN3)
	{
	bRXIN3=0;
	
	if(strstr(uart3_an_buffer,"OK"))
		{
		ptr1=strstr(uart3_an_buffer,"OK");	
		ptr2=strstr(uart3_an_buffer,"CRC");
		//char *digi;
		memcpy(digi,ptr1+2,ptr2-ptr1-2);
		//TODO проверку контрольной суммы
		temperOfAir=(signed char)atoi(digi);
		airSensorErrorStat=taesNORM;
		
		}
	else if(strstr(uart3_an_buffer,"ERRORLO"))
		{
		airSensorErrorStat=taesLO;
		}
	else if(strstr(uart3_an_buffer,"ERRORHI"))
		{
		airSensorErrorStat=taesHI;
		}
	else if(strstr(uart3_an_buffer,"OPTR"))
		{
		ptr1=strstr(uart3_an_buffer,"OPTR");	
		ptr2=strstr(uart3_an_buffer,"CRC");
		memcpy(digi,ptr1+4,ptr2-ptr1-4);
		tempIN[0]=(int)atoi(digi);
		//memcpy(digi,ptr2+4,ptr2-ptr1-4);
		
		//TODO проверку контрольной суммы
		optr_stat=(char)tempIN[0];
		optr_kontr_cnt=50;
		}
	else if(strstr(uart3_an_buffer,"DATA"))
		{
		signed char temp;	
		ptr1=strstr(uart3_an_buffer,"DATA");	
		ptr2=strstr(uart3_an_buffer,"CRC");
		memcpy(digi,ptr1+4,2);
		temp=(char)atoi(digi);
		gran_char(&temp,0,99);
		_ds1307_write_byte(6,((temp/10)<<4)+(temp%10));
		memcpy(digi,ptr1+6,2);
		temp=(char)atoi(digi);
		gran_ring_char(&temp,1,12);
		_ds1307_write_byte(5,((temp/10)<<4)+(temp%10));	
		memcpy(digi,ptr1+8,2);
		temp=(char)atoi(digi);
		gran_ring_char(&temp,1,31);
		_ds1307_write_byte(4,((temp/10)<<4)+(temp%10));
		memcpy(digi,ptr1+10,2);
		temp=(char)atoi(digi);
		gran_ring_char(&temp,1,7);
		_ds1307_write_byte(3,temp&0x07);
		memcpy(digi,ptr1+12,2);
		temp=(char)atoi(digi);
		gran_ring_char(&temp,0,23);
		_ds1307_write_byte(2,(((temp/10)<<4)+(temp%10))&0b10111111);		
		memcpy(digi,ptr1+14,2);
		temp=(char)atoi(digi);
		gran_ring_char(&temp,0,59);
		_ds1307_write_byte(1,((temp/10)<<4)+(temp%10));		
		//TODO проверку контрольной суммы
		optr_stat=(char)tempIN[0];
		optr_kontr_cnt=50;
		}		
		
	else if(strstr(uart3_an_buffer,"WATER"))
		{
		if(ind!=iWater)
			{
			tree_up(iWater,0,0,0);
			}
		}	
	else if(strstr(uart3_an_buffer,"WAT_RET"))
		{
		if(ind==iWater)
			{
			tree_down(0,0);
			}
		}				
		
	else if(strstr(uart3_an_buffer,"AIR"))
		{
		if(ind!=iAir)
			{
			tree_up(iAir,0,0,0);
			}
		}				
	else if(strstr(uart3_an_buffer,"AI_RET"))
		{
		if(ind==iAir)
			{
			tree_down(0,0);
			}
		}	

	else if(strstr(uart3_an_buffer,"TIMESTART"))
		{
		_ds1307_write_byte(0,0);
		}
		
	else if(strstr(uart3_an_buffer,"PROBESMS"))
		{
		if(memcmp(MAIN_NUMBER,"9139294352",10)==0)
			{
			memcpy(MAIN_NUMBER,"9139294352",10);
			AUTH_NUMBER_FLAGS=0x01;
			modem_send_sms('p',MAIN_NUMBER,"Ваш номер установлен как главный");
			HUMAN_SET_EE=1;
			}
		}

	else if(strstr(uart3_an_buffer,"DEFAULT"))
		{
		if(HUMAN_SET_EE!=0x2222)
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
			
			memcpy(MAIN_NUMBER,"0000000000",10);
			memcpy(AUTH_NUMBER_1,"0000000000",10);
			memcpy(AUTH_NUMBER_2,"0000000000",10);
			memcpy(AUTH_NUMBER_3,"0000000000",10);
			AUTH_NUMBER_FLAGS=0x00;
			
			HUMAN_SET_EE!=0x2222;
			}
		}
	else if(strstr(uart3_an_buffer,"INTER"))
		{
		if(ind!=iAir)
			{
			tree_up(iInterf,0,0,0);
			}
		}				
	else if(strstr(uart3_an_buffer,"INTE_RET"))
		{
		if(ind==iAir)
			{
			tree_down(0,0);
			}
		}			
	}	
	enableInterrupts();
}

