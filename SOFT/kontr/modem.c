//#include "main.h"
#include "stm8s.h"
#include "modem.h"
#include <stdio.h>
#include <string.h>

char modemStatCnt0;

signed char modemPowerStatCnt;						//Счетчик антидребезга светодиода питания модема
enum_modemPowerState modemPowerState=MPS_POWEROFF;	//Состояние питания модема
signed char net_l_cnt_up,net_l_cnt_down;			//Счетчики антидребезга светодиода линка
short net_l_cnt_one, net_l_cnt_zero, net_l_cnt_one_temp; 	//Счетчики свечения светодиода линка
enum_modemLinkState modemLinkState=MLS_UNKNOWN;		//Состояние подключения к провайдеру модема
enum_modemState modemState=MS_UNKNOWN;				//Состояние модема

signed char modemDrvPowerStartCnt=0;					//Счетчик 100мС-интервалов от включения питания 
signed short modemDrvInitStepCnt=0;						//Счетчик 100мС-шагов инициализации модема
signed short modemDrvTextSMSSendStepCnt=0;			//Счетчик 100мС-шагов отправки текстового СМС
signed short modemDrvPDUSMSSendStepCnt=0;				//Счетчик 100мС-шагов отправки PDU СМС
char *phoneNumberForSMS;											//Указатель на строку с номером телефона аддресата СМС
char *textSMS;																//Указатель не строку с текстом SMS
@near char textToSendSMS[200];								//Строка с текстом SMS
@near char numberToSendSMS[20];								//Строка с номером телефона адресата СМС
@near char numberToSendSMS_[20];							//Вспомогательная строка с номером телефона адресата СМС
@near char textToSendPDUSMS[70];							//Строка с текстом PDU SMS
@near char buferHeadToSendPDUSMS[30];					//Буфер с началом пакета PDU
@near char buferBodyToSendPDUSMS[350];				//Буфер с телом пакета PDU
@near char buferBodyToSendPDUSMS__[100];				//Буфер с телом пакета PDU
@near short lenPDUSMS;													//Длина пакета PDU 
@near char ptrTemp[30];

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
disableInterrupts();

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
		
	if(modemDrvTextSMSSendStepCnt)	//отправка текстового СМС
		{
		if(modemDrvTextSMSSendStepCnt==11)
			{
			printf("AT+CMGF=1\r");
			modemDrvTextSMSSendStepCnt++;
			}
		else if(modemDrvTextSMSSendStepCnt==21)
			{

			ptrTemp[0]='\0';
			strcat(ptrTemp,"AT + CMGS = \"");
			strcat(ptrTemp,numberToSendSMS);
			strcat(ptrTemp,"\"\r");
			printf(ptrTemp);			///*"AT + CMGS = \"" + numberToSendSMS +/*+79139294352*/ "\"\r"*/

			modemDrvTextSMSSendStepCnt++;
			}	
		else if(modemDrvTextSMSSendStepCnt==31)
			{
			//printf("PRIVET\r");
			printf(textToSendSMS);
			modemDrvTextSMSSendStepCnt++;
			}		
		else if(modemDrvTextSMSSendStepCnt==41)
			{
			printf("%c",(char)26);
			modemDrvTextSMSSendStepCnt=0;
			}				
		else
			{
			if(modemDrvTextSMSSendStepCnt<1000)	modemDrvTextSMSSendStepCnt++;
			}			
		}
		
	if(modemDrvPDUSMSSendStepCnt)	//отправка PDU СМС
		{
		if(modemDrvPDUSMSSendStepCnt==11)
			{
			printf("AT+CMGF=0\r");
			modemDrvPDUSMSSendStepCnt++;
			}
		else if(modemDrvPDUSMSSendStepCnt==21)
			{

			//ptrTemp[0]='\0';
			//lenPDUSMS=15;
			//sprintf(ptrTemp,"AT + CMGS = %d \r",lenPDUSMS);
			printf("AT + CMGS = %d \r",lenPDUSMS);
			//printf(ptrTemp);			

			modemDrvPDUSMSSendStepCnt++;
			}	
		else if(modemDrvPDUSMSSendStepCnt==31)
			{
			//printf("PRIVET\r");
			printf(buferHeadToSendPDUSMS);
			//printf(buferBodyToSendPDUSMS);
			//printf("A1K");
			memcpy(buferBodyToSendPDUSMS__,buferBodyToSendPDUSMS,75);
			buferBodyToSendPDUSMS__[75]='\0';
			printf(buferBodyToSendPDUSMS__);
			//printf("A2K");
			memcpy(buferBodyToSendPDUSMS__,&buferBodyToSendPDUSMS[75],75);
			buferBodyToSendPDUSMS__[75]='\0';
			printf(buferBodyToSendPDUSMS__);
			//printf("A3K");
			memcpy(buferBodyToSendPDUSMS__,&buferBodyToSendPDUSMS[150],75);
			buferBodyToSendPDUSMS__[75]='\0';
			printf(buferBodyToSendPDUSMS__);
			//printf("A4K");
			memcpy(buferBodyToSendPDUSMS__,&buferBodyToSendPDUSMS[225],75);
			buferBodyToSendPDUSMS__[75]='\0';
			printf(buferBodyToSendPDUSMS__);/**/
			memcpy(buferBodyToSendPDUSMS__,&buferBodyToSendPDUSMS[300],50);
			buferBodyToSendPDUSMS__[50]='\0';
			printf(buferBodyToSendPDUSMS__);
			//printf("A5K");
			printf("%c",(char)26);
			modemDrvPDUSMSSendStepCnt=0;
			}		
	
		else
			{
			if(modemDrvPDUSMSSendStepCnt<1000)	modemDrvPDUSMSSendStepCnt++;
			}			
		}		
	}
enableInterrupts();
}

//-----------------------------------------------
void modem_send_sms(char mode, char *number, char *text)
{
if(mode=='t')
	{
	disableInterrupts();
	numberToSendSMS[0]='\0';
	strcat(numberToSendSMS,"+7");
	strcat(numberToSendSMS,number);
	
	textToSendSMS[0]='\0';
	strcat(textToSendSMS,text);
	strcat(textToSendSMS,"\r");
	
	modemDrvTextSMSSendStepCnt=1;
	enableInterrupts();
	}
else if(mode=='p')
	{
	disableInterrupts();
	
	numberToSendSMS_[0]=number[0];
	numberToSendSMS_[1]='7';
	numberToSendSMS_[2]=number[2];
	numberToSendSMS_[3]=number[1];
	numberToSendSMS_[4]=number[4];
	numberToSendSMS_[5]=number[3];
	numberToSendSMS_[6]=number[6];
	numberToSendSMS_[7]=number[5];
	numberToSendSMS_[8]=number[8];
	numberToSendSMS_[9]=number[7];
	numberToSendSMS_[10]='F';
	numberToSendSMS_[11]=number[9];	
	numberToSendSMS_[12]='\0';
	
	buferHeadToSendPDUSMS[0]='\0';
	strcat(buferHeadToSendPDUSMS,"0001000B91");
	strcat(buferHeadToSendPDUSMS,numberToSendSMS_);
	strcat(buferHeadToSendPDUSMS,"0008");
	//strcat(buferToSendPDUSMS,"000810041F0440043804320435044200210021");
	text2PDU(text,buferBodyToSendPDUSMS);
	/*Это максимальная смска в ПДУ режиме
	strcpy(buferBodyToSendPDUSMS,"8C0410041004100410041004100410041004100410041004100410041004100411041204100410041004100410041004130414041504160410041004100410041704100410041704100413041404150416041004130414041504160410041304140415041604100413041404150416041004130414041504160410041304140415041604100413041404150416");//
	lenPDUSMS=153;*/
	modemDrvPDUSMSSendStepCnt=1;
/*	printf("4004100410041004100410041004100410041004100410041004100410041004110412041004100410041004100410041304140415041604100410041004100417041004100410");*/
	enableInterrupts();
	
		//printf("ABCDEFGHIJKLMN1ABCDEFGHIJKLMN2ABCDEFGHIJKLMN3ABCDEFGHIJKLMN4ABCDEFGHIJKLMN5");
	//printf("ABCDEFGHIJKLMN6ABCDEFGHIJKLMN7ABCDEFGHIJKLMN8ABCDEFGHIJKLMN9");
	}
}

//-----------------------------------------------
void text2PDU(char* text, char* adr)
{
char temp_buf[2];
char i=0;
lenPDUSMS=0;
strcpy(adr,"00");
while(1)
	{
	char c = text[i];
	if(c==0)break;
	else if(c<0x7f)
		{
		char temp[6];
		sprintf(temp,"%04X",(short)c);
		strcat(adr,temp);
		}
	else 	
		{
		char temp[6];
		sprintf(temp,"%04X",(short)c+0x0350);
		strcat(adr,temp);
		}
	lenPDUSMS+=2;
	i++;
	}
sprintf(temp_buf,"%02X",lenPDUSMS);
//strcat(adr,"04C1");
memcpy(adr,temp_buf,2);

lenPDUSMS+=13;

//return ret;
}

