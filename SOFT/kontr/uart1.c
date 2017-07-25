#include "stm8s.h"
#include "main.h"
#include "uart1.h"
#include <string.h>
#include <stdlib.h>
#include "modem.h"

//-----------------------------------------------
@near char rxBuffer1[RX_BUFFER_1_SIZE];			//Приемный буфер UART1
@near char txBuffer1[TX_BUFFER_1_SIZE];			//Передающий буфер UART1
@near short rx_wr_index1;										//Указатель на следующий принимаемый байт
@near short tx_wr_index1;										//Указатель на следующую ячейку передающего ФИФО
@near short tx_rd_index1;										//Указатель на следующий отправляемый из ФИФО байт	
@near short tx_counter1;										//Счетчик заполненности передающего ФИФО
@near char uart1_an_buffer[200];						//Буфер для анализа принятых по UART1 строк
@near char bRXIN1;													//Индикатор принятой строки в uart1_an_buffer
@near char incommingNumber[10];							//Буфер для хранения номера отправителя пришедшей смс
@near char incommingNumberToMain[10];				//Буфер для хранения номера просящегося в главные

bool isFromMainNumberMess;									//флаг, пришедшее смс от мастерского телефона
bool isFromAutorizedNumberMess;							//флаг, пришедшее смс от одного из прописанных немастерских телефонов
bool isFromNotAutorizedNumberMess;					//флаг, пришедшее смс от неавторизованного телефона

//-----------------------------------------------
//Отладка
@near char uart1_plazma;
@near char modem_plazma;
@near char modem_plazma1;
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
		memset(uart1_an_buffer,'\0',200);
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
	char volatile ptr_temp[15];
	char volatile str_main_num[15];
	char *ptrptr;
	
	isFromMainNumberMess=0;
	isFromAutorizedNumberMess=0;
	isFromNotAutorizedNumberMess=0;
	
	ptrptr=strstr(uart1_an_buffer,"+7");
	memcpy(incommingNumber,ptrptr+2,10);
	
	memset(ptr_temp,'\0',15);
	memcpy(ptr_temp,&uart1_an_buffer[6],14);
	
	memset(str_main_num,'\0',15);
	memcpy(str_main_num,/*"9139294352"*/MAIN_NUMBER,10);
	
	//if(strcmp(ptr_temp,str_main_num)==0)
	if(strstr(incommingNumber,str_main_num)!=NULL)
		{
		modem_plazma++;
		isFromMainNumberMess=1;
		}
		
	memset(str_main_num,'\0',15);
	memcpy(str_main_num,AUTH_NUMBER_1,10);
	
	if(strstr(incommingNumber,str_main_num)!=NULL)
		{
		modem_plazma++;
		isFromAutorizedNumberMess=1;
		}		

	memset(str_main_num,'\0',15);
	memcpy(str_main_num,AUTH_NUMBER_2,10);
	
	if(strstr(incommingNumber,str_main_num)!=NULL)
		{
		modem_plazma++;
		isFromAutorizedNumberMess=1;
		}		

	memset(str_main_num,'\0',15);
	memcpy(str_main_num,AUTH_NUMBER_3,10);
	
	if(strstr(incommingNumber,str_main_num)!=NULL)
		{
		modem_plazma++;
		isFromAutorizedNumberMess=1;
		}

	if((isFromMainNumberMess==0)&&(isFromAutorizedNumberMess==0)) isFromNotAutorizedNumberMess=1;
	}	
else
	{
	if((isFromMainNumberMess)||(isFromAutorizedNumberMess)||(isFromNotAutorizedNumberMess))
		{
		//char *ptr_temp;
		//strcpy(ptr_temp,uart1_an_buffer);
		
		if(strstr(uart1_an_buffer,"0423042104220410041D041E041204180422042C00200413041B04100412041D042B0419")) //"УСТАНОВИТЬ ГЛАВНЫЙ"
			{
			modem_plazma1++;
			memcpy(incommingNumberToMain,incommingNumber,10);
			modem_send_sms('t',incommingNumber/*"9139294352"*/,"OTPRAVTE 7 CIFR, VIVEDENNIH NA EKRAN USTROISTVA");
			
			}
		else if(strstr(uart1_an_buffer,"1234576"))
			{
			if(memcmp(incommingNumber,incommingNumberToMain,10)==0)
				{
				modem_send_sms('t',incommingNumber,"OK");
				memcpy(MAIN_NUMBER,incommingNumberToMain,10);
				AUTH_NUMBER_FLAGS|=0x01;
				}
			}
		else if(strstr(uart1_an_buffer,"123")) //"УСТАНОВИТЬ ГЛАВНЫЙ"
			{
			//modem_plazma1++;
			modem_send_sms('t',"9139294352",/*"OTPRAVTE 7 CIFR, VIVEDENNIH NA EKRAN USTROISTVA"*/"mama1");
			}	
		isFromMainNumberMess=0;
		isFromAutorizedNumberMess=0;
		isFromNotAutorizedNumberMess=0;
		}
	}
enableInterrupts();
}

