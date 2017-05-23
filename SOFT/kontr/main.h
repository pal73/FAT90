#define DS18B20PORT	GPIOD
#define DS18B20PIN	4

//-----------------------------------------------
//Временная сетка
//extern bool b100Hz,b10Hz,b5Hz,b2Hz,b1Hz;
extern char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;

//-----------------------------------------------
//Индикация
extern char ind_cnt;
extern char ind_outB[5];
extern char ind_outC[5];
extern char ind_outG[5];
extern const char ind_strob[5];
extern char dig[10];
extern char ind_out_[5];
extern const char DIGISYM[30];
//extern bool zero_on;
//extern bool bFL5,bFL2,bFL1,bFL_;

//-----------------------------------------------
//Управление выходом
extern char out_stat[3];

//-----------------------------------------------
//Обработка кнопок
extern char but_new;
extern char but_n, but_s, but;
extern char l_but, n_but;
extern short but0_cnt, but1_cnt;
extern char speed;
extern short but_onL_temp;

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//отладка

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
void bin2bcd_int(unsigned short in);
//-----------------------------------------------
void bcd2ind(void);
//-----------------------------------------------
void bcd2ind_zero();
//-----------------------------------------------
void int2indI_slkuf(unsigned short in, char start, char len, char komma, char unzero, char fl) ;
//-----------------------------------------------
void int2indII_slkuf(unsigned short in, char start, char len, char komma, char unzero, char fl);
//-----------------------------------------------
void t4_init(void);