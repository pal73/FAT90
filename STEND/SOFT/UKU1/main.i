#line 1 "main.c"

















#line 1 "lcd_AGM1232_uku207_3.h"










#line 19 "lcd_AGM1232_uku207_3.h"




#line 32 "lcd_AGM1232_uku207_3.h"


void lcd1_chk(void);
void lcd1_wr(char in);
void lcd2_chk(void);
void lcd2_wr(char in);
char data1_wr(char in);
void data2_wr(char in);
void lcd_set_page(char in);
void lcd_set_col(char in);
void lcd_set_raw(char in);
void lcd_init(void);
void status(void);
void delay(void);
void ltstrobe(char in);
void lcd_init_(void);
void lcd_clear(void);
void lcd_on(void);
void lcd_off(void);
void lcd_out(char* adr);

#line 19 "main.c"
#line 1 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"









 




 

 


#line 27 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"







 typedef unsigned int   size_t;


typedef signed char     S8;
typedef unsigned char   U8;
typedef short           S16;
typedef unsigned short  U16;
typedef int             S32;
typedef unsigned int    U32;
typedef long long       S64;
typedef unsigned long long U64;
typedef unsigned char   BIT;
typedef unsigned int    BOOL;

#line 54 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"

#line 66 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"



 





 
typedef U32 OS_SEM[2];

 

typedef U32 OS_MBX[];

 
typedef U32 OS_MUT[3];

 
typedef U32 OS_TID;

 
typedef void *OS_ID;

 
typedef U32 OS_RESULT;

 












 




#line 194 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"



 



 
extern void      os_set_env    (void);
extern void      rt_sys_init   (void (*task)(void), U8 priority, void *stk);
extern void      rt_tsk_pass   (void);
extern OS_TID    rt_tsk_self   (void);
extern OS_RESULT rt_tsk_prio   (OS_TID task_id, U8 new_prio);
extern OS_TID    rt_tsk_create (void (*task)(void), U8 priority, void *stk, void *argv);
extern OS_RESULT rt_tsk_delete (OS_TID task_id);

#line 230 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"

extern void      _os_sys_init(U32 p, void (*task)(void), U32 prio_stksz,
                                     void *stk)                        __svc_indirect(0);
extern OS_TID    _os_tsk_create (U32 p, void (*task)(void), U32 prio_stksz,
                                        void *stk, void *argv)         __svc_indirect(0);
extern OS_TID    _os_tsk_create_ex (U32 p, void (*task)(void *), U32 prio_stksz,
                                           void *stk, void *argv)      __svc_indirect(0);
extern OS_TID    _os_tsk_self (U32 p)                                  __svc_indirect(0);
extern void      _os_tsk_pass (U32 p)                                  __svc_indirect(0);
extern OS_RESULT _os_tsk_prio (U32 p, OS_TID task_id, U8 new_prio)     __svc_indirect(0);
extern OS_RESULT _os_tsk_delete (U32 p, OS_TID task_id)                __svc_indirect(0);

 
extern OS_RESULT rt_evt_wait (U16 wait_flags,  U16 timeout, BOOL and_wait);
extern void      rt_evt_set  (U16 event_flags, OS_TID task_id);
extern void      rt_evt_clr  (U16 clear_flags, OS_TID task_id);
extern U16       rt_evt_get  (void);







extern OS_RESULT _os_evt_wait(U32 p, U16 wait_flags, U16 timeout,
                                     BOOL and_wait)                    __svc_indirect(0);
extern void      _os_evt_set (U32 p, U16 event_flags, OS_TID task_id)  __svc_indirect(0);
extern void      _os_evt_clr (U32 p, U16 clear_flags, OS_TID task_id)  __svc_indirect(0);
extern U16       _os_evt_get (U32 p)                                   __svc_indirect(0);
extern void      isr_evt_set (U16 event_flags, OS_TID task_id);

 
extern void      rt_sem_init (OS_ID semaphore, U16 token_count);
extern OS_RESULT rt_sem_send (OS_ID semaphore);
extern OS_RESULT rt_sem_wait (OS_ID semaphore, U16 timeout);





extern void      _os_sem_init (U32 p, OS_ID semaphore, 
                                      U16 token_count)                 __svc_indirect(0);
extern OS_RESULT _os_sem_send (U32 p, OS_ID semaphore)                 __svc_indirect(0);
extern OS_RESULT _os_sem_wait (U32 p, OS_ID semaphore, U16 timeout)    __svc_indirect(0);
extern void      isr_sem_send (OS_ID semaphore);

 
extern void      rt_mbx_init  (OS_ID mailbox, U16 mbx_size);
extern OS_RESULT rt_mbx_send  (OS_ID mailbox, void *p_msg,    U16 timeout);
extern OS_RESULT rt_mbx_wait  (OS_ID mailbox, void **message, U16 timeout);
extern OS_RESULT rt_mbx_check (OS_ID mailbox);







extern void      _os_mbx_init (U32 p, OS_ID mailbox, U16 mbx_size)     __svc_indirect(0);
extern OS_RESULT _os_mbx_send (U32 p, OS_ID mailbox, void *message_ptr,
                                      U16 timeout)                     __svc_indirect(0);
extern OS_RESULT _os_mbx_wait (U32 p, OS_ID mailbox, void  **message,
                                      U16 timeout)                     __svc_indirect(0);
extern OS_RESULT _os_mbx_check (U32 p, OS_ID mailbox)                  __svc_indirect(0);
extern void      isr_mbx_send (OS_ID mailbox, void *message_ptr);
extern OS_RESULT isr_mbx_receive (OS_ID mailbox, void **message);

 
extern void      rt_mut_init    (OS_ID mutex);
extern OS_RESULT rt_mut_release (OS_ID mutex);
extern OS_RESULT rt_mut_wait    (OS_ID mutex, U16 timeout);





extern void      _os_mut_init (U32 p, OS_ID mutex)                     __svc_indirect(0);
extern OS_RESULT _os_mut_release (U32 p, OS_ID mutex)                  __svc_indirect(0);
extern OS_RESULT _os_mut_wait (U32 p, OS_ID mutex, U16 timeout)        __svc_indirect(0);

 
extern void      rt_dly_wait (U16 delay_time);
extern void      rt_itv_set  (U16 interval_time);
extern void      rt_itv_wait (void);





extern void      _os_dly_wait (U32 p, U16 delay_time)                  __svc_indirect(0);
extern void      _os_itv_set (U32 p, U16 interval_time)                __svc_indirect(0);
extern void      _os_itv_wait (U32 p)                                  __svc_indirect(0);

 
extern OS_ID     rt_tmr_create (U16 tcnt, U16 info);
extern OS_ID     rt_tmr_kill   (OS_ID timer);




extern OS_ID     _os_tmr_create (U32 p, U16 tcnt, U16 info)            __svc_indirect(0);
extern OS_ID     _os_tmr_kill (U32 p, OS_ID timer)                     __svc_indirect(0);

 
extern void      rt_tsk_lock   (void);
extern void      rt_tsk_unlock (void);




extern void      _os_tsk_lock (U32 p)                                  __svc_indirect(0);
extern void      _os_tsk_unlock (U32 p)                                __svc_indirect(0);

 
extern int       _init_box (void *box_mem, U32 box_size, U32 blk_size);
extern void     *_alloc_box (void *box_mem);
extern void     *_calloc_box (void *box_mem);
extern int       _free_box (void *box_mem, void *box);








 




 

typedef struct {                         
  U8  hr;                                
  U8  min;                               
  U8  sec;                               
  U8  day;                               
  U8  mon;                               
  U16 year;                              
} RL_TIME;

typedef struct {                         
  S8  name[256];                         
  U32 size;                              
  U16 fileID;                            
  U8  attrib;                            
  RL_TIME time;                          
} FINFO;

extern int finit (void);
extern int fdelete (const char *filename);
extern int frename (const char *oldname, const char *newname);
extern int ffind (const char *pattern, FINFO *info);
extern U64 ffree (const char *drive);
extern int fformat (const char *drive);
extern int fanalyse (const char *drive);
extern int fcheck (const char *drive);
extern int fdefrag (const char *drive);

 




 

 



 






 
#line 415 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"

 
#line 428 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"

 





 
#line 442 "C:\\Keil\\ARM\\RV31\\INC\\rtl.h"

 




 



extern void init_TcpNet (void);
extern void main_TcpNet (void);
extern void timer_tick (void);
extern U8   udp_get_socket (U8 tos, U8 opt, 
                            U16 (*listener)(U8 socket, U8 *remip, U16 port, U8 *buf, U16 len));
extern BOOL udp_release_socket (U8 socket);
extern BOOL udp_open (U8 socket, U16 locport);
extern BOOL udp_close (U8 socket);
extern BOOL udp_mcast_ttl (U8 socket, U8 ttl);
extern U8  *udp_get_buf (U16 size);
extern BOOL udp_send (U8 socket, U8 *remip, U16 remport, U8 *buf, U16 dlen);
extern U8   tcp_get_socket (U8 type, U8 tos, U16 tout,
                            U16 (*listener)(U8 socket, U8 event, U8 *buf, U16 len));
extern BOOL tcp_release_socket (U8 socket);
extern BOOL tcp_listen (U8 socket, U16 locport);
extern BOOL tcp_connect (U8 socket, U8 *remip, U16 remport, U16 locport);
extern U8  *tcp_get_buf (U16 size);
extern U16  tcp_max_dsize (U8 socket);
extern BOOL tcp_check_send (U8 socket);
extern U8   tcp_get_state (U8 socket);
extern BOOL tcp_send (U8 socket, U8 *buf, U16 dlen);
extern BOOL tcp_close (U8 socket);
extern BOOL tcp_abort (U8 socket);
extern void tcp_reset_window (U8 socket);
extern BOOL arp_cache_ip (U8 *ipadr, U8 type);
extern void ppp_listen (char const *user, char const *passw);
extern void ppp_connect (char const *dialnum, char const *user, char const *passw);
extern void ppp_close (void);
extern BOOL ppp_is_up (void);
extern void slip_listen (void);
extern void slip_connect (char const *dialnum);
extern void slip_close (void);
extern BOOL slip_is_up (void);
extern U8   get_host_by_name (U8 *hostn, void (*cbfunc)(U8 event, U8 *host_ip));
extern BOOL smtp_connect (U8 *ipadr, U16 port, void (*cbfunc)(U8 event));
extern void dhcp_disable (void);
extern BOOL igmp_join (U8 *group_ip);
extern BOOL igmp_leave (U8 *group_ip);
extern BOOL snmp_trap (U8 *manager_ip, U8 gen_trap, U8 spec_trap, U16 *obj_list);
extern BOOL snmp_set_community (const char *community);






 
  

 
#line 20 "main.c"
#line 1 "type.h"










 
#line 1 "C:\\Keil\\ARM\\RV31\\INC\\stdint.h"
 
 





 









#line 25 "C:\\Keil\\ARM\\RV31\\INC\\stdint.h"







 

     

     
typedef   signed          char int8_t;
typedef   signed short     int int16_t;
typedef   signed           int int32_t;
typedef   signed       __int64 int64_t;

     
typedef unsigned          char uint8_t;
typedef unsigned short     int uint16_t;
typedef unsigned           int uint32_t;
typedef unsigned       __int64 uint64_t;

     

     
     
typedef   signed          char int_least8_t;
typedef   signed short     int int_least16_t;
typedef   signed           int int_least32_t;
typedef   signed       __int64 int_least64_t;

     
typedef unsigned          char uint_least8_t;
typedef unsigned short     int uint_least16_t;
typedef unsigned           int uint_least32_t;
typedef unsigned       __int64 uint_least64_t;

     

     
typedef   signed           int int_fast8_t;
typedef   signed           int int_fast16_t;
typedef   signed           int int_fast32_t;
typedef   signed       __int64 int_fast64_t;

     
typedef unsigned           int uint_fast8_t;
typedef unsigned           int uint_fast16_t;
typedef unsigned           int uint_fast32_t;
typedef unsigned       __int64 uint_fast64_t;

     
typedef   signed           int intptr_t;
typedef unsigned           int uintptr_t;

     
typedef   signed       __int64 intmax_t;
typedef unsigned       __int64 uintmax_t;




     

     





     





     





     

     





     





     





     

     





     





     





     

     


     


     


     

     


     


     


     

     



     



     


     
    
 



#line 196 "C:\\Keil\\ARM\\RV31\\INC\\stdint.h"

     







     










     











#line 260 "C:\\Keil\\ARM\\RV31\\INC\\stdint.h"



 


#line 13 "type.h"

















typedef enum {RESET = 0, SET = !RESET} FlagStatus, ITStatus;
typedef enum {DISABLE = 0, ENABLE = !DISABLE} FunctionalState;

#line 21 "main.c"
#line 1 "main.h"
#line 2 "main.h"

































#line 41 "main.h"





#line 58 "main.h"

#line 67 "main.h"






#line 80 "main.h"

#line 89 "main.h"











#line 106 "main.h"







#line 136 "main.h"





#line 151 "main.h"













#line 182 "main.h"

#line 220 "main.h"

#line 240 "main.h"























#line 410 "main.h"








































#line 478 "main.h"







		










#line 510 "main.h"

#line 524 "main.h"

#line 540 "main.h"





















#line 574 "main.h"

#line 588 "main.h"









 


#line 609 "main.h"

#line 619 "main.h"

#line 628 "main.h"

#line 637 "main.h"

#line 649 "main.h"

#line 659 "main.h"

#line 668 "main.h"

#line 676 "main.h"

#line 685 "main.h"

#line 697 "main.h"

#line 709 "main.h"



extern char b1000Hz,b100Hz,b50Hz,b10Hz,b5Hz,b2Hz,b1Hz;
extern short t0cnt,t0cnt0,t0cnt1,t0cnt2,t0cnt3,t0cnt4,t0cnt5,t0cnt6,t0_cnt7;
extern char bFL5,bFL2,bFL,bFL_;
extern signed short main_10Hz_cnt;
extern signed short main_1Hz_cnt;



extern char cnt_of_slave;







typedef enum {
	iMn,iWater_sensor_kontr,iWater_sensor_kontr_ret,iSet_T,iSet_T_ret,
	iAir_sensor_kontr,iAir_sensor_kontr_ret,
	iInterf_kontr,iInterf_kontr_ret,
	iOptr_kontr, iProbesms, iDefset,iPowerdown,
	iS2,iSet_prl,iK_prl,iDnd,
	iK, iK_220_IPS_TERMOKOMPENSAT,iK_220_IPS_TERMOKOMPENSAT_IB,iK_TELECORE,iK_VD,
	iSpcprl,iSpc,k,Crash_0,Crash_1,iKednd,iAKE,iSpc_termocompensat,
	iLoad,iAVAR,
	iVrs,iPrltst,iApv,
	iK_bps,iK_bps_sel,iK_bat_ips_termokompensat_ib,iK_bat_TELECORE,iK_bat_sel,iK_bat_sel_TELECORE,iK_load,iK_net,iK_net3,
	iSet_st_prl,iK_pdp,
	iDeb,
	iPrl_bat_in_out,iPrl_bat_in_sel,iPdp1,iJAv_sel,iJAv_net_sel,iJAv_net,iJAv_src1,
	iTst_bps, iAusw,iAusw_prl,iAusw_set,
	iK_t_ext,iK_t_3U,iK_t_ext_6U,
	iAv_view,
	iBatLogKe,iJ_bat_ke,iBatLogVz,iJ_bat_vz,iBatLogWrk,
	iExtern,
	iK_power_net,
	iExt_set,iExt_set_3U,
	iExt_dt,
	iExt_sk,iExt_sk_3U,
	iExt_ddv,iExt_ddi,iExt_dud,iSM,iKlimat,iKlimat_kontur,iKlimat_TELECORE,
	iEnerg3,iEnerg,
	iVent,
	iK_power_net3,
	iAvt,iLan_set,
	iNpn_set,
	iBps_list,
	iRele_set,iRele_set_,
	iAvt_set_sel,iAvt_set,iSet_li_bat,
	iOut_volt_contr,iDop_rele_set,iBlok_ips_set,iIps_Curr_Avg_Set}i_enum;

typedef struct  
{

i_enum i;
signed char s_i;
signed char s_i1;
signed char s_i2;
signed char i_s;
} stuct_ind;







extern stuct_ind a_ind,b_ind[10],c_ind;
extern signed short ptr_ind;
extern char lcd_buffer[200+100];
extern signed char parol[3];
extern char phase;
extern char lcd_bitmap[1024];
extern char dig[5];
extern signed short ind_pointer;
extern char zero_on;
extern char mnemo_cnt;
extern char simax;
extern short av_j_si_max;
extern const char ABCDEF[];
extern const char sm_mont[13][4]; 




extern signed short Ktsrc[2];
extern signed short Kusrc[2];
extern signed short Kisrc[2];
extern signed short Ki0src[2];
extern signed short Kubat[2];
extern signed short Kubatm[2];
extern unsigned short Kibat0[2];
extern signed short Kibat1[2];
extern signed short Ktbat[2];
extern signed short Kunet;
extern signed short Ktext[3];
extern signed short Kuload;
extern signed short Kunet_ext[3];
extern signed short KunetA;
extern signed short KunetB;
extern signed short KunetC;
extern signed short Kubps;
extern signed short Kuout;
extern signed short Kuvd;

extern signed short MAIN_IST;
extern signed short UMAX;
extern signed short UOUT;
extern signed short UOUT_;
extern signed short UAVT;
extern signed short TMAX;
extern signed short TSIGN;
extern signed short TSYSMAX;
extern signed short AV_OFF_AVT;
extern signed short USIGN;
extern signed short UMN;
extern signed short ZV_ON;
extern signed short UINMAX;
extern signed short UINMIN;
extern signed short UOUTMAX;
extern signed short UOUTMIN;
extern signed short IKB;

extern signed short IMAX;
extern signed short IMIN;
extern signed short APV_ON;
extern signed short IZMAX;
extern signed short U0B;
extern signed short TZAS;
extern signed short VZ_HR;
extern signed short TBAT;
extern signed short U_AVT;
extern signed short DU;

extern signed short RELE_SET_MASK[4];

extern signed short TBATMAX;
extern signed short TBATSIGN;
extern signed short UBM_AV;
extern signed short RELE_LOG;
extern signed short TBOXMAX;
extern signed short TBOXREG;
extern signed short TBOXVENTMAX;
extern signed short TLOADDISABLE;
extern signed short TLOADENABLE;
extern signed short TBATDISABLE;
extern signed short TBATENABLE;
extern signed short TBOXMAX;
extern signed short TBOXREG;
extern signed short TBOXVENTMAX;
extern signed short TLOADDISABLE;
extern signed short TLOADENABLE;
extern signed short TBATDISABLE;
extern signed short TBATENABLE;
extern signed short TVENTON;
extern signed short TVENTOFF;
extern signed short TWARMON;
extern signed short TWARMOFF;
typedef enum {rvsAKB=0,rvsEXT,rvsBPS} enum_releventsign;
extern enum_releventsign RELEVENTSIGN;
extern signed short TZNPN;
extern signed short UONPN;
extern signed short UVNPN;
typedef enum {npnoOFF=0,npnoRELEVENT,npnoRELEAVBAT2} enum_npn_out;
extern enum_npn_out NPN_OUT;
typedef enum {npnsULOAD=0,npnsAVNET} enum_npn_sign;
extern enum_npn_sign NPN_SIGN;
extern signed short TERMOKOMPENS;
extern signed short TBOXVENTON; 
extern signed short TBOXVENTOFF;
extern signed short TBOXWARMON; 
extern signed short TBOXWARMOFF;
extern signed short BAT_TYPE;	
extern signed short DU_LI_BAT;	
extern signed short FORVARDBPSCHHOUR;	
extern signed short NUMBAT;
extern signed short NUMBAT_TELECORE;
extern signed short NUMIST;
extern signed short NUMINV;
extern signed short NUMDT;
extern signed short NUMSK;
extern signed short NUMEXT;
extern signed short NUMAVT;
extern signed short NUMMAKB;
extern signed short NUMBYPASS;
extern signed short U_OUT_KONTR_MAX;
extern signed short U_OUT_KONTR_MIN;
extern signed short U_OUT_KONTR_DELAY;
extern signed short DOP_RELE_FUNC;
extern signed short CNTRL_HNDL_TIME;	
extern signed short USODERG_LI_BAT;		
extern signed short QSODERG_LI_BAT;		
extern signed short TVENTMAX;			
extern signed short ICA_EN;				
extern signed short ICA_CH;				
extern signed short ICA_MODBUS_ADDRESS;
extern signed short ICA_MODBUS_TCP_IP1,ICA_MODBUS_TCP_IP2,ICA_MODBUS_TCP_IP3,ICA_MODBUS_TCP_IP4;	
extern signed short ICA_MODBUS_TCP_UNIT_ID;	
extern signed short PWM_START;			
extern signed short KB_ALGORITM;		
extern signed short REG_SPEED;			

typedef enum {apvON=0x01,apvOFF=0x00}enum_apv_on;
extern enum_apv_on APV_ON1,APV_ON2;

extern signed short APV_ON2_TIME;

typedef enum {bisON=0x0055,bisOFF=0x00aa}enum_bat_is_on;
extern enum_bat_is_on BAT_IS_ON[2];

extern signed short BAT_DAY_OF_ON[2];
extern signed short BAT_MONTH_OF_ON[2];
extern signed short BAT_YEAR_OF_ON[2];
extern signed short BAT_C_NOM[2];
extern signed short BAT_RESURS[2];
extern signed short BAT_C_REAL[2];


extern unsigned short AUSW_MAIN;
extern unsigned long 	AUSW_MAIN_NUMBER;
extern unsigned short AUSW_DAY;
extern unsigned short AUSW_MONTH;
extern unsigned short AUSW_YEAR;
extern unsigned short AUSW_UKU;
extern unsigned short AUSW_UKU_SUB;
extern unsigned long AUSW_UKU_NUMBER;
extern unsigned long	AUSW_BPS1_NUMBER;
extern unsigned long  AUSW_BPS2_NUMBER;
extern unsigned short AUSW_RS232;
extern unsigned short AUSW_PDH;
extern unsigned short AUSW_SDH;
extern unsigned short AUSW_ETH;

extern signed short TMAX_EXT_EN[3];
extern signed short TMAX_EXT[3];
extern signed short TMIN_EXT_EN[3];
extern signed short TMIN_EXT[3];
extern signed short T_EXT_REL_EN[3];
extern signed short T_EXT_ZVUK_EN[3];
extern signed short T_EXT_LCD_EN[3];
extern signed short T_EXT_RS_EN[3];

extern signed short SK_SIGN[4];
extern signed short SK_REL_EN[4];
extern signed short SK_ZVUK_EN[4];
extern signed short SK_LCD_EN[4];
extern signed short SK_RS_EN[4];

typedef enum {AVZ_1=1,AVZ_2=2,AVZ_3=3,AVZ_6=6,AVZ_12=12,AVZ_OFF=0}enum_avz;
extern enum_avz AVZ;

extern unsigned short HOUR_AVZ;
extern unsigned short MIN_AVZ;
extern unsigned short SEC_AVZ;
extern unsigned short DATE_AVZ;
extern unsigned short MONTH_AVZ;
extern unsigned short YEAR_AVZ;
extern unsigned short AVZ_TIME;
typedef enum {mnON=0x55,mnOFF=0xAA}enum_mnemo_on;
extern enum_mnemo_on MNEMO_ON;
extern unsigned short MNEMO_TIME;
extern signed short POWER_CNT_ADRESS;

extern signed short ETH_IS_ON;
extern signed short ETH_DHCP_ON;
extern signed short ETH_IP_1;
extern signed short ETH_IP_2;
extern signed short ETH_IP_3;
extern signed short ETH_IP_4;
extern signed short ETH_MASK_1;
extern signed short ETH_MASK_2;
extern signed short ETH_MASK_3;
extern signed short ETH_MASK_4;
extern signed short ETH_TRAP1_IP_1;
extern signed short ETH_TRAP1_IP_2;
extern signed short ETH_TRAP1_IP_3;
extern signed short ETH_TRAP1_IP_4;
extern signed short ETH_TRAP2_IP_1;
extern signed short ETH_TRAP2_IP_2;
extern signed short ETH_TRAP2_IP_3;
extern signed short ETH_TRAP2_IP_4;
extern signed short ETH_TRAP3_IP_1;
extern signed short ETH_TRAP3_IP_2;
extern signed short ETH_TRAP3_IP_3;
extern signed short ETH_TRAP3_IP_4;
extern signed short ETH_TRAP4_IP_1;
extern signed short ETH_TRAP4_IP_2;
extern signed short ETH_TRAP4_IP_3;
extern signed short ETH_TRAP4_IP_4;
extern signed short ETH_TRAP5_IP_1;
extern signed short ETH_TRAP5_IP_2;
extern signed short ETH_TRAP5_IP_3;
extern signed short ETH_TRAP5_IP_4;
extern signed short ETH_SNMP_PORT_READ;
extern signed short ETH_SNMP_PORT_WRITE;
extern signed short ETH_GW_1;
extern signed short ETH_GW_2;
extern signed short ETH_GW_3;
extern signed short ETH_GW_4;

extern signed short RELE_VENT_LOGIC;

extern signed short MODBUS_ADRESS;
extern signed short MODBUS_BAUDRATE;
extern signed short BAT_LINK;
extern signed short I_LOAD_MODE;		




typedef enum {bsOFF=0,bsCOMM_ON,bsOK} enum_batStat;


typedef struct
     {
	
	signed short	_Ub;
     
     
	signed short	_Ib;
	signed short	_Tb;
	char 		_nd;
	char   		_soh;
	char 		_soc;
	signed short   _ratCap;
	char 		_comErrStat;	
	enum_batStat	_batStat;
	signed short 	_cclv;
	char 		_rbt;
	short 		_canErrorCnt;
	char			_canError;
	char 		_485Error;
	short 		_485ErrorCnt;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
     
	
	} LI_BAT_STAT; 
extern LI_BAT_STAT li_bat;



typedef struct
     {
	signed short 	_Iout;
	signed short 	_Uout;
	signed short 	_Pout;
	signed short 	_Unet; 	
	signed short 	_Uin;
	char			_T;
	char 		_flags;
	char			_cnt;
	char 		_adress;
	} BYPS_STAT; 
extern BYPS_STAT byps;








extern char can_slot[12][16];
extern char plazma_can_inv[3];




typedef struct
     {
	char _av;
	
	
	
	
     enum {isAPV,isWRK,isRDY,isBL,isAV,isOFF_AV_NET}_state;
     char _cnt;
     char _cnt_old;
     char _cnt_more2;
     char _buff[16]; 
     signed _Uio; 
     signed _Ii;
     signed _Ti; 
	signed _Uil;
	signed _Uin;
	signed _Pio;
     char _flags_tu;
     signed _vol_u;
     signed _vol_i;
     char _is_on_cnt;
     
     int _ist_blok_host_cnt;
     short _blok_cnt; 
     char _flags_tm;
	char _flags_tm_old;
	signed short _overload_av_cnt;     
     signed short _temp_av_cnt;
     signed short _umax_av_cnt;
     signed short _umin_av_cnt;
     signed _rotor;
     signed  short _x_; 
     char _adr_ee;
	char _last_avar;
	char _Pnom;
	char _Uoutmin;
	char _Uoutmax;
	char _net_contr_en;
	char _pwm_en;
	char _phase_mode;

     } INV_STAT; 




extern INV_STAT inv[20];

extern char first_inv_slot;



extern signed short load_U;
extern signed short load_I;



extern signed short bps_U;
extern signed short out_U;
extern signed short in_U;
extern signed short out_I;
extern signed short vd_U;
extern signed short bps_I;
extern signed short sys_T;



extern signed short net_U,net_Ustore,net_Ua,net_Ub,net_Uc;
extern char bFF,bFF_;
extern signed short net_F,hz_out,hz_out_cnt,net_F3;
extern signed char unet_drv_cnt;
extern char net_av;


extern char plazma_plazma_plazma;

void bitmap_hndl(void);
void ind_hndl(void);
__irq void timer1_interrupt(void);
__irq void timer0_interrupt(void); 





extern char tout_max_cnt[4],tout_min_cnt[4];
typedef enum {tNORM,tMAX,tMIN}enum_tout_stat;
extern enum_tout_stat tout_stat[4];
extern signed short t_ext[3];
extern char ND_EXT[3];
extern signed char sk_cnt[4],sk_av_cnt[4];
typedef enum  {ssOFF,ssON} enum_sk_stat;
extern enum_sk_stat sk_stat[4];
typedef enum  {sasOFF,sasON} enum_sk_av_stat;
extern enum_sk_av_stat sk_av_stat[4],sk_av_stat_old[4];
extern signed short t_box,t_box_warm,t_box_vent;
extern char TELECORE2017_EXT_VENT_PWM,TELECORE2017_INT_VENT_PWM;



extern BOOL bSILENT;



typedef enum {tstOFF,tst1,tst2} enum_tst_state;
extern enum_tst_state tst_state[15];



extern char sign_U[2],sign_I[2];
extern char superviser_cnt;



extern unsigned short adc_buff_ext_[3];
extern unsigned short Uvv[3];
extern unsigned short Uvv0;
extern short pos_vent;
extern short t_ext_can;
extern char t_ext_can_nd;



extern char eb2_data[30];
extern short eb2_data_short[10];
extern short Uvv_eb2[3],Upes_eb2[3];
extern short Kvv_eb2[3],Kpes_eb2[3];



extern signed short vvod_pos;



extern signed long power_summary;
extern signed short power_current;
extern signed long power_summary_tempo,power_summary_tempo_old;
extern signed short power_current_tempo,power_current_tempo_old;
extern char powerSummaryCnt;
extern char powerCurrentCnt;


extern char bRESET;
extern char bRESET_EXT;
extern char bRESET_INT_WDT;
extern char bRESET_EXT_WDT;



extern signed short main_vent_pos;
extern signed char t_box_cnt;
typedef enum  {mvsOFF,mvsON} enum_mixer_vent_stat;
extern enum_mixer_vent_stat mixer_vent_stat;
typedef struct
     {
	signed short _T[4];
	char _nd[4];
	signed short _T_dispers[4];
	char _max_dispers_num;
	signed short _max_dispers;
    	signed short _avg1;
	signed short _avg2;
	char _avg_cnt;
     } INT_BOX_TEMPER;
extern INT_BOX_TEMPER ibt;
typedef enum {tbdsON,tbdsOFF,tbdsMNL} enum_tbatdisable_stat;
extern enum_tbatdisable_stat tbatdisable_stat;
typedef enum {tldsON,tldsOFF,tldsMNL} enum_tloaddisable_stat;
extern enum_tloaddisable_stat tloaddisable_stat;
typedef enum {atsOFF,atsON} enum_av_tbox_stat;
extern enum_av_tbox_stat av_tbox_stat;
extern signed short av_tbox_cnt;
extern char tbatdisable_cmnd,tloaddisable_cmnd;
extern short tbatdisable_cnt,tloaddisable_cnt;
#line 1278 "main.h"

#line 1289 "main.h"

#line 1305 "main.h"

extern char ext_can_cnt;


signed short abs_pal(signed short in);
void ADC_IRQHandler(void);



typedef enum  {osOFF,osON} enum_optr_stat;
extern enum_optr_stat optr_stat[3]; 



extern signed long ibat_metr_buff_[2];
extern short bIBAT_SMKLBR;
extern char ibat_metr_cnt;



extern char snmp_plazma;


extern char ips_bat_av_vzvod;
extern char ips_bat_av_stat;

extern char rel_warm_plazma;
extern char can_byps_plazma0,can_byps_plazma1;

extern short plazma_bat_drv0,plazma_bat_drv1,bat_drv_cnt_cnt;
extern unsigned short bat_drv_rx_cnt;
extern char bat_drv_rx_buff[512];
extern char bat_drv_rx_in;

extern short can_plazma;



#line 1354 "main.h"












extern signed short speedChrgCurr;			
extern signed short speedChrgVolt;			
extern signed short speedChrgTimeInHour; 	
extern signed short speedChrgAvtEn;	 		
extern signed short speedChrgDU;	    	
extern signed short speedChIsOn;			
extern signed long  speedChTimeCnt;			
extern signed short speedChrgBlckSrc;		
extern signed short speedChrgBlckLog;		
extern signed short speedChrgBlckStat;		
extern char  		speedChrgShowCnt;		



extern signed short ipsBlckSrc;
extern signed short ipsBlckLog;
extern signed short ipsBlckStat;



extern signed short outVoltContrHndlCnt;		
extern signed short outVoltContrHndlCnt_;		
extern char uout_av;



extern char bVDISWORK;
extern char vd_is_work_cnt;

extern short plazma_numOfCells;
extern short plazma_numOfTemperCells;
extern short plazma_numOfPacks;

extern char plazma_ztt[2];
extern char plazma1809;

extern U8 socket_tcp;



extern char ica_plazma[10];
extern char ica_timer_cnt;
extern signed short ica_my_current;
extern signed short ica_your_current;
extern signed short ica_u_necc;
extern U8 tcp_soc_avg;
extern U8 tcp_connect_stat;



extern short overloadHndlCnt;
extern char overloadAvar;



extern short uAvarHndlOutUMaxCnt,uAvarHndlOutUMinCnt;
extern char uOutAvar;



extern short uAvarHndlInUMaxCnt,uAvarHndlInUMinCnt;
extern char uInAvar;



extern short sysTAvarHndlCnt;
extern char sysTAvar;



extern short rele_av_flags;
extern short avar_vd_stat;

extern short pvlk;






 
#line 22 "main.c"
#line 1 "simbol.h"

const char caracter[1536]={
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x7F,
0x3E,0x1C,0x08,0x00,0x00,0x08,0x0C,0x0E,
0x0C,0x08,0x7f,0x49,0x51,0x49,0x45,0x7f,
0x7f,0x41,0x41,0x41,0x41,0x7f,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x5F,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x14,0x3E,0x14,0x3E,0x14,
0x00,0x24,0x2A,0x7F,0x2A,0x12,0x00,0x23,
0x13,0x08,0x64,0x62,0x00,0x36,0x49,0x55,
0x22,0x50,0x00,0x00,0x00,0x00,0x06,0x00,
0x00,0x00,0x3E,0x41,0x00,0x00,0x00,0x00,
0x00,0x41,0x3E,0x00,0x00,0x14,0x08,0x3E,
0x08,0x14,0x00,0x08,0x08,0x3E,0x08,0x08,
0x00,0x00,0x50,0x30,0x00,0x00,0x00,0x08,
0x08,0x08,0x08,0x08,0x00,0x00,0x00,0x60,
0x60,0x00,0x00,0x40,0x20,0x10,0x08,0x04,
0x00,0x3E,0x51,0x49,0x45,0x3E,0x00,0x00,
0x42,0x7F,0x40,0x00,0x00,0x42,0x61,0x51,
0x49,0x46,0x00,0x21,0x41,0x45,0x4B,0x31,
0x00,0x18,0x14,0x12,0x7F,0x10,0x00,0x27,
0x45,0x45,0x45,0x39,0x00,0x3C,0x4A,0x49,
0x49,0x30,0x00,0x01,0x71,0x09,0x05,0x03,
0x00,0x36,0x49,0x49,0x49,0x36,0x00,0x06,
0x49,0x49,0x29,0x1E,0x00,0x00,0x36,0x36,
0x00,0x00,0x00,0x00,0x56,0x36,0x00,0x00,
0x00,0x00,0x08,0x14,0x22,0x00,0x00,0x14,
0x14,0x14,0x14,0x14,0x00,0x00,0x22,0x14,
0x08,0x00,0x00,0x02,0x01,0x51,0x09,0x06,
0x00,0x32,0x49,0x79,0x41,0x3E,0x00,0x7E,
0x11,0x11,0x11,0x7E,0x00,0x7F,0x49,0x49,
0x49,0x36,0x00,0x3E,0x41,0x41,0x41,0x22,
0x00,0x7F,0x41,0x41,0x22,0x1C,0x00,0x7F,
0x49,0x49,0x49,0x41,0x00,0x7F,0x09,0x09,
0x09,0x01,0x00,0x3E,0x41,0x41,0x51,0x72,
0x00,0x7F,0x08,0x08,0x08,0x7F,0x00,0x00,
0x41,0x7F,0x41,0x00,0x00,0x20,0x40,0x41,
0x3F,0x01,0x00,0x7F,0x08,0x14,0x22,0x41,
0x00,0x7F,0x40,0x40,0x40,0x40,0x00,0x7F,
0x02,0x0C,0x02,0x7F,0x00,0x7F,0x04,0x08,
0x10,0x7F,0x00,0x3E,0x41,0x41,0x41,0x3E,
0x00,0x7F,0x09,0x09,0x09,0x06,0x00,0x3E,
0x41,0x51,0x21,0x5E,0x00,0x7F,0x09,0x19,
0x29,0x46,0x00,0x46,0x49,0x49,0x49,0x31,
0x00,0x01,0x01,0x7F,0x01,0x01,0x00,0x3F,
0x40,0x40,0x40,0x3F,0x00,0x1F,0x20,0x40,
0x20,0x1F,0x00,0x3F,0x40,0x38,0x40,0x3F,
0x00,0x63,0x14,0x08,0x14,0x63,0x00,0x07,
0x08,0x70,0x08,0x07,0x00,0x61,0x51,0x49,
0x45,0x43,0x00,0x00,0x7F,0x41,0x00,0x00,
0x00,0x04,0x08,0x10,0x20,0x40,0x00,0x00,
0x00,0x41,0x7F,0x00,0x00,0x04,0x02,0x01,
0x02,0x04,0x00,0x40,0x40,0x40,0x40,0x40,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x20,
0x54,0x54,0x54,0x78,0x00,0x7F,0x48,0x44,
0x44,0x38,0x00,0x38,0x44,0x44,0x44,0x20,
0x00,0x30,0x48,0x48,0x50,0x7E,0x00,0x38,
0x54,0x54,0x54,0x18,0x00,0x08,0x7E,0x09,
0x01,0x02,0x00,0x08,0x54,0x54,0x54,0x3C,
0x00,0x7F,0x10,0x08,0x08,0x70,0x00,0x00,
0x44,0x7D,0x40,0x00,0x00,0x20,0x40,0x44,
0x3D,0x00,0x00,0x7E,0x10,0x28,0x44,0x00,
0x00,0x00,0x41,0x7F,0x40,0x00,0x00,0x7C,
0x04,0x18,0x04,0x78,0x00,0x7C,0x08,0x04,
0x04,0x78,0x00,0x38,0x44,0x44,0x44,0x38,
0x00,0x7C,0x14,0x14,0x14,0x08,0x00,0x08,
0x14,0x14,0x14,0x7C,0x00,0x7C,0x08,0x04,
0x04,0x08,0x00,0x48,0x54,0x54,0x54,0x20,
0x00,0x04,0x3F,0x44,0x40,0x20,0x00,0x3C,
0x40,0x40,0x20,0x7C,0x00,0x1C,0x20,0x40,
0x20,0x1C,0x00,0x3C,0x40,0x30,0x40,0x3C,
0x00,0x44,0x28,0x10,0x28,0x44,0x00,0x0C,
0x50,0x50,0x50,0x3C,0x00,0x44,0x64,0x54,
0x4C,0x44,0x00,0x00,0x08,0x36,0x41,0x00,
0x00,0x00,0x00,0x7F,0x00,0x00,0x00,0x00,
0x41,0x36,0x08,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x04,0x06,0x07,
0x06,0x04,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x08,0x1C,0x3E,
0x7F,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x7F,0x3E,0x1C,0x08,0x00,0x08,0x18,
0x38,0x18,0x08,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x1C,0x3E,0x3E,0x3E,0x1C,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x7C,0x55,0x54,0x45,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x06,0x09,0x09,0x06,0x00,0x00,
0x24,0x2E,0x24,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x38,0x55,0x54,0x55,0x18,0x00,0x7C,
0x10,0x20,0x7B,0x0B,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x20,0x30,0x38,0x30,0x20,0x00,
0x00,0x7E,0x11,0x11,0x11,0x7E,0x00,0x7F,
0x49,0x49,0x49,0x31,0x00,0x7F,0x49,0x49,
0x49,0x36,0x00,0x7F,0x01,0x01,0x01,0x03,
0x00,0x60,0x3E,0x21,0x21,0x7F,0x00,0x7F,
0x49,0x49,0x49,0x41,0x00,0x77,0x08,0x7F,
0x08,0x77,0x00,0x41,0x49,0x49,0x49,0x36,
0x00,0x7F,0x20,0x10,0x08,0x7F,0x00,0x7F,
0x20,0x11,0x08,0x7F,0x00,0x7F,0x08,0x14,
0x22,0x41,0x00,0x40,0x7E,0x01,0x01,0x7F,
0x00,0x7F,0x02,0x0C,0x02,0x7F,0x00,0x7F,
0x08,0x08,0x08,0x7F,0x00,0x3E,0x41,0x41,
0x41,0x3E,0x00,0x7F,0x01,0x01,0x01,0x7F,
0x00,0x7F,0x09,0x09,0x09,0x06,0x00,0x3E,
0x41,0x41,0x41,0x22,0x00,0x01,0x01,0x7F,
0x01,0x01,0x00,0x47,0x28,0x10,0x08,0x07,
0x00,0x1C,0x22,0x7F,0x22,0x1C,0x00,0x63,
0x14,0x08,0x14,0x63,0x00,0x7F,0x40,0x40,
0x40,0xFF,0x00,0x07,0x08,0x08,0x08,0x7F,
0x00,0x7F,0x40,0x7F,0x40,0x7F,0x00,0x7F,
0x40,0x7F,0x40,0xFF,0x00,0x01,0x7F,0x48,
0x48,0x70,0x00,0x7F,0x44,0x38,0x00,0x7F,
0x00,0x7F,0x48,0x48,0x48,0x30,0x00,0x22,
0x41,0x49,0x49,0x3E,0x00,0x7F,0x08,0x3E,
0x41,0x3E,0x00,0x46,0x29,0x19,0x09,0x7F,
0x00,0x20,0x54,0x54,0x54,0x78,0x00,0x3C,
0x4A,0x4A,0x49,0x31,0x00,0x7C,0x54,0x54,
0x28,0x00,0x00,0x7C,0x04,0x04,0x04,0x0C,
0x00,0x60,0x38,0x24,0x24,0x7C,0x00,0x38,
0x54,0x54,0x54,0x18,0x00,0x6C,0x10,0x7C,
0x10,0x6C,0x00,0x44,0x44,0x54,0x54,0x28,
0x00,0x7C,0x20,0x10,0x08,0x7C,0x00,0x7C,
0x20,0x12,0x08,0x7C,0x00,0x7C,0x10,0x28,
0x44,0x00,0x00,0x40,0x38,0x04,0x04,0x7C,
0x00,0x7C,0x08,0x10,0x08,0x7C,0x00,0x7C,
0x10,0x10,0x10,0x7C,0x00,0x38,0x44,0x44,
0x44,0x38,0x00,0x7C,0x04,0x04,0x04,0x7C,
0x00,0x7C,0x14,0x14,0x14,0x08,0x00,0x38,
0x44,0x44,0x44,0x00,0x00,0x04,0x04,0x7C,
0x04,0x04,0x00,0x0C,0x50,0x50,0x50,0x3C,
0x00,0x18,0x24,0x7E,0x24,0x18,0x00,0x44,
0x28,0x10,0x28,0x44,0x00,0x7C,0x40,0x40,
0x40,0xFC,0x00,0x00,0x1C,0x10,0x10,0x7C,
0x00,0x7C,0x40,0x7C,0x40,0x7C,0x00,0x7C,
0x40,0x7C,0x40,0xFC,0x00,0x04,0x7C,0x50,
0x50,0x20,0x00,0x7C,0x50,0x20,0x00,0x7C,
0x00,0x7C,0x50,0x50,0x50,0x20,0x00,0x28,
0x44,0x54,0x54,0x38,0x00,0x7C,0x10,0x38,
0x44,0x38,0x00,0x08,0x54,0x34,0x14,0x7C};
#line 23 "main.c"
#line 1 "25lc640.h"












char spi1(char in);
void spi1_config(void);
void spi1_config_mcp2515(void);
void spi1_unconfig(void);
void lc640_wren(void);
char lc640_rdsr(void);
int lc640_read(int ADR);
int lc640_read_int(int ADR);
long lc640_read_long(int ADR);
void lc640_read_long_ptr(int ADR,char* out_ptr);
void lc640_read_str(int ADR, char* ram_ptr, char num);
char lc640_write(int ADR,char in);
char lc640_write_int(short ADR,short in);
char lc640_write_long(int ADR,long in);
char lc640_write_long_ptr(int ADR,char* in);
#line 24 "main.c"
#line 1 "Timer.h"









 



	


extern void delayMs(uint8_t timer_num, uint32_t delayInMs);
extern uint32_t init_timer( uint8_t timer_num, uint32_t timerInterval );
extern void enable_timer( uint8_t timer_num );
extern void disable_timer( uint8_t timer_num );
extern void reset_timer( uint8_t timer_num );
extern void TIMER0_IRQHandler (void);
extern void TIMER1_IRQHandler (void);




 
#line 25 "main.c"
#line 1 "gran.h"

void gran_ring_char(signed char *adr, signed char min, signed char max) ;
void gran_char(signed char *adr, signed char min, signed char max);
void gran(signed short *adr, signed short min, signed short max);
void gran_ring(signed short *adr, signed short min, signed short max);
void gran_long(signed long *adr, signed long min, signed long max); 
#line 26 "main.c"



#line 1 "cmd.h"


#line 30 "main.c"
#line 1 "ret.h"




extern char retind,retsub,retindsec;
extern int retcnt,retcntsec;
extern unsigned char f0,fc0,f1,fc1;
extern short ret_duty;

void ret_ind(char r_i,char r_s);
void ret_ind_hndl(void);
void ret_ind_sec(char r_i,int r_c);
void ret_ind_sec_hndl(void);
void ret(short duty);
void ret_hndl(void);








 

     
#line 31 "main.c"
#line 1 "eeprom_map.h"






#line 35 "eeprom_map.h"



#line 161 "eeprom_map.h"

#line 172 "eeprom_map.h"






 









 

#line 204 "eeprom_map.h"



#line 216 "eeprom_map.h"


#line 227 "eeprom_map.h"



#line 238 "eeprom_map.h"



#line 294 "eeprom_map.h"


#line 337 "eeprom_map.h"








#line 359 "eeprom_map.h"







































































































extern const unsigned short ADR_EE_BAT_ZAR_CNT[2];
extern const unsigned short ADR_EE_BAT_ZAR_CNT_KE[2];
extern const unsigned short ADR_EE_BAT_C_NOM[2];
extern const unsigned short ADR_EE_BAT_YEAR_OF_ON[2];
extern const unsigned short ADR_EE_BAT_IS_ON[2];
extern const unsigned short ADR_EE_BAT_DAY_OF_ON[2];
extern const unsigned short ADR_EE_BAT_MONTH_OF_ON[2];
extern const unsigned short ADR_EE_BAT_RESURS[2];
extern const unsigned short ADR_EE_BAT_C_REAL[2];
extern const unsigned short ADR_EE_BAT_TYPE[2];
extern const unsigned short ADR_KUBAT[2];
extern const unsigned short ADR_KUBATM[2];
extern const unsigned short ADR_KI0BAT[2];
extern const unsigned short ADR_KI1BAT[2];
extern const unsigned short ADR_KTBAT[2];
extern const unsigned short ADR_EE_BAT_TYPE[2];


extern const unsigned short ADR_TMAX_EXT_EN[3];
extern const unsigned short ADR_TMAX_EXT[3];
extern const unsigned short ADR_TMIN_EXT_EN[3];
extern const unsigned short ADR_TMIN_EXT[3];
extern const unsigned short ADR_T_EXT_REL_EN[3];
extern const unsigned short ADR_T_EXT_ZVUK_EN[3];
extern const unsigned short ADR_T_EXT_LCD_EN[3];
extern const unsigned short ADR_T_EXT_RS_EN[3];

extern const unsigned short ADR_SK_SIGN[4];
extern const unsigned short ADR_SK_REL_EN[4];
extern const unsigned short ADR_SK_ZVUK_EN[4];
extern const unsigned short ADR_SK_LCD_EN[4];
extern const unsigned short ADR_SK_RS_EN[4];

extern const unsigned short ADR_EE_RELE_SET_MASK[4];

#line 32 "main.c"
#line 1 "common_func.h"




signed short abs(signed short in);
void clr_scrn(void);
char find(char xy);
void bin2bcd_int(unsigned int in);
void bcd2lcd_zero(char sig);
void int2lcd_m(signed short in,char xy,char des);
void int2lcd_mm(signed short in,char xy,char des);
void int2lcd_mmm(signed short in,char xy,char des);
void long2lcd_mmm(signed long in,char xy,char des);
void long2lcdyx_mmm(signed long in,char y,char x,char des);
void int2lcdyx(unsigned short in,char y,char x,char des);
void int2lcd(unsigned short in,char xy,char des);
void checkboxing(char xy,short in);
void long2lcdhyx(unsigned long in,char y,char x);
void char2lcdh(char in,char yx);
void char2lcdhyx(char in,char y,char x);
void int2lcdhyx(unsigned short in,char y,char x);
void char2lcdbyx(char in,char y,char x);
void pointer_set(char num_of_first_row);
void tree_down(signed char offset_ind,signed char offset_sub_ind);
void tree_up(char tind, char tsub_ind, char tindex_set, char tsub_ind1);
void bgnd_par(char const *ptr0,char const *ptr1,char const *ptr2,char const *ptr3);
void sub_bgnd(char const *adr,char xy,signed char offset);
void show_mess(char* p1, char* p2, char* p3, char* p4,int m_sec);
void event2ind(char num, char simbol);
char ptr_carry(signed int in,unsigned char modul,signed int carry);
void event_data2ind(char num, char simbol);
void ip2lcd(	short in1,
			short in2,
			short in3,
			short in4,
			char xy,
			char flash_pos);
void community2lcd(char* in,
			char xy,
			char flash_pos,
			char flash_on);

#line 33 "main.c"
#line 1 "control.h"







extern char num_of_wrks_bps;
extern char bps_all_off_cnt,bps_mask_off_cnt,bps_mask_on_off_cnt;
extern char bps_hndl_2sec_cnt;
extern unsigned short bps_on_mask,bps_off_mask;
extern char num_necc_up,num_necc_down;
extern unsigned char sh_cnt0,b1Hz_sh;





extern long adc_buff[16][16];
extern signed short adc_buff_max[12],adc_buff_min[12],unet_buff_max,unet_buff_min;
extern short adc_buff_[16];
extern char adc_self_ch_cnt,adc_ch_net;
extern char adc_cnt,adc_cnt1,adc_ch,adc_ch_cnt;
extern short zero_cnt;
typedef enum {asCH=1,asNET_WAIT=2,asNET_RDY=3,asNET=4} enum_adc_stat;
extern enum_adc_stat adc_stat;
extern unsigned short net_buff[32],net_buff_,net_metr_buff_[3];
extern char net_buff_cnt;
extern short ADWR,period_cnt,non_zero_cnt;
extern char rele_stat;
extern char bRELE_OUT;
extern short plazma_adc_cnt;
extern signed short adc_self_ch_buff[3],adc_self_ch_disp[3];
extern long main_power_buffer[8],main_power_buffer_;
extern short main_power_buffer_cnt;
extern short adc_gorb_cnt,adc_zero_cnt;
extern char adc_window_flag;
extern short adc_window_cnt;
extern short adc_net_buff_cnt;


char vz_start(char hour);
void vz_stop(void);

void samokalibr_init(void);
void samokalibr_hndl(void);
void kb_init(void);
void kb_hndl(void);
void ubat_old_drv(void);
void unet_drv(void);
void matemat(void);
void adc_init(void);
void adc_drv5(void);
void adc_drv_(void);
void avg_hndl(void);


void rele_drv(void);
void bps_hndl(void);
void bps_drv(char in);
void bat_hndl(void);
void bat_drv(char in);
void u_necc_hndl(void);
void zar_drv(void);
void ke_start(char in);
void zar_drv(void);
void vent_hndl(void);
void avz_next_date_hndl(void);
void klimat_hndl(void);
void ext_drv(void);
void adc_drv7(void);
void avt_hndl(void);
void vent_resurs_hndl(void);
void ips_current_average_hndl(void);




typedef enum {spcOFF=0,spcKE, spcVZ}enum_spc_stat;
typedef enum {kssNOT=0,kssNOT_VZ,kssYES=100,kssNOT_BAT,kssNOT_BAT_AV,kssNOT_BAT_AV_T,kssNOT_BAT_AV_ASS,kssNOT_BAT_ZAR,kssNOT_BAT_RAZR,kssNOT_KE1,kssNOT_KE2}enum_ke_start_stat;
extern enum_spc_stat spc_stat;
extern enum_ke_start_stat ke_start_stat;
extern char spc_bat;
extern char spc_phase;
extern unsigned short vz_cnt_s,vz_cnt_s_,vz_cnt_h,vz_cnt_h_;
extern short cnt_end_ke;
extern unsigned long ke_date[2];
extern short __ee_vz_cnt;
extern short __ee_spc_stat;
extern short __ee_spc_bat;
extern short __ee_spc_phase;



extern short plazma_sk;
extern char	plazma_inv[4];
extern char plazma_bat;
extern char plazma_cntrl_stat;


extern signed int i_avg_max,i_avg_min,i_avg_summ,i_avg; 
extern signed int avg;
extern char bAVG;
extern const char sk_buff_TELECORE2015[4];



extern signed short 	main_kb_cnt;
extern signed short 	kb_cnt_1lev;
extern signed short 	kb_cnt_2lev;
extern char 		kb_full_ver;
extern char kb_start[2],kb_start_ips;
extern signed short ibat_ips,ibat_ips_;



extern char numOfForvardBps,numOfForvardBps_old;
extern char numOfForvardBps_minCnt;
extern short numOfForvardBps_hourCnt;



extern char bPARALLEL_NOT_ENOUG;
extern char bPARALLEL_ENOUG;
extern char bPARALLEL;

extern char bAVG_BLOCK;

extern char cntrl_hndl_plazma;

void zar_superviser_drv(void);
void zar_superviser_start(void);
void vent_hndl(void);
void speedChargeHndl(void);
void speedChargeStartStop(void);
void numOfForvardBps_init(void);
void outVoltContrHndl(void);


#line 34 "main.c"
#line 1 "mess.h"










		





void mess_hndl(void);
void mess_send(char _mess, short par0, short par1, char _time);
char mess_find(char _mess);
char mess_find_unvol(char _mess);

#line 35 "main.c"

#line 1 "watchdog.h"

void watchdog_init(unsigned long f,unsigned long time_out);
void watchdog_reset(void);





#line 37 "main.c"
#line 1 "ad7705.h"

extern unsigned short ad7705_res1,ad7705_res2;
extern unsigned short ad7705_buff[2][16],ad7705_buff_[2];
extern unsigned short ad7705_res;
extern char b7705ch,ad7705_wrk_cnt;
extern unsigned short cnt_ad7705_vis,cnt_ad7705_vis_wrk;
extern signed short ad7705_plazma;


void spi1_ad7705_config(void);
void ad7705_reset(void);
void ad7705_write(char in);
void ad7705_read(char num);
void ad7705_drv(void);



#line 38 "main.c"
#line 1 "beep.h"

extern unsigned long beep_stat_temp,beep_stat;
extern char beep_stat_cnt;
extern char beep_cnt;
extern char bU_BAT2REL_AV_BAT;

void beep_drv(void);
void beep_init(long zvuk,char fl);
void beep_hndl(void);
#line 39 "main.c"

#line 1 "memo.h"

void memo_read (void);






#line 41 "main.c"
#line 1 "simbols.h"


extern const char sAVNET[150];
extern const char sAVNET1[150];
extern const char sBPS1[30];
extern const char sBPS2[30];
extern const char sAVT[30];
extern const char sAVU[30];
extern const char caracter[1536];
#line 42 "main.c"
#line 1 "graphic.h"


void draw(signed short x_b,signed short y_b,signed short x_o,signed short y_o,char inverse);
void draw_rectangle(signed short x_b,signed short y_b,signed short x_o,signed short y_o,char solid,char inverse);	   
void draw_ptr(char x_b,char y_b,char ptr,char vol);
void plot(signed short x_b,signed short y_b,unsigned long data,signed short len,char inverse);
void graphic_print(signed short x_b,signed short y_b,signed short x_l,signed short y_l,signed short x_d,signed short y_d,const char* adress,char inverse);
void graphic_print_text(signed short x_b,signed short y_b,const char* bgnd,signed short num,signed short data,signed short des,signed short pos,char inverse);
void graphic_print_text_text(signed short x_b,signed short y_b,const char* bgnd,signed short num,signed short data,signed short des,signed short pos,char inverse);
#line 43 "main.c"


#line 1 "uart0.h"




















#line 29 "uart0.h"



extern char bRXIN0;
extern char UIB0[100];
extern char flag0;
extern char rx_buffer0[1024];
extern unsigned char tx_buffer0[1024];
extern unsigned short rx_wr_index0,rx_rd_index0,rx_counter0;
extern unsigned short tx_wr_index0,tx_rd_index0,tx_counter0;
extern char rx_buffer_overflow0;
extern char plazma_uart0;
extern char memo_out[50];
extern char data_rs[50];
extern char data_rs0[50];
extern const char Table87[];
extern const char Table95[]; 

char crc_87(char* ptr,char num);
char crc_95(char* ptr,char num);
void putchar0(char c);
void uart_out0 (char num,char data0,char data1,char data2,char data3,char data4,char data5);
void uart_out_adr0 (char *ptr, char len);
void uart0_init(void);
char getchar0(void);
__irq void uart0_interrupt(void);
void uart_in_an0(void);
signed short index_offset0 (signed short index,signed short offset);
char control_check0(signed short index);
void uart_in0(void);
void uart_out_adr_block (unsigned long adress,char *ptr, char len);
void rs232_data_out(void);
void rs232_data_out_tki(void);
void uart_out_buff0 (char *ptr, char len);
void rs232_data_out_1(void);
uint32_t UARTInit( uint32_t PortNum, uint32_t baudrate );

#line 46 "main.c"
#line 47 "main.c"


#line 1 "ztt.h"

extern char portZTTSunBatteryIsInitiated;
extern char zTTBatteryHndlPhase;
extern char liBatteryInBuff[300];
extern char zTTRequestPhase;
extern short zTTSilentCnt[3];
extern char zTTButteryCnter;
extern char zTTBatteryHndlCmnd;

void ztt_bat_hndl(void);
#line 50 "main.c"

#line 1 "sc16is7xx.h"
#line 2 "sc16is7xx.h"

#line 15 "sc16is7xx.h"















extern char sc16is700ByteAvailable;
extern char sc16is700TxFifoLevel;
extern char tx_buffer_sc16is700[32]; 
extern char tx_wr_index_sc16is700;
extern char tx_rd_index_sc16is700;
extern char sc16is700TxFifoEmptyCnt; 
extern char sc16is700TxPossibleFlag;


void sc16is700_init(uint32_t baudrate);
void sc16is700_wr_byte(char reg_num,char data);
char sc16is700_rd_byte(char reg_num);


void sc16is700_wr_buff(char reg_num,char num);
void putchar_sc16is700(char out_byte);
void sc16is700_uart_hndl(void);

#line 52 "main.c"

#line 1 "C:\\Keil\\ARM\\RV31\\INC\\stdio.h"
 
 
 





 






 









#line 34 "C:\\Keil\\ARM\\RV31\\INC\\stdio.h"


  
  typedef unsigned int size_t;    








 
 

 
  typedef struct __va_list __va_list;





   




 




typedef struct __fpos_t_struct {
    unsigned __int64 __pos;
    



 
    struct {
        unsigned int __state1, __state2;
    } __mbstate;
} fpos_t;
   


 


   

 

typedef struct __FILE FILE;
   






 

extern FILE __stdin, __stdout, __stderr;
extern FILE *__aeabi_stdin, *__aeabi_stdout, *__aeabi_stderr;

#line 125 "C:\\Keil\\ARM\\RV31\\INC\\stdio.h"
    

    

    





     



   


 


   


 

   



 

   


 




   


 





    


 






extern __declspec(__nothrow) int remove(const char *  ) __attribute__((__nonnull__(1)));
   





 
extern __declspec(__nothrow) int rename(const char *  , const char *  ) __attribute__((__nonnull__(1,2)));
   








 
extern __declspec(__nothrow) FILE *tmpfile(void);
   




 
extern __declspec(__nothrow) char *tmpnam(char *  );
   











 

extern __declspec(__nothrow) int fclose(FILE *  ) __attribute__((__nonnull__(1)));
   







 
extern __declspec(__nothrow) int fflush(FILE *  );
   







 
extern __declspec(__nothrow) FILE *fopen(const char * __restrict  ,
                           const char * __restrict  ) __attribute__((__nonnull__(1,2)));
   








































 
extern __declspec(__nothrow) FILE *freopen(const char * __restrict  ,
                    const char * __restrict  ,
                    FILE * __restrict  ) __attribute__((__nonnull__(2,3)));
   








 
extern __declspec(__nothrow) void setbuf(FILE * __restrict  ,
                    char * __restrict  ) __attribute__((__nonnull__(1)));
   




 
extern __declspec(__nothrow) int setvbuf(FILE * __restrict  ,
                   char * __restrict  ,
                   int  , size_t  ) __attribute__((__nonnull__(1)));
   















 
#pragma __printf_args
extern __declspec(__nothrow) int fprintf(FILE * __restrict  ,
                    const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   


















 
#pragma __printf_args
extern __declspec(__nothrow) int _fprintf(FILE * __restrict  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 
#pragma __printf_args
extern __declspec(__nothrow) int printf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   




 
#pragma __printf_args
extern __declspec(__nothrow) int _printf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   



 
#pragma __printf_args
extern __declspec(__nothrow) int sprintf(char * __restrict  , const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   






 
#pragma __printf_args
extern __declspec(__nothrow) int _sprintf(char * __restrict  , const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 

#pragma __printf_args
extern __declspec(__nothrow) int snprintf(char * __restrict  , size_t  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(3)));
   















 

#pragma __printf_args
extern __declspec(__nothrow) int _snprintf(char * __restrict  , size_t  ,
                      const char * __restrict  , ...) __attribute__((__nonnull__(3)));
   



 
#pragma __scanf_args
extern __declspec(__nothrow) int fscanf(FILE * __restrict  ,
                    const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   






























 
#pragma __scanf_args
extern __declspec(__nothrow) int _fscanf(FILE * __restrict  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 
#pragma __scanf_args
extern __declspec(__nothrow) int scanf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   






 
#pragma __scanf_args
extern __declspec(__nothrow) int _scanf(const char * __restrict  , ...) __attribute__((__nonnull__(1)));
   



 
#pragma __scanf_args
extern __declspec(__nothrow) int sscanf(const char * __restrict  ,
                    const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   








 
#pragma __scanf_args
extern __declspec(__nothrow) int _sscanf(const char * __restrict  ,
                     const char * __restrict  , ...) __attribute__((__nonnull__(1,2)));
   



 

 
extern __declspec(__nothrow) int vfscanf(FILE * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));
extern __declspec(__nothrow) int vscanf(const char * __restrict  , __va_list) __attribute__((__nonnull__(1)));
extern __declspec(__nothrow) int vsscanf(const char * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));

extern __declspec(__nothrow) int _vfscanf(FILE * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));
extern __declspec(__nothrow) int _vscanf(const char * __restrict  , __va_list) __attribute__((__nonnull__(1)));
extern __declspec(__nothrow) int _vsscanf(const char * __restrict  , const char * __restrict  , __va_list) __attribute__((__nonnull__(1,2)));

extern __declspec(__nothrow) int vprintf(const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1)));
   





 
extern __declspec(__nothrow) int _vprintf(const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1)));
   



 
extern __declspec(__nothrow) int vfprintf(FILE * __restrict  ,
                    const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   






 
extern __declspec(__nothrow) int vsprintf(char * __restrict  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   






 

extern __declspec(__nothrow) int vsnprintf(char * __restrict  , size_t  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(3)));
   







 

extern __declspec(__nothrow) int _vsprintf(char * __restrict  ,
                      const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   



 
extern __declspec(__nothrow) int _vfprintf(FILE * __restrict  ,
                     const char * __restrict  , __va_list  ) __attribute__((__nonnull__(1,2)));
   



 
extern __declspec(__nothrow) int _vsnprintf(char * __restrict  , size_t  ,
                      const char * __restrict  , __va_list  ) __attribute__((__nonnull__(3)));
   



 
extern __declspec(__nothrow) int fgetc(FILE *  ) __attribute__((__nonnull__(1)));
   







 
extern __declspec(__nothrow) char *fgets(char * __restrict  , int  ,
                    FILE * __restrict  ) __attribute__((__nonnull__(1,3)));
   










 
extern __declspec(__nothrow) int fputc(int  , FILE *  ) __attribute__((__nonnull__(2)));
   







 
extern __declspec(__nothrow) int fputs(const char * __restrict  , FILE * __restrict  ) __attribute__((__nonnull__(1,2)));
   




 
extern __declspec(__nothrow) int getc(FILE *  ) __attribute__((__nonnull__(1)));
   







 




    extern __declspec(__nothrow) int (getchar)(void);

   





 
extern __declspec(__nothrow) char *gets(char *  ) __attribute__((__nonnull__(1)));
   









 
extern __declspec(__nothrow) int putc(int  , FILE *  ) __attribute__((__nonnull__(2)));
   





 




    extern __declspec(__nothrow) int (putchar)(int  );

   



 
extern __declspec(__nothrow) int puts(const char *  ) __attribute__((__nonnull__(1)));
   





 
extern __declspec(__nothrow) int ungetc(int  , FILE *  ) __attribute__((__nonnull__(2)));
   






















 

extern __declspec(__nothrow) size_t fread(void * __restrict  ,
                    size_t  , size_t  , FILE * __restrict  ) __attribute__((__nonnull__(1,4)));
   











 

extern __declspec(__nothrow) size_t __fread_bytes_avail(void * __restrict  ,
                    size_t  , FILE * __restrict  ) __attribute__((__nonnull__(1,3)));
   











 

extern __declspec(__nothrow) size_t fwrite(const void * __restrict  ,
                    size_t  , size_t  , FILE * __restrict  ) __attribute__((__nonnull__(1,4)));
   







 

extern __declspec(__nothrow) int fgetpos(FILE * __restrict  , fpos_t * __restrict  ) __attribute__((__nonnull__(1,2)));
   








 
extern __declspec(__nothrow) int fseek(FILE *  , long int  , int  ) __attribute__((__nonnull__(1)));
   














 
extern __declspec(__nothrow) int fsetpos(FILE * __restrict  , const fpos_t * __restrict  ) __attribute__((__nonnull__(1,2)));
   










 
extern __declspec(__nothrow) long int ftell(FILE *  ) __attribute__((__nonnull__(1)));
   











 
extern __declspec(__nothrow) void rewind(FILE *  ) __attribute__((__nonnull__(1)));
   





 

extern __declspec(__nothrow) void clearerr(FILE *  ) __attribute__((__nonnull__(1)));
   




 

extern __declspec(__nothrow) int feof(FILE *  ) __attribute__((__nonnull__(1)));
   


 
extern __declspec(__nothrow) int ferror(FILE *  ) __attribute__((__nonnull__(1)));
   


 
extern __declspec(__nothrow) void perror(const char *  );
   









 

extern __declspec(__nothrow) int _fisatty(FILE *   ) __attribute__((__nonnull__(1)));
    
 

extern __declspec(__nothrow) void __use_no_semihosting_swi(void);
extern __declspec(__nothrow) void __use_no_semihosting(void);
    





 











#line 944 "C:\\Keil\\ARM\\RV31\\INC\\stdio.h"



 
#line 54 "main.c"



BOOL tick;




char b10000Hz,b1000Hz,b2000Hz,b100Hz,b50Hz,b10Hz,b5Hz,b2Hz,b1Hz,b1min;
short t0cnt,t0cnt0,t0cnt1,t0cnt2,t0cnt3,t0cnt4,t0cnt5,t0cnt6,t0_cnt7,t0_cnt_min,t0cntMin;
char bFL5,bFL2,bFL,bFL_,bTPS;
signed short main_10Hz_cnt=0;
signed short main_1Hz_cnt=0;

 


char cnt_of_slave=3;






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
signed short BAT_TYPE;	
signed short DU_LI_BAT;	
signed short FORVARDBPSCHHOUR;	
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
signed short CNTRL_HNDL_TIME;	
signed short USODERG_LI_BAT;	
signed short QSODERG_LI_BAT;	
signed short TVENTMAX;			
signed short ICA_EN;			
signed short ICA_CH;			
signed short ICA_MODBUS_ADDRESS;
signed short ICA_MODBUS_TCP_IP1,ICA_MODBUS_TCP_IP2,ICA_MODBUS_TCP_IP3,ICA_MODBUS_TCP_IP4;	
signed short ICA_MODBUS_TCP_UNIT_ID;	
signed short PWM_START;			
signed short KB_ALGORITM;		
signed short REG_SPEED;			
enum_apv_on APV_ON1,APV_ON2;
signed short APV_ON2_TIME;

enum_bat_is_on BAT_IS_ON[2];
signed short BAT_DAY_OF_ON[2];
signed short BAT_MONTH_OF_ON[2];
signed short BAT_YEAR_OF_ON[2];
signed short BAT_C_NOM[2];
signed short BAT_RESURS[2];
signed short BAT_C_REAL[2];


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
signed short I_LOAD_MODE;	









LI_BAT_STAT li_bat;




char can_slot[12][16];









INV_STAT inv[20];

char first_inv_slot=20;



BYPS_STAT byps;



signed short load_U;
signed short load_I;



signed short bps_U;
signed short out_U;
signed short in_U;
signed short out_I;
signed short vd_U;
signed short bps_I;
signed short sys_T;





char lcd_buffer[200+100]={"Hello World"};
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
const char sm_mont[13][4]={"   ","ˇÌ‚","ÙÂ‚","Ï‡","‡Ô","Ï‡È","Ë˛Ì","Ë˛Î","‡‚„","ÒÂÌ","ÓÍÚ","ÌÓˇ","‰ÂÍ"};
const char sm_dow[8][3]={"œÕ","¬“","—–","◊“","œ“","—¡","¬—"}; 
signed short ptr_ind=0;

signed short ind_pointer=0;



signed short net_U,net_Ustore,net_Ua,net_Ub,net_Uc;
char bFF,bFF_;
signed short net_F,hz_out,hz_out_cnt,net_F3;
signed char unet_drv_cnt;
char net_av;




char tout_max_cnt[4],tout_min_cnt[4];
enum_tout_stat tout_stat[4];
signed short t_ext[3];

signed char sk_cnt_dumm[4],sk_cnt[4],sk_av_cnt[4];
enum_sk_stat sk_stat[4]={ssOFF,ssOFF,ssOFF,ssOFF};
enum_sk_av_stat sk_av_stat[4]={sasOFF,sasOFF,sasOFF,sasOFF},sk_av_stat_old[4];
signed short t_box,t_box_warm,t_box_vent;
char ND_EXT[3];


extern char beep_cnt;
BOOL bSILENT;








signed short u_necc,u_necc_,u_necc_up,u_necc_dn;
signed short main_cnt_5Hz;
signed short num_necc;
signed short num_necc_Imax;
signed short num_necc_Imin;
signed short cnt_num_necc;

signed mat_temper;



unsigned main_apv_cnt,hour_apv_cnt[2],reset_apv_cnt[2];
unsigned short apv_cnt_sec[2],apv_cnt[2];



const char sm_[]	={"                    "};
const char sm_exit[]={" ¬˚ıÓ‰              "};
const char sm_time[]={" 0%:0^ 0</>  /0{   &"};







char but;                            
unsigned long but_n,but_s;
char but0_cnt;
char but1_cnt;
char but_onL_temp;



signed char cnt_net_drv;





char speed,l_but,n_but;



enum {wrkON=0x55,wrkOFF=0xAA}wrk;
char cnt_wrk;
signed short ibat_integr;
unsigned short av_beep,av_rele,av_stat;
char default_temp;
char ND_out[3];



enum_tst_state tst_state[15];




extern char adc_cnt,adc_cnt1,adc_ch;



char flag=0;


extern signed short bat_ver_cnt;
signed short Isumm;
signed short Isumm_;

#line 1 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"




















 









 

typedef enum IRQn
{
 
  NonMaskableInt_IRQn           = -14,       
  MemoryManagement_IRQn         = -12,       
  BusFault_IRQn                 = -11,       
  UsageFault_IRQn               = -10,       
  SVCall_IRQn                   = -5,        
  DebugMonitor_IRQn             = -4,        
  PendSV_IRQn                   = -2,        
  SysTick_IRQn                  = -1,        

 
  WDT_IRQn                      = 0,         
  TIMER0_IRQn                   = 1,         
  TIMER1_IRQn                   = 2,         
  TIMER2_IRQn                   = 3,         
  TIMER3_IRQn                   = 4,         
  UART0_IRQn                    = 5,         
  UART1_IRQn                    = 6,         
  UART2_IRQn                    = 7,         
  UART3_IRQn                    = 8,         
  PWM1_IRQn                     = 9,         
  I2C0_IRQn                     = 10,        
  I2C1_IRQn                     = 11,        
  I2C2_IRQn                     = 12,        
  SPI_IRQn                      = 13,        
  SSP0_IRQn                     = 14,        
  SSP1_IRQn                     = 15,        
  PLL0_IRQn                     = 16,        
  RTC_IRQn                      = 17,        
  EINT0_IRQn                    = 18,        
  EINT1_IRQn                    = 19,        
  EINT2_IRQn                    = 20,        
  EINT3_IRQn                    = 21,        
  ADC_IRQn                      = 22,        
  BOD_IRQn                      = 23,        
  USB_IRQn                      = 24,        
  CAN_IRQn                      = 25,        
  DMA_IRQn                      = 26,        
  I2S_IRQn                      = 27,        
  ENET_IRQn                     = 28,        
  RIT_IRQn                      = 29,        
  MCPWM_IRQn                    = 30,        
  QEI_IRQn                      = 31,        
  PLL1_IRQn                     = 32,        
  USBActivity_IRQn              = 33,        
  CANActivity_IRQn              = 34,        
} IRQn_Type;






 

 





#line 1 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"



















 




















































 

 
 
 
 
 
 
 
 


#line 86 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"

















 

#line 112 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"





 


 





 






 
typedef struct
{
  volatile uint32_t ISER[8];                       
       uint32_t RESERVED0[24];
  volatile uint32_t ICER[8];                       
       uint32_t RSERVED1[24];
  volatile uint32_t ISPR[8];                       
       uint32_t RESERVED2[24];
  volatile uint32_t ICPR[8];                       
       uint32_t RESERVED3[24];
  volatile uint32_t IABR[8];                       
       uint32_t RESERVED4[56];
  volatile uint8_t  IP[240];                       
       uint32_t RESERVED5[644];
  volatile  uint32_t STIR;                          
}  NVIC_Type;


 
typedef struct
{
  volatile const  uint32_t CPUID;                         
  volatile uint32_t ICSR;                          
  volatile uint32_t VTOR;                          
  volatile uint32_t AIRCR;                         
  volatile uint32_t SCR;                           
  volatile uint32_t CCR;                           
  volatile uint8_t  SHP[12];                       
  volatile uint32_t SHCSR;                         
  volatile uint32_t CFSR;                          
  volatile uint32_t HFSR;                          
  volatile uint32_t DFSR;                          
  volatile uint32_t MMFAR;                         
  volatile uint32_t BFAR;                          
  volatile uint32_t AFSR;                          
  volatile const  uint32_t PFR[2];                        
  volatile const  uint32_t DFR;                           
  volatile const  uint32_t ADR;                           
  volatile const  uint32_t MMFR[4];                       
  volatile const  uint32_t ISAR[5];                       
} SCB_Type;


 
typedef struct
{
  volatile uint32_t CTRL;                          
  volatile uint32_t LOAD;                          
  volatile uint32_t VAL;                           
  volatile const  uint32_t CALIB;                         
} SysTick_Type;


 
typedef struct
{
  volatile  union  
  {
    volatile  uint8_t    u8;                        
    volatile  uint16_t   u16;                       
    volatile  uint32_t   u32;                       
  }  PORT [32];                                
       uint32_t RESERVED0[864];
  volatile uint32_t TER;                           
       uint32_t RESERVED1[15];
  volatile uint32_t TPR;                           
       uint32_t RESERVED2[15];
  volatile uint32_t TCR;                           
       uint32_t RESERVED3[29];
  volatile uint32_t IWR;                           
  volatile uint32_t IRR;                           
  volatile uint32_t IMCR;                          
       uint32_t RESERVED4[43];
  volatile uint32_t LAR;                           
  volatile uint32_t LSR;                           
       uint32_t RESERVED5[6];
  volatile const  uint32_t PID4;                          
  volatile const  uint32_t PID5;
  volatile const  uint32_t PID6;
  volatile const  uint32_t PID7;
  volatile const  uint32_t PID0;
  volatile const  uint32_t PID1;
  volatile const  uint32_t PID2;
  volatile const  uint32_t PID3;
  volatile const  uint32_t CID0;
  volatile const  uint32_t CID1;
  volatile const  uint32_t CID2;
  volatile const  uint32_t CID3;
} ITM_Type;


 
typedef struct
{
       uint32_t RESERVED0;
  volatile const  uint32_t ICTR;                          



       uint32_t RESERVED1;

} InterruptType_Type;


 

typedef struct
{
  volatile const  uint32_t TYPE;                          
  volatile uint32_t CTRL;                          
  volatile uint32_t RNR;                           
  volatile uint32_t RBAR;                          
  volatile uint32_t RASR;                          
  volatile uint32_t RBAR_A1;                       
  volatile uint32_t RASR_A1;                       
  volatile uint32_t RBAR_A2;                       
  volatile uint32_t RASR_A2;                       
  volatile uint32_t RBAR_A3;                       
  volatile uint32_t RASR_A3;                       
} MPU_Type;



 
typedef struct
{
  volatile uint32_t DHCSR;                         
  volatile  uint32_t DCRSR;                         
  volatile uint32_t DCRDR;                         
  volatile uint32_t DEMCR;                         
} CoreDebug_Type;


 
#line 274 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"

#line 281 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"










 






#line 311 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"


 


 




#line 336 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"


 
 
 
 









 
extern uint32_t __get_PSP(void);









 
extern void __set_PSP(uint32_t topOfProcStack);









 
extern uint32_t __get_MSP(void);









 
extern void __set_MSP(uint32_t topOfMainStack);








 
extern uint32_t __REV16(uint16_t value);








 
extern int32_t __REVSH(int16_t value);


#line 502 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"









 









 
static __inline uint32_t  __get_BASEPRI(void)
{
  register uint32_t __regBasePri         __asm("basepri");
  return(__regBasePri);
}








 
static __inline void __set_BASEPRI(uint32_t basePri)
{
  register uint32_t __regBasePri         __asm("basepri");
  __regBasePri = (basePri & 0x1ff);
}









 
static __inline uint32_t __get_PRIMASK(void)
{
  register uint32_t __regPriMask         __asm("primask");
  return(__regPriMask);
}








 
static __inline void __set_PRIMASK(uint32_t priMask)
{
  register uint32_t __regPriMask         __asm("primask");
  __regPriMask = (priMask);
}








 
static __inline uint32_t __get_FAULTMASK(void)
{
  register uint32_t __regFaultMask       __asm("faultmask");
  return(__regFaultMask);
}








 
static __inline void __set_FAULTMASK(uint32_t faultMask)
{
  register uint32_t __regFaultMask       __asm("faultmask");
  __regFaultMask = (faultMask & 1);
}








 
static __inline uint32_t __get_CONTROL(void)
{
  register uint32_t __regControl         __asm("control");
  return(__regControl);
}








 
static __inline void __set_CONTROL(uint32_t control)
{
  register uint32_t __regControl         __asm("control");
  __regControl = control;
}





#line 1044 "C:\\Keil\\ARM\\RV31\\INC\\core_cm3.h"



 













 
static __inline void NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
{
  uint32_t reg_value;
  uint32_t PriorityGroupTmp = (PriorityGroup & 0x07);                          
  
  reg_value  = ((SCB_Type *) ((0xE000E000) + 0x0D00))->AIRCR;                                                     
  reg_value &= ~((0xFFFFU << 16) | (0x0F << 8));                               
  reg_value  = ((reg_value | (0x5FA << 16) | (PriorityGroupTmp << 8)));   
  ((SCB_Type *) ((0xE000E000) + 0x0D00))->AIRCR = reg_value;
}









 
static __inline uint32_t NVIC_GetPriorityGrouping(void)
{
  return ((((SCB_Type *) ((0xE000E000) + 0x0D00))->AIRCR >> 8) & 0x07);                                           
}









 
static __inline void NVIC_EnableIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000) + 0x0100))->ISER[((uint32_t)(IRQn) >> 5)] = (1 << ((uint32_t)(IRQn) & 0x1F));  
}









 
static __inline void NVIC_DisableIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000) + 0x0100))->ICER[((uint32_t)(IRQn) >> 5)] = (1 << ((uint32_t)(IRQn) & 0x1F));  
}









 
static __inline uint32_t NVIC_GetPendingIRQ(IRQn_Type IRQn)
{
  return((uint32_t) ((((NVIC_Type *) ((0xE000E000) + 0x0100))->ISPR[(uint32_t)(IRQn) >> 5] & (1 << ((uint32_t)(IRQn) & 0x1F)))?1:0));  
}









 
static __inline void NVIC_SetPendingIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000) + 0x0100))->ISPR[((uint32_t)(IRQn) >> 5)] = (1 << ((uint32_t)(IRQn) & 0x1F));  
}









 
static __inline void NVIC_ClearPendingIRQ(IRQn_Type IRQn)
{
  ((NVIC_Type *) ((0xE000E000) + 0x0100))->ICPR[((uint32_t)(IRQn) >> 5)] = (1 << ((uint32_t)(IRQn) & 0x1F));  
}









 
static __inline uint32_t NVIC_GetActive(IRQn_Type IRQn)
{
  return((uint32_t)((((NVIC_Type *) ((0xE000E000) + 0x0100))->IABR[(uint32_t)(IRQn) >> 5] & (1 << ((uint32_t)(IRQn) & 0x1F)))?1:0));  
}













 
static __inline void NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority)
{
  if(IRQn < 0) {
    ((SCB_Type *) ((0xE000E000) + 0x0D00))->SHP[((uint32_t)(IRQn) & 0xF)-4] = ((priority << (8 - 5)) & 0xff); }  
  else {
    ((NVIC_Type *) ((0xE000E000) + 0x0100))->IP[(uint32_t)(IRQn)] = ((priority << (8 - 5)) & 0xff);    }         
}















 
static __inline uint32_t NVIC_GetPriority(IRQn_Type IRQn)
{

  if(IRQn < 0) {
    return((uint32_t)(((SCB_Type *) ((0xE000E000) + 0x0D00))->SHP[((uint32_t)(IRQn) & 0xF)-4] >> (8 - 5)));  }  
  else {
    return((uint32_t)(((NVIC_Type *) ((0xE000E000) + 0x0100))->IP[(uint32_t)(IRQn)]           >> (8 - 5)));  }  
}
















 
static __inline uint32_t NVIC_EncodePriority (uint32_t PriorityGroup, uint32_t PreemptPriority, uint32_t SubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & 0x07);                          
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7 - PriorityGroupTmp) > 5) ? 5 : 7 - PriorityGroupTmp;
  SubPriorityBits     = ((PriorityGroupTmp + 5) < 7) ? 0 : PriorityGroupTmp - 7 + 5;
 
  return (
           ((PreemptPriority & ((1 << (PreemptPriorityBits)) - 1)) << SubPriorityBits) |
           ((SubPriority     & ((1 << (SubPriorityBits    )) - 1)))
         );
}

















 
static __inline void NVIC_DecodePriority (uint32_t Priority, uint32_t PriorityGroup, uint32_t* pPreemptPriority, uint32_t* pSubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & 0x07);                          
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7 - PriorityGroupTmp) > 5) ? 5 : 7 - PriorityGroupTmp;
  SubPriorityBits     = ((PriorityGroupTmp + 5) < 7) ? 0 : PriorityGroupTmp - 7 + 5;
  
  *pPreemptPriority = (Priority >> SubPriorityBits) & ((1 << (PreemptPriorityBits)) - 1);
  *pSubPriority     = (Priority                   ) & ((1 << (SubPriorityBits    )) - 1);
}



 



 














 
static __inline uint32_t SysTick_Config(uint32_t ticks)
{ 
  if (ticks > ((1<<24) -1))  return (1);                                              

  ((SysTick_Type *) ((0xE000E000) + 0x0010))->LOAD  =  (ticks & ((1<<24) -1)) - 1;                                       
  NVIC_SetPriority (SysTick_IRQn, (1<<5) - 1);                             
  ((SysTick_Type *) ((0xE000E000) + 0x0010))->VAL   =  (0x00);                                                               
  ((SysTick_Type *) ((0xE000E000) + 0x0010))->CTRL = (1 << 2) | (1<<0) | (1<<1);  
  return (0);                                                                             
}







 








 
static __inline void NVIC_SystemReset(void)
{
  ((SCB_Type *) ((0xE000E000) + 0x0D00))->AIRCR  = ((0x5FA << 16) | (((SCB_Type *) ((0xE000E000) + 0x0D00))->AIRCR & (0x700)) | (1<<2));  
  __dsb(0);                                                                                            
  while(1);                                                                             
}


 











 
static __inline uint32_t ITM_SendChar (uint32_t ch)
{
  if (ch == '\n') ITM_SendChar('\r');
  
  if ((((CoreDebug_Type *) (0xE000EDF0))->DEMCR & (1 << 24))  &&
      (((ITM_Type *) (0xE0000000))->TCR & 1)                  &&
      (((ITM_Type *) (0xE0000000))->TER & (1UL << 0))  ) 
  {
    while (((ITM_Type *) (0xE0000000))->PORT[0].u32 == 0);
    ((ITM_Type *) (0xE0000000))->PORT[0].u8 = (uint8_t) ch;
  }  
  return (ch);
}







 
#line 97 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"
#line 1 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\system_LPC17xx.h"




















 









extern uint32_t SystemFrequency;     










 
extern void SystemInit (void);





#line 98 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"


 
 
 


#pragma anon_unions


 
typedef struct
{
  volatile uint32_t FLASHCFG;                
       uint32_t RESERVED0[31];
  volatile uint32_t PLL0CON;                 
  volatile uint32_t PLL0CFG;
  volatile const  uint32_t PLL0STAT;
  volatile  uint32_t PLL0FEED;
       uint32_t RESERVED1[4];
  volatile uint32_t PLL1CON;
  volatile uint32_t PLL1CFG;
  volatile const  uint32_t PLL1STAT;
  volatile  uint32_t PLL1FEED;
       uint32_t RESERVED2[4];
  volatile uint32_t PCON;
  volatile uint32_t PCONP;
       uint32_t RESERVED3[15];
  volatile uint32_t CCLKCFG;
  volatile uint32_t USBCLKCFG;
  volatile uint32_t CLKSRCSEL;
  volatile uint32_t	CANSLEEPCLR;
  volatile uint32_t	CANWAKEFLAGS;
       uint32_t RESERVED4[10];
  volatile uint32_t EXTINT;                  
       uint32_t RESERVED5;
  volatile uint32_t EXTMODE;
  volatile uint32_t EXTPOLAR;
       uint32_t RESERVED6[12];
  volatile uint32_t RSID;                    
       uint32_t RESERVED7[7];
  volatile uint32_t SCS;                     
  volatile uint32_t IRCTRIM;                 
  volatile uint32_t PCLKSEL0;
  volatile uint32_t PCLKSEL1;
       uint32_t RESERVED8[4];
  volatile uint32_t USBIntSt;                
  volatile uint32_t DMAREQSEL;
  volatile uint32_t CLKOUTCFG;               
 } LPC_SC_TypeDef;

 
typedef struct
{
  volatile uint32_t PINSEL0;
  volatile uint32_t PINSEL1;
  volatile uint32_t PINSEL2;
  volatile uint32_t PINSEL3;
  volatile uint32_t PINSEL4;
  volatile uint32_t PINSEL5;
  volatile uint32_t PINSEL6;
  volatile uint32_t PINSEL7;
  volatile uint32_t PINSEL8;
  volatile uint32_t PINSEL9;
  volatile uint32_t PINSEL10;
       uint32_t RESERVED0[5];
  volatile uint32_t PINMODE0;
  volatile uint32_t PINMODE1;
  volatile uint32_t PINMODE2;
  volatile uint32_t PINMODE3;
  volatile uint32_t PINMODE4;
  volatile uint32_t PINMODE5;
  volatile uint32_t PINMODE6;
  volatile uint32_t PINMODE7;
  volatile uint32_t PINMODE8;
  volatile uint32_t PINMODE9;
  volatile uint32_t PINMODE_OD0;
  volatile uint32_t PINMODE_OD1;
  volatile uint32_t PINMODE_OD2;
  volatile uint32_t PINMODE_OD3;
  volatile uint32_t PINMODE_OD4;
  volatile uint32_t I2CPADCFG;
} LPC_PINCON_TypeDef;

 
typedef struct
{
  union {
    volatile uint32_t FIODIR;
    struct {
      volatile uint16_t FIODIRL;
      volatile uint16_t FIODIRH;
    };
    struct {
      volatile uint8_t  FIODIR0;
      volatile uint8_t  FIODIR1;
      volatile uint8_t  FIODIR2;
      volatile uint8_t  FIODIR3;
    };
  };
  uint32_t RESERVED0[3];
  union {
    volatile uint32_t FIOMASK;
    struct {
      volatile uint16_t FIOMASKL;
      volatile uint16_t FIOMASKH;
    };
    struct {
      volatile uint8_t  FIOMASK0;
      volatile uint8_t  FIOMASK1;
      volatile uint8_t  FIOMASK2;
      volatile uint8_t  FIOMASK3;
    };
  };
  union {
    volatile uint32_t FIOPIN;
    struct {
      volatile uint16_t FIOPINL;
      volatile uint16_t FIOPINH;
    };
    struct {
      volatile uint8_t  FIOPIN0;
      volatile uint8_t  FIOPIN1;
      volatile uint8_t  FIOPIN2;
      volatile uint8_t  FIOPIN3;
    };
  };
  union {
    volatile uint32_t FIOSET;
    struct {
      volatile uint16_t FIOSETL;
      volatile uint16_t FIOSETH;
    };
    struct {
      volatile uint8_t  FIOSET0;
      volatile uint8_t  FIOSET1;
      volatile uint8_t  FIOSET2;
      volatile uint8_t  FIOSET3;
    };
  };
  union {
    volatile  uint32_t FIOCLR;
    struct {
      volatile  uint16_t FIOCLRL;
      volatile  uint16_t FIOCLRH;
    };
    struct {
      volatile  uint8_t  FIOCLR0;
      volatile  uint8_t  FIOCLR1;
      volatile  uint8_t  FIOCLR2;
      volatile  uint8_t  FIOCLR3;
    };
  };
} LPC_GPIO_TypeDef;

typedef struct
{
  volatile const  uint32_t IntStatus;
  volatile const  uint32_t IO0IntStatR;
  volatile const  uint32_t IO0IntStatF;
  volatile  uint32_t IO0IntClr;
  volatile uint32_t IO0IntEnR;
  volatile uint32_t IO0IntEnF;
       uint32_t RESERVED0[3];
  volatile const  uint32_t IO2IntStatR;
  volatile const  uint32_t IO2IntStatF;
  volatile  uint32_t IO2IntClr;
  volatile uint32_t IO2IntEnR;
  volatile uint32_t IO2IntEnF;
} LPC_GPIOINT_TypeDef;

 
typedef struct
{
  volatile uint32_t IR;
  volatile uint32_t TCR;
  volatile uint32_t TC;
  volatile uint32_t PR;
  volatile uint32_t PC;
  volatile uint32_t MCR;
  volatile uint32_t MR0;
  volatile uint32_t MR1;
  volatile uint32_t MR2;
  volatile uint32_t MR3;
  volatile uint32_t CCR;
  volatile const  uint32_t CR0;
  volatile const  uint32_t CR1;
       uint32_t RESERVED0[2];
  volatile uint32_t EMR;
       uint32_t RESERVED1[12];
  volatile uint32_t CTCR;
} LPC_TIM_TypeDef;

 
typedef struct
{
  volatile uint32_t IR;
  volatile uint32_t TCR;
  volatile uint32_t TC;
  volatile uint32_t PR;
  volatile uint32_t PC;
  volatile uint32_t MCR;
  volatile uint32_t MR0;
  volatile uint32_t MR1;
  volatile uint32_t MR2;
  volatile uint32_t MR3;
  volatile uint32_t CCR;
  volatile const  uint32_t CR0;
  volatile const  uint32_t CR1;
  volatile const  uint32_t CR2;
  volatile const  uint32_t CR3;
       uint32_t RESERVED0;
  volatile uint32_t MR4;
  volatile uint32_t MR5;
  volatile uint32_t MR6;
  volatile uint32_t PCR;
  volatile uint32_t LER;
       uint32_t RESERVED1[7];
  volatile uint32_t CTCR;
} LPC_PWM_TypeDef;

 
typedef struct
{
  union {
  volatile const  uint8_t  RBR;
  volatile  uint8_t  THR;
  volatile uint8_t  DLL;
       uint32_t RESERVED0;
  };
  union {
  volatile uint8_t  DLM;
  volatile uint32_t IER;
  };
  union {
  volatile const  uint32_t IIR;
  volatile  uint8_t  FCR;
  };
  volatile uint8_t  LCR;
       uint8_t  RESERVED1[7];
  volatile const  uint8_t  LSR;
       uint8_t  RESERVED2[7];
  volatile uint8_t  SCR;
       uint8_t  RESERVED3[3];
  volatile uint32_t ACR;
  volatile uint8_t  ICR;
       uint8_t  RESERVED4[3];
  volatile uint8_t  FDR;
       uint8_t  RESERVED5[7];
  volatile uint8_t  TER;
       uint8_t  RESERVED6[39];
  volatile uint32_t FIFOLVL;
} LPC_UART_TypeDef;

typedef struct
{
  union {
  volatile const  uint8_t  RBR;
  volatile  uint8_t  THR;
  volatile uint8_t  DLL;
       uint32_t RESERVED0;
  };
  union {
  volatile uint8_t  DLM;
  volatile uint32_t IER;
  };
  union {
  volatile const  uint32_t IIR;
  volatile  uint8_t  FCR;
  };
  volatile uint8_t  LCR;
       uint8_t  RESERVED1[7];
  volatile const  uint8_t  LSR;
       uint8_t  RESERVED2[7];
  volatile uint8_t  SCR;
       uint8_t  RESERVED3[3];
  volatile uint32_t ACR;
  volatile uint8_t  ICR;
       uint8_t  RESERVED4[3];
  volatile uint8_t  FDR;
       uint8_t  RESERVED5[7];
  volatile uint8_t  TER;
       uint8_t  RESERVED6[39];
  volatile uint32_t FIFOLVL;
} LPC_UART0_TypeDef;

typedef struct
{
  union {
  volatile const  uint8_t  RBR;
  volatile  uint8_t  THR;
  volatile uint8_t  DLL;
       uint32_t RESERVED0;
  };
  union {
  volatile uint8_t  DLM;
  volatile uint32_t IER;
  };
  union {
  volatile const  uint32_t IIR;
  volatile  uint8_t  FCR;
  };
  volatile uint8_t  LCR;
       uint8_t  RESERVED1[3];
  volatile uint8_t  MCR;
       uint8_t  RESERVED2[3];
  volatile const  uint8_t  LSR;
       uint8_t  RESERVED3[3];
  volatile const  uint8_t  MSR;
       uint8_t  RESERVED4[3];
  volatile uint8_t  SCR;
       uint8_t  RESERVED5[3];
  volatile uint32_t ACR;
       uint32_t RESERVED6;
  volatile uint32_t FDR;
       uint32_t RESERVED7;
  volatile uint8_t  TER;
       uint8_t  RESERVED8[27];
  volatile uint8_t  RS485CTRL;
       uint8_t  RESERVED9[3];
  volatile uint8_t  ADRMATCH;
       uint8_t  RESERVED10[3];
  volatile uint8_t  RS485DLY;
       uint8_t  RESERVED11[3];
  volatile uint32_t FIFOLVL;
} LPC_UART1_TypeDef;

 
typedef struct
{
  volatile uint32_t SPCR;
  volatile const  uint32_t SPSR;
  volatile uint32_t SPDR;
  volatile uint32_t SPCCR;
       uint32_t RESERVED0[3];
  volatile uint32_t SPINT;
} LPC_SPI_TypeDef;

 
typedef struct
{
  volatile uint32_t CR0;
  volatile uint32_t CR1;
  volatile uint32_t DR;
  volatile const  uint32_t SR;
  volatile uint32_t CPSR;
  volatile uint32_t IMSC;
  volatile uint32_t RIS;
  volatile uint32_t MIS;
  volatile uint32_t ICR;
  volatile uint32_t DMACR;
} LPC_SSP_TypeDef;

 
typedef struct
{
  volatile uint32_t I2CONSET;
  volatile const  uint32_t I2STAT;
  volatile uint32_t I2DAT;
  volatile uint32_t I2ADR0;
  volatile uint32_t I2SCLH;
  volatile uint32_t I2SCLL;
  volatile  uint32_t I2CONCLR;
  volatile uint32_t MMCTRL;
  volatile uint32_t I2ADR1;
  volatile uint32_t I2ADR2;
  volatile uint32_t I2ADR3;
  volatile const  uint32_t I2DATA_BUFFER;
  volatile uint32_t I2MASK0;
  volatile uint32_t I2MASK1;
  volatile uint32_t I2MASK2;
  volatile uint32_t I2MASK3;
} LPC_I2C_TypeDef;

 
typedef struct
{
  volatile uint32_t I2SDAO;
  volatile uint32_t I2SDAI;
  volatile  uint32_t I2STXFIFO;
  volatile const  uint32_t I2SRXFIFO;
  volatile const  uint32_t I2SSTATE;
  volatile uint32_t I2SDMA1;
  volatile uint32_t I2SDMA2;
  volatile uint32_t I2SIRQ;
  volatile uint32_t I2STXRATE;
  volatile uint32_t I2SRXRATE;
  volatile uint32_t I2STXBITRATE;
  volatile uint32_t I2SRXBITRATE;
  volatile uint32_t I2STXMODE;
  volatile uint32_t I2SRXMODE;
} LPC_I2S_TypeDef;

 
typedef struct
{
  volatile uint32_t RICOMPVAL;
  volatile uint32_t RIMASK;
  volatile uint8_t  RICTRL;
       uint8_t  RESERVED0[3];
  volatile uint32_t RICOUNTER;
} LPC_RIT_TypeDef;

 
typedef struct
{
  volatile uint8_t  ILR;
       uint8_t  RESERVED0[7];
  volatile uint8_t  CCR;
       uint8_t  RESERVED1[3];
  volatile uint8_t  CIIR;
       uint8_t  RESERVED2[3];
  volatile uint8_t  AMR;
       uint8_t  RESERVED3[3];
  volatile const  uint32_t CTIME0;
  volatile const  uint32_t CTIME1;
  volatile const  uint32_t CTIME2;
  volatile uint8_t  SEC;
       uint8_t  RESERVED4[3];
  volatile uint8_t  MIN;
       uint8_t  RESERVED5[3];
  volatile uint8_t  HOUR;
       uint8_t  RESERVED6[3];
  volatile uint8_t  DOM;
       uint8_t  RESERVED7[3];
  volatile uint8_t  DOW;
       uint8_t  RESERVED8[3];
  volatile uint16_t DOY;
       uint16_t RESERVED9;
  volatile uint8_t  MONTH;
       uint8_t  RESERVED10[3];
  volatile uint16_t YEAR;
       uint16_t RESERVED11;
  volatile uint32_t CALIBRATION;
  volatile uint32_t GPREG0;
  volatile uint32_t GPREG1;
  volatile uint32_t GPREG2;
  volatile uint32_t GPREG3;
  volatile uint32_t GPREG4;
  volatile uint8_t  RTC_AUXEN;
       uint8_t  RESERVED12[3];
  volatile uint8_t  RTC_AUX;
       uint8_t  RESERVED13[3];
  volatile uint8_t  ALSEC;
       uint8_t  RESERVED14[3];
  volatile uint8_t  ALMIN;
       uint8_t  RESERVED15[3];
  volatile uint8_t  ALHOUR;
       uint8_t  RESERVED16[3];
  volatile uint8_t  ALDOM;
       uint8_t  RESERVED17[3];
  volatile uint8_t  ALDOW;
       uint8_t  RESERVED18[3];
  volatile uint16_t ALDOY;
       uint16_t RESERVED19;
  volatile uint8_t  ALMON;
       uint8_t  RESERVED20[3];
  volatile uint16_t ALYEAR;
       uint16_t RESERVED21;
} LPC_RTC_TypeDef;

 
typedef struct
{
  volatile uint8_t  WDMOD;
       uint8_t  RESERVED0[3];
  volatile uint32_t WDTC;
  volatile  uint8_t  WDFEED;
       uint8_t  RESERVED1[3];
  volatile const  uint32_t WDTV;
  volatile uint32_t WDCLKSEL;
} LPC_WDT_TypeDef;

 
typedef struct
{
  volatile uint32_t ADCR;
  volatile uint32_t ADGDR;
       uint32_t RESERVED0;
  volatile uint32_t ADINTEN;
  volatile const  uint32_t ADDR0;
  volatile const  uint32_t ADDR1;
  volatile const  uint32_t ADDR2;
  volatile const  uint32_t ADDR3;
  volatile const  uint32_t ADDR4;
  volatile const  uint32_t ADDR5;
  volatile const  uint32_t ADDR6;
  volatile const  uint32_t ADDR7;
  volatile const  uint32_t ADSTAT;
  volatile uint32_t ADTRM;
} LPC_ADC_TypeDef;

 
typedef struct
{
  volatile uint32_t DACR;
  volatile uint32_t DACCTRL;
  volatile uint16_t DACCNTVAL;
} LPC_DAC_TypeDef;

 
typedef struct
{
  volatile const  uint32_t MCCON;
  volatile  uint32_t MCCON_SET;
  volatile  uint32_t MCCON_CLR;
  volatile const  uint32_t MCCAPCON;
  volatile  uint32_t MCCAPCON_SET;
  volatile  uint32_t MCCAPCON_CLR;
  volatile uint32_t MCTIM0;
  volatile uint32_t MCTIM1;
  volatile uint32_t MCTIM2;
  volatile uint32_t MCPER0;
  volatile uint32_t MCPER1;
  volatile uint32_t MCPER2;
  volatile uint32_t MCPW0;
  volatile uint32_t MCPW1;
  volatile uint32_t MCPW2;
  volatile uint32_t MCDEADTIME;
  volatile uint32_t MCCCP;
  volatile uint32_t MCCR0;
  volatile uint32_t MCCR1;
  volatile uint32_t MCCR2;
  volatile const  uint32_t MCINTEN;
  volatile  uint32_t MCINTEN_SET;
  volatile  uint32_t MCINTEN_CLR;
  volatile const  uint32_t MCCNTCON;
  volatile  uint32_t MCCNTCON_SET;
  volatile  uint32_t MCCNTCON_CLR;
  volatile const  uint32_t MCINTFLAG;
  volatile  uint32_t MCINTFLAG_SET;
  volatile  uint32_t MCINTFLAG_CLR;
  volatile  uint32_t MCCAP_CLR;
} LPC_MCPWM_TypeDef;

 
typedef struct
{
  volatile  uint32_t QEICON;
  volatile const  uint32_t QEISTAT;
  volatile uint32_t QEICONF;
  volatile const  uint32_t QEIPOS;
  volatile uint32_t QEIMAXPOS;
  volatile uint32_t CMPOS0;
  volatile uint32_t CMPOS1;
  volatile uint32_t CMPOS2;
  volatile const  uint32_t INXCNT;
  volatile uint32_t INXCMP;
  volatile uint32_t QEILOAD;
  volatile const  uint32_t QEITIME;
  volatile const  uint32_t QEIVEL;
  volatile const  uint32_t QEICAP;
  volatile uint32_t VELCOMP;
  volatile uint32_t FILTER;
       uint32_t RESERVED0[998];
  volatile  uint32_t QEIIEC;
  volatile  uint32_t QEIIES;
  volatile const  uint32_t QEIINTSTAT;
  volatile const  uint32_t QEIIE;
  volatile  uint32_t QEICLR;
  volatile  uint32_t QEISET;
} LPC_QEI_TypeDef;

 
typedef struct
{
  volatile uint32_t mask[512];               
} LPC_CANAF_RAM_TypeDef;

typedef struct                           
{
  volatile uint32_t AFMR;
  volatile uint32_t SFF_sa;
  volatile uint32_t SFF_GRP_sa;
  volatile uint32_t EFF_sa;
  volatile uint32_t EFF_GRP_sa;
  volatile uint32_t ENDofTable;
  volatile const  uint32_t LUTerrAd;
  volatile const  uint32_t LUTerr;
  volatile uint32_t FCANIE;
  volatile uint32_t FCANIC0;
  volatile uint32_t FCANIC1;
} LPC_CANAF_TypeDef;

typedef struct                           
{
  volatile const  uint32_t CANTxSR;
  volatile const  uint32_t CANRxSR;
  volatile const  uint32_t CANMSR;
} LPC_CANCR_TypeDef;

typedef struct                           
{
  volatile uint32_t MOD;
  volatile  uint32_t CMR;
  volatile uint32_t GSR;
  volatile const  uint32_t ICR;
  volatile uint32_t IER;
  volatile uint32_t BTR;
  volatile uint32_t EWL;
  volatile const  uint32_t SR;
  volatile uint32_t RFS;
  volatile uint32_t RID;
  volatile uint32_t RDA;
  volatile uint32_t RDB;
  volatile uint32_t TFI1;
  volatile uint32_t TID1;
  volatile uint32_t TDA1;
  volatile uint32_t TDB1;
  volatile uint32_t TFI2;
  volatile uint32_t TID2;
  volatile uint32_t TDA2;
  volatile uint32_t TDB2;
  volatile uint32_t TFI3;
  volatile uint32_t TID3;
  volatile uint32_t TDA3;
  volatile uint32_t TDB3;
} LPC_CAN_TypeDef;

 
typedef struct                           
{
  volatile const  uint32_t DMACIntStat;
  volatile const  uint32_t DMACIntTCStat;
  volatile  uint32_t DMACIntTCClear;
  volatile const  uint32_t DMACIntErrStat;
  volatile  uint32_t DMACIntErrClr;
  volatile const  uint32_t DMACRawIntTCStat;
  volatile const  uint32_t DMACRawIntErrStat;
  volatile const  uint32_t DMACEnbldChns;
  volatile uint32_t DMACSoftBReq;
  volatile uint32_t DMACSoftSReq;
  volatile uint32_t DMACSoftLBReq;
  volatile uint32_t DMACSoftLSReq;
  volatile uint32_t DMACConfig;
  volatile uint32_t DMACSync;
} LPC_GPDMA_TypeDef;

typedef struct                           
{
  volatile uint32_t DMACCSrcAddr;
  volatile uint32_t DMACCDestAddr;
  volatile uint32_t DMACCLLI;
  volatile uint32_t DMACCControl;
  volatile uint32_t DMACCConfig;
} LPC_GPDMACH_TypeDef;

 
typedef struct
{
  volatile const  uint32_t HcRevision;              
  volatile uint32_t HcControl;
  volatile uint32_t HcCommandStatus;
  volatile uint32_t HcInterruptStatus;
  volatile uint32_t HcInterruptEnable;
  volatile uint32_t HcInterruptDisable;
  volatile uint32_t HcHCCA;
  volatile const  uint32_t HcPeriodCurrentED;
  volatile uint32_t HcControlHeadED;
  volatile uint32_t HcControlCurrentED;
  volatile uint32_t HcBulkHeadED;
  volatile uint32_t HcBulkCurrentED;
  volatile const  uint32_t HcDoneHead;
  volatile uint32_t HcFmInterval;
  volatile const  uint32_t HcFmRemaining;
  volatile const  uint32_t HcFmNumber;
  volatile uint32_t HcPeriodicStart;
  volatile uint32_t HcLSTreshold;
  volatile uint32_t HcRhDescriptorA;
  volatile uint32_t HcRhDescriptorB;
  volatile uint32_t HcRhStatus;
  volatile uint32_t HcRhPortStatus1;
  volatile uint32_t HcRhPortStatus2;
       uint32_t RESERVED0[40];
  volatile const  uint32_t Module_ID;

  volatile const  uint32_t OTGIntSt;                
  volatile uint32_t OTGIntEn;
  volatile  uint32_t OTGIntSet;
  volatile  uint32_t OTGIntClr;
  volatile uint32_t OTGStCtrl;
  volatile uint32_t OTGTmr;
       uint32_t RESERVED1[58];

  volatile const  uint32_t USBDevIntSt;             
  volatile uint32_t USBDevIntEn;
  volatile  uint32_t USBDevIntClr;
  volatile  uint32_t USBDevIntSet;

  volatile  uint32_t USBCmdCode;              
  volatile const  uint32_t USBCmdData;

  volatile const  uint32_t USBRxData;               
  volatile  uint32_t USBTxData;
  volatile const  uint32_t USBRxPLen;
  volatile  uint32_t USBTxPLen;
  volatile uint32_t USBCtrl;
  volatile  uint32_t USBDevIntPri;

  volatile const  uint32_t USBEpIntSt;              
  volatile uint32_t USBEpIntEn;
  volatile  uint32_t USBEpIntClr;
  volatile  uint32_t USBEpIntSet;
  volatile  uint32_t USBEpIntPri;

  volatile uint32_t USBReEp;                 
  volatile  uint32_t USBEpInd;
  volatile uint32_t USBMaxPSize;

  volatile const  uint32_t USBDMARSt;               
  volatile  uint32_t USBDMARClr;
  volatile  uint32_t USBDMARSet;
       uint32_t RESERVED2[9];
  volatile uint32_t USBUDCAH;
  volatile const  uint32_t USBEpDMASt;
  volatile  uint32_t USBEpDMAEn;
  volatile  uint32_t USBEpDMADis;
  volatile const  uint32_t USBDMAIntSt;
  volatile uint32_t USBDMAIntEn;
       uint32_t RESERVED3[2];
  volatile const  uint32_t USBEoTIntSt;
  volatile  uint32_t USBEoTIntClr;
  volatile  uint32_t USBEoTIntSet;
  volatile const  uint32_t USBNDDRIntSt;
  volatile  uint32_t USBNDDRIntClr;
  volatile  uint32_t USBNDDRIntSet;
  volatile const  uint32_t USBSysErrIntSt;
  volatile  uint32_t USBSysErrIntClr;
  volatile  uint32_t USBSysErrIntSet;
       uint32_t RESERVED4[15];

  union {
  volatile const  uint32_t I2C_RX;                  
  volatile  uint32_t I2C_TX;
  };
  volatile const  uint32_t I2C_STS;
  volatile uint32_t I2C_CTL;
  volatile uint32_t I2C_CLKHI;
  volatile  uint32_t I2C_CLKLO;
       uint32_t RESERVED5[824];

  union {
  volatile uint32_t USBClkCtrl;              
  volatile uint32_t OTGClkCtrl;
  };
  union {
  volatile const  uint32_t USBClkSt;
  volatile const  uint32_t OTGClkSt;
  };
} LPC_USB_TypeDef;

 
typedef struct
{
  volatile uint32_t MAC1;                    
  volatile uint32_t MAC2;
  volatile uint32_t IPGT;
  volatile uint32_t IPGR;
  volatile uint32_t CLRT;
  volatile uint32_t MAXF;
  volatile uint32_t SUPP;
  volatile uint32_t TEST;
  volatile uint32_t MCFG;
  volatile uint32_t MCMD;
  volatile uint32_t MADR;
  volatile  uint32_t MWTD;
  volatile const  uint32_t MRDD;
  volatile const  uint32_t MIND;
       uint32_t RESERVED0[2];
  volatile uint32_t SA0;
  volatile uint32_t SA1;
  volatile uint32_t SA2;
       uint32_t RESERVED1[45];
  volatile uint32_t Command;                 
  volatile const  uint32_t Status;
  volatile uint32_t RxDescriptor;
  volatile uint32_t RxStatus;
  volatile uint32_t RxDescriptorNumber;
  volatile const  uint32_t RxProduceIndex;
  volatile uint32_t RxConsumeIndex;
  volatile uint32_t TxDescriptor;
  volatile uint32_t TxStatus;
  volatile uint32_t TxDescriptorNumber;
  volatile uint32_t TxProduceIndex;
  volatile const  uint32_t TxConsumeIndex;
       uint32_t RESERVED2[10];
  volatile const  uint32_t TSV0;
  volatile const  uint32_t TSV1;
  volatile const  uint32_t RSV;
       uint32_t RESERVED3[3];
  volatile uint32_t FlowControlCounter;
  volatile const  uint32_t FlowControlStatus;
       uint32_t RESERVED4[34];
  volatile uint32_t RxFilterCtrl;            
  volatile uint32_t RxFilterWoLStatus;
  volatile uint32_t RxFilterWoLClear;
       uint32_t RESERVED5;
  volatile uint32_t HashFilterL;
  volatile uint32_t HashFilterH;
       uint32_t RESERVED6[882];
  volatile const  uint32_t IntStatus;               
  volatile uint32_t IntEnable;
  volatile  uint32_t IntClear;
  volatile  uint32_t IntSet;
       uint32_t RESERVED7;
  volatile uint32_t PowerDown;
       uint32_t RESERVED8;
  volatile uint32_t Module_ID;
} LPC_EMAC_TypeDef;


#pragma no_anon_unions



 
 
 
 
#line 924 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"

 
#line 945 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"

 
#line 959 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"

 
#line 972 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"

 







 
 
 
#line 1031 "C:\\Keil\\ARM\\INC\\NXP\\LPC17xx\\LPC17xx.H"

#line 461 "main.c"







 

extern short plazma_adc_cnt;
extern char net_buff_cnt;
extern unsigned short net_buff[32],net_buff_;
extern char rele_stat ;
extern char bRXIN0;


char cntrl_plazma;
extern char bOUT_FREE2;
extern char   av_bps[12],av_inv[6],av_dt[4],av_sk[4];

char content[63];









extern signed short samokalibr_cnt;



extern char mess[10],mess_old[10],mess_cnt[10];
extern short mess_par0[10],mess_par1[10],mess_data[2];




extern signed short 	main_kb_cnt;
extern signed short 	kb_cnt_1lev;
extern signed short 	kb_cnt_2lev;
extern char 			kb_full_ver;
extern char 			kb_start[2],kb_start_ips;





char sign_U[2],sign_I[2];
char superviser_cnt;


char plazma_plazma_plazma;

char bRESET=0;
char bRESET_EXT=0;
char ext_can_cnt;
char bRESET_INT_WDT=0;
char bRESET_EXT_WDT=0;


signed short vvod_pos;



unsigned short adc_buff_ext_[3];
unsigned short Uvv[3];
unsigned short Uvv0;
short pos_vent;
short t_ext_can;
char t_ext_can_nd;




char eb2_data[30];
short eb2_data_short[10];
short Uvv_eb2[3],Upes_eb2[3];
short Kvv_eb2[3],Kpes_eb2[3];


signed long power_summary;
signed short power_current;
signed long power_summary_tempo,power_summary_tempo_old;
signed short power_current_tempo,power_current_tempo_old;
char powerSummaryCnt;
char powerCurrentCnt;



signed short main_vent_pos;
signed char t_box_cnt=0;
enum_mixer_vent_stat mixer_vent_stat=mvsOFF;
INT_BOX_TEMPER ibt;
enum_tbatdisable_stat tbatdisable_stat=tbdsON;
enum_tloaddisable_stat tloaddisable_stat=tldsON;
enum_av_tbox_stat av_tbox_stat=atsOFF;
signed short av_tbox_cnt;
short tbatdisable_cnt,tloaddisable_cnt;
#line 568 "main.c"

#line 577 "main.c"







char snmp_plazma;


short plazma_but_an;

char bCAN_OFF;


char max_net_slot;



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



signed short speedChrgCurr;			
signed short speedChrgVolt;			
signed short speedChrgTimeInHour; 		
signed short speedChrgAvtEn;	    		
signed short speedChrgDU;	    		
signed short speedChIsOn;			
signed long  speedChTimeCnt;			
signed short speedChrgBlckSrc;		
signed short speedChrgBlckLog;		
signed short speedChrgBlckStat;		
char  	   speedChrgShowCnt;		



signed short ipsBlckSrc;
signed short ipsBlckLog;
signed short ipsBlckStat;




signed short outVoltContrHndlCnt;		
signed short outVoltContrHndlCnt_;		
char uout_av;



char bVDISWORK;
char vd_is_work_cnt;

short plazma_numOfCells;
short plazma_numOfTemperCells;
short plazma_numOfPacks;




 

char plazma_ztt[2];
char plazma1809;

U8 socket_tcp;







char ica_plazma[10];
char ica_timer_cnt;
signed short ica_my_current;
signed short ica_your_current;
signed short ica_u_necc;
U8 tcp_soc_avg;
U8 tcp_connect_stat;



short overloadHndlCnt;
char overloadAvar;



short uAvarHndlOutUMaxCnt,uAvarHndlOutUMinCnt;
char uOutAvar;



short uAvarHndlInUMaxCnt,uAvarHndlInUMinCnt;
char uInAvar;



short sysTAvarHndlCnt;
char sysTAvar;

short pvlk;
char klbr_en;




char rele_in_stat[3][3];



enum_optr_stat optr_stat[3];



short rele_av_flags;
short avar_vd_stat;










#line 735 "main.c"


void uartWrite(char c)
{
	
	if( c == '\n' ) 
		{
	

 

		putchar_sc16is700(0x0D);
		putchar_sc16is700(0x0A);
		}
	else
		{
		
		putchar_sc16is700(c);
		}
}


int fputc(int c, FILE * stream)
{
	uartWrite(c); 
	return c; 
}



void rtc_init (void) 
{
((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->CCR=0x11;
}










 



signed short abs_pal(signed short in)
{
if(in<0)return -in;
else return in;
}















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



void ADC_IRQHandler(void) {
((LPC_ADC_TypeDef *) ((0x40000000UL) + 0x34000) )->ADCR &=  ~(7<<24);



adc_self_ch_buff[adc_self_ch_cnt]=(((LPC_ADC_TypeDef *) ((0x40000000UL) + 0x34000) )->ADGDR>>4) & 0xFFF; 
adc_self_ch_cnt++;
if(adc_self_ch_cnt<3)
	{
	((LPC_ADC_TypeDef *) ((0x40000000UL) + 0x34000) )->ADCR |=  (1<<24);
	}
else
	{

 
	
	}



 
}


void transmit_hndl(void)
{
static char transmit_hndl_cnt;
if(a_ind . i==iMn)
	{
	printf("OK%dCRC%d\n",25,7);
	}
else if(a_ind . i==iOptr_kontr)
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

else if(a_ind . i==iSet_T)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",11,2);
	else 
		{
		char tempCRC=0;

		tempCRC=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR%100;
		tempCRC^=(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH%100);
		tempCRC^=(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM%100);
		tempCRC^=(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOW%100);
		tempCRC^=(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR%100);
		tempCRC^=(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN%100);
		
		printf("DATA%02d%02d%02d%02d%02d%02dCRC%d\n",((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR,((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH,((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM,((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOW+1,((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR,((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN,tempCRC);
		} 
	}

else if(a_ind . i==iSet_T_ret)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	
  						printf("TIMESTART\n");
	}

else if(a_ind . i==iWater_sensor_kontr)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",12,2);
	else 
		{
		printf("WATER\n");
		}
	}
else if(a_ind . i==iWater_sensor_kontr_ret)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	printf("WAT_RET\n");
	}
else if(a_ind . i==iAir_sensor_kontr)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	if(transmit_hndl_cnt==0)printf("OK%dCRC%d\n",17,2);
	else 
		{
		printf("AIR\n");
		}
	}
else if(a_ind . i==iAir_sensor_kontr_ret)
	{
	transmit_hndl_cnt++;
	if(transmit_hndl_cnt>=5)transmit_hndl_cnt=0;

	printf("AI_RET\n");
	}
else if(a_ind . i==iInterf_kontr)
	{
	printf("INTER\n");

	}
else if(a_ind . i==iInterf_kontr_ret)
	{
	printf("INTE_RET\n");
	}
else if(a_ind . i==iProbesms)
	{
	printf("PROBESMS\n");
	}

}



void def_ips_set(short voltage)
{
if(voltage==24)
	{
	
	}
if(voltage==48)
	{
	
	}
if(voltage==60)
	{
	
	}

if(voltage==220)
	{
	

	lc640_write_int(0x10+100+36,2);
	lc640_write_int(0x10+100+38,0);


	lc640_write_int(0x10+100+2,0);
	lc640_write_int(0x10+100+86,1);
	lc640_write_int(0x10+100+78,60);
	lc640_write_int(0x10+100+4,2450);
	lc640_write_int(0x10+100+84,2315/2);
	
	
	lc640_write_int(0x10+100+82,70);
	lc640_write_int(0x10+100+10,80);

	lc640_write_int(0x10+100+14,187);
	lc640_write_int(0x10+100+16,187);
	lc640_write_int(0x10+100+18,0);
	lc640_write_int(0x10+100+20,20);

	
	lc640_write_int(0x10+100+24,80);
	lc640_write_int(0x10+100+26,50);

	lc640_write_int(0x10+100+44,apvON);
	lc640_write_int(0x10+100+46,apvON);
	lc640_write_int(0x10+100+48,1);
	lc640_write_int(0x10+100+30,160);
	lc640_write_int(0x10+100+32,2200);
	lc640_write_int(0x10+100+34,3);
	lc640_write_int(0x10+100+88,50);  
	lc640_write_int(0x10+100+90,40);
	lc640_write_int(0x10+100+72,mnON);
	lc640_write_int(0x10+100+74,30);	
	lc640_write_int(0x10+100+12,1);




	lc640_write_int(0x10+100+92,70);
	lc640_write_int(0x10+100+96,60);
	lc640_write_int(0x10+100+94,25);
	lc640_write_int(0x10+100+98,80);
	lc640_write_int(0x10+100+100,70);
	lc640_write_int(0x10+100+102,91);
	lc640_write_int(0x10+100+104,80);

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

	lc640_write_int(0x10+500+96,10);

	lc640_write_int(0x10+500+92,11);


	lc640_write_int(0x10+100+84,2315-1870);
	lc640_write_int(0x10+100+80,2200);
	lc640_write_int(0x10+100+30,20);
	lc640_write_int(0x10+100+224,22033);
	lc640_write_int(0x10+100+86,1);
	lc640_write_int(0x10+100+72,mnOFF);
	}

if(voltage==110)
	{
	

	lc640_write_int(0x10+100+36,2);
	lc640_write_int(0x10+100+38,0);


	lc640_write_int(0x10+100+2,0);
	lc640_write_int(0x10+100+86,1);
	lc640_write_int(0x10+100+78,60);
	lc640_write_int(0x10+100+4,1350);
	lc640_write_int(0x10+100+84,1350/2);
	
	
	lc640_write_int(0x10+100+82,70);
	lc640_write_int(0x10+100+10,80);

	lc640_write_int(0x10+100+14,99);
	lc640_write_int(0x10+100+16,187);
	lc640_write_int(0x10+100+18,0);
	lc640_write_int(0x10+100+20,20);

	
	lc640_write_int(0x10+100+24,80);
	lc640_write_int(0x10+100+26,50);

	lc640_write_int(0x10+100+44,apvON);
	lc640_write_int(0x10+100+46,apvON);
	lc640_write_int(0x10+100+48,1);
	lc640_write_int(0x10+100+30,160);
	lc640_write_int(0x10+100+32,1220);
	lc640_write_int(0x10+100+34,3);
	lc640_write_int(0x10+100+88,50);  
	lc640_write_int(0x10+100+90,40);
	lc640_write_int(0x10+100+72,mnON);
	lc640_write_int(0x10+100+74,30);	
	lc640_write_int(0x10+100+12,1);




	lc640_write_int(0x10+100+92,70);
	lc640_write_int(0x10+100+96,60);
	lc640_write_int(0x10+100+94,25);
	lc640_write_int(0x10+100+98,80);
	lc640_write_int(0x10+100+100,70);
	lc640_write_int(0x10+100+102,91);
	lc640_write_int(0x10+100+104,80);

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

	lc640_write_int(0x10+500+96,10);

	lc640_write_int(0x10+500+92,11);


	lc640_write_int(0x10+100+84,1220-600);
	lc640_write_int(0x10+100+80,1220);
	lc640_write_int(0x10+100+30,20);
	lc640_write_int(0x10+100+224,22033);
	lc640_write_int(0x10+100+86,1);
	lc640_write_int(0x10+100+72,mnOFF);
	}

lc640_write_int(ADR_EE_BAT_IS_ON[0],bisOFF);
lc640_write_int(ADR_EE_BAT_DAY_OF_ON[0],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM);
lc640_write_int(ADR_EE_BAT_MONTH_OF_ON[0],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH);
lc640_write_int(ADR_EE_BAT_YEAR_OF_ON[0],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR);
lc640_write_int(ADR_EE_BAT_C_NOM[0],0);
lc640_write_int(ADR_EE_BAT_RESURS[0],0);

lc640_write_int(ADR_EE_BAT_IS_ON[1],bisOFF);
lc640_write_int(ADR_EE_BAT_DAY_OF_ON[1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM);
lc640_write_int(ADR_EE_BAT_MONTH_OF_ON[1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH);
lc640_write_int(ADR_EE_BAT_YEAR_OF_ON[1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR);
lc640_write_int(ADR_EE_BAT_C_NOM[1],0);
lc640_write_int(ADR_EE_BAT_RESURS[1],0);


lc640_write_int(0x10+100+164,2400);
lc640_write_int(0x10+100+162,20);
lc640_write_int(0x10+100+166,1);
lc640_write_int(0x10+100+168,0);
lc640_write_int(0x10+100+172,0);
lc640_write_int(0x10+100+174,0);
lc640_write_int(0x10+100+170,40);
lc640_write_int(0x10+100+182,1310);
lc640_write_int(0x10+100+184,1100);


}



void net_drv(void)
{ 

max_net_slot=24;


if(++cnt_net_drv>max_net_slot) 
	{
	cnt_net_drv=-5;
	} 


if((cnt_net_drv>=0)&&(cnt_net_drv<=max_net_slot)) 


	{
	
	if(mess_find_unvol(33))
		{
		if(mess_data[0]==34)
			{
			
			if(a_ind . s_i1==cnt_net_drv)
				{
				return;
				}
			}
		}
	
	
	
	
	if(!bCAN_OFF)
		{







     	}
	if(cnt_net_drv<=max_net_slot)
	     {



 
 
 
 


						


	     }
	}

else if(cnt_net_drv==-1)
	{
     
     } 
     
else if(cnt_net_drv==-2)
	{
	
     
     
	} 
else if(cnt_net_drv==-3)
	{                 
	
	ibat_metr_cnt++;
	}
	
	

	
     
     


}




void parol_init(void)
{
parol[0]=0;
parol[1]=0;
parol[2]=0;
a_ind . s_i=0;
}


void bitmap_hndl(void)
{
short x,ii,i;
unsigned int ptr_bitmap;


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


void ind_hndl(void)
{			  

const char* ptrs[60];
 






	   













 	













 







































































 






 if(a_ind . i==iMn)
	{
	ptrs[0]	=			" 0%:0^:0& 0</>  /0{ ";
	ptrs[1]=			"                    ";	
	ptrs[2]=			" œÓÎÌ‡ˇ ÔÓ‚ÂÍ‡    ";
	ptrs[3]=			"  ÓÌÚÓÎ¸ ËÌÚÂÙÂÈÒ‡";
    ptrs[4]=			"  ÓÌÚÓÎ¸ ÓÔÚÓÌÓ‚  ";
	ptrs[5]=			" ”ÒÚ‡ÌÓ‚Í‡ ‚ÂÏÂÌË  ";
	ptrs[6]=			" ƒ‡Ú˜ËÍ ‚ÓÁ‰Ûı‡     ";
	ptrs[7]=			" ƒ‡Ú˜ËÍ ‚Ó‰˚        ";	
	ptrs[8]=			" œÓ·Ì‡ˇ ÒÏÒ        ";
	ptrs[8]=			" “ÂÒÚ ‚˚ÍÎ˛˜ÂÌËˇ    ";
	ptrs[9]=			" «‡‚Ó‰ÒÍËÂ ÛÒÚ‡ÌÓ‚ÍË";						
	
	

	if(a_ind . s_i-a_ind . i_s>1)a_ind . i_s=a_ind . s_i-1;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	
	bgnd_par(ptrs[0],ptrs[1],ptrs[a_ind . i_s+2],ptrs[a_ind . i_s+3]);
 	
	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR,'%',0);
	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN,'^',0);
	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->SEC,'&',0);
	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM,'<',0);
	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR,'{',0); 
	sub_bgnd(sm_mont[((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH],'>',0);

 	if(bFL2)
 	     {
 	     lcd_buffer[find(':')]=' ';
 	     lcd_buffer[find(':')]=' ';
 	     lcd_buffer[find(':')]=' ';
 	     }

	pointer_set(2);	
	
	
	








 		
	}

else if(a_ind . i==iInterf_kontr)
	{
	bgnd_par(	" œ–Œ¬≈– ¿ »Õƒ» ¿÷»» ",
				"       ÕŒœŒ         ",
				"      ¡»œœ≈–¿       ",
				" ¬˚ıÓ‰              "); 
	pointer_set(3);
	} 


else if(a_ind . i==iOptr_kontr)
	{
	const char* ptr[12];
 
	simax=10;

	ptr[0]=			" ŒÔÚ3     !    @#$ ";
	ptr[1]=			" ŒÔÚ2     %    ^&* ";
	ptr[2]=			" ŒÔÚ1     (    )-= ";
	ptr[3]=			sm_exit;


		{
		bgnd_par(		"  ŒÕ“–ŒÀ‹ Œœ“–ŒÕŒ¬  ",
					ptr[a_ind . i_s],
					ptr[a_ind . i_s+1],
					ptr[a_ind . i_s+2]);

		if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
		else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;

		pointer_set(1);
		
		}
	
	if(optr_stat[2]==osON)	sub_bgnd("¬ À.",'!',-3);
	else 					sub_bgnd("¬€ À.",'!',-4);
	if(optr_stat[1]==osON)	sub_bgnd("¬ À.",'%',-3);
	else 					sub_bgnd("¬€ À.",'%',-4);
	if(optr_stat[0]==osON)	sub_bgnd("¬ À.",'(',-3);
	else 					sub_bgnd("¬€ À.",'(',-4);

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

 
else if(a_ind . i==iWater_sensor_kontr)
	{
	bgnd_par(	" Õ¿ À≈¬ŒÃ »Õƒ» ¿“Œ–≈",
				"    “≈Ãœ≈–¿“”–¿     ",
				"    ƒ¿“◊» ¿ ¬Œƒ€    ",
				" ¬˚ıÓ‰              "); 
	pointer_set(3);
	} 	   
	 	  

else if(a_ind . i==iAir_sensor_kontr)
	{
	bgnd_par(	" Õ¿ À≈¬ŒÃ »Õƒ» ¿“Œ–≈",
				"    “≈Ãœ≈–¿“”–¿     ",
				"  ƒ¿“◊» ¿ ¬Œ«ƒ”’¿   ",
				" ¬˚ıÓ‰              "); 
	pointer_set(3);
	} 	 

else if(a_ind . i==iVent)
	{

	ptrs[0]=  		" F‚ÂÌÚ.ÚÂÍÛ˘.     !%";
     ptrs[1]=  		" F‚ÂÌÚ.max. (  @%) #";
	ptrs[2]=  	     " ¬˚ıÓ‰              ";

	bgnd_par(			"     ¬≈Õ“»Àﬂ“Œ–     ",
					ptrs[a_ind . i_s],
					ptrs[a_ind . i_s+1],
					ptrs[a_ind . i_s+2]);

	pointer_set(1);

     int2lcd(main_vent_pos*5,'!',0);
	int2lcd(pos_vent,'#',0);
	int2lcd(pos_vent*5+45,'@',0);     
	}

else if(a_ind . i==iAvt)
	{
     ptrs[0]=  		"  ¿¬“ŒÃ¿“€ Õ¿√–”«Œ  ";
	ptrs[1]=  		" ¿‚ÚÓÏ‡Ú π1       ! ";
	ptrs[2]=  		" ¿‚ÚÓÏ‡Ú π2       @ ";
	ptrs[3]=  		" ¿‚ÚÓÏ‡Ú π3       # ";
	ptrs[4]=  		" ¿‚ÚÓÏ‡Ú π4       $ ";
	ptrs[5]=  		" ¿‚ÚÓÏ‡Ú π5       % ";
	ptrs[6]=  		" ¿‚ÚÓÏ‡Ú π6       ^ ";
	ptrs[7]=  		" ¿‚ÚÓÏ‡Ú π7       & ";
	ptrs[8]=  		" ¿‚ÚÓÏ‡Ú π8       * ";
	ptrs[9]=  		" ¿‚ÚÓÏ‡Ú π9       ( ";
	ptrs[10]=  		" ¿‚ÚÓÏ‡Ú π10      ) ";
	ptrs[11]=  		" ¿‚ÚÓÏ‡Ú π11      + ";
	ptrs[12]=  		" ¿‚ÚÓÏ‡Ú π12      = ";

	ptrs[1+NUMAVT]=  	" ¬˚ıÓ‰              ";
	ptrs[2+NUMAVT]=  	"                    ";
	ptrs[3+NUMAVT]=  	"                    ";

	bgnd_par(		ptrs[0],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2],
				ptrs[a_ind . i_s+3]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

	
























 
     
     

     
     

     
     
     
     }


else if(a_ind . i==iBatLogVz)
	{
	if(av_j_si_max==0)
		{
		bgnd_par(	"¬€–¿¬Õ»¬¿ﬁŸ»≈ «¿–ﬂƒ€",
				"     ¡¿“¿–≈» N!     ",
				" ∆ÛÌ‡Î ÔÛÒÚ        ",
				sm_exit);
		a_ind . s_i=0;
		a_ind . i_s=0;
		pointer_set(3);
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"¬€–¿¬Õ»¬¿ﬁŸ»≈ «¿–ﬂƒ€",
				"     ¡¿“¿–≈» N!     ",
				" (                  ",
				sm_exit);
		a_ind . i_s=0;
		pointer_set(2);
		}	
	else
		{
		if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
		else if((a_ind . s_i-a_ind . i_s)>1) a_ind . i_s=a_ind . s_i-1;
		if(a_ind . i_s==(av_j_si_max-1)) 
			{
			bgnd_par(	"¬€–¿¬Õ»¬¿ﬁŸ»≈ «¿–ﬂƒ€",
					"     ¡¿“¿–≈» N!     ",
					" (                  ",
					sm_exit);
			}

		else bgnd_par(	"¬€–¿¬Õ»¬¿ﬁŸ»≈ «¿–ﬂƒ€",
					"     ¡¿“¿–≈» N!     ",
					" (                  ",
					" [                  "); 
		pointer_set(2);			        
		}
   	int2lcd(a_ind . s_i1+1,'!',0);
 	event_data2ind(content[a_ind . i_s],'(');
 	event_data2ind(content[a_ind . i_s+1],'[');
	
	}
   
else if(a_ind . i==iBatLogWrk)
	{
	if(av_j_si_max==0)
		{
		bgnd_par(	"      –¿«–ﬂƒ€       ",
				"     ¡¿“¿–≈» N!     ",
				" ∆ÛÌ‡Î ÔÛÒÚ        ",
				sm_exit);
		a_ind . s_i=0;
		a_ind . i_s=0;
		pointer_set(3);
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"      –¿«–ﬂƒ€       ",
				"     ¡¿“¿–≈» N!     ",
				" (                  ",
				sm_exit);
		a_ind . i_s=0;
		pointer_set(2);
		}	

	else
		{
		if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
		else if((a_ind . s_i-a_ind . i_s)>1) a_ind . i_s=a_ind . s_i-1;
		if(a_ind . i_s==(av_j_si_max-1))
			{
			bgnd_par(	"      –¿«–ﬂƒ€       ",
					"     ¡¿“¿–≈» N!     ",
					" (                  ",
					sm_exit);
			}
		else bgnd_par(	"      –¿«–ﬂƒ€       ",
					"     ¡¿“¿–≈» N!     ",
					" (                  ",
					" [                  ");

		pointer_set(2);
		}

   	int2lcd(a_ind . s_i1+1,'!',0);
 	event_data2ind(content[a_ind . i_s],'(');
 	event_data2ind(content[a_ind . i_s+1],'[');

	

	} 
	
else if((a_ind . i==iSet_prl)||(a_ind . i==iK_prl)
	||(a_ind . i==iAusw_prl)||(a_ind . i==iPrltst))
	{
	bgnd_par("  ¬‚Â‰ËÚÂ  Ô‡ÓÎ¸   ",sm_,sm_,sm_);
	int2lcdyx(parol[0],1,8,0);
     int2lcdyx(parol[1],1,9,0);
     int2lcdyx(parol[2],1,10,0);
     lcd_buffer[48+a_ind . s_i]='§';
	}	
		
else if(a_ind . i==iPrl_bat_in_out)
	{
	if(BAT_IS_ON[a_ind . s_i1]==bisON)ptrs[0]="ƒÎˇ ‚˚‚Â‰ÂÌËˇ ·‡Ú.-Ë";
	else  ptrs[0]="ƒÎˇ ‚‚Â‰ÂÌËˇ ·‡Ú‡ÂË";
	bgnd_par(ptrs[0],"  Ì‡·ÂËÚÂ Ô‡ÓÎ¸   ",sm_,sm_);
	
     int2lcdyx(parol[0],2,8,0);
     int2lcdyx(parol[1],2,9,0);
     int2lcdyx(parol[2],2,10,0);
     lcd_buffer[68+a_ind . s_i]='§';	
	}

else if(a_ind . i==iPrl_bat_in_sel)
	{
	
	bgnd_par(	"ƒÎˇ ‚‚Â‰ÂÌËˇ ·‡Ú‡ÂË",
			"   ‚˚·ÂËÚÂ ÂÂ ÚËÔ   ",
			" —‚ËÌˆÓ‚Ó-ÍËÒÎÓÚÌ‡ˇ ",
			" GYFP4875T          ");
	
	pointer_set(2);
	}




else if(a_ind . i==iSet_T)
	{
	static char phase_cnt;
	if(++phase_cnt>=15)
	     {
	     phase_cnt=0;
	     if(++phase>=3)phase=0;
	     }
	ptrs[0]=sm_time;
	ptrs[1]=sm_;
	if(phase==0)ptrs[2]="     <> - ‚˚·Ó     ";
     if(phase==1)ptrs[2]="   ^v - ÛÒÚ‡ÌÓ‚Í‡   ";
     if(phase==2)ptrs[2]="     §  - ‚˚ıÓ‰     ";
	
	bgnd_par(" ”—“¿ÕŒ¬ ¿  ¬–≈Ã≈Õ» ",ptrs[0],ptrs[1],ptrs[2]);
     if(a_ind . s_i==0)lcd_buffer[42]='^';
     else if(a_ind . s_i==1)lcd_buffer[45]='^';
     else if(a_ind . s_i==2)lcd_buffer[48]='^';
     else if(a_ind . s_i==3)lcd_buffer[51]='^';
     else if(a_ind . s_i==4)lcd_buffer[55]='^';
     else if(a_ind . s_i==5)lcd_buffer[59]='^';
  
 	
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN,'^',0);
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR,'%',0);
 	
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM,'<',0);
 	sub_bgnd(sm_mont[((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH],'>',0);
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR,'{',0);
 	if(bFL2)
 	     {
 	     lcd_buffer[find(':')]=' ';
 	     
 	     }
	
	sub_bgnd(sm_dow[((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOW],'&',-1);
	
	
	
		   
	}  

else if((a_ind . i==iSet_T_ret)||(a_ind . i==iAir_sensor_kontr_ret)||(a_ind . i==iWater_sensor_kontr_ret)||(a_ind . i==iInterf_kontr_ret))
	{
	bgnd_par(sm_,sm_,sm_,sm_);	 
		   
	}  

else if(a_ind . i==iK)
	{
	char i;
	i=0;
	
	ptrs[i++]=" —ÂÚ¸               ";
	if(NUMBAT)
     ptrs[i++]=" ¡‡Ú‡ÂË            ";
	if(NUMIST)
	ptrs[i++]=" ¡œ—                ";
	if(NUMINV)
     ptrs[i++]=" »Ì‚ÂÚÓ˚          ";
	ptrs[i++]=" Õ‡„ÛÁÍ‡           ";
     ptrs[i++]=" ¬ÌÂ¯ÌËÂ ‰‡Ú˜ËÍË    ";
     ptrs[i++]=" —ËÎÓ‚˚Â ‚‚Ó‰˚      ";
     ptrs[i++]=" ¬˚ıÓ‰              ";
     ptrs[i++]="                    ";
     ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("      ¿À»¡–Œ¬ ¿     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}    	


else if(a_ind . i==iK_220_IPS_TERMOKOMPENSAT)
	{
	char i;
	i=0;
	
	ptrs[i++]=" —ÂÚ¸               ";
	if(NUMBAT)
     ptrs[i++]=" ¡‡Ú‡ÂË            ";
	if(NUMIST)
	ptrs[i++]=" ¡œ—                ";
	ptrs[i++]=" ¬˚ıÓ‰Ì˚Â Ô‡‡ÏÂÚ˚ ";
     if(NUMDT)
     ptrs[i++]=" ¬ÌÂ¯ÌËÂ ‰‡Ú˜ËÍË    ";
     ptrs[i++]=" ¬˚ıÓ‰              ";
     ptrs[i++]="                    ";
     ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("      ¿À»¡–Œ¬ ¿     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}   

else if(a_ind . i==iK_VD)
	{
	char i;
	i=0;
	
	ptrs[i++]=" U‚˚ı.         !¬   ";
	ptrs[i++]=" I‚˚ı.         @¿   ";
	if(NUMIST)
	ptrs[i++]=" ¡œ—                ";
	ptrs[i++]=" U‚.‰.         #¬   ";
    ptrs[i++]=" TÒËÒÚÂÏ˚  =   ^∞C  ";;
    ptrs[i++]=" ¬˚ıÓ‰              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("      ¿À»¡–Œ¬ ¿     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);

	int2lcd(out_U,'!',1);
	int2lcd(out_I,'@',0);
	int2lcd(vd_U,'#',1);
	int2lcd(sys_T,'^',0);
	
	
    
	
	if((a_ind . s_i==0)||(a_ind . s_i==3))mess_send(225,229,1000,10);
	
	
	
	}   


else if(a_ind . i==iK_220_IPS_TERMOKOMPENSAT_IB)
	{
	char i;
	i=0;
	
	ptrs[i++]=" —ÂÚ¸               ";
    ptrs[i++]=" ¡‡Ú‡Âˇ            ";
	if(NUMIST)
	ptrs[i++]=" ¡œ—                ";
	ptrs[i++]=" ¬˚ıÓ‰Ì˚Â Ô‡‡ÏÂÚ˚ ";
    if(NUMDT)
    ptrs[i++]=" ¬ÌÂ¯ÌËÂ ‰‡Ú˜ËÍË    ";
    ptrs[i++]=" ¬˚ıÓ‰              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("      ¿À»¡–Œ¬ ¿     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}   


else if(a_ind . i==iK_TELECORE)
	{
	char i;
	i=0;
	
	ptrs[i++]=	" —ÂÚ¸               ";
	if(NUMBAT_TELECORE)
    ptrs[i++]=	" ¡‡Ú‡ÂË            ";
	if(NUMIST)
	ptrs[i++]=	" ¡œ—                ";
	ptrs[i++]=	" Õ‡„ÛÁÍ‡           ";
    if(NUMDT)
    ptrs[i++]=	" ¬ÌÂ¯ÌËÂ ‰‡Ú˜ËÍË    ";
    ptrs[i++]=" ¬˚ıÓ‰              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("      ¿À»¡–Œ¬ ¿     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}    	

else if(a_ind . i==iK_net)
	{
	ptrs[0]=" U =     @¬         ";
     ptrs[1]=" ¬˚ıÓ‰              ";
	ptrs[2]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("    ¿À»¡–Œ¬ ¿ —≈“»  ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

	pointer_set(1);	
	int2lcd(net_U,'@',0);
	
	
	
     }


else if(a_ind . i==iK_net3)
	{

	ptrs[0]=  		" UÙA           !¬   ";
    ptrs[1]=  		" UÙB           @¬   ";
    ptrs[2]=  	    " UÙC           #¬   ";
	ptrs[3]=  	    " ¬˚ıÓ‰              ";


	bgnd_par(		"    ¿À»¡–Œ¬ ¿ —≈“»  ",
					ptrs[a_ind . i_s],
					ptrs[a_ind . i_s+1],
					ptrs[a_ind . i_s+2]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

    int2lcd(net_Ua,'!',0);
	int2lcd(net_Ub,'@',0);
	int2lcd(net_Uc,'#',0);

	


 

    }


else if(a_ind . i==iK_load)
	{
	ptrs[0]=" U =     @¬         ";
     ptrs[1]=" ¬˚ıÓ‰              ";
	ptrs[2]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(		"  ¿À»¡–Œ¬ ¿ Õ¿√–”« »",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2]);

	pointer_set(1);
	if((load_U)>1000)int2lcd(load_U/10,'@',0);	
	else int2lcd(load_U,'@',1);
     }

else if(a_ind . i==iK_t_ext)
	{
	ptrs[0]=  	" t‚ÌÂ¯.‚ÓÁ‰.    !∞— ";
     ptrs[1]=  	" tÓÚÒÂÍ ›œ”     @∞— ";
     ptrs[2]=  	" tÓÚÒÂÍ MSAN    #∞— ";
     ptrs[3]=	     " ¬˚ıÓ‰              ";
	ptrs[4]=	     "                    ";
	ptrs[5]=	     "                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(		"  ¿À»¡–Œ¬ ¿ ¬Õ≈ÿÕ»’ ",
				" ƒ¿“◊» Œ¬ “≈Ãœ≈–¿“”–",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	if(ND_EXT[0])sub_bgnd("ÌÂËÒÔ.",'!',-3);
     else int2lcd_mmm(t_ext[0],'!',0);

	if(ND_EXT[1])sub_bgnd("ÌÂËÒÔ.",'@',-3);
     else int2lcd_mmm(t_ext[1],'@',0);

	if(ND_EXT[2])sub_bgnd("ÌÂËÒÔ.",'#',-3);
     else int2lcd_mmm(t_ext[2],'#',0);
     }

else if(a_ind . i==iK_t_ext_6U)
	{
	ptrs[0]=  		" t1             !∞— ";
    ptrs[1]=  		" t2             @∞— ";
    ptrs[2]=  		" t3             #∞— ";
    ptrs[NUMDT]=	" ¬˚ıÓ‰              ";
	ptrs[NUMDT+1]=  "                    ";
	ptrs[NUMDT+2]=  "                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(		"  ¿À»¡–Œ¬ ¿ ¬Õ≈ÿÕ»’ ",
				" ƒ¿“◊» Œ¬ “≈Ãœ≈–¿“”–",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	if(ND_EXT[0])sub_bgnd("ÌÂËÒÔ.",'!',-3);
     else int2lcd_mmm(t_ext[0],'!',0);

	if(ND_EXT[1])sub_bgnd("ÌÂËÒÔ.",'@',-3);
     else int2lcd_mmm(t_ext[1],'@',0);

	if(ND_EXT[2])sub_bgnd("ÌÂËÒÔ.",'#',-3);
     else int2lcd_mmm(t_ext[2],'#',0);
	
     }
     
else if(a_ind . i==iK_bat_sel)
	{
	ptrs[0]=						" ¡‡Ú‡Âˇ N1         ";
     ptrs[1]=						" ¡‡Ú‡Âˇ N2         ";
     if(BAT_IS_ON[0]!=bisON)ptrs[0]=	" ¡‡Ú‡Âˇ N2         ";
	ptrs[0+NUMBAT]=				" ¬˚ıÓ‰              ";
	ptrs[1+NUMBAT]=				"                    ";
	ptrs[2+NUMBAT]=				"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("  ¿À»¡–Œ¬ ¿ ¡¿“¿–≈… ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
     }     



else if(a_ind . i==iK_power_net3)
	{
     ptrs[0]=  		" ¬‚Ó‰ Ù.A    !¬     ";
	ptrs[1]=  		" ¬‚Ó‰ Ù.B    @¬     ";
	ptrs[2]=  		" ¬‚Ó‰ Ù.C    #¬     ";
     ptrs[3]=  	     " œ›—  Ù.A    &¬     ";
     ptrs[4]=  	     " œ›—  Ù.B    *¬     ";
     ptrs[5]=  	     " œ›—  Ù.C    (¬     ";		            
     ptrs[6]=" ¬˚ıÓ‰              ";
	ptrs[7]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par( "       ¿À»¡–Œ¬ ¿    ",
               "   —»ÀŒ¬€’ ¬¬ŒƒŒ¬   ",
               ptrs[a_ind . i_s],
               ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	int2lcd(Uvv_eb2[0],'!',0);
	int2lcd(Uvv_eb2[1],'@',0);
	int2lcd(Uvv_eb2[2],'#',0);
	int2lcd(Upes_eb2[0],'&',0);
	int2lcd(Upes_eb2[1],'*',0);
	int2lcd(Upes_eb2[2],'(',0);
	
	
	
     }


			
if(a_ind . i==iDeb)
     {
     if(a_ind . s_i==0)
     	{


        bgnd_par("*0000*000000*       ",
     	         "                    ",
     	         "                    ",
     	         "      ********      ");

		int2lcdyx(1051,0,4,0);
		long2lcdyx_mmm(21112UL,0,11,0);
	
		int2lcdyx(numOfForvardBps_minCnt,1,5,0);
		int2lcdyx(numOfForvardBps_hourCnt,1,10,0);
		int2lcdyx(numOfForvardBps,1,15,0);
	
		int2lcdyx(numOfForvardBps_minCnt,2,4,0);
		int2lcdyx(numOfForvardBps_hourCnt,2,9,0);

      

     	}     

    	else if(a_ind . s_i==1) 
     	{
     	bgnd_par("¡                   ",
     	         "                    ",
     	         "                    ",
     	         "                    ");

		
		
		
		

				
		

 







 

		int2lcdyx(a_ind . s_i1+0,1,0,0);
		int2lcdyx(a_ind . s_i1+1,2,0,0);
		int2lcdyx(a_ind . s_i1+2,3,0,0);
		
		


 		
		
	

 			
		
	











 

	



 
		



 		}

 

    else if(a_ind . s_i==2)
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
		
		int2lcdyx(outVoltContrHndlCnt,3,19,0);

		long2lcdhyx(0x12345678UL,1,14);


		}  

	else if(a_ind . s_i==3)
     	{
     	bgnd_par(" ≈                  ",
     	         "                    ",
     	         "                   ^",
     	         "                   &");
























 







 
	
	
		








 


		   
		    

































































 
		}

   else if(a_ind . s_i==4)
     	{
     	bgnd_par(	"LB                  ",
     		    	"                    ",
     		    	"      !   #         ",
     		    	"      @   $         ");


     	int2lcdyx(NUMBAT_TELECORE,0,1,0);

		
		int2lcdyx(plazma_cntrl_stat,0,19,0);
		

		int2lcdyx(load_U,1,19,0);
			


		


		




		
	   	

		int2lcdyx(IMAX,0,13,0);
		




		
		

		
		


		




		
		
		

		
		
 		

		

		

		
		
		 
		
		
		
		
		}





















 
 
    else if(a_ind . s_i==5)
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



	










 

		
    	}  		  		


  else if(a_ind . s_i==6)
     	{
     	bgnd_par(	"6                   ",
     		    	"    !     $         ",
     		    	"    @     %         ",
     		    	"            ^       ");
#line 2558 "main.c"
    	}


   else if(a_ind . s_i==7)
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
    else if(a_ind . s_i==8)
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

    else if(a_ind . s_i==10)
     	{
     	bgnd_par("LB                  ",
     		    "                    ",
     		    "                    ",
     		    "                    ");

     	int2lcdyx(a_ind . s_i1+1,0,3,0);

		
		
		
     	}	

    else if(a_ind . s_i==11)
     	{
     	bgnd_par("LB                  ",
     		    "                    ",
     		    "                    ",
     		    "                    ");

     	int2lcdyx(a_ind . s_i,0,1,0);
		
		int2lcdyx(u_necc,0,5,0);

		int2lcdyx(load_U,0,11,0);

		
		
		

		int2lcdyx(li_bat._canErrorCnt,2,5,0);
		int2lcdyx(li_bat._canError,2,8,0);
		int2lcdyx(li_bat._485ErrorCnt,3,5,0);
		int2lcdyx(li_bat._485Error,3,8,0);
			
		


















 
		
     	}	
    else if(a_ind . s_i==12)
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


     	
     	
 
		
     	}	     			
     }






	
else if(a_ind . i==iAvt_set_sel)
	{
	ptrs[0]=						" ¡œ— N1             ";
     ptrs[1]=						" ¡œ— N2             ";
     ptrs[2]=						" ¡œ— N3             ";
	ptrs[3]=						" ¡œ— N4             ";
     ptrs[4]=						" ¡œ— N5             ";
     ptrs[5]=						" ¡œ— N6             ";
	ptrs[6]=						" ¡œ— N7             ";
     ptrs[7]=						" ¡œ— N8             ";
     ptrs[8]=						" ¡œ— N9             ";
	ptrs[9]=						" ¡œ— N10            ";
     ptrs[10]=						" ¡œ— N11            ";
     ptrs[11]=						" ¡œ— N12            ";               
	ptrs[NUMIST]=					" ¬˚ıÓ‰              ";
	ptrs[1+NUMIST]=				"                    ";
	ptrs[2+NUMIST]=				"                    ";


	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(				"”—“¿ÕŒ¬ ¿ Õ¿œ–ﬂ∆≈Õ»ﬂ",
						" ¿¬“ŒÕŒÃÕŒ… –¿¡Œ“€  ",
						ptrs[a_ind . i_s],
						ptrs[a_ind . i_s+1]);
	pointer_set(2);

	}		 

else if(a_ind . i==iAvt_set)
	{
	ptrs[0]=" U‡‚ÚÓÌ =   $¬      ";
	if(bFL_)
		{
		ptrs[1]=" ÛÒÚ‡ÌÓ‚ËÚÂ U‡‚ÚÓÌ  ";
     	ptrs[2]="  Ì‡Ê‡ÚËÂÏ ö ËÎË ú  ";
     	}
     else 
     	{
		ptrs[1]=" Û‰ÂÊË‚‡ÈÚÂ § ‰Îˇ  ";
     	ptrs[2]="    Á‡ÔÓÏËÌ‡ÌËˇ     ";     	
     	}	

     ptrs[3]=sm_exit;
     ptrs[4]=sm_;
     ptrs[5]=sm_;     	     	    
	

     if((a_ind . s_i==0)||(a_ind . s_i==1)||(a_ind . s_i==2))a_ind . i_s=0;
	else a_ind . i_s=3;
	
	bgnd_par("       ¡œ— N!      ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

	pointer_set(1);	
	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd(U_AVT,'$',1);
	 
	
     if(a_ind . s_i==0)
		{
        mess_send(205,208,(1<<a_ind . s_i1),10);
        mess_send(200,201,0,40);
        mess_send(190,191,U_AVT,10);
	    mess_send(225,230,0,10);

        }

 	if(mess_find( (215)) && (mess_data[0]==217) )
		{
		a_ind . s_i=3;
		show_mess(	"     ”ÒÚ‡ÌÓ‚Í‡      ",
	          		"    Ì‡ÔˇÊÂÌËˇ      ",
	          		" ‡‚ÚÓÌÓÏÌÓÈ ‡·ÓÚ˚  ",
	          		"    ÔÓËÁ‚Â‰ÂÌ‡     ",3000);
		
		}
	
	 }
else if(a_ind . i==iOut_volt_contr)
	{
	ptrs[0]=" U‚˚ımax         !¬ ";
    ptrs[1]=" U‚˚ımin         @¬ ";
    ptrs[2]=" TÁ‰Ê.‡‚.       #Ò.";     	
    ptrs[3]=sm_exit;
    ptrs[4]=sm_;
    ptrs[5]=sm_;     	     	    
	

	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	
	bgnd_par(	" ŒÕ“–ŒÀ‹ ¬€’ŒƒÕŒ√Œ ",
				"    Õ¿œ–ﬂ∆≈Õ»ﬂ     ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	int2lcd(U_OUT_KONTR_MAX,'!',1);
	int2lcd(U_OUT_KONTR_MIN,'@',1);
	int2lcd(U_OUT_KONTR_DELAY,'#',0);
	}
else if(a_ind . i==iDop_rele_set)
	{
	if(DOP_RELE_FUNC==0)
		{
		ptrs[0]=	" »Ì‰ËÍ‡ˆËˇ          ";
		ptrs[1]=	" ÛÒÍÓÂÌÌÓ„Ó Á‡ˇ‰‡ ";
		}
	else  
		{
		ptrs[0]=	" »Ì‰ËÍ‡ˆËˇ          ";
		ptrs[1]=	" ‡ÁˇÊÂÌÌÓÈ ·‡Ú‡ÂË";
		}
	ptrs[2]=		" ¬˚ıÓ‰              ";
	ptrs[3]=		"                    ";


	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(			"ƒŒœŒœÀÕ»“≈À‹ÕŒ≈ –≈À≈",
						"  ‘”Õ ÷»ŒÕ¿À‹ÕŒ—“‹  ",
						ptrs[a_ind . i_s],
						ptrs[a_ind . i_s+1]);
	pointer_set(2);

	
	
	
	}

else if (a_ind . i==iIps_Curr_Avg_Set)
	{ 
	if(ICA_EN==0)
		{
		ptrs[0]=		" ¬˚ÍÎ˛˜ÂÌÓ          ";
		simax=1;
		}
	else 
		{
		ptrs[0]=		" ¬ÍÎ˛˜ÂÌÓ           ";
		if(ICA_CH==0)
			{
			ptrs[1]=	"  ¿Õ¿À  MODBUS-RTU  ";
			ptrs[2]=	" ¿ƒ–≈— ¬≈ƒŒÃŒ√Œ   ! ";
			simax=3;
			}
		else
			{
			ptrs[1]=	"  ¿Õ¿À   MODBUS-TCP ";
			ptrs[2]=	" IP 00@.00#.00$.00% ";
			ptrs[3]=	" ¿ƒ–≈— ¬≈ƒŒÃŒ√Œ   ^ ";
			simax=4;
			}
		} 
	ptrs[simax]=		" ¬˚ıÓ‰              ";
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>1) a_ind . i_s=a_ind . s_i-1;	
	bgnd_par(	" ¬€–¿¬Õ»¬¿Õ»≈ “Œ Œ¬ ",
				"        »œ—         ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);
	
	pointer_set(2);
	int2lcd(ICA_MODBUS_ADDRESS,'!',0);
	if((a_ind . s_i==2)&&(a_ind . s_i1==0)&&bFL2)sub_bgnd("   ",'@',-2);
	else int2lcd(ICA_MODBUS_TCP_IP1,'@',0);
	if((a_ind . s_i==2)&&(a_ind . s_i1==1)&&bFL2)sub_bgnd("   ",'#',-2);
	else int2lcd(ICA_MODBUS_TCP_IP2,'#',0);
	if((a_ind . s_i==2)&&(a_ind . s_i1==2)&&bFL2)sub_bgnd("   ",'$',-2);
	else int2lcd(ICA_MODBUS_TCP_IP3,'$',0);
	if((a_ind . s_i==2)&&(a_ind . s_i1==3)&&bFL2)sub_bgnd("   ",'%',-2);
	else int2lcd(ICA_MODBUS_TCP_IP4,'%',0);
	int2lcd(ICA_MODBUS_TCP_UNIT_ID,'^',0);	
     
 	} 









 
























 



 



}							    


#line 2933 "main.c"




#line 2956 "main.c"




void but_drv(void)
{
char i;
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIODIR|=(1<<21);
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIOPIN&=~(1<<21);
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIODIR&=~((1<<22)|(1<<23)|(1<<24)|(1<<25)|(1<<26));
((LPC_PINCON_TypeDef *) ((0x40000000UL) + 0x2C000) )->PINMODE3&=~((1<<12)|(1<<13)|(1<<14)|(1<<15)|(1<<16)|(1<<17)|(1<<18)|(1<<19)|(1<<20)|(1<<21));

((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIODIR|=(1<<8);
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIOPIN&=~(1<<8);
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

			((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIODIR|=(1<<8);
			((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIOPIN|=(1<<8);

but_n=((((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIOPIN|(~((1<<22)|(1<<23)|(1<<24)|(1<<25)|(1<<26))))>>22) ;



if((but_n==1023UL)||(but_n!=but_s))
 	{
	speed=0;
 
   	if (((but0_cnt>=4)||(but1_cnt!=0))&&(!l_but))
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
   	but_onL_temp=20;
    	but0_cnt=0;
  	but1_cnt=0;          
     goto but_drv_out;
  	}
else if(but_n==but_s)
 	{
  	but0_cnt++;
  	if(but0_cnt>=4)
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


void but_an(void)
{
signed short temp_SS;


if(!n_but)return;




 
av_beep=0x0000;
av_rele=0x0000;
mnemo_cnt=MNEMO_TIME;
ips_bat_av_stat=0;


if((main_1Hz_cnt<10)&&((but==253)||(but==125)||(but==251)||(but==123)||(but==247)||(but==119)||(but==239)||(but==111)||(but==254)||(but==126)))
	{
	__ee_spc_stat=spcOFF;
	spc_stat=spcOFF;
	}
if(but==249)
     {
     if(a_ind . i!=iDeb)
          {
		c_ind=a_ind;
		tree_up(iDeb,5,0,0);
		
          }
     else 
          {
		tree_down(0,0);
          }
		
		     
     }
else if(but==231)
	{
	bSILENT=1;
	beep_init(0x00000000,'S');
	}
else if(but==121)
     {
	
	}

else if(but==122)
     {
	if(!bCAN_OFF)bCAN_OFF=1;
	else bCAN_OFF=0;
	speed=0;
	}

else if(a_ind . i==iDeb)
	{
	if(but==239)
		{
		a_ind . s_i++;
		a_ind . i_s=0;
		gran_ring_char(&a_ind . s_i,0,12);
		}
	else if(but==247)
		{
		a_ind . s_i--;
		a_ind . i_s=0;
		gran_ring_char(&a_ind . s_i,0,12);
		}
		
	else if(a_ind . s_i==1)
		{
		if(but==253)
	     	{
	     	a_ind . s_i1--;
	     	gran_char(&a_ind . s_i1,0,30);
	     	}
		if(but==251)
	     	{
	     	a_ind . s_i1++;
	     	gran_char(&a_ind . s_i1,0,30);
	     	}
	     
		if(but==254)
	     	{
	     	

 

			 




			 }

		if(but==254)
	     	{
			
			ind_pointer=0;
			a_ind . i=(i_enum)0;
			a_ind . s_i=0;
			a_ind . s_i1=0;
			a_ind . s_i2=0;
			a_ind . i_s=0;
			}
	     
			
		} 

	 else if(a_ind . s_i==5)
	 	{
		if(but==126)	numOfForvardBps_init();
		}
				
	 else if(a_ind . s_i==5)
	 	{
		if(but==126)
		{
		
		
		((LPC_CAN_TypeDef *) ((0x40000000UL) + 0x44000) )->MOD&=~(1<<0);
		}
		}

	else if(a_ind . s_i==1)
		{
		if(but==253)
	     	{
	     	a_ind . s_i1--;
	     	gran_char(&a_ind . s_i1,0,1);
	     	}
		if(but==251)
	     	{
	     	a_ind . s_i1++;
	     	gran_char(&a_ind . s_i1,0,1);
	     	}
		}		
		
		
			
     else if(but==253)
	     {
	     a_ind . i_s--;
	     gran_char(&a_ind . i_s,0,4);
	     
	     }	
     else if(but==251)
	     {
	     a_ind . i_s++;
	     gran_char(&a_ind . i_s,0,4); 
	     
	     }	
     else if(but==254)
         	{
          
          
          }   
          
     else if(but==126)
         	{
          

          }                      				
	}

else if(a_ind . i==iMn)
	{
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,9);
		}
		
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,9);
		}	

	else if(but==239)
		{
		
		a_ind . s_i=0;

		}
	else if(but==247)
		{
		
		a_ind . s_i=0;

		}
	else if(but==123)
		{
		a_ind . s_i=0;
		}

	else if(but==103)
		{
		if(klbr_en)klbr_en=0;
		else klbr_en=1;
		}
				
	else if(but==254)
		{
		if(a_ind . s_i==0) 
			{
			}
		else if(a_ind . s_i==1)
			{
			tree_up(iInterf_kontr,0,0,0);
			}
		else if(a_ind . s_i==2)
			{
			tree_up(iOptr_kontr,0,0,0);
			}
		else if(a_ind . s_i==3)
			{
			tree_up(iSet_T,0,0,0);
			}
		else if(a_ind . s_i==4)
			{
			tree_up(iAir_sensor_kontr,0,0,0);
			}
		else if(a_ind . s_i==5)
			{
			tree_up(iWater_sensor_kontr,0,0,0);
			}
		else if(a_ind . s_i==7)
			{
			tree_up(iProbesms,0,0,0);
			}
		else if(a_ind . s_i==7)
			{
			tree_up(iPowerdown,0,0,0);
			}
		else if(a_ind . s_i==8)
			{
			tree_up(iDefset,0,0,0);
			}

 		}

    }

else if(a_ind . i==iInterf_kontr)
	{
	if (but==254)
	    {
		tree_up(iInterf_kontr_ret,0,0,0);
		ret_ind(20,1);
	    }
	}

else if(a_ind . i==iOptr_kontr)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(a_ind . s_i==0)
	     {
	     if(optr_stat[2]==osOFF)optr_stat[2]=osON;
		 else optr_stat[2]=osOFF; 
	     }
	else if(a_ind . s_i==1)
	     {
	     if(optr_stat[1]==osOFF)optr_stat[1]=osON;
		 else optr_stat[1]=osOFF; 
	     }
	else if(a_ind . s_i==2)
	     {
	     if(optr_stat[0]==osOFF)optr_stat[0]=osON;
		 else optr_stat[0]=osOFF; 
	     }
	else if((a_ind . s_i==3)&&(but==254))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	}


else if(a_ind . i==iWater_sensor_kontr)
	{
	if (but==254)
	    {
		tree_up(iWater_sensor_kontr_ret,0,0,0);
		ret_ind(20,1);
	    }
	}

else if(a_ind . i==iAir_sensor_kontr)
	{
	if (but==254)
	    {
		tree_up(iAir_sensor_kontr_ret,0,0,0);
		ret_ind(20,1);
	    }
	}


else if((a_ind . i==iPrl_bat_in_out)||(a_ind . i==iSet_prl)||(a_ind . i==iK_prl)
	||(a_ind . i==iAusw_prl)
	||(a_ind . i==iPrltst))
	{
	ret(50);
	if(but==239)
		{
		a_ind . s_i++;
		gran_ring_char(&a_ind . s_i,0,2);
		}
	else if(but==247)
		{
		a_ind . s_i--;
		gran_ring_char(&a_ind . s_i,0,2);
		}	
	else if(but==253)
		{
		parol[a_ind . s_i]++;
		gran_ring_char(&parol[a_ind . s_i],0,9);
		}	
	else if(but==251)
		{
		parol[a_ind . s_i]--;
		gran_ring_char(&parol[a_ind . s_i],0,9);
		}	
	else if(but==254)
		{
		unsigned short tempU;
		tempU=parol[2]+(parol[1]*10U)+(parol[0]*100U);
		
		if(a_ind . i==iPrl_bat_in_out)
		     {
		     if(BAT_IS_ON[a_ind . s_i1]!=bisON)
		          {
		          if(tempU==722)
		               {
					
					
		               lc640_write_int(ADR_EE_BAT_IS_ON[a_ind . s_i1],bisON);
					lc640_write_int(0x10+100+142,0);
		               lc640_write_int(ADR_EE_BAT_DAY_OF_ON[a_ind . s_i1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM);
		               lc640_write_int(ADR_EE_BAT_MONTH_OF_ON[a_ind . s_i1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH);
		               lc640_write_int(ADR_EE_BAT_YEAR_OF_ON[a_ind . s_i1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR);
		               lc640_write_int(ADR_EE_BAT_C_REAL[a_ind . s_i1],0x5555);
		               lc640_write_int(ADR_EE_BAT_RESURS[a_ind . s_i1],0);
					lc640_write_int(ADR_EE_BAT_ZAR_CNT[a_ind . s_i1],0);
		               
		               lc640_write(996,0);
					lc640_write(1016,0);
					lc640_write(1020,0);
					lc640_write(998,0);
					lc640_write(1018,0);
					lc640_write(1022,0);
					lc640_write(1014,0);
					lc640_write(1012,0);					
		               
                         tree_down(0,0);
                         ret(0); 
		               }
		          else
		               {
		               tree_down(0,0);
	    	               show_mess("                    ",
	          				"       œ‡ÓÎ¸       ",
	          				"     ÌÂ‚ÂÌ˚È!!!    ",
	          				"                    ",1000);
     	               }
		          }      
               else		          
		          {
		          if(tempU==722)
		               {
		               lc640_write_int(ADR_EE_BAT_IS_ON[a_ind . s_i1],bisOFF);
		               lc640_write_int(ADR_EE_BAT_DAY_OF_ON[a_ind . s_i1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM);
		               lc640_write_int(ADR_EE_BAT_MONTH_OF_ON[a_ind . s_i1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH);
		               lc640_write_int(ADR_EE_BAT_YEAR_OF_ON[a_ind . s_i1],((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR);

		               tree_down(0,0);
		               ret(0);
		               
		               }
	               else
		               {
		               tree_down(0,0);
	    	               show_mess("                    ",
	          				"       œ‡ÓÎ¸       ",
	          				"     ÌÂ‚ÂÌ˚È!!!    ",
	          				"                    ",1000);
		               }		               
		          }     
               }
		
		else if(a_ind . i==iSet_prl)
			{
	     	if(tempU==184) 
				{
				tree_down(0,0);


				


				ret(1000);
				}
			else 
				{
		          tree_down(0,0);
	    	          show_mess("                    ",
	          			"       œ‡ÓÎ¸       ",
	          			"     ÌÂ‚ÂÌ˚È!!!    ",
	          			"                    ",1000);
				}
			}
		else	if(a_ind . i==iK_prl)
			{
	     	if(tempU==873) 
				{
				tree_down(0,0);
				tree_up(iK_VD,0,0,0);
				ret(100);				
				}
			else 
				{
		          tree_down(0,0);
	    	          show_mess("                    ",
	          			"       œ‡ÓÎ¸       ",
	          			"     ÌÂ‚ÂÌ˚È!!!    ",
	          			"                    ",1000);
				}
			} 
	
		else	if(a_ind . i==iAusw_prl)
			{
	     	if(tempU==949) 
				{
				tree_down(0,0);
				tree_up(iAusw_set,1,0,0);
				default_temp=10;
				ret(0);
				}
			else 
				{
		          tree_down(0,0);
	    	          show_mess("                    ",
	          			"       œ‡ÓÎ¸       ",
	          			"     ÌÂ‚ÂÌ˚È!!!    ",
	          			"                    ",1000);
				}
			} 	
			
		else	if(a_ind . i==iSet_st_prl)
			{
	     	if(tempU==295) 
				{
	
				a_ind . s_i=1;
				a_ind . i_s=0;
				default_temp=10;
				}
			else 
				{
		          tree_down(0,0);
	    	          show_mess("                    ",
	          			"       œ‡ÓÎ¸       ",
	          			"     ÌÂ‚ÂÌ˚È!!!    ",
	          			"                    ",1000);
				}
			} 
						
		else if(a_ind . i==iPrltst)
			{
			if(tempU==999) 
				{
				tree_down(0,0);

			
				
				tst_state[0]=tstOFF;
				tst_state[1]=tstOFF;
				tst_state[2]=tstOFF;
				tst_state[3]=tstOFF;
				tst_state[4]=tstOFF;
				tst_state[5]=tstOFF;
				tst_state[6]=tstOFF;
				tst_state[7]=tstOFF;
				tst_state[9]=tstOFF;
				tst_state[10]=(enum_tst_state)0;
				ret(10000);				


				}
	  		else 
				{
		          tree_down(0,0);
	    	          show_mess("                    ",
	          			"       œ‡ÓÎ¸       ",
	          			"     ÌÂ‚ÂÌ˚È!!!    ",
	          			"                    ",1000);
				}
			}
		}
	}






else if(a_ind . i==iSet_T)
	{
	signed char temp;
	if(but==239)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,5);
		}
	else if(but==247)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,5);
		}
	else if(but==254)
		{
		tree_up(iSet_T_ret,0,0,0);
		ret_ind(20,1);
		
		}	
	else if(a_ind . s_i==0)
	     {			    
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR;
	     if((but==253)||(but==125))
	          {
	          temp++;
	          gran_ring_char(&temp,0,23);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp--;
	          gran_ring_char(&temp,0,23);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR=temp;
	          }	
	     speed=1;               
	     }
     else if(a_ind . s_i==1)
	     {
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN;
	     if((but==253)||(but==125))
	          {
	          temp++;
	          gran_ring_char(&temp,0,59);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp--;
	          gran_ring_char(&temp,0,59);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN=temp;
	          }	
	     speed=1;               
	     }
 















 

     else if(a_ind . s_i==2)
	     {
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM;
	     if((but==253)||(but==125))
	          {
	          temp++;
	          gran_ring_char(&temp,1,31);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp--;
	          gran_ring_char(&temp,1,31);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM=temp;
	          }	
	     speed=1;               
	     }
     else if(a_ind . s_i==3)
	     {
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH;
	     if((but==253)||(but==125))
	          {
	          temp++;
	          gran_ring_char(&temp,1,12);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp--;
	          gran_ring_char(&temp,1,12);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH=temp;
	          }	
	     speed=1;               
	     }	  
     else if(a_ind . s_i==4)
	     {
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR;
	     if((but==253)||(but==125))
	          {
	          temp++;
	          gran_ring_char(&temp,0,99);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp--;
	          gran_ring_char(&temp,0,99);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR=temp;
	          }	
	     speed=1;               
	     }		 
	else if(a_ind . s_i==5)
	     {
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOW;
	     if((but==253)||(but==125))
	          {
	          temp++;
	          gran_ring_char(&temp,0,6);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOW=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp--;
	          gran_ring_char(&temp,0,6);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOW=temp;
	          }	
	     speed=1;               
	     }	       
	}  

    
else if(a_ind . i==iK)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+2);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+2);
		}
	else if(but==123)
		{
		a_ind . s_i=2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+2;
		}				
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{
			tree_up(iK_net,0,0,0);	
			ret(1000);		
			}
		else if((NUMBAT)&&(a_ind . s_i==1))
			{
			tree_up(iK_bat_sel,0,0,0);	
			ret(1000);
			}
		else if((NUMIST)&&(a_ind . s_i==(1+(NUMBAT!=0))))
			{
			tree_up(iK_bps_sel,0,0,0);	
			ret(1000);
			}





















 
 		else if((NUMINV)&&(a_ind . s_i==(1+(NUMBAT!=0)+(NUMIST!=0))))
			{
			
			ret(1000);
			}
								
			else if((a_ind . s_i==(1+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0))))		  
			{
			tree_up(iK_load,0,0,0);	
			ret(1000);
			}
          
      	else if(a_ind . s_i==(2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)))	    
			{
			tree_up(iK_t_ext,0,0,0);	
			ret(1000);			
			}
 		else if(a_ind . s_i==(2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+1))		 
			{
			tree_up(iK_power_net3,0,0,0);	
			ret(1000);
               }               				
 	   	else if(a_ind . s_i==(2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+2))	    
			{
	          tree_down(0,0);
	          ret(0);
               }	               			
		}					
	}

else if(a_ind . i==iK_VD)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4+(NUMIST!=0));
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4+(NUMIST!=0));
		}
	else if(but==123)
		{
		a_ind . s_i=4+(NUMIST!=0);
		}
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+52);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	    gran(&temp_SS,50,2000);

		lc640_write_int(0x10+52,temp_SS);					
		speed=1;	
					
		}

	else if(a_ind . s_i==1)
		{
		temp_SS=lc640_read_int(ADR_KI1BAT[0]);
		if(but==239)temp_SS++;
		else if(but==111)temp_SS+=2;
		else if(but==247)temp_SS--;
		else if(but==119)temp_SS-=2;
						
		gran(&temp_SS,200,30000);
		lc640_write_int(ADR_KI1BAT[0],temp_SS);
		phase=1;
		speed=1;
		}

	else if((NUMIST)&&(a_ind . s_i==2))
		{
		tree_up(iK_bps_sel,0,0,0);	
		ret(1000);
		}
	else if(a_ind . s_i==(2+(NUMIST!=0)))
		{
		temp_SS=lc640_read_int(0x10+54);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	    gran(&temp_SS,30,2000);

		lc640_write_int(0x10+54,temp_SS);					
		speed=1;	
					
		}
	else if(a_ind . s_i==(3+(NUMIST!=0)))
		{
		temp_SS=lc640_read_int(0x10+100+50);
	    if(but==239)
	    	{
		    temp_SS++;
	     	}
	    else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	    else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	    else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	    gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+50,temp_SS);					
		speed=1;	
		}			
   	else if(a_ind . s_i==(4+(NUMIST!=0)))	  
		{
	    tree_down(0,0);
	    ret(0);
        }
	}


else if(a_ind . i==iK_t_ext)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+100+50);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	     gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+50,temp_SS);					
		speed=1;	
					
		}

	else if(a_ind . s_i==1)
		{
		temp_SS=lc640_read_int(0x10+100+52);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	     gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+52,temp_SS);					
		speed=1;	
					
		}
	else if(a_ind . s_i==2)
		{
		temp_SS=lc640_read_int(0x10+100+54);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	     gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+54,temp_SS);					
		speed=1;	
					
		}
	else if(a_ind . s_i==3)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}

else if(a_ind . i==iK_t_ext_6U)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMDT);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMDT);
		}
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+100+50);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	     gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+50,temp_SS);					
		speed=1;	
					
		}

	else if(a_ind . s_i==1)
		{
		temp_SS=lc640_read_int(0x10+100+52);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	     gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+52,temp_SS);					
		speed=1;	
					
		}
	else if(a_ind . s_i==2)
		{
		temp_SS=lc640_read_int(0x10+100+54);
	     if(but==239)
	     	{
		     temp_SS++;
	     	}
	     else if(but==111)
	     	{
	     	temp_SS+=2;
	     	}	
	     else if(but==247)
	     	{
	     	temp_SS--;
	     	}
	     else if(but==119)
	     	{
	     	temp_SS-=2;
	     	}
	     gran(&temp_SS,1900,3000);
		lc640_write_int(0x10+100+54,temp_SS);					
		speed=1;	
					
		}
 	if(a_ind . s_i==NUMDT)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}
			

else if(a_ind . i==iBatLogVz)
	{
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,av_j_si_max);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,av_j_si_max);
		}
	else if(but==254)
		{
		if(a_ind . s_i==av_j_si_max)
			{
			tree_down(0,0);
			}
		} 
	else if(but==247)
		{
		tree_down(0,0);
		}		
    
	
		
	}

else if(a_ind . i==iBatLogKe)
	{
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,av_j_si_max);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,av_j_si_max);
		}
	else if(but==254)
		{
		if(a_ind . s_i==av_j_si_max)
			{
			tree_down(0,0);
			}
		} 
	else if(but==247)
		{
		tree_down(0,0);
		}		
    
	}

else if(a_ind . i==iBatLogWrk)
	{
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,av_j_si_max);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,av_j_si_max);
		}
	else if(but==254)
		{
		if(a_ind . s_i==av_j_si_max)
			{
			tree_down(0,0);
			}
		else if(a_ind . s_i<=av_j_si_max)
			{
			
			
			a_ind . i_s=0;
			
			}	
		} 
	else if(but==247)
		{
		tree_down(0,0);
		}		
	else if(but==239)
		{
	    

		} 
	
	}

else if(a_ind . i==iAv_view)
	{

 	}





else if(a_ind . i==iTst_bps)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3);
		tst_state[5]=tst1;
		tst_state[6]=tstOFF;
		
		if(a_ind . s_i==2)
			{
			a_ind . s_i=3;
			
			}

		}

	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3);
		tst_state[5]=tst1;
		tst_state[6]=tstOFF;
		
		if(a_ind . s_i==2)
			{
			a_ind . s_i=1;
			
			}
		}

	else if(a_ind . s_i==0)
		{
		if(but==239)
			{
			if(tst_state[5]==tstOFF)tst_state[5]=tst1;
			
			else tst_state[5]=tstOFF;
			}
		else if(but==247)
			{
			if(tst_state[5]==tstOFF)tst_state[5]=tst1;
			
			else tst_state[5]=tstOFF;
			}
		}
	else if(a_ind . s_i==1)
		{
		if((but==254)||(but==239))
			{
			if(tst_state[6]==tstOFF) tst_state[6]=tst1;
			
			else tst_state[6]=tstOFF;
			}
		else if(but==247)
			{
			if(tst_state[6]==tstOFF) tst_state[6]=tst1;
			
			else tst_state[6]=tstOFF;
			}
		}		
		
	else if(a_ind . s_i==3)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}	
	}

else if(a_ind . i==iKlimat)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,7);
	
		}

	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,7);
		
		}
	else if(a_ind . s_i==0)
	     {
	     if(but==239)TBOXMAX++;
	     else if(but==111)TBOXMAX+=2;
	     else if(but==247)TBOXMAX--;
	     else if(but==119)TBOXMAX-=2;
	     gran(&TBOXMAX,50,80);
	     lc640_write_int(0x10+100+92,TBOXMAX);
	     speed=1;
	     }

	else if(a_ind . s_i==1)
	     {
	     if(but==239)TBOXVENTMAX++;
	     else if(but==111)TBOXVENTMAX+=2;
	     else if(but==247)TBOXVENTMAX--;
	     else if(but==119)TBOXVENTMAX-=2;
	     gran(&TBOXVENTMAX,49,81);
	     lc640_write_int(0x10+100+96,TBOXVENTMAX);
	     speed=1;
	     }

	else if(a_ind . s_i==2)
	     {
	     if(but==239)TBOXREG++;
	     else if(but==111)TBOXREG+=2;
	     else if(but==247)TBOXREG--;
	     else if(but==119)TBOXREG-=2;
	     gran(&TBOXREG,5,30);
	     lc640_write_int(0x10+100+94,TBOXREG);
	     speed=1;
	     }

	else if(a_ind . s_i==3)
	     {
	     if(but==239)TLOADDISABLE++;
	     else if(but==111)TLOADDISABLE+=2;
	     else if(but==247)TLOADDISABLE--;
	     else if(but==119)TLOADDISABLE-=2;
	     gran(&TLOADDISABLE,49,81);
	     lc640_write_int(0x10+100+98,TLOADDISABLE);
	     speed=1;
	     }

	else if(a_ind . s_i==4)
	     {
	     if(but==239)TLOADENABLE++;
	     else if(but==111)TLOADENABLE+=2;
	     else if(but==247)TLOADENABLE--;
	     else if(but==119)TLOADENABLE-=2;
	     gran(&TLOADENABLE,44,TLOADDISABLE-5);
	     lc640_write_int(0x10+100+100,TLOADENABLE);
	     speed=1;
	     }

	else if(a_ind . s_i==5)
	     {
	     if(but==239)TBATDISABLE++;
	     else if(but==111)TBATDISABLE+=2;
	     else if(but==247)TBATDISABLE--;
	     else if(but==119)TBATDISABLE-=2;
	     gran(&TBATDISABLE,49,91);
	     lc640_write_int(0x10+100+102,TBATDISABLE);
	     speed=1;
	     }

	else if(a_ind . s_i==6)
	     {
	     if(but==239)TBATENABLE++;
	     else if(but==111)TBATENABLE+=2;
	     else if(but==247)TBATENABLE--;
	     else if(but==119)TBATENABLE-=2;
	     gran(&TBATENABLE,44,TBATDISABLE-5);
	     lc640_write_int(0x10+100+104,TBATENABLE);
	     speed=1;
	     }
	else if(a_ind . s_i==7)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	}

else if(a_ind . i==iKlimat_kontur)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,9);
	
		}

	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,9);
		
		}
	else if(a_ind . s_i==0)
	     {
	     if(but==239)TBOXMAX++;
	     else if(but==111)TBOXMAX+=2;
	     else if(but==247)TBOXMAX--;
	     else if(but==119)TBOXMAX-=2;
	     gran(&TBOXMAX,50,80);
	     lc640_write_int(0x10+100+92,TBOXMAX);
	     speed=1;
	     }





















 
	else if(a_ind . s_i==1)
	     {
	     if(but==239)TBOXVENTMAX++;
	     else if(but==111)TBOXVENTMAX+=2;
	     else if(but==247)TBOXVENTMAX--;
	     else if(but==119)TBOXVENTMAX-=2;
	     gran(&TBOXVENTMAX,49,81);
	     lc640_write_int(0x10+100+96,TBOXVENTMAX);
	     speed=1;
	     }

	else if(a_ind . s_i==2)
	     {
	     if(but==239)TBOXREG++;
	     else if(but==111)TBOXREG+=2;
	     else if(but==247)TBOXREG--;
	     else if(but==119)TBOXREG-=2;
	     
		gran(&TBOXREG,0,50);
	     lc640_write_int(0x10+100+94,TBOXREG);
	     speed=1;
	     }


	else if(a_ind . s_i==3)
	     {
	     if(but==239)TBOXWARMON++;
	     else if(but==111)TBOXWARMON+=2;
	     else if(but==247)TBOXWARMON--;
	     else if(but==119)TBOXWARMON-=2;
	     
		gran(&TBOXWARMON,-50,50);
	     lc640_write_int(0x10+100+132,TBOXWARMON);
	     speed=1;
	     }

	else if(a_ind . s_i==4)
	     {
	     if(but==239)TBOXWARMOFF++;
	     else if(but==111)TBOXWARMOFF+=2;
	     else if(but==247)TBOXWARMOFF--;
	     else if(but==119)TBOXWARMOFF-=2;
	     
		gran(&TBOXWARMOFF,-50,50);
	     lc640_write_int(0x10+100+134,TBOXWARMOFF);
	     speed=1;
	     }

	else if(a_ind . s_i==5)
	     {
	     if(but==239)TLOADDISABLE++;
	     else if(but==111)TLOADDISABLE+=2;
	     else if(but==247)TLOADDISABLE--;
	     else if(but==119)TLOADDISABLE-=2;
	     gran(&TLOADDISABLE,49,81);
	     lc640_write_int(0x10+100+98,TLOADDISABLE);
	     speed=1;
	     }

	else if(a_ind . s_i==6)
	     {
	     if(but==239)TLOADENABLE++;
	     else if(but==111)TLOADENABLE+=2;
	     else if(but==247)TLOADENABLE--;
	     else if(but==119)TLOADENABLE-=2;
	     gran(&TLOADENABLE,44,TLOADDISABLE-5);
	     lc640_write_int(0x10+100+100,TLOADENABLE);
	     speed=1;
	     }

	else if(a_ind . s_i==7)
	     {
	     if(but==239)TBATDISABLE++;
	     else if(but==111)TBATDISABLE+=2;
	     else if(but==247)TBATDISABLE--;
	     else if(but==119)TBATDISABLE-=2;
	     gran(&TBATDISABLE,49,91);
	     lc640_write_int(0x10+100+102,TBATDISABLE);
	     speed=1;
	     }

	else if(a_ind . s_i==8)
	     {
	     if(but==239)TBATENABLE++;
	     else if(but==111)TBATENABLE+=2;
	     else if(but==247)TBATENABLE--;
	     else if(but==119)TBATENABLE-=2;
	     gran(&TBATENABLE,44,TBATDISABLE-5);
	     lc640_write_int(0x10+100+104,TBATENABLE);
	     speed=1;
	     }
	else if(a_ind . s_i==9)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	}
#line 4899 "main.c"
else if(a_ind . i==iNpn_set)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,simax);
	
		}

	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,simax);
		
		}
	else if(a_ind . s_i==0)
	    {
	    if(NPN_OUT==npnoRELEVENT)NPN_OUT=npnoRELEAVBAT2;
		else if(NPN_OUT==npnoRELEAVBAT2)NPN_OUT=npnoOFF;
		else NPN_OUT=npnoRELEVENT;
	    lc640_write_int(0x10+100+116,NPN_OUT);
	    
	    }
	else if(a_ind . s_i==1)
	    {
		if(NPN_OUT==npnoOFF)
			{
			if(but==254)			
				{
				tree_down(0,0);
				ret(0);
				}
			}
		else
			{
			

 

			if(but==239)UONPN++;
	     	else if(but==111)UONPN+=2;
	     	else if(but==247)UONPN--;
	     	else if(but==119)UONPN-=2;
	     	gran(&UONPN,100,2500);
	     	lc640_write_int(0x10+100+120,UONPN);
	     	speed=1;

			}
		}
	else if(a_ind . s_i==2)
		{



















 

			if(but==239)UVNPN++;
	     	else if(but==111)UVNPN+=2;
	     	else if(but==247)UVNPN--;
	     	else if(but==119)UVNPN-=2;
	     	gran(&UVNPN,100,2500);
	     	lc640_write_int(0x10+100+122,UVNPN);
	     	speed=1;
		}
	else if(a_ind . s_i==3)
		{

















 
			if(but==239)TZNPN++;
	     	else if(but==111)TZNPN+=2;
	     	else if(but==247)TZNPN--;
	     	else if(but==119)TZNPN-=2;
	     	gran(&TZNPN,10,60);
	     	lc640_write_int(0x10+100+124,TZNPN);
	     	speed=1;
		}
	else if(a_ind . s_i==4)
		{









 
			if(but==254)			
				{
				tree_down(0,0);
				ret(0);
				}
		}
	else if(a_ind . s_i==5)
		{
		if(NPN_SIGN==npnsULOAD)
			{
			if(but==254)			
				{
				tree_down(0,0);
				ret(0);
				}
			}
		}


	}
else if(a_ind . i==iBps_list)
	{

	if (but==253)
		{      
		a_ind . s_i1--;
		gran_char(&a_ind . s_i1,0,NUMIST-2);
		}
		
	else if (but==251)
		{
		a_ind . s_i1++;
		gran_char(&a_ind . s_i1,0,NUMIST-2);
		}

	else if (but==123)
		{
		a_ind . s_i1=NUMIST-2;
		}
				
	else if(but==239)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3);
		}
				
	else if(but==247)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(but==254)
		{
		tree_down(0,0);
		}
		
	else if(but==126)
		{
		if(bAVG_BLOCK) bAVG_BLOCK=0;
		else bAVG_BLOCK=1;
		}						
	}
else if(a_ind . i==iAvt_set_sel)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMIST);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMIST);
		}
	else if((a_ind . s_i>=0)&&(a_ind . s_i<NUMIST))
		{
		if(but==254)
			{
			tree_up(iAvt_set,0,0,a_ind . s_i);
			}
		}
	else if(a_ind . s_i==NUMIST)
		{
		if(but==254)
			{
			tree_down(0,0);
			}	
		}
	}

else if(a_ind . i==iOut_volt_contr)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}
	else if(a_ind . s_i==3)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	else if(a_ind . s_i==0)
		{
		if(but==239)U_OUT_KONTR_MAX++;
		else if(but==111)U_OUT_KONTR_MAX=(U_OUT_KONTR_MAX/5+1)*5;
		else if(but==247)U_OUT_KONTR_MAX--;
		else if(but==119)U_OUT_KONTR_MAX=(U_OUT_KONTR_MAX/5-1)*5;
		gran(&U_OUT_KONTR_MAX,10,3000);
		lc640_write_int(0x10+100+182,U_OUT_KONTR_MAX);
		speed=1;
		}				

	else if(a_ind . s_i==1)
		{
		if(but==239)U_OUT_KONTR_MIN++;
		else if(but==111)U_OUT_KONTR_MIN=(U_OUT_KONTR_MIN/5+1)*5;
		else if(but==247)U_OUT_KONTR_MIN--;
		else if(but==119)U_OUT_KONTR_MIN=(U_OUT_KONTR_MIN/5-1)*5;
		gran(&U_OUT_KONTR_MIN,10,3000);
		lc640_write_int(0x10+100+184,U_OUT_KONTR_MIN);
		speed=1;
		}				


	else if(a_ind . s_i==2)
		{
		if(but==239)U_OUT_KONTR_DELAY++;
	    else if(but==111)U_OUT_KONTR_DELAY+=2;
	    else if(but==247)U_OUT_KONTR_DELAY--;
	    else if(but==119)U_OUT_KONTR_DELAY-=2;
	    gran(&U_OUT_KONTR_DELAY,5,100);
	    lc640_write_int(0x10+100+186,U_OUT_KONTR_DELAY);
	    speed=1;
		}				






 

	}

else if(a_ind . i==iDop_rele_set)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i+=2;
		gran_char(&a_ind . s_i,0,2);
		}
	else if(but==253)
		{
		a_ind . s_i-=2;
		gran_char(&a_ind . s_i,0,2);
		}
	else if(but==123)
		{
		a_ind . s_i=2;
		}
	else if(a_ind . s_i==2)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	else if(a_ind . s_i==0)
		{
		if((but==239)||(but==111))DOP_RELE_FUNC++;
		if((but==247)||(but==119))DOP_RELE_FUNC--;
		gran(&DOP_RELE_FUNC,0,1);
		lc640_write_int(0x10+100+188,DOP_RELE_FUNC);
		speed=1;
		}				
	}

else if (a_ind . i==iIps_Curr_Avg_Set)
	{
     ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		a_ind . s_i1=0;
		gran_char(&a_ind . s_i,0,simax);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		a_ind . s_i1=0;
		gran_char(&a_ind . s_i,0,simax);
		}
	else if(but==123)
		{
		a_ind . s_i=simax;
		}			
	else if(a_ind . s_i==simax)
		{
		if(but==254)tree_down(0,0);
		}

	else if(a_ind . s_i==0)
		{
		if(but==254)
			{
			if(ICA_EN)ICA_EN=0;
			else ICA_EN=1;
			lc640_write_int(0x10+350+6,ICA_EN);
			}
		}
	else if(ICA_EN)
		{
		if(a_ind . s_i==1)
			{
			if(but==254)
				{
				if(ICA_CH)ICA_CH=0;
				else ICA_CH=1;
				lc640_write_int(0x10+350+4,ICA_CH);
				}
			}
		else if(ICA_CH==0)
			{
			if(a_ind . s_i==2)
				{
				if((but==239)||(but==111))
					{
					ICA_MODBUS_ADDRESS++;
					gran(&ICA_MODBUS_ADDRESS,1,254);
					lc640_write_int(0x10+350+8,ICA_MODBUS_ADDRESS);
					speed=1;
					}
				if((but==247)||(but==119))
					{
					ICA_MODBUS_ADDRESS--;
					gran(&ICA_MODBUS_ADDRESS,1,254);
					lc640_write_int(0x10+350+8,ICA_MODBUS_ADDRESS);
					speed=1;
					}
				}
			}

		else if(ICA_CH==1)
			{
			if(a_ind . s_i==2)
				{
				if((but==254)||(but==126))
					{
					a_ind . s_i1++;
					gran_ring_char(&a_ind . s_i1,0,3);
					}
				else if(a_ind . s_i1==0)
					{
					if((but==239)||(but==111))
						{
						ICA_MODBUS_TCP_IP1++;
						gran_ring(&ICA_MODBUS_TCP_IP1,0,255);
						lc640_write_int(0x10+350+10,ICA_MODBUS_TCP_IP1);
						speed=1;
						}
					if((but==247)||(but==119))
						{
						ICA_MODBUS_TCP_IP1--;
						gran(&ICA_MODBUS_TCP_IP1,0,255);
						lc640_write_int(0x10+350+10,ICA_MODBUS_TCP_IP1);
						speed=1;
						}
					}
				else if(a_ind . s_i1==1)
					{
					if((but==239)||(but==111))
						{
						ICA_MODBUS_TCP_IP2++;
						gran_ring(&ICA_MODBUS_TCP_IP2,0,255);
						lc640_write_int(0x10+350+12,ICA_MODBUS_TCP_IP2);
						speed=1;
						}
					if((but==247)||(but==119))
						{
						ICA_MODBUS_TCP_IP2--;
						gran(&ICA_MODBUS_TCP_IP2,0,255);
						lc640_write_int(0x10+350+12,ICA_MODBUS_TCP_IP2);
						speed=1;
						}
					}
				else if(a_ind . s_i1==2)
					{
					if((but==239)||(but==111))
						{
						ICA_MODBUS_TCP_IP3++;
						gran_ring(&ICA_MODBUS_TCP_IP3,0,255);
						lc640_write_int(0x10+350+14,ICA_MODBUS_TCP_IP3);
						speed=1;
						}
					if((but==247)||(but==119))
						{
						ICA_MODBUS_TCP_IP3--;
						gran(&ICA_MODBUS_TCP_IP3,0,255);
						lc640_write_int(0x10+350+14,ICA_MODBUS_TCP_IP3);
						speed=1;
						}
					}
				else if(a_ind . s_i1==3)
					{
					if((but==239)||(but==111))
						{
						ICA_MODBUS_TCP_IP4++;
						gran_ring(&ICA_MODBUS_TCP_IP4,0,255);
						lc640_write_int(0x10+350+16,ICA_MODBUS_TCP_IP4);
						speed=1;
						}
					if((but==247)||(but==119))
						{
						ICA_MODBUS_TCP_IP4--;
						gran(&ICA_MODBUS_TCP_IP4,0,255);
						lc640_write_int(0x10+350+16,ICA_MODBUS_TCP_IP4);
						speed=1;
						}
					}
				}
			if(a_ind . s_i==3)
				{
				if((but==239)||(but==111))
					{
					ICA_MODBUS_TCP_UNIT_ID++;
					gran(&ICA_MODBUS_TCP_UNIT_ID,1,254);
					lc640_write_int(0x10+350+18,ICA_MODBUS_TCP_UNIT_ID);
					speed=1;
					}
				if((but==247)||(but==119))
					{
					ICA_MODBUS_TCP_UNIT_ID--;
					gran(&ICA_MODBUS_TCP_UNIT_ID,1,254);
					lc640_write_int(0x10+350+18,ICA_MODBUS_TCP_UNIT_ID);
					speed=1;
					}
				}
			}
		}


  	} 

		

n_but=0;
}


void watchdog_enable (void) 
{
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDTC=2000000;
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDCLKSEL=0;
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDMOD=3;
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDFEED=0xaa;
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDFEED=0x55;
}


void watchdog_reset (void) 
{
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDFEED=0xaa;
((LPC_WDT_TypeDef *) ((0x40000000UL) + 0x00000) )->WDFEED=0x55;
}







void SysTick_Handler (void) 	  
{

b2000Hz=1;

if(bTPS)
	{
	((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIODIR|=(1UL<<26);
	((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIOPIN^=(1UL<<26);
	}

if(++t0cnt4>=2)
	{
t0cnt4=0;
b1000Hz=1;

	bFF=(char)(( (((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIOPIN & ((0xffffffff>>(32-1))<<27)) >> 27));
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





  return;          




}



__irq void timer0_interrupt(void) 
{	




 
}





int main (void) 
{
char ind_reset_cnt=0;






SystemInit();

bTPS=1;

((SysTick_Type *) ((0xE000E000) + 0x0010))->LOAD = (SystemFrequency / 2000) - 1;
((SysTick_Type *) ((0xE000E000) + 0x0010))->CTRL = 0x07;








((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIODIR = ( (((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIODIR & ~((0xffffffff>>(32-1))<<27)) | (0 << 27) );
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIODIR = ( (((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIODIR & ~((0xffffffff>>(32-1))<<7)) | (1 << 7) );
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIODIR = ( (((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00040) )->FIODIR & ~((0xffffffff>>(32-1))<<8)) | (1 << 8) );

	;















ad7705_reset();
{long xx; xx=(unsigned long)20 * 12000UL; while(xx)xx--;};

ad7705_write(0x21);
ad7705_write((((0x1101) | 0x1101>>3 | 0x1101>>6 | 0x1101>>9) & 0xf | ((0x1101) | 0x1101>>3 | 0x1101>>6 | 0x1101>>9)>>12 & 0xf0)); 
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


















 




lcd_init();  
lcd_on();
lcd_clear();
		

rtc_init();

a_ind . i=iMn;












	

	
	
	

	
	








adc_init();

((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIODIR|=(1<<11);
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIOSET|=(1<<11);


lc640_write_int(100,134);




memo_read();



watchdog_enable();


sc16is700_init((uint32_t)(9600));



  		
while (1)  
	{
	
     
     

	








 






 

	





  
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



		sc16is700_uart_hndl();

		}
	
	if(b100Hz)
		{
		b100Hz=0;

		
		

		if((!bRESET_INT_WDT)&&(!bRESET_EXT_WDT))but_drv();
		but_an();
		}
		 
	if(b50Hz)
		{
		b50Hz=0;
		
		
		
		
		net_drv();
		
		}

	if(b10Hz)
		{



		b10Hz=0;
				


		
		ind_hndl(); 

		bitmap_hndl();
		if(!bRESET_EXT_WDT)
			{
			lcd_out(lcd_bitmap);
			}

		
		

		adc_window_cnt=0;  

		ret_hndl();
		ret_ind_hndl();  
		mess_hndl();

					  

		
		
		

		rele_in_drv();
		}

	if(b5Hz)
		{
		b5Hz=0;

		if(!bRESET_EXT_WDT)
			{
			ad7705_drv();
			}
		if(!bRESET_EXT_WDT)
			{
			
			}  memo_read();
		((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00020) )->FIODIR|=(1UL<<26);
		matemat();
		
		rele_drv();
		
		
		
		

		transmit_hndl();
  		}

	if(b2Hz)
		{
		b2Hz=0;

				
		

		
		
  		}

	if(b1Hz)
		{
		b1Hz=0;
		if(!bRESET_INT_WDT)
			{
			watchdog_reset();
			}
		

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
		
		






 	
 
		
		
	



 


		

		
		




		
		
		
		}
	if(b1min)
		{
		b1min=0;

		}

	}
}
