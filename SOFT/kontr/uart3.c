#include "stm8s.h"
#include "main.h"
#include "uart3.h"
#include <string.h>
#include <stdlib.h>

//-----------------------------------------------
@near char rxBuffer3[RX_BUFFER_3_SIZE];			//Приемный буфер UART3
@near short rx_wr_index3;						//Указатель на следующий принимаемый байт
@near char uart3_an_buffer[100];				//Буфер для анализа принятых по UART3 строк
@near char bRXIN3;								//Индикатор принятой строки в uart3_an_buffer

//-----------------------------------------------
//Отладка
char uart3_plazma;

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
	}
}

//-----------------------------------------------
void uart3_in_an (void)
{
if(bRXIN3)
	{
	bRXIN3=0;
	
	if(strstr(uart3_an_buffer,"OK"))
		{
		char *ptr1=strstr(uart3_an_buffer,"OK");	
		char *ptr2=strstr(uart3_an_buffer,"CRC");
		char *digi;
		memcpy(digi,ptr1+2,ptr2-ptr1-2);
		
		temperOfAir=(signed char)atoi(digi);
		}
	}
}

