#include "stm8s.h"
#include "main.h"
#include "uart1.h"
#include <string.h>
#include <stdlib.h>
#include "modem.h"
#include <stdio.h>
#include "lowlev.h"
#include "ds18b20.h"
#include "next_version.h"

//-----------------------------------------------
@near char rxBuffer1[RX_BUFFER_1_SIZE];				//Приемный буфер UART1
@near char txBuffer1[TX_BUFFER_1_SIZE];				//Передающий буфер UART1
@near short rx_wr_index1;							//Указатель на следующий принимаемый байт
@near short tx_wr_index1;							//Указатель на следующую ячейку передающего ФИФО
@near short tx_rd_index1;							//Указатель на следующий отправляемый из ФИФО байт	
@near short tx_counter1;							//Счетчик заполненности передающего ФИФО
@near char uart1_an_buffer[350];					//Буфер для анализа принятых по UART1 строк
@near char bRXIN1;									//Индикатор принятой строки в uart1_an_buffer
@near char incommingNumber[10];						//Буфер для хранения номера отправителя пришедшей смс
@near char incommingNumberToMain[10];				//Буфер для хранения номера просящегося в главные
@near char incommingNumberUSSDRequ[10];				//Буфер для хранения номера приславшео USSD запрос


bool isFromMainNumberMess;							//флаг, пришедшее смс от мастерского телефона
bool isFromAutorizedNumberMess;						//флаг, пришедшее смс от одного из прописанных немастерских телефонов
bool isFromNotAutorizedNumberMess;					//флаг, пришедшее смс от неавторизованного телефона
bool bOK;											//Модем ответил "OK"
bool bERROR;										//Модем ответил "ERROR"
bool bINITIALIZED;									//Модем инициализирован
char ussdRequ;										//Был USSD запрос
char bCBC;												//модем ответил CBC

bool bBUY_SMS;											//Прощальное SMS ушло
@near char cbcRequ;										//Был запрос состояния аккумулятора

@near char* number_temp;
@near short cell;
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
		
		if(rx_wr_index1>=1)
			{
			cntAirSensorLineErrorLo=0;	
			}		
/*	cntAirSensorLineErrorHi=0;
	
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
disableInterrupts();
if (tx_counter1 || ((UART1->SR & UART1_SR_TXE)==0))
   {
   txBuffer1[tx_wr_index1]=c;
   if (++tx_wr_index1 == TX_BUFFER_1_SIZE) tx_wr_index1=0;
   ++tx_counter1;
   }
else UART1->DR=c;
enableInterrupts();
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

else if(strstr(uart1_an_buffer,"UNDER-VOLTAGE WARNNING"))
	{
	//tree_up(iAfterReset,0,0,0);
	//printf("AT + CPOWD = 1 \r");
	//printf("AT + CBC \r");
	modemDrvPowerDownStepCnt=1;
	}
	
else if(strstr(uart1_an_buffer,"CBC"))
	{
	char* ptr1;
	char* ptr2;
	//char volatile ptr_temp[15];
	ptr1=strstr(uart1_an_buffer,",");
	ptr1++;
	ptr2=strstr(ptr1,",");
	ptr2++;
	memset(cbc_temp,'\0',15);
	memcpy(cbc_temp,ptr2,1);
	memcpy(cbc_temp+1,".",1);
	memcpy(cbc_temp+2,ptr2+1,3);
	memset(cbc_temp1,'\0',15);
	memcpy(cbc_temp1,ptr2,4);
	
	cbcVoltage=(short)strtol(cbc_temp1,NULL,0);

//memset(cbc_temp,'\0',15);
//memcpy(cbc_temp,"7654",5);
	
	//sprintf(tempRussianText,"Напряжение аккумулятора %sв, система выключена до появления сети",ptr_temp);
	//modem_send_sms('p',MAIN_NUMBER,tempRussianText);
	//printf(ptr_temp);
	
	if(bCBC==1)bCBC=2;
	if(bCBC_SELF==1)bCBC_SELF=2;
	
	}
else if((strstr(uart1_an_buffer,"CUSD"))&&(ussdRequ))
	{
	char* ptr1;
	char* ptr2;
	ptr1=strstr(uart1_an_buffer,"\"");
	ptr1++;
	if((*(ptr1))=='0')
		{
		strncpy(tempRussianText,ptr1,80);
		PDU2text(tempRussianText);
		modem_send_sms('p',incommingNumberUSSDRequ,russianText);
		}
	else
		{	
		ptr2=strstr(ptr1,"\"");
		strncpy(tempRussianText,ptr1,/*(unsigned char)(ptr2-ptr1)*/40);
		tempRussianText[40/*(unsigned char)(ptr2-ptr1)*/]=0;
		modem_send_sms('p',incommingNumberUSSDRequ,tempRussianText);
		}
	if(ussdRequ)ussdRequ--;	
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
		//modem_plazma++;
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
		modem_plazma++;
		PDU2text(uart1_an_buffer); 	//Пропускаем все пришедшие смс через парсер PDU
		
		if(strstr(russianText,"НОМЕР ГЛАВНЫЙ")) //Установить главный номер
			{
			//modem_plazma1++;
			memcpy(incommingNumberToMain,incommingNumber,10);
			modem_send_sms('p',incommingNumber,"Отправьте в ответном смс 7 цифр выведенных на индикатор устройства");/**/
			tree_up(iMn_number,0,0,0);
			rand_dig[0]=(rand()%10);
			rand_dig[1]=(rand()%10);
			rand_dig[2]=(rand()%10);
			rand_dig[3]=(rand()%10);
			rand_dig[4]=(rand()%10);
			rand_dig[5]=(rand()%10);
			rand_dig[6]=(rand()%10);
			sprintf(rand_dig_str,"%d%d%d%d%d%d%d",(int)rand_dig[0],(int)rand_dig[1],(int)rand_dig[2],(int)rand_dig[3],(int)rand_dig[4],(int)rand_dig[5],(int)rand_dig[6]);
			ret_ind(120,0);
			}
		else if(strstr(uart1_an_buffer,rand_dig_str/*"1234576"*/))
			{
			if(memcmp(incommingNumber,incommingNumberToMain,10)==0)
				{
				memcpy(MAIN_NUMBER,incommingNumberToMain,10);
				AUTH_NUMBER_FLAGS=0x01;
				modem_send_sms('p',MAIN_NUMBER,"Ваш номер установлен как главный");
				tree_down(0,0);
				ind=iMn;
				ret_ind(0,0);
				}
			}
		else if((strstr(russianText,"НОМЕР"))&&(isFromMainNumberMess)) //"Установить номер
			{
			number_temp=find_number_in_text(russianText);
			if(number_temp)
				{
				if(find_this_number_in_autorized(number_temp)) 
					{
					modem_send_sms('p',MAIN_NUMBER,"Такой номер уже есть в списке авторизованых");
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
					sprintf(tempRussianText,"Номер %s добавлен в список (ячейка %d)",number_temp,cell);
					modem_send_sms('p',MAIN_NUMBER,tempRussianText);
					sprintf(tempRussianText,"Ваш номер добавлен в список ");
					modem_send_sms('p',number_temp,tempRussianText);

					}
				else
					{
					modem_send_sms('p',MAIN_NUMBER,"Номер не добавлен, память заполнена");
					}
				}
			
			//modem_plazma1++;
			//modem_send_sms('t',"9139294352",/*"OTPRAVTE 7 CIFR, VIVEDENNIH NA EKRAN USTROISTVA"*/"mama1");
			}
		else if((strstr(russianText,"СПИСОК"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Список телефонов
			{
			
			sprintf(tempRussianText,"Список:\n"); //номеров\n
			//strcat(tempRussianText,"+7");
			strncat(tempRussianText,MAIN_NUMBER,10);
			strcat(tempRussianText," (гл.)\n");
			//strcpy(tempRussianText,tempStr);
			//sprintf(tempStr,"%s (главн),",MAIN_NUMBER);
			//strcat(tempRussianText,tempStr);
			if(AUTH_NUMBER_FLAGS&0x02)
				{
				//strcat(tempRussianText,",\r\n+7");
				strncat(tempRussianText,AUTH_NUMBER_1,10);
				strcat(tempRussianText," (1)\n");	
				}
			if(AUTH_NUMBER_FLAGS&0x04)
				{
				//strcat(tempRussianText,",\r\n+7");
				strncat(tempRussianText,AUTH_NUMBER_2,10);
				strcat(tempRussianText," (2)\n");	
				}
			if(AUTH_NUMBER_FLAGS&0x08)
				{
				//strcat(tempRussianText,",\r\n+7");
				strncat(tempRussianText,AUTH_NUMBER_3,10);
				strcat(tempRussianText," (3)");	
				}
			modem_send_sms('p',incommingNumber,tempRussianText);
			}
			
		else if((strstr(russianText,"УДАЛИТЬ"))&&(isFromMainNumberMess)) //Удаление номеров
			{
			if(strstr(russianText,"ВСЕ"))
				{
				if(AUTH_NUMBER_FLAGS&0x0e)
					{
					AUTH_NUMBER_FLAGS&=0x01;
				
					modem_send_sms('p',MAIN_NUMBER,"Все номера кроме главного удалены");
					}
				else
					{
					modem_send_sms('p',MAIN_NUMBER,"В списке нет номеров кроме главного");
					}
				}
			else if(find_number_in_text(russianText))
				{
				number_temp=find_number_in_text(russianText);
				if(find_this_number_in_autorized(number_temp))
					{
					char temp=find_this_number_in_autorized(number_temp);
					AUTH_NUMBER_FLAGS&=(char)(~(1<<temp));
					strcpy(tempRussianText,"Номер ");
					strncat(tempRussianText,number_temp,10);
					strcat(tempRussianText," удален из списка номеров");
					modem_send_sms('p',MAIN_NUMBER,tempRussianText);
					}
				else modem_send_sms('p',MAIN_NUMBER,"Такого номера нет в списке");
				}
			}

		else if((strstr(russianText,"УСТАВКИ"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //УСТАВКИ
			{
			if(MODE_EE==1)
				{
				sprintf(tempRussianText,"Режим - по воде\nуставка %dгр.\nмакс.мощность %d",(int)targetTemper,(int)MAX_POWER_EE);
				}
			if(MODE_EE==2)
				{
				sprintf(tempRussianText,"Режим - по воздуху\nуставка %dгр.\nмакс.мощность %d",(int)targetTemper,(int)MAX_POWER_EE);
				}
			if(MODE_EE==3)
				{
				sprintf(tempRussianText,"Режим - по графику\nтекущая уставка %dгр.(воздух)\nмакс.мощность %d",(int)targetTemper,(int)MAX_POWER_EE);
				}				

			modem_send_sms('p',incommingNumber,tempRussianText);
			}

		else if((strstr(russianText,"РЕЖИМ"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Установка режима работы
			{
			if(strstr(russianText,"ВОДА"))
				{
				MODE_EE=1;
				modem_send_sms('p',incommingNumber,"Установлен режим регулирования по температуре воды");
				}
			else if(strstr(russianText,"ВОЗДУХ"))
				{
				MODE_EE=2;
				modem_send_sms('p',incommingNumber,"Установлен режим регулирования по температуре воздуха");
				}
			else
				{
				modem_send_sms('p',incommingNumber,"Команда не распознана");
				}				

//%			modem_send_sms('p',incommingNumber,tempRussianText);
			}
			
		else if((strstr(russianText,"ВОДА"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Установка температуры воды
			{
			short tempSS=find_number_fild_in_text(russianText);	
				
			if(MODE_EE!=1)
				{
				modem_send_sms('p',incommingNumber,"В текущем режиме работы выполнение такой команды невозможно");	
				}
			else if((tempSS<5)||(tempSS>85))
				{
				modem_send_sms('p',incommingNumber,"Значение находится за пределами разрешенных(5-85).Команда отклонена");
				}
			else
				{
				NECC_TEMPER_WATER_EE=tempSS;
				sprintf(tempRussianText,"Температура воды установлена на %dгр.Ц.",(int)NECC_TEMPER_WATER_EE);
				modem_send_sms('p',incommingNumber,tempRussianText);
				}					
			}

		else if((strstr(russianText,"ВОЗДУХ"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Установка температуры воздуха
			{
			short tempSS=find_number_fild_in_text(russianText);	
				
			if(MODE_EE!=2)
				{
				modem_send_sms('p',incommingNumber,"В текущем режиме работы выполнение такой команды невозможно");	
				}
			else if((tempSS<5)||(tempSS>35))
				{
				modem_send_sms('p',incommingNumber,"Значение находится за пределами разрешенных(5-35).Команда отклонена");
				}
			else
				{
				NECC_TEMPER_AIR_EE=tempSS;
				sprintf(tempRussianText,"Температура воздуха установлена на %dгр.Ц.",(int)NECC_TEMPER_AIR_EE);
				modem_send_sms('p',incommingNumber,tempRussianText);
				}					
			}

		else if((strstr(russianText,"СТАТУС"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Запрос состояния системы
			{
			sprintf(tempStr,"Tвода %3dгр.Ц \n",(int)temperOfWater);
			if(waterSensorErrorStat == dsesNORM)strcpy(tempRussianText,tempStr);
			else strcpy(tempRussianText,"Tводы неиспр.\n");
			sprintf(tempStr,"Tвоздух %3dгр.Ц \n",(int)temperOfAir);
			if(airSensorErrorStat == taesNORM)strcat(tempRussianText,tempStr);
			else strcat(tempRussianText,"Tвоздуха неиспр.\n");
			if(powerAlarm == paNORM) strcat(tempRussianText,"Питание норма\n");
			else 					 strcat(tempRussianText,"Питание выкл.\n");
			if(outMode==omON)		 strcat(tempRussianText,"Термостат вкл.\n");
			else 					 strcat(tempRussianText,"Термостат выкл.\n");
			
			sprintf(tempStr,"Нагрев %1d",(int)powerEnabled);
			strcat(tempRussianText,tempStr);
			modem_send_sms('p',incommingNumber,tempRussianText);
			}
		else if((strstr(russianText,"ВЕРСИЯ"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Запрос версии прошивки
			{
			sprintf(tempRussianText,"Версия ПО %d.%03d",VERSION,BUILD);
			modem_send_sms('p',incommingNumber,tempRussianText);			
			}
		else if((strstr(uart1_an_buffer,"USSD"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Запрос версии прошивки
			{
			char* ppptr;
			ppptr=strstr(uart1_an_buffer,"USSD");
			ppptr+=4;
			sprintf(tempRussianText,"ATD%s\r\n",ppptr);
			
			printf(tempRussianText);
			//printf("ATD#100#;\r\n");
			memcpy(incommingNumberUSSDRequ,incommingNumber,10);
			ussdRequ=2;
			}
		else if((strstr(russianText,"АККУМУЛЯТОР"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Запрос состояния аккумулятора
			{
			printf("AT + CBC \r");
			cbcRequ=1;
			}
		else if((strstr(russianText,"ОТЛАДКА"))&&(isFromMainNumberMess||isFromAutorizedNumberMess)) //Запрос версии прошивки
			{
			sprintf(tempRussianText,"Версия ПО %d.%03d",VERSION,BUILD);
			modem_send_sms('p',incommingNumber,"Привет  0123456"/*tempRussianText*/);			
			}			


		isFromMainNumberMess=0;
		isFromAutorizedNumberMess=0;
		isFromNotAutorizedNumberMess=0;
		}
	}
enableInterrupts();
}

