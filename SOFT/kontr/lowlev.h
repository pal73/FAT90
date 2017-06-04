
//-----------------------------------------------
//Обработка кнопок
extern char but_new;
extern char but_n, but_s, but;
extern char l_but, n_but;
extern short but0_cnt, but1_cnt;
extern char speed;
extern short but_onL_temp;

#define BUT_ON	5
#define BUT_ONL	20

//-----------------------------------------------
//Состояние питающего напряжения
typedef enum {psOFF=0xAA,psON=0x55} enum_power_stat;
extern enum_power_stat power_stat,power_stat_old;
extern char power_stat_cnt;

//-----------------------------------------------
//Самовозврат меню
extern char retCnt;
extern char retStep;

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
void out_drv(void);
//-----------------------------------------------
void power_stat_drv(void);
//-----------------------------------------------
void delay_us(short num_of_delay);
//-----------------------------------------------
void but_drv(void);
//-----------------------------------------------
void clear_ind(void);
//-----------------------------------------------
void tree_down(signed char offset_ind,signed char offset_sub_ind);
//-----------------------------------------------
void tree_up(char tind, char tsub_ind, char tindex_set, char tsub_ind1);
//-----------------------------------------------
void gran_char(signed char *adr, signed char min, signed char max);
//-----------------------------------------------
void gran_ring_char(signed char *adr, signed char min, signed char max);
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
void ret_ind(char r_c, char r_s);
//-----------------------------------------------
void ret_ind_hndl(void);
//-----------------------------------------------
void led_set(signed char led_num, signed char led_stat);
//-----------------------------------------------
void led_mask_off(signed char led_mask);
//-----------------------------------------------
void led_mask_on(signed char led_mask);
//-----------------------------------------------
void led_off(signed char led_num);
//-----------------------------------------------
void led_on(signed char led_num);
//-----------------------------------------------
void led_flash(signed char led_num);
//-----------------------------------------------
void random_gen(void);


