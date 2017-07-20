#define DS18B20PORT	GPIOD
#define DS18B20PIN	7

#define _FLASH_IAPSR FLASH->IAPSR
//-----------------------------------------------
//Переменные в EEPROM
@eeprom extern char						MAIN_NUMBER[10];			//Ячейка для хранения номера мастера
@eeprom extern char						AUTH_NUMBER_1[10];		//Ячейка для хранения номера первого авторизованого телефона
@eeprom extern signed short		HUMAN_SET_EE; 				//подпись человека (0x1234)
@eeprom extern signed char	  NECC_TEMPER_AIR_EE; 	//температура поддержания воздуха
@eeprom extern signed char		NECC_TEMPER_WATER_EE;	//температура поддержания воды
@eeprom extern signed char 		MODE_EE;							//режим работы устройства (1 - по воде, 2 - по воздуху, 3 - по графику) 
@eeprom extern signed char 		MAX_POWER_EE;					//максимальная мощность нагревания 
@eeprom extern char						AUTH_NUMBER_2[10];		//Ячейка для хранения номера второго авторизованого телефона
@eeprom extern char						AUTH_NUMBER_3[10];		//Ячейка для хранения номера третьего авторизованого телефона

//-----------------------------------------------
//Порядок включения ТЭНов в зависимости от случайного числа
extern const char warmOrder[6][3];
extern char currRandom,fiksRandom;

//-----------------------------------------------
//Временная сетка
//extern bool b100Hz,b10Hz,b5Hz,b2Hz,b1Hz;
extern char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;
extern signed char mainCnt;

//-----------------------------------------------
//Индикация
extern char ind_cnt;
extern char ind_outB[12];
extern char ind_outC[12];
extern char ind_outG[12];
extern const char ind_strob[12];
extern char dig[10];
extern char ind_out_[5];
extern const char DIGISYM[30];
//***********************************************
//Eiaeeaoey
typedef enum 
	{
	iMn,iSet,iSet_,iSetT,iDate_W,iSetTable,iSetTable_,iDeb,iTemperSet,iDefSet,
	iModem_deb
	} ind_enum;
	
typedef struct  
{
ind_enum i;
signed char s_i;
signed char s_i1;
signed char s_i2;
signed char i_s;
} struct_ind;
extern struct_ind a_ind,b_ind[10],c_ind;
extern signed char ind_pointer;

#define ind     		a_ind.i
#define sub_ind     	a_ind.s_i
#define sub_ind1     	a_ind.s_i1
#define sub_ind2     	a_ind.s_i2
#define index_set     	a_ind.i_s
extern bool zero_on;
extern bool bFL5,bFL2,bFL1,bFL_;
extern char led_ind_out1,led_ind_out2;


//-----------------------------------------------
//Управление выходом
typedef enum {osOFF,osON}enum_out_stat;
extern enum_out_stat out_stat[3],out_mode;

#define butON	254
#define butM	253
#define butU	251
#define butD	247
#define butUD	243
#define butON_	126
#define butM_	125
#define butU_	123
#define butD_	119
#define butUD_	115
#define butMD_	117
#define butOND_	118
#define butMU_	121

//-----------------------------------------------
//Температура
extern signed char 	temperOfWater;
extern signed char	temperOfAir;
extern signed char 	temperToReg;
typedef enum {taesNORM=0x55,taesHI=1,taesLO=0,taesLHI=3,taesLLO=2} enumTemperOfAirErrorStat; 
extern enumTemperOfAirErrorStat airSensorErrorStat;

//-----------------------------------------------
//Время
extern char buff_for_time[10];
extern char time_sec;
extern char time_min;
extern char time_hour;
extern char time_day_of_week;
extern char time_month;
extern char time_year;

//-----------------------------------------------
//Регулирование мощности
extern signed char powerNecc,powerNeccOld;
extern signed char powerNeccDelta;

//-----------------------------------------------
//Зуммер
extern signed char beep_drv_cnt;

//-----------------------------------------------
//Ошибки
extern bool bERR;	//серьезная ошибка
extern bool bWARN; //предупреждение

//-----------------------------------------------
//Исправность линии воздушного датчика
extern char cntAirSensorLineErrorLo;
extern char cntAirSensorLineErrorHi;
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//отладка
//extern char random_plazma;
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//-----------------------------------------------
void but_an(void);
//-----------------------------------------------
void ind_hndl(void);
//-----------------------------------------------
void t4_init(void);