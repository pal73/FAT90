
//-----------------------------------------------
//��������� ��������� ����������
typedef enum {psOFF=0xAA,psON=0x55} enum_power_stat;
extern enum_power_stat power_stat,power_stat_old;
extern char power_stat_cnt;

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------

//-----------------------------------------------
void out_drv(void);
//-----------------------------------------------
void power_stat_drv(void);
//-----------------------------------------------
void delay_us(short num_of_delay);

