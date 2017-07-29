#include "stm8s.h"
#include "main.h"
#include "uart1.h"
#include <string.h>
#include <stdlib.h>
#include "modem.h"
#include <stdio.h>

//-----------------------------------------------
@near char rxBuffer1[RX_BUFFER_1_SIZE];			//�������� ����� UART1
@near char txBuffer1[TX_BUFFER_1_SIZE];			//���������� ����� UART1
@near short rx_wr_index1;										//��������� �� ��������� ����������� ����
@near short tx_wr_index1;										//��������� �� ��������� ������ ����������� ����
@near short tx_rd_index1;										//��������� �� ��������� ������������ �� ���� ����	
@near short tx_counter1;										//������� ������������� ����������� ����
@near char uart1_an_buffer[200];						//����� ��� ������� �������� �� UART1 �����
@near char bRXIN1;													//��������� �������� ������ � uart1_an_buffer
@near char incommingNumber[10];							//����� ��� �������� ������ ����������� ��������� ���
@near char incommingNumberToMain[10];				//����� ��� �������� ������ ����������� � �������

bool isFromMainNumberMess;									//����, ��������� ��� �� ����������� ��������
bool isFromAutorizedNumberMess;							//����, ��������� ��� �� ������ �� ����������� ������������ ���������
bool isFromNotAutorizedNumberMess;					//����, ��������� ��� �� ����������������� ��������
bool bOK;																		//����� ������� "OK"
bool bERROR;																	//����� ������� "ERROR"

@near char* number_temp;
@near short cell;
//-----------------------------------------------
//�������
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
	else if(rx_data1=='>') 
		{
		bOK=1;
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

if(strstr(uart1_an_buffer,"OK"))
	{
	bOK=1;
	}
else if(strstr(uart1_an_buffer,"ERROR"))
	{
	bERROR=1;
	}	
else if(strstr(uart1_an_buffer,"+CMT"))
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
	if((strstr(incommingNumber,str_main_num)!=NULL)&&(AUTH_NUMBER_FLAGS&0x01))
		{
		modem_plazma++;
		isFromMainNumberMess=1;
		}
		
	memset(str_main_num,'\0',15);
	memcpy(str_main_num,AUTH_NUMBER_1,10);
	
	if((strstr(incommingNumber,str_main_num)!=NULL)&&(AUTH_NUMBER_FLAGS&0x02))
		{
		//modem_plazma++;
		isFromAutorizedNumberMess=1;
		}		

	memset(str_main_num,'\0',15);
	memcpy(str_main_num,AUTH_NUMBER_2,10);
	
	if((strstr(incommingNumber,str_main_num)!=NULL)&&(AUTH_NUMBER_FLAGS&0x04))
		{
		//modem_plazma++;
		isFromAutorizedNumberMess=1;
		}		

	memset(str_main_num,'\0',15);
	memcpy(str_main_num,AUTH_NUMBER_3,10);
	
	if((strstr(incommingNumber,str_main_num)!=NULL)&&(AUTH_NUMBER_FLAGS&0x08))
		{
		//modem_plazma++;
		isFromAutorizedNumberMess=1;
		}

	if((isFromMainNumberMess==0)&&(isFromAutorizedNumberMess==0)) isFromNotAutorizedNumberMess=1;
	}	
else
	{
	//modem_plazma1++;
	if((isFromMainNumberMess)||(isFromAutorizedNumberMess)||(isFromNotAutorizedNumberMess))
		{
			modem_plazma1++;
		PDU2text(uart1_an_buffer); 	//���������� ��� ��������� ��� ����� ������ PDU
		
		if(strstr(russianText,"����� �������")) //"0423042104220410041D041E041204180422042C00200413041B04100412041D042B0419"
			{
			//modem_plazma1++;
			memcpy(incommingNumberToMain,incommingNumber,10);
			modem_send_sms('p',incommingNumber,"��������� � �������� ��� 7 ���� ���������� �� ��������� ����������");/**/
			
			}
		else if(strstr(uart1_an_buffer,"1234576"))
			{
			if(memcmp(incommingNumber,incommingNumberToMain,10)==0)
				{
				memcpy(MAIN_NUMBER,incommingNumberToMain,10);
				AUTH_NUMBER_FLAGS=0x01;
				modem_send_sms('p',MAIN_NUMBER,"��� ����� ���������� ��� �������");
				}
			}
		else if((strstr(russianText,"�����"))&&(isFromMainNumberMess)) //"���������� �����
			{
			number_temp=find_number_in_text(russianText);
			if(number_temp)
				{
				if(find_this_number_in_autorized(number_temp)) 
					{
					modem_send_sms('p',MAIN_NUMBER,"����� ����� ��� ���� � ������ �������������");
					}
				else if(find_empty_number_cell())
					{
					cell = find_empty_number_cell();
					if(cell==1)
						{
						memcpy(AUTH_NUMBER_1,number_temp,10);
						AUTH_NUMBER_FLAGS|=0b00000010;
						}
					else if(cell==2)
						{
						memcpy(AUTH_NUMBER_2,number_temp,10);
						AUTH_NUMBER_FLAGS|=0b00000100;							
						}
					else if(cell==3)
						{
						memcpy(AUTH_NUMBER_3,number_temp,10);
						AUTH_NUMBER_FLAGS|=0b00001000;							
						}
					sprintf(tempRussianText,"����� %s �������� � ������ (������ %d)",number_temp,cell);
					modem_send_sms('p',MAIN_NUMBER,tempRussianText);
					sprintf(tempRussianText,"��� ����� �������� � ������ ");
					modem_send_sms('p',number_temp,tempRussianText);

					}
				else
					{
					modem_send_sms('p',MAIN_NUMBER,"����� �� ��������, ������ ���������");
					}
				}
			
			//modem_plazma1++;
			//modem_send_sms('t',"9139294352",/*"OTPRAVTE 7 CIFR, VIVEDENNIH NA EKRAN USTROISTVA"*/"mama1");
			}
		else if((strstr(russianText,"������"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //������ ���������
			{
			
			sprintf(tempRussianText,"������ �������: \r\n");
			strcat(tempRussianText,"+7");
			strcat(tempRussianText,MAIN_NUMBER);
			strcat(tempRussianText," (�������)");
			//strcpy(tempRussianText,tempStr);
			//sprintf(tempStr,"%s (�������),",MAIN_NUMBER);
			//strcat(tempRussianText,tempStr);
			/*if(AUTH_NUMBER_FLAGS&0x01)
				{
				strcat(tempRussianText,",\r\n+7");
				strcat(tempRussianText,AUTH_NUMBER_1);
				strcat(tempRussianText,"(1)");	
				}*/
			/*if(AUTH_NUMBER_FLAGS&0x02)
				{
				sprintf(tempStr,"+7%s (1),",AUTH_NUMBER_2);
				strcat(tempRussianText,tempStr);	
				}
			if(AUTH_NUMBER_FLAGS&0x04)
				{
				sprintf(tempStr,"+7%s (1),",AUTH_NUMBER_3);
				strcat(tempRussianText,tempStr);	
				}*/
			modem_send_sms('p',MAIN_NUMBER,tempRussianText);
			}
		isFromMainNumberMess=0;
		isFromAutorizedNumberMess=0;
		isFromNotAutorizedNumberMess=0;
		}
	}
enableInterrupts();
}

