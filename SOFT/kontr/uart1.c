#include "stm8s.h"
#include "main.h"
#include "uart1.h"
#include <string.h>
#include <stdlib.h>

//-----------------------------------------------
@near char rxBuffer1[RX_BUFFER_1_SIZE];			//Приемный буфер UART1
@near char txBuffer1[TX_BUFFER_1_SIZE];			//Передающий буфер UART1
@near short rx_wr_index1;						//Указатель на следующий принимаемый байт
@near short tx_wr_index1;						//Указатель на следующую ячейку передающего ФИФО
@near short tx_rd_index1;						//Указатель на следующий отправляемый из ФИФО байт	
@near short tx_counter1;						//Счетчик заполненности передающего ФИФО
@near char uart1_an_buffer[100];				//Буфер для анализа принятых по UART3 строк
@near char bRXIN1;								//Индикатор принятой строки в uart3_an_buffer

//-----------------------------------------------
//Отладка
char uart1_plazma;
char modem_plazma;
//char *ptr1;
//char *ptr2;
//char *digi;

//-----------------------------------------------
void uart1_init (void)
{
GPIOA->DDR&=~(1<<4);	
GPIOA->CR1|=(1<<4);
GPIOA->CR2&=~(1<<4);

GPIOA->DDR|=(1<<5);	
GPIOA->CR1|=(1<<5);
GPIOA->CR2|=(1<<5);
	
UART1->CR1&=~UART1_CR1_M;
//UART1->CR2|= 0x0c;
UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
UART1->BRR2= 0x02;//0x03;
UART1->BRR1= 0x41;//0x68;
UART1->CR2|= UART3_CR2_TEN | UART1_CR2_REN | UART1_CR2_RIEN /*| UART1_CR2_TIEN*/;	
}

//***********************************************
@far @interrupt void UART1RxInterrupt (void) 
{
char rx_status1=UART1->SR;
char rx_data1=UART1->DR;
	
if (rx_status1 & (UART1_SR_RXNE))
	{
	if(rx_data1=='\r')
		{
		memset(uart1_an_buffer,'\0',100);
		memcpy(uart1_an_buffer,rxBuffer1,rx_wr_index1);
		bRXIN1=1;
		rx_wr_index1=0;
		}
	else if(rx_data1!='\n') 
		{
		rxBuffer1[rx_wr_index1++]=rx_data1;
		if(rx_wr_index1>=RX_BUFFER_1_SIZE)
			{
			rx_wr_index1=0;	
			}
		}
/*	cntAirSensorLineErrorHi=0;
	cntAirSensorLineErrorLo=0;
	if(airSensorErrorStat==taesLHI)airSensorErrorStat=taesNORM;
	if(airSensorErrorStat==taesLLO)airSensorErrorStat=taesNORM;*/
	}
}

//***********************************************
@far @interrupt void UART1TxInterrupt (void) 
{
if (tx_counter1)
	{
	--tx_counter1;
	UART1->DR=txBuffer1[tx_rd_index1];
	if (++tx_rd_index1 == TX_BUFFER_1_SIZE) tx_rd_index1=0;
	}
else 
	{
	//bOUT_FREE=1;
	UART1->CR2&= ~UART1_CR2_TIEN;
	}
}

//-----------------------------------------------
void putchar(char c)
{
while (tx_counter1 == TX_BUFFER_1_SIZE);

if (tx_counter1 || ((UART1->SR & UART1_SR_TXE)==0))
   {
   txBuffer1[tx_wr_index1]=c;
   if (++tx_wr_index1 == TX_BUFFER_1_SIZE) tx_wr_index1=0;
   ++tx_counter1;
   }
else UART1->DR=c;

UART1->CR2|= UART1_CR2_TIEN;
}

//-----------------------------------------------
void uart1_in_an (void)
{
if(!bRXIN1)return;

disableInterrupts();
bRXIN1=0;

if(strstr(uart1_an_buffer,"+CMT"))
	{
	char *ptr_temp;
	memcpy(ptr_temp,&uart1_an_buffer[7],12);
	if(strstr(ptr_temp,"+79139294352"))	modem_plazma++;
	
/*	if(strstr(uart1_an_buffer,"OK"))
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
		}	*/
	}		
enableInterrupts();
}

