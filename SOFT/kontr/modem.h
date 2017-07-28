
extern char modemStatCnt0;

extern signed char modemPowerStatCnt;			//Счетчик антидребезга светодиода питания модема

typedef enum {MPS_POWEROFF, MPS_POWERON}enum_modemPowerState;
extern enum_modemPowerState modemPowerState;	//Состояние питания модема

extern signed char net_l_cnt_up,net_l_cnt_down;			//Счетчики антидребезга светодиода линка
extern short net_l_cnt_one, net_l_cnt_zero, net_l_cnt_one_temp; 	//Счетчики свечения светодиода линка
typedef enum {MLS_UNKNOWN, MLS_UNLINKED, MLS_LINKED, MLS_GPRS}enum_modemLinkState;
extern enum_modemLinkState modemLinkState;		//Состояние подключения к провайдеру модема
typedef enum {MS_UNKNOWN, MS_POWEROFF, MS_UNLINKED, MS_LINKED, MS_GPRS, MS_LINKED_INITIALIZED}enum_modemState;
extern enum_modemState modemState;				//Состояние модема

extern signed char modemDrvPowerStartCnt;						//Счетчик 100мС-интервалов от включения питания 
extern signed short modemDrvInitStepCnt;						//Счетчик 100мС-шагов инициализации модема
extern signed short modemDrvTextSMSSendStepCnt;			//Счетчик 100мС-шагов отправки текстового СМС
extern signed short modemDrvPDUSMSSendStepCnt;			//Счетчик 100мС-шагов отправки PDU СМС
extern char *phoneNumberForSMS;											//Указатель на строку с номером телефона аддресата СМС
extern char *textSMS;																//Указатель не строку с текстом SMS
extern @near char textToSendSMS[200];								//Строка с текстом SMS
extern @near char numberToSendSMS[20];							//Строка с номером телефона адресата СМС
extern @near char numberToSendSMS_[20];							//Вспомогательная строка с номером телефона адресата СМС
extern @near char textToSendPDUSMS[70];							//Строка с текстом PDU SMS
extern @near char buferHeadToSendPDUSMS[30];				//Буфер с началом пакета PDU
extern @near char buferBodyToSendPDUSMS[350];				//Буфер с телом пакета PDU
extern @near short lenPDUSMS;												//Длина пакета PDU
extern @near char russianText[70];									//Буфер для преобразованного русского текста



/*
041E0422041F042004100412042C04220415002000370020042604180424042000200412042B0412041504140415041D041D042B04250020041D041000200418041D04140418041A04100422041E042000200423042104220420041E04190421042204120410002000280411041504170020041F0420041E04110415041B041E04120029

ОТПРАВЬТЕ 7 ЦИФР ВЫВЕДЕННЫХ НА ИНДИКАТОР УСТРОЙСТВА (БЕЗ ПРОБЕЛОВ)
*/

//-----------------------------------------------
void modem_gpio_init(void);
//-----------------------------------------------
//оценка текущего состояния модема
void modem_stat_drv(void);
//-----------------------------------------------
void modem_drv(void);
//-----------------------------------------------
void modem_send_sms(char mode, char *number, char *text);
//-----------------------------------------------
void text2PDU(char* text, char* adr);
//-----------------------------------------------
void PDU2text(char* text);
//-----------------------------------------------
//Поиск телефонного номера в тексте смс
char find_number_in_text(char* text, char* number);
