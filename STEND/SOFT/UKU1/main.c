//������� �����
//#define SC16IS740_UART


// ����������� ������ �� ���� �� ������ ���
// REL2.3 �������� ������ ����(���� ����� �������) �� ������ ������(���� �� ����)
// REL1.1	adc_buff_[0];
// REL1.2	adc_buff_[7];
// REL1.3	adc_buff_[8];
// REL2.1	adc_buff_[1];
// REL2.2	adc_buff_[4];
// REL2.3	adc_buff_[3];
// REL3.1	adc_buff_[2];
// REL3.2	adc_buff_[6];
// REL3.2	adc_buff_[5];


#include "lcd_AGM1232_uku207_3.h"
#include "rtl.h"
#include "type.h"
#include "main.h"
#include "simbol.h"
#include "25lc640.h"
#include "Timer.h"
#include "gran.h"
//#include "uart0.h"
//#include "uart1.h"
//#include "uart2.h"
#include "cmd.h"
#include "ret.h"
#include "eeprom_map.h"
#include "common_func.h"
#include "control.h"
#include "mess.h"
//#include "full_can.h"
#include "watchdog.h"
#include "ad7705.h"
#include "beep.h"
//#include "avar_hndl.h"
#include "memo.h"
#include "simbols.h"
#include "graphic.h"
//#include "snmp_data_file.h" 
//#include "net_config.h"
#include "uart0.h"
#include <rtl.h>
//#include "modbus.h"
//#include "sacred_sun.h"
#include "ztt.h"
//#include "mcp2515.h"
#include "sc16is7xx.h"
//#include "modbus_tcp.h"
#include <stdio.h> 

//extern U8 own_hw_adr[];
//extern U8  snmp_Community[];
BOOL tick;


//***********************************************
//������
char b10000Hz,b1000Hz,b2000Hz,b100Hz,b50Hz,b10Hz,b5Hz,b2Hz,b1Hz,b1min;
short t0cnt,t0cnt0,t0cnt1,t0cnt2,t0cnt3,t0cnt4,t0cnt5,t0cnt6,t0_cnt7,t0_cnt_min,t0cntMin;
char bFL5,bFL2,bFL,bFL_,bTPS;
signed short main_10Hz_cnt=0;
signed short main_1Hz_cnt=0;

 
//***********************************************
//��������� �����
char cnt_of_slave=3;
//char cnt_of_wrks;   //����������� ���������� ���������� , ��� ���������



//**********************************************
//������������, ������������ �� EEPROM
signed short Ktsrc[2];
signed short Kusrc[2];
signed short Kisrc[2];
signed short Ki0src[2];
signed short Kubat[2];
signed short Kubatm[2];
unsigned short Kibat0[2];
signed short Kibat1[2];
signed short Ktbat[2];
signed short Kunet;
signed short Kunet_ext[3];
signed short Ktext[3];
signed short Kuload;
signed short KunetA;
signed short KunetB;
signed short KunetC;
signed short Kubps;
signed short Kuout;
signed short Kuvd;

signed short MAIN_IST;
signed short UMAX;
signed short UOUT;
signed short UOUT_;
signed short UAVT;
signed short TMAX;
signed short TSIGN;
signed short TSYSMAX;
signed short AV_OFF_AVT;
signed short USIGN;
signed short UMN;
signed short ZV_ON;
signed short UINMAX;
signed short UINMIN;
signed short UOUTMAX;
signed short UOUTMIN;

signed short IKB;
//signed short KVZ;

signed short IMAX;
signed short IMIN;
signed short APV_ON;
signed short IZMAX;
signed short U0B;
signed short TZAS;
signed short VZ_HR;
signed short TBAT;
signed short U_AVT;
signed short DU;
//signed short PAR;

signed short RELE_SET_MASK[4]={1,2,3,4};

signed short TBATMAX;
signed short TBATSIGN;
signed short UBM_AV;
signed short RELE_LOG;
signed short TBOXMAX;
signed short TBOXREG;
signed short TBOXVENTMAX;
signed short TLOADDISABLE;
signed short TLOADENABLE;
signed short TBATDISABLE;
signed short TBATENABLE;
signed short TVENTON;
signed short TVENTOFF;
signed short TWARMON;
signed short TWARMOFF;
enum_releventsign RELEVENTSIGN;
signed short TZNPN;
signed short UONPN;
signed short UVNPN;
enum_npn_out NPN_OUT;
enum_npn_sign NPN_SIGN;
signed short TERMOKOMPENS;
signed short TBOXVENTON; 
signed short TBOXVENTOFF;
signed short TBOXWARMON; 
signed short TBOXWARMOFF;
signed short BAT_TYPE;	//��� �������. 0 - ������� ���������, 1-�������� COSLIGHT, 2-�������� SACRED SUN , 3-�������� ZTT
signed short DU_LI_BAT;	//��������, ������������ ���������� ���������� �������� �������
signed short FORVARDBPSCHHOUR;	//������������������ �������� ��������� � �����. ���� 0 - ������� ��������� � ������� ������ ��������
signed short NUMBAT;
signed short NUMBAT_TELECORE;
signed short NUMIST;
signed short NUMINV;
signed short NUMDT;
signed short NUMSK;
signed short NUMEXT;
signed short NUMAVT;
signed short NUMMAKB;
signed short NUMBYPASS;
signed short U_OUT_KONTR_MAX;
signed short U_OUT_KONTR_MIN;
signed short U_OUT_KONTR_DELAY;
signed short DOP_RELE_FUNC;
signed short CNTRL_HNDL_TIME;	//���������� ������� ������������� ���������� ��� ��������
signed short USODERG_LI_BAT;	//���������� ���������� �������� �������
signed short QSODERG_LI_BAT;	//����� ��� ������� �������� ����������� ���������� ���������� �������� �������
signed short TVENTMAX;			//������������ ������ �����������
signed short ICA_EN;			//������������ ������ ������������ ����� ���
signed short ICA_CH;			//����� ����� ��� ������������ �����, 0 - MODBUS, 1 - MODBUS-TCP
signed short ICA_MODBUS_ADDRESS;//����� �������� ��� ������������ ����� �� ���� MODBUS-RTU
signed short ICA_MODBUS_TCP_IP1,ICA_MODBUS_TCP_IP2,ICA_MODBUS_TCP_IP3,ICA_MODBUS_TCP_IP4;	//IP �������� ��� ������������ ����� �� ���� MODBUS-TCP
signed short ICA_MODBUS_TCP_UNIT_ID;	//UNIT ID �������� ��� ������������ ����� �� ���� MODBUS-TCP
signed short PWM_START;			//��������� ��� ��� ������
signed short KB_ALGORITM;		//2-� ��� 3-� ������������ �������� �������� ���� �������
signed short REG_SPEED;			//�������� �������������, 1- �����������, 2,3,4,5- ����������� � 2,3,4,5 ���
enum_apv_on APV_ON1,APV_ON2;
signed short APV_ON2_TIME;

enum_bat_is_on BAT_IS_ON[2];
signed short BAT_DAY_OF_ON[2];
signed short BAT_MONTH_OF_ON[2];
signed short BAT_YEAR_OF_ON[2];
signed short BAT_C_NOM[2];
signed short BAT_RESURS[2];
signed short BAT_C_REAL[2];
//signed short BAT_TYPE[2];

unsigned short AUSW_MAIN;
unsigned long AUSW_MAIN_NUMBER;
unsigned short AUSW_DAY;
unsigned short AUSW_MONTH;
unsigned short AUSW_YEAR;
unsigned short AUSW_UKU;
unsigned short AUSW_UKU_SUB;
unsigned long AUSW_UKU_NUMBER;
unsigned long	AUSW_BPS1_NUMBER;
unsigned long  AUSW_BPS2_NUMBER;
unsigned short AUSW_RS232;
unsigned short AUSW_PDH;
unsigned short AUSW_SDH;
unsigned short AUSW_ETH;

signed short TMAX_EXT_EN[3];
signed short TMAX_EXT[3];
signed short TMIN_EXT_EN[3];
signed short TMIN_EXT[3];
signed short T_EXT_REL_EN[3];
signed short T_EXT_ZVUK_EN[3];
signed short T_EXT_LCD_EN[3];
signed short T_EXT_RS_EN[3];

signed short SK_SIGN[4];
signed short SK_REL_EN[4];
signed short SK_ZVUK_EN[4];
signed short SK_LCD_EN[4];
signed short SK_RS_EN[4];

enum_avz AVZ;

unsigned short HOUR_AVZ;
unsigned short MIN_AVZ;
unsigned short SEC_AVZ;
unsigned short DATE_AVZ;
unsigned short MONTH_AVZ;
unsigned short YEAR_AVZ;
unsigned short AVZ_TIME;

enum_mnemo_on MNEMO_ON;
unsigned short MNEMO_TIME;

signed short POWER_CNT_ADRESS;

signed short ETH_IS_ON;
signed short ETH_DHCP_ON;
signed short ETH_IP_1;
signed short ETH_IP_2;
signed short ETH_IP_3;
signed short ETH_IP_4;
signed short ETH_MASK_1;
signed short ETH_MASK_2;
signed short ETH_MASK_3;
signed short ETH_MASK_4;
signed short ETH_TRAP1_IP_1;
signed short ETH_TRAP1_IP_2;
signed short ETH_TRAP1_IP_3;
signed short ETH_TRAP1_IP_4;
signed short ETH_TRAP2_IP_1;
signed short ETH_TRAP2_IP_2;
signed short ETH_TRAP2_IP_3;
signed short ETH_TRAP2_IP_4;
signed short ETH_TRAP3_IP_1;
signed short ETH_TRAP3_IP_2;
signed short ETH_TRAP3_IP_3;
signed short ETH_TRAP3_IP_4;
signed short ETH_TRAP4_IP_1;
signed short ETH_TRAP4_IP_2;
signed short ETH_TRAP4_IP_3;
signed short ETH_TRAP4_IP_4;
signed short ETH_TRAP5_IP_1;
signed short ETH_TRAP5_IP_2;
signed short ETH_TRAP5_IP_3;
signed short ETH_TRAP5_IP_4;

signed short ETH_SNMP_PORT_READ;
signed short ETH_SNMP_PORT_WRITE;

signed short ETH_GW_1;
signed short ETH_GW_2;
signed short ETH_GW_3;
signed short ETH_GW_4;

signed short RELE_VENT_LOGIC;

signed short MODBUS_ADRESS;
signed short MODBUS_BAUDRATE;
signed short BAT_LINK;
signed short I_LOAD_MODE;	//������ ��������� ��������� ���� - �� ����� ��� ��� ����� ����� ����������






//#ifdef UKU_TELECORE2015
//***********************************************
//��������� �������� �������  
LI_BAT_STAT li_bat;
//#endif

//***********************************************
//���������� �� ���������� ����
char can_slot[12][16];



//***********************************************
//��������� ����������
#ifdef UKU_220_V2
INV_STAT inv[3];
#endif
#ifndef UKU_220_V2
INV_STAT inv[20];
#endif
char first_inv_slot=MINIM_INV_ADRESS;

//***********************************************
//��������� �������
BYPS_STAT byps;

//***********************************************
//��������� ��������
signed short load_U;
signed short load_I;

//***********************************************
//��������� ������
signed short bps_U;
signed short out_U;
signed short in_U;
signed short out_I;
signed short vd_U;
signed short bps_I;
signed short sys_T;


//***********************************************
//���������

char lcd_buffer[LCD_SIZE+100]={"Hello World"};
signed char parol[3];
char phase;
char lcd_bitmap[1024];
char dig[5];
char dumm_ind[20];
stuct_ind a_ind,b_ind[10],c_ind;
char dumm_ind_[20];
char zero_on;
char mnemo_cnt=50;
char simax;
short av_j_si_max;
const char ABCDEF[]={"0123456789ABCDEF"};
const char sm_mont[13][4]={"   ","���","���","���","���","���","���","���","���","���","���","���","���"};
const char sm_dow[8][3]={"��","��","��","��","��","��","��"}; //
signed short ptr_ind=0;

signed short ind_pointer=0;

//***********************************************
//��������� ��������� ����
signed short net_U,net_Ustore,net_Ua,net_Ub,net_Uc;
char bFF,bFF_;
signed short net_F,hz_out,hz_out_cnt,net_F3;
signed char unet_drv_cnt;
char net_av;

//***********************************************
//��������� ������� ��������
//signed short tout[4];
char tout_max_cnt[4],tout_min_cnt[4];
enum_tout_stat tout_stat[4];
signed short t_ext[3];

signed char sk_cnt_dumm[4],sk_cnt[4],sk_av_cnt[4];
enum_sk_stat sk_stat[4]={ssOFF,ssOFF,ssOFF,ssOFF};
enum_sk_av_stat sk_av_stat[4]={sasOFF,sasOFF,sasOFF,sasOFF},sk_av_stat_old[4];
signed short t_box,t_box_warm,t_box_vent;
char ND_EXT[3];
//***********************************************
//�����
extern char beep_cnt;
BOOL bSILENT;








signed short u_necc,u_necc_,u_necc_up,u_necc_dn;
signed short main_cnt_5Hz;
signed short num_necc;
signed short num_necc_Imax;
signed short num_necc_Imin;
signed short cnt_num_necc;
//char bSAME_IST_ON;
signed mat_temper;

//***********************************************
//���
unsigned main_apv_cnt,hour_apv_cnt[2],reset_apv_cnt[2];
unsigned short apv_cnt_sec[2],apv_cnt[2];

//***********************************************
//��������� ���������
const char sm_[]	={"                    "};
const char sm_exit[]={" �����              "};
const char sm_time[]={" 0%:0^ 0</>  /0{   &"};





//**********************************************
//������ � �������� 
char but;                            
unsigned long but_n,but_s;
char but0_cnt;
char but1_cnt;
char but_onL_temp;

//***********************************************
//����������� �����
signed char cnt_net_drv;



//***********************************************
//������ � ��������
char speed,l_but,n_but;

//***********************************************
//�������������
enum {wrkON=0x55,wrkOFF=0xAA}wrk;
char cnt_wrk;
signed short ibat_integr;
unsigned short av_beep,av_rele,av_stat;
char default_temp;
char ND_out[3];

//***********************************************
//����
enum_tst_state tst_state[15];

//***********************************************
//���
//extern short adc_buff[16][16],adc_buff_[16];
extern char adc_cnt,adc_cnt1,adc_ch;

//***********************************************

char flag=0;


extern signed short bat_ver_cnt;
signed short Isumm;
signed short Isumm_;

#include <LPC17xx.H>                        /* LPC21xx definitions */



/*
extern void lcd_init(void);
extern void lcd_on(void);
extern void lcd_clear(void);
*/

extern short plazma_adc_cnt;
extern char net_buff_cnt;
extern unsigned short net_buff[32],net_buff_;
extern char rele_stat/*,rele_stat_*/;
extern char bRXIN0;


char cntrl_plazma;
extern char bOUT_FREE2;
extern char /*av_net,*//*av_bat[2],*/av_bps[12],av_inv[6],av_dt[4],av_sk[4];

char content[63];

//const short ptr_bat_zar_cnt[2]={EE_ZAR1_CNT,EE_ZAR2_CNT};


//unsigned short YEAR_AVZ,MONTH_AVZ,DATE_AVZ,HOUR_AVZ,MIN_AVZ,SEC_AVZ;


//**********************************************
//���������������
extern signed short samokalibr_cnt;

//**********************************************
//���������
extern char mess[MESS_DEEP],mess_old[MESS_DEEP],mess_cnt[MESS_DEEP];
extern short mess_par0[MESS_DEEP],mess_par1[MESS_DEEP],mess_data[2];


//**********************************************
//�������� ������� �������
extern signed short 	main_kb_cnt;
extern signed short 	kb_cnt_1lev;
extern signed short 	kb_cnt_2lev;
extern char 			kb_full_ver;
extern char 			kb_start[2],kb_start_ips;



//-----------------------------------------------
//�������� ������
char sign_U[2],sign_I[2];
char superviser_cnt;


char plazma_plazma_plazma;

char bRESET=0;
char bRESET_EXT=0;
char ext_can_cnt;
char bRESET_INT_WDT=0;
char bRESET_EXT_WDT=0;
//-----------------------------------------------
//��������� ������
signed short vvod_pos;

//-----------------------------------------------
//����� ����������
unsigned short adc_buff_ext_[3];
unsigned short Uvv[3];
unsigned short Uvv0;
short pos_vent;
short t_ext_can;
char t_ext_can_nd;


//-----------------------------------------------
//����� ���������� 2
char eb2_data[30];
short eb2_data_short[10];
short Uvv_eb2[3],Upes_eb2[3];
short Kvv_eb2[3],Kpes_eb2[3];
//-----------------------------------------------
//������ �� ��������
signed long power_summary;
signed short power_current;
signed long power_summary_tempo,power_summary_tempo_old;
signed short power_current_tempo,power_current_tempo_old;
char powerSummaryCnt;
char powerCurrentCnt;

//-----------------------------------------------
//�������������� � �����������
signed short main_vent_pos;
signed char t_box_cnt=0;
enum_mixer_vent_stat mixer_vent_stat=mvsOFF;
INT_BOX_TEMPER ibt;
enum_tbatdisable_stat tbatdisable_stat=tbdsON;
enum_tloaddisable_stat tloaddisable_stat=tldsON;
enum_av_tbox_stat av_tbox_stat=atsOFF;
signed short av_tbox_cnt;
short tbatdisable_cnt,tloaddisable_cnt;
#ifdef UKU_KONTUR
short t_box_vent_on_cnt;
short t_box_warm_on_cnt;
enum_vent_stat vent_stat_k=vsON;
enum_warm_stat warm_stat_k=wsON;
#endif

#ifdef UKU_TELECORE2015 
short t_box_vent_on_cnt;
short t_box_warm_on_cnt;
short t_box_vvent_on_cnt;
enum_vent_stat vent_stat_k=vsON,vvent_stat_k=vsON;
enum_warm_stat warm_stat_k=wsON;
signed short TELECORE2015_KLIMAT_WARM_ON_temp;
#endif





//short sys_plazma,sys_plazma1;

char snmp_plazma;


short plazma_but_an;

char bCAN_OFF;


char max_net_slot;

//-----------------------------------------------
//��������� ��� �� ����� ��������� ���� �������
signed long ibat_metr_buff_[2];
short bIBAT_SMKLBR;
char ibat_metr_cnt=0;





char ips_bat_av_vzvod=0;
char ips_bat_av_stat=0;

char rel_warm_plazma;
char can_byps_plazma0,can_byps_plazma1;

char bCAN_INV;
char plazma_can_inv[3];

unsigned short bat_drv_rx_cnt;
char bat_drv_rx_buff[512];
char bat_drv_rx_in;

short plazma_bat_drv0,plazma_bat_drv1,bat_drv_cnt_cnt;
short can_plazma;

//-----------------------------------------------
//���������� �����
signed short speedChrgCurr;			//������������ ��� ����������� ������, ����������� �� ������
signed short speedChrgVolt;			//������������ ���������� ����������� ������, ����������� �� ������
signed short speedChrgTimeInHour; 		//������������ ����� ����������� ������ � �����, ����������� �� ������
signed short speedChrgAvtEn;	    		//�������������� ��������� ����������� ������ ��������/���������
signed short speedChrgDU;	    		//�������� ���������� ����������� ��� ��������� ����������� ������
signed short speedChIsOn;			//������� ��������� ����������� ������ ���/����
signed long  speedChTimeCnt;			//������� ������� ������ ����������� ������
signed short speedChrgBlckSrc;		//�������� ������� ����������, 0-����., 1-��1, 2-��2
signed short speedChrgBlckLog;		//������ ������� ����������, 1 - ���������� �� ���������� ��, 0 - �� ������������
signed short speedChrgBlckStat;		//������ ���������� ��� �������������� � ����������� ������.
char  	   speedChrgShowCnt;		//������� ������ ��������������� ���������

//-----------------------------------------------
//���������� ���
signed short ipsBlckSrc;
signed short ipsBlckLog;
signed short ipsBlckStat;


//-----------------------------------------------
//�������� ��������� ����������
signed short outVoltContrHndlCnt;		//�������, ������� � ���� � ������ ���������� ������� ������
signed short outVoltContrHndlCnt_;		//�������, ������� � ���� � ������ ���������� ���������� ������� ������
char uout_av;

//-----------------------------------------------
//�������� ������ ������������
char bVDISWORK;
char vd_is_work_cnt;

short plazma_numOfCells;
short plazma_numOfTemperCells;
short plazma_numOfPacks;
/*
#ifdef MCP2515_CAN
#define can1_out	mcp2515_transmit
#endif
*/

char plazma_ztt[2];
char plazma1809;

U8 socket_tcp;

//-----------------------------------------------
//������ ������������
//char vent_resurs_temp[4];

//-----------------------------------------------
//������������ ����� ���
char ica_plazma[10];
char ica_timer_cnt;
signed short ica_my_current;
signed short ica_your_current;
signed short ica_u_necc;
U8 tcp_soc_avg;
U8 tcp_connect_stat;

//-----------------------------------------------
//������ �� ����������
short overloadHndlCnt;
char overloadAvar;

//-----------------------------------------------
//������ �� ��������� ����������
short uAvarHndlOutUMaxCnt,uAvarHndlOutUMinCnt;
char uOutAvar;

//-----------------------------------------------
//������ �� �������� ����������
short uAvarHndlInUMaxCnt,uAvarHndlInUMinCnt;
char uInAvar;

//-----------------------------------------------
//������ �� ����������� �������
short sysTAvarHndlCnt;
char sysTAvar;

short pvlk;
char klbr_en;


//***********************************************
//��������� ������� �������� �� ����
char rele_in_stat[3][3];

//-----------------------------------------------
//��������� �������� ������������ ���������� ����� 
enum_optr_stat optr_stat[3];

//***********************************************
//��������� ������ ��� ����
short rele_av_flags;
short avar_vd_stat;
// ��� 0 - ������ ������ �� ���
// ��� 1 - ���������� ������� �� ����
// ��� 2 - �������� �������
// ��� 3 - �������� ���������� ��������
// ��� 4 - �������� ���������� ��������
// ��� 5 - ������� ���������� ��������
// ��� 6 - ������� ���������� ��������
// ��� 7 - ������ ����� �� ���� KAN
// ��� 8 - ������������ � ������

#define THRE        (1<<5) //Transmit Holding Register Empty
#define MULVAL      15
#define DIVADDVAL   2
#define Ux_FIFO_EN  (1<<0)
#define Rx_FIFO_RST (1<<1)
#define Tx_FIFO_RST (1<<2)
#define DLAB_BIT    (1<<7)
#define LINE_FEED   0x0A //LF, For Linux, MAC and Windows Terminals  
#define CARRIAGE_RETURN 0x0D //CR, For Windows Terminals (CR+LF).

//-----------------------------------------------
void uartWrite(char c)
{
	//while ( !(LPC_UART0->LSR & THRE) ); //wait till the THR is empty
	if( c == '\n' ) //Send 
		{
	/*	LPC_UART0->THR = CARRIAGE_RETURN;
		while( !(LPC_UART0->LSR & THRE )); 
		LPC_UART0->THR = LINE_FEED;*/

		putchar_sc16is700(CARRIAGE_RETURN);
		putchar_sc16is700(LINE_FEED);
		}
	else
		{
		//LPC_UART0->THR = c; 
		putchar_sc16is700(c);
		}
}

//-----------------------------------------------
int fputc(int c, FILE * stream)
{
	uartWrite(c); //Transmit Character
	return c; //return the character written to denote a successful write
}


//-----------------------------------------------
void rtc_init (void) 
{
LPC_RTC->CCR=0x11;
}

/*
//-----------------------------------------------
static void timer_poll () 
{
if (SysTick->CTRL & 0x10000) 
     {
     timer_tick ();
     tick = __TRUE;
     }
} */


//-----------------------------------------------
signed short abs_pal(signed short in)
{
if(in<0)return -in;
else return in;
}


// ����������� ������ �� ���� �� ������ ���
// REL2.3 �������� ������ ����(���� ����� �������) �� ������ ������(���� �� ����)
// REL1.1	adc_buff_[0];
// REL1.2	adc_buff_[7];
// REL1.3	adc_buff_[8];
// REL2.1	adc_buff_[1];
// REL2.2	adc_buff_[4];
// REL2.3	adc_buff_[3];
// REL3.1	adc_buff_[2];
// REL3.2	adc_buff_[6];
// REL3.2	adc_buff_[5];

//-----------------------------------------------
void rele_in_drv(void)
{

if(adc_buff_[0]>3000)rele_in_stat[0][0]=1;
else if(adc_buff_[0]<1000)rele_in_stat[0][0]=0;

if(adc_buff_[7]>3000)rele_in_stat[0][1]=1;
else if(adc_buff_[7]<1000)rele_in_stat[0][1]=0;

if(adc_buff_[8]>3000)rele_in_stat[0][2]=1;
else if(adc_buff_[8]<1000)rele_in_stat[0][2]=0;

if(adc_buff_[1]>3000)rele_in_stat[1][0]=1;
else if(adc_buff_[1]<1000)rele_in_stat[1][0]=0;

if(adc_buff_[4]>3000)rele_in_stat[1][1]=1;
else if(adc_buff_[4]<1000)rele_in_stat[1][1]=0;

if(adc_buff_[3]>3000)rele_in_stat[1][2]=1;
else if(adc_buff_[3]<1000)rele_in_stat[1][2]=0;

if(adc_buff_[2]>3000)rele_in_stat[2][0]=1;
else if(adc_buff_[2]<1000)rele_in_stat[2][0]=0;

if(adc_buff_[6]>3000)rele_in_stat[2][1]=1;
else if(adc_buff_[6]<1000)rele_in_stat[2][1]=0;

if(adc_buff_[5]>3000)rele_in_stat[2][2]=1;
else if(adc_buff_[5]<1000)rele_in_stat[2][2]=0;

}


//-----------------------------------------------
void ADC_IRQHandler(void) {
LPC_ADC->ADCR &=  ~(7<<24);



adc_self_ch_buff[adc_self_ch_cnt]=(LPC_ADC->ADGDR>>4) & 0xFFF;/* Read Conversion Result             */
adc_self_ch_cnt++;
if(adc_self_ch_cnt<3)
	{
	LPC_ADC->ADCR |=  (1<<24);
	}
else
	{

 
	//SET_REG(LPC_ADC->ADCR,1,24,3);
	}

/*			adc_buff_[0]=AD_last;
			if(AD_last<adc_buff_min[adc_ch])adc_buff_min[adc_ch]=AD_last;
			if(AD_last>adc_buff_max[adc_ch])adc_buff_max[adc_ch]=AD_last;*/
}

//-----------------------------------------------
void transmit_hndl(void)
{
static char transmit_hndl_cnt;
if(ind==iMn)
	{
	printf("OK%dCRC%d\n",25,7);
	}
else if(ind==iOptr_kontr)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",38,11);
	else 
		{
		char temp=0,tempCRC=0;

		if(optr_stat[0]==osON)
			{
			temp|=0x01;
			tempCRC++;
			}
		if(optr_stat[1]==osON)
			{
			temp|=0x02;
			tempCRC++;
			}
		if(optr_stat[2]==osON)
			{
			temp|=0x04;
			tempCRC++;
			} 
		printf("OPTR%dCRC%d\n",temp,tempCRC);
		} 
	}

else if(ind==iSet_T)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",11,2);
	else 
		{
		char tempCRC=0;

		tempCRC=LPC_RTC->YEAR%100;
		tempCRC^=(LPC_RTC->MONTH%100);
		tempCRC^=(LPC_RTC->DOM%100);
		tempCRC^=(LPC_RTC->DOW%100);
		tempCRC^=(LPC_RTC->HOUR%100);
		tempCRC^=(LPC_RTC->MIN%100);
		
		printf("DATA%02d%02d%02d%02d%02d%02dCRC%d\n",LPC_RTC->YEAR,LPC_RTC->MONTH,LPC_RTC->DOM,LPC_RTC->DOW+1,LPC_RTC->HOUR,LPC_RTC->MIN,tempCRC);
		} 
	}

else if(ind==iSet_T_ret)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	/*if(transmit_hndl_cnt==4)	printf("RET0\n");
	else*/ 						printf("TIMESTART\n");
	}

else if(ind==iWater_sensor_kontr)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",12,2);
	else 
		{
		printf("WATER\n");
		}
	}
else if(ind==iWater_sensor_kontr_ret)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	printf("WAT_RET\n");
	}
else if(ind==iAir_sensor_kontr)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",17,2);
	else 
		{
		printf("AIR\n");
		}
	}
else if(ind==iAir_sensor_kontr_ret)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	printf("AI_RET\n");
	}
else if(ind==iInterf_kontr)
	{
	printf("INTER\n");

	}
else if(ind==iInterf_kontr_ret)
	{
	printf("INTE_RET\n");
	}
else if(ind==iProbesms)
	{
	printf("PROBESMS\n");
	}

else if(ind==iDefset)
	{
	printf("DEFAULT\n");
	}

}


//-----------------------------------------------
void def_ips_set(short voltage)
{
if(voltage==24)
	{
	//def_set(300,voltage,voltage,22,150,240,7,0);
	}
if(voltage==48)
	{
	//def_set(600,voltage,voltage,44,100,480,7,0);
	}
if(voltage==60)
	{
	//def_set(750,voltage,voltage,55,100,600,7,0);
	}

if(voltage==220)
	{
	//def_set(2450,2366,2315,187,100,2200,2,2346);

	lc640_write_int(EE_NUMIST,2);
	lc640_write_int(EE_NUMINV,0);
//lc640_write_int(EE_NUMDT,0);
//lc640_write_int(EE_NUMSK,0);
	lc640_write_int(EE_MAIN_IST,0);
	lc640_write_int(EE_PAR,1);
	lc640_write_int(EE_TBAT,60);
	lc640_write_int(EE_UMAX,2450);
	lc640_write_int(EE_DU,2315/2);
	//lc640_write_int(EE_UB0,2366);
	//lc640_write_int(EE_UB20,2315);
	lc640_write_int(EE_TSIGN,70);
	lc640_write_int(EE_TMAX,80);
//lc640_write_int(EE_C_BAT,180);
	lc640_write_int(EE_USIGN,187);
	lc640_write_int(EE_UMN,187);
	lc640_write_int(EE_ZV_ON,0);
	lc640_write_int(EE_IKB,20);
//lc640_write_int(EE_KVZ,1030);
	//lc640_write_int(EE_UVZ,2346);
	lc640_write_int(EE_IMAX,80);
	lc640_write_int(EE_IMIN,50);
//lc640_write_int(EE_APV_ON,apvON);
	lc640_write_int(EE_APV_ON1,apvON);
	lc640_write_int(EE_APV_ON2,apvON);
	lc640_write_int(EE_APV_ON2_TIME,1);
	lc640_write_int(EE_IZMAX,160);
	lc640_write_int(EE_U0B,2200);
	lc640_write_int(EE_TZAS,3);
	lc640_write_int(EE_TBATMAX,50);  
	lc640_write_int(EE_TBATSIGN,40);
	lc640_write_int(EE_MNEMO_ON,mnON);
	lc640_write_int(EE_MNEMO_TIME,30);	
	lc640_write_int(EE_AV_OFF_AVT,1);
//lc640_write_int(EE_APV_ON1,apvOFF);



	lc640_write_int(EE_TBOXMAX,70);
	lc640_write_int(EE_TBOXVENTMAX,60);
	lc640_write_int(EE_TBOXREG,25);
	lc640_write_int(EE_TLOADDISABLE,80);
	lc640_write_int(EE_TLOADENABLE,70);
	lc640_write_int(EE_TBATDISABLE,91);
	lc640_write_int(EE_TBATENABLE,80);

	lc640_write_int(ADR_SK_SIGN[0],0);
	lc640_write_int(ADR_SK_REL_EN[0],0);
	lc640_write_int(ADR_SK_LCD_EN[0],0xffff);

	lc640_write_int(ADR_SK_SIGN[1],0);
	lc640_write_int(ADR_SK_REL_EN[1],0);
	lc640_write_int(ADR_SK_LCD_EN[1],0xffff);

	lc640_write_int(ADR_SK_SIGN[2],0);
	lc640_write_int(ADR_SK_REL_EN[2],0);
	lc640_write_int(ADR_SK_LCD_EN[2],0xffff);

	lc640_write_int(ADR_SK_SIGN[3],0);
	lc640_write_int(ADR_SK_REL_EN[3],0);
	lc640_write_int(ADR_SK_LCD_EN[3],0xffff);

	lc640_write_int(EE_UBM_AV,10);

	lc640_write_int(EE_POS_VENT,11);


	lc640_write_int(EE_DU,2315-1870);
	lc640_write_int(EE_U_AVT,2200);
	lc640_write_int(EE_IZMAX,20);
	lc640_write_int(EE_AUSW_MAIN,22033);
	lc640_write_int(EE_PAR,1);
	lc640_write_int(EE_MNEMO_ON,mnOFF);
	}

if(voltage==110)
	{
	//def_set(1350,1270,1225,99,20,1220,2,1290);

	lc640_write_int(EE_NUMIST,2);
	lc640_write_int(EE_NUMINV,0);
//lc640_write_int(EE_NUMDT,0);
//lc640_write_int(EE_NUMSK,0);
	lc640_write_int(EE_MAIN_IST,0);
	lc640_write_int(EE_PAR,1);
	lc640_write_int(EE_TBAT,60);
	lc640_write_int(EE_UMAX,1350);
	lc640_write_int(EE_DU,1350/2);
	//lc640_write_int(EE_UB0,1270);
	//lc640_write_int(EE_UB20,1225);
	lc640_write_int(EE_TSIGN,70);
	lc640_write_int(EE_TMAX,80);
//lc640_write_int(EE_C_BAT,180);
	lc640_write_int(EE_USIGN,99);
	lc640_write_int(EE_UMN,187);
	lc640_write_int(EE_ZV_ON,0);
	lc640_write_int(EE_IKB,20);
//lc640_write_int(EE_KVZ,1030);
	//lc640_write_int(EE_UVZ,1290);
	lc640_write_int(EE_IMAX,80);
	lc640_write_int(EE_IMIN,50);
//lc640_write_int(EE_APV_ON,apvON);
	lc640_write_int(EE_APV_ON1,apvON);
	lc640_write_int(EE_APV_ON2,apvON);
	lc640_write_int(EE_APV_ON2_TIME,1);
	lc640_write_int(EE_IZMAX,160);
	lc640_write_int(EE_U0B,1220);
	lc640_write_int(EE_TZAS,3);
	lc640_write_int(EE_TBATMAX,50);  
	lc640_write_int(EE_TBATSIGN,40);
	lc640_write_int(EE_MNEMO_ON,mnON);
	lc640_write_int(EE_MNEMO_TIME,30);	
	lc640_write_int(EE_AV_OFF_AVT,1);
//lc640_write_int(EE_APV_ON1,apvOFF);



	lc640_write_int(EE_TBOXMAX,70);
	lc640_write_int(EE_TBOXVENTMAX,60);
	lc640_write_int(EE_TBOXREG,25);
	lc640_write_int(EE_TLOADDISABLE,80);
	lc640_write_int(EE_TLOADENABLE,70);
	lc640_write_int(EE_TBATDISABLE,91);
	lc640_write_int(EE_TBATENABLE,80);

	lc640_write_int(ADR_SK_SIGN[0],0);
	lc640_write_int(ADR_SK_REL_EN[0],0);
	lc640_write_int(ADR_SK_LCD_EN[0],0xffff);

	lc640_write_int(ADR_SK_SIGN[1],0);
	lc640_write_int(ADR_SK_REL_EN[1],0);
	lc640_write_int(ADR_SK_LCD_EN[1],0xffff);

	lc640_write_int(ADR_SK_SIGN[2],0);
	lc640_write_int(ADR_SK_REL_EN[2],0);
	lc640_write_int(ADR_SK_LCD_EN[2],0xffff);

	lc640_write_int(ADR_SK_SIGN[3],0);
	lc640_write_int(ADR_SK_REL_EN[3],0);
	lc640_write_int(ADR_SK_LCD_EN[3],0xffff);

	lc640_write_int(EE_UBM_AV,10);

	lc640_write_int(EE_POS_VENT,11);


	lc640_write_int(EE_DU,1220-600);
	lc640_write_int(EE_U_AVT,1220);
	lc640_write_int(EE_IZMAX,20);
	lc640_write_int(EE_AUSW_MAIN,22033);
	lc640_write_int(EE_PAR,1);
	lc640_write_int(EE_MNEMO_ON,mnOFF);
	}

lc640_write_int(ADR_EE_BAT_IS_ON[0],bisOFF);
lc640_write_int(ADR_EE_BAT_DAY_OF_ON[0],LPC_RTC->DOM);
lc640_write_int(ADR_EE_BAT_MONTH_OF_ON[0],LPC_RTC->MONTH);
lc640_write_int(ADR_EE_BAT_YEAR_OF_ON[0],LPC_RTC->YEAR);
lc640_write_int(ADR_EE_BAT_C_NOM[0],0);
lc640_write_int(ADR_EE_BAT_RESURS[0],0);

lc640_write_int(ADR_EE_BAT_IS_ON[1],bisOFF);
lc640_write_int(ADR_EE_BAT_DAY_OF_ON[1],LPC_RTC->DOM);
lc640_write_int(ADR_EE_BAT_MONTH_OF_ON[1],LPC_RTC->MONTH);
lc640_write_int(ADR_EE_BAT_YEAR_OF_ON[1],LPC_RTC->YEAR);
lc640_write_int(ADR_EE_BAT_C_NOM[1],0);
lc640_write_int(ADR_EE_BAT_RESURS[1],0);


lc640_write_int(EE_SPEED_CHRG_VOLT,2400);
lc640_write_int(EE_SPEED_CHRG_CURR,20);
lc640_write_int(EE_SPEED_CHRG_TIME,1);
lc640_write_int(EE_SPEED_CHRG_AVT_EN,0);
lc640_write_int(EE_SPEED_CHRG_BLOCK_SRC,0);
lc640_write_int(EE_SPEED_CHRG_BLOCK_LOG,0);
lc640_write_int(EE_SPEED_CHRG_D_U,40);
lc640_write_int(EE_U_OUT_KONTR_MAX,1310);
lc640_write_int(EE_U_OUT_KONTR_MIN,1100);


}


//-----------------------------------------------
void net_drv(void)
{ 

max_net_slot=24;


if(++cnt_net_drv>max_net_slot) 
	{
	cnt_net_drv=-5;
	} 


if((cnt_net_drv>=0)&&(cnt_net_drv<=max_net_slot)) // � 1 �� 12 ������� ��������


	{
	//cnt_net_drv=2; 
	if(mess_find_unvol(MESS2NET_DRV))
		{
		if(mess_data[0]==PARAM_BPS_NET_OFF)
			{
			//mess_data[1]=1;
			if(sub_ind1==cnt_net_drv)
				{
				return;
				}
			}
		}
	
	//bps[cnt_net_drv]._vol_u=2400;
	//bps[cnt_net_drv]._x_=0;
	//if(cntrl_stat==1000) 		   
	if(!bCAN_OFF)
		{
//		if(cntrl_stat==1000)	can1_out(cnt_net_drv,cnt_net_drv,GETTM,bps[cnt_net_drv]._flags_tu,*((char*)(&UOUT)),*((char*)((&UOUT))+1),0xe8,0x03);
//		else 					can1_out(cnt_net_drv,cnt_net_drv,GETTM,bps[cnt_net_drv]._flags_tu,*((char*)(&UOUT)),*((char*)((&UOUT))+1),*((char*)(&bps[cnt_net_drv]._x_)),*((char*)((&bps[cnt_net_drv]._x_))+1));

//		if(cntrl_stat==2000) can1_out(cnt_net_drv,cnt_net_drv,GETTM,bps[cnt_net_drv]._flags_tu,*((char*)(&UOUT)),*((char*)((&UOUT))+1),(char)(cntrl_stat),(char)((cntrl_stat)>>8)/*,*((char*)(&cntrl_stat)),*((char*)((&cntrl_stat))+1)*/);

//		else can1_out(cnt_net_drv,cnt_net_drv,GETTM,bps[cnt_net_drv]._flags_tu,*((char*)(&UOUT)),*((char*)((&UOUT))+1),(char)(cntrl_stat+bps[cnt_net_drv]._x_),(char)((cntrl_stat+bps[cnt_net_drv]._x_)>>8)/*,*((char*)(&cntrl_stat)),*((char*)((&cntrl_stat))+1)*/);

     	}
	if(cnt_net_drv<=max_net_slot)
	     {
//	     if(bps[cnt_net_drv]._cnt<CNT_SRC_MAX)
//   	 		{    
//   	 		bps[cnt_net_drv]._cnt++;
 //  	 		if( (bps[cnt_net_drv]._cnt>=CNT_SRC_MAX) && (!net_av) && (!(bps[cnt_net_drv]._av&0x08)) && (cnt_net_drv<NUMIST) ) 
 //  	 			{
 //  	 			avar_bps_hndl(cnt_net_drv,3,1);
 //  	 			}
//   	 		}
//		else bps[cnt_net_drv]._cnt=CNT_SRC_MAX;
						
//		if((bps[cnt_net_drv]._cnt>=3)&&(bps[cnt_net_drv]._cnt_old<3))bps[cnt_net_drv]._cnt_more2++;
//		bps[cnt_net_drv]._cnt_old=bps[cnt_net_drv]._cnt;
	     }
	}

else if(cnt_net_drv==-1)
	{
     //if(!bCAN_OFF)can1_out(0xff,0xff,MEM_KF,*((char*)(&UMAX)),*((char*)((&UMAX))+1),*((char*)(&DU)),*((char*)((&DU))+1),0);
     } 
     
else if(cnt_net_drv==-2)
	{
	//UAVT=4567;
     //if(!bCAN_OFF)can1_out(0xff,0xff,MEM_KF1,*((char*)(&UAVT)),*((char*)((&UAVT))+1),(char)(TMAX),(char)(TSIGN),(char)TZAS);
     //byps._cnt++;
	} 
else if(cnt_net_drv==-3)
	{                 
	//if(!bCAN_OFF) can1_out(GETTM_IBATMETER,GETTM_IBATMETER,0,0,0,0,0,0);
	ibat_metr_cnt++;
	}
	
	
//else if(cnt_net_drv==15)
	//{
     //if(!bCAN_OFF)can1_out(0xff,0xff,MEM_KF1,*((char*)(&TMAX)),*((char*)((&TMAX))+1),*((char*)(&TSIGN)),*((char*)((&TSIGN))+1),(char)TZAS);
     //}


}

//-----------------------------------------------

//-----------------------------------------------
void parol_init(void)
{
parol[0]=0;
parol[1]=0;
parol[2]=0;
sub_ind=0;
}

//-----------------------------------------------
void bitmap_hndl(void)
{
short x,ii,i;
unsigned int ptr_bitmap;
//static char ptr_cnt1,ptr_cnt2,ptr_cnt3,ptr_cnt4;

for(ii=0;ii<488;ii++)
	{
	lcd_bitmap[ii]=0x00;
	}


	{
	for(i=0;i<4;i++)
		{
		ptr_bitmap=122*(unsigned)i;
		for(x=(20*i);x<((20*i)+20);x++)
	 		{
			lcd_bitmap[ptr_bitmap++]=caracter[(unsigned)lcd_buffer[x]*6];
			lcd_bitmap[ptr_bitmap++]=caracter[((unsigned)lcd_buffer[x]*6)+1];
			lcd_bitmap[ptr_bitmap++]=caracter[((unsigned)lcd_buffer[x]*6)+2];
			lcd_bitmap[ptr_bitmap++]=caracter[((unsigned)lcd_buffer[x]*6)+3];
			lcd_bitmap[ptr_bitmap++]=caracter[((unsigned)lcd_buffer[x]*6)+4];
			lcd_bitmap[ptr_bitmap++]=caracter[((unsigned)lcd_buffer[x]*6)+5];
			} 
		}
	}	
}

//-----------------------------------------------
void ind_hndl(void)
{			  
//const char* ptr;
const char* ptrs[60];
/*const char* sub_ptrs[50]; */
//static char sub_cnt,sub_cnt1;
//char /*i,*/sub_cnt_max;
//char ii_;				  
//static char /*ii_cnt,*/cnt_ind_bat;
long tempL;

	   
//sub_cnt_max=5;
//i=0;
/*	      
if(spc_stat==spcVZ)
	{
	sub_ptrs[i++]=		" ������.�����  X:0x ";
	sub_cnt_max++;
	}
if(spc_stat==spcKE)
	{
	if(spc_bat==0)		sub_ptrs[i++]=		"�������� ���. ��� �1";
	else if(spc_bat==1)	sub_ptrs[i++]=		"�������� ���. ��� �2";
	sub_cnt_max++;
	}*/	


/*
if(avar_stat&0x0002)
	{
	sub_ptrs[i++]=	" ������ ������� �1  ";
	sub_cnt_max++;	
	}

if(avar_stat&0x0004)
	{
	sub_ptrs[i++]=	" ������ ������� �2  ";
	sub_cnt_max++;	
	}*/
/*
if(ips_bat_av_stat)
	{
	sub_ptrs[i++]=	"  ������ �������    ";
	sub_cnt_max++;	
	}

if(uout_av)
	{
	sub_ptrs[i++]=	"   ������ U���!!!   ";
	sub_cnt_max++;	
	}




if(overloadAvar)
	{
	sub_ptrs[i++]=	" ���������� �� ����!";
	sub_cnt_max++;	
	}

if(sysTAvar)
	{
	sub_ptrs[i++]=	" �������� �������!  ";
	sub_cnt_max++;	
	}

if(uOutAvar==1)
	{
	sub_ptrs[i++]=	"   �������� U���.!  ";
	sub_cnt_max++;	
	}

if(uOutAvar==2)
	{
	sub_ptrs[i++]=	"   �������� U���.!  ";
	sub_cnt_max++;	
	}

if(uInAvar==1)
	{
	sub_ptrs[i++]=	"   �������� U��.!   ";
	sub_cnt_max++;	
	}

if(uInAvar==2)
	{
	sub_ptrs[i++]=	"   �������� U��.!   ";
	sub_cnt_max++;	
	}

cnt_of_slave=NUMIST+NUMINV;


//cnt_of_wrks=0;
//for(i=0;i<NUMIST;i++)
 //    {
//     if(bps[i]._state==bsWRK)cnt_of_wrks++;
  //   }


sub_cnt1++;	
if(sub_cnt1>=20)
	{
	sub_cnt1=0;
	sub_cnt++;
	if(sub_cnt>=sub_cnt_max)
		{
		sub_cnt=0;
		}
	} */






/*else */if(ind==iMn)
	{
	ptrs[0]	=			" 0%:0^:0& 0</>  /0{ ";
	ptrs[1]=			"       ��     .  �  ";	
	ptrs[2]=			" ������ ��������    ";
	ptrs[3]=			" ��������� �������  ";
	ptrs[4]=			" �������� ����������";
    ptrs[5]=			" �������� ��������  ";
	ptrs[6]=			" ������ �������     ";
	ptrs[7]=			" ������ ����        ";	
	ptrs[8]=			" ������� ���        ";
	ptrs[9]=			" ���� ����������    ";
	ptrs[10]=			" ��������� ���������";						
	
	

	if(sub_ind-index_set>1)index_set=sub_ind-1;
	else if (sub_ind<index_set)index_set=sub_ind;
	
	bgnd_par(ptrs[0],ptrs[1],ptrs[index_set+2],ptrs[index_set+3]);
 	
	int2lcd(LPC_RTC->HOUR,'%',0);
	int2lcd(LPC_RTC->MIN,'^',0);
	int2lcd(LPC_RTC->SEC,'&',0);
	int2lcd(LPC_RTC->DOM,'<',0);
	int2lcd(LPC_RTC->YEAR,'{',0); 
	sub_bgnd(sm_mont[LPC_RTC->MONTH],'>',0);

 	if(bFL2)
 	     {
 	     lcd_buffer[find(':')]=' ';
 	     lcd_buffer[find(':')]=' ';
 	     lcd_buffer[find(':')]=' ';
 	     }

	pointer_set(2);	
	tempL=(long)ad7705_res1-32600L;
	if(tempL<0)tempL=0;
	tempL*=10;
	tempL/=255;

	int2lcdyx(tempL,1,6,0);
	int2lcdyx((adc_buff_[10]*10)/62,1,16,2);

	//int2lcdyx(ad7705_buff_[1],1,17,0);
	/*
	int2lcdyx(rele_in_stat[2][0],1,9,0);
	int2lcdyx(rele_in_stat[2][1],1,11,0);
	int2lcdyx(rele_in_stat[2][2],1,13,0);
	int2lcdyx(rele_in_stat[1][0],2,9,0);
	int2lcdyx(rele_in_stat[1][1],2,11,0);
	int2lcdyx(rele_in_stat[1][2],2,13,0);
	int2lcdyx(rele_in_stat[0][0],3,9,0);
	int2lcdyx(rele_in_stat[0][1],3,11,0);
	int2lcdyx(rele_in_stat[0][2],3,13,0);	*/		
	}

else if(ind==iInterf_kontr)
	{
	bgnd_par(	" �������� ��������� ",
				"      ������        ",
				"      �������       ",
				" �����              "); 
	pointer_set(3);
	} 


else if(ind==iOptr_kontr)
	{
	const char* ptr[12];
 
	simax=10;

	ptr[0]=			" ����3     !    @#$ ";
	ptr[1]=			" ����2     %    ^&* ";
	ptr[2]=			" ����1     (    )-= ";
	ptr[3]=			sm_exit;


		{
		bgnd_par(		" �������� ��������  ",
					ptr[index_set],
					ptr[index_set+1],
					ptr[index_set+2]);

		if(sub_ind-index_set>2)index_set=sub_ind-2;
		else if (sub_ind<index_set)index_set=sub_ind;

		pointer_set(1);
		
		}
	
	if(optr_stat[2]==osON)	sub_bgnd("���.",'!',-3);
	else 					sub_bgnd("����.",'!',-4);
	if(optr_stat[1]==osON)	sub_bgnd("���.",'%',-3);
	else 					sub_bgnd("����.",'%',-4);
	if(optr_stat[0]==osON)	sub_bgnd("���.",'(',-3);
	else 					sub_bgnd("����.",'(',-4);

	int2lcd(rele_in_stat[2][0],'@',0);
	int2lcd(rele_in_stat[2][1],'#',0);
	int2lcd(rele_in_stat[2][2],'$',0);
	int2lcd(rele_in_stat[1][0],'^',0);
	int2lcd(rele_in_stat[1][1],'&',0);
	int2lcd(rele_in_stat[1][2],'*',0);
	int2lcd(rele_in_stat[0][0],')',0);
	int2lcd(rele_in_stat[0][1],'-',0);
	int2lcd(rele_in_stat[0][2],'=',0);
    }

 
else if(ind==iWater_sensor_kontr)
	{
	bgnd_par(	" �� ����� ����������",
				"    �����������     ",
				"    ������� ����    ",
				" �����              "); 
	pointer_set(3);
	} 	   
	 	  

else if(ind==iAir_sensor_kontr)
	{
	bgnd_par(	" �� ����� ����������",
				"    �����������     ",
				"  ������� �������   ",
				" �����              "); 
	pointer_set(3);
	} 	 

else if(ind==iProbesms)
	{
	bgnd_par(	"     ��������       ",
				"     �������        ",
				"       ���          ",
				" �����              "); 
	pointer_set(3);
	}

if(ind==iPowerdown)
	{
	bgnd_par(	"  �������� �������  ",
				"   �� ����������    ",
				"       ����         ",
				" �����              "); 
	pointer_set(3);
	}
if(ind==iPowerdown_ret)
	{
	bgnd_par(	" �������� ��������  ",
				"      �� ���        ",
				"       �����        ",
				"                    "); 

	}

if(ind==iDefset)
	{
	bgnd_par(	"       ������       ",
				"      ���������     ",
				"      ���������     ",
				"                    "); 

	}

else if(ind==iAvt)
	{
     ptrs[0]=  		"  �������� �������� ";
	ptrs[1]=  		" ������� �1       ! ";
	ptrs[2]=  		" ������� �2       @ ";
	ptrs[3]=  		" ������� �3       # ";
	ptrs[4]=  		" ������� �4       $ ";
	ptrs[5]=  		" ������� �5       % ";
	ptrs[6]=  		" ������� �6       ^ ";
	ptrs[7]=  		" ������� �7       & ";
	ptrs[8]=  		" ������� �8       * ";
	ptrs[9]=  		" ������� �9       ( ";
	ptrs[10]=  		" ������� �10      ) ";
	ptrs[11]=  		" ������� �11      + ";
	ptrs[12]=  		" ������� �12      = ";

	ptrs[1+NUMAVT]=  	" �����              ";
	ptrs[2+NUMAVT]=  	"                    ";
	ptrs[3+NUMAVT]=  	"                    ";

	bgnd_par(		ptrs[0],
				ptrs[index_set+1],
				ptrs[index_set+2],
				ptrs[index_set+3]);

	if(sub_ind-index_set>2)index_set=sub_ind-2;
	else if (sub_ind<index_set)index_set=sub_ind;
	pointer_set(1);

	//int2lcdyx(eb2_data_short[6],0,6,0);
/*
	if(avt_stat[0]==avtON)	sub_bgnd("���.",'!',-3);
	else 				sub_bgnd("����.",'!',-4);
	if(avt_stat[1]==avtON)	sub_bgnd("���.",'@',-3);
	else 				sub_bgnd("����.",'@',-4);
	if(avt_stat[2]==avtON)	sub_bgnd("���.",'#',-3);
	else 				sub_bgnd("����.",'#',-4);
	if(avt_stat[3]==avtON)	sub_bgnd("���.",'$',-3);
	else 				sub_bgnd("����.",'$',-4);
	if(avt_stat[4]==avtON)	sub_bgnd("���.",'%',-3);
	else 				sub_bgnd("����.",'%',-4);
	if(avt_stat[5]==avtON)	sub_bgnd("���.",'^',-3);
	else 				sub_bgnd("����.",'^',-4);
	if(avt_stat[6]==avtON)	sub_bgnd("���.",'&',-3);
	else 				sub_bgnd("����.",'&',-4);
	if(avt_stat[7]==avtON)	sub_bgnd("���.",'*',-3);
	else 				sub_bgnd("����.",'*',-4);
	if(avt_stat[8]==avtON)	sub_bgnd("���.",'(',-3);
	else 				sub_bgnd("����.",'(',-4);
	if(avt_stat[9]==avtON)	sub_bgnd("���.",')',-3);
	else 				sub_bgnd("����.",')',-4);
	if(avt_stat[10]==avtON)	sub_bgnd("���.",'+',-3);
	else 				sub_bgnd("����.",'+',-4); 
	if(avt_stat[11]==avtON)	sub_bgnd("���.",'=',-3);
	else 				sub_bgnd("����.",'=',-4);	*/
     //int2lcd(Uvv[1],'$',0);
     //int2lcd(Uvv[2],'$',0);

     //long2lcd_mmm(power_summary,'%',2);
     //int2lcd(power_current,'^',0);

     //int2lcdyx(adc_buff_ext_[0],0,4,0);
     //int2lcdyx(adc_buff_ext_[1],0,10,0);
     //int2lcdyx(adc_buff_ext_[2],0,16,0);
     }


else if(ind==iBatLogVz)
	{
	if(av_j_si_max==0)
		{
		bgnd_par(	"������������� ������",
				"     ������� N!     ",
				" ������ ����        ",
				sm_exit);
		sub_ind=0;
		index_set=0;
		pointer_set(3);
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"������������� ������",
				"     ������� N!     ",
				" (                  ",
				sm_exit);
		index_set=0;
		pointer_set(2);
		}	
	else
		{
		if(sub_ind<index_set) index_set=sub_ind;
		else if((sub_ind-index_set)>1) index_set=sub_ind-1;
		if(index_set==(av_j_si_max-1)) 
			{
			bgnd_par(	"������������� ������",
					"     ������� N!     ",
					" (                  ",
					sm_exit);
			}

		else bgnd_par(	"������������� ������",
					"     ������� N!     ",
					" (                  ",
					" [                  "); 
		pointer_set(2);			        
		}
   	int2lcd(sub_ind1+1,'!',0);
 	event_data2ind(content[index_set],'(');
 	event_data2ind(content[index_set+1],'[');
	
	}
   
else if(ind==iBatLogWrk)
	{
	if(av_j_si_max==0)
		{
		bgnd_par(	"      �������       ",
				"     ������� N!     ",
				" ������ ����        ",
				sm_exit);
		sub_ind=0;
		index_set=0;
		pointer_set(3);
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"      �������       ",
				"     ������� N!     ",
				" (                  ",
				sm_exit);
		index_set=0;
		pointer_set(2);
		}	

	else
		{
		if(sub_ind<index_set) index_set=sub_ind;
		else if((sub_ind-index_set)>1) index_set=sub_ind-1;
		if(index_set==(av_j_si_max-1))
			{
			bgnd_par(	"      �������       ",
					"     ������� N!     ",
					" (                  ",
					sm_exit);
			}
		else bgnd_par(	"      �������       ",
					"     ������� N!     ",
					" (                  ",
					" [                  ");

		pointer_set(2);
		}

   	int2lcd(sub_ind1+1,'!',0);
 	event_data2ind(content[index_set],'(');
 	event_data2ind(content[index_set+1],'[');

	

	} 
	
else if((ind==iSet_prl)||(ind==iK_prl)
	||(ind==iAusw_prl)||(ind==iPrltst))
	{
	bgnd_par("  �������  ������   ",sm_,sm_,sm_);
	int2lcdyx(parol[0],1,8,0);
     int2lcdyx(parol[1],1,9,0);
     int2lcdyx(parol[2],1,10,0);
     lcd_buffer[48+sub_ind]='�';
	}	
		
else if(ind==iPrl_bat_in_out)
	{
	if(BAT_IS_ON[sub_ind1]==bisON)ptrs[0]="��� ��������� ���.-�";
	else  ptrs[0]="��� �������� �������";
	bgnd_par(ptrs[0],"  �������� ������   ",sm_,sm_);
	
     int2lcdyx(parol[0],2,8,0);
     int2lcdyx(parol[1],2,9,0);
     int2lcdyx(parol[2],2,10,0);
     lcd_buffer[68+sub_ind]='�';	
	}

else if(ind==iPrl_bat_in_sel)
	{
	
	bgnd_par(	"��� �������� �������",
			"   ������� �� ���   ",
			" ��������-��������� ",
			" GYFP4875T          ");
	
	pointer_set(2);
	}




else if(ind==iSet_T)
	{
	static char phase_cnt;
	if(++phase_cnt>=15)
	     {
	     phase_cnt=0;
	     if(++phase>=3)phase=0;
	     }
	ptrs[0]=sm_time;
	ptrs[1]=sm_;
	if(phase==0)ptrs[2]="     <> - �����     ";
     if(phase==1)ptrs[2]="   ^v - ���������   ";
     if(phase==2)ptrs[2]="     �  - �����     ";
	
	bgnd_par(" ���������  ������� ",ptrs[0],ptrs[1],ptrs[2]);
     if(sub_ind==0)lcd_buffer[42]='^';
     else if(sub_ind==1)lcd_buffer[45]='^';
     else if(sub_ind==2)lcd_buffer[48]='^';
     else if(sub_ind==3)lcd_buffer[51]='^';
     else if(sub_ind==4)lcd_buffer[55]='^';
     else if(sub_ind==5)lcd_buffer[59]='^';
  
 	//int2lcd(LPC_RTC->SEC,'&',0);
 	int2lcd(LPC_RTC->MIN,'^',0);
 	int2lcd(LPC_RTC->HOUR,'%',0);
 	
 	int2lcd(LPC_RTC->DOM,'<',0);
 	sub_bgnd(sm_mont[LPC_RTC->MONTH],'>',0);
 	int2lcd(LPC_RTC->YEAR,'{',0);
 	if(bFL2)
 	     {
 	     lcd_buffer[find(':')]=' ';
 	     //lcd_buffer[find(':')]=' ';
 	     }
	
	sub_bgnd(sm_dow[LPC_RTC->DOW],'&',-1);
	//if(LPC_RTC->DOW==0)
	//int2lcdyx(LPC_RTC->DOW,2,5,0);
	//int2lcdyx(LPC_RTC->DOY,2,10,0);	 
	int2lcdyx(sub_ind,0,2,0);	   
	}  

else if((ind==iSet_T_ret)||(ind==iAir_sensor_kontr_ret)||(ind==iWater_sensor_kontr_ret)||(ind==iInterf_kontr_ret))
	{
	bgnd_par(sm_,sm_,sm_,sm_);	 
		   
	}  

else if(ind==iK)
	{
	char i;
	i=0;
	
	ptrs[i++]=" ����               ";
	if(NUMBAT)
     ptrs[i++]=" �������            ";
	if(NUMIST)
	ptrs[i++]=" ���                ";
	if(NUMINV)
     ptrs[i++]=" ���������          ";
	ptrs[i++]=" ��������           ";
     ptrs[i++]=" ������� �������    ";
     ptrs[i++]=" ������� �����      ";
     ptrs[i++]=" �����              ";
     ptrs[i++]="                    ";
     ptrs[i++]="                    ";

	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par("     ����������     ",
			ptrs[index_set],
			ptrs[index_set+1],
			ptrs[index_set+2]);

	pointer_set(1);	 
	}    	


else if(ind==iK_220_IPS_TERMOKOMPENSAT)
	{
	char i;
	i=0;
	
	ptrs[i++]=" ����               ";
	if(NUMBAT)
     ptrs[i++]=" �������            ";
	if(NUMIST)
	ptrs[i++]=" ���                ";
	ptrs[i++]=" �������� ��������� ";
     if(NUMDT)
     ptrs[i++]=" ������� �������    ";
     ptrs[i++]=" �����              ";
     ptrs[i++]="                    ";
     ptrs[i++]="                    ";

	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par("     ����������     ",
			ptrs[index_set],
			ptrs[index_set+1],
			ptrs[index_set+2]);

	pointer_set(1);	 
	}   

else if(ind==iK_VD)
	{
	char i;
	i=0;
	
	ptrs[i++]=" U���.         !�   ";
	ptrs[i++]=" I���.         @�   ";
	if(NUMIST)
	ptrs[i++]=" ���                ";
	ptrs[i++]=" U�.�.         #�   ";
    ptrs[i++]=" T�������  =   ^�C  ";;
    ptrs[i++]=" �����              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par("     ����������     ",
			ptrs[index_set],
			ptrs[index_set+1],
			ptrs[index_set+2]);

	pointer_set(1);

	int2lcd(out_U,'!',1);
	int2lcd(out_I,'@',0);
	int2lcd(vd_U,'#',1);
	int2lcd(sys_T,'^',0);
	
	//int2lcdyx(adc_buff_[0],0,4,0);
    //int2lcdyx(adc_buff_[1],0,9,0);	
	
	if((sub_ind==0)||(sub_ind==3))mess_send(MESS2CNTRL_HNDL,PARAM_CNTRL_STAT_SET,1000,10);
	
	//int2lcdyx(adc_buff_[6],0,4,0);
	//int2lcdyx(Ktext[0],0,9,0);	 
	}   


else if(ind==iK_220_IPS_TERMOKOMPENSAT_IB)
	{
	char i;
	i=0;
	
	ptrs[i++]=" ����               ";
    ptrs[i++]=" �������            ";
	if(NUMIST)
	ptrs[i++]=" ���                ";
	ptrs[i++]=" �������� ��������� ";
    if(NUMDT)
    ptrs[i++]=" ������� �������    ";
    ptrs[i++]=" �����              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par("     ����������     ",
			ptrs[index_set],
			ptrs[index_set+1],
			ptrs[index_set+2]);

	pointer_set(1);	 
	}   


else if(ind==iK_TELECORE)
	{
	char i;
	i=0;
	
	ptrs[i++]=	" ����               ";
	if(NUMBAT_TELECORE)
    ptrs[i++]=	" �������            ";
	if(NUMIST)
	ptrs[i++]=	" ���                ";
	ptrs[i++]=	" ��������           ";
    if(NUMDT)
    ptrs[i++]=	" ������� �������    ";
    ptrs[i++]=" �����              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par("     ����������     ",
			ptrs[index_set],
			ptrs[index_set+1],
			ptrs[index_set+2]);

	pointer_set(1);	 
	}    	

else if(ind==iK_net)
	{
	ptrs[0]=" U =     @�         ";
     ptrs[1]=" �����              ";
	ptrs[2]="                    ";
	
	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par("   ���������� ����  ",ptrs[index_set],ptrs[index_set+1],ptrs[index_set+2]);

	pointer_set(1);	
	int2lcd(net_U,'@',0);
	//int2lcdyx(net_buff_,3,10,0);
	
	//int2lcdyx(Kunet,3,16,0);
     }


else if(ind==iK_net3)
	{

	ptrs[0]=  		" U�A           !�   ";
    ptrs[1]=  		" U�B           @�   ";
    ptrs[2]=  	    " U�C           #�   ";
	ptrs[3]=  	    " �����              ";


	bgnd_par(		"   ���������� ����  ",
					ptrs[index_set],
					ptrs[index_set+1],
					ptrs[index_set+2]);

	if(sub_ind-index_set>2)index_set=sub_ind-2;
	else if (sub_ind<index_set)index_set=sub_ind;
	pointer_set(1);

    int2lcd(net_Ua,'!',0);
	int2lcd(net_Ub,'@',0);
	int2lcd(net_Uc,'#',0);

	/*int2lcdyx(KunetC,0,19,0);
	int2lcdyx(adc_buff_[10],0,13,0);
	int2lcdyx(KunetB,0,8,0);
	int2lcdyx(adc_buff_[3],0,4,0);*/

    }


else if(ind==iK_load)
	{
	ptrs[0]=" U =     @�         ";
     ptrs[1]=" �����              ";
	ptrs[2]="                    ";
	
	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(		" ���������� ��������",
				ptrs[index_set],
				ptrs[index_set+1],
				ptrs[index_set+2]);

	pointer_set(1);
	if((load_U)>1000)int2lcd(load_U/10,'@',0);	
	else int2lcd(load_U,'@',1);
     }

else if(ind==iK_t_ext)
	{
	ptrs[0]=  	" t����.����.    !�� ";
     ptrs[1]=  	" t����� ���     @�� ";
     ptrs[2]=  	" t����� MSAN    #�� ";
     ptrs[3]=	     " �����              ";
	ptrs[4]=	     "                    ";
	ptrs[5]=	     "                    ";
	
	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(		" ���������� ������� ",
				" �������� ����������",
				ptrs[index_set],
				ptrs[index_set+1]);

	pointer_set(2);	
	if(ND_EXT[0])sub_bgnd("������.",'!',-3);
     else int2lcd_mmm(t_ext[0],'!',0);

	if(ND_EXT[1])sub_bgnd("������.",'@',-3);
     else int2lcd_mmm(t_ext[1],'@',0);

	if(ND_EXT[2])sub_bgnd("������.",'#',-3);
     else int2lcd_mmm(t_ext[2],'#',0);
     }

else if(ind==iK_t_ext_6U)
	{
	ptrs[0]=  		" t1             !�� ";
    ptrs[1]=  		" t2             @�� ";
    ptrs[2]=  		" t3             #�� ";
    ptrs[NUMDT]=	" �����              ";
	ptrs[NUMDT+1]=  "                    ";
	ptrs[NUMDT+2]=  "                    ";
	
	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(		" ���������� ������� ",
				" �������� ����������",
				ptrs[index_set],
				ptrs[index_set+1]);

	pointer_set(2);	
	if(ND_EXT[0])sub_bgnd("������.",'!',-3);
     else int2lcd_mmm(t_ext[0],'!',0);

	if(ND_EXT[1])sub_bgnd("������.",'@',-3);
     else int2lcd_mmm(t_ext[1],'@',0);

	if(ND_EXT[2])sub_bgnd("������.",'#',-3);
     else int2lcd_mmm(t_ext[2],'#',0);
	//int2lcdyx(u_necc,3,18,0);
     }
     
else if(ind==iK_bat_sel)
	{
	ptrs[0]=						" ������� N1         ";
     ptrs[1]=						" ������� N2         ";
     if(BAT_IS_ON[0]!=bisON)ptrs[0]=	" ������� N2         ";
	ptrs[0+NUMBAT]=				" �����              ";
	ptrs[1+NUMBAT]=				"                    ";
	ptrs[2+NUMBAT]=				"                    ";

	if((sub_ind-index_set)>2)index_set=sub_ind-2;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(" ���������� ������� ",ptrs[index_set],ptrs[index_set+1],ptrs[index_set+2]);
	pointer_set(1);
	
     }     



else if(ind==iK_power_net3)
	{
     ptrs[0]=  		" ���� �.A    !�     ";
	ptrs[1]=  		" ���� �.B    @�     ";
	ptrs[2]=  		" ���� �.C    #�     ";
     ptrs[3]=  	     " ���  �.A    &�     ";
     ptrs[4]=  	     " ���  �.B    *�     ";
     ptrs[5]=  	     " ���  �.C    (�     ";		            
     ptrs[6]=" �����              ";
	ptrs[7]="                    ";
	
	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par( "      ����������    ",
               "   ������� ������   ",
               ptrs[index_set],
               ptrs[index_set+1]);

	pointer_set(2);	
	int2lcd(Uvv_eb2[0],'!',0);
	int2lcd(Uvv_eb2[1],'@',0);
	int2lcd(Uvv_eb2[2],'#',0);
	int2lcd(Upes_eb2[0],'&',0);
	int2lcd(Upes_eb2[1],'*',0);
	int2lcd(Upes_eb2[2],'(',0);
	//int2lcdyx(net_buff_,3,10,0);
	
	//int2lcdyx(Kunet,3,16,0);
     }


			
if(ind==iDeb)
     {
     if(sub_ind==0)
     	{


        bgnd_par("*0000*000000*       ",
     	         "                    ",
     	         "                    ",
     	         "      ********      ");

		int2lcdyx(SOFT_NUM,0,4,0);
		long2lcdyx_mmm(SOFT_DATE,0,11,0);
	
		int2lcdyx(numOfForvardBps_minCnt,1,5,0);
		int2lcdyx(numOfForvardBps_hourCnt,1,10,0);
		int2lcdyx(numOfForvardBps,1,15,0);
	
		int2lcdyx(numOfForvardBps_minCnt,2,4,0);
		int2lcdyx(numOfForvardBps_hourCnt,2,9,0);

      

     	}     

    	else if(sub_ind==1) 
     	{
     	bgnd_par("�                   ",
     	         "                    ",
     	         "                    ",
     	         "                    ");

		//int2lcdyx(bAVG,0,0,0);
		//int2lcdyx(LPC_CAN1->GSR,0,6,0);
		//int2lcdyx((LPC_CAN1->GSR)>>16,0,16,0);
		//int2lcdyx(avg,0,19,0);

				//int2lcdyx((((LPC_CAN1->GSR)&(0xff000000))>>24),0,19,0);
		//int2lcdyx((((LPC_CAN1->GSR)&(0x00ff0000))>>16),0,15,0);

 /*         int2lcdyx(bat[0]._Ubm,1,7,0); 	int2lcdyx(bat[0]._av,1,10,0);
		int2lcdyx(bat[0]._dUbm,2,7,0);
		int2lcdyx(bat[0]._cnt_as,3,7,0);
		
 
		int2lcdyx(bat[1]._Ub,0,14,0);
          int2lcdyx(bat[1]._Ubm,1,14,0);	int2lcdyx(bat[1]._av,1,17,0);
		int2lcdyx(bat[1]._dUbm,2,14,0);
		int2lcdyx(bat[1]._cnt_as,3,14,0);*/

		int2lcdyx(sub_ind1+0,1,0,0);
		int2lcdyx(sub_ind1+1,2,0,0);
		int2lcdyx(sub_ind1+2,3,0,0);
		
		
/*		int2lcdyx(bps[sub_ind1  ]._cnt,1,2,0);
		int2lcdyx(bps[sub_ind1+1]._cnt,2,2,0);
		int2lcdyx(bps[sub_ind1+2]._cnt,3,2,0);*/		
		
	/*	int2lcdyx(bps[sub_ind1  ]._ist_blok_cnt,1,5,0);
		int2lcdyx(bps[sub_ind1+1]._ist_blok_cnt,2,5,0);
		int2lcdyx(bps[sub_ind1+2]._ist_blok_cnt,3,5,0);*/			
		
	/*	char2lcdhyx(bps[sub_ind1  ]._flags_tu,1,8);
		char2lcdhyx(bps[sub_ind1+1]._flags_tu,2,8);
		char2lcdhyx(bps[sub_ind1+2]._flags_tu,3,8);

		int2lcdyx(bps[sub_ind1  ]._vol_u,1,12,0);
		int2lcdyx(bps[sub_ind1+1]._vol_u,2,12,0);
		int2lcdyx(bps[sub_ind1+2]._vol_u,3,12,0);		


		char2lcdhyx(bps[sub_ind1]._flags_tm,1,15);
		char2lcdhyx(bps[sub_ind1+1]._flags_tm,2,15);
		char2lcdhyx(bps[sub_ind1+2]._flags_tm,3,15);	
		*/

	/*
		char2lcdhyx(bps[sub_ind1]._rotor>>8,1,15);
		char2lcdhyx(bps[sub_ind1+1]._rotor>>8,2,15);
		char2lcdhyx(bps[sub_ind1+2]._rotor>>8,3,15);		
		*/
		



 		}

 

    else if(sub_ind==2)
     	{
     	bgnd_par(	"F                   ",
     		    	"                    ",
     		    	"                    ",
     		    	"                    ");


		int2lcdyx(uout_av,1,5,0);
		int2lcdyx(USIGN,2,5,0); 

		int2lcdyx(bSILENT,3,5,0);

		
		
		int2lcdyx(U_OUT_KONTR_MAX,0,19,0);
		int2lcdyx(load_U,1,19,0);
		int2lcdyx(U_OUT_KONTR_MIN,2,19,0);
		//int2lcdyx(U_OUT_KONTR_DELAY,3,19,0);
		int2lcdyx(outVoltContrHndlCnt,3,19,0);

		long2lcdhyx(0x12345678UL,1,14);
//		long2lcdhyx(avar_stat,2,14);
//		long2lcdhyx(avar_ind_stat,3,14);
		}  

	else if(sub_ind==3)
     	{
     	bgnd_par("��                  ",
     	         "                    ",
     	         "                   ^",
     	         "                   &");

/*	int2lcdyx(spc_stat,0,5,0);
	int2lcdyx(__ee_spc_stat,0,9,0);
	int2lcdyx(lc640_read_int(EE_SPC_STAT),0,13,0);

	int2lcdyx(spc_bat,1,5,0);
	int2lcdyx(__ee_spc_bat,1,9,0);
	int2lcdyx(lc640_read_int(EE_SPC_BAT),1,13,0);

	int2lcdyx(bat_u_old_cnt,0,19,0);
	
	
	int2lcdyx(bat[0]._zar_cnt_ke,2,5,0);
	int2lcdyx(lc640_read_int(ADR_EE_BAT_ZAR_CNT_KE[0]),2,10,0);	
	int2lcdyx(bat[0]._u_old[0],2,14,0);
	int2lcd_mmm(bat[0]._Ib,'^',2);

	int2lcdyx(bat[1]._zar_cnt_ke,3,5,0);
	int2lcdyx(lc640_read_int(ADR_EE_BAT_ZAR_CNT_KE[1]),3,10,0);
	int2lcdyx(bat[1]._Ub,3,14,0);
	int2lcd_mmm(bat[1]._Ib,'&',2);	

	int2lcdyx(spc_phase,1,15,0);
	int2lcdyx(__ee_spc_phase,1,17,0);
	int2lcdyx(lc640_read_int(EE_SPC_PHASE),1,19,0);	*/

/*	int2lcdyx(speedChIsOn,0,4,0);
	int2lcdyx(speedChTimeCnt,1,4,0);
	int2lcdyx(speedChrgBlckStat,2,4,0);
	int2lcdyx(speedChrgBlckSrc,3,4,0);

	int2lcdyx(speedChrgBlckSrc,0,8,0);
	int2lcdyx(speedChrgBlckLog,1,8,0); */
	
	
		

/*	    		int2lcdyx(adc_net_buff_cnt,0,4,0);

		    	int2lcdyx((short)(main_power_buffer[0]>>12),0,19,0);
			int2lcdyx((short)(main_power_buffer[1]>>12),1,19,0);
			int2lcdyx((short)(main_power_buffer[2]>>12),2,19,0);
			int2lcdyx((short)(main_power_buffer[3]>>12),3,19,0);

		    	int2lcdyx((net_buff_),2,5,0); */


		   
		    


/*		int2lcdyx(load_U,0,4,0);
		int2lcdyx(load_I,1,4,0);
		lcd_buffer[44]='a';
		int2lcd_mmm((bat[0]._Ib)/10,'a',1);
		lcd_buffer[64]='a';
		int2lcd_mmm((bat[1]._Ib)/10,'a',1);

 		int2lcdyx(u_necc,0,8,0);

		
		
		lcd_buffer[14]='.';
		lcd_buffer[34]='.';
		int2lcdyx(Isumm,0,15,1);		
		int2lcdyx(Isumm_,1,15,1);


		int2lcdyx(cntrl_stat,0,19,0);
		int2lcdyx(num_necc,1,19,0);
		
		
		  
//		int2lcdyx(cntrl_stat,0,15,0);
		 
		//int2lcdyx(cntrl_plazma,1,3,0);
		//lcd_buffer[30]='a';
		int2lcd_mmm(Ibmax,'a',0);
		int2lcdyx(IZMAX,1,14,0);

		lcd_buffer[65]='a';
		int2lcd_mmm(bat[0]._Ib,'a',0);

		lcd_buffer[70]='a';
		int2lcd_mmm(bat[1]._Ib,'a',0); 

		lcd_buffer[75]='a';
		int2lcd_mmm(Ibmax,'a',0); 

	//	int2lcdyx(IMAX,2,3,0);
		
		

	//	int2lcdyx(IZMAX,3,19,0);

		//int2lcdyx(num_necc_Imax,3,6,0);
		//int2lcdyx(num_necc_Imin,3,12,0);


 //    	lcd_buffer[4]='a';            
 //    	int2lcd_mmm(Ibat,'a',1);   int2lcdyx(cntrl_stat,0,9,0);          int2lcdyx(hour_apv_cnt,0,13,0);                             char2lcdhyx(St_[0],0,19);  
 //    	int2lcdyx(Ubat,1,4,0);     int2lcdyx(main_apv_cnt,1,9,0);        int2lcdyx(lc640_read_int(bps1_AVAR_PTR),1,13,0);            char2lcdhyx(St_[1],1,19);
 //    	int2lcdyx(Us[0],2,4,0);  int2lcdyx(apv_cnt_1,2,9,0);           int2lcdyx(lc640_read_int(SRC1_AVAR_CNT),2,13,0);                                     int2lcdhyx(av_stat,2,19);
 //    	int2lcdyx(Us[1],3,4,0);  int2lcdyx(reset_apv_cnt,3,9,0);                                            int2lcdyx(plazma,3,19,0);
     	//int2lcd(plazma,'(',0);

     	//int2lcd(Us[0],'#',1);
     	//int2lcd(Us[1],'$',1);
     	//int2lcd(Is[0],'%',1);
     	//int2lcd(Is[1],'^',1);
    // 	int2lcd(bat[0]._Ub,'<',1);
    // 	int2lcd_mmm(bat[0]._Ib,'>',2);
 //    	char2lcdhyx(St_[0],3,13);
 //    	char2lcdhyx(St_[1],3,19);
 //    	char2lcdhyx(St,3,5);  */
		}

   else if(sub_ind==4)
     	{
     	bgnd_par(	"LB                  ",
     		    	"                    ",
     		    	"      !   #         ",
     		    	"      @   $         ");


     	int2lcdyx(NUMBAT_TELECORE,0,1,0);

		
		int2lcdyx(plazma_cntrl_stat,0,19,0);
		
//		int2lcdyx(Ubpsmax,1,3,0);
		int2lcdyx(load_U,1,19,0);
			
///		int2lcdyx(lakb[0]._balanced_event_code/*_tot_bat_volt*/,2,2,0);
//	   	int2lcdyx(lakb[1]._balanced_event_code/*_tot_bat_volt*/,3,2,0);
		
//	 	int2lcd_mmm(lakb[0]._ch_curr/10,'!',0);
//		int2lcd_mmm(lakb[1]._ch_curr/10,'@',0);		
		

//		int2lcdyx(TELECORE2017_ULINECC,2,19,0);
//	   	int2lcdyx(TELECORE2017_ULINECC_,3,19,0);

		//int2lcdyx(lakb[0]._communicationFullErrorStat,2,19,0);
	   	//int2lcdyx(lakb[1]._communicationFullErrorStat,3,19,0);

		int2lcdyx(IMAX,0,13,0);
		




		//int2lcdyx(load_I,2,17,0); 
		//int2lcdyx(Isumm,3,17,0);

		//int2lcdyx(lakb[0]._s_o_c_percent,2,17,0); 
		//int2lcdyx(lakb[1]._s_o_c_percent,3,17,0);


		




		
		//int2lcdyx(u_necc,1,15,0);
		

		//int2lcdyx(plazma_ztt[0],1,13,0);lakb[i]._communicationFullErrorStat
		//int2lcdyx(plazma_ztt[1],1,17,0);
 		//int2lcdyx(zTTBatteryHndlCmnd/*zTTBatteryHndlPhase*/,0,5,0);

		//int2lcdyx(zTTButteryCnter,0,7,0);

		//int2lcdyx(numOfPacks,0,9,0);

		//int2lcdyx(numOfTemperCells,0,12,0);
		//t2lcdyx(cntrl_stat_blck_cnt,0,6,0);
		 
		//int2lcdyx(ch_cnt0,0,13,0);
		//int2lcdyx(ch_cnt1,0,16,0);
		//int2lcdyx(bat[0]._Ib,0,9,0);
		//int2lcdyx(bat[1]._Ib,0,15,0);
		}
/*	else if(sub_ind==4)
     	{
     	bgnd_par(" ������             ",
     	         "                    ",
     	         "                    ",
     	         "                    ");

		int2lcdyx(main_10Hz_cnt,0,7,0);
		int2lcdyx(bat[0]._av,0,10,0);
		int2lcdyx(bat[1]._av,0,12,0);
		char2lcdhyx(rele_stat,0,19);

 		long2lcdhyx(avar_stat,1,7);
		long2lcdhyx(avar_stat_old,2,7);
		long2lcdhyx(avar_ind_stat,3,7);

		long2lcdhyx(avar_stat_new,2,19);
		long2lcdhyx(avar_stat_offed,3,19);



		}*/
 
    else if(sub_ind==5)
     	{
     	bgnd_par(	"*                   ",
     		    	"                    ",
     		    	"                    ",
     		    	"                    ");

		int2lcdyx(adc_buff_[0],0,4,0);
		int2lcdyx(adc_buff_[1],1,4,0);
		int2lcdyx(adc_buff_[2],2,4,0);
		int2lcdyx(adc_buff_[3],3,4,0);
		int2lcdyx(adc_buff_[4],0,9,0);
		int2lcdyx(adc_buff_[5],1,9,0);
		int2lcdyx(adc_buff_[6],2,9,0);
		int2lcdyx(adc_buff_[7],3,9,0);
		int2lcdyx(adc_buff_[8],0,14,0);
		int2lcdyx(adc_buff_[9],1,14,0);
		int2lcdyx(adc_buff_[10],2,14,0);
		int2lcdyx(adc_buff_[11],3,14,0);
		int2lcdyx(adc_buff_[12],0,19,0);
		int2lcdyx(adc_buff_[13],1,19,0);
		int2lcdyx(adc_buff_[14],2,19,0);
		int2lcdyx(adc_buff_[15],3,19,0);



	/*	int2lcdyx(main_kb_cnt,0,3,0);
		int2lcdyx(cntrl_stat,1,3,0);
		int2lcdyx(ibat_ips,2,3,0);
		int2lcdyx(ibat_ips_,3,3,0);

		int2lcdyx(kb_cnt_1lev,0,19,0);
		int2lcdyx(kb_cnt_2lev,1,19,0);
		int2lcdyx(kb_full_ver,2,19,0);

		int2lcdyx(Ibmax,0,16,0);
		int2lcdyx(IZMAX_,1,16,0);
		int2lcdyx(cntrl_hndl_plazma,2,16,0); */

		
    	}  		  		


  else if(sub_ind==6)
     	{
     	bgnd_par(	"6                   ",
     		    	"    !     $         ",
     		    	"    @     %         ",
     		    	"            ^       ");
#ifdef UKU_TELECORE2017     		    
/*		int2lcd_mmm(bat[0]._Ib,'!',2);
		int2lcd_mmm(bat[1]._Ib,'@',2);
		int2lcd_mmm(bps[0]._Ii,'$',1);
		int2lcd_mmm(bps[1]._Ii,'%',1);
		int2lcd_mmm(bps[2]._Ii,'^',1); */

		int2lcd_mmm(t_ext[0],'!',0);
		int2lcd_mmm(t_ext[1],'@',0);
		int2lcd_mmm(t_box_warm,'$',0);
		int2lcd_mmm(t_box_vent,'%',0);
		//int2lcdyx(load_I,3,7,0);
		//int2lcdyx(t_box_vent,2,7,0);

		int2lcdyx(warm_stat_k,1,19,0);
		int2lcdyx(vent_stat_k,2,19,0);
		

		int2lcdyx(TELECORE2017_KLIMAT_WARM_ON_temp,3,3,0);
		int2lcdyx(TELECORE2017_KLIMAT_WARM_ON,3,7,0);
		int2lcdyx(TELECORE2017_KLIMAT_WARM_OFF,3,11,0);
		int2lcdyx(TELECORE2017_INT_VENT_PWM,3,15,0);
		int2lcdyx(TELECORE2017_EXT_VENT_PWM,3,19,0);
		
		
		
		//int2lcdyx(li_bat._Tb,3,3,0);
		
		


		int2lcdyx(t_box_warm_on_cnt,1,17,0);
		int2lcdyx(t_box_vent_on_cnt,2,17,0);
//			//int2lcdyx(t_box_vent_on_cnt,0,3,0);
	//int2lcdyx(t_box_warm_on_cnt,0,7,0);
//		int2lcdyx(vent_stat_k,2,15,0);

		
		int2lcdyx(ND_EXT[0],0,9,0);
		int2lcdyx(ND_EXT[1],0,13,0);
		//int2lcdyx(TELECORE2017_KLIMAT_VENT_ON20,0,16,0);	 
		int2lcdyx(lakb[0]._zar_percent,0,19,0);	 
#endif
    	}


   else if(sub_ind==7)
     	{
     	bgnd_par("7                   ",
     		    "                    ",
     		    "                    ",
     		    "                    ");
     		    
		int2lcdyx(adc_buff_[sk_buff_TELECORE2015[0]],0,19,0);
		int2lcdyx(adc_buff_[sk_buff_TELECORE2015[1]],1,19,0);
		int2lcdyx(adc_buff_[sk_buff_TELECORE2015[2]],2,19,0);
		int2lcdyx(adc_buff_[sk_buff_TELECORE2015[3]],3,19,0);
		int2lcdyx(sk_cnt[0],0,14,0);
		int2lcdyx(sk_cnt[1],1,14,0);
		int2lcdyx(sk_cnt[2],2,14,0);
		int2lcdyx(sk_cnt[3],3,14,0);
		int2lcdyx(sk_stat[0],0,10,0);
		int2lcdyx(sk_stat[1],1,10,0);
		int2lcdyx(sk_stat[2],2,10,0);
		int2lcdyx(sk_stat[3],3,10,0);

    		}
    else if(sub_ind==8)
     	{
     	bgnd_par("                    ",
     		    "                    ",
     		    "                    ",
     		    "                    ");
     	int2lcdyx(ibt._T[0],0,2,0);
		int2lcdyx(ibt._T[1],1,2,0);
     	int2lcdyx(ibt._T[2],2,2,0);
		int2lcdyx(ibt._T[3],3,2,0);
		
     	int2lcdyx(ibt._nd[0],0,4,0);
		int2lcdyx(ibt._nd[1],1,4,0);
     	int2lcdyx(ibt._nd[2],2,4,0);
		int2lcdyx(ibt._nd[3],3,4,0);	    

     	int2lcdyx(ibt._T_dispers[0],0,7,0);
		int2lcdyx(ibt._T_dispers[1],1,7,0);
     	int2lcdyx(ibt._T_dispers[2],2,7,0);
		int2lcdyx(ibt._T_dispers[3],3,7,0);
			    
		int2lcdyx(ibt._avg1,0,19,0);
		int2lcdyx(ibt._max_dispers_num,1,19,0);
		int2lcdyx(t_box,3,19,0);
     	}		     	

    else if(sub_ind==10)
     	{
     	bgnd_par("LB                  ",
     		    "                    ",
     		    "                    ",
     		    "                    ");

     	int2lcdyx(sub_ind1+1,0,3,0);

		//int2lcdyx(lakb[sub_ind1]._bRS485ERR,3,16,0);
		//int2lcdyx(lakb[sub_ind1]._rs485_cnt,3,19,0); 
		
     	}	

    else if(sub_ind==11)
     	{
     	bgnd_par("LB                  ",
     		    "                    ",
     		    "                    ",
     		    "                    ");

     	int2lcdyx(sub_ind,0,1,0);
		
		int2lcdyx(u_necc,0,5,0);

		int2lcdyx(load_U,0,11,0);
//int2lcdyx(ccc_plazma[2],3,12,0);
		//int2lcdyx(ccc_plazma[3],1,16,0);  
		//int2lcdyx(ccc_plazma[4],2,16,0);  
		//int2lcdyx(ccc_plazma[5],3,16,0); 

		int2lcdyx(li_bat._canErrorCnt,2,5,0);
		int2lcdyx(li_bat._canError,2,8,0);
		int2lcdyx(li_bat._485ErrorCnt,3,5,0);
		int2lcdyx(li_bat._485Error,3,8,0);
			
		/*int2lcdyx(lakb[sub_ind1]._cnt,0,6,0);

		int2lcdyx(lakb[sub_ind1]._max_cell_temp,0,14,0);
		int2lcdyx(lakb[sub_ind1]._min_cell_temp,0,19,0);

		int2lcdyx(lakb[sub_ind1]._max_cell_volt,1,4,0);
		int2lcdyx(lakb[sub_ind1]._min_cell_volt,1,9,0);
		int2lcdyx(lakb[sub_ind1]._tot_bat_volt,1,14,0);
		int2lcdyx(lakb[sub_ind1]._s_o_h,1,19,0);

		int2lcdyx(lakb[sub_ind1]._ch_curr,2,4,0);
		int2lcdyx(lakb[sub_ind1]._dsch_curr,2,9,0);
		int2lcdyx(lakb[sub_ind1]._rat_cap,2,14,0);
		int2lcdyx(lakb[sub_ind1]._s_o_c,2,19,0);

		int2lcdyx(lakb[sub_ind1]._c_c_l_v,3,4,0);
		int2lcdyx(lakb[sub_ind1]._r_b_t,3,9,0);
		int2lcdyx(lakb[sub_ind1]._b_p_ser_num,3,14,0);
		int2lcdyx(lakb[sub_ind1]._bRS485ERR,3,16,0);
		 */
		
     	}	
    else if(sub_ind==12)
     	{
     	bgnd_par(	"ica                 ",
     		    	"                    ",
     		    	"                    ",
     		    	"                    ");
		int2lcdyx(ica_my_current,1,4,0);
     	int2lcdyx(ica_your_current,2,4,0);
     	int2lcdyx(ica_timer_cnt,1,14,0);


		int2lcdyx(ica_plazma[0],0,15,0);
     	int2lcdyx(ica_plazma[1],1,15,0);
     	int2lcdyx(ica_plazma[2],2,15,0);
     	int2lcdyx(ica_plazma[3],3,15,0);
     	int2lcdyx(ica_plazma[4],0,19,0);
		int2lcdyx(ica_plazma[5],1,19,0);
     	int2lcdyx(ica_plazma[6],2,19,0);
     	int2lcdyx(ica_plazma[7],3,19,0);

 
		int2lcdyx(ica_u_necc+50,0,10,0);
		int2lcdyx(u_necc,1,10,0);

		int2lcdyx(bps_U,2,10,0);


     	//int2lcdyx(ica_plazma[8],3,15,0);
     	//int2lcdyx(ica_plazma[9],3,19,0); */
 
		
     	}	     			
     }






	
else if(ind==iAvt_set_sel)
	{
	ptrs[0]=						" ��� N1             ";
     ptrs[1]=						" ��� N2             ";
     ptrs[2]=						" ��� N3             ";
	ptrs[3]=						" ��� N4             ";
     ptrs[4]=						" ��� N5             ";
     ptrs[5]=						" ��� N6             ";
	ptrs[6]=						" ��� N7             ";
     ptrs[7]=						" ��� N8             ";
     ptrs[8]=						" ��� N9             ";
	ptrs[9]=						" ��� N10            ";
     ptrs[10]=						" ��� N11            ";
     ptrs[11]=						" ��� N12            ";               
	ptrs[NUMIST]=					" �����              ";
	ptrs[1+NUMIST]=				"                    ";
	ptrs[2+NUMIST]=				"                    ";


	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(				"��������� ����������",
						" ���������� ������  ",
						ptrs[index_set],
						ptrs[index_set+1]);
	pointer_set(2);

	}		 

else if(ind==iAvt_set)
	{
	ptrs[0]=" U����� =   $�      ";
	if(bFL_)
		{
		ptrs[1]=" ���������� U�����  ";
     	ptrs[2]="  �������� � ��� �  ";
     	}
     else 
     	{
		ptrs[1]=" ����������� � ���  ";
     	ptrs[2]="    �����������     ";     	
     	}	

     ptrs[3]=sm_exit;
     ptrs[4]=sm_;
     ptrs[5]=sm_;     	     	    
	

     if((sub_ind==0)||(sub_ind==1)||(sub_ind==2))index_set=0;
	else index_set=3;
	
	bgnd_par("       ��� N!      ",ptrs[index_set],ptrs[index_set+1],ptrs[index_set+2]);

	pointer_set(1);	
	int2lcd(sub_ind1+1,'!',0);
	int2lcd(U_AVT,'$',1);
	 
	
     if(sub_ind==0)
		{
        mess_send(MESS2BPS_HNDL,PARAM_BPS_MASK_ON_OFF_AFTER_2SEC,(1<<sub_ind1),10);
        mess_send(MESS2BAT_HNDL,PARAM_BAT_ALL_OFF_AFTER_2SEC,0,40);
        mess_send(MESS2UNECC_HNDL,PARAM_UNECC_SET,U_AVT,10);
	    mess_send(MESS2CNTRL_HNDL,PARAM_CNTRL_STAT_FAST_REG,0,10);

        }

 	if(mess_find( (MESS2IND_HNDL)) && (mess_data[0]==PARAM_U_AVT_GOOD) )
		{
		sub_ind=3;
		show_mess(	"     ���������      ",
	          		"    ����������      ",
	          		" ���������� ������  ",
	          		"    �����������     ",3000);
		
		}
	//int2lcdyx(sub_ind,0,4,0);		      
	 }
else if(ind==iOut_volt_contr)
	{
	ptrs[0]=" U���max         !� ";
    ptrs[1]=" U���min         @� ";
    ptrs[2]=" T����.��.       #�.";     	
    ptrs[3]=sm_exit;
    ptrs[4]=sm_;
    ptrs[5]=sm_;     	     	    
	

	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	else if(sub_ind<index_set)index_set=sub_ind;
	
	bgnd_par(	"�������� ��������� ",
				"    ����������     ",
				ptrs[index_set],
				ptrs[index_set+1]);

	pointer_set(2);	
	int2lcd(U_OUT_KONTR_MAX,'!',1);
	int2lcd(U_OUT_KONTR_MIN,'@',1);
	int2lcd(U_OUT_KONTR_DELAY,'#',0);
	}
else if(ind==iDop_rele_set)
	{
	if(DOP_RELE_FUNC==0)
		{
		ptrs[0]=	" ���������          ";
		ptrs[1]=	" ����������� ������ ";
		}
	else /*if(DOP_RELE_FUNC==0)*/
		{
		ptrs[0]=	" ���������          ";
		ptrs[1]=	" ����������� �������";
		}
	ptrs[2]=		" �����              ";
	ptrs[3]=		"                    ";


	if((sub_ind-index_set)>1)index_set=sub_ind;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(			"��������������� ����",
						"  ����������������  ",
						ptrs[index_set],
						ptrs[index_set+1]);
	pointer_set(2);

	//int2lcdyx(sub_ind,0,6,0);
	//int2lcdyx(index_set,0,9,0);
	
	}

else if (ind==iIps_Curr_Avg_Set)
	{ 
	if(ICA_EN==0)
		{
		ptrs[0]=		" ���������          ";
		simax=1;
		}
	else 
		{
		ptrs[0]=		" ��������           ";
		if(ICA_CH==0)
			{
			ptrs[1]=	" �����  MODBUS-RTU  ";
			ptrs[2]=	" ����� ��������   ! ";
			simax=3;
			}
		else
			{
			ptrs[1]=	" �����   MODBUS-TCP ";
			ptrs[2]=	" IP 00@.00#.00$.00% ";
			ptrs[3]=	" ����� ��������   ^ ";
			simax=4;
			}
		} 
	ptrs[simax]=		" �����              ";
	
	if(sub_ind<index_set) index_set=sub_ind;
	else if((sub_ind-index_set)>1) index_set=sub_ind-1;	
	bgnd_par(	" ������������ ����� ",
				"        ���         ",
				ptrs[index_set],
				ptrs[index_set+1]);
	
	pointer_set(2);
	int2lcd(ICA_MODBUS_ADDRESS,'!',0);
	if((sub_ind==2)&&(sub_ind1==0)&&bFL2)sub_bgnd("   ",'@',-2);
	else int2lcd(ICA_MODBUS_TCP_IP1,'@',0);
	if((sub_ind==2)&&(sub_ind1==1)&&bFL2)sub_bgnd("   ",'#',-2);
	else int2lcd(ICA_MODBUS_TCP_IP2,'#',0);
	if((sub_ind==2)&&(sub_ind1==2)&&bFL2)sub_bgnd("   ",'$',-2);
	else int2lcd(ICA_MODBUS_TCP_IP3,'$',0);
	if((sub_ind==2)&&(sub_ind1==3)&&bFL2)sub_bgnd("   ",'%',-2);
	else int2lcd(ICA_MODBUS_TCP_IP4,'%',0);
	int2lcd(ICA_MODBUS_TCP_UNIT_ID,'^',0);	
     
 	} 

/*
const char sm7[]	={" �������� N2        "}; //
const char sm8[]	={" ��������           "}; //
const char sm9[]	={" ����               "}; //
const char sm10[]	={" �����������        "}; // 
const char sm11[]	={" ������ ������      "}; //
const char sm12[]	=" ���������� ������  "}; //
const cha		=" �������            "}; //
*/


//char2lcdhyx(bat_rel_stat[0],0,10);
//char2lcdhyx(bat_rel_stat[1],0,15);
//int2lcdyx(u_necc,0,19,0);
//int2lcdyx(cntrl_stat,0,5,0); 	   mess_cnt[i]

//char2lcdhyx(bat_rel_stat[0],0,5);
//char2lcdhyx(bat_rel_stat[1],0,10);
//int2lcdyx(mess_cnt[1],0,2,0);
//int2lcdyx(GET_REG(IOPIN1,21,1),0,5,0); 
//int2lcdyx(samokalibr_cnt,0,10,0);
//char2lcdhyx(rele_stat,0,19);
//char2lcdhyx(mess_cnt[1],0,16); 

//int2lcdyx(ad7705_res1,0,8,0);
//int2lcdyx(ad7705_res2,0,16,0); 
//	int2lcdyx(bat[0]._cnt_to_block,0,1,0);
//	int2lcdyx(bat[1]._cnt_to_block,0,3,0);
//	int2lcdyx(bat[0]._rel_stat,0,5,0);
/*	int2lcdyx(ind,0,3,0); 
	int2lcdyx(sub_ind,0,6,0);
	int2lcdyx(index_set,0,9,0);
	int2lcdyx(ptr_ind,0,14,0);
	;*/
/*int2lcdyx(ind,0,19,0);
int2lcdyx(retindsec,0,15,0);
int2lcdyx(retcnt,0,11,0);
int2lcdyx(retcntsec,0,7,0);	*/
//int2lcdyx(bps[0]._vol_i,0,15,0);
//int2lcdyx(cntrl_stat,0,19,0); 
//int2lcdyx(bps[0]._Uin,0,4,0);
}							    


#define BUT0	16
#define BUT1	17
#define BUT2	18
#define BUT3	19
#define BUT4	20   
#define BUT_MASK (1UL<<BUT0)|(1UL<<BUT1)|(1UL<<BUT2)|(1UL<<BUT3)|(1UL<<BUT4)

#define BUT_ON 4
#define BUT_ONL 20 

#define butLUR_  101
#define butU   253
#define butU_  125
#define butD   251
#define butD_  123
#define butL   247
#define butL_  119
#define butR   239
#define butR_  111
#define butE   254
#define butE_  126
#define butEL_  118
#define butUD  249
#define butUD_  121
#define butLR   231
#define butLR_   103
#define butED_  122
#define butDR_  107
#define butDL_  115

#define BUT_ON 4
#define BUT_ONL 20 
//-----------------------------------------------
void but_drv(void)
{
char i;
LPC_GPIO1->FIODIR|=(1<<21);
LPC_GPIO1->FIOPIN&=~(1<<21);
LPC_GPIO1->FIODIR&=~((1<<22)|(1<<23)|(1<<24)|(1<<25)|(1<<26));
LPC_PINCON->PINMODE3&=~((1<<12)|(1<<13)|(1<<14)|(1<<15)|(1<<16)|(1<<17)|(1<<18)|(1<<19)|(1<<20)|(1<<21));

LPC_GPIO2->FIODIR|=(1<<8);
LPC_GPIO2->FIOPIN&=~(1<<8);
for(i=0;i<200;i++)
{
__nop();
__nop();
__nop();
__nop();
__nop();
__nop();
__nop();
__nop();
}

			LPC_GPIO2->FIODIR|=(1<<8);
			LPC_GPIO2->FIOPIN|=(1<<8);

but_n=((LPC_GPIO1->FIOPIN|(~((1<<22)|(1<<23)|(1<<24)|(1<<25)|(1<<26))))>>22)/*&0x0000001f*/;



if((but_n==1023UL)||(but_n!=but_s))
 	{
	speed=0;
 
   	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
  		{
   	     n_but=1;
          but=but_s;

          }
   	if (but1_cnt>=but_onL_temp)
  		{
   	     n_but=1;
 
          but=but_s&0x7f;
          }
    	l_but=0;
   	but_onL_temp=BUT_ONL;
    	but0_cnt=0;
  	but1_cnt=0;          
     goto but_drv_out;
  	}
else if(but_n==but_s)
 	{
  	but0_cnt++;
  	if(but0_cnt>=BUT_ON)
  		{
   		but0_cnt=0;
   		but1_cnt++;
   		if(but1_cnt>=but_onL_temp)
   			{              
    			but=but_s&0x7f;
    			but1_cnt=0;
    			n_but=1;
    			     
    			l_but=1;
			if(speed)
				{
    				but_onL_temp=but_onL_temp>>1;
        			if(but_onL_temp<=2) but_onL_temp=2;
				}    
   			}
  		}
 	}
but_drv_out: 
but_s=but_n; 
   
}

//-----------------------------------------------
void but_an(void)
{
signed short temp_SS;
//signed short /*deep,i,cap,*/ptr;
//char av_head[4];
if(!n_but)return;
/*else  					
	{
	plazma_but_an++;
	goto but_an_end;
	}*/
av_beep=0x0000;
av_rele=0x0000;
mnemo_cnt=MNEMO_TIME;
ips_bat_av_stat=0;
//bat_ips._av&=~1;

if((main_1Hz_cnt<10)&&((but==butU)||(but==butU_)||(but==butD)||(but==butD_)||(but==butL)||(but==butL_)||(but==butR)||(but==butR_)||(but==butE)||(but==butE_)))
	{
	__ee_spc_stat=spcOFF;
	spc_stat=spcOFF;
	}
if(but==butUD)
     {
     if(ind!=iDeb)
          {
		c_ind=a_ind;
		tree_up(iDeb,5,0,0);
		
          }
     else 
          {
		tree_down(0,0);
          }
		
		     
     }
else if(but==butLR)
	{
	bSILENT=1;
	beep_init(0x00000000,'S');
	}
else if(but==butUD_)
     {
	//avar_bat_as_hndl(0,1);
	}

else if(but==butED_)
     {
	if(!bCAN_OFF)bCAN_OFF=1;
	else bCAN_OFF=0;
	speed=0;
	}

else if(ind==iDeb)
	{
	if(but==butR)
		{
		sub_ind++;
		index_set=0;
		gran_ring_char(&sub_ind,0,12);
		}
	else if(but==butL)
		{
		sub_ind--;
		index_set=0;
		gran_ring_char(&sub_ind,0,12);
		}
		
	else if(sub_ind==1)
		{
		if(but==butU)
	     	{
	     	sub_ind1--;
	     	gran_char(&sub_ind1,0,30);
	     	}
		if(but==butD)
	     	{
	     	sub_ind1++;
	     	gran_char(&sub_ind1,0,30);
	     	}
	     
		if(but==butE)
	     	{
	     	/*SET_REG(C2GSR,3,24,8);
			C2MOD=0;
			 bOUT_FREE2=1;*/

			 // CAN interface 1, use IRQVec7, at 125kbit
//can2_init(7,8,CANBitrate250k_60MHz);

// Receive message with ID 102h on CAN 1
//FullCAN_SetFilter(2,0x18e);
			 }

		if(but==butE)
	     	{
			//lc640_write_int(EE_BAT1_ZAR_CNT,10);
			ind_pointer=0;
			ind=(i_enum)0;
			sub_ind=0;
			sub_ind1=0;
			sub_ind2=0;
			index_set=0;
			}
	     
			
		} 

	 else if(sub_ind==5)
	 	{
		if(but==butE_)	numOfForvardBps_init();
		}
				
	 else if(sub_ind==5)
	 	{
		if(but==butE_)
		{
		//can1_init(BITRATE62_5K6_25MHZ);
		//FullCAN_SetFilter(0,0x18e);
		LPC_CAN1->MOD&=~(1<<0);
		}
		}

	else if(sub_ind==1)
		{
		if(but==butU)
	     	{
	     	sub_ind1--;
	     	gran_char(&sub_ind1,0,1);
	     	}
		if(but==butD)
	     	{
	     	sub_ind1++;
	     	gran_char(&sub_ind1,0,1);
	     	}
		}		
		
		
			
     else if(but==butU)
	     {
	     index_set--;
	     gran_char(&index_set,0,4);
	     //lc640_write_int(ptr_ki_src[0],lc640_read_int(ptr_ki_src[0])+10);
	     }	
     else if(but==butD)
	     {
	     index_set++;
	     gran_char(&index_set,0,4); 
	     //lc640_write_int(ptr_ki_src[0],lc640_read_int(ptr_ki_src[0])-10);
	     }	
     else if(but==butE)
         	{
          //a=b[--ptr_ind];
          //can1_out(1,2,3,4,5,6,7,8);
          }   
          
     else if(but==butE_)
         	{
          //a=b[--ptr_ind];
//          can1_out_adr(TXBUFF,3);
          }                      				
	}

else if(ind==iMn)
	{
	if(but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,8);
		}
		
	else if(but==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,8);
		}	

	else if(but==butR)
		{
		//ind=iMn;
		sub_ind=0;

		}
	else if(but==butL)
		{
		//ind=iMn;
		sub_ind=0;

		}
	else if(but==butD_)
		{
		sub_ind=0;
		}

	else if(but==butLR_)
		{
		if(klbr_en)klbr_en=0;
		else klbr_en=1;
		}
				
	else if(but==butE)
		{
		if(sub_ind==0) 
			{
			}
		else if(sub_ind==1)
			{
			tree_up(iSet_T,0,0,0);
			//tree_up(iSet_T_ret,0,0,0);
			//ret_ind(20,-1);
			}
		else if(sub_ind==2)
			{
			tree_up(iInterf_kontr,0,0,0);
			}
		else if(sub_ind==3)
			{
			tree_up(iOptr_kontr,0,0,0);
			}

		else if(sub_ind==4)
			{
			tree_up(iAir_sensor_kontr,0,0,0);
			}
		else if(sub_ind==5)
			{
			tree_up(iWater_sensor_kontr,0,0,0);
			}
		else if(sub_ind==6)
			{
			tree_up(iProbesms,0,0,0);
			}
		else if(sub_ind==7)
			{
			tree_up(iPowerdown,0,0,0);
			}
		else if(sub_ind==8)
			{
			tree_up(iDefset,0,0,0);
			ret_ind(20,0);
			}

 		}

    }

else if(ind==iInterf_kontr)
	{
	if (but==butE)
	    {
		tree_up(iInterf_kontr_ret,0,0,0);
		ret_ind(10,-1);
	    }
	}

else if(ind==iOptr_kontr)
	{
	ret(1000);
	if (but==butU)
		{      
		sub_ind--;
		gran_char(&sub_ind,0,3);
		}
		
	else if (but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,3);
		}
	else if(sub_ind==0)
	     {
	     if(optr_stat[2]==osOFF)optr_stat[2]=osON;
		 else optr_stat[2]=osOFF; 
	     }
	else if(sub_ind==1)
	     {
	     if(optr_stat[1]==osOFF)optr_stat[1]=osON;
		 else optr_stat[1]=osOFF; 
	     }
	else if(sub_ind==2)
	     {
	     if(optr_stat[0]==osOFF)optr_stat[0]=osON;
		 else optr_stat[0]=osOFF; 
	     }
	else if((sub_ind==3)&&(but==butE))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	}


else if(ind==iWater_sensor_kontr)
	{
	if (but==butE)
	    {
		tree_up(iWater_sensor_kontr_ret,0,0,0);
		ret_ind(10,-1);
	    }
	}

else if(ind==iAir_sensor_kontr)
	{
	if (but==butE)
	    {
		tree_up(iAir_sensor_kontr_ret,0,0,0);
		ret_ind(10,-1);
	    }
	}
else if(ind==iProbesms)
	{
	if (but==butE) tree_down(0,0);
    }
else if(ind==iPowerdown)
	{
	if (but==butE)
	    {
		tree_up(iPowerdown_ret,0,0,0);
		ret_ind(20,-1);
	    }
	}

else if(ind==iSet_T)
	{
	signed char temp;
	if((but==butR)&&(sub_ind>=0)&&(sub_ind<=5))
		{
		sub_ind++;
		gran_char(&sub_ind,0,5);
		}
	else if((but==butL)&&(sub_ind>=0)&&(sub_ind<=5))
		{
		sub_ind--;
		gran_char(&sub_ind,0,5);
		}
	else if(but==butE)
		{
		tree_up(iSet_T_ret,0,0,0);
		ret_ind(10,-1);
		//tree_down(0,0);
		}
	else if(but==butLR_)
		{
		if((sub_ind>=0)&&(sub_ind<=5))sub_ind=10;
		else sub_ind=0;
		speed=0;
		}			
	else if(sub_ind==0)
	     {			    
	     temp=LPC_RTC->HOUR;
	     if((but==butU)||(but==butU_))
	          {
	          temp++;
	          gran_ring_char(&temp,0,23);
	          LPC_RTC->HOUR=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp--;
	          gran_ring_char(&temp,0,23);
	          LPC_RTC->HOUR=temp;
	          }	
	     speed=1;               
	     }
     else if(sub_ind==1)
	     {
	     temp=LPC_RTC->MIN;
	     if((but==butU)||(but==butU_))
	          {
	          temp++;
	          gran_ring_char(&temp,0,59);
	          LPC_RTC->MIN=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp--;
	          gran_ring_char(&temp,0,59);
	          LPC_RTC->MIN=temp;
	          }	
	     speed=1;               
	     }
 /*    else if(sub_ind==2)
	     {				  
	     temp=LPC_RTC->SEC;
	     if((but==butU)||(but==butU_))
	          {
	          temp=0;
	          gran_ring_char(&temp,0,59);
	          LPC_RTC->SEC=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp=0;
	          gran_ring_char(&temp,0,59);
	          LPC_RTC->SEC=temp;
	          }	
	     speed=1;               
	     } */

     else if(sub_ind==2)
	     {
	     temp=LPC_RTC->DOM;
	     if((but==butU)||(but==butU_))
	          {
	          temp++;
	          gran_ring_char(&temp,1,31);
	          LPC_RTC->DOM=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp--;
	          gran_ring_char(&temp,1,31);
	          LPC_RTC->DOM=temp;
	          }	
	     speed=1;               
	     }
     else if(sub_ind==3)
	     {
	     temp=LPC_RTC->MONTH;
	     if((but==butU)||(but==butU_))
	          {
	          temp++;
	          gran_ring_char(&temp,1,12);
	          LPC_RTC->MONTH=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp--;
	          gran_ring_char(&temp,1,12);
	          LPC_RTC->MONTH=temp;
	          }	
	     speed=1;               
	     }	  
     else if(sub_ind==4)
	     {
	     temp=LPC_RTC->YEAR;
	     if((but==butU)||(but==butU_))
	          {
	          temp++;
	          gran_ring_char(&temp,0,99);
	          LPC_RTC->YEAR=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp--;
	          gran_ring_char(&temp,0,99);
	          LPC_RTC->YEAR=temp;
	          }	
	     speed=1;               
	     }		 
	else if(sub_ind==5)
	     {
	     temp=LPC_RTC->DOW;
	     if((but==butU)||(but==butU_))
	          {
	          temp++;
	          gran_ring_char(&temp,0,6);
	          LPC_RTC->DOW=temp;
	          }
          else if((but==butD)||(but==butD_))
	          {
	          temp--;
	          gran_ring_char(&temp,0,6);
	          LPC_RTC->DOW=temp;
	          }	
	     speed=1;               
	     }	       
	}  

    






else if(ind==iTst_bps)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,3);
		tst_state[5]=tst1;
		tst_state[6]=tstOFF;
		
		if(sub_ind==2)
			{
			sub_ind=3;
			//index_set=2;
			}

		}

	else if(but==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,3);
		tst_state[5]=tst1;
		tst_state[6]=tstOFF;
		
		if(sub_ind==2)
			{
			sub_ind=1;
			//index_set=2;
			}
		}

	else if(sub_ind==0)
		{
		if(but==butR)
			{
			if(tst_state[5]==tstOFF)tst_state[5]=tst1;
			//else if(tst_state[5]==tst1)tst_state[5]=tst2;
			else tst_state[5]=tstOFF;
			}
		else if(but==butL)
			{
			if(tst_state[5]==tstOFF)tst_state[5]=tst1;
			//else if(tst_state[5]==tst1)tst_state[5]=tstOFF;
			else tst_state[5]=tstOFF;
			}
		}
	else if(sub_ind==1)
		{
		if((but==butE)||(but==butR))
			{
			if(tst_state[6]==tstOFF) tst_state[6]=tst1;
			//else if(tst_state[6]==tst1) tst_state[6]=tst2;
			else tst_state[6]=tstOFF;
			}
		else if(but==butL)
			{
			if(tst_state[6]==tstOFF) tst_state[6]=tst1;
			//else if(tst_state[6]==tstOFF) tst_state[6]=tst2;
			else tst_state[6]=tstOFF;
			}
		}		
		
	else if(sub_ind==3)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}	
	}

else if(ind==iKlimat)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,7);
	
		}

	else if(but==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,7);
		
		}
	else if(sub_ind==0)
	     {
	     if(but==butR)TBOXMAX++;
	     else if(but==butR_)TBOXMAX+=2;
	     else if(but==butL)TBOXMAX--;
	     else if(but==butL_)TBOXMAX-=2;
	     gran(&TBOXMAX,50,80);
	     lc640_write_int(EE_TBOXMAX,TBOXMAX);
	     speed=1;
	     }

	else if(sub_ind==1)
	     {
	     if(but==butR)TBOXVENTMAX++;
	     else if(but==butR_)TBOXVENTMAX+=2;
	     else if(but==butL)TBOXVENTMAX--;
	     else if(but==butL_)TBOXVENTMAX-=2;
	     gran(&TBOXVENTMAX,49,81);
	     lc640_write_int(EE_TBOXVENTMAX,TBOXVENTMAX);
	     speed=1;
	     }

	else if(sub_ind==2)
	     {
	     if(but==butR)TBOXREG++;
	     else if(but==butR_)TBOXREG+=2;
	     else if(but==butL)TBOXREG--;
	     else if(but==butL_)TBOXREG-=2;
	     gran(&TBOXREG,5,30);
	     lc640_write_int(EE_TBOXREG,TBOXREG);
	     speed=1;
	     }

	else if(sub_ind==3)
	     {
	     if(but==butR)TLOADDISABLE++;
	     else if(but==butR_)TLOADDISABLE+=2;
	     else if(but==butL)TLOADDISABLE--;
	     else if(but==butL_)TLOADDISABLE-=2;
	     gran(&TLOADDISABLE,49,81);
	     lc640_write_int(EE_TLOADDISABLE,TLOADDISABLE);
	     speed=1;
	     }

	else if(sub_ind==4)
	     {
	     if(but==butR)TLOADENABLE++;
	     else if(but==butR_)TLOADENABLE+=2;
	     else if(but==butL)TLOADENABLE--;
	     else if(but==butL_)TLOADENABLE-=2;
	     gran(&TLOADENABLE,44,TLOADDISABLE-5);
	     lc640_write_int(EE_TLOADENABLE,TLOADENABLE);
	     speed=1;
	     }

	else if(sub_ind==5)
	     {
	     if(but==butR)TBATDISABLE++;
	     else if(but==butR_)TBATDISABLE+=2;
	     else if(but==butL)TBATDISABLE--;
	     else if(but==butL_)TBATDISABLE-=2;
	     gran(&TBATDISABLE,49,91);
	     lc640_write_int(EE_TBATDISABLE,TBATDISABLE);
	     speed=1;
	     }

	else if(sub_ind==6)
	     {
	     if(but==butR)TBATENABLE++;
	     else if(but==butR_)TBATENABLE+=2;
	     else if(but==butL)TBATENABLE--;
	     else if(but==butL_)TBATENABLE-=2;
	     gran(&TBATENABLE,44,TBATDISABLE-5);
	     lc640_write_int(EE_TBATENABLE,TBATENABLE);
	     speed=1;
	     }
	else if(sub_ind==7)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	}

else if(ind==iKlimat_kontur)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,9);
	
		}

	else if(but==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,9);
		
		}
	else if(sub_ind==0)
	     {
	     if(but==butR)TBOXMAX++;
	     else if(but==butR_)TBOXMAX+=2;
	     else if(but==butL)TBOXMAX--;
	     else if(but==butL_)TBOXMAX-=2;
	     gran(&TBOXMAX,50,80);
	     lc640_write_int(EE_TBOXMAX,TBOXMAX);
	     speed=1;
	     }

/*	else if(sub_ind==1)
	     {
	     if(but==butR)TBOXVENTON++;
	     else if(but==butR_)TBOXVENTON+=2;
	     else if(but==butL)TBOXVENTON--;
	     else if(but==butL_)TBOXVENTON-=2;
	     gran(&TBOXVENTON,TBOXVENTOFF+2,150);
	     lc640_write_int(EE_TBOXVENTON,TBOXVENTON);
	     speed=1;
	     }

	else if(sub_ind==2)
	     {
	     if(but==butR)TBOXVENTOFF++;
	     else if(but==butR_)TBOXVENTOFF+=2;
	     else if(but==butL)TBOXVENTOFF--;
	     else if(but==butL_)TBOXVENTOFF-=2;
	     gran(&TBOXVENTOFF,TBOXWARMOFF+2,TBOXVENTON-2);
	     lc640_write_int(EE_TBOXVENTOFF,TBOXVENTOFF);
	     speed=1;
	     }  */
	else if(sub_ind==1)
	     {
	     if(but==butR)TBOXVENTMAX++;
	     else if(but==butR_)TBOXVENTMAX+=2;
	     else if(but==butL)TBOXVENTMAX--;
	     else if(but==butL_)TBOXVENTMAX-=2;
	     gran(&TBOXVENTMAX,49,81);
	     lc640_write_int(EE_TBOXVENTMAX,TBOXVENTMAX);
	     speed=1;
	     }

	else if(sub_ind==2)
	     {
	     if(but==butR)TBOXREG++;
	     else if(but==butR_)TBOXREG+=2;
	     else if(but==butL)TBOXREG--;
	     else if(but==butL_)TBOXREG-=2;
	     //gran(&TBOXREG,5,30);
		gran(&TBOXREG,0,50);
	     lc640_write_int(EE_TBOXREG,TBOXREG);
	     speed=1;
	     }


	else if(sub_ind==3)
	     {
	     if(but==butR)TBOXWARMON++;
	     else if(but==butR_)TBOXWARMON+=2;
	     else if(but==butL)TBOXWARMON--;
	     else if(but==butL_)TBOXWARMON-=2;
	     //gran(&TBOXWARMON,-20,20);
		gran(&TBOXWARMON,-50,50);
	     lc640_write_int(EE_TBOXWARMON,TBOXWARMON);
	     speed=1;
	     }

	else if(sub_ind==4)
	     {
	     if(but==butR)TBOXWARMOFF++;
	     else if(but==butR_)TBOXWARMOFF+=2;
	     else if(but==butL)TBOXWARMOFF--;
	     else if(but==butL_)TBOXWARMOFF-=2;
	     //gran(&TBOXWARMOFF,-20,20);
		gran(&TBOXWARMOFF,-50,50);
	     lc640_write_int(EE_TBOXWARMOFF,TBOXWARMOFF);
	     speed=1;
	     }

	else if(sub_ind==5)
	     {
	     if(but==butR)TLOADDISABLE++;
	     else if(but==butR_)TLOADDISABLE+=2;
	     else if(but==butL)TLOADDISABLE--;
	     else if(but==butL_)TLOADDISABLE-=2;
	     gran(&TLOADDISABLE,49,81);
	     lc640_write_int(EE_TLOADDISABLE,TLOADDISABLE);
	     speed=1;
	     }

	else if(sub_ind==6)
	     {
	     if(but==butR)TLOADENABLE++;
	     else if(but==butR_)TLOADENABLE+=2;
	     else if(but==butL)TLOADENABLE--;
	     else if(but==butL_)TLOADENABLE-=2;
	     gran(&TLOADENABLE,44,TLOADDISABLE-5);
	     lc640_write_int(EE_TLOADENABLE,TLOADENABLE);
	     speed=1;
	     }

	else if(sub_ind==7)
	     {
	     if(but==butR)TBATDISABLE++;
	     else if(but==butR_)TBATDISABLE+=2;
	     else if(but==butL)TBATDISABLE--;
	     else if(but==butL_)TBATDISABLE-=2;
	     gran(&TBATDISABLE,49,91);
	     lc640_write_int(EE_TBATDISABLE,TBATDISABLE);
	     speed=1;
	     }

	else if(sub_ind==8)
	     {
	     if(but==butR)TBATENABLE++;
	     else if(but==butR_)TBATENABLE+=2;
	     else if(but==butL)TBATENABLE--;
	     else if(but==butL_)TBATENABLE-=2;
	     gran(&TBATENABLE,44,TBATDISABLE-5);
	     lc640_write_int(EE_TBATENABLE,TBATENABLE);
	     speed=1;
	     }
	else if(sub_ind==9)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	}
#ifdef UKU_TELECORE2015
 else if(ind==iKlimat_TELECORE)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		if(sub_ind==1)
			{
			sub_ind++;
			index_set=1;
			}
		gran_char(&sub_ind,0,11);
		if(sub_ind==3)sub_ind++;
		gran_char(&sub_ind,0,11);	
		}

	else if(but==butU)
		{
		sub_ind--;
		if(sub_ind==1)sub_ind--;
		gran_char(&sub_ind,0,11);
		if(sub_ind==3)sub_ind--;
		gran_char(&sub_ind,0,11);
		
		}
	else if(sub_ind==0)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_WARM_SIGNAL++;
	     else if(but==butR_)TELECORE2015_KLIMAT_WARM_SIGNAL++;
	     else if(but==butL)TELECORE2015_KLIMAT_WARM_SIGNAL--;
	     else if(but==butL_)TELECORE2015_KLIMAT_WARM_SIGNAL--;
	     gran_ring(&TELECORE2015_KLIMAT_WARM_SIGNAL,0,1);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_WARM_SIGNAL,TELECORE2015_KLIMAT_WARM_SIGNAL);
	     speed=1;
	     }
	else if(sub_ind==2)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_VENT_SIGNAL++;
	     else if(but==butR_)TELECORE2015_KLIMAT_VENT_SIGNAL++;
	     else if(but==butL)TELECORE2015_KLIMAT_VENT_SIGNAL--;
	     else if(but==butL_)TELECORE2015_KLIMAT_VENT_SIGNAL--;
	     gran_ring(&TELECORE2015_KLIMAT_VENT_SIGNAL,0,1);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_VENT_SIGNAL,TELECORE2015_KLIMAT_VENT_SIGNAL);
	     speed=1;
	     }
	else if(sub_ind==4)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_WARM_ON++;
	     else if(but==butR_)TELECORE2015_KLIMAT_WARM_ON+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_WARM_ON--;
	     else if(but==butL_)TELECORE2015_KLIMAT_WARM_ON-=2;
	     gran(&TELECORE2015_KLIMAT_WARM_ON,-20,50);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_WARM_ON,TELECORE2015_KLIMAT_WARM_ON);
	     speed=1;
	     }

	else if(sub_ind==5)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_WARM_OFF++;
	     else if(but==butR_)TELECORE2015_KLIMAT_WARM_OFF+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_WARM_OFF--;
	     else if(but==butL_)TELECORE2015_KLIMAT_WARM_OFF-=2;
	     gran(&TELECORE2015_KLIMAT_WARM_OFF,-20,50);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_WARM_OFF,TELECORE2015_KLIMAT_WARM_OFF);
	     speed=1;
	     }


	else if(sub_ind==6)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_CAP++;
	     else if(but==butR_)TELECORE2015_KLIMAT_CAP+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_CAP--;
	     else if(but==butL_)TELECORE2015_KLIMAT_CAP-=2;
	     //gran(&TBOXWARMON,-20,20);
		gran(&TELECORE2015_KLIMAT_CAP,5,95);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_CAP,TELECORE2015_KLIMAT_CAP);
	     speed=1;
	     }

	else if(sub_ind==7)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_VENT_ON++;
	     else if(but==butR_)TELECORE2015_KLIMAT_VENT_ON+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_VENT_ON--;
	     else if(but==butL_)TELECORE2015_KLIMAT_VENT_ON-=2;
	     gran(&TELECORE2015_KLIMAT_VENT_ON,0,80);
		gran(&TELECORE2015_KLIMAT_VENT_ON,TELECORE2015_KLIMAT_VENT_OFF,80);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_VENT_ON,TELECORE2015_KLIMAT_VENT_ON);
	     speed=1;
	     }

	else if(sub_ind==8)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_VENT_OFF++;
	     else if(but==butR_)TELECORE2015_KLIMAT_VENT_OFF+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_VENT_OFF--;
	     else if(but==butL_)TELECORE2015_KLIMAT_VENT_OFF-=2;
	     gran(&TELECORE2015_KLIMAT_VENT_OFF,0,80);
		gran(&TELECORE2015_KLIMAT_VENT_OFF,0,TELECORE2015_KLIMAT_VENT_OFF);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_VENT_OFF,TELECORE2015_KLIMAT_VENT_OFF);
	     speed=1;
	     }
	else if(sub_ind==9)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_VVENT_ON++;
	     else if(but==butR_)TELECORE2015_KLIMAT_VVENT_ON+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_VVENT_ON--;
	     else if(but==butL_)TELECORE2015_KLIMAT_VVENT_ON-=2;
	     gran(&TELECORE2015_KLIMAT_VVENT_ON,0,80);
		gran(&TELECORE2015_KLIMAT_VVENT_ON,TELECORE2015_KLIMAT_VVENT_OFF,80);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_VVENT_ON,TELECORE2015_KLIMAT_VVENT_ON);
	     speed=1;
	     }

	else if(sub_ind==10)
	     {
	     if(but==butR)TELECORE2015_KLIMAT_VVENT_OFF++;
	     else if(but==butR_)TELECORE2015_KLIMAT_VVENT_OFF+=2;
	     else if(but==butL)TELECORE2015_KLIMAT_VVENT_OFF--;
	     else if(but==butL_)TELECORE2015_KLIMAT_VVENT_OFF-=2;
	     gran(&TELECORE2015_KLIMAT_VVENT_OFF,0,80);
		gran(&TELECORE2015_KLIMAT_VVENT_OFF,0,TELECORE2015_KLIMAT_VVENT_OFF);
	     lc640_write_int(EE_TELECORE2015_KLIMAT_VVENT_OFF,TELECORE2015_KLIMAT_VVENT_OFF);
	     speed=1;
	     }


	else if(sub_ind==11)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	}
#endif
#ifdef UKU_TELECORE2017
 else if(ind==iKlimat_TELECORE)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		if(sub_ind==1)
			{
			sub_ind++;
			index_set=1;
			}
		gran_char(&sub_ind,0,17);
		if(sub_ind==3)sub_ind++;
		gran_char(&sub_ind,0,17);	
		}

	else if(but==butU)
		{
		sub_ind--;
		if(sub_ind==1)sub_ind--;
		gran_char(&sub_ind,0,17);
 		}
	else if(but==butLR_)
		{
		lc640_write_int(EE_TELECORE2017_KLIMAT_WARM_SIGNAL,0);
		lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_SIGNAL,1);
		lc640_write_int(EE_TELECORE2017_KLIMAT_WARM_ON,10);
		lc640_write_int(EE_TELECORE2017_KLIMAT_WARM_OFF,30);
		lc640_write_int(EE_TELECORE2017_KLIMAT_CAP,30);
		//lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON0,30);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON20,40);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON40,50);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON60,60);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON80,70);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON100,80);
	    //lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON0,10);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON20,20);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON40,30);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON60,40);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON80,50);
	    lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON100,60);
 		}

	else if(sub_ind==0)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_WARM_SIGNAL++;
	     else if(but==butR_)TELECORE2017_KLIMAT_WARM_SIGNAL++;
	     else if(but==butL)TELECORE2017_KLIMAT_WARM_SIGNAL--;
	     else if(but==butL_)TELECORE2017_KLIMAT_WARM_SIGNAL--;
	     gran_ring(&TELECORE2017_KLIMAT_WARM_SIGNAL,0,1);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_WARM_SIGNAL,TELECORE2017_KLIMAT_WARM_SIGNAL);
	     speed=1;
	     }
	else if(sub_ind==2)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_SIGNAL++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_SIGNAL++;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_SIGNAL--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_SIGNAL--;
	     gran_ring(&TELECORE2017_KLIMAT_VENT_SIGNAL,0,1);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_SIGNAL,TELECORE2017_KLIMAT_VENT_SIGNAL);
	     speed=1;
	     }
	else if(sub_ind==4)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_WARM_ON++;
	     else if(but==butR_)TELECORE2017_KLIMAT_WARM_ON+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_WARM_ON--;
	     else if(but==butL_)TELECORE2017_KLIMAT_WARM_ON-=2;
	     gran(&TELECORE2017_KLIMAT_WARM_ON,-20,50);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_WARM_ON,TELECORE2017_KLIMAT_WARM_ON);
	     speed=1;
	     }

	else if(sub_ind==5)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_WARM_OFF++;
	     else if(but==butR_)TELECORE2017_KLIMAT_WARM_OFF+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_WARM_OFF--;
	     else if(but==butL_)TELECORE2017_KLIMAT_WARM_OFF-=2;
	     gran(&TELECORE2017_KLIMAT_WARM_OFF,-20,50);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_WARM_OFF,TELECORE2017_KLIMAT_WARM_OFF);
	     speed=1;
	     }


	else if(sub_ind==6)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_CAP++;
	     else if(but==butR_)TELECORE2017_KLIMAT_CAP+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_CAP--;
	     else if(but==butL_)TELECORE2017_KLIMAT_CAP-=2;
	     gran(&TELECORE2017_KLIMAT_CAP,5,95);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_CAP,TELECORE2017_KLIMAT_CAP);
	     speed=1;
	     }

/*	else if(sub_ind==7)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_ON0++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_ON0+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_ON0--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_ON0-=2;
		 gran(&TELECORE2017_KLIMAT_VENT_ON0,0,TELECORE2017_KLIMAT_VENT_ON20);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON0,TELECORE2017_KLIMAT_VENT_ON0);
	     speed=1;
	     }*/


	else if(sub_ind==7)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_ON100++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_ON100+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_ON100--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_ON100-=2;
		 gran(&TELECORE2017_KLIMAT_VENT_ON100,TELECORE2017_KLIMAT_VENT_ON80,100);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON100,TELECORE2017_KLIMAT_VENT_ON100);
	     speed=1;
	     }
	else if(sub_ind==8)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_ON80++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_ON80+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_ON80--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_ON80-=2;
		 gran(&TELECORE2017_KLIMAT_VENT_ON80,TELECORE2017_KLIMAT_VENT_ON60,TELECORE2017_KLIMAT_VENT_ON100);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON80,TELECORE2017_KLIMAT_VENT_ON80);
	     speed=1;
	     }


	else if(sub_ind==9)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_ON60++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_ON60+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_ON60--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_ON60-=2;
		 gran(&TELECORE2017_KLIMAT_VENT_ON60,TELECORE2017_KLIMAT_VENT_ON40,TELECORE2017_KLIMAT_VENT_ON80);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON60,TELECORE2017_KLIMAT_VENT_ON60);
	     speed=1;
	     }

	else if(sub_ind==10)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_ON40++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_ON40+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_ON40--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_ON40-=2;
		 gran(&TELECORE2017_KLIMAT_VENT_ON40,TELECORE2017_KLIMAT_VENT_ON20,TELECORE2017_KLIMAT_VENT_ON60);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON40,TELECORE2017_KLIMAT_VENT_ON40);
	     speed=1;
	     }

	else if(sub_ind==11)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_VENT_ON20++;
	     else if(but==butR_)TELECORE2017_KLIMAT_VENT_ON20+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_VENT_ON20--;
	     else if(but==butL_)TELECORE2017_KLIMAT_VENT_ON20-=2;
		 gran(&TELECORE2017_KLIMAT_VENT_ON20,0,TELECORE2017_KLIMAT_VENT_ON40);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_VENT_ON20,TELECORE2017_KLIMAT_VENT_ON20);
	     speed=1;
	     }

/*	else if(sub_ind==12)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_DVENT_ON0++;
	     else if(but==butR_)TELECORE2017_KLIMAT_DVENT_ON0+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_DVENT_ON0--;
	     else if(but==butL_)TELECORE2017_KLIMAT_DVENT_ON0-=2;
		 gran(&TELECORE2017_KLIMAT_DVENT_ON0,0,TELECORE2017_KLIMAT_DVENT_ON20);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON0,TELECORE2017_KLIMAT_DVENT_ON0);
	     speed=1;
	     }*/

	else if(sub_ind==12)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_DVENT_ON100++;
	     else if(but==butR_)TELECORE2017_KLIMAT_DVENT_ON100+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_DVENT_ON100--;
	     else if(but==butL_)TELECORE2017_KLIMAT_DVENT_ON100-=2;
		 gran(&TELECORE2017_KLIMAT_DVENT_ON100,TELECORE2017_KLIMAT_DVENT_ON80,100);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON100,TELECORE2017_KLIMAT_DVENT_ON100);
	     speed=1;
	     }

	else if(sub_ind==13)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_DVENT_ON80++;
	     else if(but==butR_)TELECORE2017_KLIMAT_DVENT_ON80+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_DVENT_ON80--;
	     else if(but==butL_)TELECORE2017_KLIMAT_DVENT_ON80-=2;
		 gran(&TELECORE2017_KLIMAT_DVENT_ON80,TELECORE2017_KLIMAT_DVENT_ON60,TELECORE2017_KLIMAT_DVENT_ON100);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON80,TELECORE2017_KLIMAT_DVENT_ON80);
	     speed=1;
	     }

	else if(sub_ind==14)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_DVENT_ON60++;
	     else if(but==butR_)TELECORE2017_KLIMAT_DVENT_ON60+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_DVENT_ON60--;
	     else if(but==butL_)TELECORE2017_KLIMAT_DVENT_ON60-=2;
		 gran(&TELECORE2017_KLIMAT_DVENT_ON60,TELECORE2017_KLIMAT_DVENT_ON40,TELECORE2017_KLIMAT_DVENT_ON80);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON60,TELECORE2017_KLIMAT_DVENT_ON60);
	     speed=1;
	     }

	else if(sub_ind==15)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_DVENT_ON40++;
	     else if(but==butR_)TELECORE2017_KLIMAT_DVENT_ON40+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_DVENT_ON40--;
	     else if(but==butL_)TELECORE2017_KLIMAT_DVENT_ON40-=2;
		 gran(&TELECORE2017_KLIMAT_DVENT_ON40,TELECORE2017_KLIMAT_DVENT_ON20,TELECORE2017_KLIMAT_DVENT_ON60);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON40,TELECORE2017_KLIMAT_DVENT_ON40);
	     speed=1;
	     }

	else if(sub_ind==16)
	     {
	     if(but==butR)TELECORE2017_KLIMAT_DVENT_ON20++;
	     else if(but==butR_)TELECORE2017_KLIMAT_DVENT_ON20+=2;
	     else if(but==butL)TELECORE2017_KLIMAT_DVENT_ON20--;
	     else if(but==butL_)TELECORE2017_KLIMAT_DVENT_ON20-=2;
		 gran(&TELECORE2017_KLIMAT_DVENT_ON20,0,TELECORE2017_KLIMAT_DVENT_ON40);
	     lc640_write_int(EE_TELECORE2017_KLIMAT_DVENT_ON20,TELECORE2017_KLIMAT_DVENT_ON20);
	     speed=1;
	     }

	else if(sub_ind==17)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	}
#endif
else if(ind==iNpn_set)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,simax);
	
		}

	else if(but==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,simax);
		
		}
	else if(sub_ind==0)
	    {
	    if(NPN_OUT==npnoRELEVENT)NPN_OUT=npnoRELEAVBAT2;
		else if(NPN_OUT==npnoRELEAVBAT2)NPN_OUT=npnoOFF;
		else NPN_OUT=npnoRELEVENT;
	    lc640_write_int(EE_NPN_OUT,NPN_OUT);
	    
	    }
	else if(sub_ind==1)
	    {
		if(NPN_OUT==npnoOFF)
			{
			if(but==butE)			
				{
				tree_down(0,0);
				ret(0);
				}
			}
		else
			{
			/*if(NPN_SIGN==npnsAVNET)NPN_SIGN=npnsULOAD;
			else NPN_SIGN=npnsAVNET;
			lc640_write_int(EE_NPN_SIGN,NPN_SIGN);*/

			if(but==butR)UONPN++;
	     	else if(but==butR_)UONPN+=2;
	     	else if(but==butL)UONPN--;
	     	else if(but==butL_)UONPN-=2;
	     	gran(&UONPN,100,2500);
	     	lc640_write_int(EE_UONPN,UONPN);
	     	speed=1;

			}
		}
	else if(sub_ind==2)
		{
/*		if(NPN_SIGN==npnsULOAD)
			{
			if(but==butR)UONPN++;
	     	else if(but==butR_)UONPN+=2;
	     	else if(but==butL)UONPN--;
	     	else if(but==butL_)UONPN-=2;
	     	gran(&UONPN,100,2500);
	     	lc640_write_int(EE_UONPN,UONPN);
	     	speed=1;
			}
		else 
			{
			if(but==butR)TZNPN++;
	     	else if(but==butR_)TZNPN+=2;
	     	else if(but==butL)TZNPN--;
	     	else if(but==butL_)TZNPN-=2;
	     	gran(&TZNPN,10,60);
	     	lc640_write_int(EE_TZNPN,TZNPN);
	     	speed=1;
			}*/

			if(but==butR)UVNPN++;
	     	else if(but==butR_)UVNPN+=2;
	     	else if(but==butL)UVNPN--;
	     	else if(but==butL_)UVNPN-=2;
	     	gran(&UVNPN,100,2500);
	     	lc640_write_int(EE_UVNPN,UVNPN);
	     	speed=1;
		}
	else if(sub_ind==3)
		{
/*		if(NPN_SIGN==npnsULOAD)
			{
			if(but==butR)UVNPN++;
	     	else if(but==butR_)UVNPN+=2;
	     	else if(but==butL)UVNPN--;
	     	else if(but==butL_)UVNPN-=2;
	     	gran(&UVNPN,100,2500);
	     	lc640_write_int(EE_UVNPN,UVNPN);
	     	speed=1;
			}
		else 
			{
			if(but==butE)			
				{
				tree_down(0,0);
				ret(0);
				}
			}*/
			if(but==butR)TZNPN++;
	     	else if(but==butR_)TZNPN+=2;
	     	else if(but==butL)TZNPN--;
	     	else if(but==butL_)TZNPN-=2;
	     	gran(&TZNPN,10,60);
	     	lc640_write_int(EE_TZNPN,TZNPN);
	     	speed=1;
		}
	else if(sub_ind==4)
		{
/*		if(NPN_SIGN==npnsULOAD)
			{
			if(but==butR)TZNPN++;
	     	else if(but==butR_)TZNPN+=2;
	     	else if(but==butL)TZNPN--;
	     	else if(but==butL_)TZNPN-=2;
	     	gran(&TZNPN,10,60);
	     	lc640_write_int(EE_TZNPN,TZNPN);
	     	speed=1;
			}*/
			if(but==butE)			
				{
				tree_down(0,0);
				ret(0);
				}
		}
	else if(sub_ind==5)
		{
		if(NPN_SIGN==npnsULOAD)
			{
			if(but==butE)			
				{
				tree_down(0,0);
				ret(0);
				}
			}
		}


	}
else if(ind==iBps_list)
	{
//	ret_ind(0,0,0);
	if (but==butU)
		{      
		sub_ind1--;
		gran_char(&sub_ind1,0,NUMIST-2);
		}
		
	else if (but==butD)
		{
		sub_ind1++;
		gran_char(&sub_ind1,0,NUMIST-2);
		}

	else if (but==butD_)
		{
		sub_ind1=NUMIST-2;
		}
				
	else if(but==butR)
		{
		sub_ind++;
		gran_char(&sub_ind,0,3);
		}
				
	else if(but==butL)
		{
		sub_ind--;
		gran_char(&sub_ind,0,3);
		}
	else if(but==butE)
		{
		tree_down(0,0);
		}
		
	else if(but==butE_)
		{
		if(bAVG_BLOCK) bAVG_BLOCK=0;
		else bAVG_BLOCK=1;
		}						
	}
else if(ind==iAvt_set_sel)
	{
	ret(1000);
	if (but==butU)
		{      
		sub_ind--;
		gran_char(&sub_ind,0,NUMIST);
		}
		
	else if (but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,NUMIST);
		}
	else if((sub_ind>=0)&&(sub_ind<NUMIST))
		{
		if(but==butE)
			{
			tree_up(iAvt_set,0,0,sub_ind);
			}
		}
	else if(sub_ind==NUMIST)
		{
		if(but==butE)
			{
			tree_down(0,0);
			}	
		}
	}

else if(ind==iOut_volt_contr)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,3);
		}
	else if(but==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,3);
		}
	else if(but==butD_)
		{
		sub_ind=3;
		}
	else if(sub_ind==3)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	else if(sub_ind==0)
		{
		if(but==butR)U_OUT_KONTR_MAX++;
		else if(but==butR_)U_OUT_KONTR_MAX=(U_OUT_KONTR_MAX/5+1)*5;
		else if(but==butL)U_OUT_KONTR_MAX--;
		else if(but==butL_)U_OUT_KONTR_MAX=(U_OUT_KONTR_MAX/5-1)*5;
		gran(&U_OUT_KONTR_MAX,10,3000);
		lc640_write_int(EE_U_OUT_KONTR_MAX,U_OUT_KONTR_MAX);
		speed=1;
		}				

	else if(sub_ind==1)
		{
		if(but==butR)U_OUT_KONTR_MIN++;
		else if(but==butR_)U_OUT_KONTR_MIN=(U_OUT_KONTR_MIN/5+1)*5;
		else if(but==butL)U_OUT_KONTR_MIN--;
		else if(but==butL_)U_OUT_KONTR_MIN=(U_OUT_KONTR_MIN/5-1)*5;
		gran(&U_OUT_KONTR_MIN,10,3000);
		lc640_write_int(EE_U_OUT_KONTR_MIN,U_OUT_KONTR_MIN);
		speed=1;
		}				


	else if(sub_ind==2)
		{
		if(but==butR)U_OUT_KONTR_DELAY++;
	    else if(but==butR_)U_OUT_KONTR_DELAY+=2;
	    else if(but==butL)U_OUT_KONTR_DELAY--;
	    else if(but==butL_)U_OUT_KONTR_DELAY-=2;
	    gran(&U_OUT_KONTR_DELAY,5,100);
	    lc640_write_int(EE_U_OUT_KONTR_DELAY,U_OUT_KONTR_DELAY);
	    speed=1;
		}				


/*	
	int2lcd(U_BAT_KONTR_MAX,'!',1);
	int2lcd(U_BAT_KONTR_MIN,'@',1);
	int2lcd(U_BAT_KONTR_DELAY,'#',0);
	*/

	}

else if(ind==iDop_rele_set)
	{
	ret(1000);
	if(but==butD)
		{
		sub_ind+=2;
		gran_char(&sub_ind,0,2);
		}
	else if(but==butU)
		{
		sub_ind-=2;
		gran_char(&sub_ind,0,2);
		}
	else if(but==butD_)
		{
		sub_ind=2;
		}
	else if(sub_ind==2)
		{
		if(but==butE)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	else if(sub_ind==0)
		{
		if((but==butR)||(but==butR_))DOP_RELE_FUNC++;
		if((but==butL)||(but==butL_))DOP_RELE_FUNC--;
		gran(&DOP_RELE_FUNC,0,1);
		lc640_write_int(EE_DOP_RELE_FUNC,DOP_RELE_FUNC);
		speed=1;
		}				
	}

else if (ind==iIps_Curr_Avg_Set)
	{
     ret(1000);
	if(but==butD)
		{
		sub_ind++;
		sub_ind1=0;
		gran_char(&sub_ind,0,simax);
		}
	else if(but==butU)
		{
		sub_ind--;
		sub_ind1=0;
		gran_char(&sub_ind,0,simax);
		}
	else if(but==butD_)
		{
		sub_ind=simax;
		}			
	else if(sub_ind==simax)
		{
		if(but==butE)tree_down(0,0);
		}

	else if(sub_ind==0)
		{
		if(but==butE)
			{
			if(ICA_EN)ICA_EN=0;
			else ICA_EN=1;
			lc640_write_int(EE_ICA_EN,ICA_EN);
			}
		}
	else if(ICA_EN)
		{
		if(sub_ind==1)
			{
			if(but==butE)
				{
				if(ICA_CH)ICA_CH=0;
				else ICA_CH=1;
				lc640_write_int(EE_ICA_CH,ICA_CH);
				}
			}
		else if(ICA_CH==0)
			{
			if(sub_ind==2)
				{
				if((but==butR)||(but==butR_))
					{
					ICA_MODBUS_ADDRESS++;
					gran(&ICA_MODBUS_ADDRESS,1,254);
					lc640_write_int(EE_ICA_MODBUS_ADDRESS,ICA_MODBUS_ADDRESS);
					speed=1;
					}
				if((but==butL)||(but==butL_))
					{
					ICA_MODBUS_ADDRESS--;
					gran(&ICA_MODBUS_ADDRESS,1,254);
					lc640_write_int(EE_ICA_MODBUS_ADDRESS,ICA_MODBUS_ADDRESS);
					speed=1;
					}
				}
			}

		else if(ICA_CH==1)
			{
			if(sub_ind==2)
				{
				if((but==butE)||(but==butE_))
					{
					sub_ind1++;
					gran_ring_char(&sub_ind1,0,3);
					}
				else if(sub_ind1==0)
					{
					if((but==butR)||(but==butR_))
						{
						ICA_MODBUS_TCP_IP1++;
						gran_ring(&ICA_MODBUS_TCP_IP1,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP1,ICA_MODBUS_TCP_IP1);
						speed=1;
						}
					if((but==butL)||(but==butL_))
						{
						ICA_MODBUS_TCP_IP1--;
						gran(&ICA_MODBUS_TCP_IP1,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP1,ICA_MODBUS_TCP_IP1);
						speed=1;
						}
					}
				else if(sub_ind1==1)
					{
					if((but==butR)||(but==butR_))
						{
						ICA_MODBUS_TCP_IP2++;
						gran_ring(&ICA_MODBUS_TCP_IP2,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP2,ICA_MODBUS_TCP_IP2);
						speed=1;
						}
					if((but==butL)||(but==butL_))
						{
						ICA_MODBUS_TCP_IP2--;
						gran(&ICA_MODBUS_TCP_IP2,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP2,ICA_MODBUS_TCP_IP2);
						speed=1;
						}
					}
				else if(sub_ind1==2)
					{
					if((but==butR)||(but==butR_))
						{
						ICA_MODBUS_TCP_IP3++;
						gran_ring(&ICA_MODBUS_TCP_IP3,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP3,ICA_MODBUS_TCP_IP3);
						speed=1;
						}
					if((but==butL)||(but==butL_))
						{
						ICA_MODBUS_TCP_IP3--;
						gran(&ICA_MODBUS_TCP_IP3,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP3,ICA_MODBUS_TCP_IP3);
						speed=1;
						}
					}
				else if(sub_ind1==3)
					{
					if((but==butR)||(but==butR_))
						{
						ICA_MODBUS_TCP_IP4++;
						gran_ring(&ICA_MODBUS_TCP_IP4,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP4,ICA_MODBUS_TCP_IP4);
						speed=1;
						}
					if((but==butL)||(but==butL_))
						{
						ICA_MODBUS_TCP_IP4--;
						gran(&ICA_MODBUS_TCP_IP4,0,255);
						lc640_write_int(EE_ICA_MODBUS_TCP_IP4,ICA_MODBUS_TCP_IP4);
						speed=1;
						}
					}
				}
			if(sub_ind==3)
				{
				if((but==butR)||(but==butR_))
					{
					ICA_MODBUS_TCP_UNIT_ID++;
					gran(&ICA_MODBUS_TCP_UNIT_ID,1,254);
					lc640_write_int(EE_ICA_MODBUS_TCP_UNIT_ID,ICA_MODBUS_TCP_UNIT_ID);
					speed=1;
					}
				if((but==butL)||(but==butL_))
					{
					ICA_MODBUS_TCP_UNIT_ID--;
					gran(&ICA_MODBUS_TCP_UNIT_ID,1,254);
					lc640_write_int(EE_ICA_MODBUS_TCP_UNIT_ID,ICA_MODBUS_TCP_UNIT_ID);
					speed=1;
					}
				}
			}
		}


  	} 

		
//but_an_end:
n_but=0;
}

//-----------------------------------------------
void watchdog_enable (void) 
{
LPC_WDT->WDTC=2000000;
LPC_WDT->WDCLKSEL=0;
LPC_WDT->WDMOD=3;
LPC_WDT->WDFEED=0xaa;
LPC_WDT->WDFEED=0x55;
}

//-----------------------------------------------
void watchdog_reset (void) 
{
LPC_WDT->WDFEED=0xaa;
LPC_WDT->WDFEED=0x55;
}


//***********************************************
//***********************************************
//***********************************************
//***********************************************
//***********************************************
void SysTick_Handler (void) 	 /* SysTick Interrupt Handler (1ms)    */
{
//sys_plazma++;
b2000Hz=1;

if(bTPS)
	{
	LPC_GPIO1->FIODIR|=(1UL<<26);
	LPC_GPIO1->FIOPIN^=(1UL<<26);
	}

if(++t0cnt4>=2)
	{
t0cnt4=0;
b1000Hz=1;

	bFF=(char)(GET_REG(LPC_GPIO0->FIOPIN, 27, 1));
	if(bFF!=bFF_) hz_out++;
	bFF_=bFF;


if(++t0cnt5>=20)
     {
     t0cnt5=0;
     b50Hz=1;
     }
     
if(++t0cnt>=10)
     {
     t0cnt=0;
     b100Hz=1;

     hz_out_cnt++;
     if(hz_out_cnt>=500)
	     {	
	     hz_out_cnt=0;
	     net_F=hz_out;
	     hz_out=0;
	     }

     if(++t0cnt0>=10)
	     {
	     t0cnt0=0;
	     b10Hz=1;
		beep_drv();
		if(main_10Hz_cnt<10000) main_10Hz_cnt++;
	     }

     if(t0cnt0==5)
	     {
		//beep_drv();
	     }

     if(++t0cnt1>=20)
	     {
	     t0cnt1=0;
	     b5Hz=1;
		if(bFL5)bFL5=0;
		else bFL5=1;     
	     }

     if(++t0cnt2>=50)
	     {
	     t0cnt2=0;
	     b2Hz=1;
		if(bFL2)bFL2=0;
		else bFL2=1;

	     }         

     if(++t0cnt3>=100)
	     {
	     t0cnt3=0;
	     b1Hz=1;
		if(main_1Hz_cnt<10000) main_1Hz_cnt++;
		if(bFL)bFL=0;
		else bFL=1;

		t0cntMin++;
		if(t0cntMin>=60)
			{
			t0cntMin=0;
			b1min=1;
			}
	     }
     }

	}




//LPC_GPIO0->FIOCLR|=0x00000001;
  return;          



//LPC_GPIO0->FIOCLR|=0x00000001;
}


//***********************************************
__irq void timer0_interrupt(void) 
{	
/*if(BPS1_spa_leave)T0EMR_bit.EM1=0; 
else T0EMR_bit.EM1=1;
if(BPS2_spa_leave)T0EMR_bit.EM3=0; 
else T0EMR_bit.EM3=1;
T0IR = 0xff;*/
}

//===============================================
//===============================================
//===============================================
//===============================================
int main (void) 
{
char ind_reset_cnt=0;
//long i;
//char mac_adr[6] = { 0x00,0x73,0x04,50,60,70 };

//i=200000;
//while(--i){};

SystemInit();

bTPS=1;

SysTick->LOAD = (SystemFrequency / 2000) - 1;
SysTick->CTRL = 0x07;

//init_timer( 0,SystemFrequency/2000/4 - 1 ); // 1ms	
//enable_timer( 0 );

//rs232_data_out_1();



SET_REG(LPC_GPIO0->FIODIR, 0, 27, 1);
SET_REG(LPC_GPIO2->FIODIR, 1, 7, 1);
SET_REG(LPC_GPIO2->FIODIR, 1, 8, 1);
//LPC_GPIO1->FIODIR  |= 1<<27;                
	;
//FIO1MASK = 0x00000000;	 
//LPC_GPIO0->FIODIR  |= 1<<27;
//LPC_GPIO0->FIOSET  |= 1<<27;

///SET_REG(LPC_GPIO0->FIODIR,0,10,1); //���� ������� 
#ifdef UKU2071x
//SET_REG(LPC_GPIO3->FIODIR,1,SHIFT_REL_AV_NET,1);
//SET_REG(LPC_GPIO3->FIOCLR,1,SHIFT_REL_AV_NET,1);  // ���� ������ ���� ��� ���
#else 
//SET_REG(LPC_GPIO3->FIODIR,1,SHIFT_REL_AV_NET,1);
//SET_REG(LPC_GPIO3->FIOSET,1,SHIFT_REL_AV_NET,1);  // ���� ������ ���� ��� ���
#endif



ad7705_reset();
delay_ms(20);

ad7705_write(0x21);
ad7705_write(BIN8(1101)); 
ad7705_write(0x11);
ad7705_write(0x44);


ad7705_buff[0][1]=0x7fff;
ad7705_buff[0][2]=0x7fff;
ad7705_buff[0][3]=0x7fff;
ad7705_buff[0][4]=0x7fff;
ad7705_buff[0][5]=0x7fff;
ad7705_buff[0][6]=0x7fff;
ad7705_buff[0][7]=0x7fff;
ad7705_buff[0][8]=0x7fff;
ad7705_buff[0][9]=0x7fff;
ad7705_buff[0][10]=0x7fff;
ad7705_buff[0][11]=0x7fff;
ad7705_buff[0][12]=0x7fff;
ad7705_buff[0][13]=0x7fff;
ad7705_buff[0][14]=0x7fff;
ad7705_buff[0][15]=0x7fff;
ad7705_buff[1][1]=0x7fff;
ad7705_buff[1][2]=0x7fff;
ad7705_buff[1][3]=0x7fff;
ad7705_buff[1][4]=0x7fff;
ad7705_buff[1][5]=0x7fff;
ad7705_buff[1][6]=0x7fff;
ad7705_buff[1][7]=0x7fff;
ad7705_buff[1][8]=0x7fff;
ad7705_buff[1][9]=0x7fff;
ad7705_buff[1][10]=0x7fff;
ad7705_buff[1][11]=0x7fff;
ad7705_buff[1][12]=0x7fff;
ad7705_buff[1][13]=0x7fff;
ad7705_buff[1][14]=0x7fff;
ad7705_buff[1][15]=0x7fff;

ad7705_buff_[0]=0x7fff;
ad7705_buff_[1]=0x7fff;

/*
ad7705_reset();
delay_ms(20);

ad7705_write(0x20);
ad7705_write(BIN8(1101)); 
ad7705_write(0x10);
ad7705_write(0x44);

ad7705_reset();
delay_ms(20);  

ad7705_write(0x20);
ad7705_write(BIN8(1101)); 
ad7705_write(0x10);
ad7705_write(0x44); 

delay_ms(20); */




lcd_init();  
lcd_on();
lcd_clear();
		
///LPC_GPIO4->FIODIR |= (1<<29);           /* LEDs on PORT2 defined as Output    */
rtc_init();
///pwm_init();
ind=iMn;

//snmp_plazma=15;


//#ifdef ETHISON
//mac_adr[5]=*((char*)&AUSW_MAIN_NUMBER);
//mac_adr[4]=*(((char*)&AUSW_MAIN_NUMBER)+1);
//mac_adr[3]=*(((char*)&AUSW_MAIN_NUMBER)+2);
//mem_copy (own_hw_adr, mac_adr, 6);


//if(lc640_read_int(EE_ETH_IS_ON)==1)
	//{

	//bitmap_hndl();
	//lcd_out(lcd_bitmap);
	//init_TcpNet ();

	//init_ETH();
	//mem_copy (&localm[NETIF_ETH], &ip_config, sizeof(ip_config));

//	}
//#endif
//event2snmp(2);


//LPC_GPIO0->FIODIR |= (0x60000000);

adc_init();

LPC_GPIO0->FIODIR|=(1<<11);
LPC_GPIO0->FIOSET|=(1<<11);


lc640_write_int(100,134);




memo_read();



watchdog_enable();


sc16is700_init((uint32_t)(9600));


//lc640_write_int(EE_RELE_SET_MASK0,25);
  		
while (1)  
	{
	//bTPS=0; 
     //timer_poll ();
     //main_TcpNet ();

	//watchdog_reset();



/*	if(bRXIN0) 
		{
		bRXIN0=0;
	
		uart_in0();
		}  */

/*	if(bRXIN_SC16IS700) 
		{
		bRXIN_SC16IS700=0;
	
		uart_in_SC16IS700();
		}*/

	/*
	if(bRXIN1) 
		{
		bRXIN1=0;
	
		uart_in1();
		}*/ 
     if(b10000Hz)
		{
		b10000Hz=0; 
		

		}

     if(b2000Hz)
		{

		if(adc_window_cnt<200)adc_window_cnt++;

		b2000Hz=0; 
		adc_drv7();
		
		}

	if(b1000Hz)
		{
		b1000Hz=0;


		#ifdef SC16IS740_UART
		sc16is700_uart_hndl();
		#endif		
		}
	
	if(b100Hz)
		{
		b100Hz=0;

		//LPC_GPIO2->FIODIR|=(1<<7);
		//LPC_GPIO2->FIOPIN^=(1<<7);		

		if((!bRESET_INT_WDT)&&(!bRESET_EXT_WDT))but_drv();
		but_an();
		}
		 
	if(b50Hz)
		{
		b50Hz=0;
		//#ifdef MCP2515_CAN
		//net_drv_mcp2515();
		//#endif
		//#ifndef MCP2515_CAN
		net_drv();
		//#endif
		}

	if(b10Hz)
		{
//		char i;


		b10Hz=0;
				


		
		ind_hndl(); 
		#ifndef SIMULATOR
		bitmap_hndl();
		if(!bRESET_EXT_WDT)
			{
			lcd_out(lcd_bitmap);
			}
		#endif
		//ad7705_drv();
		//ad7705_write(0x20);

		adc_window_cnt=0;  

		ret_hndl();
		ret_ind_hndl();  
		mess_hndl();

					  

		//ret_hndl();
		//ext_drv();
		//avt_hndl();

		rele_in_drv();
		}

	if(b5Hz)
		{
		b5Hz=0;

		ad7705_drv();
  		memo_read();
		LPC_GPIO1->FIODIR|=(1UL<<26);
		matemat();
		
		rele_drv();
		
		//rele_hndl();
		//if(!bRESET_EXT_WDT)avar_hndl();
		//snmp_data();

		transmit_hndl();
  		}

	if(b2Hz)
		{
		b2Hz=0;

				//uart_out_adr1(dig,150);
		//sc16is700_wr_buff(CS16IS7xx_THR, 20);

		//sc16is700_wr_byte(CS16IS7xx_LCR, 0x80);
		//can1_out(cnt_net_drv,cnt_net_drv,GETTM,bps[cnt_net_drv]._flags_tu,*((char*)(&bps[cnt_net_drv]._vol_u)),*((char*)((&bps[cnt_net_drv]._vol_u))+1),*((char*)(&bps[cnt_net_drv]._vol_i)),*((char*)((&bps[cnt_net_drv]._vol_i))+1));
  		}

	if(b1Hz)
		{
		b1Hz=0;
		if(!bRESET_INT_WDT)
			{
			watchdog_reset();
			}
		//can1_out_adr((char*)&net_U,21);

		samokalibr_hndl();

		beep_hndl();

	

		plazma_plazma_plazma++;

		if(++ind_reset_cnt>=60)
			{
			ind_reset_cnt=0;
			lcd_init();
			lcd_on();
			lcd_clear();
			}
               


		  
		if(t_ext_can_nd<10) t_ext_can_nd++;
		
		//if(main_1Hz_cnt<200)main_1Hz_cnt++;


/*		#ifdef UKU_220_IPS_TERMOKOMPENSAT
		if((AUSW_MAIN==22063)||(AUSW_MAIN==22023)||(AUSW_MAIN==22043))rs232_data_out_tki();
		else if(AUSW_MAIN==22010)rs232_data_out_1();
		else rs232_data_out();
		#endif */	
 
		//modbus_registers_transmit(MODBUS_ADRESS,4,0,5);
		
	/*	putchar2(0x56);
		putchar2(0x57);
		putchar2(0x58);
		putchar2(0x59);
		putchar2(0x5a);*/


		//outVoltContrHndl();

		
		




		//printf("a %s \r\n","abc");
		//printf("a %s \r\n","abc");
		
		}
	if(b1min)
		{
		b1min=0;

		}

	}
}
