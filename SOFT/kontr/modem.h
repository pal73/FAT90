
extern char modemStatCnt0;

extern signed char modemPowerStatCnt;			//Счетчик антидребезга светодиода питания модема

typedef enum {MPS_POWEROFF, MPS_POWERON}enum_modemPowerState;
extern enum_modemPowerState modemPowerState;	//Состояние питания модема

extern signed char net_l_cnt_up,net_l_cnt_down;			//Счетчики антидребезга светодиода линка
extern short net_l_cnt_one, net_l_cnt_zero, net_l_cnt_one_temp; 	//Счетчики свечения светодиода линка
typedef enum {MLS_UNKNOWN, MLS_UNLINKED, MLS_LINKED, MLS_GPRS}enum_modemLinkState;
extern enum_modemLinkState modemLinkState;		//Состояние подключения к провайдеру модема
typedef enum {MS_UNKNOWN, MS_POWEROFF, MS_UNLINKED, MS_LINKED, MS_GPRS}enum_modemState;
extern enum_modemState modemState;				//Состояние модема

//-----------------------------------------------
void modem_gpio_init(void);
//-----------------------------------------------
//оценка текущего состояния модема
void modem_stat_drv(void);
