#define DS18B20PORT	GPIOD
#define DS18B20PIN	7

//-----------------------------------------------
//Временная сетка
//extern bool b100Hz,b10Hz,b5Hz,b2Hz,b1Hz;
extern char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;

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
typedef enum {iMn,iSetT,iSetT_} enum_ind;
extern enum_ind ind,ret_ind;
extern char sub_ind,sub_ind1;
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

#define butON	254
#define butM	253
#define butU	251
#define butD	247
#define butON_	126
#define butM_	125
#define butU_	123
#define butD_	119

//-----------------------------------------------
//Температура
extern signed short temperWater;

//-----------------------------------------------
//Время
extern char buff_for_time[10];
extern char time_sec;
extern char time_min;
extern char time_hour;
extern char time_day_of_week;
extern char time_month;
extern char time_year;

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