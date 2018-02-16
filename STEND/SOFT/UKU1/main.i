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

#line 10 "main.c"
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






 
  

 
#line 11 "main.c"
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

#line 12 "main.c"
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
	iMn_VD,
	iSet_VD,

	iMn_TELECORE2017,

	iSrv_sl,iNet,iNet3,iNetEM,
	iSet,iSet_220_IPS_TERMOKOMPENSAT,iSet_220_V2,
	iInv_set,
	iMakb,
	iBps,iBps_elteh,iS2,iSet_prl,iK_prl,iDnd,
	iK, iK_220_IPS_TERMOKOMPENSAT,iK_220_IPS_TERMOKOMPENSAT_IB,iK_TELECORE,iK_VD,
	iSpcprl,iSpc,k,Crash_0,Crash_1,iKednd,iAv_view_avt,iAKE,iSpc_termocompensat,
	iLoad,iAVAR,
	iStr,iStr_VD,
	iVrs,iPrltst,iApv,
	iK_bps,iK_bps_sel,iK_bat_ips_termokompensat_ib,iK_bat_TELECORE,iK_bat_sel,iK_bat_sel_TELECORE,iK_load,iK_net,iK_net3,
	iK_makb_sel,iK_makb,iK_out,
	iTst_220_IPS_TERMOKOMPENSAT,iTst_VD,
	iTst_klbr,iTst_BPS1,iTst_BPS2,iTst_BPS12,iDebug,
	iDef_220_IPS_TERMOKOMPENSAT,
	iSet_st_prl,iK_pdp,iSet_T,
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
	iExt_ddv,iExt_ddi,iExt_dud,iExt_dp,iSM,iLog,iLog_,iBatLog,iKlimat,iKlimat_kontur,iKlimat_TELECORE,
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




typedef struct
     {
	char 		_cnt_to_block;
	signed short	_Ub;
     signed short	_Ubm;
     signed short	_dUbm;
	signed short	_Ib;
	signed short	_Tb;
	char 		_nd;
	char 		_cnt_wrk;
	char 		_wrk;
	unsigned short _zar;
	char 		_full_ver;
	signed long 	_zar_cnt;
	signed long 	_zar_cnt_ke;
	unsigned short _Iintegr,_Iintegr_; 
	signed short 	_u_old[8];
	signed short	_u_old_cnt;
	unsigned long 	_wrk_date[2];
	char 		_rel_stat;
	char			_av;
	char			_time_cnt;
	char 		_temper_stat;
	
	
	signed short 	_sign_temper_cnt;
	signed short 	_max_temper_cnt;
	signed long 	_resurs_cnt;
	signed short 	_cnt_as; 	
     
	
	} BAT_STAT; 
extern BAT_STAT bat[2],bat_ips;
extern signed short		bat_u_old_cnt;
extern signed short 	Ib_ips_termokompensat;


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



typedef struct
     {
	signed short	_U[5];
	signed short	_Ub[5];
	signed short	_T[5];
	signed short	_T_nd[5];
	signed short 	_cnt; 	
	} MAKB_STAT; 
extern MAKB_STAT makb[4];



typedef struct
     {
	signed short	_max_cell_volt;
	signed short	_min_cell_volt;
	signed short	_max_cell_temp;
	signed short	_min_cell_temp;
	signed short	_tot_bat_volt;
	signed short	_ch_curr;
	signed short	_dsch_curr;
	signed short	_rat_cap;
	signed short	_s_o_h;
	signed short	_s_o_c;
	signed short	_c_c_l_v;
	signed short	_r_b_t;
	signed short	_b_p_ser_num;
	signed short   _flags1;
	signed short 	_flags2;
	signed short 	_communication2lvlErrorStat; 	
	signed short	_communication2lvlErrorCnt;  	
	signed short 	_cnt;
	signed short 	_communicationFullErrorStat;	
	signed short   _battIsOn;		
	char 		_plazma[8];		
	signed short 	_isOnCnt;
	signed short	_s_o_c_abs;		
	signed short 	_s_o_c_percent; 
	signed short	_plazma_ss;
	signed short	_zar_percent;	
	signed char		_cell_temp_1;	
	signed char		_cell_temp_2;	
	signed char		_cell_temp_3;	
	signed char		_cell_temp_4;	
	signed char		_cell_temp_ambient;	
	signed char		_cell_temp_power;	
	
	
	
	signed char		_charge_and_discharge_current_alarm_status;	 	
	signed char 	_battery_total_voltage_alarm_status;			
	signed char		_custom_alarm_quantity;							
	signed char		_balanced_event_code;							
	signed char 	_voltage_event_code;							
	signed char 	_temperature_event_code;						
	signed char		_current_event_code;							
	signed char		_fet_status_code;								
	signed short	_balanced_status_code;							
	signed char 	_system_status_code;							

	} LAKB_STAT; 
extern LAKB_STAT lakb[3];
extern char lakb_damp[1][42];
extern char bLAKB_KONF_CH;
extern char bLAKB_KONF_CH_old;
extern char lakb_ison_mass[7];
extern short lakb_mn_ind_cnt;
extern char bLAKB_KONF_CH_EN;
extern char bRS485ERR;
extern short LBAT_STRUKT;
extern char lakb_error_cnt;	
extern short numOfPacks,numOfPacks_;
extern short numOfCells, numOfTemperCells, baseOfData;
extern short lakb_stat_comm_error;	
extern short lakbNotErrorNum;		
extern short lakbKanErrorCnt;		
extern short lakbKanErrorStat;		





extern char can_slot[12][16];
extern char plazma_can_inv[3];





typedef struct
    {
    enum {dSRC=3,dINV=5,dNET_METR=7,dIBAT_METR=9,dMAKB=11}_device;
	char _av;
	
	
	
	
	
 	enum {bsOFF_AV_NET,bsAPV,bsWRK,bsRDY,bsBL,bsAV}_state;
    char _cnt;
     char _cnt_old;
     char _cnt_more2;
     char _buff[20]; 
     
     
     
     
     signed _Uii; 
     signed _Uin;
     signed _Ii;
     signed _Ti; 
     char _flags_tu;
	 signed _Uisum;
     
     
     
     
     
     signed _vol_u;
     signed _vol_i;
     char _is_on_cnt;
     
     int _ist_blok_host_cnt;
     short _blok_cnt; 
     char _flags_tm;
	signed short _overload_av_cnt;     
     signed short _temp_av_cnt;
     signed short _umax_av_cnt;
     signed short _umin_av_cnt;
     signed _rotor;
     signed  short _x_; 
     char _adr_ee;
	char _last_avar;
	char _vent_resurs_temp[4];
	unsigned short _vent_resurs;
	signed short debug_info_to_uku0;
	signed short debug_info_to_uku1;
	signed short _avg;
	signed short _cntrl_stat;
     } BPS_STAT; 
extern BPS_STAT bps[29];



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
#line 1458 "main.h"

#line 1469 "main.h"

#line 1485 "main.h"

extern char ext_can_cnt;


signed short abs_pal(signed short in);
void ADC_IRQHandler(void);




typedef enum  {avtOFF,avtON} enum_avt_stat;
extern enum_avt_stat avt_stat[12],avt_stat_old[12]; 



extern signed long ibat_metr_buff_[2];
extern short bIBAT_SMKLBR;
extern char ibat_metr_cnt;



extern signed short npn_tz_cnt;
typedef enum {npnsOFF=0,npnsON} enum_npn_stat;
extern enum_npn_stat npn_stat;

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



#line 1539 "main.h"












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






 
#line 13 "main.c"
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
#line 14 "main.c"
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
#line 15 "main.c"
#line 1 "Timer.h"









 



	


extern void delayMs(uint8_t timer_num, uint32_t delayInMs);
extern uint32_t init_timer( uint8_t timer_num, uint32_t timerInterval );
extern void enable_timer( uint8_t timer_num );
extern void disable_timer( uint8_t timer_num );
extern void reset_timer( uint8_t timer_num );
extern void TIMER0_IRQHandler (void);
extern void TIMER1_IRQHandler (void);




 
#line 16 "main.c"
#line 1 "gran.h"

void gran_ring_char(signed char *adr, signed char min, signed char max) ;
void gran_char(signed char *adr, signed char min, signed char max);
void gran(signed short *adr, signed short min, signed short max);
void gran_ring(signed short *adr, signed short min, signed short max);
void gran_long(signed long *adr, signed long min, signed long max); 
#line 17 "main.c"
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

#line 18 "main.c"
#line 1 "uart1.h"









extern char bRXIN1;
extern char UIB1[20];
extern char flag1;
extern char rx_buffer1[100];
extern char tx_buffer1[300];
extern unsigned short rx_wr_index1,rx_rd_index1,rx_counter1;
extern unsigned short tx_wr_index1,tx_rd_index1,tx_counter1;
extern char rx_buffer_overflow1;
extern char plazma_uart1;
extern char uart1_mess[10];
extern char data_rs1[40];
typedef enum {ursMEGA=0x55,ursXPORT=0xaa}enum_usart1_router_stat;
extern enum_usart1_router_stat usart1_router_stat;
extern char usart1_router_wrk;
extern char memo_out1[100];

extern char UIB10[30];
extern char usart1_router_cnt;
extern char plazma_suz[5];

void putchar1(char c);
void uart_out1 (char num,char data0,char data1,char data2,char data3,char data4,char data5);
void uart_out_adr1 (char *ptr, unsigned char len);
void uart1_init(void);
char getchar1(void);
__irq void uart1_interrupt(void);
void uart_in_an1(void);
char index_offset1 (signed char index,signed char offset);
char control_check1(char index);
void uart_in1(void);

#line 19 "main.c"
#line 1 "uart2.h"




















#line 29 "uart2.h"


extern char bRXIN2;
extern char UIB2[100];
extern char flag2;
extern char rx_buffer2[1024];
extern char tx_buffer2[1024];
extern unsigned short rx_wr_index2,rx_rd_index2,rx_counter2;
extern unsigned short tx_wr_index2,tx_rd_index2,tx_counter2;
extern char rx_buffer_overflow2;
extern char plazma_uart2;
extern char memo_out2[50];
extern char data_rs2[50];
extern char data_rs02[50];

void putchar2(char c);
void uart_out2 (char num,char data0,char data1,char data2,char data3,char data4,char data5);
void uart_out_adr2 (char *ptr, char len);
void uart0_init(void);
char getchar0(void);
__irq void uart0_interrupt(void);
void uart_in_an2(void);
signed short index_offset2 (signed short index,signed short offset);
char control_check2(signed short index);
void uart_in0(void);
void uart_out_adr2_block (unsigned long adress,char *ptr, char len);
uint32_t UART_2_Init(uint32_t baudrate );
void uart_in2(void); 


#line 20 "main.c"
#line 1 "cmd.h"


#line 21 "main.c"
#line 1 "ret.h"




extern char retind,retsub,retindsec;
extern int retcnt,retcntsec;
extern unsigned char f0,fc0,f1,fc1;
extern short ret_duty;

void ret_ind(char r_i,char r_s,int r_c);
void ret_ind_hndl(void);
void ret_ind_sec(char r_i,int r_c);
void ret_ind_sec_hndl(void);
void ret(short duty);
void ret_hndl(void);








 

     
#line 22 "main.c"
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

#line 23 "main.c"
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

#line 24 "main.c"
#line 1 "control.h"







extern char num_of_wrks_bps;
extern char bps_all_off_cnt,bps_mask_off_cnt,bps_mask_on_off_cnt;
extern char bps_hndl_2sec_cnt;
extern unsigned short bps_on_mask,bps_off_mask;
extern char num_necc_up,num_necc_down;
extern unsigned char sh_cnt0,b1Hz_sh;


extern short cntrl_stat_blok_cnt,cntrl_stat_blok_cnt_,cntrl_stat_blok_cnt_plus[2],cntrl_stat_blok_cnt_minus[2];



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


void rele_hndl(void);
void bps_hndl(void);
void bps_drv(char in);
void bat_hndl(void);
void bat_drv(char in);
void u_necc_hndl(void);
void cntrl_hndl(void);
void zar_drv(void);
void num_necc_hndl(void);
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



extern signed short cntrl_stat;
extern signed short cntrl_stat_old;
extern signed short cntrl_stat_new;
extern signed short Ibmax;
extern unsigned char unh_cnt0,unh_cnt1,b1Hz_unh;
extern unsigned char	ch_cnt0,b1Hz_ch,i,iiii;
extern unsigned char	ch_cnt1,b1_30Hz_ch;
extern unsigned char	ch_cnt2,b1_10Hz_ch;
extern unsigned short IZMAX_;
extern unsigned short IZMAX_70;
extern unsigned short IZMAX_130;
extern unsigned short Ubpsmax;
extern unsigned short cntrl_stat_blck_cnt;

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


#line 25 "main.c"
#line 1 "mess.h"










		





void mess_hndl(void);
void mess_send(char _mess, short par0, short par1, char _time);
char mess_find(char _mess);
char mess_find_unvol(char _mess);

#line 26 "main.c"
#line 1 "full_can.h"


  








#line 19 "full_can.h"



  
















extern char ptr_can1_tx_wr,ptr_can1_tx_rd;
extern long can1_info[8];
extern long can1_id[8];
extern long can1_data[8];
extern long can1_datb[8];
																							 
extern char ptr_can2_tx_wr,ptr_can2_tx_rd;

extern long can2_info[8];
extern long can2_id[8];
extern long can2_data[8];
extern long can2_datb[8];

extern unsigned short rotor_can[6];



extern char bR;
extern char RXBUFF[40],TXBUFF[40];
extern char bIN,bIN2;
extern char bd_dumm[25];
extern char bd[25];
extern char TX_len;

extern char RXBUFF2[40],TXBUFF2[40];
extern char can_tx_cnt;
extern char can_tx_cnt2;


extern char rotor_rotor_rotor[2];
extern char can_tx_cnt;

extern const char Table87[];
extern const char Table95[];

extern char can_debug_plazma[2][10];
extern char bOUT_FREE;
extern char can_rotor[10];
extern char plazma_can;
extern char plazma_can1,plazma_can2,plazma_can3,plazma_can4;



typedef struct
{
  unsigned int Dat1; 
                     
                     
                     
  unsigned int DatA; 
  unsigned int DatB; 
} FULLCAN_MSG; 
extern short volatile gCANFilter;
extern FULLCAN_MSG volatile gFullCANList[2];
extern char can_reset_cnt;



char CRC1_in(void);
char CRC2_in(void);
char CRC1_out(void);
char CRC2_out(void);
void can1_out_adr(char* ptr,char num);
__irq void can_isr_err (void);
void mcp2515_transmit(char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7);
void can_adr_hndl(void);
void can_in_an(void);
void can_in_an2(void);
__irq void can_isr_rx (void); 
__irq void can_isr_tx (void); 
short can1_init ( unsigned int can_btr);
short can2_init ( unsigned int can_btr);
short FullCAN_SetFilter (
  unsigned short can_port, 
  unsigned int CANID 
  );

void CAN_IRQHandler(void);
void CAN_ISR_Rx1( void );

extern char can_debug_plazma[2][10];
extern char ccc_plazma[20];

#line 27 "main.c"
#line 1 "watchdog.h"

void watchdog_init(unsigned long f,unsigned long time_out);
void watchdog_reset(void);





#line 28 "main.c"
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



#line 29 "main.c"
#line 1 "beep.h"

extern unsigned long beep_stat_temp,beep_stat;
extern char beep_stat_cnt;
extern char beep_cnt;
extern char bU_BAT2REL_AV_BAT;

void beep_drv(void);
void beep_init(long zvuk,char fl);
void beep_hndl(void);
#line 30 "main.c"
#line 1 "avar_hndl.h"




extern unsigned avar_stat;	 	
extern unsigned avar_ind_stat; 	
extern unsigned avar_stat_old;
extern unsigned avar_stat_new,avar_stat_offed;









void avar_hndl(void);
void avar_unet_hndl(char in);
void avar_uout_hndl(char in);
void reload_hndl(void);
void avar_bps_hndl(char bps, char v, char in);
void avar_bat_hndl(char bat, char in);
void avar_bat_as_hndl(char b, char in);
void ke_mem_hndl(char b,unsigned short in);
void vz_mem_hndl(unsigned short in);
void wrk_mem_hndl(char b);
void avar_bat_ips_hndl(char in);



#line 31 "main.c"
#line 1 "memo.h"

void memo_read (void);






#line 32 "main.c"
#line 1 "simbols.h"


extern const char sAVNET[150];
extern const char sAVNET1[150];
extern const char sBPS1[30];
extern const char sBPS2[30];
extern const char sAVT[30];
extern const char sAVU[30];
extern const char caracter[1536];
#line 33 "main.c"
#line 1 "graphic.h"


void draw(signed short x_b,signed short y_b,signed short x_o,signed short y_o,char inverse);
void draw_rectangle(signed short x_b,signed short y_b,signed short x_o,signed short y_o,char solid,char inverse);	   
void draw_ptr(char x_b,char y_b,char ptr,char vol);
void plot(signed short x_b,signed short y_b,unsigned long data,signed short len,char inverse);
void graphic_print(signed short x_b,signed short y_b,signed short x_l,signed short y_l,signed short x_d,signed short y_d,const char* adress,char inverse);
void graphic_print_text(signed short x_b,signed short y_b,const char* bgnd,signed short num,signed short data,signed short des,signed short pos,char inverse);
void graphic_print_text_text(signed short x_b,signed short y_b,const char* bgnd,signed short num,signed short data,signed short des,signed short pos,char inverse);
#line 34 "main.c"
#line 1 "snmp_data_file.h"
extern char snmp_community[10];


extern signed short snmp_device_code;
extern signed 	   snmp_sernum;
extern signed short snmp_sernum_lsb;
extern signed short snmp_sernum_msb;
extern char 	   snmp_location[100];
extern signed short snmp_numofbat;
extern signed short snmp_numofbps;
extern signed short snmp_numofinv;
extern signed short snmp_numofavt;
extern signed short snmp_numofdt;
extern signed short snmp_numofsk;
extern signed short snmp_numofevents;


extern signed short snmp_mains_power_voltage;
extern signed short snmp_mains_power_frequency;
extern signed short snmp_mains_power_status;
extern signed short snmp_mains_power_alarm;
extern signed short snmp_mains_power_voltage_phaseA;
extern signed short snmp_mains_power_voltage_phaseB;
extern signed short snmp_mains_power_voltage_phaseC;


extern signed short snmp_load_voltage;
extern signed short snmp_load_current;


extern signed short snmp_bps_number[8];
extern signed short snmp_bps_voltage[8];
extern signed short snmp_bps_current[8];
extern signed short snmp_bps_temperature[8];
extern signed short snmp_bps_stat[8];


extern signed short snmp_inv_number[3];
extern signed short snmp_inv_voltage[3];
extern signed short snmp_inv_current[3];
extern signed short snmp_inv_temperature[3];
extern signed short snmp_inv_stat[3];


extern signed short snmp_bat_number[2];
extern signed short snmp_bat_voltage[2];
extern signed short snmp_bat_part_voltage[2];
extern signed short snmp_bat_current[2];
extern signed short snmp_bat_temperature[2];
extern signed short snmp_bat_capacity[2];
extern signed short snmp_bat_charge[2];
extern signed short snmp_bat_status[2];


extern signed short snmp_makb_number[4];
extern signed short snmp_makb_connect_status[4];
extern signed short snmp_makb_voltage0[4];
extern signed short snmp_makb_voltage1[4];
extern signed short snmp_makb_voltage2[4];
extern signed short snmp_makb_voltage3[4];
extern signed short snmp_makb_voltage4[4];
extern signed short snmp_makb_temper0[4];
extern signed short snmp_makb_temper1[4];
extern signed short snmp_makb_temper2[4];
extern signed short snmp_makb_temper3[4];
extern signed short snmp_makb_temper4[4];
extern signed short snmp_makb_temper0_stat[4];
extern signed short snmp_makb_temper1_stat[4];
extern signed short snmp_makb_temper2_stat[4];
extern signed short snmp_makb_temper3_stat[4];
extern signed short snmp_makb_temper4_stat[4];
extern signed short snmp_bat_voltage[2];
extern signed short snmp_bat_current[2];
extern signed short snmp_bat_temperature[2];
extern signed short snmp_bat_capacity[2];
extern signed short snmp_bat_charge[2];
extern signed short snmp_bat_status[2]; 



extern signed short snmp_spc_stat;
extern char snmp_spc_trap_message[100];
extern signed short snmp_spc_trap_value_0,snmp_spc_trap_value_1,snmp_spc_trap_value_2;


extern signed short snmp_energy_vvod_phase_a;
extern signed short snmp_energy_vvod_phase_b;
extern signed short snmp_energy_vvod_phase_c;
extern signed short snmp_energy_pes_phase_a;
extern signed short snmp_energy_pes_phase_b;
extern signed short snmp_energy_pes_phase_c;
extern signed short snmp_energy_input_voltage;


extern signed long snmp_energy_total_energy;
extern signed short snmp_energy_current_energy;


extern signed char snmp_sk_number[4];
extern signed char snmp_sk_aktiv[4];
extern signed char snmp_sk_alarm_aktiv[4];
extern signed char snmp_sk_alarm[4];
extern char snmp_sk_name[4][20];


extern signed char snmp_dt_number[3];
extern signed short snmp_dt_temper[3];
extern signed char snmp_dt_error[3];


extern signed char snmp_avt_number[12];
extern signed char snmp_avt_stat[12];


extern signed short snmp_command;
extern signed short snmp_command_parametr;


extern char snmp_log[64][128];


extern signed short snmp_main_bps;
extern signed short snmp_zv_en;
extern signed short snmp_alarm_auto_disable;
extern signed short snmp_bat_test_time;
extern signed short snmp_u_max;
extern signed short snmp_u_min;
extern signed short snmp_u_0_grad;
extern signed short snmp_u_20_grad;
extern signed short snmp_u_sign;
extern signed short snmp_u_min_power;
extern signed short snmp_u_withouth_bat;
extern signed short snmp_control_current;
extern signed short snmp_max_charge_current;
extern signed short snmp_max_current;
extern signed short snmp_min_current;
extern signed short snmp_uvz;
extern signed short snmp_max_current_koef;
extern signed short snmp_max_current_koef;
extern signed short snmp_up_charge_koef;
extern signed short snmp_powerup_psu_timeout;
extern signed short snmp_max_temperature;
extern signed short snmp_tsign_bat; 
extern signed short snmp_tmax_bat;
extern signed short snmp_tsign_bps;
extern signed short snmp_tmax_bps;
extern signed short snmp_bat_part_alarm;
extern signed short snmp_power_cnt_adress;


extern signed short snmp_klimat_box_temper;
extern signed short snmp_klimat_settings_box_alarm;
extern signed short snmp_klimat_settings_vent_on;
extern signed short snmp_klimat_settings_vent_off;
extern signed short snmp_klimat_settings_warm_on;
extern signed short snmp_klimat_settings_warm_off;
extern signed short snmp_klimat_settings_load_on;
extern signed short snmp_klimat_settings_load_off;
extern signed short snmp_klimat_settings_batt_on;
extern signed short snmp_klimat_settings_batt_off;


extern signed short snmp_dt_ext;
extern signed short snmp_dt_msan;
extern signed short snmp_dt_epu;


extern short snmp_lakb_number[7];				
extern short snmp_lakb_voltage[7];				
extern short snmp_lakb_max_cell_voltage[7];		
extern short snmp_lakb_min_cell_voltage[7];		
extern short snmp_lakb_max_cell_temperature[7];	
extern short snmp_lakb_min_cell_temperature[7];	
extern short snmp_lakb_ch_curr[7];				
extern short snmp_lakb_dsch_curr[7];			
extern short snmp_lakb_rat_cap[7];				
extern short snmp_lakb_soh[7];				
extern short snmp_lakb_soc[7];				
extern short snmp_lakb_cclv[7];  				
extern short snmp_lakb_rbt[7];				
extern short snmp_lakb_flags1[7];				
extern short snmp_lakb_flags2[7];				
extern char snmp_lakb_damp1[3][150];				
extern char snmp_lakb_damp2[100];				
extern signed char	snmp_lakb_cell_temperature_1[3];		
extern signed char	snmp_lakb_cell_temperature_2[3];		
extern signed char	snmp_lakb_cell_temperature_3[3];		
extern signed char	snmp_lakb_cell_temperature_4[3];		
extern signed char	snmp_lakb_cell_temperature_ambient[3];	
extern signed char	snmp_lakb_cell_temperature_power[3];	


extern signed char	snmp_warm_sign;				
extern signed char	snmp_cool_sign;				
extern signed char	snmp_warm_on_temper;		
extern signed char	snmp_warm_off_temper;		
extern signed char	snmp_warm_q;				
extern signed char	snmp_cool_100_temper;		
extern signed char	snmp_cool_80_temper;		
extern signed char	snmp_cool_60_temper;		
extern signed char	snmp_cool_40_temper;		
extern signed char	snmp_cool_20_temper;		
extern signed char	snmp_cool_100_dtemper;		
extern signed char	snmp_cool_80_dtemper;		
extern signed char	snmp_cool_60_dtemper;		
extern signed char	snmp_cool_40_dtemper;		
extern signed char	snmp_cool_20_dtemper;		
extern signed char 	snmp_warm_stat;				
  

void snmp_data (void);
void snmp_sernum_write (int mode); 
void snmp_location_write (int mode);
void snmp_command_execute (int mode);
void event2snmp(char num);
void snmp_main_bps_write (int mode);
void snmp_zv_on_write (int mode);
void snmp_alarm_auto_disable_write (int mode);
void snmp_bat_test_time_write (int mode);
void snmp_u_max_write (int mode);
void snmp_u_min_write (int mode);
void snmp_u_0_grad_write (int mode);
void snmp_u_20_grad_write (int mode);
void snmp_u_sign_write (int mode);
void snmp_u_min_power_write (int mode);
void snmp_u_withouth_bat_write (int mode);
void snmp_control_current_write (int mode);
void snmp_max_charge_current_write (int mode);
void snmp_max_current_write (int mode);
void snmp_min_current_write (int mode);
void snmp_up_charge_koef_write (int mode);
void snmp_powerup_psu_timeout_write (int mode);
void snmp_max_temperature_write (int mode);
void event2snmp(char num);
void snmp_trap_send(char* str, signed short in0, signed short in1, signed short in2);
void snmp_alarm_aktiv_write1(int mode);
void snmp_alarm_aktiv_write2(int mode);
void snmp_alarm_aktiv_write3(int mode);
void snmp_alarm_aktiv_write4(int mode);
void snmp_klimat_settings_box_alarm_write(int mode);
void snmp_klimat_settings_vent_on_write(int mode);
void snmp_klimat_settings_vent_off_write(int mode);
void snmp_klimat_settings_warm_on_write(int mode);
void snmp_klimat_settings_warm_off_write(int mode);
void snmp_klimat_settings_load_on_write(int mode);
void snmp_klimat_settings_load_off_write(int mode);
void snmp_klimat_settings_batt_on_write(int mode);
void snmp_klimat_settings_batt_off_write(int mode);
void snmp_tsign_bat_write(int mode);
void snmp_tmax_bat_write(int mode);
void snmp_tsign_bps_write(int mode);
void snmp_tmax_bps_write(int mode);
void snmp_bat_part_alarm_write(int mode);
void snmp_power_cnt_adress_write(int mode);
void snmp_uvz_write(int mode);
void snmp_warm_sign_write(int mode);
void snmp_cool_sign_write(int mode);
void snmp_warm_on_temper_write(int mode);
void snmp_warm_off_temper_write(int mode);
void snmp_warm_q_write(int mode);
void snmp_cool_100_temper_write(int mode);
void snmp_cool_80_temper_write(int mode);
void snmp_cool_60_temper_write(int mode);
void snmp_cool_40_temper_write(int mode);
void snmp_cool_20_temper_write(int mode);
void snmp_cool_100_dtemper_write(int mode);
void snmp_cool_80_dtemper_write(int mode);
void snmp_cool_60_dtemper_write(int mode);
void snmp_cool_40_dtemper_write(int mode);
void snmp_cool_20_dtemper_write(int mode);





 
#line 35 "main.c"
#line 1 "C:\\Keil\\ARM\\RV31\\INC\\net_config.h"









 




#line 16 "C:\\Keil\\ARM\\RV31\\INC\\net_config.h"

 



                                   





 




 




 
#line 50 "C:\\Keil\\ARM\\RV31\\INC\\net_config.h"

 





 
#line 73 "C:\\Keil\\ARM\\RV31\\INC\\net_config.h"

 





typedef struct os_frame {          
  U16 length;                      
  U16 index;                       
  U8  data[1];                     
} OS_FRAME;


typedef struct arp_info {          
  U8  State;                       
  U8  Type;                        
  U8  Retries;                     
  U8  Tout;                        
  U8  HwAdr[6];           
  U8  IpAdr[4];            
} ARP_INFO;


typedef struct igmp_info {         
  U8  State;                       
  U8  Tout;                        
  U8  GrpIpAdr[4];         
} IGMP_INFO;


typedef struct udp_info {          
  U8  State;                       
  U8  McastTtl;                    
  U16 LocPort;                     
  U8  Tos;                         
  U8  Opt;                         
                                   
  U16 (*cb_func)(U8 socket, U8 *rem_ip, U16 port, U8 *buf, U16 len);
} UDP_INFO;


typedef struct tcp_info {          
  U8  State;                       
  U8  Type;                        
  U8  Flags;                       
  U8  Tos;                         
  U8  RemIpAdr[4];         
  U16 RemPort;                     
  U16 LocPort;                     
  U16 MaxSegSize;                  
  U16 WinSize;                     
  U32 SendSeq;                     
  U32 SendSeqNext;                 
  U32 RecSeqNext;                  
  U16 Tout;                        
  U16 AliveTimer;                  
  U16 RetryTimer;                  
  U8  TxFlags;                     
  U8  Retries;                     
  OS_FRAME *ReTransFrm;            
                                   
  U16 (*cb_func)(U8 socket, U8 event, U8 *p1, U16 p2);
} TCP_INFO;


typedef struct http_info {         
  U8  State;                       
  U8  Socket;                      
  U16 Flags;                       
  U8  FType;                       
  U8  PostSt;                      
  U16 DelimSz;                     
  U32 CGIvar;                      
  U32 DLen;                        
  U32 Count;                       
  U16 BCnt;                        
  U8  Lang[6];                     
  U32 LMDate;                      
  U8 *Script;                      
  U8 *pDelim;                      
  void *sFile;                     
  void *dFile;                     
} HTTP_INFO;


typedef struct http_file {         
  const U32 Id;                    
  const U8 *Start;                 
} HTTP_FILE;


typedef struct tnet_info {         
  U8  State;                       
  U8  Socket;                      
  U8  Flags;                       
  U8  BCnt;                        
  U16 Tout;                        
  U8  Widx;                        
  U8  Ridx;                        
  U32 SVar;                        
  U8  LBuf[96];           
  U8  Fifo[128];           
  U8  hNext;                       
  U8  hCurr;                       
  U8  Hist[128];           
} TNET_INFO;


typedef struct tftp_info {         
  U8  State;                       
  U8  Retries;                     
  U8  Flags;                       
  U16 Timer;                       
  U8  RemIpAdr[4];         
  U16 RemPort;                     
  U16 BlockNr;                     
  void *File;                      
  U32 FPos;                        
} TFTP_INFO;


typedef struct ftp_info {          
  U8  State;                       
  U8  Socket;                      
  U8  Flags;                       
  U8  Resp;                        
  U8  RemIpAdr[4];         
  U16 DPort;                       
  U8  DSocket;                     
  U8  PathLen;                     
  U8 *Path;                        
  U8 *Name;                        
  void *File;                      
} FTP_INFO;


typedef struct dns_cache {         
  U32 HostId;                      
  U32 Ttl;                         
  U8  IpAdr[4];            
} DNS_CACHE;


typedef struct localm {            
  U8 IpAdr[4];             
  U8 DefGW[4];             
  U8 NetMask[4];           
  U8 PriDNS[4];            
  U8 SecDNS[4];            
} LOCALM;


typedef struct remotem {           
  U8 IpAdr[4];             
  U8 HwAdr[6];            
} REMOTEM;


typedef struct mib_entry {         
  U8   Type;                       
  U8   OidLen;                     
  U8   Oid[13];             
  U8   ValSz;                      
  void *Val;                       
  void (*cb_func)(int mode);       
} MIB_ENTRY;


typedef enum {                     
  ERR_MEM_ALLOC,
  ERR_MEM_FREE,
  ERR_MEM_CORRUPT,
  ERR_UDP_ALLOC,
  ERR_TCP_ALLOC,
  ERR_TCP_STATE
} ERROR_CODE;




 

 
extern void init_system (void);
extern void run_system (void);
extern void process_hl_igmp (OS_FRAME *frame);
extern void process_hl_udp (OS_FRAME *frame);
extern void process_hl_tcp (OS_FRAME *frame);
extern BOOL dispatch_frame (OS_FRAME *frame, U8 netif);
extern BOOL eth_chk_adr (OS_FRAME *frame);
extern U8  *eth_get_adr (U8 *ipadr);
__weak void arp_notify (void);
extern void sys_error (ERROR_CODE code);

 
extern OS_FRAME *alloc_mem (U32 byte_size);
extern void free_mem (OS_FRAME *mem_ptr);

 
extern void init_eth_link (void);
extern void run_eth_link (void);
extern void put_in_queue (OS_FRAME *frame);
extern BOOL eth_send_frame (OS_FRAME *frame);

 
extern void init_ppp_link (void);
extern void run_ppp_link (void);
extern BOOL ppp_send_frame (OS_FRAME *frame, U16 prot);

 
extern void init_slip_link (void);
extern void run_slip_link (void);
extern BOOL slip_send_frame (OS_FRAME *frame);

 
extern int  mem_copy (void *dp, void *sp, int len);
extern void mem_rcopy (void *dp, void *sp, int len);
extern BOOL mem_comp (void *sp1, void *sp2, int len);
extern void mem_set (void *dp, U8 val, int len);
extern BOOL mem_test (void *sp, U8 val, int len);
extern BOOL str_scomp (U8 *sp, U8 const *cp);
extern int  str_copy (U8 *dp, U8 *sp);
extern void str_up_case (U8 *dp, U8 *sp);
extern U16  SwapB (U16 w16);
extern U16  get_u16 (U8 *p16);
extern U32  get_u32 (U8 *p32);
extern void set_u32 (U8 *p32, U32 val);

 
extern void arp_send_req (U32 entry);

 
extern void init_igmp (void);
extern void run_igmp_host (void);
extern void process_igmp (OS_FRAME *frame);

 
extern void init_udp (void);
extern void process_udp (OS_FRAME *frame);

 
extern void init_tcp (void);
extern void tcp_poll_sockets (void);
extern void process_tcp (OS_FRAME *frame_r);

 
extern void init_http (void);
extern void run_http_server (void);
extern void *http_fopen (U8 *name);
extern void http_fclose (void *file);
extern U16  http_fread (void *file, U8 *buf, U16 len);
extern BOOL http_fgets (void *file, U8 *buf, U16 size);
extern U32  http_finfo (U8 *name);
extern void cgi_process_var (U8 *qstr);
extern void cgi_process_data (U8 code, U8 *dat, U16 len);
extern U16  cgi_func (U8 *env, U8 *buf, U16 buflen, U32 *pcgi);
extern U8  *cgx_content_type (void);
extern BOOL http_accept_host (U8 *rem_ip, U16 rem_port);
extern U8  *http_get_var (U8 *env, void *ansi, U16 maxlen);
extern U8  *http_get_lang (void);
extern void http_get_info (REMOTEM *info);
extern U8   http_get_session (void);
extern U8  *http_get_content_type (void);
extern U32  http_date (RL_TIME *time);

 
extern void init_tnet (void);
extern void run_tnet_server (void);
extern U16  tnet_cbfunc (U8 code, U8 *buf, U16 buflen);
extern U16  tnet_process_cmd (U8 *cmd, U8 *buf, U16 buflen, U32 *pvar);
extern BOOL tnet_ccmp (U8 *buf, U8 *cmd);
extern void tnet_set_delay (U16 cnt);
extern void tnet_get_info (REMOTEM *info);
extern U8   tnet_get_session (void);
extern BOOL tnet_msg_poll (U8 session);

 
extern void init_tftp (void);
extern void run_tftp_server (void);
extern void *tftp_fopen (U8 *fname, U8 *mode);
extern void tftp_fclose (void *file);
extern U16  tftp_fread (void *file, U32 fpos, U8 *buf);
extern U16  tftp_fwrite (void *file, U8 *buf, U16 len);

 
extern void init_ftp (void);
extern void run_ftp_server (void);
extern void *ftp_fopen (U8 *fname, U8 *mode);
extern void ftp_fclose (void *file);
extern U16  ftp_fread (void *file, U8 *buf, U16 len);
extern U16  ftp_fwrite (void *file, U8 *buf, U16 len);
extern BOOL ftp_fdelete (U8 *fname);
extern BOOL ftp_frename (U8 *fname, U8 *newn);
extern U16  ftp_ffind (U8 code, U8 *buf, U8 *mask, U16 len);

 
extern void init_dhcp (void);
extern void run_dhcp_client (void);

 
extern void init_nbns (void);

 
extern void init_dns (void);
extern void run_dns_client (void);
extern U8   get_host_by_name (U8 *hostn, void (*cbfunc)(U8, U8 *));

 
extern void init_smtp (void);
extern void run_smtp_client (void);
extern U16  smtp_cbfunc (U8 code, U8 *buf, U16 buflen, U32 *pvar);
extern BOOL smtp_accept_auth (U8 *srv_ip);

 
extern void init_ethernet (void);
extern void send_frame (OS_FRAME *frame);
extern void poll_ethernet (void);
extern void int_enable_eth (void);
extern void int_disable_eth (void);

 
extern void init_serial (void);
extern int  com_getchar (void);
extern BOOL com_putchar (U8 c);
extern BOOL com_tx_active (void);

 
extern void init_modem (void);
extern void modem_dial (U8 *dialnum);
extern void modem_hangup (void);
extern void modem_listen (void);
extern BOOL modem_online (void);
extern BOOL modem_process (U8 ch);
extern void modem_run (void);







 



#line 36 "main.c"
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

#line 37 "main.c"
#line 38 "main.c"
#line 1 "modbus.h"

extern unsigned char modbus_buf[20];
extern short modbus_crc16;
extern char modbus_timeout_cnt;
extern char bMODBUS_TIMEOUT;
extern unsigned char modbus_rx_buffer[30];	
extern unsigned char modbus_an_buffer[30];	
extern unsigned char modbus_rx_buffer_ptr;	
extern unsigned char modbus_rx_counter;		

extern short modbus_plazma;				
extern short modbus_plazma1;				
extern short modbus_plazma2;				
extern short modbus_plazma3;				

extern unsigned short modbus_rx_arg0;		
extern unsigned short modbus_rx_arg1;		
extern unsigned short modbus_rx_arg2;		
extern unsigned short modbus_rx_arg3;		

extern char modbus_tx_buff[100];



unsigned short CRC16_2(char* buf, short len);





void modbus_hold_registers_transmit(unsigned char adr,unsigned char func,unsigned short reg_adr,unsigned short reg_quantity, char prot);

void modbus_input_registers_transmit(unsigned char adr,unsigned char func,unsigned short reg_adr,unsigned short reg_quantity, char prot);





#line 39 "main.c"
#line 1 "sacred_sun.h"

extern char portForSacredSunBatteryIsInitiated;
extern char sacredSunBatteryHndlPhase;
extern char liBatteryInBuff[300];
extern char sacredSunRequestPhase;
extern short sacredSunSilentCnt;

void sacred_san_bat_hndl(void);
short ascii2halFhex(char in);
#line 40 "main.c"
#line 1 "ztt.h"

extern char portZTTSunBatteryIsInitiated;
extern char zTTBatteryHndlPhase;
extern char liBatteryInBuff[300];
extern char zTTRequestPhase;
extern short zTTSilentCnt[3];
extern char zTTButteryCnter;
extern char zTTBatteryHndlCmnd;

void ztt_bat_hndl(void);
#line 41 "main.c"
#line 1 "mcp2515.h"


























#line 43 "mcp2515.h"

#line 58 "mcp2515.h"

#line 73 "mcp2515.h"

#line 88 "mcp2515.h"

#line 103 "mcp2515.h"

#line 118 "mcp2515.h"

#line 133 "mcp2515.h"

#line 148 "mcp2515.h"

extern char mcp2515_can_st,mcp2515_can_st_old;
extern char MCP2515_RXBUFF[40];
extern char bMCP2515_IN;
extern char mcp2515_out_buff[8][8];
extern char mcp2515_buff_wr_ptr;
extern char mcp2515_buff_rd_ptr;



void mcp2515_reset(void);

char mcp2515_write(char addr,char in);

char mcp2515_read(char addr);

void mcp2515_bit_modify(char addr,char mask,char data);

char mcp2515_read_status(void);

void mcp2515_rts(char in);

void can_mcp2515_init(void);

void can_mcp2515_hndl(void);

#line 42 "main.c"

#line 1 "modbus_tcp.h"

extern char plazma_modbus_tcp[20];

U16 tcp_callback (U8 soc, U8 evt, U8 *ptr, U16 par);

extern char modbus_tcp_func;
extern char modbus_tcp_unit;
extern short modbus_tcp_rx_arg0;
extern short modbus_tcp_rx_arg1;



extern char* modbus_tcp_out_ptr;

U16 tcp_callback (U8 soc, U8 evt, U8 *ptr, U16 par);

#line 44 "main.c"
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



 
#line 45 "main.c"

extern U8 own_hw_adr[];
extern U8  snmp_Community[];
BOOL tick;
extern LOCALM localm[];





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





BAT_STAT bat[2],bat_ips;
signed short		bat_u_old_cnt;
signed short 		Ib_ips_termokompensat;



MAKB_STAT makb[4];



LAKB_STAT lakb[3];
char lakb_damp[1][42];
char bLAKB_KONF_CH=0;
char bLAKB_KONF_CH_old=0;
char lakb_ison_mass[7];
short lakb_mn_ind_cnt;
char bLAKB_KONF_CH_EN;

short LBAT_STRUKT;
char lakb_error_cnt;		
short numOfPacks,numOfPacks_;
short numOfCells, numOfTemperCells, baseOfData;
short lakb_stat_comm_error;	
short lakbNotErrorNum;		
short lakbKanErrorCnt;		
short lakbKanErrorStat;		




LI_BAT_STAT li_bat;




char can_slot[12][16];




BPS_STAT bps[29];







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
const char sm_mont[13][4]={"   ","янв","фев","мар","апр","май","июн","июл","авг","сен","окт","ноя","дек"}; 
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
const char sm_exit[]={" Выход              "};
const char sm_time[]={" 0%:0^:0& 0</>  /0{ "};







char but;                            
unsigned long but_n,but_s;
char but0_cnt;
char but1_cnt;
char but_onL_temp;



signed char cnt_net_drv;



extern char ptr_can1_tx_wr,ptr_can1_tx_rd;
extern char ptr_can2_tx_wr,ptr_can2_tx_rd;
extern unsigned short rotor_can[6];
extern char RXBUFF[40],TXBUFF[40];







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

#line 491 "main.c"







 

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



extern signed short cntrl_stat;
extern signed short cntrl_stat_old;
extern signed short cntrl_stat_new;
extern signed short Ibmax;




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
char tbatdisable_cmnd=20,tloaddisable_cmnd=22;
short tbatdisable_cnt,tloaddisable_cnt;
#line 605 "main.c"

#line 614 "main.c"

#line 627 "main.c"



enum_avt_stat avt_stat[12],avt_stat_old[12];



char snmp_plazma;


short plazma_but_an;

char bCAN_OFF;


char max_net_slot;



signed long ibat_metr_buff_[2];
short bIBAT_SMKLBR;
char ibat_metr_cnt=0;




#line 664 "main.c"



signed short npn_tz_cnt;
enum_npn_stat npn_stat=npnsON;


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



short rele_av_flags;
short avar_vd_stat;










#line 793 "main.c"


void uartWrite(char c)
{
	while ( !(((LPC_UART0_TypeDef *) ((0x40000000UL) + 0x0C000) )->LSR & (1<<5)) ); 
	if( c == '\n' ) 
	{
		((LPC_UART0_TypeDef *) ((0x40000000UL) + 0x0C000) )->THR = 0x0D;
		while( !(((LPC_UART0_TypeDef *) ((0x40000000UL) + 0x0C000) )->LSR & (1<<5) )); 
		((LPC_UART0_TypeDef *) ((0x40000000UL) + 0x0C000) )->THR = 0x0A;
	}
	else
	{
		((LPC_UART0_TypeDef *) ((0x40000000UL) + 0x0C000) )->THR = c; 
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


static void timer_poll () 
{
if (((SysTick_Type *) ((0xE000E000) + 0x0010))->CTRL & 0x10000) 
     {
     timer_tick ();
     tick = 1;
     }
}


void inv_search(void)
{
char i;

first_inv_slot=8;
for(i=0;i<12;i++)
	{
	if(bps[i]._device==dINV)
		{
		first_inv_slot=i;
		break;

		}
	}
}


signed short abs_pal(signed short in)
{
if(in<0)return -in;
else return in;
}


void init_ETH(void)
{
localm[0].IpAdr[0]=lc640_read_int(0x10+500+200+4);
localm[0].IpAdr[1]=lc640_read_int(0x10+500+200+6);
localm[0].IpAdr[2]=lc640_read_int(0x10+500+200+8);
localm[0].IpAdr[3]=lc640_read_int(0x10+500+200+10);

localm[0].NetMask[0]=lc640_read_int(0x10+500+200+12);
localm[0].NetMask[1]=lc640_read_int(0x10+500+200+14);
localm[0].NetMask[2]=lc640_read_int(0x10+500+200+16);
localm[0].NetMask[3]=lc640_read_int(0x10+500+200+18);

localm[0].DefGW[0]=lc640_read_int(0x10+500+200+64);
localm[0].DefGW[1]=lc640_read_int(0x10+500+200+66);
localm[0].DefGW[2]=lc640_read_int(0x10+500+200+68);
localm[0].DefGW[3]=lc640_read_int(0x10+500+200+70);

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


void def_set(int umax__,int ub0__,int ub20__,int usign__,int imax__,int uob__,int numi,int _uvz)
{
;
lc640_write_int(0x10+100+36,numi);
lc640_write_int(0x10+100+38,0);


lc640_write_int(0x10+100+2,0);
lc640_write_int(0x10+100+86,1);
lc640_write_int(0x10+100+78,60);
lc640_write_int(0x10+100+4,umax__);
lc640_write_int(0x10+100+84,ub20__/2);


lc640_write_int(0x10+100+82,70);
lc640_write_int(0x10+100+10,80);

lc640_write_int(0x10+100+14,usign__);
lc640_write_int(0x10+100+16,187);
lc640_write_int(0x10+100+18,0);
lc640_write_int(0x10+100+20,10);


lc640_write_int(0x10+100+24,imax__);
lc640_write_int(0x10+100+26,(imax__*8)/10);

lc640_write_int(0x10+100+44,apvON);
lc640_write_int(0x10+100+46,apvON);
lc640_write_int(0x10+100+48,1);
lc640_write_int(0x10+100+30,160);
lc640_write_int(0x10+100+32,uob__);
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
}



void def_ips_set(short voltage)
{
if(voltage==24)
	{
	def_set(300,voltage,voltage,22,150,240,7,0);
	}
if(voltage==48)
	{
	def_set(600,voltage,voltage,44,100,480,7,0);
	}
if(voltage==60)
	{
	def_set(750,voltage,voltage,55,100,600,7,0);
	}

if(voltage==220)
	{
	def_set(2450,2366,2315,187,100,2200,2,2346);

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
	def_set(1350,1270,1225,99,20,1220,2,1290);

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


void can_reset_hndl(void)
{
if((lc640_read_int(0x06)<0)||(lc640_read_int(0x06)>2))	lc640_write_int(0x06,0);

can_reset_cnt++;

if((can_reset_cnt>=10)&&(!(avar_stat&0x0001))&&(!bRESET))
	{
	if(lc640_read_int(0x06)<2)
		{
		lc640_write_int(0x06,lc640_read_int(0x06)+1);
		bRESET=1;
		}
	}

if((main_1Hz_cnt>=3600UL)&&(lc640_read_int(0x06)!=0))
	{
	lc640_write_int(0x06,0);
	}

if(((((LPC_CAN_TypeDef *) ((0x40000000UL) + 0x44000) )->GSR)>>24)==127)bRESET=1;
if((((((LPC_CAN_TypeDef *) ((0x40000000UL) + 0x44000) )->GSR)>>16)&0x00ff)==127)bRESET=1;

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



		if(cntrl_stat==2000) mcp2515_transmit(cnt_net_drv,cnt_net_drv,0xED,bps[cnt_net_drv]._flags_tu,*((char*)(&UOUT)),*((char*)((&UOUT))+1),(char)(cntrl_stat),(char)((cntrl_stat)>>8) );

		else mcp2515_transmit(cnt_net_drv,cnt_net_drv,0xED,bps[cnt_net_drv]._flags_tu,*((char*)(&UOUT)),*((char*)((&UOUT))+1),(char)(cntrl_stat+bps[cnt_net_drv]._x_),(char)((cntrl_stat+bps[cnt_net_drv]._x_)>>8) );

     	}
	if(cnt_net_drv<=max_net_slot)
	     {
	     if(bps[cnt_net_drv]._cnt<60)
   	 		{    
   	 		bps[cnt_net_drv]._cnt++;
   	 		if( (bps[cnt_net_drv]._cnt>=60) && (!net_av) && (!(bps[cnt_net_drv]._av&0x08)) && (cnt_net_drv<NUMIST) ) 
   	 			{
   	 			avar_bps_hndl(cnt_net_drv,3,1);
   	 			}
   	 		}
		else bps[cnt_net_drv]._cnt=60;
						
		if((bps[cnt_net_drv]._cnt>=3)&&(bps[cnt_net_drv]._cnt_old<3))bps[cnt_net_drv]._cnt_more2++;
		bps[cnt_net_drv]._cnt_old=bps[cnt_net_drv]._cnt;
	     }
	}

else if(cnt_net_drv==-1)
	{
     if(!bCAN_OFF)mcp2515_transmit(0xff,0xff,0x62,*((char*)(&UMAX)),*((char*)((&UMAX))+1),*((char*)(&DU)),*((char*)((&DU))+1),0);
     } 
     
else if(cnt_net_drv==-2)
	{
	
     if(!bCAN_OFF)mcp2515_transmit(0xff,0xff,0x26,*((char*)(&UAVT)),*((char*)((&UAVT))+1),(char)(TMAX),(char)(TSIGN),(char)TZAS);
     byps._cnt++;
	} 
else if(cnt_net_drv==-3)
	{                 
	if(!bCAN_OFF) mcp2515_transmit(0x1d,0x1d,0,0,0,0,0,0);
	ibat_metr_cnt++;
	}
	
	

	
     
     


}




void net_drv_mcp2515(void)
{ 




max_net_slot=20+20;



if(++cnt_net_drv>max_net_slot) 
	{
	cnt_net_drv=0;
	
	
	if(bCAN_INV)bCAN_INV=0;
	else bCAN_INV=1;

	} 



if(cnt_net_drv<=17) 

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
	
	bps[cnt_net_drv]._vol_u=2400;
			   
	if(!bCAN_OFF)mcp2515_transmit(cnt_net_drv,cnt_net_drv,0xED,bps[cnt_net_drv]._flags_tu,0x60 ,0x09 ,*((char*)(&bps[cnt_net_drv]._vol_i)),*((char*)((&bps[cnt_net_drv]._vol_i))+1));
     
	if(cnt_net_drv<=17)
	     {
	     if(bps[cnt_net_drv]._cnt<60)
   	 		{    
   	 		bps[cnt_net_drv]._cnt++;
   	 		if( (bps[cnt_net_drv]._cnt>=60) && (!net_av) && (!(bps[cnt_net_drv]._av&0x08)) && (cnt_net_drv<NUMIST) ) 
   	 			{
   	 			avar_bps_hndl(cnt_net_drv,3,1);
   	 			}
   	 		}
		else bps[cnt_net_drv]._cnt=60;
						
		if((bps[cnt_net_drv]._cnt>=3)&&(bps[cnt_net_drv]._cnt_old<3))bps[cnt_net_drv]._cnt_more2++;
		bps[cnt_net_drv]._cnt_old=bps[cnt_net_drv]._cnt;
	     }
	}





















 	
	

else if(cnt_net_drv==19)
	{
     if(!bCAN_OFF)
		{
		mcp2515_transmit(cnt_net_drv,cnt_net_drv,0xED,BAT_TYPE,NUMBAT,0,0,0);
		lakb[0]._cnt++;
		if(lakb[0]._cnt>20)lakb[0]._cnt=20;
		lakb[1]._cnt++;
		if(lakb[1]._cnt>20)lakb[1]._cnt=20;
		}
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
static char ptr_cnt,ptr_cnt1,ptr_cnt2,ptr_cnt3,ptr_cnt4;

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
const char* sub_ptrs[50];
static char sub_cnt,sub_cnt1;
char i,sub_cnt_max;
char ii_;				  
static char ii_cnt,cnt_ind_bat;


	   
sub_cnt_max=5;
i=0;











 	
if(avar_stat&0x0001)
	{
	sub_ptrs[i++]=		"   Авария сети!!!   ";
	sub_cnt_max++;	
	}












 

if(ips_bat_av_stat)
	{
	sub_ptrs[i++]=	"  Авария батареи    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+0)))
	{
	sub_ptrs[i++]=	"   Авария БПС №1    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+1)))
	{
	sub_ptrs[i++]=	"   Авария БПС №2    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+2)))
	{
	sub_ptrs[i++]=	"   Авария БПС №3    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+3)))
	{
	sub_ptrs[i++]=	"   Авария БПС №4    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+4)))
	{
	sub_ptrs[i++]=	"   Авария БПС №5    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+5)))
	{
	sub_ptrs[i++]=	"   Авария БПС №6    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+6)))
	{
	sub_ptrs[i++]=	"   Авария БПС №7    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+7)))
	{
	sub_ptrs[i++]=	"   Авария БПС №8    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+8)))
	{
	sub_ptrs[i++]=	"   Авария БПС №9    ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+9)))
	{
	sub_ptrs[i++]=	"   Авария БПС №10   ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+10)))
	{
	sub_ptrs[i++]=	"   Авария БПС №11   ";
	sub_cnt_max++;	
	}
if(avar_stat&(1<<(3+11)))
	{
	sub_ptrs[i++]=	"   Авария БПС №12   ";
	sub_cnt_max++;	
	}

if(uout_av)
	{
	sub_ptrs[i++]=	"   Авария Uвых!!!   ";
	sub_cnt_max++;	
	}


if(bps[0]._av&(1<<4))
	{
	sub_ptrs[i++]=	"Ресурс вент. БПС1   ";
	sub_cnt_max++;
	sub_ptrs[i++]=	"     исчерпан       ";
	sub_cnt_max++;		
	}

if(overloadAvar)
	{
	sub_ptrs[i++]=	" Перегрузка по току!";
	sub_cnt_max++;	
	}

if(sysTAvar)
	{
	sub_ptrs[i++]=	" Перегрев системы!  ";
	sub_cnt_max++;	
	}

if(uOutAvar==1)
	{
	sub_ptrs[i++]=	"   Завышено Uвых.!  ";
	sub_cnt_max++;	
	}

if(uOutAvar==2)
	{
	sub_ptrs[i++]=	"   Занижено Uвых.!  ";
	sub_cnt_max++;	
	}

if(uInAvar==1)
	{
	sub_ptrs[i++]=	"   Завышено Uвх.!   ";
	sub_cnt_max++;	
	}

if(uInAvar==2)
	{
	sub_ptrs[i++]=	"   Занижено Uвх.!   ";
	sub_cnt_max++;	
	}

cnt_of_slave=NUMIST+NUMINV;




 

  


sub_cnt1++;	
if(sub_cnt1>=20)
	{
	sub_cnt1=0;
	sub_cnt++;
	if(sub_cnt>=sub_cnt_max)
		{
		sub_cnt=0;
		}
	}






else if(a_ind . i==iMn_VD)
	{
	ptrs[0]	=	"                    ";

	ptrs[0]	=	"  В работе    rист. ";


	 
    i=0;
 	
	ptrs[1]=			"Uвх.    ]В Uв.д.  @В";	
	ptrs[2]=			"Uвых.   #В Iвых.  $А";
    ptrs[3]=			" 0%:0^:0& 0</>  /0{ ";
	ptrs[4]=			"   Tсистемы    ?°C  ";
								
	ptrs[5]=  			" БПС N1             ";
    ptrs[6]=  			" БПС N2             ";
    ptrs[7]=  			" БПС N3             ";
    ptrs[8]=  			" БПС N4             ";
    ptrs[9]= 			" БПС N5             ";
    ptrs[10]= 			" БПС N6             ";
    ptrs[11]= 			" БПС N7             ";
    ptrs[12]= 			" БПС N8             ";
    ptrs[13]= 			" БПС N9             ";
    ptrs[14]= 			" БПС N10            ";
	ptrs[15]=  			" БПС N11            ";
    ptrs[16]=  			" БПС N12            ";
    ptrs[17]=  			" БПС N13            ";
    ptrs[18]=  			" БПС N14            ";
    ptrs[19]= 			" БПС N15            ";
    ptrs[20]= 			" БПС N16            ";
    ptrs[21]= 			" БПС N17            ";
    ptrs[22]= 			" БПС N18            ";
    ptrs[23]= 			" БПС N19            ";
    ptrs[24]= 			" БПС N20            ";
 	ptrs[25]=  			" БПС N21            ";
    ptrs[26]=  			" БПС N22            ";
    ptrs[27]=  			" БПС N23            ";
    ptrs[28]=  			" БПС N24            ";
    ptrs[29]= 			" БПС N25            ";
    ptrs[30]= 			" БПС N26            ";
    ptrs[31]= 			" БПС N27            ";
    ptrs[32]= 			" БПС N28            ";
    ptrs[33]= 			" БПС N29            ";
    ptrs[34]= 			" БПС N30            ";
    ptrs[35]= 			" БПС N31            ";
    ptrs[36]= 			" БПС N32            ";
	
	ptrs[5+NUMIST]=		" Таблица источников ";
	ptrs[6+NUMIST]= 	" Установки          "; 
    ptrs[7+NUMIST]= 	" Журнал событий     ";
	ptrs[8+NUMIST]= 	" Выход              ";
	ptrs[9+NUMIST]=	" Тест               ";
	

    if(a_ind . s_i==0)a_ind . i_s=0;
	else if((a_ind . i_s-a_ind . s_i)>2)a_ind . i_s=a_ind . s_i+2;
	else if(a_ind . s_i>a_ind . i_s)a_ind . i_s=a_ind . s_i;
	
	if(sub_cnt<5)bgnd_par(ptrs[0],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2],ptrs[a_ind . i_s+3]);
	else bgnd_par(sub_ptrs[sub_cnt-5],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2],ptrs[a_ind . i_s+3]);
	
	if((ii_cnt<=80)||((spc_stat!=spcVZ)&&(spc_stat!=spcKE))) 
		{
	

		
		if((sub_cnt<5) )int2lcdyx(num_of_wrks_bps,0,14,0);

          
     	}


		
		
 		
	
	
		
		
 		
		






 
 	
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

	if((a_ind . i_s)&&(a_ind . s_i>1))
	     {
	     if(a_ind . i_s==a_ind . s_i)lcd_buffer[60]=1;
	     else if((a_ind . i_s-a_ind . s_i)==1)lcd_buffer[40]=1;
	     else if((a_ind . i_s-a_ind . s_i)==2)lcd_buffer[20]=1;
	     }	
		
	
	
	   
	
		
		
		if(bIBAT_SMKLBR)sub_bgnd("КЛБР. ",'$',-3);
		else  int2lcd_mmm(Ib_ips_termokompensat,'$',0);
		
		int2lcd_mmm(t_ext[0],'?',0);
		
	
	
		
		
		
		
			
			
			
			
			
		
			
			
			
		
		

	int2lcd(out_U/10,'#',0);
	int2lcd(sys_T,'#',0);
	int2lcd(vd_U/10,'@',0);
	int2lcd(in_U/10,']',0);
	
	

	

	

	
	
	
	

	
	}



else if(a_ind . i==iMakb)
	{
	const char* ptr[12];
 
	simax=10;

	ptr[0]=			" Uб1    =     @В    ";
	ptr[1]=			" Uб2    =     #В    ";
	ptr[2]=			" Uб3    =     $В    ";
	ptr[3]=			" Uб4    =     %В    ";
	ptr[4]=			" Uб5    =     ^В    ";
	ptr[5]=			" tб1    =     &°С   ";
	ptr[6]=			" tб2    =     *°С   ";
	ptr[7]=			" tб3    =     (°С   ";
	ptr[8]=			" tб4    =     )°С   ";
	ptr[9]=			" tб5    =     +°С   ";
	ptr[10]=			sm_exit;

 	if(makb[a_ind . s_i1]._cnt>=5)
	 	{
		bgnd_par(		"   МОНИТОР АКБ N<   ",
					"   НЕ ПОДКЛЮЧЕН!!!  ",
					"                    ",
					"                    ");
		}


	else 
		{
		bgnd_par(		"   МОНИТОР АКБ N<   ",
					ptr[a_ind . i_s],
					ptr[a_ind . i_s+1],
					ptr[a_ind . i_s+2]);

		if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
		else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;

		if(a_ind . s_i>=simax)	pointer_set(1);
		
		int2lcd(makb[a_ind . s_i1]._Ub[0],'@',1);
		int2lcd(makb[a_ind . s_i1]._Ub[1],'#',1);
		int2lcd(makb[a_ind . s_i1]._Ub[2],'$',1);
		int2lcd(makb[a_ind . s_i1]._Ub[3],'%',1);
		int2lcd(makb[a_ind . s_i1]._Ub[4],'^',1);
		if(makb[a_ind . s_i1]._T_nd[0])sub_bgnd("НЕПОДКЛЮЧЕН",'&',-5);
		else int2lcd_mmm(makb[a_ind . s_i1]._T[0],'&',0); 
 		if(makb[a_ind . s_i1]._T_nd[1])sub_bgnd("НЕПОДКЛЮЧЕН",'*',-5);
		else int2lcd_mmm(makb[a_ind . s_i1]._T[1],'*',0); 
		if(makb[a_ind . s_i1]._T_nd[2])sub_bgnd("НЕПОДКЛЮЧЕН",'(',-5);
		else int2lcd_mmm(makb[a_ind . s_i1]._T[2],'(',0); 
		if(makb[a_ind . s_i1]._T_nd[3])sub_bgnd("НЕПОДКЛЮЧЕН",')',-5);
		else int2lcd_mmm(makb[a_ind . s_i1]._T[3],')',0); 
		if(makb[a_ind . s_i1]._T_nd[4])sub_bgnd("НЕПОДКЛЮЧЕН",'+',-5);
		else int2lcd_mmm(makb[a_ind . s_i1]._T[4],'+',0); 
		}
	int2lcd(a_ind . s_i1+1,'<',0);
    }

 else if(a_ind . i==iBps)
	{
	const char* ptr[8];
 
	simax=5;

	ptr[1]=			" Uист =        (В   ";
	ptr[2]=			" Iист =        [A   ";
	ptr[3]=			" tист =        ]°С  ";
	ptr[4]=			" Сброс аварий       ";
	ptr[5]=			sm_exit;

	if(bps[a_ind . s_i1]._state==bsWRK)
		{
		ptr[0]=		"      в работе      ";
		if((bps[a_ind . s_i1]._flags_tm&0x08)&&(bFL2))
		ptr[0]=		"  СИЛЬНЫЙ НАГРЕВ!!! ";	      
		}
 	 else if(bps[a_ind . s_i1]._state==bsRDY)
	 	{
		ptr[0]=		"      в резерве     ";	
		}

 	 else if(bps[a_ind . s_i1]._state==bsBL)
	 	{
		ptr[0]=		" заблокирован извне ";	
		}

	 else if(bps[a_ind . s_i1]._state==bsAPV)
	 	{
		ptr[0]=		"    Работает АПВ    ";
		}
	 
	 else if(bps[a_ind . s_i1]._state==bsAV)
	 	{
		if(bps[a_ind . s_i1]._av&(1<<0))
		ptr[0]=		" Авария - перегрев! ";
		else if(bps[a_ind . s_i1]._av&(1<<1))
		ptr[0]=		"Авария - завыш.Uвых!";
		else if(bps[a_ind . s_i1]._av&(1<<2))	 
		ptr[0]=		"Авария - заниж.Uвых!";
		else if(bps[a_ind . s_i1]._av&(1<<3))
			{
			ptr[0]=	"  Авария - потеряна ";
			ptr[1]=	"      связь!!!      ";
			ptr[2]=	"                    ";
			simax=0;
			}
		}

	 else if(bps[a_ind . s_i1]._state==bsOFF_AV_NET)
	 	{
		ptr[0]=		"      ВЫКЛЮЧЕН      ";
		ptr[1]=		"     Отсутствует    ";
		ptr[2]=		" первичное питание! ";
		simax=0;
		}

	bgnd_par(			"       БПС N&       ",
					ptr[a_ind . i_s],
					ptr[a_ind . i_s+1],
					ptr[a_ind . i_s+2]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;

	if(a_ind . s_i>=4)	pointer_set(1);


		

	int2lcd(a_ind . s_i1+1,'&',0);
	int2lcd(bps[a_ind . s_i1]._Uii,'(',1);
     int2lcd(bps[a_ind . s_i1]._Ii,'[',1);  
   	int2lcd_mmm(bps[a_ind . s_i1]._Ti,']',0); 
   			 
    
    
    

	
	
     }
 else if(a_ind . i==iBps_elteh)
	{
	const char* ptr[11];
 
	simax=9;

	ptr[1]=			" Uист.=        (В   ";
	ptr[2]=			" Uвых.=        )В   ";
	ptr[3]=			" Iист.=        [A   ";
	ptr[4]=			" tист.=        ]°С  ";
	ptr[5]=			" Наработка          ";
	ptr[6]=			" вентилятора      >ч";
	ptr[7]=			" Сброс аварий       ";
	ptr[8]=			sm_exit;
 	ptr[9]=			" Сброс наработки    ";

	if(bps[a_ind . s_i1]._state==bsWRK)
		{
		ptr[0]=		"      в работе      ";
		if((bps[a_ind . s_i1]._flags_tm&0x08)&&(bFL2))
		ptr[0]=		"  СИЛЬНЫЙ НАГРЕВ!!! ";	      
		}
 	 else if(bps[a_ind . s_i1]._state==bsRDY)
	 	{
		ptr[0]=		"      в резерве     ";	
		}

 	 else if(bps[a_ind . s_i1]._state==bsBL)
	 	{
		ptr[0]=		" заблокирован извне ";	
		}

	 else if(bps[a_ind . s_i1]._state==bsAPV)
	 	{
		ptr[0]=		"    Работает АПВ    ";
		}
	 
	 else if(bps[a_ind . s_i1]._state==bsAV)
	 	{
		if(bps[a_ind . s_i1]._av&(1<<0))
		ptr[0]=		" Авария - перегрев! ";
		else if(bps[a_ind . s_i1]._av&(1<<1))
		ptr[0]=		"Авария - завыш.Uвых!";
		else if(bps[a_ind . s_i1]._av&(1<<2))	 
		ptr[0]=		"Авария - заниж.Uвых!";
		else if(bps[a_ind . s_i1]._av&(1<<3))
			{
			ptr[0]=	"  Авария - потеряна ";
			ptr[1]=	"      связь!!!      ";
			ptr[2]=	"                    ";
			simax=0;
			}
		}

	 else if(bps[a_ind . s_i1]._state==bsOFF_AV_NET)
	 	{
		ptr[0]=		"      ВЫКЛЮЧЕН      ";
		ptr[1]=		"     Отсутствует    ";
		ptr[2]=		" первичное питание! ";
		simax=0;
		}

	bgnd_par(			" \       БПС N&       ",
					ptr[a_ind . i_s],
					ptr[a_ind . i_s+1],
					ptr[a_ind . i_s+2]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;

	if(a_ind . s_i>=7)	pointer_set(1);


		

	int2lcd(a_ind . s_i1+1,'&',0);
	int2lcd(bps[a_ind . s_i1]._Uii,'(',1);
	int2lcd(bps[a_ind . s_i1]._Uisum,')',1);
    int2lcd(bps[a_ind . s_i1]._Ii,'[',1);  
   	int2lcd_mmm(bps[a_ind . s_i1]._Ti,']',0); 
	int2lcd(bps[a_ind . s_i1]._vent_resurs,'>',0);
   			 
    
    
   	
	
	
	
	
	
	
	
	
    }  	   
	 	  
else if(a_ind . i==iNet)
	{
	bgnd_par(		"        СЕТЬ        ",
				" U   =     [В       ",
				" f   =     ]Гц      ",
				sm_exit);
	lcd_buffer[60]=1;
	     	
     int2lcd(net_U,'[',0);
     int2lcd(net_F,']',1);

 



                  	      	   	    		
     }

else if(a_ind . i==iNet3)
	{


	ptrs[0]=  		" UфA           !В   ";
    ptrs[1]=  		" UфB           @В   ";
    ptrs[2]=  	    " UфC           #В   ";
	ptrs[3]=  	    " f   =     ]Гц      ";           
	ptrs[4]=  		" Выход              ";


	bgnd_par(		"        СЕТЬ        ",
					ptrs[a_ind . i_s],
					ptrs[a_ind . i_s+1],
					ptrs[a_ind . i_s+2]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

    int2lcd(net_Ua,'!',0);
	int2lcd(net_Ub,'@',0);
	int2lcd(net_Uc,'#',0);



    int2lcd(net_F,']',1);


 



                  	      	   	    		
     }

else if(a_ind . i==iNetEM)
	{


	ptrs[0]=  		" U             [В   ";
    	ptrs[1]=  		" f             ]Гц  ";
    	ptrs[2]=  	    	" Pтекущ.       #Вт  ";
	ptrs[3]=  	    	" Pсумм.        $кВтч";           
	ptrs[4]=  		" Выход              ";


	bgnd_par(		"        СЕТЬ        ",
					ptrs[a_ind . i_s],
					ptrs[a_ind . i_s+1],
					ptrs[a_ind . i_s+2]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

     int2lcd(net_U,'[',0);
     int2lcd(net_F,']',1);
     long2lcd_mmm(power_summary/10,'$',1);
     int2lcd(power_current,'#',0);

 




                  	      	   	    		
     }


else if(a_ind . i==iLoad)
	{
	bgnd_par(		"      НАГРУЗКА      ",
				" Uнагр =     [В     ",
				" Iнагр =     ]А     ",
				sm_exit);
	lcd_buffer[60]=1;
	     	
     int2lcd(load_U,'[',1);
     int2lcd(load_I,']',1);

     
                   	      	   	    		
     }

else if(a_ind . i==iVent)
	{

	ptrs[0]=  		" Fвент.текущ.     !%";
     ptrs[1]=  		" Fвент.max. (  @%) #";
	ptrs[2]=  	     " Выход              ";

	bgnd_par(			"     ВЕНТИЛЯТОР     ",
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
     ptrs[0]=  		"  АВТОМАТЫ НАГРУЗОК ";
	ptrs[1]=  		" Автомат №1       ! ";
	ptrs[2]=  		" Автомат №2       @ ";
	ptrs[3]=  		" Автомат №3       # ";
	ptrs[4]=  		" Автомат №4       $ ";
	ptrs[5]=  		" Автомат №5       % ";
	ptrs[6]=  		" Автомат №6       ^ ";
	ptrs[7]=  		" Автомат №7       & ";
	ptrs[8]=  		" Автомат №8       * ";
	ptrs[9]=  		" Автомат №9       ( ";
	ptrs[10]=  		" Автомат №10      ) ";
	ptrs[11]=  		" Автомат №11      + ";
	ptrs[12]=  		" Автомат №12      = ";

	ptrs[1+NUMAVT]=  	" Выход              ";
	ptrs[2+NUMAVT]=  	"                    ";
	ptrs[3+NUMAVT]=  	"                    ";

	bgnd_par(		ptrs[0],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2],
				ptrs[a_ind . i_s+3]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

	

	if(avt_stat[0]==avtON)	sub_bgnd("ВКЛ.",'!',-3);
	else 				sub_bgnd("ВЫКЛ.",'!',-4);
	if(avt_stat[1]==avtON)	sub_bgnd("ВКЛ.",'@',-3);
	else 				sub_bgnd("ВЫКЛ.",'@',-4);
	if(avt_stat[2]==avtON)	sub_bgnd("ВКЛ.",'#',-3);
	else 				sub_bgnd("ВЫКЛ.",'#',-4);
	if(avt_stat[3]==avtON)	sub_bgnd("ВКЛ.",'$',-3);
	else 				sub_bgnd("ВЫКЛ.",'$',-4);
	if(avt_stat[4]==avtON)	sub_bgnd("ВКЛ.",'%',-3);
	else 				sub_bgnd("ВЫКЛ.",'%',-4);
	if(avt_stat[5]==avtON)	sub_bgnd("ВКЛ.",'^',-3);
	else 				sub_bgnd("ВЫКЛ.",'^',-4);
	if(avt_stat[6]==avtON)	sub_bgnd("ВКЛ.",'&',-3);
	else 				sub_bgnd("ВЫКЛ.",'&',-4);
	if(avt_stat[7]==avtON)	sub_bgnd("ВКЛ.",'*',-3);
	else 				sub_bgnd("ВЫКЛ.",'*',-4);
	if(avt_stat[8]==avtON)	sub_bgnd("ВКЛ.",'(',-3);
	else 				sub_bgnd("ВЫКЛ.",'(',-4);
	if(avt_stat[9]==avtON)	sub_bgnd("ВКЛ.",')',-3);
	else 				sub_bgnd("ВЫКЛ.",')',-4);
	if(avt_stat[10]==avtON)	sub_bgnd("ВКЛ.",'+',-3);
	else 				sub_bgnd("ВЫКЛ.",'+',-4); 
	if(avt_stat[11]==avtON)	sub_bgnd("ВКЛ.",'=',-3);
	else 				sub_bgnd("ВЫКЛ.",'=',-4);
     
     

     
     

     
     
     
     }

else if(a_ind . i==iEnerg)
	{
     ptrs[0]=  		"  ЭЛЕКТРОСНАБЖЕНИЕ  ";

     ptrs[1]=  		" Ввод       #В      ";
     ptrs[2]=  	     " ПЭС        $В      ";            
     ptrs[3]=  	     " Pсумм.       %кВт*ч";
	ptrs[4]=  	     " Pтекущ.      ^Вт   ";
	ptrs[5]=  	     " Выход              ";
	ptrs[6]=  	     "                    ";
	ptrs[7]=  	     "                    ";

	bgnd_par(		ptrs[0],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2],
				ptrs[a_ind . i_s+3]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

	int2lcd(Uvv0,'#',0);
     int2lcd(Uvv[1],'$',0);
     

     long2lcd_mmm(power_summary,'%',2);
     int2lcd(power_current,'^',0);

     
     
     
     }

else if(a_ind . i==iEnerg3)
	{
     ptrs[0]=  		"  ЭЛЕКТРОСНАБЖЕНИЕ  ";

     ptrs[1]=  		" Ввод ф.A    !В     ";
	ptrs[2]=  		" Ввод ф.B    @В     ";
	ptrs[3]=  		" Ввод ф.C    #В     ";
     ptrs[4]=  	     " ПЭС  ф.A    &В     ";
     ptrs[5]=  	     " ПЭС  ф.B    )В     ";
     ptrs[6]=  	     " ПЭС  ф.C    (В     ";		            
     ptrs[7]=  	     " Pсумм.       %кВт*ч";
	ptrs[8]=  	     " Pтекущ.      ^Вт   ";
	ptrs[9]=  	     " Выход              ";
	ptrs[10]=  	     "                    ";
	ptrs[11]=  	     "                    ";

	bgnd_par(		ptrs[0],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2],
				ptrs[a_ind . i_s+3]);

	if(a_ind . s_i-a_ind . i_s>2)a_ind . i_s=a_ind . s_i-2;
	else if (a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	pointer_set(1);

	int2lcd(Uvv_eb2[0],'!',0);
	int2lcd(Uvv_eb2[1],'@',0);
	int2lcd(Uvv_eb2[2],'#',0);
	int2lcd(Upes_eb2[0],'&',0);
	int2lcd(Upes_eb2[1],')',0);
	int2lcd(Upes_eb2[2],'(',0);
     long2lcd_mmm(power_summary,'%',3);
     int2lcd(power_current,'^',0);

     }

else if(a_ind . i==iSpc)
	{

 	ptrs[0]=	" Выр.заряд          ";
 	ptrs[1]=	" Авт.выр.заряд      ";
 	ptrs[2]=	" К.Е. батареи N1    ";
 	ptrs[3]=	" К.Е. батареи N2    ";
 
 
 	ptrs[4]=	" Выход              ";
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
    	bgnd_par( "     СПЕЦФУНКЦИИ    ",
    	          ptrs[a_ind . i_s],
    	          ptrs[a_ind . i_s+1],
    	          ptrs[a_ind . i_s+2]);
	pointer_set(1);
	}    		

else if(a_ind . i==iSpc_termocompensat)
	{
 	ptrs[0]=	" Выр.заряд          ";
 	ptrs[1]=	" Авт.выр.заряд      ";
 	ptrs[2]=	" К.Е. батареи       ";
 	ptrs[3]=	" Выход              ";
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
    	bgnd_par( "     СПЕЦФУНКЦИИ    ",
    	          ptrs[a_ind . i_s],
    	          ptrs[a_ind . i_s+1],
    	          ptrs[a_ind . i_s+2]);
	pointer_set(1);
	}    		

else if(a_ind . i==iLog)
	{
	


	av_j_si_max=lc640_read_int(1024+1024+512+1024+2);
	if(av_j_si_max>64)av_j_si_max=0;

	if(av_j_si_max==0)
		{
		bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," Журнал пуст        ",sm_exit,sm_);
		
		a_ind . s_i=1;
		a_ind . i_s=0;
		}       
		
	else if(av_j_si_max==1)
		{
		bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," (                  ",sm_exit," Очистить журнал    ");
		
		
		
		a_ind . i_s=0;
		}

	else if(av_j_si_max==2)
		{
		if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
		else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;		
		if(a_ind . i_s==0) bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," (                  "," [                  ",sm_exit);
		else if(a_ind . i_s==1) bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," (                  ",sm_exit," Очистить журнал    ");
		
		
		
		
		}
		
	else if(av_j_si_max>2)
		{
		if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
		else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;  
		if(a_ind . i_s==(av_j_si_max-1)) bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," (                  ",sm_exit," Очистить журнал    ");
		else if(a_ind . i_s==(av_j_si_max-2)) bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," (                  "," [                  ",sm_exit);
		else bgnd_par("   ЖУРНАЛ СОБЫТИЙ   "," (                  "," [                  "," {                  ");
		
		
		
		

		}
	pointer_set(1);
     event2ind(a_ind . i_s,'(');
     event2ind(a_ind . i_s+1,'[');	
     event2ind(a_ind . i_s+2,'{');	  
    
	}



else if(a_ind . i==iLog_)
	{	
	unsigned short tempUI ;

	char av_head[4],av_data_on[8],av_data_off[8],av_data[4];
	short av_head_int[2];
	
	bgnd_par(sm_,sm_,sm_,sm_);
	tempUI=lc640_read_int(1024+1024+512+1024);
	tempUI=ptr_carry(tempUI,64,-1*((signed)a_ind . s_i1));
	tempUI*=32;
	tempUI+=1024;
     
     lc640_read_long_ptr(tempUI,av_head);
     lc640_read_long_ptr(tempUI+4,(char*)av_head_int);
     lc640_read_long_ptr(tempUI+8,av_data_on);
     lc640_read_long_ptr(tempUI+12,&(av_data_on[4])); 
     lc640_read_long_ptr(tempUI+16,av_data_off);
     lc640_read_long_ptr(tempUI+20,&(av_data_off[4]));      
	lc640_read_long_ptr(tempUI+24,av_data);
	
	


	if((av_head[0]=='U')&&(av_head[2]=='R'))
		{
		if(a_ind . i_s==0) {
		
		bgnd_par(	"    Перезагрузка    ",
				"   или включение    ",
				"       системы      ",
				"  0%(  0^ 0@:0#:0$  ");
		} else if(a_ind . i_s==1) {

		bgnd_par(	"    Перезагрузка    ",
				"   или включение    ",
				"       системы      ",
				"  код источника  [  ");		
		
		} else if(a_ind . i_s==2) {

		bgnd_par(	"    Перезагрузка    ",
				"   или включение    ",
				"       системы      ",
				"                 ]  ");		
		
		}					
				  	
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		int2lcd(av_data_on[7],'[',0);
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		
		if(av_data_on[7]&0x08)sub_bgnd("superwiser  ",']',-12);
		else if(av_data_on[7]&0x04)sub_bgnd("watchdog      ",']',-12);
		else if(av_data_on[7]&0x02)sub_bgnd("ext.reset    ",']',-12);
		else if(av_data_on[7]&0x01)sub_bgnd("power on     ",']',-12);
		av_j_si_max=2;

		
		}

	else if((av_head[0]=='P')&&(av_head[2]=='A'))
		{  
		ptrs[0]="   Авария сети!!!   ";
		ptrs[1]="  0%(  0^ 0@:0#:0$  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[2]="    не устранена    ";
			ptrs[3]="     Uсети=  +В     ";
			bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
			int2lcd(net_U,'+',0);
			}
		else 
			{
			gran_char(&a_ind . i_s,0,1);
			ptrs[2]="      устранена     ";
			ptrs[3]="  0[]  0< 0>:0=:0)  ";
			ptrs[4]="     Uмин=  +В      ";
			bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
			int2lcd(av_data_off[4],'>',0);
			int2lcd(av_data_off[5],'=',0);
			int2lcd(av_data_off[6],')',0);
			int2lcd(av_data_off[2],'[',0);
			int2lcd(av_data_off[0],'<',0); 
			if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
			sub_bgnd(sm_mont[av_data_off[1]],']',0);
			
			int2lcd(av_data[0]+(av_data[1]*256),'+',0);			
			}	
		
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		av_j_si_max=1;
		}

	else if((av_head[0]=='B')&&(av_head[2]=='C'))
		{  
		ptrs[0]="       Авария       ";
		ptrs[1]="     батареи N+     ";
		ptrs[2]="  0%(  0^ 0@:0#:0$  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[3]="    не устранена    ";
			bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
			}
		else 
			{
			gran_char(&a_ind . i_s,0,1);
			ptrs[3]="      устранена     ";
			ptrs[4]="  0[]  0< 0>:0=:0)  ";
			bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
			int2lcd(av_data_off[4],'>',0);
			int2lcd(av_data_off[5],'=',0);
			int2lcd(av_data_off[6],')',0);
			int2lcd(av_data_off[2],'[',0);
			int2lcd(av_data_off[0],'<',0); 
			if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
			sub_bgnd(sm_mont[av_data_off[1]],']',0);
			
						
			}	
		int2lcd(av_head[1]+1,'+',0);
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		av_j_si_max=1;
		}

	else if((av_head[0]=='B')&&(av_head[2]=='S'))
		{  
		ptrs[0]="       Авария       ";
		ptrs[1]="    несимметрии     ";
		ptrs[2]="     батареи N+     ";
		ptrs[3]="  0%(  0^ 0@:0#:0$  ";
		bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
		int2lcd(av_head[1]+1,'+',0);
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		av_j_si_max=0;
		}

	else if((av_head[0]=='B')&&(av_head[2]=='Z'))
		{  
		ptrs[0]="   Выравнивающий    ";
		ptrs[1]="       заряд        ";
		ptrs[2]="  0%(  0^ 0@:0#:0$  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[3]="    не завершен     ";
			bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
			}
		else 
			{
			gran_char(&a_ind . i_s,0,1);
			ptrs[3]="      завершен      ";
			ptrs[4]="  0[]  0< 0>:0=:0)  ";
			bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
			int2lcd(av_data_off[4],'>',0);
			int2lcd(av_data_off[5],'=',0);
			int2lcd(av_data_off[6],')',0);
			int2lcd(av_data_off[2],'[',0);
			int2lcd(av_data_off[0],'<',0); 
			if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
			sub_bgnd(sm_mont[av_data_off[1]],']',0);
			
						
			}	
		int2lcd(av_head[1]+1,'+',0);
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		av_j_si_max=1;
		}



	else if((av_head[0]=='B')&&(av_head[2]=='W'))
		{  
		ptrs[0]="       Разряд       ";
		ptrs[1]="     батареи N!     ";
		ptrs[2]="   Начало           ";
		ptrs[3]="  0%(  0^ 0@:0#:0$  ";
		ptrs[4]="       Uбат=  <В";
		ptrs[5]="   Конец            ";
		ptrs[6]="  0qw  0r 0i:0l:0s  ";
		ptrs[7]="         Uбат=  >В  ";
		ptrs[8]="   Отдано    /а*ч.  ";
		
		bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
		
		int2lcd(av_head[1]+1,'!',0);

		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
				
		int2lcd(av_data_off[4],'i',0);
		int2lcd(av_data_off[5],'l',0);
		int2lcd(av_data_off[6],'s',0);
		int2lcd(av_data_off[2],'q',0);
		int2lcd(av_data_off[0],'r',0); 
		if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
		sub_bgnd(sm_mont[av_data_off[1]],'w',0);
		
		
		int2lcd(av_head_int[0]/10,'/',1);
		int2lcd(av_data_on[3]+(av_data_on[7]*256),'<',1);
		int2lcd(av_head_int[1],'>',1);	
		av_j_si_max=5;				

		
		}

	else if((av_head[0]=='B')&&(av_head[2]=='K'))
		{  
		ptrs[0]="  Контроль емкости  ";
		ptrs[1]="       батареи      ";
		ptrs[2]="   Начало           ";
		ptrs[3]="  0%(  0^ 0@:0#:0$  ";
		ptrs[4]="         Uбат=  <В  ";
		ptrs[5]="   Конец            ";
		ptrs[6]="  0qw  0r 0i:0l:0s  ";
		ptrs[7]="         Uбат=  >В  ";
		ptrs[8]="   Ёмкость   /а*ч.  ";
		
		bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
		
		int2lcd(av_head[1]+1,'!',0);

		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
				
		int2lcd(av_data_off[4],'i',0);
		int2lcd(av_data_off[5],'l',0);
		int2lcd(av_data_off[6],'s',0);
		int2lcd(av_data_off[2],'q',0);
		int2lcd(av_data_off[0],'r',0); 
		if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
		sub_bgnd(sm_mont[av_data_off[1]],'w',0);
		
		
		int2lcd(av_head_int[0],'/',1);
		int2lcd(av_data_on[3]+(av_data_on[7]*256),'<',1);
		int2lcd(av_head_int[1],'>',1);	
		av_j_si_max=5;				

		
		}



	else if((av_head[0]=='S')||(av_head[0]=='I'))
		{  
		ptrs[0]="   Авария БПС N+    ";
		
		if(av_head[2]=='L')
			{
			ptrs[1]="     отключился     ";
			}
		else if(av_head[2]=='T')
			{
			ptrs[1]="      перегрев      ";
			}		
		else if(av_head[2]=='U')
			{
			ptrs[1]="   завышено Uвых.   ";
			}		
		else if(av_head[2]=='u')
			{
			ptrs[1]="   занижено Uвых.   ";
			}								
		else if(av_head[2]=='O')
			{
			ptrs[1]="    завышено Iвых   ";
			}		
		
		ptrs[2]="  0%(  0^ 0@:0#:0$  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[3]="    не устранена    ";
			bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
			}
		else 
			{
			gran_char(&a_ind . i_s,0,1);
			ptrs[3]="      устранена     ";
			ptrs[4]="  0[]  0< 0>:0=:0)  ";
			bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
			int2lcd(av_data_off[4],'>',0);
			int2lcd(av_data_off[5],'=',0);
			int2lcd(av_data_off[6],')',0);
			int2lcd(av_data_off[2],'[',0);
			int2lcd(av_data_off[0],'<',0); 
			if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
			sub_bgnd(sm_mont[av_data_off[1]],']',0);
			
						
			}	
		int2lcd(av_head[1]+1,'+',0);
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		}

	else if((av_head[0]=='V')&&(av_head[1]=='I')&&(av_head[2]=='N'))
		{
		av_j_si_max=4;  
		ptrs[0]=" Авария входного    ";
		ptrs[1]=" напряжения (заниж.)";
		if(av_head_int[1]==1)ptrs[1]=" напряжения (завыш.)";
		ptrs[2]="   Начало           ";
		ptrs[3]="  0%[  0^ 0@:0#:0$  ";
		ptrs[4]="        Uвх=    <В  ";
		ptrs[5]="   Конец            ";
		ptrs[6]="  0qw  0r 0i:0l:0s  ";
		ptrs[7]="        Uвх=    >В  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[5]="  Не устранена      ";
			ptrs[6]="                    ";
			ptrs[7]="                    ";
			av_j_si_max=2;
			}
			
		bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
		
		int2lcd(av_head[1]+1,'!',0);

		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'[',0);
				
		int2lcd(av_data_off[4],'i',0);
		int2lcd(av_data_off[5],'l',0);
		int2lcd(av_data_off[6],'s',0);
		int2lcd(av_data_off[2],'q',0);
		int2lcd(av_data_off[0],'r',0); 
		if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
		sub_bgnd(sm_mont[av_data_off[1]],'w',0);
		
		int2lcd(av_head_int[0],'<',1);
		int2lcd(av_data[0]+(av_data[1]*256),'>',1);
			
		
		
		

						
		}

	else if((av_head[0]=='V')&&(av_head[1]=='O')&&(av_head[2]=='U')&&(av_head[3]=='T'))
		{
		av_j_si_max=4;  
		ptrs[0]=" Авария выходного   ";
		ptrs[1]=" напряжения (заниж.)";
		if(av_head_int[2]==1)ptrs[1]=" напряжения (завыш.)";
		ptrs[2]="   Начало           ";
		ptrs[3]="  0%[  0^ 0@:0#:0$  ";
		ptrs[4]="       Uвых=    <В  ";
		ptrs[5]="   Конец            ";
		ptrs[6]="  0qw  0r 0i:0l:0s  ";
		ptrs[7]="       Uвых=    >В  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[5]="  Не устранена      ";
			ptrs[6]="                    ";
			ptrs[7]="                    ";
			av_j_si_max=2;
			}
			
		bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
		
		int2lcd(av_head[1]+1,'!',0);

		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'[',0);
				
		int2lcd(av_data_off[4],'i',0);
		int2lcd(av_data_off[5],'l',0);
		int2lcd(av_data_off[6],'s',0);
		int2lcd(av_data_off[2],'q',0);
		int2lcd(av_data_off[0],'r',0); 
		if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
		sub_bgnd(sm_mont[av_data_off[1]],'w',0);
		
		int2lcd(av_head_int[0],'<',1);
		int2lcd(av_data[0]+(av_data[1]*256),'>',1);

						
		}


	else if((av_head[0]=='O')&&(av_head[1]=='V')&&(av_head[2]=='L'))
		{  
		ptrs[0]=" ПЕРЕГРУЗКА СИСТЕМЫ ";
		ptrs[1]="       ПО ТОКУ      ";
		
		ptrs[2]="  0%(  0^ 0@:0#:0$  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[3]="    не устранена    ";
			bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
			}
		else 
			{
			gran_char(&a_ind . i_s,0,1);
			ptrs[3]="      устранена     ";
			ptrs[4]="  0[]  0< 0>:0=:0)  ";
			bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
			int2lcd(av_data_off[4],'>',0);
			int2lcd(av_data_off[5],'=',0);
			int2lcd(av_data_off[6],')',0);
			int2lcd(av_data_off[2],'[',0);
			int2lcd(av_data_off[0],'<',0); 
			if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
			sub_bgnd(sm_mont[av_data_off[1]],']',0);
			
						
			}	
		int2lcd(av_head[1]+1,'+',0);
		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'(',0);
		
		}

	else if((av_head[0]=='T')&&(av_head[1]=='S')&&(av_head[2]=='Y')&&(av_head[3]=='S'))
		{
		av_j_si_max=4;  
		ptrs[0]="  Авария перегрев   ";
		ptrs[1]="      системы       ";
		ptrs[2]="   Начало           ";
		ptrs[3]="  0%[  0^ 0@:0#:0$  ";
		ptrs[4]="  Tсистемы =   <°С  ";
		ptrs[5]="   Конец            ";
		ptrs[6]="  0qw  0r 0i:0l:0s  ";
		ptrs[7]="  Tсистемы =   >°С  ";
		if((av_data_off[0]=='A')&&(av_data_off[1]=='A'))
			{
			ptrs[5]="  Не устранена      ";
			ptrs[6]="                    ";
			ptrs[7]="                    ";
			av_j_si_max=2;
			}
			
		bgnd_par(ptrs[a_ind . i_s],ptrs[1+a_ind . i_s],ptrs[2+a_ind . i_s],ptrs[3+a_ind . i_s]);
		
		int2lcd(av_head[1]+1,'!',0);

		int2lcd(av_data_on[4],'@',0);
		int2lcd(av_data_on[5],'#',0);
		int2lcd(av_data_on[6],'$',0);
		int2lcd(av_data_on[2],'%',0);
		int2lcd(av_data_on[0],'^',0); 
		if(!((av_data_on[1]>=1)&&(av_data_on[1]<=12)))av_data_on[1]=1;
		sub_bgnd(sm_mont[av_data_on[1]],'[',0);
				
		int2lcd(av_data_off[4],'i',0);
		int2lcd(av_data_off[5],'l',0);
		int2lcd(av_data_off[6],'s',0);
		int2lcd(av_data_off[2],'q',0);
		int2lcd(av_data_off[0],'r',0); 
		if(!((av_data_off[1]>=1)&&(av_data_off[1]<=12)))av_data_off[1]=1;
		sub_bgnd(sm_mont[av_data_off[1]],'w',0);
		
		int2lcd(av_head_int[0],'<',0);
		int2lcd(av_data[0]+(av_data[1]*256),'>',0);

						
		}	
	
	}
		 
else if(a_ind . i==iBatLog)
	{
	if(BAT_IS_ON[a_ind . s_i1]==bisON)ptrs[0]=" Введена  0!/@  /0# ";
	else ptrs[0]=" Выведена 0!/@  /0# ";
     ptrs[1]=" Номин.емк.     $A*ч";
     ptrs[2]=" Наработка      %ч. ";
     ptrs[3]=" Контроль емкости   ";
     ptrs[4]=" Выравнивающий заряд";
     ptrs[5]=" Разряды            ";
     ptrs[6]=sm_exit;	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(	" БАТАРЕЙНЫЙ ЖУРНАЛ  ",
			"     БАТАРЕЯ N^     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1]);
	pointer_set(2);	

	int2lcd(a_ind . s_i1+1,'^',0); 
	int2lcd(BAT_DAY_OF_ON[a_ind . s_i1],'!',0);
	sub_bgnd(sm_mont[BAT_MONTH_OF_ON[a_ind . s_i1]],'@',0);
	int2lcd(BAT_YEAR_OF_ON[a_ind . s_i1],'#',0); 
	int2lcd(BAT_C_NOM[a_ind . s_i1],'$',0);
	int2lcd(BAT_RESURS[a_ind . s_i1],'%',0);

	


 
	}

else if(a_ind . i==iBatLogKe)
	{             
	if(av_j_si_max==0)
		{
		bgnd_par(	"  КОНТРОЛИ ЕМКОСТИ  ",
				"     БАТАРЕИ N!     ",
				" Журнал пуст        ",
				sm_exit);
		pointer_set(3);
		a_ind . s_i=0;
		a_ind . i_s=0;
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"  КОНТРОЛИ ЕМКОСТИ  ",
				"     БАТАРЕИ N!     ",
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
			bgnd_par( "  КОНТРОЛИ ЕМКОСТИ  ",
					"     БАТАРЕИ N!     ",
					" (                  ",
					sm_exit);
			}
		else
			{
			bgnd_par(	"  КОНТРОЛИ ЕМКОСТИ  ",
					"     БАТАРЕИ N!     ",
					" (                  ",
					" [                  ");
			}
		pointer_set(2);			 
		}
		
   	int2lcd(a_ind . s_i1+1,'!',0);
 	event_data2ind(content[a_ind . i_s],'(');
 	event_data2ind(content[a_ind . i_s+1],'[');
	}

else if(a_ind . i==iBatLogVz)
	{
	if(av_j_si_max==0)
		{
		bgnd_par(	"ВЫРАВНИВАЮЩИЕ ЗАРЯДЫ",
				"     БАТАРЕИ N!     ",
				" Журнал пуст        ",
				sm_exit);
		a_ind . s_i=0;
		a_ind . i_s=0;
		pointer_set(3);
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"ВЫРАВНИВАЮЩИЕ ЗАРЯДЫ",
				"     БАТАРЕИ N!     ",
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
			bgnd_par(	"ВЫРАВНИВАЮЩИЕ ЗАРЯДЫ",
					"     БАТАРЕИ N!     ",
					" (                  ",
					sm_exit);
			}

		else bgnd_par(	"ВЫРАВНИВАЮЩИЕ ЗАРЯДЫ",
					"     БАТАРЕИ N!     ",
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
		bgnd_par(	"      РАЗРЯДЫ       ",
				"     БАТАРЕИ N!     ",
				" Журнал пуст        ",
				sm_exit);
		a_ind . s_i=0;
		a_ind . i_s=0;
		pointer_set(3);
		} 
	else if(av_j_si_max==1)
		{
		bgnd_par(	"      РАЗРЯДЫ       ",
				"     БАТАРЕИ N!     ",
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
			bgnd_par(	"      РАЗРЯДЫ       ",
					"     БАТАРЕИ N!     ",
					" (                  ",
					sm_exit);
			}
		else bgnd_par(	"      РАЗРЯДЫ       ",
					"     БАТАРЕИ N!     ",
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
	bgnd_par("  Введите  пароль   ",sm_,sm_,sm_);
	int2lcdyx(parol[0],1,8,0);
     int2lcdyx(parol[1],1,9,0);
     int2lcdyx(parol[2],1,10,0);
     lcd_buffer[48+a_ind . s_i]='¤';
	}	
		
else if(a_ind . i==iPrl_bat_in_out)
	{
	if(BAT_IS_ON[a_ind . s_i1]==bisON)ptrs[0]="Для выведения бат.-и";
	else  ptrs[0]="Для введения батареи";
	bgnd_par(ptrs[0],"  наберите пароль   ",sm_,sm_);
	
     int2lcdyx(parol[0],2,8,0);
     int2lcdyx(parol[1],2,9,0);
     int2lcdyx(parol[2],2,10,0);
     lcd_buffer[68+a_ind . s_i]='¤';	
	}

else if(a_ind . i==iPrl_bat_in_sel)
	{
	
	bgnd_par(	"Для введения батареи",
			"   выбеите ее тип   ",
			" Свинцово-кислотная ",
			" GYFP4875T          ");
	
	pointer_set(2);
	}


else if(a_ind . i==iSet)
	{
     ptrs[0]=		" Стандартные        ";
	ptrs[1]=		" Время и дата       ";
     ptrs[2]=		" Структура          ";
	ptrs[3]=		" Климатконтроль     ";
	ptrs[4]=		" Выход              ";
     ptrs[5]=		" Мнемоника         y";
	ptrs[6]=		" Зв.сигн.   (       ";
	ptrs[7]=		" Отключение сигнала ";
	ptrs[8]=		"  аварии    )       ";
	ptrs[9]=		" АПВ источников     ";
	ptrs[10]=		" Паралл.работа z    ";
	ptrs[11]=		" T проверки   цепи  ";
     ptrs[12]=		" батареи     qмин.  ";
     ptrs[13]=		" Umax=       !В     ";
     ptrs[14]=		" Umin=       ZВ     ";
     ptrs[15]=		" Uб0°=       @В     ";
     ptrs[16]=		" Uб20°=      #В     ";
     ptrs[17]=		" Uсигн=      ^В     ";
     ptrs[18]=		" Umin.сети=  &В     ";
	ptrs[19]=		" U0б=        >В     ";
	ptrs[20]=		" Iбк.=       jА     ";
     ptrs[21]=		" Iз.мах.=    JА     ";
     ptrs[22]=		" Imax =      ]A     ";
     ptrs[23]=		" Imin =      {A     ";
     ptrs[24]=		" Uвыр.зар.=   [В    ";
     ptrs[25]=		" Tз.вкл.а.с. !с     ";
	ptrs[26]=		" tи.max=     $°C    ";
	ptrs[27]=		" tи.сигн=    z°C    ";
	ptrs[28]=		" tбат.max=   b°C    ";
	ptrs[29]=		" tбат.сигн=  X°C    ";
     ptrs[30]=		" Внешние датчики    ";
	ptrs[31]=		" Ethernet           ";
     ptrs[32]=      " Адрес счетчика    +";
     ptrs[33]=      " Контроль ср.точки  ";
     ptrs[34]=      " батареи         Q% ";
	ptrs[35]=      " Серийный N        w";
     ptrs[36]=		" Выход              ";
     ptrs[37]=		" Калибровки         "; 
     ptrs[38]=		"                    ";        
	
	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     УСТАНОВКИ      ",
			ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

	pointer_set(1);	
	
	if(a_ind . i_s<19)
	     {
	     if(ZV_ON)sub_bgnd("ВКЛ.",'(',0);
	     else sub_bgnd("ВЫК.",'(',0);
	     if(AV_OFF_AVT)sub_bgnd("автом.",')',0);
	     else sub_bgnd("ручн.",')',0);


	     if(MNEMO_ON==mnON)
	     	{
	     	sub_bgnd("через yс.",'y',-8);
	     	int2lcd(MNEMO_TIME,'y',0);
	     	}
	     else sub_bgnd("выкл.",'y',-4);
	     int2lcd(UMAX,'!',1);
	     
	     
	     
	     int2lcd(USIGN,'^',0);
	     int2lcd(UMN,'&',0);
	     int2lcd(U0B,'>',1);
	     } 
	int2lcd(TMAX,'$',0);
	int2lcd(IKB,'j',2);

	int2lcd(IMAX,']',1);
	int2lcd(IMIN,'{',1);
	int2lcd(IZMAX,'J',1); 
	int2lcd(TZAS,'!',0);
	int2lcd(TBAT,'q',0);
	int2lcd(TSIGN,'z',0); 
	int2lcd(TBATMAX,'b',0); 
	int2lcd(TBATSIGN,'X',0);
     int2lcd(POWER_CNT_ADRESS,'+',0);
     if(UBM_AV)
          {
          int2lcd(UBM_AV,'Q',0);
          } 
     else sub_bgnd("ВЫКЛ.",'Q',-2);


	long2lcd_mmm(AUSW_MAIN_NUMBER,'w',0);
	}


else if((a_ind . i==iSet_VD))
	{
    ptrs[0]=		" Стандартные        ";
	ptrs[1]=		" Время и дата       ";
    ptrs[2]=		" Структура          ";
	ptrs[3]=		" Выход              ";
	ptrs[4]=		" Зв.сигн.   (       ";
	ptrs[5]=		" Отключение сигнала ";
	ptrs[6]=		"  аварии    )       ";
	ptrs[7]=		" АПВ источников     ";
	ptrs[8]=		" Uвых. =        @В  ";
    ptrs[9]=		" Uавтон. =      #В  ";
	ptrs[10]=		" tбпс.сигн =    z°C ";
	ptrs[11]=		" tбпс.max =     $°C ";
	ptrs[12]=		" tсист.max =    [°C ";
	ptrs[13]=		" dUбпс.авар =   ZВ  ";
    ptrs[14]=		" Uбпс.авар =    !В  ";
    ptrs[15]=		" Uвх.авар.max =   ^В";
    ptrs[16]=		" Uвх.авар.min =   &В";
    ptrs[17]=		" Uвых.авар.max =  jВ";
    ptrs[18]=		" Uвых.авар.min =  JВ";
	ptrs[19]=		" Tз.ав.сигн. =    }с";
    ptrs[20]=		" Порог ресурса      ";
    ptrs[21]=		" вентилятора      ]ч";
	ptrs[22]=		" Реле               ";
	ptrs[23]=		" Ethernet           ";
	ptrs[24]=		" MODBUS ADRESS     <";
	ptrs[25]=		" MODBUS BAUDRATE    ";
	ptrs[26]=		"                  >0";
	ptrs[27]=		" Измерение тока     ";
	ptrs[28]=		" нагрузки          {";
    ptrs[29]=		" Выход              ";
    ptrs[30]=		" Калибровки         "; 
    ptrs[31]=		"                    ";        
	
	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     УСТАНОВКИ      ",
			ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

	pointer_set(1);	
	

		{
	    if(ZV_ON)sub_bgnd("ВКЛ.",'(',0);
	    else sub_bgnd("ВЫК.",'(',0);
	    if(AV_OFF_AVT)sub_bgnd("автом.",')',0);
	    else sub_bgnd("ручн.",')',0);
		int2lcd(UOUT,'@',1);
	    int2lcd(UAVT,'#',1);
		int2lcd(TMAX,'$',0);	
		int2lcd(TSIGN,'z',0);
		int2lcd(TSYSMAX,'[',0);
		int2lcd(UMAX,'!',1);
		int2lcd(DU,'Z',1);
	    int2lcd(UINMAX/10,'^',0);
	    int2lcd(UINMIN/10,'&',0);
		int2lcd(UOUTMAX/10,'j',0);	
		int2lcd(UOUTMIN/10,'J',0);
		int2lcd(TZAS,'}',0);
		int2lcd(TVENTMAX*10,']',0);

		if(TBAT==0)sub_bgnd("выкл.",'q',0);	
		else int2lcd(TBAT,'q',0);

		if(I_LOAD_MODE)
     		{
     		sub_bgnd("шунт",'{',-3);
     		}
		else sub_bgnd("суммIбпс",'{',-7);
	    } 
	
	

	
	
 
	
	
 
	int2lcd(TBATMAX,'b',0); 
	int2lcd(TBATSIGN,'X',0);
     int2lcd(POWER_CNT_ADRESS,'+',0);
     if(UBM_AV)
          {
          int2lcd(UBM_AV,'Q',0);
          } 
     else sub_bgnd("ВЫКЛ.",'Q',-2);


	long2lcd_mmm(AUSW_MAIN_NUMBER,'w',0);
	if(a_ind . i_s>19)
		{
		if(TERMOKOMPENS)sub_bgnd("ВКЛ.",'q',-3);
		else sub_bgnd("ВЫКЛ.",'q',-4);
		}
	int2lcd(MODBUS_ADRESS,'<',0);
	int2lcd(MODBUS_BAUDRATE,'>',0);

	if((FORVARDBPSCHHOUR<=0)||(FORVARDBPSCHHOUR>500)) {
		sub_bgnd("ВЫКЛ.",'l',0);
	} else {
		int2lcd(FORVARDBPSCHHOUR,'l',0);	
	}

	
	
	int2lcd(PWM_START,'(',0);
	
	if(KB_ALGORITM==1)	sub_bgnd("1-о ступ.",')',0);
	else if(KB_ALGORITM==2)	sub_bgnd("2-х ступ.",')',0);
	else 				sub_bgnd("3-х ступ.",')',0);
	if(REG_SPEED==2)	sub_bgnd("стандарт/2",'&',0);
	else if(REG_SPEED==3)	sub_bgnd("стандарт/3",'&',0);
	else if(REG_SPEED==4)	sub_bgnd("стандарт/4",'&',0);
	else if(REG_SPEED==5)	sub_bgnd("стандарт/5",'&',0);
	else 				sub_bgnd("стандарт",'&',0);

	int2lcd(MODBUS_ADRESS,'<',0);
	int2lcd(MODBUS_BAUDRATE,'>',0);

	}




else if (a_ind . i==iDef_220_IPS_TERMOKOMPENSAT)
	{ 
	ptrs[0]=" ИПС380/220-45АТКИ17";
	ptrs[1]=" ИПС220/220-10АТКИ17";
	ptrs[2]=" ИПС380/110-90АТКИ9 ";
	ptrs[3]=" ИПС380/220-ТКИ18   ";
	ptrs[4]=sm_exit;
	ptrs[5]="                    ";
	ptrs[6]="                    ";
	if(bFL5)ptrs[default_temp]=sm_;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;

    	bgnd_par("СТАНДАРТНЫЕ УСТ.-КИ ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
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
	if(phase==0)ptrs[2]="     <> - выбор     ";
     if(phase==1)ptrs[2]="   ^v - установка   ";
     if(phase==2)ptrs[2]="     ¤  - выход     ";
	
	bgnd_par(" УСТАНОВКА  ВРЕМЕНИ ",ptrs[0],ptrs[1],ptrs[2]);
     if(a_ind . s_i==0)lcd_buffer[42]='^';
     else if(a_ind . s_i==1)lcd_buffer[45]='^';
     else if(a_ind . s_i==2)lcd_buffer[48]='^';
     else if(a_ind . s_i==3)lcd_buffer[51]='^';
     else if(a_ind . s_i==4)lcd_buffer[54]='^';
     else if(a_ind . s_i==5)lcd_buffer[58]='^';
  
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->SEC,'&',0);
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MIN,'^',0);
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->HOUR,'%',0);
 	
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->DOM,'<',0);
 	sub_bgnd(sm_mont[((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->MONTH],'>',0);
 	int2lcd(((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->YEAR,'{',0);
 	if(bFL2)
 	     {
 	     lcd_buffer[find(':')]=' ';
 	     lcd_buffer[find(':')]=' ';
 	     }  
	}  

else if(a_ind . i==iStr)
	{
	ptrs[0]=" Батарей           @";
	ptrs[1]=" Источников        !";
	ptrs[2]=" Инверторов        ^";	
	ptrs[3]=" Контролируемых     ";
	ptrs[4]=" автоматов         $";
	ptrs[5]=" Выход              ";

	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
	bgnd_par("      СТРУКТУРА     ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);

	int2lcd(NUMBAT,'@',0);		
	int2lcd(NUMIST,'!',0);
	int2lcd(NUMAVT,'$',0);	 
	int2lcd(NUMINV,'^',0);
	int2lcd(NUMDT,'#',0);
	int2lcd(NUMSK,'$',0);
	}    

else if(a_ind . i==iStr_VD)
	{
	ptrs[0]=" Источников        !";
	ptrs[1]=" Датчиков темпер.  #";


	ptrs[2]=" Выход              ";
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
	bgnd_par("      СТРУКТУРА     ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);

	int2lcd(NUMIST,'!',0); 
	int2lcd(NUMDT,'#',0);
	int2lcd(NUMMAKB,'%',0);
	int2lcd(NUMSK,'$',0);
	}    

else if (a_ind . i==iLan_set)
	{
	char sss[10]="abcdef";
	char i ;
	 
	ptrs[0]=	" Ethernet         ! ";
	ptrs[1]=	" DHCPклиент       @ ";
	ptrs[2]=	" IPадрес            ";
	ptrs[3]=	"  000.000.000.00#   ";
	ptrs[4]=	" Маска подсети      ";
	ptrs[5]=	"  000.000.000.00$   ";
	ptrs[6]=	" Шлюз               ";
	ptrs[7]=	"  000.000.000.00)   ";
	ptrs[8]=	" Порт.чтения       [";
	ptrs[9]=	" Порт.записи       ]";
	ptrs[10]=	" Community <        ";
	ptrs[11]=	" Адресат для TRAP N1";
	ptrs[12]=	"  000.000.000.00%   ";
	ptrs[13]=	" Адресат для TRAP N2";
	ptrs[14]=	"  000.000.000.00^   ";
	ptrs[15]=	" Адресат для TRAP N3";
	ptrs[16]=	"  000.000.000.00&   ";
	ptrs[17]=	" Адресат для TRAP N4";
	ptrs[18]=	"  000.000.000.00*   ";
	ptrs[19]=	" Адресат для TRAP N5";
	ptrs[20]=	"  000.000.000.00(   ";
	ptrs[21]=	" Выход              ";

	
	if(!ETH_IS_ON)
		{
		ptrs[1]=" Выход              ";
		ptrs[2]="                    ";
		ptrs[3]="                    ";
		}

	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;

     bgnd_par(	" УСТАНОВКИ Ethernet ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
     if(ETH_IS_ON)
     	{
     	sub_bgnd("ВКЛ.",'!',-3);   
     	}
     else 
     	{
     	sub_bgnd("ВЫКЛ.",'!',-4);   
     	}

     if(ETH_DHCP_ON)
     	{
     	sub_bgnd("ВКЛ.",'@',-3);   
     	}
     else 
     	{
     	sub_bgnd("ВЫКЛ.",'@',-4);   
     	}
		  
	if(a_ind . s_i==2)	ip2lcd(ETH_IP_1,ETH_IP_2,ETH_IP_3,ETH_IP_4,'#',(a_ind . s_i1+1));
	else ip2lcd(ETH_IP_1,ETH_IP_2,ETH_IP_3,ETH_IP_4,'#',0);
	if(a_ind . s_i==4)	ip2lcd(ETH_MASK_1,ETH_MASK_2,ETH_MASK_3,ETH_MASK_4,'$',(a_ind . s_i1+1));
	else ip2lcd(ETH_MASK_1,ETH_MASK_2,ETH_MASK_3,ETH_MASK_4,'$',0);
	if(a_ind . s_i==6)	ip2lcd(ETH_GW_1,ETH_GW_2,ETH_GW_3,ETH_GW_4,')',(a_ind . s_i1+1));
	else ip2lcd(ETH_GW_1,ETH_GW_2,ETH_GW_3,ETH_GW_4,')',0);

	int2lcd(ETH_SNMP_PORT_READ,'[',0);
	int2lcd(ETH_SNMP_PORT_WRITE,']',0);

	if( (ETH_TRAP1_IP_1==255) && (ETH_TRAP1_IP_2==255) && (ETH_TRAP1_IP_3==255) && (ETH_TRAP1_IP_4==255) ) sub_bgnd("    неактивен    ",'%',-14);
	else
		{
		if(a_ind . s_i==11)	ip2lcd(ETH_TRAP1_IP_1,ETH_TRAP1_IP_2,ETH_TRAP1_IP_3,ETH_TRAP1_IP_4,'%',(a_ind . s_i1+1));
		else ip2lcd(ETH_TRAP1_IP_1,ETH_TRAP1_IP_2,ETH_TRAP1_IP_3,ETH_TRAP1_IP_4,'%',0);
		}

	if( (ETH_TRAP2_IP_1==255) && (ETH_TRAP2_IP_2==255) && (ETH_TRAP2_IP_3==255) && (ETH_TRAP2_IP_4==255) ) sub_bgnd("    неактивен    ",'^',-14);
	else
		{
		if(a_ind . s_i==13)	ip2lcd(ETH_TRAP2_IP_1,ETH_TRAP2_IP_2,ETH_TRAP2_IP_3,ETH_TRAP2_IP_4,'^',(a_ind . s_i1+1));
		else ip2lcd(ETH_TRAP2_IP_1,ETH_TRAP2_IP_2,ETH_TRAP2_IP_3,ETH_TRAP2_IP_4,'^',0);
		}

	if( (ETH_TRAP3_IP_1==255) && (ETH_TRAP3_IP_2==255) && (ETH_TRAP3_IP_3==255) && (ETH_TRAP3_IP_4==255) ) sub_bgnd("    неактивен    ",'&',-14);
	else
		{
		if(a_ind . s_i==15)	ip2lcd(ETH_TRAP3_IP_1,ETH_TRAP3_IP_2,ETH_TRAP3_IP_3,ETH_TRAP3_IP_4,'&',(a_ind . s_i1+1));
		else ip2lcd(ETH_TRAP3_IP_1,ETH_TRAP3_IP_2,ETH_TRAP3_IP_3,ETH_TRAP3_IP_4,'&',0);
		}

	if( (ETH_TRAP4_IP_1==255) && (ETH_TRAP4_IP_2==255) && (ETH_TRAP4_IP_3==255) && (ETH_TRAP4_IP_4==255) ) sub_bgnd("    неактивен    ",'*',-14);
	else
		{
		if(a_ind . s_i==17)	ip2lcd(ETH_TRAP4_IP_1,ETH_TRAP4_IP_2,ETH_TRAP4_IP_3,ETH_TRAP4_IP_4,'*',(a_ind . s_i1+1));
		else ip2lcd(ETH_TRAP4_IP_1,ETH_TRAP4_IP_2,ETH_TRAP4_IP_3,ETH_TRAP4_IP_4,'*',0);
		}

	if( (ETH_TRAP5_IP_1==255) && (ETH_TRAP5_IP_2==255) && (ETH_TRAP5_IP_3==255) && (ETH_TRAP5_IP_4==255) ) sub_bgnd("    неактивен    ",'(',-14);
	else
		{
		if(a_ind . s_i==19)	ip2lcd(ETH_TRAP5_IP_1,ETH_TRAP5_IP_2,ETH_TRAP5_IP_3,ETH_TRAP5_IP_4,'(',(a_ind . s_i1+1));
		else ip2lcd(ETH_TRAP5_IP_1,ETH_TRAP5_IP_2,ETH_TRAP5_IP_3,ETH_TRAP5_IP_4,'(',0);
		}























 


	
	
	
	

	for(i=0;i<9;i++)
		{
		sss[i]=snmp_community[i];
		}
	sss[9]=0;		

	if(a_ind . s_i==10)community2lcd(sss,'<',a_ind . s_i1,1);
	else community2lcd(sss,'<',a_ind . s_i1,0);
	
	
	
	
	
	}



else if (a_ind . i==iBlok_ips_set)
	{
	char sss[10]="abcdef";

	 
	ptrs[0]=	" Блокирование      ^";
	ptrs[1]=	" Сигнал блокирования";
	ptrs[2]=	"                   &";
	ptrs[3]=	" Выход              ";

	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;

     bgnd_par(	"   БЛОКИРОВКА ИПС   ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);
	
	pointer_set(1);

	if(ipsBlckSrc==1)sub_bgnd("СК1",'^',-2);
	else if(ipsBlckSrc==2)sub_bgnd("СК2",'^',-2);   
    else if(ipsBlckSrc==0)sub_bgnd("ВЫКЛ.",'^',-4);
	else sub_bgnd("НЕКОРР..",'^',-6); 
	if(ipsBlckLog==0)sub_bgnd("РАЗОМКН.",'&',-7);
	else if(ipsBlckLog==1) sub_bgnd("ЗАМКН.",'&',-5);  
    else sub_bgnd("НЕКОРР.",'&',-6); 	  

	
	}


else if (a_ind . i==iApv)
	{ 
	ptrs[0]=			" АПВ 1й уровень !   ";
	if(APV_ON1!=apvON)
	     {
	     ptrs[1]=		" Выход              ";
	     ptrs[2]=sm_;
	     ptrs[3]=sm_;
	     ptrs[4]=sm_;
	     simax=1;
	     }
	else
	     {
	     if(APV_ON2!=apvON)
	          {
	          ptrs[1]=" АПВ 2й уровень @   ";
	          ptrs[2]=" Выход              ";
	          ptrs[3]=sm_;
	          ptrs[4]=sm_;
	          simax=2;
	          }
	     else 
	          {
               ptrs[1]=" АПВ 2й уровень @   ";
	          ptrs[2]=" Период АПВ2     #ч.";
	          ptrs[3]=" Выход              ";
	          ptrs[4]=sm_;
	          simax=3;	          
	          }     
	     }     
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;	
     bgnd_par("   АПВ ИСТОЧНИКОВ   ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	if(APV_ON1==apvON)sub_bgnd("ВКЛ.",'!',0);
	else sub_bgnd("ВЫКЛ.",'!',-1);
	
	if(APV_ON2==apvON)
	     {
	     sub_bgnd("ВКЛ.",'@',0);
	     int2lcd(APV_ON2_TIME,'#',0);
	     }
	else sub_bgnd("ВЫКЛ.",'@',-1);	
     
 	} 














 

else if (a_ind . i==iExt_set)
	{ 



	ptrs[0]=		" Датчик двери       ";
	ptrs[1]=		" Датчик дыма        ";
	ptrs[2]=		" Датчик удара       ";

	ptrs[3]=  	" Выход              ";
	ptrs[4]=  	"                    ";
	ptrs[5]=  	"                    ";
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("     УСТАНОВКИ      ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	}

else if (a_ind . i==iExt_set_3U)
	{ 
	ptrs[0]=		" Сухой контакт №1   ";
	ptrs[1]=		" Сухой контакт №2   ";
	ptrs[2]=		" Сухой контакт №3   ";
	ptrs[3]=		" Сухой контакт №4   ";
	ptrs[NUMSK]=  	" Выход              ";
	ptrs[NUMSK+1]= "                    ";
	ptrs[NUMSK+2]=	"                    ";
	ptrs[NUMSK+3]=	"                    ";
		
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("     УСТАНОВКИ      ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	}
	
else if (a_ind . i==iExt_dt)
	{ 
	ptrs[0]=" температура     @°C";
	ptrs[1]=" tmax            #°C";
	ptrs[2]=" tmin            $°C";
	ptrs[3]=" Реле            [  ";
	ptrs[4]=" Звук            ]  ";
	ptrs[5]=" Дисплей         (  ";
	ptrs[6]=" RS232           )  ";
	ptrs[7]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>1) a_ind . i_s=a_ind . s_i-1;
     bgnd_par("  ВНЕШНИЙ ДАТЧИК    ","   ТЕМПЕРАТУРЫ N!   ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1]);
	
	pointer_set(2);
	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd_mmm(t_ext[a_ind . s_i1],'@',0);
	if(!TMAX_EXT_EN[a_ind . s_i1])int2lcd_mmm(TMAX_EXT[a_ind . s_i1],'#',0);
	else sub_bgnd("выкл.",'#',-2);
	if(!TMIN_EXT_EN[a_ind . s_i1])int2lcd_mmm(TMIN_EXT[a_ind . s_i1],'$',0);
	else sub_bgnd("выкл.",'$',-2);
	if(!T_EXT_REL_EN[a_ind . s_i1])sub_bgnd("вкл.",'[',-2);
	else sub_bgnd("выкл.",'[',-2);
	if(!T_EXT_ZVUK_EN[a_ind . s_i1])sub_bgnd("вкл.",']',-2);
	else sub_bgnd("выкл.",']',-2);
	if(!T_EXT_LCD_EN[a_ind . s_i1])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);
	if(!T_EXT_RS_EN[a_ind . s_i1])sub_bgnd("вкл.",')',-2);
	else sub_bgnd("выкл.",')',-2);	
	
	
	
	}	
else if (a_ind . i==iExt_sk)
	{ 
	ptrs[0]=" состояние - @      ";
	ptrs[1]=" аварийное          ";
	ptrs[2]=" состояние - #      ";
	ptrs[3]=" Реле            [  ";
	ptrs[4]=" Звук            ]  ";
	ptrs[5]=" Дисплей         (  ";
	ptrs[6]=" RS232           )  ";
	ptrs[7]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("  СУХОЙ КОНТАКТ N!  ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	int2lcd(a_ind . s_i1+1,'!',0);
	if(sk_stat[a_ind . s_i1]==ssON)sub_bgnd("замкнут",'@',0);
	else sub_bgnd("разомк.",'@',0);
	if(!SK_SIGN[a_ind . s_i1])sub_bgnd("замкнут",'#',0);
	else sub_bgnd("незамк.",'#',0);
	if(!TMIN_EXT_EN[a_ind . s_i1])int2lcd_mmm(TMIN_EXT[a_ind . s_i1],'$',0);
	else sub_bgnd("выкл.",'$',-6);
	if(!SK_REL_EN[a_ind . s_i1])sub_bgnd("вкл.",'[',-2);
	else sub_bgnd("выкл.",'[',-2);
	if(!SK_ZVUK_EN[a_ind . s_i1])sub_bgnd("вкл.",']',-2);
	else sub_bgnd("выкл.",']',-2);
	if(!SK_LCD_EN[a_ind . s_i1])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);
	if(!SK_RS_EN[a_ind . s_i1])sub_bgnd("вкл.",')',-2);
	else sub_bgnd("выкл.",')',-2);	
	
	
	
	}		

else if (a_ind . i==iExt_sk_3U)
	{ 
	ptrs[0]=" состояние - @      ";
	ptrs[1]=" аварийное          ";
	ptrs[2]=" состояние - #      ";
	ptrs[3]=" Звук            ]  ";
	ptrs[4]=" Дисплей         (  ";
	ptrs[5]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("  СУХОЙ КОНТАКТ N!  ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	int2lcd(a_ind . s_i1+1,'!',0);
	if(sk_stat[a_ind . s_i1]==ssON)sub_bgnd("замкнут",'@',0);
	else sub_bgnd("разомк.",'@',0);
	if(!SK_SIGN[a_ind . s_i1])sub_bgnd("замкнут",'#',0);
	else sub_bgnd("незамк.",'#',0);
	if(!SK_ZVUK_EN[a_ind . s_i1])sub_bgnd("вкл.",']',-2);
	else sub_bgnd("выкл.",']',-2);
	if(!SK_LCD_EN[a_ind . s_i1])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);
	}		

else if (a_ind . i==iExt_ddv)
	{ 
	ptrs[0]=" состояние - @      ";
	ptrs[1]=" открытое состояние ";
	ptrs[2]=" двери     - #      ";
	ptrs[3]=" Реле            [  ";
	ptrs[4]=" Дисплей         (  ";
	ptrs[5]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("   ДАТЧИК ДВЕРИ     ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	
	if(sk_stat[0]==ssON)sub_bgnd("замкнут",'@',0);
	else sub_bgnd("разомк.",'@',0);
	if(!SK_SIGN[0])sub_bgnd("замкнут",'#',0);
	else sub_bgnd("незамк.",'#',0);
	if(SK_REL_EN[0])sub_bgnd("вкл.",'[',-2);
	else sub_bgnd("выкл.",'[',-2);
     if(SK_LCD_EN[0])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);
	
	}	

else if (a_ind . i==iExt_ddi)
	{ 
	ptrs[0]=" состояние - @      ";
	ptrs[1]=" аварийное          ";
	ptrs[2]=" состояние - #      ";
	ptrs[3]=" Реле            [  ";
	ptrs[4]=" Дисплей         (  ";
	ptrs[5]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("   ДАТЧИК ДЫМА      ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	
	if(sk_stat[1]==ssON)sub_bgnd("замкнут",'@',0);
	else sub_bgnd("разомк.",'@',0);
	if(!SK_SIGN[1])sub_bgnd("замкнут",'#',0);
	else sub_bgnd("незамк.",'#',0);
	if(SK_REL_EN[1])sub_bgnd("вкл.",'[',-2);
	else sub_bgnd("выкл.",'[',-2);
	if(SK_LCD_EN[1])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);
	}	

else if (a_ind . i==iExt_dud)
	{ 
	ptrs[0]=" состояние - @      ";
	ptrs[1]=" аварийное          ";
	ptrs[2]=" состояние - #      ";
	ptrs[3]=" Реле            [  ";
	ptrs[4]=" Дисплей         (  ";
	ptrs[5]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("   ДАТЧИК УДАРА     ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);
	
	if(sk_stat[2]==ssON)sub_bgnd("замкнут",'@',0);
	else sub_bgnd("разомк.",'@',0);
	if(!SK_SIGN[2])sub_bgnd("замкнут",'#',0);
	else sub_bgnd("незамк.",'#',0);
	if(SK_REL_EN[2])sub_bgnd("вкл.",'[',-2);
	else sub_bgnd("выкл.",'[',-2);
	if(SK_LCD_EN[2])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);
	}


else if (a_ind . i==iExt_dp)
	{ 
	ptrs[0]=" состояние - @      ";
	ptrs[1]=" аварийное          ";
	ptrs[2]=" состояние - #      ";
	ptrs[3]=" Реле            [  ";
     ptrs[4]=" Дисплей         (  ";
	ptrs[5]=sm_exit;
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>2) a_ind . i_s=a_ind . s_i-2;
     bgnd_par("ДАТЧИК ПЕРЕВОРАЧИВ. ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	
	pointer_set(1);

	if(sk_stat[3]==ssON)sub_bgnd("замкнут",'@',0);
	else sub_bgnd("разомк.",'@',0);
	if(!SK_SIGN[3])sub_bgnd("замкнут",'#',0);
	else sub_bgnd("незамк.",'#',0);
	if(!SK_REL_EN[3])sub_bgnd("вкл.",'[',-2);
	else sub_bgnd("выкл.",'[',-2);
	if(!SK_LCD_EN[3])sub_bgnd("вкл.",'(',-2);
	else sub_bgnd("выкл.",'(',-2);


    


 
	}

else if(a_ind . i==iK)
	{
	char i;
	i=0;
	
	ptrs[i++]=" Сеть               ";
	if(NUMBAT)
     ptrs[i++]=" Батареи            ";
	if(NUMIST)
	ptrs[i++]=" БПС                ";
	if(NUMINV)
     ptrs[i++]=" Инверторы          ";
	ptrs[i++]=" Нагрузка           ";
     ptrs[i++]=" Внешние датчики    ";
     ptrs[i++]=" Силовые вводы      ";
     ptrs[i++]=" Выход              ";
     ptrs[i++]="                    ";
     ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     КАЛИБРОВКА     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}    	


else if(a_ind . i==iK_220_IPS_TERMOKOMPENSAT)
	{
	char i;
	i=0;
	
	ptrs[i++]=" Сеть               ";
	if(NUMBAT)
     ptrs[i++]=" Батареи            ";
	if(NUMIST)
	ptrs[i++]=" БПС                ";
	ptrs[i++]=" Выходные параметры ";
     if(NUMDT)
     ptrs[i++]=" Внешние датчики    ";
     ptrs[i++]=" Выход              ";
     ptrs[i++]="                    ";
     ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     КАЛИБРОВКА     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}   

else if(a_ind . i==iK_VD)
	{
	char i;
	i=0;
	
	ptrs[i++]=" Uвых.         !В   ";
	ptrs[i++]=" Iвых.         @А   ";
	if(NUMIST)
	ptrs[i++]=" БПС                ";
	ptrs[i++]=" Uв.д.         #В   ";
    ptrs[i++]=" Tсистемы  =   ^°C  ";;
    ptrs[i++]=" Выход              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     КАЛИБРОВКА     ",
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
	
	ptrs[i++]=" Сеть               ";
    ptrs[i++]=" Батарея            ";
	if(NUMIST)
	ptrs[i++]=" БПС                ";
	ptrs[i++]=" Выходные параметры ";
    if(NUMDT)
    ptrs[i++]=" Внешние датчики    ";
    ptrs[i++]=" Выход              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     КАЛИБРОВКА     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}   


else if(a_ind . i==iK_TELECORE)
	{
	char i;
	i=0;
	
	ptrs[i++]=	" Сеть               ";
	if(NUMBAT_TELECORE)
    ptrs[i++]=	" Батареи            ";
	if(NUMIST)
	ptrs[i++]=	" БПС                ";
	ptrs[i++]=	" Нагрузка           ";
    if(NUMDT)
    ptrs[i++]=	" Внешние датчики    ";
    ptrs[i++]=" Выход              ";
    ptrs[i++]="                    ";
    ptrs[i++]="                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     КАЛИБРОВКА     ",
			ptrs[a_ind . i_s],
			ptrs[a_ind . i_s+1],
			ptrs[a_ind . i_s+2]);

	pointer_set(1);	 
	}    	

else if(a_ind . i==iK_net)
	{
	ptrs[0]=" U =     @В         ";
     ptrs[1]=" Выход              ";
	ptrs[2]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("   КАЛИБРОВКА СЕТИ  ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

	pointer_set(1);	
	int2lcd(net_U,'@',0);
	
	
	
     }


else if(a_ind . i==iK_net3)
	{

	ptrs[0]=  		" UфA           !В   ";
    ptrs[1]=  		" UфB           @В   ";
    ptrs[2]=  	    " UфC           #В   ";
	ptrs[3]=  	    " Выход              ";


	bgnd_par(		"   КАЛИБРОВКА СЕТИ  ",
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
	ptrs[0]=" U =     @В         ";
     ptrs[1]=" Выход              ";
	ptrs[2]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(		" КАЛИБРОВКА НАГРУЗКИ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2]);

	pointer_set(1);
	if((load_U)>1000)int2lcd(load_U/10,'@',0);	
	else int2lcd(load_U,'@',1);
     }

else if(a_ind . i==iK_out)
	{
	ptrs[0]=" Uвыпр. =     @В    ";
    ptrs[1]=" Uшины  =     #В    ";
	ptrs[2]=" Выход              ";
	ptrs[3]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(	"КАЛИБРОВКА ВЫХОДНЫХ ",
				"     ПАРАМЕТРОВ     ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);

	pointer_set(2);
	
	if((bps_U)>1000)int2lcd(bps_U/10,'@',0);	
	else int2lcd(bps_U,'@',1);

	if((out_U)>1000)int2lcd(out_U/10,'#',0);	
	else int2lcd(out_U,'#',1);
    }

else if(a_ind . i==iK_t_ext)
	{
	ptrs[0]=  	" tвнеш.возд.    !°С ";
     ptrs[1]=  	" tотсек ЭПУ     @°С ";
     ptrs[2]=  	" tотсек MSAN    #°С ";
     ptrs[3]=	     " Выход              ";
	ptrs[4]=	     "                    ";
	ptrs[5]=	     "                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(		" КАЛИБРОВКА ВНЕШНИХ ",
				" ДАТЧИКОВ ТЕМПЕРАТУР",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	if(ND_EXT[0])sub_bgnd("неиспр.",'!',-3);
     else int2lcd_mmm(t_ext[0],'!',0);

	if(ND_EXT[1])sub_bgnd("неиспр.",'@',-3);
     else int2lcd_mmm(t_ext[1],'@',0);

	if(ND_EXT[2])sub_bgnd("неиспр.",'#',-3);
     else int2lcd_mmm(t_ext[2],'#',0);
     }

else if(a_ind . i==iK_t_ext_6U)
	{
	ptrs[0]=  		" t1             !°С ";
    ptrs[1]=  		" t2             @°С ";
    ptrs[2]=  		" t3             #°С ";
    ptrs[NUMDT]=	" Выход              ";
	ptrs[NUMDT+1]=  "                    ";
	ptrs[NUMDT+2]=  "                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(		" КАЛИБРОВКА ВНЕШНИХ ",
				" ДАТЧИКОВ ТЕМПЕРАТУР",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	if(ND_EXT[0])sub_bgnd("неиспр.",'!',-3);
     else int2lcd_mmm(t_ext[0],'!',0);

	if(ND_EXT[1])sub_bgnd("неиспр.",'@',-3);
     else int2lcd_mmm(t_ext[1],'@',0);

	if(ND_EXT[2])sub_bgnd("неиспр.",'#',-3);
     else int2lcd_mmm(t_ext[2],'#',0);
	
     }
     
else if(a_ind . i==iK_bat_sel)
	{
	ptrs[0]=						" Батарея N1         ";
     ptrs[1]=						" Батарея N2         ";
     if(BAT_IS_ON[0]!=bisON)ptrs[0]=	" Батарея N2         ";
	ptrs[0+NUMBAT]=				" Выход              ";
	ptrs[1+NUMBAT]=				"                    ";
	ptrs[2+NUMBAT]=				"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(" КАЛИБРОВКА БАТАРЕЙ ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
     }     

else if(a_ind . i==iK_bat_sel_TELECORE)
	{
	ptrs[0]=						" Батарея N1         ";
    ptrs[1]=						" Батарея N2         ";
    ptrs[0+NUMBAT_TELECORE]=		" Выход              ";
	ptrs[1+NUMBAT_TELECORE]=		"                    ";
	ptrs[2+NUMBAT_TELECORE]=		"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(" КАЛИБРОВКА БАТАРЕЙ ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
     }  

else if(a_ind . i==iK_bat_TELECORE)
	{
    ptrs[0]=		" Iбат =     #А      ";
    if(phase==0)
      	{
        ptrs[1]=	"   нажмите ¤ для    ";
        ptrs[2]=	"калибровки нуля Iбат";
        }
    else          
       	{
        ptrs[1]=	" откалибруйте Iбат  ";
        ptrs[2]=	"  нажатием љ или њ  ";
        }
	ptrs[3]=		" Выход              ";
    ptrs[4]=		"                    ";
    ptrs[5]=		"                    ";

	bgnd_par(		" КАЛИБРОВКА БАТ. N! ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2]);
     
   	if(a_ind . s_i==0)
     	{
     	if(phase==0)
     		{
			mess_send(205,208,0xffff,10);
     		mess_send(210,100,1,10);
			mess_send(200,202,(1<<a_ind . s_i1),10);
     		
     		}
    	else if(phase==1)
     		{
			mess_send(205,206,0xffff,10);
			mess_send(200,202,(1<<(1-a_ind . s_i1)),10);
     		
   			}
     		
     	}

	
	if((a_ind . s_i==0)||(a_ind . s_i==1)||(a_ind . s_i==2))a_ind . i_s=0;
	else a_ind . i_s=3;

	pointer_set(1);	
	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd_mmm(bat[a_ind . s_i1]._Ib,'#',2);

	}  	

else if(a_ind . i==iK_bat_ips_termokompensat_ib)
	{
     ptrs[0]=		" Iбат =     #А      ";
     ptrs[1]=		" откалибруйте Iбат  ";
     ptrs[2]=		"  нажатием љ или њ  ";
     ptrs[3]=		" Выход              ";
     ptrs[4]=		"                    ";
     ptrs[5]=		"                    ";

	bgnd_par(		" КАЛИБРОВКА БАТ. N1 ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2]);
     

	if((a_ind . s_i==0)||(a_ind . s_i==1)||(a_ind . s_i==2))a_ind . i_s=0;
	else if((a_ind . s_i==3)||(a_ind . s_i==4)||(a_ind . s_i==5))a_ind . i_s=3;
	


	pointer_set(1);	
	
	if(bIBAT_SMKLBR)sub_bgnd("КЛБР. ",'#',-4);
	else int2lcd_mmm(Ib_ips_termokompensat,'#',2);

	
	}  	

  

else if(a_ind . i==iInv_set)
	{
	ptrs[0]=						" Минимальное напр.  ";
     ptrs[1]=						" выхода          <В ";
     ptrs[2]=						" Максимальное напр. ";
	ptrs[3]=						" выхода          >В ";
	ptrs[4]=					  	" Выход              ";
	ptrs[5]=						"                    ";
	ptrs[6]=						"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("    ИНВЕРТОР N!     ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd(inv[a_ind . s_i1]._Uoutmin,'<',0);
	int2lcd(inv[a_ind . s_i1]._Uoutmax,'>',0);
	}     

else if(a_ind . i==iK_makb_sel)
	{
	ptrs[0]=						" Монитор АКБ N1     ";
     ptrs[1]=						" Монитор АКБ N2     ";
     ptrs[2]=						" Монитор АКБ N3     ";
	ptrs[3]=						" Монитор АКБ N4     ";
	ptrs[NUMMAKB]=					" Выход              ";
	ptrs[1+NUMMAKB]=				"                    ";
	ptrs[2+NUMMAKB]=				"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("КАЛИБРОВАТЬ МОНИТОРЫ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
     }     

else if(a_ind . i==iK_makb)
	{
	ptrs[0]=						" U1  =    !В        ";
	ptrs[1]=						" U2  =    @В        ";
	ptrs[2]=						" U3  =    #В        ";
	ptrs[3]=						" U4  =    $В        ";
	ptrs[4]=						" U5  =    %В        ";
	ptrs[5]=						" t1  =    ^°C       ";
	ptrs[6]=						" t2  =    &°C       ";
	ptrs[7]=						" t3  =    *°C       ";
	ptrs[8]=						" t4  =    (°C       ";
	ptrs[9]=						" t5  =    )°C       ";
	ptrs[10]=						" Выход              ";
	ptrs[11]=						"                    ";

	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     КАЛИБРОВКА     ","   МОНИТОР АКБ N<   ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1]);
	pointer_set(2);
	simax=10;

	int2lcd(a_ind . s_i1+1,'<',0);
	int2lcd(makb[a_ind . s_i1]._U[0],'!',1);
	int2lcd(makb[a_ind . s_i1]._U[1],'@',1);
	int2lcd(makb[a_ind . s_i1]._U[2],'#',1);
	int2lcd(makb[a_ind . s_i1]._U[3],'$',1);
	int2lcd(makb[a_ind . s_i1]._U[4],'%',1);

	if(makb[a_ind . s_i1]._T_nd[0])sub_bgnd("НЕПОДКЛЮЧЕН",'^',-5);
	else int2lcd_mmm(makb[a_ind . s_i1]._T[0],'^',0); 
	if(makb[a_ind . s_i1]._T_nd[1])sub_bgnd("НЕПОДКЛЮЧЕН",'&',-5);
	else int2lcd_mmm(makb[a_ind . s_i1]._T[1],'&',0); 
	if(makb[a_ind . s_i1]._T_nd[2])sub_bgnd("НЕПОДКЛЮЧЕН",'*',-5);
	else int2lcd_mmm(makb[a_ind . s_i1]._T[2],'*',0); 
	if(makb[a_ind . s_i1]._T_nd[3])sub_bgnd("НЕПОДКЛЮЧЕН",'(',-5);
	else int2lcd_mmm(makb[a_ind . s_i1]._T[3],'(',0); 
	if(makb[a_ind . s_i1]._T_nd[4])sub_bgnd("НЕПОДКЛЮЧЕН",')',-5);
	else int2lcd_mmm(makb[a_ind . s_i1]._T[4],')',0); 






 
	
     }   

else if(a_ind . i==iK_bps_sel)
	{
	ptrs[0]=						" БПС N1             ";
     ptrs[1]=						" БПС N2             ";
     ptrs[2]=						" БПС N3             ";
	ptrs[3]=						" БПС N4             ";
     ptrs[4]=						" БПС N5             ";
     ptrs[5]=						" БПС N6             ";
	ptrs[6]=						" БПС N7             ";
     ptrs[7]=						" БПС N8             ";
     ptrs[8]=						" БПС N9             ";
	ptrs[9]=						" БПС N10            ";
     ptrs[10]=						" БПС N11            ";
     ptrs[11]=						" БПС N12            ";               
	ptrs[NUMIST]=					" Выход              ";
	ptrs[1+NUMIST]=				"                    ";
	ptrs[2+NUMIST]=				"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("  КАЛИБРОВКА БПСов  ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
     }     

else if(a_ind . i==iK_bps)
	{
	
	ptrs[0]=" Uист =    @В       ";
    ptrs[1]=" откалибруйте Uист  ";
	ptrs[2]="  нажатием љ или њ  "; 
	ptrs[3]=" Uшины =   #В       ";
    ptrs[4]=" откалибруйте Uнагр ";
    ptrs[5]="  нажатием љ или њ  ";
	ptrs[6]=" Uавтон =   $В      ";
	if(bFL_)
		{
		ptrs[7]=" установите Uавтон  ";
     	ptrs[8]="  нажатием љ или њ  ";
     	}
    else 
     	{
		ptrs[7]=" удерживайте ¤ для  ";
     	ptrs[8]="    запоминания     ";     	
     	}	
	ptrs[9]=" Iист =     %А      ";
	if(phase==0)
    	{
        ptrs[10]=	"   нажмите ¤ для    ";
        ptrs[11]=	"калибровки нуля Iист";
        }
    else
     	{
        ptrs[10]=" откалибруйте Iист  ";
        ptrs[11]="  нажатием љ или њ  ";     	
     	} 
     	
    ptrs[12]=" tист =   ^°C       ";    
	ptrs[13]=" откалибруйте tист  ";
    ptrs[14]="  нажатием љ или њ  ";
	ptrs[15]=" Uвых  =    &В      ";
    ptrs[16]=" откалибруйте Uвых  ";
	ptrs[17]="  нажатием љ или њ  ";
    ptrs[18]=sm_exit;
    ptrs[19]=sm_;
    ptrs[20]=sm_;     	     	    
	

    if((a_ind . s_i==0)||(a_ind . s_i==1)||(a_ind . s_i==2))a_ind . i_s=0;
	else if((a_ind . s_i==3)||(a_ind . s_i==4)||(a_ind . s_i==5))a_ind . i_s=3;
	else if((a_ind . s_i==6)||(a_ind . s_i==7)||(a_ind . s_i==8))a_ind . i_s=6;
	else if((a_ind . s_i==9)||(a_ind . s_i==10)||(a_ind . s_i==11))a_ind . i_s=9;
	else if((a_ind . s_i==12)||(a_ind . s_i==13)||(a_ind . s_i==14))a_ind . i_s=12;
	else if((a_ind . s_i==15)||(a_ind . s_i==16)||(a_ind . s_i==17))a_ind . i_s=15;	
	else a_ind . i_s=18;
	
	bgnd_par(" КАЛИБРОВКА БПС N! ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

	pointer_set(1);	
	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd(bps[a_ind . s_i1]._Uii,'@',1);
	int2lcd(bps[a_ind . s_i1]._Uin,'#',1);
	int2lcd(U_AVT,'$',1);
	int2lcd(bps[a_ind . s_i1]._Ii,'%',1);
	int2lcd(bps[a_ind . s_i1]._Ti,'^',0); 
	int2lcd(bps[a_ind . s_i1]._Uisum,'&',1);
	 
	
    if((a_ind . s_i==0)||(a_ind . s_i==3))
		{
		mess_send(205,208,(1<<a_ind . s_i1),10);
		mess_send(200,201,0,10);
	    mess_send(225,229,2000,10);
        }
  	if(a_ind . s_i==6)
		{
        mess_send(205,208,(1<<a_ind . s_i1),10);
        mess_send(200,201,0,40);
        mess_send(190,191,U_AVT,10);
	   	mess_send(225,230,0,10);
		}

    if(a_ind . s_i==9)
		{
		if(phase==0)
			{
          	mess_send(205,208,~(1<<a_ind . s_i1),10);
          	}
      	else if(phase==1)
			{
          	mess_send(205,208,(1<<a_ind . s_i1),10);
			mess_send(200,201,0,10);
          	}
       	mess_send(225,229,2000,10);
        }
	
    if(a_ind . s_i==12)
		{
        }	

    if(a_ind . s_i==15)
		{
		mess_send(205,208,(1<<a_ind . s_i1),10);
		mess_send(200,201,0,10);
	    mess_send(225,229,2000,10);
        }          
          
	if(mess_find( (215)) && (mess_data[0]==217) )
		{
		show_mess("     Установка      ",
	          	"    напряжения      ",
	          	" автономной работы  ",
	          	"    произведена     ",3000);
		}	     
	     
	
	






 






	 }


else if(a_ind . i==iRele_set)
	{
	ptrs[0]=				" Реле N1            ";
    ptrs[1]=				" Реле N2            ";
    ptrs[2]=				" Реле N3            ";
	ptrs[3]=				" Реле N4            ";
	ptrs[4]=				" Выход              ";
	ptrs[5]=				"                    ";
	ptrs[6]=				"                    ";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(	"   НАСТРОЙКА РЕЛЕ   ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
     }     

else if(a_ind . i==iRele_set_)
	{
	
	ptrs[0]=	" Авария модуля     @";
    ptrs[1]=	" Пергрузка системы  ";
	ptrs[2]=	"  по току          #"; 
	ptrs[3]=	" Перегрев системы  $";
    ptrs[4]=	" Uвых. занижено    %";
    ptrs[5]=	" Uвых. завышено    ^";
	ptrs[6]=	" Uвх. занижено     [";
	ptrs[7]=	" Uвх. завышено     ]";
	ptrs[8]=	" Ресурс вентилятора ";
	ptrs[9]=	"  израсходован     {";
	ptrs[10]=	" Uв.д. > 2В        }";
    ptrs[11]=	sm_exit;
    ptrs[12]=	sm_;
    ptrs[13]=	sm_;     	     	    
	

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	
	bgnd_par(	" Реле N! срабатыв. ",
				ptrs[a_ind . i_s],
				ptrs[a_ind . i_s+1],
				ptrs[a_ind . i_s+2]);

	pointer_set(1);	

	int2lcd(a_ind . s_i1+1,'!',0); 
 	checkboxing('@',RELE_SET_MASK[a_ind . s_i1]&(1<<0));
	checkboxing('#',RELE_SET_MASK[a_ind . s_i1]&(1<<1));
 	checkboxing('$',RELE_SET_MASK[a_ind . s_i1]&(1<<2));
	checkboxing('%',RELE_SET_MASK[a_ind . s_i1]&(1<<3));
 	checkboxing('^',RELE_SET_MASK[a_ind . s_i1]&(1<<4));
	checkboxing('[',RELE_SET_MASK[a_ind . s_i1]&(1<<5));
 	checkboxing(']',RELE_SET_MASK[a_ind . s_i1]&(1<<6));
	checkboxing('{',RELE_SET_MASK[a_ind . s_i1]&(1<<7));
	checkboxing('}',RELE_SET_MASK[a_ind . s_i1]&(1<<8));
	
	
	
	
	}


else if(a_ind . i==iK_power_net)
	{
	ptrs[0]=" Uввод=    @В       ";
	ptrs[1]=" Uпэс =    #В       ";
     ptrs[2]=" Выход              ";
	ptrs[3]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par( "      КАЛИБРОВКА    ",
               "   СИЛОВЫХ ВВОДОВ   ",
               ptrs[a_ind . i_s],
               ptrs[a_ind . i_s+1]);

	pointer_set(2);	
	int2lcd(Uvv[0],'@',0);
     int2lcd(Uvv[1],'#',0);
	
	
	
     }


else if(a_ind . i==iK_power_net3)
	{
     ptrs[0]=  		" Ввод ф.A    !В     ";
	ptrs[1]=  		" Ввод ф.B    @В     ";
	ptrs[2]=  		" Ввод ф.C    #В     ";
     ptrs[3]=  	     " ПЭС  ф.A    &В     ";
     ptrs[4]=  	     " ПЭС  ф.B    *В     ";
     ptrs[5]=  	     " ПЭС  ф.C    (В     ";		            
     ptrs[6]=" Выход              ";
	ptrs[7]="                    ";
	
	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par( "      КАЛИБРОВКА    ",
               "   СИЛОВЫХ ВВОДОВ   ",
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
		int2lcdyx(cntrl_stat,2,19,0);

      

     	}     

    	else if(a_ind . s_i==1) 
     	{
     	bgnd_par("Б                   ",
     	         "                    ",
     	         "                    ",
     	         "                    ");

		
		
		
		

				
		

 







 

		int2lcdyx(a_ind . s_i1+0,1,0,0);
		int2lcdyx(a_ind . s_i1+1,2,0,0);
		int2lcdyx(a_ind . s_i1+2,3,0,0);
		
		
		int2lcdyx(bps[a_ind . s_i1  ]._cnt,1,2,0);
		int2lcdyx(bps[a_ind . s_i1+1]._cnt,2,2,0);
		int2lcdyx(bps[a_ind . s_i1+2]._cnt,3,2,0);		
		
	

 			
		
	











 
		int2lcdyx(bps[a_ind . s_i1]._Ii,1,15,0);
		int2lcdyx(bps[a_ind . s_i1+1]._Ii,2,15,0);
		int2lcdyx(bps[a_ind . s_i1+2]._Ii,3,15,0);
	



 
		
		int2lcdyx(bps[a_ind . s_i1]._rotor,1,19,0);
		int2lcdyx(bps[a_ind . s_i1+1]._rotor,2,19,0);
		int2lcdyx(bps[a_ind . s_i1+2]._rotor,3,19,0);


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
		long2lcdhyx(avar_stat,2,14);
		long2lcdhyx(avar_ind_stat,3,14);
		}  

	else if(a_ind . s_i==3)
     	{
     	bgnd_par("КЕ                  ",
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
		
		int2lcdyx(bps[0]._Ii,0,5,0);
		int2lcdyx(bps[1]._Ii,0,9,0);
		
		int2lcdyx(plazma_cntrl_stat,0,19,0);
		
		int2lcdyx(Ubpsmax,1,3,0);
		int2lcdyx(Ibmax,1,7,0);
		int2lcdyx(cntrl_stat,1,11,0);
		int2lcdyx(load_U,1,19,0);
			
		int2lcdyx(lakb[0]._balanced_event_code ,2,2,0);
	   	int2lcdyx(lakb[1]._balanced_event_code ,3,2,0);
		
	 	int2lcd_mmm(lakb[0]._ch_curr/10,'!',0);
		int2lcd_mmm(lakb[1]._ch_curr/10,'@',0);		
		
	 	int2lcd_mmm(bat[0]._Ib/10,'#',0);
		int2lcd_mmm(bat[1]._Ib/10,'$',0);




		
	   	

		int2lcdyx(IMAX,0,13,0);
		
		int2lcdyx(lakb[0]._voltage_event_code,2,15,0); 
		int2lcdyx(lakb[1]._voltage_event_code,3,15,0);



		
		

		
		


		




		
		
		

		
		
 		

		

		

		
		
		 
		
		
		
		
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
#line 5110 "main.c"
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
		int2lcdyx(lakb[a_ind . s_i1]._cnt,0,6,0);

		int2lcdyx(lakb[a_ind . s_i1]._max_cell_temp,0,14,0);
		int2lcdyx(lakb[a_ind . s_i1]._min_cell_temp,0,19,0);

		int2lcdyx(lakb[a_ind . s_i1]._max_cell_volt,1,4,0);
		int2lcdyx(lakb[a_ind . s_i1]._min_cell_volt,1,9,0);
		int2lcdyx(lakb[a_ind . s_i1]._tot_bat_volt,1,14,0);
		int2lcdyx(lakb[a_ind . s_i1]._s_o_h,1,19,0);

		int2lcdyx(lakb[a_ind . s_i1]._ch_curr,2,4,0);
		int2lcdyx(lakb[a_ind . s_i1]._dsch_curr,2,9,0);
		int2lcdyx(lakb[a_ind . s_i1]._rat_cap,2,14,0);
		int2lcdyx(lakb[a_ind . s_i1]._s_o_c,2,19,0);

		int2lcdyx(lakb[a_ind . s_i1]._c_c_l_v,3,4,0);
		int2lcdyx(lakb[a_ind . s_i1]._r_b_t,3,9,0);
		int2lcdyx(lakb[a_ind . s_i1]._b_p_ser_num,3,14,0);
		
		
		
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
		int2lcdyx(bps[0]._Uin,0,15,0);
		int2lcdyx(bps[1]._Uii,0,19,0);

		int2lcdyx(li_bat._Ub,1,3,0);


		int2lcdyx(lakb[0]._tot_bat_volt,1,8,0);   

		int2lcdyx(cntrl_stat,1,19,0);
		
		int2lcdyx(lakb_error_cnt,3,19,0);



		
		
		
		

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

else if((a_ind . i==iAv_view)||(a_ind . i==iAv_view_avt))
	{


	
	bgnd_par(sm_,sm_,sm_,sm_);
	if(a_ind . s_i==0)
		{	
		if(avar_stat&0x00000001)
			{
			bgnd_par(	"    Авария  сети    ",
				    	"    не устранена    ",
				    	sm_,sm_); 
			int2lcd(net_U,']',0);
			}
    		else 
			{
	    		bgnd_par(	"    Авария  сети    ",
	    				"     устранена      ",
					sm_,sm_); 
			}
		}
	else if((a_ind . s_i==1)||(a_ind . s_i==2))
		{
		if(avar_stat&(1<<a_ind . s_i))
			{
			bgnd_par(	"   Авария бат. N!   ",
				    	"    не устранена    ",
				    	sm_,sm_); 
			}
    		else 
			{
	    		bgnd_par(	"   Авария бат. N!   ",
	    				"     устранена      ",
					sm_,sm_); 
		
		     }
		int2lcd(a_ind . s_i,'!',0);
		} 
     
	else if((a_ind . s_i>=3)&&(a_ind . s_i<=14))
		{
		if((a_ind . s_i-2)<=9)					ptrs[0]=	"   Авария БПС N+    ";
		else 							ptrs[0]=	"   Авария БПС N +   ";
		if(bps[a_ind . s_i-3]._last_avar==0)		ptrs[1]=	"     перегрев!!!    ";
		else if(bps[a_ind . s_i-3]._last_avar==1)	ptrs[1]=	"  завышено Uвых!!!  ";	
		else if(bps[a_ind . s_i-3]._last_avar==2)	ptrs[1]=	"  занижено Uвых!!!  ";	
		else if(bps[a_ind . s_i-3]._last_avar==3)	ptrs[1]=	"    отключился!!!   ";
		if(avar_stat&(1<<a_ind . s_i)) 			ptrs[2]=	"    не устранена    ";
		else								ptrs[2]=	"     устранена      ";	
										ptrs[3]=	"                    ";

		bgnd_par(ptrs[0],ptrs[1],ptrs[2],ptrs[3]);
		int2lcd((a_ind . s_i-2),'+',0);
          
		

		} 
		
	else if(a_ind . s_i==24)
		{ 

		if(sk_av_stat[0]==sasON)
			{
			bgnd_par(	"   Авария СК. N1    ",
				    	"    не устранена    ",
				    	sm_,sm_); 
			}
    		else 
			{
	    		bgnd_par(	"   Авария СК. N1    ",
	    				"     устранена      ",
					sm_,sm_); 
		
		     }

		}

	else if(a_ind . s_i==25)
		{ 

		if(sk_av_stat[1]==sasON)
			{
			bgnd_par(	"   Авария СК. N2    ",
				    	"    не устранена    ",
				    	sm_,sm_); 
			}
    		else 
			{
	    		bgnd_par(	"   Авария СК. N2    ",
	    				"     устранена      ",
					sm_,sm_); 
		
		     }

		}

	else if(a_ind . s_i==26)
		{ 

		if(sk_av_stat[2]==sasON)
			{
			bgnd_par(	"   Авария СК. N3    ",
				    	"    не устранена    ",
				    	sm_,sm_); 
			}
    		else 
			{
	    		bgnd_par(	"   Авария СК. N3    ",
	    				"     устранена      ",
					sm_,sm_); 
		
		     }

		}

	else if(a_ind . s_i==27)
		{ 

		if(sk_av_stat[3]==sasON)
			{
			bgnd_par(	"   Авария СК. N4    ",
				    	"    не устранена    ",
				    	sm_,sm_); 
			}
    		else 
			{
	    		bgnd_par(	"   Авария СК. N4    ",
	    				"     устранена      ",
					sm_,sm_); 
		
		     }

		}

	else if(a_ind . s_i==28)
		{ 
		if(avar_stat&(1<<a_ind . s_i))
			{
			bgnd_par(	"  Авария выходного  ",
				    	"    напряжения!!!   ",
				    	sm_,sm_); 
			}

		}

	else if(a_ind . s_i==5)
		{

		}

	else if(a_ind . s_i==6)
		{

		}

	else if(a_ind . s_i==7)
		{

		} 
		
	else if(a_ind . s_i==8)
		{

		}

	else if(a_ind . s_i==9)
		{

		}

	else if(a_ind . s_i==10)
		{

		}
	    		     
	else if(a_ind . s_i==11)
		{

		} 
		
	else if(a_ind . s_i==12)
		{

		}

	else if(a_ind . s_i==13)
		{

		}

	else if(a_ind . s_i==14)
		{

		}

	else if(a_ind . s_i==15)
		{

		} 
					
	} 



else if(a_ind . i==iTst_VD)
	{
	ptrs[0]=						" Реле аварии        ";
    ptrs[1]=						" 1                 !";
    ptrs[2]=						" Реле аварии        ";
    ptrs[3]=						" 2                 @";
    ptrs[4]=						" Реле аварии        ";
    ptrs[5]=						" 3                 #";
	ptrs[6]=						" Реле аварии        ";
    ptrs[7]=						" 4                 $";
	ptrs[8]=						" БПС N1             ";
    ptrs[9]=						" БПС N2             ";
    ptrs[10]=						" БПС N3             ";
	ptrs[11]=						" БПС N4             ";
    ptrs[12]=						" БПС N5             ";
    ptrs[13]=						" БПС N6             ";
	ptrs[14]=						" БПС N7             ";
    ptrs[15]=						" БПС N8             ";
    ptrs[16]=						" БПС N9             ";               
	ptrs[17]=						" БПС N10            ";
    ptrs[18]=						" БПС N11            ";
    ptrs[19]=						" БПС N12            ";               
	ptrs[8+NUMIST]=					" Выход              ";
	ptrs[9+NUMIST]=					" Проверка WDT(внутр)";
	ptrs[10+NUMIST]=				" Проверка WDT(внешн)";

	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("        ТЕСТ        ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);


 

	
	

	if(tst_state[0]==tst1) sub_bgnd("ВКЛ.",'!',-3);
	if(tst_state[0]==tst2) sub_bgnd("ВЫКЛ.",'!',-4);
	else sub_bgnd("РАБОЧ.",'!',-5);

	if(tst_state[1]==tst1) sub_bgnd("ВКЛ.",'@',-3);
	if(tst_state[1]==tst2) sub_bgnd("ВЫКЛ.",'@',-4);
	else sub_bgnd("РАБОЧ.",'@',-5);

	if(tst_state[2]==tst1) sub_bgnd("ВКЛ.",'#',-3);
	if(tst_state[2]==tst2) sub_bgnd("ВЫКЛ.",'#',-4);
	else sub_bgnd("РАБОЧ.",'#',-5);

	if(tst_state[3]==tst1) sub_bgnd("ВКЛ.",'$',-3);
	if(tst_state[3]==tst2) sub_bgnd("ВЫКЛ.",'$',-4);
	else sub_bgnd("РАБОЧ.",'$',-5);
	
	if(a_ind . s_i==0)
		{
		if(tst_state[0]==tst1)mess_send(210,101,1,5);
		else if(tst_state[0]==tst2)mess_send(210,101,0,5);
		}
	else if(a_ind . s_i==2)
		{
		if(tst_state[1]==tst1)mess_send(210,102,1,5);
		else if(tst_state[1]==tst2)mess_send(210,102,0,5);
		}	
	else if(a_ind . s_i==4)
		{
		if(tst_state[2]==tst1)mess_send(210,103,1,5);
		else if(tst_state[2]==tst2)mess_send(210,103,0,5);
		}
	else if(a_ind . s_i==6)
		{
		if(tst_state[3]==tst1)mess_send(210,104,1,5);
		else if(tst_state[3]==tst2)mess_send(210,104,0,5);
		}
	}

else if(a_ind . i==iTst_bps)
	{
	if(tst_state[5]==tstOFF)ptrs[0]=		" Выключен           ";
	else if(tst_state[5]==tst1)ptrs[0]=		" Включен            ";

    ptrs[1]=								" ШИМ              @ ";
    ptrs[2]=								" U =  .$В  I =  .#A ";
	ptrs[3]=								" Выход              ";


	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par("     ТЕСТ БПС N!    ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);
	pointer_set(1);

	if(tst_state[6]==tst1) sub_bgnd("Umax",'@',-3); 
	else sub_bgnd("Umin",'@',-3);




	

 
	
	

	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd(bps[a_ind . s_i1]._Ii,'#',1);
	int2lcd(bps[a_ind . s_i1]._Uii,'$',1);


	if(tst_state[5]==tstOFF) mess_send(205,208,~(1<<a_ind . s_i1),10);
	else mess_send(205,208,(1<<a_ind . s_i1),10);
	
	
	
	if(a_ind . s_i==0)mess_send(225,229,1020,10);	
	else if(tst_state[6]==tstOFF) mess_send(225,229,30,10);
	else if(tst_state[6]==tst1) mess_send(225,229,1020,10);

























 




	}	 
else if(a_ind . i==iKlimat)
	{
	ptrs[0]=				" tшк.max=       !°C ";
	ptrs[1]=				" tвент.max=     @°C ";
	ptrs[2]=				" tшк.рег.=      #°C ";
	ptrs[3]=				" tоткл.нагр.    $°C ";
	ptrs[4]=				" tвкл.нагр.     %°C ";
	ptrs[5]=				" tоткл.бат.     ^°C ";
	ptrs[6]=				" tвкл.бат.      &°C ";
	ptrs[7]=				" Выход              ";



	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(				"   КЛИМАТКОНТРОЛЬ   ",
						ptrs[a_ind . i_s],
						ptrs[a_ind . i_s+1],
						ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
	int2lcd(TBOXMAX,'!',0); 
	if((TBOXVENTMAX>=50)&&(TBOXVENTMAX<=80))int2lcd(TBOXVENTMAX,'@',0); 
	else sub_bgnd("ВЫКЛ.",'@',-2);
	int2lcd(TBOXREG,'#',0);
	if((TLOADDISABLE>=50)&&(TLOADDISABLE<=80))int2lcd(TLOADDISABLE,'$',0);
	else sub_bgnd("ВЫКЛ.",'$',-2);
	if((TLOADDISABLE>=50)&&(TLOADDISABLE<=80) )int2lcd(TLOADENABLE,'%',0);
	else sub_bgnd("ВЫКЛ.",'%',-2);
	if((TBATDISABLE>=50)&&(TBATDISABLE<=90))int2lcd(TBATDISABLE,'^',0);
	else sub_bgnd("ВЫКЛ.",'^',-2);
	if((TBATDISABLE>=50)&&(TBATDISABLE<=90) )int2lcd(TBATENABLE,'&',0);
	else sub_bgnd("ВЫКЛ.",'&',-2);
	}

else if(a_ind . i==iKlimat_kontur)
	{
	ptrs[0]=				" tшк.max=       !°C ";
	ptrs[1]=				" tвент.max=     @°C ";
	ptrs[2]=				" tшк.рег.=      #°C ";
	ptrs[3]=				" tвкл.отопит.   $°C ";
	ptrs[4]=				" tоткл.отопит.  %°C ";
	ptrs[5]=				" tоткл.нагруз.  ^°C ";
	ptrs[6]=				" tвкл.нагруз.   &°C ";
	ptrs[7]=				" tоткл.бат.     *°C ";
	ptrs[8]=				" tвкл.бат.      (°C ";
	ptrs[9]=				" Выход              ";



	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(				"   КЛИМАТКОНТРОЛЬ   ",
						ptrs[a_ind . i_s],
						ptrs[a_ind . i_s+1],
						ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
	int2lcd(TBOXMAX,'!',0); 

 
	if((TBOXVENTMAX>=50)&&(TBOXVENTMAX<=80))int2lcd(TBOXVENTMAX,'@',0); 
	else sub_bgnd("ВЫКЛ.",'@',-2);
	int2lcd(TBOXREG,'#',0);
	int2lcd_mmm(TBOXWARMON,'$',0); 
	int2lcd_mmm(TBOXWARMOFF,'%',0);
	if((TLOADDISABLE>=50)&&(TLOADDISABLE<=80))int2lcd(TLOADDISABLE,'^',0);
	else sub_bgnd("ВЫКЛ.",'^',-2);
	if((TLOADDISABLE>=50)&&(TLOADDISABLE<=80))int2lcd(TLOADENABLE,'&',0);
	else sub_bgnd("ВЫКЛ.",'&',-2);
	if((TBATDISABLE>=50)&&(TBATDISABLE<=90))int2lcd(TBATDISABLE,'*',0);
	else sub_bgnd("ВЫКЛ.",'*',-2);
	if((TBATDISABLE>=50)&&(TBATDISABLE<=90))int2lcd(TBATENABLE,'(',0);
	else sub_bgnd("ВЫКЛ.",'(',-2);





	
	int2lcdyx(t_box,0,19,0);	 
	}
#line 5849 "main.c"

else if(a_ind . i==iNpn_set)
	{
	ptrs[0]=				" Вывод          !   ";
	if(NPN_OUT==npnoOFF)
		{
		ptrs[1]=			" Выход              ";
		ptrs[2]=			"                    ";
		simax=1;
		}
	else 
		{














 

			ptrs[1]=		" Uоткл.н.п.н.    $В ";
			ptrs[2]=		" Uвкл.н.п.н.     %В ";
			ptrs[3]=		" Tз.н.п.н.       #с.";
			ptrs[4]=		" Выход              ";
			simax=4;
		}


	if((a_ind . s_i-a_ind . i_s)>2)a_ind . i_s=a_ind . s_i-2;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(				" Отключение Н.П.Н.  ",
							ptrs[a_ind . i_s],
							ptrs[a_ind . i_s+1],
							ptrs[a_ind . i_s+2]);
	pointer_set(1);
	
	if(NPN_OUT==npnoRELEVENT) sub_bgnd("Реле вент-ра",'!',-8);
	else if(NPN_OUT==npnoRELEAVBAT2) sub_bgnd("Реле АВ.БАТ2",'!',-8);
	else sub_bgnd("Выкл.",'!',-1);


	int2lcd(TZNPN,'#',0);
	int2lcd(UONPN,'$',1);
	int2lcd(UVNPN,'%',1);

	}



else if(a_ind . i==iBps_list)
     {
     if(a_ind . s_i==0)
     	{
     	bgnd_par(" N  L   U    I    t ",
     	         " !  @    ^    $    #",
     	         " !  @    ^    $    #",
     	         " !  @    ^    $    #");
      

     	}     

    else if(a_ind . s_i==1) 
     	{
      	bgnd_par(" N  L   U    I   Uн ",
     	         " !  @    ^    $    %",
     	         " !  @    ^    $    %",
     	         " !  @    ^    $    %");

		} 

    else if(a_ind . s_i==2) 
     	{
      	bgnd_par(" N   U    I   pwm ВТ",
     	         " !    ^    $   &   (",
     	         " !    ^    $   &   (",
     	         " !    ^    $   &   (");

		}

 	else if(a_ind . s_i==3) 
     	{
      	bgnd_par(" N   U    I   pwm пр",
     	         " !    ^    $   &   )",
     	         " !    ^    $   &   )",
     	         " !    ^    $   &   )");

		}


	int2lcd(a_ind . s_i1+1,'!',0);
	int2lcd(a_ind . s_i1+2,'!',0);
	if(a_ind . s_i1==NUMIST-2) sub_bgnd("Ш",'!',0);
	else int2lcd(a_ind . s_i1+3,'!',0);

	int2lcd(bps[a_ind . s_i1]._cnt,'@',0);
	int2lcd(bps[a_ind . s_i1+1]._cnt,'@',0);
	if(a_ind . s_i1==NUMIST-2)int2lcd(ibat_metr_cnt,'@',0);
	else int2lcd(bps[a_ind . s_i1+2]._cnt,'@',0);		
		
	int2lcd(bps[a_ind . s_i1]._Uii/10,'^',0);
	int2lcd(bps[a_ind . s_i1+1]._Uii/10,'^',0);
	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2]._Uii/10,'^',0);
	else sub_bgnd(" ",'^',0);

     int2lcd(bps[a_ind . s_i1]._Ii,'$',1); 
	int2lcd(bps[a_ind . s_i1+1]._Ii,'$',1); 
	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2]._Ii,'$',1); 
	else int2lcd_mmm(Ib_ips_termokompensat,'$',0);

	int2lcd(bps[a_ind . s_i1]._Uin/10,'%',0);
	int2lcd(bps[a_ind . s_i1+1]._Uin/10,'%',0);
	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2]._Uin/10,'%',0);
	else sub_bgnd(" ",'%',0);

	int2lcd(bps[a_ind . s_i1]._Ti,'#',0);
	int2lcd(bps[a_ind . s_i1+1]._Ti,'#',0); 
   	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2]._Ti,'#',0);
	else sub_bgnd(" ",'#',0);

	int2lcd(bps[a_ind . s_i1].debug_info_to_uku0,'&',0);
	int2lcd(bps[a_ind . s_i1+1].debug_info_to_uku0,'&',0);
	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2].debug_info_to_uku0,'&',0);
	else sub_bgnd(" ",'&',0);

	int2lcd(bps[a_ind . s_i1]._x_+50,'(',0);
	int2lcd(bps[a_ind . s_i1+1]._x_+50,'(',0);
	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2]._x_+50,'(',0);
	else sub_bgnd(" ",'(',0);

	int2lcd(bps[a_ind . s_i1]._avg,')',0);
	int2lcd(bps[a_ind . s_i1+1]._avg,')',0);
	if(a_ind . s_i1<NUMIST-2) int2lcd(bps[a_ind . s_i1+2]._avg,')',0);
	else sub_bgnd(" ",')',0);

	}
	
else if(a_ind . i==iAvt_set_sel)
	{
	ptrs[0]=						" БПС N1             ";
     ptrs[1]=						" БПС N2             ";
     ptrs[2]=						" БПС N3             ";
	ptrs[3]=						" БПС N4             ";
     ptrs[4]=						" БПС N5             ";
     ptrs[5]=						" БПС N6             ";
	ptrs[6]=						" БПС N7             ";
     ptrs[7]=						" БПС N8             ";
     ptrs[8]=						" БПС N9             ";
	ptrs[9]=						" БПС N10            ";
     ptrs[10]=						" БПС N11            ";
     ptrs[11]=						" БПС N12            ";               
	ptrs[NUMIST]=					" Выход              ";
	ptrs[1+NUMIST]=				"                    ";
	ptrs[2+NUMIST]=				"                    ";


	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(				"УСТАНОВКА НАПРЯЖЕНИЯ",
						" АВТОНОМНОЙ РАБОТЫ  ",
						ptrs[a_ind . i_s],
						ptrs[a_ind . i_s+1]);
	pointer_set(2);

	}		 

else if(a_ind . i==iAvt_set)
	{
	ptrs[0]=" Uавтон =   $В      ";
	if(bFL_)
		{
		ptrs[1]=" установите Uавтон  ";
     	ptrs[2]="  нажатием љ или њ  ";
     	}
     else 
     	{
		ptrs[1]=" удерживайте ¤ для  ";
     	ptrs[2]="    запоминания     ";     	
     	}	

     ptrs[3]=sm_exit;
     ptrs[4]=sm_;
     ptrs[5]=sm_;     	     	    
	

     if((a_ind . s_i==0)||(a_ind . s_i==1)||(a_ind . s_i==2))a_ind . i_s=0;
	else a_ind . i_s=3;
	
	bgnd_par("       БПС N!      ",ptrs[a_ind . i_s],ptrs[a_ind . i_s+1],ptrs[a_ind . i_s+2]);

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
		show_mess(	"     Установка      ",
	          		"    напряжения      ",
	          		" автономной работы  ",
	          		"    произведена     ",3000);
		
		}
	
	 }
else if(a_ind . i==iOut_volt_contr)
	{
	ptrs[0]=" Uвыхmax         !В ";
    ptrs[1]=" Uвыхmin         @В ";
    ptrs[2]=" Tздрж.ав.       #с.";     	
    ptrs[3]=sm_exit;
    ptrs[4]=sm_;
    ptrs[5]=sm_;     	     	    
	

	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i-1;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	
	bgnd_par(	"КОНТРОЛЬ ВЫХОДНОГО ",
				"    НАПРЯЖЕНИЯ     ",
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
		ptrs[0]=	" Индикация          ";
		ptrs[1]=	" ускоренного заряда ";
		}
	else  
		{
		ptrs[0]=	" Индикация          ";
		ptrs[1]=	" разряженной батареи";
		}
	ptrs[2]=		" Выход              ";
	ptrs[3]=		"                    ";


	if((a_ind . s_i-a_ind . i_s)>1)a_ind . i_s=a_ind . s_i;
	else if(a_ind . s_i<a_ind . i_s)a_ind . i_s=a_ind . s_i;
	bgnd_par(			"ДОПОПЛНИТЕЛЬНОЕ РЕЛЕ",
						"  ФУНКЦИОНАЛЬНОСТЬ  ",
						ptrs[a_ind . i_s],
						ptrs[a_ind . i_s+1]);
	pointer_set(2);

	
	
	
	}

else if (a_ind . i==iIps_Curr_Avg_Set)
	{ 
	if(ICA_EN==0)
		{
		ptrs[0]=		" Выключено          ";
		simax=1;
		}
	else 
		{
		ptrs[0]=		" Включено           ";
		if(ICA_CH==0)
			{
			ptrs[1]=	" КАНАЛ  MODBUS-RTU  ";
			ptrs[2]=	" АДРЕС ВЕДОМОГО   ! ";
			simax=3;
			}
		else
			{
			ptrs[1]=	" КАНАЛ   MODBUS-TCP ";
			ptrs[2]=	" IP 00@.00#.00$.00% ";
			ptrs[3]=	" АДРЕС ВЕДОМОГО   ^ ";
			simax=4;
			}
		} 
	ptrs[simax]=		" Выход              ";
	
	if(a_ind . s_i<a_ind . i_s) a_ind . i_s=a_ind . s_i;
	else if((a_ind . s_i-a_ind . i_s)>1) a_ind . i_s=a_ind . s_i-1;	
	bgnd_par(	" ВЫРАВНИВАНИЕ ТОКОВ ",
				"        ИПС         ",
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


#line 6220 "main.c"




#line 6243 "main.c"




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
signed short deep,i,cap,ptr;
char av_head[4];
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
          
          mcp2515_transmit(1,2,3,4,5,6,7,8);
          }   
          
     else if(but==126)
         	{
          
          can1_out_adr(TXBUFF,3);
          }                      				
	}

else if(a_ind . i==iMn_VD)
	{
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,6+NUMIST);
		}
		
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,6+NUMIST);
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
			if(avar_ind_stat)
				{
				
				
				tree_up(iAv_view,0,0,0);
				while(!(avar_ind_stat&(1<<a_ind . s_i)))
					{
					a_ind . s_i++;
					if(a_ind . s_i>=32)
						{
						tree_down(0,0);
						avar_ind_stat=0;
						}
					}
				}																							
			}

		else if((a_ind . s_i>1)&&(a_ind . s_i<=(1+NUMIST)))
		    	{
		    	tree_up(iBps_elteh,0,0,a_ind . s_i-2);
		    	} 


		else if(a_ind . s_i==(2+NUMIST))
			{
	     	tree_up(iBps_list,0,0,0);
		    }		
		else if(a_ind . s_i==(3+NUMIST))
			{
			tree_up(iSet_prl,0,0,0);
		    ret(50);
		    parol_init();
			}
		else if(a_ind . s_i==(4+NUMIST))
			{
			if(but==126)avar_uout_hndl(1);
			tree_up(iLog,0,0,0);
		    ret(1000);
			}
		else if(a_ind . s_i==(5+NUMIST))
			{
			a_ind . s_i=0;
			}
		else if(a_ind . s_i==(6+NUMIST))
			{
	     	tree_up(iPrltst,0,0,0);
		    parol_init();
			
			}
 		}
	else if(but==125)
		{
		if(sysTAvar==0)avar_sys_t_hndl(1,456);
		else avar_sys_t_hndl(0,789);
		}
    }



else if(a_ind . i==iMakb)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		if(a_ind . s_i>7)a_ind . s_i=7;
		
		gran_char(&a_ind . s_i,0,simax);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i<3)a_ind . s_i=3;
		gran_char(&a_ind . s_i,0,simax);
		}
	else if((but==247)||((a_ind . s_i==simax)&&(but==254)))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	else if(but==123)
		{
		a_ind . s_i=simax;
		}		    
	}


else if(a_ind . i==iBps)
	{
	ret_ind(0,0,0);
	if (but==253)
		{      
		a_ind . s_i--;
		if(a_ind . s_i==3)a_ind . s_i=1;
		else if(a_ind . s_i==1)a_ind . s_i=0;
		gran_char(&a_ind . s_i,0,simax);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i<3)a_ind . s_i=3;
		gran_char(&a_ind . s_i,0,simax);
		}
		
	else if((but==254)&&(a_ind . s_i==4))
		{
		mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0x16,0x63,0,0,0,0);
		}
				
	else if(((but==254)&&(a_ind . s_i==5))||(but))
		{
	     tree_down(0,0);
	     ret(0);
		}	
		
	}	
else if(a_ind . i==iBps_elteh)
	{
	ret_ind(0,0,0);
	if (but==253)
		{      
		a_ind . s_i--;
		if(a_ind . s_i==4)a_ind . s_i=2;
		else if(a_ind . s_i==1)a_ind . s_i=0;
		gran_char(&a_ind . s_i,0,simax);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i<3)a_ind . s_i=3;
		if(a_ind . s_i==4)a_ind . i_s=4;
		if(a_ind . s_i==5)a_ind . s_i=7;
		gran_char(&a_ind . s_i,0,simax);
		}
	else if (but==239)
		{      
		
		
		}
		




 
	
	else if((but==254)&&(a_ind . s_i==7))
		{
		mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0x16,0x63,0,0,0,0);
		}
				
	else if(((but==254)&&(a_ind . s_i==8))||(but==247))
		{
	     tree_down(0,0);
	     ret(0);
		}	
	else if((but==254)&&(a_ind . s_i==9))
		{
		mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0x16,0x64,0,0,0,0);
		}			
	}			
else if(a_ind . i==iNet)
	{
	ret(1000);
	if((but==247)||(but==254))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	}

else if(a_ind . i==iNet3)
	{
	ret(1000);
	ret_ind(0,0,0);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4);
		}
	else if((but==247)||((but==254)&&(a_ind . s_i==4)))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	}
else if(a_ind . i==iNetEM)
	{
	ret(1000);
	ret_ind(0,0,0);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4);
		}
	else if((but==247)||((but==254)&&(a_ind . s_i==4)))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	}

else if(a_ind . i==iLoad)
	{
	ret(1000);
	if((but==247)||(but==254))
	     {
	     tree_down(0,0);
	     ret(0);
	     }
	}	

else if(a_ind . i==iExtern)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,8);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,8);		
		}

	else if((but==254)&&(a_ind . s_i==8))
		{
	     tree_down(0,0);
	     ret(0);
		}	
	}

else if(a_ind . i==iVent)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,1,2);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,1,2);		
		}

	else if (a_ind . s_i==1)
		{
          if((but==239)||(but==111))
               {
               pos_vent++;
               }
          else if((but==247)||(but==119))
               {
               pos_vent--;
               }

		gran(&pos_vent,1,11);
          lc640_write_int(0x10+500+92,pos_vent);		
		}
		
	else if((but==254)&&(a_ind . s_i==2))
		{
	     tree_down(0,0);
	     ret(0);
		}	
	}
else if(a_ind . i==iAvt)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMAVT);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMAVT);		
		}

	else if((but==254)&&(a_ind . s_i==NUMAVT))
		{
	     tree_down(0,0);
	     ret(0);
		}
	}
else if(a_ind . i==iEnerg)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4);		
		}

	else if((but==254)&&(a_ind . s_i==4))
		{
	     tree_down(0,0);
	     ret(0);
		}
     }

else if(a_ind . i==iEnerg3)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,8);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,8);		
		}

	else if((but==254)&&(a_ind . s_i==8))
		{
	     tree_down(0,0);
	     ret(0);
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
	          				"       Пароль       ",
	          				"     неверный!!!    ",
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
	          				"       Пароль       ",
	          				"     неверный!!!    ",
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
	          			"       Пароль       ",
	          			"     неверный!!!    ",
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
	          			"       Пароль       ",
	          			"     неверный!!!    ",
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
	          			"       Пароль       ",
	          			"     неверный!!!    ",
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
	          			"       Пароль       ",
	          			"     неверный!!!    ",
	          			"                    ",1000);
				}
			} 
						
		else if(a_ind . i==iPrltst)
			{
			if(tempU==999) 
				{
				tree_down(0,0);

				tree_up(iTst_VD,0,0,0);
				
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
	          			"       Пароль       ",
	          			"     неверный!!!    ",
	          			"                    ",1000);
				}
			}
		}
	}



else if(a_ind . i==iPrl_bat_in_sel)
	{
	ret(1000);
	if (but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,1);
		}
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,1);
		}
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{
			lc640_write_int(ADR_EE_BAT_IS_ON[a_ind . s_i1],bisON);
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
		               
               tree_down(-1,0);
               ret(0);
 
			}
		else if (a_ind . s_i==1)
			{
			lc640_write_int(ADR_EE_BAT_IS_ON[a_ind . s_i1],bisON);
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
		               
               tree_down(-1,0);
               ret(0);
	    	     show_mess("    Не забудьте     ",
	          		"  настроить канал   ",
	          		"       связи        ",
	          		"     с батареей.    ",3000);			 
			}
		}
	}

else if(a_ind . i==iSpc)
	{
	ret(1000);
	if (but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4);
		}
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4);
		}
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{   
            
			parol_init();
			}
		else if(a_ind . s_i==1)
			{
            
            parol_init();
			}			
		else if((a_ind . s_i==2)||(a_ind . s_i==3))
			{
            
            parol_init();
			} 
		else if(a_ind . s_i==4)
			{
			tree_down(0,0);
			ret(0);
			}	
		}
	else if(but==247)
		{
		tree_down(0,0);
		ret(0);
		}			
	}
else if(a_ind . i==iSpc_termocompensat)
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
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{   
            
			parol_init();
			}
		else if(a_ind . s_i==1)
			{
            
            parol_init();
			}			
		else if(a_ind . s_i==2)
			{
            
            parol_init();
			} 
		else if(a_ind . s_i==3)
			{
			tree_down(0,0);
			ret(0);
			}	
		}
	else if(but==247)
		{
		tree_down(0,0);
		ret(0);
		}
	}



else if(a_ind . i==iLog)
	{
	ret_ind_sec(0,0);
	ret_ind(0,0,0);
	if (but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,av_j_si_max+1);
		}
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,av_j_si_max+1);
          
		}  

	else if (but==123)
		{
		a_ind . s_i=av_j_si_max;
		} 
		 
	else if (but==247)
		{
		tree_down(0,0);
		ret(0);
		}  
		
	else if(but==254)
		{  
		if(a_ind . s_i==av_j_si_max+1)
			{
			lc640_write(1024+1024+512+1024+2,0);
			lc640_write(1024+1024+512+1024,0);
			tree_down(0,0);
			avar_ind_stat=0;
			avar_stat=0;
			avar_stat_old=0;				
			}
					
		else if(a_ind . s_i==av_j_si_max)
			{
			tree_down(0,0);
			ret(0);
			}
			
		else 
			{
			


 
			tree_up(iLog_,0,0,a_ind . s_i);
			}	
			
		} 

	else if(but==239)
		{
	    
		}
	else if(but==111)
		{
	    	
		}		
	else if(but==247)
		{
	    	
		}
				
	else if(but==119)
		{           
		



 				
	
		}	 		
	}

else if(a_ind . i==iLog_)
	{          
	if(but==253)
		{
		a_ind . i_s--;
		gran_char(&a_ind . i_s,0,av_j_si_max);
		}
	else if(but==251)
		{
		a_ind . i_s++;
		gran_char(&a_ind . i_s,0,av_j_si_max);
		}
	else 
		{
		
 
		tree_down(0,0 );
		}		
	}	

else if(a_ind . i==iSet)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==7)a_ind . i_s=6;
		if(a_ind . s_i==8)a_ind . s_i=9;
		if(a_ind . s_i==11)a_ind . i_s=10;
		if(a_ind . s_i==12)a_ind . s_i=13;
          if(a_ind . s_i==32)
               {
               a_ind . i_s=31;
               }
          if(a_ind . s_i==34)
               {
               a_ind . s_i=35;
               
               }
		
		gran_char(&a_ind . s_i,0,37);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if(a_ind . s_i==8)a_ind . s_i=7;
		if(a_ind . s_i==12)a_ind . s_i=9;
          if(a_ind . s_i==33)
               {
               a_ind . s_i=32;
		     
               }
		gran_char(&a_ind . s_i,0,37);
		}
	else if(but==123)
		{
		a_ind . s_i=35;
		}
		
	else if(a_ind . s_i==0)
	     {
	     if(but==254)
	          {
#line 7398 "main.c"
	          ret(1000);
	          default_temp=10;
	          }


	     }	
	
     else if(a_ind . s_i==1)
		{
		if(but==254)
		     {
		     tree_up(iSet_T,0,0,0);
		     ret(1000);
		     phase=0;
		     }
		}	
					 
     else if(a_ind . s_i==2)
		{
		if(but==254)
		     {
#line 7444 "main.c"









		     }
		}	
	
	else if(a_ind . s_i==3)
	     {
		if(but==254)
		     {		
			tree_up(iKlimat,0,0,0);
			}
	     }

	else if(a_ind . s_i==5)
	     {
	     if(but==239)MNEMO_TIME++;
	     else if(but==111)MNEMO_TIME+=10;
	     else if(but==247)MNEMO_TIME--;
	     else if(but==119)MNEMO_TIME-=10;

	     if(((MNEMO_TIME<5)||(MNEMO_TIME>60))&&(MNEMO_ON!=mnOFF))lc640_write_int(0x10+100+72,mnOFF);	
	     if(((MNEMO_TIME>=5)&&(MNEMO_TIME<=60))&&(MNEMO_ON!=mnON))lc640_write_int(0x10+100+72,mnON);
	     gran((signed short*)&MNEMO_TIME,4,61);
	     lc640_write_int(0x10+100+74,MNEMO_TIME);
	     speed=1;
	     }
				     		
	else if(a_ind . s_i==6)
	     {
		if(ZV_ON)ZV_ON=0;
		else ZV_ON=1;
	     lc640_write_int(0x10+100+18,ZV_ON);
	     speed=1;
	     }	
	
	else if(a_ind . s_i==7)
	     {
		if(AV_OFF_AVT)AV_OFF_AVT=0;
		else AV_OFF_AVT=1;
	     lc640_write_int(0x10+100+12,AV_OFF_AVT);
	     speed=1;
	     }	

	else if(a_ind . s_i==9)
	     {
	     if(but==254)
	          {
	          tree_up(iApv,0,0,0);
	          ret(1000);
	          }
	     }	

	else if(a_ind . s_i==10)
	     {



	     speed=1;
	     }

	else if(a_ind . s_i==11)
	     {
	     if(but==239)TBAT++;
	     else if(but==111)TBAT+=10;
	     else if(but==247)TBAT--;
	     else if(but==119)TBAT-=10;
	     gran(&TBAT,5,60);
	     lc640_write_int(0x10+100+78,TBAT);
	     speed=1;
	     }	
	                    	     	
	else if(a_ind . s_i==13)
	     {
	     if(but==239)UMAX++;
	     else if(but==111)UMAX+=10;
	     else if(but==247)UMAX--;
	     else if(but==119)UMAX-=10;



	     gran(&UMAX,10,1000);

	     lc640_write_int(0x10+100+4,UMAX);
	     speed=1;
	     }
	else if(a_ind . s_i==14)
	     {




 






 
	     }	     
	else if(a_ind . s_i==15)
	     {
	     





 
	     }
	     
	else if(a_ind . s_i==16)
	     {






 
	     }	

	else if(a_ind . s_i==17)
	     {
	     if(but==239)USIGN++;
	     else if(but==111)USIGN+=10;
	     else if(but==247)USIGN--;
	     else if(but==119)USIGN-=10;
		gran(&USIGN,40,100);
	     lc640_write_int(0x10+100+14,USIGN);
	     speed=1;
	     }	
	else if(a_ind . s_i==18)
	     {
	     if(but==239)UMN++;
	     else if(but==111)UMN+=10;
	     else if(but==247)UMN--;
	     else if(but==119)UMN-=10;
	     gran(&UMN,1,220);
	     lc640_write_int(0x10+100+16,UMN);
	     speed=1;
	     }	

	else if(a_ind . s_i==19)
	     {
	     if(but==239)U0B++;
	     else if(but==111)U0B+=10;
	     else if(but==247)U0B--;
	     else if(but==119)U0B-=10;
		gran(&U0B,400,800);
	     lc640_write_int(0x10+100+32,U0B);
	     speed=1;
	     }	
	     
	else if(a_ind . s_i==20)
	     {
	     if(but==239)IKB++;
	     else if(but==111)IKB+=10;
	     else if(but==247)IKB--;
	     else if(but==119)IKB-=10;
	     gran(&IKB,1,500);
	     lc640_write_int(0x10+100+20,IKB);
	     speed=1;
	     }		
            
	else if(a_ind . s_i==21)
	     {
	     if(but==239)IZMAX++;
	     else if(but==111)IZMAX+=10;
	     else if(but==247)IZMAX--;
	     else if(but==119)IZMAX-=10;
		gran(&IZMAX,10,1000);
	     lc640_write_int(0x10+100+30,IZMAX);
	     speed=1;
	     }   

	else if(a_ind . s_i==22)
	     {
	     if(but==239)IMAX++;
	     else if(but==111)IMAX+=10;
	     else if(but==247)IMAX--;
	     else if(but==119)IMAX-=10;
		gran(&IMAX,10,1000);
	     lc640_write_int(0x10+100+24,IMAX);
	     speed=1;
	     }		
	     
	else if(a_ind . s_i==23)
	     {
	     if(but==239)IMIN++;
	     else if(but==111)IMIN+=10;
	     else if(but==247)IMIN--;
	     else if(but==119)IMIN-=10;
	     gran(&IMIN,40,IMAX-10);
	     lc640_write_int(0x10+100+26,IMIN);
	     speed=1;
	     }
	
	else if(a_ind . s_i==24)
	     {




 
	     }
	     
	else if(a_ind . s_i==25)
		{
		if ((but==239)||(but==111))TZAS++;
		if ((but==247)||(but==119))TZAS--;
		gran(&TZAS,0,3);
		lc640_write_int(0x10+100+34,TZAS);
		speed=1; 
		}	
			       	        
	else if(a_ind . s_i==26)
	     {
	     if(but==239)TMAX++;
	     else if(but==111)TMAX+=2;
	     else if(but==247)TMAX--;
	     else if(but==119)TMAX-=2;
	     gran(&TMAX,10,100);
	     lc640_write_int(0x10+100+10,TMAX);
	     speed=1;
	     }	
	
	else if(a_ind . s_i==27)
	     {
	     if(but==239)TSIGN++;
	     else if(but==111)TSIGN+=2;
	     else if(but==247)TSIGN--;
	     else if(but==119)TSIGN-=2;
	     gran(&TSIGN,10,100);
	     lc640_write_int(0x10+100+82,TSIGN);
	     speed=1;
	     }	     
	else if(a_ind . s_i==28)
	     {
	     if(but==239)TBATMAX++;
	     else if(but==111)TBATMAX+=2;
	     else if(but==247)TBATMAX--;
	     else if(but==119)TBATMAX-=2;
	     gran(&TBATMAX,10,100);
	     lc640_write_int(0x10+100+88,TBATMAX);
	     speed=1;
	     }	
	
	else if(a_ind . s_i==29)
	     {
	     if(but==239)TBATSIGN++;
	     else if(but==111)TBATSIGN+=2;
	     else if(but==247)TBATSIGN--;
	     else if(but==119)TBATSIGN-=2;
	     gran(&TBATSIGN,10,100);
	     lc640_write_int(0x10+100+90,TBATSIGN);
	     speed=1;
	     }	
     	     	     		     	     
    else if(a_ind . s_i==30)
		{
		if(but==254)
		     {
		     tree_up(iExt_set,0,0,0);
		     ret(1000);
		     }
		}

    else if(a_ind . s_i==31)
		{
		if(but==254)
		     {
		     tree_up(iLan_set,0,0,0);
		     ret(1000);
		     }
		}
	else if(a_ind . s_i==32)
	     {
	     if(but==239)POWER_CNT_ADRESS++;
	     else if(but==111)POWER_CNT_ADRESS+=10;
	     else if(but==247)POWER_CNT_ADRESS--;
	     else if(but==119)POWER_CNT_ADRESS-=10;
	     gran(&POWER_CNT_ADRESS,0,10000);
	     lc640_write_int(0x10+500+94,POWER_CNT_ADRESS);
	     speed=1;
	     } 
	else if(a_ind . s_i==33)
	     {
	     if(but==239)UBM_AV++;
	     else if(but==111)UBM_AV++;
	     else if(but==247)UBM_AV--;
	     else if(but==119)UBM_AV--;
	     gran(&UBM_AV,0,50);
	     lc640_write_int(0x10+500+96,UBM_AV);
	     speed=1;
	     }

	else if(a_ind . s_i==34)
	     {
	     if(but==239)AUSW_MAIN_NUMBER++;
	     else if(but==111)AUSW_MAIN_NUMBER+=20;
	     else if(but==247)AUSW_MAIN_NUMBER--;
	     else if(but==119)AUSW_MAIN_NUMBER-=20;
		else if(but==118)AUSW_MAIN_NUMBER=15000;
		if(AUSW_MAIN_NUMBER<13000)AUSW_MAIN_NUMBER=100000;
		if(AUSW_MAIN_NUMBER>100000)AUSW_MAIN_NUMBER=13000;
	     lc640_write_int(0x10+100+226,(short)(AUSW_MAIN_NUMBER&0x0000ffffUL));
		lc640_write_int(0x10+100+226+2,(short)((AUSW_MAIN_NUMBER&0xffff0000UL)>>16UL));
	     speed=1;
	     }                    		
 
     else if((a_ind . s_i==36) || (a_ind . s_i==4))
		{
		if(but==254)
		     {
		     tree_down(0,0);
		     ret(0);
		     }
		}
				
	else if(a_ind . s_i==37)
		{
		if(but==254)
		     {		
			tree_up(iK_prl,0,0,0);
			parol_init();
			ret(50);
			}						
		}
		







 	
     }




else if(a_ind . i==iSet_VD)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==5)a_ind . i_s=6;
		if(a_ind . s_i==6)a_ind . s_i=7;
		if(a_ind . s_i==20)
        	{
			a_ind . i_s=18;
			}
		if(a_ind . s_i==21)
        	{
			a_ind . s_i=22;
            a_ind . i_s=19;
            }
		if(a_ind . s_i==25)
        	{
			
            a_ind . i_s=24;
            }
		if(a_ind . s_i==26)
        	{
			a_ind . s_i=27;
            
            }
		if(a_ind . s_i==28)
        	{
			a_ind . s_i=29;
            
            }																			
		gran_char(&a_ind . s_i,0,30);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if(a_ind . s_i==6)
			{
			a_ind . s_i=5;
			}
		if(a_ind . s_i==21)
			{
			a_ind . s_i=20;
			}
		if(a_ind . s_i==26)
        	{
			a_ind . s_i=25;
            
            }
		if(a_ind . s_i==28)
        	{
			a_ind . s_i=27;
            
            }
		gran_char(&a_ind . s_i,0,30);
		}
	else if(but==123)
		{
		a_ind . s_i=29;
		}

	else if(but==103)
		{
		lc640_write_int(0x10+100+162,20);
		lc640_write_int(0x10+100+164,2400);
		lc640_write_int(0x10+100+166,1);
		lc640_write_int(0x10+100+170,50);
		lc640_write_int(0x10+100+168,0);
		lc640_write_int(0x10+100+172,1);
		lc640_write_int(0x10+100+174,1);
		lc640_write_int(0x10+100+226,20000);
		}
		
	else if(a_ind . s_i==0)
	     {
	     if(but==254)
	        {
	          
	          
	          

			lc640_write_int(0x10+100+18,1);
			lc640_write_int(0x10+100+12,1);
			lc640_write_int(0x10+100+44,apvON);
			lc640_write_int(0x10+100+46,apvON);
			lc640_write_int(0x10+100+48,1);
			lc640_write_int(0x10+100+6,2300);
			lc640_write_int(0x10+100+8,2300);
			lc640_write_int(0x10+100+82,70);
			lc640_write_int(0x10+100+10,80);
			lc640_write_int(0x10+100+106,50);
			lc640_write_int(0x10+100+84,200);
			lc640_write_int(0x10+100+4,700);
			lc640_write_int(0x10+100+144,2500);
			lc640_write_int(0x10+100+146,1700);
			lc640_write_int(0x10+100+148,2500);
			lc640_write_int(0x10+100+150,2200);
			lc640_write_int(0x10+100+34,5);
			lc640_write_int(0x10+350+2,6000);
			lc640_write_int(ADR_EE_RELE_SET_MASK[0],0x01);
			lc640_write_int(ADR_EE_RELE_SET_MASK[1],0x78);
			lc640_write_int(ADR_EE_RELE_SET_MASK[2],0x02);
			lc640_write_int(ADR_EE_RELE_SET_MASK[3],0x84);

	        }
		}	
	
     else if(a_ind . s_i==1)
		{
		if(but==254)
		     {
		     tree_up(iSet_T,0,0,0);
		     ret(1000);
		     phase=0;
		     }
		}	
					 
     else if(a_ind . s_i==2)
		{
		if(but==254)
		     {
		     tree_up(iStr_VD,0,0,0);
		     ret(1000);
		     a_ind . i_s=0;
 		     }
		}	
	
	else if(a_ind . s_i==4)
	     {
		if(ZV_ON)ZV_ON=0;
		else ZV_ON=1;
	     lc640_write_int(0x10+100+18,ZV_ON);
	     speed=1;
	     }	
	
	else if(a_ind . s_i==5)
	     {
		if(AV_OFF_AVT)AV_OFF_AVT=0;
		else AV_OFF_AVT=1;
	     lc640_write_int(0x10+100+12,AV_OFF_AVT);
	     speed=1;
	     }	

	else if(a_ind . s_i==7)
	     {
	     if(but==254)
	          {
	          tree_up(iApv,0,0,0);
	          ret(1000);
	          }
	     }	
 
	else if(a_ind . s_i==8)
	     {
	     if(but==239)UOUT++;
	     else if(but==111)UOUT+=10;
	     else if(but==247)UOUT--;
	     else if(but==119)UOUT-=10;

	     gran(&UOUT,2250,2350);

	     lc640_write_int(0x10+100+6,UOUT);
	     speed=1;
	     }
	else if(a_ind . s_i==9)
	     {
	     if(but==239)UAVT++;
	     else if(but==111)UAVT+=10;
	     else if(but==247)UAVT--;
	     else if(but==119)UAVT-=10;

	     gran(&UAVT,2250,2350);

	     lc640_write_int(0x10+100+8,UAVT);
	     speed=1;
	     }
		 	     
	else if(a_ind . s_i==10)
	     {
	     if(but==239)TSIGN++;
	     else if(but==111)TSIGN+=2;
	     else if(but==247)TSIGN--;
	     else if(but==119)TSIGN-=2;
	     gran(&TSIGN,10,100);
	     lc640_write_int(0x10+100+82,TSIGN);
	     speed=1;
	     }

 	else if(a_ind . s_i==11)
	     {
	     if(but==239)TMAX++;
	     else if(but==111)TMAX+=2;
	     else if(but==247)TMAX--;
	     else if(but==119)TMAX-=2;
	     gran(&TMAX,10,100);
	     lc640_write_int(0x10+100+10,TMAX);
	     speed=1;
	     }

 	else if(a_ind . s_i==12)
	     {
	     if(but==239)TSYSMAX++;
	     else if(but==111)TSYSMAX+=2;
	     else if(but==247)TSYSMAX--;
	     else if(but==119)TSYSMAX-=2;
	     gran(&TSYSMAX,10,100);
	     lc640_write_int(0x10+100+106,TSYSMAX);
	     speed=1;
	     }		 	
	else if(a_ind . s_i==13)
	    {
		if(but==239)DU++;
	    else if(but==111)DU+=10;
	    else if(but==247)DU--;
	    else if(but==119)DU-=10;
	    gran(&DU,50,1000);
	    lc640_write_int(0x10+100+84,DU);
	    speed=1;
	    }
		 	
	else if(a_ind . s_i==14)
		{
	    if(but==239)UMAX++;
	    else if(but==111)UMAX+=10;
	    else if(but==247)UMAX--;
	    else if(but==119)UMAX-=10;
		gran(&UMAX,10,3000);
		lc640_write_int(0x10+100+4,UMAX);
	    speed=1;
	    }

	else if(a_ind . s_i==15)
		{
	    if(but==239)UINMAX=(UINMAX*10+100)/10;
	    else if(but==111)UINMAX=(UINMAX*10+1000)/10;
	    else if(but==247)UINMAX=(UINMAX*10-100)/10;
	    else if(but==119)UINMAX=(UINMAX*10-1000)/10;
		gran(&UINMAX,10,3000);
		lc640_write_int(0x10+100+144,UINMAX);
	    speed=1;
	    }

	else if(a_ind . s_i==16)
		{
	    if(but==239)UINMIN=(UINMIN*10+100)/10;
	    else if(but==111)UINMIN=(UINMIN*10+1000)/10;
	    else if(but==247)UINMIN=(UINMIN*10-100)/10;
	    else if(but==119)UINMIN=(UINMIN*10-1000)/10;
		gran(&UINMIN,10,3000);
		lc640_write_int(0x10+100+146,UINMIN);
	    speed=1;
	    }

	else if(a_ind . s_i==17)
		{
	    if(but==239)UOUTMAX=(UOUTMAX*10+100)/10;
	    else if(but==111)UOUTMAX=(UOUTMAX*10+1000)/10;
	    else if(but==247)UOUTMAX=(UOUTMAX*10-100)/10;
	    else if(but==119)UOUTMAX=(UOUTMAX*10-1000)/10;
		gran(&UOUTMAX,10,3000);
		lc640_write_int(0x10+100+148,UOUTMAX);
	    speed=1;
	    }

	else if(a_ind . s_i==18)
		{
	    if(but==239)UOUTMIN=(UOUTMIN*10+100)/10;
	    else if(but==111)UOUTMIN=(UOUTMIN*10+1000)/10;
	    else if(but==247)UOUTMIN=(UOUTMIN*10-100)/10;
	    else if(but==119)UOUTMIN=(UOUTMIN*10-1000)/10;
		gran(&UOUTMIN,10,3000);
		lc640_write_int(0x10+100+150,UOUTMIN);
	    speed=1;
	    }

	else if(a_ind . s_i==19)
		{
		if ((but==239)||(but==111))TZAS++;
		if ((but==247)||(but==119))TZAS--;
		gran(&TZAS,3,60);
		lc640_write_int(0x10+100+34,TZAS);
		speed=1; 
		}

	else if(a_ind . s_i==20)
		{
	    if(but==239)		TVENTMAX=((TVENTMAX/100)+1)*100;
	    else if(but==111)	TVENTMAX=((TVENTMAX/100)+1)*100;
	    else if(but==247)	TVENTMAX=((TVENTMAX/100)-1)*100;
	    else if(but==119)	TVENTMAX=((TVENTMAX/100)-1)*100;
		else if(but==126)	TVENTMAX=1500;
		gran(&TVENTMAX,1,6000);
		lc640_write_int(0x10+350+2,TVENTMAX);
	    speed=1;
	    }

	else if(a_ind . s_i==22)
		{
		if(but==254)
		    {		
			tree_up(iRele_set,0,0,0);
			ret(500);
			}						
		}
  	else if(a_ind . s_i==23)
		{
		if(but==254) 
		     {
		     tree_up(iLan_set,0,0,0);
		     ret(1000);
		     }
		}
  	else if(a_ind . s_i==24)
	    {
	     if((but==239)||(but==111))
	     	{
	     	MODBUS_ADRESS++;
	     	gran(&MODBUS_ADRESS,1,100);
	     	lc640_write_int(0x10+500+200+72,MODBUS_ADRESS);
			speed=1;
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	MODBUS_ADRESS--;
	     	gran(&MODBUS_ADRESS,1,100);
	     	lc640_write_int(0x10+500+200+72,MODBUS_ADRESS);
			speed=1;
	     	}
          }

     else if(a_ind . s_i==25)
	     {
	     if((but==239)||(but==111))
	     	{
			if(MODBUS_BAUDRATE==120)MODBUS_BAUDRATE=240;
			else if(MODBUS_BAUDRATE==240)MODBUS_BAUDRATE=480;
	     	else if(MODBUS_BAUDRATE==480)MODBUS_BAUDRATE=960;
			else if(MODBUS_BAUDRATE==960)MODBUS_BAUDRATE=1920;
			else if(MODBUS_BAUDRATE==1920)MODBUS_BAUDRATE=3840;
			else if(MODBUS_BAUDRATE==3840)MODBUS_BAUDRATE=5760;
			
			else if(MODBUS_BAUDRATE==5760)MODBUS_BAUDRATE=11520;
			else MODBUS_BAUDRATE=120;
	     	gran(&MODBUS_BAUDRATE,120,11520);
	     	lc640_write_int(0x10+500+200+74,MODBUS_BAUDRATE);
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
			if(MODBUS_BAUDRATE==120)MODBUS_BAUDRATE=11520;
			else if(MODBUS_BAUDRATE==240)MODBUS_BAUDRATE=120;
	     	else if(MODBUS_BAUDRATE==480)MODBUS_BAUDRATE=240;
			else if(MODBUS_BAUDRATE==960)MODBUS_BAUDRATE=480;
			else if(MODBUS_BAUDRATE==1920)MODBUS_BAUDRATE=960;
			else if(MODBUS_BAUDRATE==3840)MODBUS_BAUDRATE=1920;
			
			else if(MODBUS_BAUDRATE==5760)MODBUS_BAUDRATE=3840;
			else MODBUS_BAUDRATE=11520;
	     	gran(&MODBUS_BAUDRATE,120,11520);
	     	lc640_write_int(0x10+500+200+74,MODBUS_BAUDRATE);
	     	}
          }

     else if(a_ind . s_i==27)
	     {
	     if((but==239)||(but==111))
	     	{
	     	I_LOAD_MODE=1;
	     	lc640_write_int(0x10+100+78,I_LOAD_MODE);
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	I_LOAD_MODE=0;
	     	lc640_write_int(0x10+100+78,I_LOAD_MODE);
	     	}
          }

    else if((a_ind . s_i==29) || (a_ind . s_i==3))
		{
		if(but==254)
		     {
		     tree_down(0,0);
		     ret(0);
		     }
		}
				
	else if(a_ind . s_i==30)
		{
		if(but==254)
		     {		
			tree_up(iK_prl,0,0,0);
			parol_init();
			ret(50);
			}						
		}
     }


else if (a_ind . i==iDef_220_IPS_TERMOKOMPENSAT)
	{
	simax=4;
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
	else if(but==123)
		{
		a_ind . s_i=simax;
		}
	
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{
			def_ips_set(220);
			
			lc640_write_int(0x10+100+80,2200);
			lc640_write_int(0x10+100+30,50);
			
			
			lc640_write_int(0x10+100+224,22043);
			lc640_write_int(0x10+100+36,3);

			lc640_write_int(0x10+100+86,0);
			
			lc640_write_int(0x10+100+84,2315-1110);


			
			
			lc640_write_int(0x10+500+96,0);
			lc640_write_int(0x10+100+182,2420);
			lc640_write_int(0x10+100+184,2200);

			}
		else if(a_ind . s_i==1)
			{
			def_ips_set(220);
			lc640_write_int(0x10+100+84,2315-1850);
			lc640_write_int(0x10+100+80,2200);
			
			lc640_write_int(0x10+100+224,22011);
			lc640_write_int(0x10+100+36,2);
			lc640_write_int(0x10+100+126,1);
			
		     
			
	

 
		
			
		
			
			
		
			
			lc640_write_int(0x10+100+36,2);

			lc640_write_int(0x10+100+86,0);
			lc640_write_int(0x10+100+4,2550);
			lc640_write_int(0x10+100+84,2315-1110);
			
			
			lc640_write_int(0x10+100+30,50);
			
			lc640_write_int(0x10+500+96,0);
			lc640_write_int(0x10+100+4,2450);
			lc640_write_int(0x10+100+182,2420);
			lc640_write_int(0x10+100+184,2200);

			}
		else if(a_ind . s_i==2)
			{
			def_ips_set(110);
			
			
			
			
			
			lc640_write_int(0x10+100+224,22043);
			

			
			
			
			
			
			
			
			
			
			

			}
		else if(a_ind . s_i==3)
			{
			def_ips_set(220);
			
			lc640_write_int(0x10+100+80,2200);
			
			lc640_write_int(0x10+100+224,22018);
			lc640_write_int(0x10+100+36,2);
			lc640_write_int(0x10+100+126,1);
			
		     
			
	

 
		
			
		
			
			
		
			
			lc640_write_int(0x10+100+36,2);

			lc640_write_int(0x10+100+86,0);
			lc640_write_int(0x10+100+4,2700);
			lc640_write_int(0x10+100+84,2450-1200);


			lc640_write_int(0x10+100+30,50);
			
			lc640_write_int(0x10+500+96,0);
			
			lc640_write_int(0x10+100+182,2420);
			lc640_write_int(0x10+100+184,2200);

			}
		else if(a_ind . s_i==simax)
			{
			tree_down(0,0);
			}
		default_temp=a_ind . s_i;	
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
		tree_down(0,0);
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
	     temp=((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->SEC;
	     if((but==253)||(but==125))
	          {
	          temp=0;
	          gran_ring_char(&temp,0,59);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->SEC=temp;
	          }
          else if((but==251)||(but==123))
	          {
	          temp=0;
	          gran_ring_char(&temp,0,59);
	          ((LPC_RTC_TypeDef *) ((0x40000000UL) + 0x24000) )->SEC=temp;
	          }	
	     speed=1;               
	     }

     else if(a_ind . s_i==3)
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
     else if(a_ind . s_i==4)
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
     else if(a_ind . s_i==5)
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
	}  

else if(a_ind . i==iStr)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . i_s=1;
		if(a_ind . s_i==3)a_ind . s_i++;
		gran_char(&a_ind . s_i,1,5);	

		}
	else if(but==253)
		{
		a_ind . s_i--;
		if(a_ind . s_i==3)a_ind . s_i--;
		gran_char(&a_ind . s_i,1,5);	 
		}
	else if(but==123)
		{
 		a_ind . s_i=5;		  
		}				
     else if(a_ind . s_i==1)
	     {
	     if((but==239)||(but==111))
	     	{
	     	NUMIST++;
	     	gran(&NUMIST,0,12);
	     	lc640_write_int(0x10+100+36,NUMIST);
			numOfForvardBps_init();
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	NUMIST--;
	     	gran(&NUMIST,0,12);
	     	lc640_write_int(0x10+100+36,NUMIST);
			numOfForvardBps_init();
	     	}
          }	
 
	  else if(a_ind . s_i==2)
	     {
	     if((but==239)||(but==111))
	     	{
	     	NUMINV++;
	     	gran(&NUMINV,0,12-NUMIST);
	     	lc640_write_int(0x10+100+38,NUMINV);
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	NUMINV--;
	     	gran(&NUMINV,0,12-NUMIST);
	     	lc640_write_int(0x10+100+38,NUMINV);
	     	}
          }	
 
      else if(a_ind . s_i==3)   
	     {
	     if((but==239)||(but==111))
	     	{
	     	NUMAVT++;
	     	gran(&NUMAVT,0,12);
	     	lc640_write_int(0x10+500+98,NUMAVT);
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	NUMAVT--;
	     	gran(&NUMAVT,0,12);
	     	lc640_write_int(0x10+500+98,NUMAVT);
	     	}
          }	
          
     else if(a_ind . s_i==5)	   
	     {
	     if(but==254)
	          {
			tree_down(0,0);
	          }
          }	          
	}

else if(a_ind . i==iStr_VD)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,2);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,2);
		}
	else if(but==123)
		{
		a_ind . s_i=4;
		}				
     else if(a_ind . s_i==0)
	     {
	     if((but==239)||(but==111))
	     	{
	     	NUMIST++;
	     	gran(&NUMIST,0,18);
	     	lc640_write_int(0x10+100+36,NUMIST);
			numOfForvardBps_init();
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	NUMIST--;
	     	gran(&NUMIST,0,18);
	     	lc640_write_int(0x10+100+36,NUMIST);
			numOfForvardBps_init();
	     	}
          }	
          
     else if(a_ind . s_i==1)
	     {
	     if((but==239)||(but==111))
	     	{
	     	NUMDT++;
	     	gran(&NUMDT,0,3);
	     	lc640_write_int(0x10+500+90,NUMDT);
	     	}
	     
	     else if((but==247)||(but==119))
	     	{
	     	NUMDT--;
	     	gran(&NUMDT,0,3);
	     	lc640_write_int(0x10+500+90,NUMDT);
	     	}
          }	

 


































 			  			                 
    else if(a_ind . s_i==2)
	     {
	     if(but==254)
	          {
			tree_down(0,0);
	          }
          }
	}
 
else if (a_ind . i==iLan_set)
	{
	char si_max;
	ret(1000);

	si_max=1;
	if(ETH_IS_ON!=0)si_max=21;

	if(but==251)
		{
		a_ind . s_i++;

		if((a_ind . s_i==2)&&(a_ind . i_s==0))
			{
			a_ind . i_s=1;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==3) 
			{
			a_ind . s_i=4;
			a_ind . i_s=3;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==5) 
			{
			a_ind . s_i=6;
			a_ind . i_s=5;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==7) 
			{
			a_ind . s_i=8;
			
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==10) 
			{
			
			
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==11) 
			{
			
			a_ind . i_s=10;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==12) 
			{
			a_ind . s_i++;
			}
		if(a_ind . s_i==13) 
			{
			
			a_ind . i_s=12;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==14) 
			{
			a_ind . s_i++;
			}
		if(a_ind . s_i==15) 
			{
			
			a_ind . i_s=14;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==16) 
			{
			a_ind . s_i++;
			}
		if(a_ind . s_i==17) 
			{
			
			a_ind . i_s=16;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==18) 
			{
			a_ind . s_i++;
			}
		if(a_ind . s_i==19) 
			{
			
			a_ind . i_s=18;
			a_ind . s_i1=0;
			}
		if(a_ind . s_i==20) 
			{
			a_ind . s_i++;
			}
	



 
		
		gran_char(&a_ind . s_i,0,si_max);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,si_max);
		if(a_ind . s_i==20) 
			{
			a_ind . s_i--;
			}		
		if(a_ind . s_i==18) 
			{
			a_ind . s_i--;
			}		
		if(a_ind . s_i==16) 
			{
			a_ind . s_i--;
			}
		if(a_ind . s_i==14) 
			{
			a_ind . s_i--;
			}
		if(a_ind . s_i==12) 
			{
			a_ind . s_i--;
			}
		if(a_ind . s_i==7) 
			{
			a_ind . s_i--;
			}
		if(a_ind . s_i==5) 
			{
			a_ind . s_i--;
			}
		if(a_ind . s_i==3) 
			{
			a_ind . s_i--;
			}
		}
	else if(but==123)
		{
		a_ind . s_i=si_max;
		}
	else if(but==103)
		{
		lc640_write_int(0x10+500+200,1);
		lc640_write_int(0x10+500+200+2,1);
		lc640_write_int(0x10+500+200+4,192);
		lc640_write_int(0x10+500+200+6,168);
		lc640_write_int(0x10+500+200+8,1);
		lc640_write_int(0x10+500+200+10,251);



		lc640_write_int(0x10+500+200+12,255);
		lc640_write_int(0x10+500+200+14,255);
		lc640_write_int(0x10+500+200+16,255);
		lc640_write_int(0x10+500+200+18,0);
		lc640_write_int(0x10+500+200+64,192);
		lc640_write_int(0x10+500+200+66,168);
		lc640_write_int(0x10+500+200+68,1);
		lc640_write_int(0x10+500+200+70,254);
		lc640_write_int(0x10+500+200+60,161);
		lc640_write_int(0x10+500+200+62,162);
		lc640_write_int(0x10+500+200+270,'1');
		lc640_write_int(0x10+500+200+270+2,'2');
		lc640_write_int(0x10+500+200+270+4,'3');
		lc640_write_int(0x10+500+200+270+6,0);
		lc640_write_int(0x10+500+200+270+8,0);
		lc640_write_int(0x10+500+200+20,255);
		lc640_write_int(0x10+500+200+22,255);
		lc640_write_int(0x10+500+200+24,255);
		lc640_write_int(0x10+500+200+26,255);
		lc640_write_int(0x10+500+200+28,255);
		lc640_write_int(0x10+500+200+30,255);
		lc640_write_int(0x10+500+200+32,255);
		lc640_write_int(0x10+500+200+34,255);
		lc640_write_int(0x10+500+200+36,255);
		lc640_write_int(0x10+500+200+38,255);
		lc640_write_int(0x10+500+200+40,255);
		lc640_write_int(0x10+500+200+42,255);
		lc640_write_int(0x10+500+200+44,255);
		lc640_write_int(0x10+500+200+46,255);
		lc640_write_int(0x10+500+200+48,255);
		lc640_write_int(0x10+500+200+50,255);
		lc640_write_int(0x10+500+200+52,255);
		lc640_write_int(0x10+500+200+54,255);
		lc640_write_int(0x10+500+200+56,255);
		lc640_write_int(0x10+500+200+58,255);
		}					
	else if(a_ind . s_i==0)
	     {
	     if((but==254)||(but==247)||(but==239))
	     	{
	     	if(ETH_IS_ON)lc640_write_int(0x10+500+200,0);
			else lc640_write_int(0x10+500+200,1);
	     	}
	     }	
     else if((a_ind . s_i==1)&&(ETH_IS_ON))
	     {
		if((but==254)||(but==247)||(but==239))
	     	{
	     	if(ETH_DHCP_ON)lc640_write_int(0x10+500+200+2,0);
			else lc640_write_int(0x10+500+200+2,1);
	     	}
		}	
     else if(a_ind . s_i==2)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_IP_1++;
				gran_ring(&ETH_IP_1,0,255);
				lc640_write_int(0x10+500+200+4,ETH_IP_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_IP_1--;
				gran_ring(&ETH_IP_1,0,255);
				lc640_write_int(0x10+500+200+4,ETH_IP_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_IP_2++;
				gran_ring(&ETH_IP_2,0,255);
				lc640_write_int(0x10+500+200+6,ETH_IP_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_IP_2--;
				gran_ring(&ETH_IP_2,0,255);
				lc640_write_int(0x10+500+200+6,ETH_IP_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_IP_3++;
				gran_ring(&ETH_IP_3,0,255);
				lc640_write_int(0x10+500+200+8,ETH_IP_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_IP_3--;
				gran_ring(&ETH_IP_3,0,255);
				lc640_write_int(0x10+500+200+8,ETH_IP_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_IP_4++;
				gran_ring(&ETH_IP_4,0,255);
				lc640_write_int(0x10+500+200+10,ETH_IP_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_IP_4--;
				gran_ring(&ETH_IP_4,0,255);
				lc640_write_int(0x10+500+200+10,ETH_IP_4);
				}
			speed=1;
			}

          }
     else if(a_ind . s_i==4)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_MASK_1++;
				gran_ring(&ETH_MASK_1,0,255);
				lc640_write_int(0x10+500+200+12,ETH_MASK_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_MASK_1--;
				gran_ring(&ETH_MASK_1,0,255);
				lc640_write_int(0x10+500+200+12,ETH_MASK_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_MASK_2++;
				gran_ring(&ETH_MASK_2,0,255);
				lc640_write_int(0x10+500+200+14,ETH_MASK_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_MASK_2--;
				gran_ring(&ETH_MASK_2,0,255);
				lc640_write_int(0x10+500+200+14,ETH_MASK_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_MASK_3++;
				gran_ring(&ETH_MASK_3,0,255);
				lc640_write_int(0x10+500+200+16,ETH_MASK_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_MASK_3--;
				gran_ring(&ETH_MASK_3,0,255);
				lc640_write_int(0x10+500+200+16,ETH_MASK_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_MASK_4++;
				gran_ring(&ETH_MASK_4,0,255);
				lc640_write_int(0x10+500+200+18,ETH_MASK_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_MASK_4--;
				gran_ring(&ETH_MASK_4,0,255);
				lc640_write_int(0x10+500+200+18,ETH_MASK_4);
				}
			speed=1;
			}
		}
     else if(a_ind . s_i==6)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_GW_1++;
				gran_ring(&ETH_GW_1,0,255);
				lc640_write_int(0x10+500+200+64,ETH_GW_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_GW_1--;
				gran_ring(&ETH_GW_1,0,255);
				lc640_write_int(0x10+500+200+64,ETH_GW_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_GW_2++;
				gran_ring(&ETH_GW_2,0,255);
				lc640_write_int(0x10+500+200+66,ETH_GW_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_GW_2--;
				gran_ring(&ETH_GW_2,0,255);
				lc640_write_int(0x10+500+200+66,ETH_GW_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_GW_3++;
				gran_ring(&ETH_GW_3,0,255);
				lc640_write_int(0x10+500+200+68,ETH_GW_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_GW_3--;
				gran_ring(&ETH_GW_3,0,255);
				lc640_write_int(0x10+500+200+68,ETH_GW_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_GW_4++;
				gran_ring(&ETH_GW_4,0,255);
				lc640_write_int(0x10+500+200+70,ETH_GW_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_GW_4--;
				gran_ring(&ETH_GW_4,0,255);
				lc640_write_int(0x10+500+200+70,ETH_GW_4);
				}
			speed=1;
			}
		}
      else if(a_ind . s_i==8)
	     {
		if(but==239)ETH_SNMP_PORT_READ++;
		else if(but==111)ETH_SNMP_PORT_READ+=2;
		else if(but==247)ETH_SNMP_PORT_READ--;
		else if(but==119)ETH_SNMP_PORT_READ-=2;
		speed=1;
		lc640_write_int(0x10+500+200+60,ETH_SNMP_PORT_READ);
		}

     else if(a_ind . s_i==9)
	     {
		if(but==239)ETH_SNMP_PORT_WRITE++;
		else if(but==111)ETH_SNMP_PORT_WRITE+=2;
		else if(but==247)ETH_SNMP_PORT_WRITE--;
		else if(but==119)ETH_SNMP_PORT_WRITE-=2;
		speed=1;
		lc640_write_int(0x10+500+200+62,ETH_SNMP_PORT_WRITE);
		}					
     else if(a_ind . s_i==10)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,8);
	     	}
		if((but==239)||(but==111))
			{
			snmp_community[a_ind . s_i1]++;
			if(snmp_community[a_ind . s_i1]<32) snmp_community[a_ind . s_i1]=32;
			else if ((snmp_community[a_ind . s_i1]>32)&&(snmp_community[a_ind . s_i1]<48)) snmp_community[a_ind . s_i1]=48;
			else if ((snmp_community[a_ind . s_i1]>57)&&(snmp_community[a_ind . s_i1]<65)) snmp_community[a_ind . s_i1]=65;
			else if ((snmp_community[a_ind . s_i1]>90)&&(snmp_community[a_ind . s_i1]<97)) snmp_community[a_ind . s_i1]=97;
			else if (snmp_community[a_ind . s_i1]>122) snmp_community[a_ind . s_i1]=32;
				
			lc640_write_int(0x10+500+200+270+(a_ind . s_i1*2),snmp_community[a_ind . s_i1]);
			speed=1;
			}
		if((but==247)||(but==119))
			{
			snmp_community[a_ind . s_i1]--;
			if(snmp_community[a_ind . s_i1]<32) snmp_community[a_ind . s_i1]=122;
			else if ((snmp_community[a_ind . s_i1]>32)&&(snmp_community[a_ind . s_i1]<48)) snmp_community[a_ind . s_i1]=32;
			else if ((snmp_community[a_ind . s_i1]>57)&&(snmp_community[a_ind . s_i1]<65)) snmp_community[a_ind . s_i1]=57;
			else if ((snmp_community[a_ind . s_i1]>90)&&(snmp_community[a_ind . s_i1]<97)) snmp_community[a_ind . s_i1]=90;
			else if (snmp_community[a_ind . s_i1]>122) snmp_community[a_ind . s_i1]=122;
			
			lc640_write_int(0x10+500+200+270+(a_ind . s_i1*2),snmp_community[a_ind . s_i1]);
			speed=1;
			}
		}
 
     else if(a_ind . s_i==11)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP1_IP_1++;
				gran_ring(&ETH_TRAP1_IP_1,0,255);
				lc640_write_int(0x10+500+200+20,ETH_TRAP1_IP_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP1_IP_1--;
				gran_ring(&ETH_TRAP1_IP_1,0,255);
				lc640_write_int(0x10+500+200+20,ETH_TRAP1_IP_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP1_IP_2++;
				gran_ring(&ETH_TRAP1_IP_2,0,255);
				lc640_write_int(0x10+500+200+22,ETH_TRAP1_IP_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP1_IP_2--;
				gran_ring(&ETH_TRAP1_IP_2,0,255);
				lc640_write_int(0x10+500+200+22,ETH_TRAP1_IP_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP1_IP_3++;
				gran_ring(&ETH_TRAP1_IP_3,0,255);
				lc640_write_int(0x10+500+200+24,ETH_TRAP1_IP_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP1_IP_3--;
				gran_ring(&ETH_TRAP1_IP_3,0,255);
				lc640_write_int(0x10+500+200+24,ETH_TRAP1_IP_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP1_IP_4++;
				gran_ring(&ETH_TRAP1_IP_4,0,255);
				lc640_write_int(0x10+500+200+26,ETH_TRAP1_IP_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP1_IP_4--;
				gran_ring(&ETH_TRAP1_IP_4,0,255);
				lc640_write_int(0x10+500+200+26,ETH_TRAP1_IP_4);
				}
			speed=1;
			}
		}	
     else if(a_ind . s_i==13)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP2_IP_1++;
				gran_ring(&ETH_TRAP2_IP_1,0,255);
				lc640_write_int(0x10+500+200+28,ETH_TRAP2_IP_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP2_IP_1--;
				gran_ring(&ETH_TRAP2_IP_1,0,255);
				lc640_write_int(0x10+500+200+28,ETH_TRAP2_IP_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP2_IP_2++;
				gran_ring(&ETH_TRAP2_IP_2,0,255);
				lc640_write_int(0x10+500+200+30,ETH_TRAP2_IP_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP2_IP_2--;
				gran_ring(&ETH_TRAP2_IP_2,0,255);
				lc640_write_int(0x10+500+200+30,ETH_TRAP2_IP_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP2_IP_3++;
				gran_ring(&ETH_TRAP2_IP_3,0,255);
				lc640_write_int(0x10+500+200+32,ETH_TRAP2_IP_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP2_IP_3--;
				gran_ring(&ETH_TRAP2_IP_3,0,255);
				lc640_write_int(0x10+500+200+32,ETH_TRAP2_IP_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP2_IP_4++;
				gran_ring(&ETH_TRAP2_IP_4,0,255);
				lc640_write_int(0x10+500+200+34,ETH_TRAP2_IP_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP2_IP_4--;
				gran_ring(&ETH_TRAP2_IP_4,0,255);
				lc640_write_int(0x10+500+200+34,ETH_TRAP2_IP_4);
				}
			speed=1;
			}
		}	
     else if(a_ind . s_i==15)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP3_IP_1++;
				gran_ring(&ETH_TRAP3_IP_1,0,255);
				lc640_write_int(0x10+500+200+36,ETH_TRAP3_IP_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP3_IP_1--;
				gran_ring(&ETH_TRAP3_IP_1,0,255);
				lc640_write_int(0x10+500+200+36,ETH_TRAP3_IP_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP3_IP_2++;
				gran_ring(&ETH_TRAP3_IP_2,0,255);
				lc640_write_int(0x10+500+200+38,ETH_TRAP3_IP_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP3_IP_2--;
				gran_ring(&ETH_TRAP3_IP_2,0,255);
				lc640_write_int(0x10+500+200+38,ETH_TRAP3_IP_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP3_IP_3++;
				gran_ring(&ETH_TRAP3_IP_3,0,255);
				lc640_write_int(0x10+500+200+40,ETH_TRAP3_IP_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP3_IP_3--;
				gran_ring(&ETH_TRAP3_IP_3,0,255);
				lc640_write_int(0x10+500+200+40,ETH_TRAP3_IP_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP3_IP_4++;
				gran_ring(&ETH_TRAP3_IP_4,0,255);
				lc640_write_int(0x10+500+200+42,ETH_TRAP3_IP_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP3_IP_4--;
				gran_ring(&ETH_TRAP3_IP_4,0,255);
				lc640_write_int(0x10+500+200+42,ETH_TRAP3_IP_4);
				}
			speed=1;
			}
		}	
     else if(a_ind . s_i==17)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP4_IP_1++;
				gran_ring(&ETH_TRAP4_IP_1,0,255);
				lc640_write_int(0x10+500+200+44,ETH_TRAP4_IP_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP4_IP_1--;
				gran_ring(&ETH_TRAP4_IP_1,0,255);
				lc640_write_int(0x10+500+200+44,ETH_TRAP4_IP_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP4_IP_2++;
				gran_ring(&ETH_TRAP4_IP_2,0,255);
				lc640_write_int(0x10+500+200+46,ETH_TRAP4_IP_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP4_IP_2--;
				gran_ring(&ETH_TRAP4_IP_2,0,255);
				lc640_write_int(0x10+500+200+46,ETH_TRAP4_IP_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP4_IP_3++;
				gran_ring(&ETH_TRAP4_IP_3,0,255);
				lc640_write_int(0x10+500+200+48,ETH_TRAP4_IP_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP4_IP_3--;
				gran_ring(&ETH_TRAP4_IP_3,0,255);
				lc640_write_int(0x10+500+200+48,ETH_TRAP4_IP_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP4_IP_4++;
				gran_ring(&ETH_TRAP4_IP_4,0,255);
				lc640_write_int(0x10+500+200+50,ETH_TRAP4_IP_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP4_IP_4--;
				gran_ring(&ETH_TRAP4_IP_4,0,255);
				lc640_write_int(0x10+500+200+50,ETH_TRAP4_IP_4);
				}
			speed=1;
			}
		}	
     else if(a_ind . s_i==19)
	     {
		if(but==126)
	     	{
	     	a_ind . s_i1++;
			gran_ring_char(&a_ind . s_i1,0,3);
	     	}
		else if(a_ind . s_i1==0)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP5_IP_1++;
				gran_ring(&ETH_TRAP5_IP_1,0,255);
				lc640_write_int(0x10+500+200+52,ETH_TRAP5_IP_1);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP5_IP_1--;
				gran_ring(&ETH_TRAP5_IP_1,0,255);
				lc640_write_int(0x10+500+200+52,ETH_TRAP5_IP_1);
				}
			speed=1;
			}
		else if(a_ind . s_i1==1)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP5_IP_2++;
				gran_ring(&ETH_TRAP5_IP_2,0,255);
				lc640_write_int(0x10+500+200+54,ETH_TRAP5_IP_2);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP5_IP_2--;
				gran_ring(&ETH_TRAP5_IP_2,0,255);
				lc640_write_int(0x10+500+200+54,ETH_TRAP5_IP_2);
				}
			speed=1;
			}
		else if(a_ind . s_i1==2)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP5_IP_3++;
				gran_ring(&ETH_TRAP5_IP_3,0,255);
				lc640_write_int(0x10+500+200+56,ETH_TRAP5_IP_3);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP5_IP_3--;
				gran_ring(&ETH_TRAP5_IP_3,0,255);
				lc640_write_int(0x10+500+200+56,ETH_TRAP5_IP_3);
				}
			speed=1;
			}
		else if(a_ind . s_i1==3)
			{
			if((but==239)||(but==111))
				{
				ETH_TRAP5_IP_4++;
				gran_ring(&ETH_TRAP5_IP_4,0,255);
				lc640_write_int(0x10+500+200+58,ETH_TRAP5_IP_4);
				}
			else if((but==247)||(but==119))
				{
				ETH_TRAP5_IP_4--;
				gran_ring(&ETH_TRAP5_IP_4,0,255);
				lc640_write_int(0x10+500+200+58,ETH_TRAP5_IP_4);
				}
			speed=1;
			}
		}													          
    else if(a_ind . s_i==si_max)
	     {
	     if(but==254)
	          {
	          tree_down(0,0);
	          }
          }	          	
	}


else if (a_ind . i==iBlok_ips_set)
	{
    ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . s_i=3;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		gran_char(&a_ind . s_i,0,3);
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}			
     
	else if(a_ind . s_i==0)
		{
		if((but==239)||(but==111))
			{
			ipsBlckSrc++;
			gran(&ipsBlckSrc,0,2);
			lc640_write_int(0x10+100+190,ipsBlckSrc);
			}
		else if((but==247)||(but==119))
			{
			ipsBlckSrc--;
			gran(&ipsBlckSrc,0,2);
			lc640_write_int(0x10+100+190,ipsBlckSrc);
			}
		speed=1;
		}

	else if(a_ind . s_i==1)
		{
		if((but==239)||(but==111))
			{
			ipsBlckLog=1;
			lc640_write_int(0x10+100+192,ipsBlckLog);
			}
		else if((but==247)||(but==119))
			{
			ipsBlckLog=0;
			lc640_write_int(0x10+100+192,ipsBlckLog);
			}
		speed=1;
		}

	else if((a_ind . s_i==3)&&(but==254))
		{
	     tree_down(0,0);
	     ret(0);
		} 												
	}

else if (a_ind . i==iApv)
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
	else if(but==123)
		{
		a_ind . s_i=simax;
		}			
	else if(but==254)
	     {
	     if(a_ind . s_i==simax)
	          {
	          
	          tree_down(0,0);
	          }
	     else if(a_ind . s_i==0)   
	          {
	          if(APV_ON1==apvON)lc640_write_int(0x10+100+44,apvOFF);
	          else lc640_write_int(0x10+100+44,apvON);
	          }
          else if((a_ind . s_i==1)&&(APV_ON1==apvON))   
	          {
	          if(APV_ON2==apvON)lc640_write_int(0x10+100+46,apvOFF);
	          else lc640_write_int(0x10+100+46,apvON);
	          }	 
          }
     
     else if((a_ind . s_i==2)&&(APV_ON2==apvON))   
          {
	     if((but==239)||(but==111))
	          {
	          signed short tempSS;
	          tempSS=APV_ON2_TIME;
	          tempSS++;
	          gran(&tempSS,1,24);
	          lc640_write_int(0x10+100+48,tempSS);
	          }
          else if((but==247)||(but==119))
	          {
	          signed short tempSS;
	          tempSS=APV_ON2_TIME;
	          tempSS--;
	          gran(&tempSS,1,24);
	          lc640_write_int(0x10+100+48,tempSS);
	          }	          
	     speed=1;
	     }	 
  	} 

else if (a_ind . i==iExt_set)
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

	else if((but==254)&&(a_ind . s_i==0))
		{
	     tree_up(iExt_ddv,0,0,0);
	     ret(0);
		}

	else if((but==254)&&(a_ind . s_i==1))
		{
	     tree_up(iExt_ddi,0,0,0);
	     ret(0);
		}
	else if((but==254)&&(a_ind . s_i==2))
		{
	     tree_up(iExt_dud,0,0,0);
	     ret(0);
		}




 
		
	else if((but==254)&&(a_ind . s_i==3))
		{
	     tree_down(0,0);
	     ret(0);
		}        	
	}

else if (a_ind . i==iExt_set_3U)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMSK);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMSK);		
		}
 	else if((but==254)&&(a_ind . s_i==NUMSK))
		{
	     tree_down(0,0);
	     ret(0);
		}
	else if((but==254)&&(a_ind . s_i==0))
		{
	     tree_up(iExt_sk_3U,0,0,0);
	     ret(0);
		}
	else if((but==254)&&(a_ind . s_i==1))
		{
	     tree_up(iExt_sk_3U,0,0,1);
	     ret(0);
		}
	else if((but==254)&&(a_ind . s_i==2))
		{
	     tree_up(iExt_sk_3U,0,0,2);
	     ret(0);
		}
	else if((but==254)&&(a_ind . s_i==3))
		{
	     tree_up(iExt_sk_3U,0,0,3);
	     ret(0);
		} 
	}

else if (a_ind . i==iExt_dt)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,1,7);
		}
	else if(but==253)
		{
		if(a_ind . s_i==1)a_ind . i_s=0;
		else a_ind . s_i--;
		gran_char(&a_ind . s_i,1,7);
		}	
	else if(but==123)
		{
		a_ind . s_i=7;
		}			
		
	else if(a_ind . s_i==1) 
		{
		if(but==254)
			{
			if(!TMAX_EXT_EN[a_ind . s_i1])lc640_write_int(ADR_TMAX_EXT_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_TMAX_EXT_EN[a_ind . s_i1],0);
			}
		else if((but==239)||(but==111))
			{
			TMAX_EXT[a_ind . s_i1]++;
			}	
		else if((but==247)||(but==119))
			{
			TMAX_EXT[a_ind . s_i1]--;
			}	
		gran(&TMAX_EXT[a_ind . s_i1],-50,100);
		if(lc640_read_int(ADR_TMAX_EXT[a_ind . s_i1])!=TMAX_EXT[a_ind . s_i1]) lc640_write_int(ADR_TMAX_EXT[a_ind . s_i1],TMAX_EXT[a_ind . s_i1]);			
		speed=1;
		}
	else if(a_ind . s_i==2) 
		{
		if(but==254)
			{
			if(!TMIN_EXT_EN[a_ind . s_i1])lc640_write_int(ADR_TMIN_EXT_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_TMIN_EXT_EN[a_ind . s_i1],0);
			}
		else if((but==239)||(but==111))
			{
			TMIN_EXT[a_ind . s_i1]++;
			}	
		else if((but==247)||(but==119))
			{
			TMIN_EXT[a_ind . s_i1]--;
			}	
		gran(&TMIN_EXT[a_ind . s_i1],-50,100);
		if(lc640_read_int(ADR_TMIN_EXT[a_ind . s_i1])!=TMIN_EXT[a_ind . s_i1]) lc640_write_int(ADR_TMIN_EXT[a_ind . s_i1],TMIN_EXT[a_ind . s_i1]);			
		speed=1;
		}		
	else if(a_ind . s_i==3) 
		{
		if(but==254)
			{
			if(!T_EXT_REL_EN[a_ind . s_i1])lc640_write_int(ADR_T_EXT_REL_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_T_EXT_REL_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==4) 
		{
		if(but==254)
			{
			if(!T_EXT_ZVUK_EN[a_ind . s_i1])lc640_write_int(ADR_T_EXT_ZVUK_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_T_EXT_ZVUK_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==5) 
		{
		if(but==254)
			{
			if(!T_EXT_LCD_EN[a_ind . s_i1])lc640_write_int(ADR_T_EXT_LCD_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_T_EXT_LCD_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==6) 
		{
		if(but==254)
			{
			if(!T_EXT_RS_EN[a_ind . s_i1])lc640_write_int(ADR_T_EXT_RS_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_T_EXT_RS_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==7) 
		{
		if(but==254)
			{
			tree_down(0,0);
			
			}
		}												
	}	

else if (a_ind . i==iExt_sk)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . s_i=3;
		gran_char(&a_ind . s_i,1,7);
		
		}
	else if(but==253)
		{
		if(a_ind . s_i==1)a_ind . i_s=0;
		else a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		gran_char(&a_ind . s_i,1,7);
		}	
	else if(but==123)
		{
		a_ind . s_i=7;
		}			
	else if(a_ind . s_i==1) 
		{
		if(but==254)
			{
			if(!SK_SIGN[a_ind . s_i1])lc640_write_int(ADR_SK_SIGN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_SIGN[a_ind . s_i1],0);
			}
		}
	else if(a_ind . s_i==3) 
		{
	
		
	
	
	
		}	
	else if(a_ind . s_i==4) 
		{
		if(but==254)
			{
			if(!SK_ZVUK_EN[a_ind . s_i1])lc640_write_int(ADR_SK_ZVUK_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_ZVUK_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==5) 
		{
		if(but==254)
			{
			if(!SK_LCD_EN[a_ind . s_i1])lc640_write_int(ADR_SK_LCD_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_LCD_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==6) 
		{
		if(but==254)
			{
			if(!SK_RS_EN[a_ind . s_i1])lc640_write_int(ADR_SK_RS_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_RS_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==7) 
		{
		if(but==254)
			{
			
			tree_down(0,0);
			}
		}												
	}	

else if (a_ind . i==iExt_sk_3U)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . s_i=3;
		gran_char(&a_ind . s_i,1,5);
		
		}
	else if(but==253)
		{
		if(a_ind . s_i==1)a_ind . i_s=0;
		else a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		gran_char(&a_ind . s_i,1,5);
		}	
	else if(but==123)
		{
		a_ind . s_i=5;
		}			
	else if(a_ind . s_i==1) 
		{
		if(but==254)
			{
			if(!SK_SIGN[a_ind . s_i1])lc640_write_int(ADR_SK_SIGN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_SIGN[a_ind . s_i1],0);
			}
		}
	else if(a_ind . s_i==3) 
		{
		if(but==254)
			{
			if(!SK_ZVUK_EN[a_ind . s_i1])lc640_write_int(ADR_SK_ZVUK_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_ZVUK_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==4) 
		{
		if(but==254)
			{
			if(!SK_LCD_EN[a_ind . s_i1])lc640_write_int(ADR_SK_LCD_EN[a_ind . s_i1],0xffff);
			else lc640_write_int(ADR_SK_LCD_EN[a_ind . s_i1],0);
			}
		}	
	else if(a_ind . s_i==5) 
		{
		if(but==254)
			{
			tree_down(0,0);
			}
		}												
	}	

else if (a_ind . i==iExt_ddv)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . s_i=3;
		gran_char(&a_ind . s_i,1,5);
		
		}
	else if(but==253)
		{
		if(a_ind . s_i==1)a_ind . i_s=0;
		else a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		gran_char(&a_ind . s_i,1,5);
		}	
	else if(but==123)
		{
		a_ind . s_i=7;
		}			
	else if(a_ind . s_i==1) 
		{
		if(but==254)
			{
			if(!SK_SIGN[0])lc640_write_int(ADR_SK_SIGN[0],0xffff);
			else lc640_write_int(ADR_SK_SIGN[0],0);
			}
		}
	else if(a_ind . s_i==3) 
		{
		if(but==254)
			{
			if(SK_REL_EN[0])lc640_write_int(ADR_SK_REL_EN[0],0);
			else lc640_write_int(ADR_SK_REL_EN[0],0xffff);
			}
		}	

	else if(a_ind . s_i==4) 
		{
		if(but==254)
			{
			if(SK_LCD_EN[0])lc640_write_int(ADR_SK_LCD_EN[0],0);
			else lc640_write_int(ADR_SK_LCD_EN[0],0xffff);
			}
		}	
	else if(a_ind . s_i==5) 
		{
		if(but==254)
			{
			tree_down(0,0);
			}
		}												
	}	

else if (a_ind . i==iExt_ddi)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . s_i=3;
		gran_char(&a_ind . s_i,1,5);
		
		}
	else if(but==253)
		{
		if(a_ind . s_i==1)a_ind . i_s=0;
		else a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		gran_char(&a_ind . s_i,1,5);
		}	
	else if(but==123)
		{
		a_ind . s_i=7;
		}			
	else if(a_ind . s_i==1) 
		{
		if(but==254)
			{
			if(!SK_SIGN[1])lc640_write_int(ADR_SK_SIGN[1],0xffff);
			else lc640_write_int(ADR_SK_SIGN[1],0);
			}
		}
	else if(a_ind . s_i==3) 
		{
		if(but==254)
			{
			if(SK_REL_EN[1])lc640_write_int(ADR_SK_REL_EN[1],0);
			else lc640_write_int(ADR_SK_REL_EN[1],0xffff);
			}
		}	
	else if(a_ind . s_i==4) 
		{
		if(but==254)
			{
			if(SK_LCD_EN[1])lc640_write_int(ADR_SK_LCD_EN[1],0);
			else lc640_write_int(ADR_SK_LCD_EN[1],0xffff);
			}
		}	
	else if(a_ind . s_i==5) 
		{
		if(but==254)
			{
			tree_down(0,0);
			}
		}												
	}
 
 else if (a_ind . i==iExt_dud)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)a_ind . s_i=3;
		gran_char(&a_ind . s_i,1,5);
		
		}
	else if(but==253)
		{
		if(a_ind . s_i==1)a_ind . i_s=0;
		else a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		gran_char(&a_ind . s_i,1,5);
		}	
	else if(but==123)
		{
		a_ind . s_i=7;
		}			
	else if(a_ind . s_i==1) 
		{
		if(but==254)
			{
			if(!SK_SIGN[2])lc640_write_int(ADR_SK_SIGN[2],0xffff);
			else lc640_write_int(ADR_SK_SIGN[2],0);
			}
		}
	else if(a_ind . s_i==3) 
		{
		if(but==254)
			{
			if(SK_REL_EN[2])lc640_write_int(ADR_SK_REL_EN[2],0);
			else lc640_write_int(ADR_SK_REL_EN[2],0xffff);
			}
		}	
	else if(a_ind . s_i==4) 
		{
		if(but==254)
			{
			if(SK_LCD_EN[2])lc640_write_int(ADR_SK_LCD_EN[2],0);
			else lc640_write_int(ADR_SK_LCD_EN[2],0xffff);
			}
		}	
	else if(a_ind . s_i==5) 
		{
		if(but==254)
			{
			tree_down(0,0);
			}
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


else if(a_ind . i==iK_220_IPS_TERMOKOMPENSAT)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+(NUMDT!=0));
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+(NUMDT!=0));
		}
	else if(but==123)
		{
		a_ind . s_i=2+(NUMBAT!=0)+(NUMIST!=0)+(NUMINV!=0)+(NUMDT!=0);
		}
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{
			if((AUSW_MAIN==22033)||(AUSW_MAIN==22018))
				{
				tree_up(iK_net3,0,0,0);
		     	ret(1000);
				}
			else
				{
				tree_up(iK_net,0,0,0);	
				ret(1000);		
				}
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

		else if((a_ind . s_i==(1+(NUMBAT!=0)+(NUMIST!=0))))
			{
			tree_up(iK_out,0,0,0);	
			ret(1000);
			}
          
         	else if((NUMDT)&&(a_ind . s_i==(2+(NUMBAT!=0)+(NUMIST!=0))))
			{
			tree_up(iK_t_ext_6U,0,0,0);	
			ret(1000);			
			}
 						
          else if(a_ind . s_i==(3+(NUMBAT!=0)+(NUMIST!=0) ))
			{
	          tree_down(0,0);
	          ret(0);
               }	               			
		}			
	}

else if(a_ind . i==iK_220_IPS_TERMOKOMPENSAT_IB)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3+(NUMIST!=0)+(NUMDT!=0));
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3+(NUMIST!=0)+(NUMDT!=0));
		}
	else if(but==123)
		{
		a_ind . s_i=3+(NUMIST!=0)+(NUMDT!=0);
		}
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{
			if((AUSW_MAIN==22063)||(AUSW_MAIN==22023)||(AUSW_MAIN==22043)||(AUSW_MAIN==22018))
				{
				tree_up(iK_net3,0,0,0);
		     	ret(1000);
				}
			else
				{
				tree_up(iK_net,0,0,0);	
				ret(1000);		
				}
			}
		else if(a_ind . s_i==1)
			{
			tree_up(iK_bat_ips_termokompensat_ib,0,0,0);	
			ret(1000);
			}
		else if((NUMIST)&&(a_ind . s_i==2))
			{
			tree_up(iK_bps_sel,0,0,0);	
			ret(1000);
			}

		else if((a_ind . s_i==(2+(NUMIST!=0))))
			{
			tree_up(iK_out,0,0,0);	
			ret(1000);
			}
          
         	else if((NUMDT)&&(a_ind . s_i==(3+(NUMIST!=0))))
			{
			tree_up(iK_t_ext_6U,0,0,0);	
			ret(1000);			
			}
 						
          else if(a_ind . s_i==(3+(NUMIST!=0)+(NUMDT!=0)))
			{
	          tree_down(0,0);
	          ret(0);
               }	               			
		}			
	}

else if(a_ind . i==iK_TELECORE)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,2+(NUMBAT_TELECORE!=0)+(NUMIST!=0)+(NUMDT!=0));
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,2+(NUMBAT_TELECORE!=0)+(NUMIST!=0)+(NUMDT!=0));
		}
	else if(but==123)
		{
		a_ind . s_i=2+(NUMBAT_TELECORE!=0)+(NUMIST!=0)+(NUMDT!=0);
		}				
	else if(but==254)
		{
		if(a_ind . s_i==0)
			{
			tree_up(iK_net,0,0,0);
		    ret(1000);
			}
		else if((NUMBAT_TELECORE)&&(a_ind . s_i==1))
			{
			tree_up(iK_bat_sel_TELECORE,0,0,0);	
			ret(1000);
			}
		else if((NUMIST)&&(a_ind . s_i==(1+(NUMBAT_TELECORE!=0))))
			{
			tree_up(iK_bps_sel,0,0,0);	
			ret(1000);
			}

		else if((a_ind . s_i==(1+(NUMBAT_TELECORE!=0)+(NUMIST!=0))))
			{
			tree_up(iK_load,0,0,0);	
			ret(1000);
			}
          
    	else if((NUMDT)&&(a_ind . s_i==(2+(NUMBAT_TELECORE!=0)+(NUMIST!=0))))
			{
			tree_up(iK_t_ext_6U,0,0,0);	
			ret(1000);			
			}
    	else if(a_ind . s_i==(2+(NUMBAT_TELECORE!=0)+(NUMIST!=0)+(NUMDT!=0)))
			{
	     	tree_down(0,0);
	        ret(0);
            }	               			
		}			
	}

else if(a_ind . i==iK_net)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,1);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,1);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=1;
		}				
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+16);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			
			temp_SS+=10;
			
			}	
		else if(but==247)
			{
			
			temp_SS--;
			
			}
		else if(but==119)
			{
			
			temp_SS-=10;
			
			}				
		speed=1;
		gran(&temp_SS,10,12000);
		lc640_write_int(0x10+16,temp_SS);
					
		}
	else if(a_ind . s_i==1)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}

else if(a_ind . i==iK_net3)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}				
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+44);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,150,4000);
		lc640_write_int(0x10+44,temp_SS);
		}

	else if(a_ind . s_i==1)
		{
		temp_SS=lc640_read_int(0x10+46);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,150,4000);
		lc640_write_int(0x10+46,temp_SS);
		}

	else if(a_ind . s_i==2)
		{
		temp_SS=lc640_read_int(0x10+48);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,150,4000);
		lc640_write_int(0x10+48,temp_SS);
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

else if(a_ind . i==iK_power_net)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,2);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,2);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}				
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+22);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+22,temp_SS);
					
		}
	else if(a_ind . s_i==1)
		{
		temp_SS=lc640_read_int(0x10+24);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+24,temp_SS);
					
		}



	else if(a_ind . s_i==2)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}

else if(a_ind . i==iK_power_net3)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,6);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,6);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=6;
		}
						
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+32);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+32,temp_SS);
		}

	else if(a_ind . s_i==1)
		{
		temp_SS=lc640_read_int(0x10+34);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+34,temp_SS);
		}

	else if(a_ind . s_i==2)
		{
		temp_SS=lc640_read_int(0x10+36);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+36,temp_SS);
		}

	else if(a_ind . s_i==3)
		{
		temp_SS=lc640_read_int(0x10+38);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+38,temp_SS);
		}

	else if(a_ind . s_i==4)
		{
		temp_SS=lc640_read_int(0x10+40);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+40,temp_SS);
		}

	else if(a_ind . s_i==5)
		{
		temp_SS=lc640_read_int(0x10+42);
		if(but==239)
			{
			temp_SS++;
			}
		else if(but==111)
			{
			temp_SS+=10;
			}	
		else if(but==247)
			{
			temp_SS--;
			}
		else if(but==119)
			{
			temp_SS-=10;
			}				
		speed=1;
		gran(&temp_SS,200,550);
		lc640_write_int(0x10+42,temp_SS);
		}




	else if(a_ind . s_i==6)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}

else if(a_ind . i==iK_bat_sel)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMBAT);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMBAT);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=1+NUMBAT;
		}	
	else if((but==254)&&(NUMBAT)&&(BAT_IS_ON[0]==bisON)&&(a_ind . s_i==0))
		{







		
	

 
		


		
     	

		ret(1000);
		}	
	else if((but==254)&&(NUMBAT)&&(BAT_IS_ON[1]==bisON)&&(a_ind . s_i==((BAT_IS_ON[0]==bisON))))
		{

		
		
     	
     		
		ret(1000);
		}	
	else if(a_ind . s_i==(NUMBAT))
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}				
	}

else if(a_ind . i==iK_bat_sel_TELECORE)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMBAT_TELECORE);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMBAT_TELECORE);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=1+NUMBAT_TELECORE;
		}
	else if(a_ind . s_i==0)
		{
		if((but==254)&&(NUMBAT_TELECORE>0))
			{
			tree_up(iK_bat_TELECORE,0,0,0);	
			ret(1000);
			}
		}	
	else if((a_ind . s_i==1)&&(NUMBAT_TELECORE>1))
		{
		if((but==254)&&(NUMBAT_TELECORE>1))
			{
			tree_up(iK_bat_TELECORE,0,0,1);	
			ret(1000);
			}
		}
	else if(a_ind . s_i==(NUMBAT_TELECORE))
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}				
	}

else if(a_ind . i==iK_bat_TELECORE)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if((a_ind . s_i==1)||(a_ind . s_i==2))a_ind . s_i=3;
		gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if((a_ind . s_i==1)||(a_ind . s_i==2)) a_ind . s_i=0;
        gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}			
					
	else if(a_ind . s_i==0)
		{
		if(but==254)
		     {
		     if(phase==0)
		          {
		          lc640_write_int(ADR_KI0BAT[a_ind . s_i1],ad7705_buff_[a_ind . s_i1]);
		          phase=1;
		          }
		     }	
		else
			{
			temp_SS=lc640_read_int(ADR_KI1BAT[a_ind . s_i1]);
			if(but==239)temp_SS++;
			else if(but==111)temp_SS+=2;
			else if(but==247)temp_SS--;
			else if(but==119)temp_SS-=2;
						
			gran(&temp_SS,20,4000);
			lc640_write_int(ADR_KI1BAT[a_ind . s_i1],temp_SS);
			phase=1;
			}
				
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

else if(a_ind . i==iK_bat_ips_termokompensat_ib)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if((a_ind . s_i==1)||(a_ind . s_i==2))a_ind . s_i=3;
		gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if((a_ind . s_i==1)||(a_ind . s_i==2)) a_ind . s_i=0;
          gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}			
					
	else if(a_ind . s_i==0)
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
									 	
	else if(a_ind . s_i==3)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}		

else if(a_ind . i==iK_bps_sel)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMIST);
		phase=0;
		mcp2515_transmit(a_ind . s_i,a_ind . s_i,0x16,0x63,0,0,0,0);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMIST);
		phase=0;
		mcp2515_transmit(a_ind . s_i,a_ind . s_i,0x16,0x63,0,0,0,0);
		}
	else if(but==123)
		{
		a_ind . s_i=1+NUMIST;
		}	
	else if((but==254)&&(NUMIST)&&(a_ind . s_i<NUMIST))
		{
		tree_up(iK_bps,0,0,a_ind . s_i);	
		
		mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0x16,0x63,0,0,0,0);
		
     	

		ret(1000);
		}	
	else if(a_ind . s_i==(NUMIST))
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}				
	}

else if(a_ind . i==iK_bps)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if((a_ind . s_i==1)||(a_ind . s_i==2))a_ind . s_i=3;
		else if((a_ind . s_i==4)||(a_ind . s_i==5))a_ind . s_i=9;
		else if((a_ind . s_i==7)||(a_ind . s_i==8))a_ind . s_i=9;
		else if((a_ind . s_i==10)||(a_ind . s_i==11))a_ind . s_i=12;
		else if((a_ind . s_i==13)||(a_ind . s_i==14))a_ind . s_i=15;
		else if((a_ind . s_i==16)||(a_ind . s_i==17))a_ind . s_i=18;
		gran_char(&a_ind . s_i,0,18);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if((a_ind . s_i==1)||(a_ind . s_i==2))a_ind . s_i=0;
		else if((a_ind . s_i==4)||(a_ind . s_i==5))a_ind . s_i=3;
		else if((a_ind . s_i==7)||(a_ind . s_i==8))a_ind . s_i=3;
		else if((a_ind . s_i==10)||(a_ind . s_i==11))a_ind . s_i=9;
		else if((a_ind . s_i==13)||(a_ind . s_i==14))a_ind . s_i=12;
		else if((a_ind . s_i==16)||(a_ind . s_i==17))a_ind . s_i=15;		
		gran_char(&a_ind . s_i,0,18);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=18;
		}
	else if (a_ind . s_i == 0)
		{
		if(but==231) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(0*16)+1,(0*16)+1,0,0,0);
	    else if(but==239) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(0*16)+2,(0*16)+2,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(0*16)+3,(0*16)+3,0,0,0);
    	else if(but==247) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(0*16)+4,(0*16)+4,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(0*16)+5,(0*16)+5,0,0,0);
		speed=1;
		}	
		
	else if (a_ind . s_i == 3)
		{
		if(but==231) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(1*16)+1,(1*16)+1,0,0,0);
	    else if(but==239) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(1*16)+2,(1*16)+2,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(1*16)+3,(1*16)+3,0,0,0);
    	else if(but==247) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(1*16)+4,(1*16)+4,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(1*16)+5,(1*16)+5,0,0,0);
		speed=1;
		}		
		















 	
		
	else if (a_ind . s_i == 9)
		{
		if(but==254)
			{
			mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(2*16)+1,(2*16)+1,0,0,0);
			phase=1;
			}
	    else if(but==239) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(2*16)+2,(2*16)+2,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(2*16)+3,(2*16)+3,0,0,0);
    	else if(but==247) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(2*16)+4,(2*16)+4,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(2*16)+5,(2*16)+5,0,0,0);
		speed=1;
		}		
		
	else if (a_ind . s_i == 12)
		{
		if(but==239) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(3*16)+2,(3*16)+2,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(3*16)+3,(3*16)+3,0,0,0);
    	else if(but==247) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(3*16)+4,(3*16)+4,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(3*16)+5,(3*16)+5,0,0,0);
		speed=1;
		}								

	else if (a_ind . s_i == 15)
		{
		if(but==231) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(5*16)+1,(5*16)+1,0,0,0);
	    else if(but==239) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(5*16)+2,(5*16)+2,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(5*16)+3,(5*16)+3,0,0,0);
    	else if(but==247) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(5*16)+4,(5*16)+4,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEE,(5*16)+5,(5*16)+5,0,0,0);
		speed=1;
		}
	else if(a_ind . s_i==18)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}
	}		

else if(a_ind . i==iRele_set)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4);
		}
	else if(but==123)
		{
		a_ind . s_i=4;
		}	
	else if((but==254)&&(a_ind . s_i>=0)&&(a_ind . s_i<=3))
		{
		tree_up(iRele_set_,0,0,a_ind . s_i);	
		
		
		
     	

		ret(1000);
		}	
	else if(a_ind . s_i==4)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}				
	}

else if(a_ind . i==iRele_set_)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if(a_ind . s_i==2)
			{
			a_ind . s_i=3;
			a_ind . i_s=2;
			}
		else if(a_ind . s_i==8)
			{
			a_ind . i_s=7;
			}
		else if(a_ind . s_i==9)
			{
			a_ind . s_i=10;
			}
		gran_char(&a_ind . s_i,0,11);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if(a_ind . s_i==2)a_ind . s_i=1;
		else if(a_ind . s_i==9)a_ind . s_i=8;
		gran_char(&a_ind . s_i,0,11);		
		}
	else if(but==123)
		{
		a_ind . s_i=11;
		}
	else if (a_ind . s_i == 0)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<0);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<0);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<0);
		}	
		
	else if (a_ind . s_i == 1)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<1);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<1);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<1);
		}	
		
	else if (a_ind . s_i == 3)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<2);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<2);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<2);
		}
		
	else if (a_ind . s_i == 4)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<3);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<3);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<3);
		}	
		
	else if (a_ind . s_i == 5)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<4);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<4);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<4);
		}							

	else if (a_ind . s_i == 6)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<5);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<5);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<5);
		}
	else if (a_ind . s_i == 7)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<6);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<6);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<6);
		}
	else if (a_ind . s_i == 8)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<7);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<7);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<7);
		}

	else if (a_ind . s_i == 10)
		{
		if(but==254) RELE_SET_MASK[a_ind . s_i1]^=(1<<8);
	    else if(but==239) RELE_SET_MASK[a_ind . s_i1]|=(1<<8);
    	else if(but==247) RELE_SET_MASK[a_ind . s_i1]&=~(1<<8);
		}

	else if(a_ind . s_i==11)
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	
	if(RELE_SET_MASK[a_ind . s_i1]!=lc640_read_int(ADR_EE_RELE_SET_MASK[a_ind . s_i1]))lc640_write_int(ADR_EE_RELE_SET_MASK[a_ind . s_i1],RELE_SET_MASK[a_ind . s_i1]);

	}

else if(a_ind . i==iInv_set)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,4);
		if(a_ind . s_i==1)
			{
			a_ind . s_i=2;
			a_ind . i_s=1;
			}
		if(a_ind . s_i==3)
			{
			a_ind . s_i=4;
			a_ind . i_s=2;
			}
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,4);
		if(a_ind . s_i==1)a_ind . s_i=0;
		if(a_ind . s_i==3)
			{
			a_ind . s_i=2;
			a_ind . i_s=2;
			}
		}
	else if (a_ind . s_i == 0)
		{
		if(but==239) 		mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xa2 ,0xa2 ,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xa3 ,0xa3 ,0,0,0);
    		else if(but==247) 	mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xa4 ,0xa4 ,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xa5 ,0xa5 ,0,0,0);
		speed=1;
		}
	else if (a_ind . s_i == 2)
		{
		if(but==239) 		mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xb2 ,0xb2 ,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xb3 ,0xb3 ,0,0,0);
    		else if(but==247) 	mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xb4 ,0xb4 ,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1+first_inv_slot,a_ind . s_i1+first_inv_slot,0xEE,0xb5 ,0xb5 ,0,0,0);
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
	}
	
else if(a_ind . i==iK_makb_sel)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,NUMMAKB);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,NUMMAKB);
		}
	else if(but==123)
		{
		a_ind . s_i=NUMMAKB;
		}	
	else if((but==254)&&(NUMMAKB)&&(a_ind . s_i<NUMMAKB))
		{
		if(makb[a_ind . s_i]._cnt<5)
			{
			tree_up(iK_makb,0,0,a_ind . s_i);
			ret(1000);
			}
		else show_mess(
					"                    ",
	          		"   НЕ ПОДКЛЮЧЕН!!!  ",
	          		"                    ",
	          		"                    ",1000);	
		}	
	else if(a_ind . s_i==(NUMMAKB))
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}				
	}

else if(a_ind . i==iK_makb)
	{
	ret(1000);
	if (but==253)
		{      
		a_ind . s_i--;
		
		
		gran_char(&a_ind . s_i,0,simax);
		}
		
	else if (but==251)
		{
		a_ind . s_i++;
		
		gran_char(&a_ind . s_i,0,simax);
		}
	else if(but==123)
		{
		a_ind . s_i=10;
		}
	else if ((a_ind . s_i >= 0) && (a_ind . s_i <= 9))
		{
		if(but==231) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEF,		(a_ind . s_i*16)+1,(a_ind . s_i*16)+1,0,0,0);
	     else if(but==239) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEF,	(a_ind . s_i*16)+2,(a_ind . s_i*16)+2,0,0,0);
		else if(but==111)	mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEF,	(a_ind . s_i*16)+3,(a_ind . s_i*16)+3,0,0,0);
    		else if(but==247) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEF,	(a_ind . s_i*16)+4,(a_ind . s_i*16)+4,0,0,0); 
		else if(but==119) mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0xEF,	(a_ind . s_i*16)+5,(a_ind . s_i*16)+5,0,0,0);
		speed=1;
		}	
		
	else if(a_ind . s_i==10)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}




else if(a_ind . i==iK_load)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i=1;
		}
	else if(but==253)
		{
		a_ind . s_i=0;
		}
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+20);
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
#line 11609 "main.c"
		gran(&temp_SS,100,5000);


		lc640_write_int(0x10+20,temp_SS);					
		speed=1;	
					
		}
	else if(a_ind . s_i==1)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
		}			
	}

else if(a_ind . i==iK_out)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,2);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,2);
		}
	else if(a_ind . s_i==0)
		{
		temp_SS=lc640_read_int(0x10+50);
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

		lc640_write_int(0x10+50,temp_SS);					
		speed=1;	
					
		}
	else if(a_ind . s_i==1)
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
	else if(a_ind . s_i==2)
		{
		if(but==254)
			{
			tree_down(0,1);
			ret(0);
			}
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
			
else if(a_ind . i==iBatLog)
	{
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,6);
		}
	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,6);
		}
	else if(but==123)
		{
		a_ind . s_i=6;
		}				
	else if((but==247)&&((a_ind . s_i==0)||(a_ind . s_i==3)||(a_ind . s_i==4)))
		{
		tree_down(0,0);
		}		
	else if(a_ind . s_i==0)
	     {
	     if(but==254)
	          {
	          
	          
	          
	               
	               
	               
	               
	          tree_up(iPrl_bat_in_out,0,0,a_ind . s_i1);
	          if(BAT_IS_ON[a_ind . s_i1]!=bisON) show_mess("  Введение батареи  ",
	          								 "    уничтожит все   ",
	          								 "   предшествующие   ",
	          								 "      данные!!!     ",4000);     
	          parol_init();
	          }
	     }
	else if(a_ind . s_i==1)
	     {
	     if(but==239)BAT_C_NOM[a_ind . s_i1]++;
	     else if(but==111)BAT_C_NOM[a_ind . s_i1]+=10;
	     else if(but==247)BAT_C_NOM[a_ind . s_i1]--;
	     else if(but==119)BAT_C_NOM[a_ind . s_i1]-=10;
	     gran(&BAT_C_NOM[a_ind . s_i1],0,2000);
	     lc640_write_int(ADR_EE_BAT_C_NOM[a_ind . s_i1],BAT_C_NOM[a_ind . s_i1]);
	     speed=1;
	     }		     
		
	else if(a_ind . s_i==3)
		{
		if(but==254)
			{ 
               cap=0;
			deep=lc640_read_int(1024+1024+512+1024+2);
			ptr=lc640_read_int(1024+1024+512+1024);
			
			if(deep>63)
				{
				deep=0;
			     ptr=0;
			     }
			     			
			for(i=0;i<deep;i++)
				{
				lc640_read_long_ptr(1024+(32*ptr),av_head);
				
				if((av_head[0]=='B')&&(av_head[1]==a_ind . s_i1)&&(av_head[2]=='K')) 	
					{
					cap++;
					content[cap-1]=ptr;
					}
					
				ptr=ptr_carry(ptr,64,-1); 
	
				} 
				
			tree_up(iBatLogKe,0,0,a_ind . s_i1);
			
			av_j_si_max=cap;
			if(av_j_si_max>63)av_j_si_max=0;
			} 
		}




	else if(a_ind . s_i==4)
		{
		if(but==254)
			{ 
               cap=0;
			deep=lc640_read_int(1024+1024+512+1024+2);
			ptr=lc640_read_int(1024+1024+512+1024);
			
			if(deep>63)
				{
				deep=0;
			     ptr=0;
			     }
			     
			for(i=0;i<deep;i++)
				{
				lc640_read_long_ptr(1024+(32*ptr),av_head);
				
				if((av_head[0]=='B') &&(av_head[2]=='Z')) 	
					{
					cap++;
					content[cap-1]=ptr;
					}
					
				ptr=ptr_carry(ptr,64,-1); 
				} 
				
			tree_up(iBatLogVz,0,0,a_ind . s_i1);   
			
			av_j_si_max=cap;
			if(av_j_si_max>63)av_j_si_max=0;
			} 
		else if(but==239)
			{
			
			
			} 
		}

	else if(a_ind . s_i==5)
		{
		if(but==254)
			{ 
               cap=0;
			deep=lc640_read_int(1024+1024+512+1024+2);
			ptr=lc640_read_int(1024+1024+512+1024);

			if(deep>63)
				{
				deep=0;
			     ptr=0;
			     }
			
			
			
			for(i=0;i<deep;i++)
				{
				lc640_read_long_ptr(1024+(32*ptr),av_head);
				
				if((av_head[0]=='B')&&(av_head[1]==a_ind . s_i1)&&(av_head[2]=='W')) 	
					{
					cap++;
					content[cap-1]=ptr;
					}
					
		   	


 
				ptr=ptr_carry(ptr,64,-1); 
				} 
				
			
 

			tree_up(iBatLogWrk,0,0,a_ind . s_i1);
			
			av_j_si_max=cap;
			if(av_j_si_max>63)av_j_si_max=0;
			} 
		else if(but==239)
			{
			
			
			} 
		}		
		 	         	
     else if(a_ind . s_i==6)
	     {
	     if(but==254)
	          {
			if(BAT_IS_ON[a_ind . s_i1]!=bisON)tree_down(0,-4);
	          else tree_down(0,0);
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
	if(but==254)
		{
		avar_ind_stat&=~(1L<<a_ind . s_i);
		if(avar_ind_stat)
			{
			while(!(avar_ind_stat&(1<<a_ind . s_i)))
				{
				a_ind . s_i++;
				if(a_ind . s_i>=32)
					{
					tree_down(0,0);
					avar_ind_stat=0;
					}
				}
		 	}
	 	else 
			{
			tree_down(0,0);
			avar_ind_stat=0;
			}
		}
 	}


		
else if(a_ind . i==iTst_VD)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		gran_char(&a_ind . s_i,0,10+NUMIST);
		phase=0;
		tst_state[0]=tstOFF;
		tst_state[1]=tstOFF;
		tst_state[2]=tstOFF;
		tst_state[3]=tstOFF;
		tst_state[4]=tstOFF;
		tst_state[5]=tstOFF;
		tst_state[6]=tstOFF;
		tst_state[7]=tstOFF;
		tst_state[8]=tstOFF;

		if(a_ind . s_i==1)
			{
			a_ind . s_i=2;
			a_ind . i_s=1;
			}
		if(a_ind . s_i==3)
			{
			a_ind . s_i=4;
			a_ind . i_s=3;
			}
		if(a_ind . s_i==5)
			{
			a_ind . s_i=6;
			a_ind . i_s=5;
			}
		if(a_ind . s_i==7)
			{
			a_ind . s_i=8;
			a_ind . i_s=7;
			}
		}

	else if(but==253)
		{
		a_ind . s_i--;
		gran_char(&a_ind . s_i,0,10+NUMIST);
		phase=0;
		tst_state[0]=tstOFF;
		tst_state[1]=tstOFF;
		tst_state[2]=tstOFF;
		tst_state[3]=tstOFF;
		tst_state[4]=tstOFF;
		tst_state[5]=tstOFF;
		tst_state[6]=tstOFF;
		tst_state[7]=tstOFF;
		tst_state[8]=tstOFF;
		
		if(a_ind . s_i==7)
			{
			a_ind . s_i=6;
			a_ind . i_s=4;
			} 
		if(a_ind . s_i==5)
			{
			a_ind . s_i=4;
			a_ind . i_s=5;
			} 
		if(a_ind . s_i==3)
			{
			a_ind . s_i=2;
			
			}
		if(a_ind . s_i==1)
			{
			a_ind . s_i=0;
			
			}
		}

	else if(a_ind . s_i==0)
		{
		if((but==254)||(but==239))
			{
			if(tst_state[0]==tstOFF) tst_state[0]=tst1;
			else if(tst_state[0]==tst1) tst_state[0]=tst2;
			else tst_state[0]=tstOFF; 
			}
		else if(but==247)
			{
			if(tst_state[0]==tst2) tst_state[0]=tst1;
			else if(tst_state[0]==tstOFF) tst_state[0]=tst2;
			else tst_state[0]=tstOFF; 
			}
		}
		
	else if(a_ind . s_i==2)
		{
		if((but==254)||(but==239))
			{
			if(tst_state[1]==tstOFF) tst_state[1]=tst1;
			else if(tst_state[1]==tst1) tst_state[1]=tst2;
			else tst_state[1]=tstOFF;
			}
		else if(but==247)
			{
			if(tst_state[1]==tst2) tst_state[1]=tst1;
			else if(tst_state[1]==tstOFF) tst_state[1]=tst2;
			else tst_state[1]=tstOFF;
			}
		}
			
	else if(a_ind . s_i==4)
		{
		if((but==254)||(but==239))
			{
			if(tst_state[2]==tstOFF) tst_state[2]=tst1;
			else if(tst_state[2]==tst1) tst_state[2]=tst2;
			else tst_state[2]=tstOFF;
			}
		else if(but==247)
			{
			if(tst_state[2]==tst2) tst_state[2]=tst1;
			else if(tst_state[2]==tstOFF) tst_state[2]=tst2;
			else tst_state[2]=tstOFF;
			}
		}

	else if(a_ind . s_i==6)
		{
		if((but==254)||(but==239))
			{
			if(tst_state[3]==tstOFF) tst_state[3]=tst1;
			else if(tst_state[3]==tst1) tst_state[3]=tst2;
			else tst_state[3]=tstOFF;
			}
		else if(but==247)
			{
			if(tst_state[3]==tst2) tst_state[3]=tst1;
			else if(tst_state[3]==tstOFF) tst_state[3]=tst2;
			else tst_state[3]=tstOFF;
			}
		}
	else if((a_ind . s_i>=8)&&(a_ind . s_i<(8+NUMIST))&&(NUMIST)&&((but==254)))	
		{
		tree_up(iTst_bps,0,0,a_ind . s_i-8);
		mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0x16,0x63,0,0,0,0);
		tst_state[5]=tst1;
		tst_state[6]=tstOFF;
		}											

	else if(a_ind . s_i==(8+NUMIST))
		{
		if(but==254)
			{
			tree_down(0,0);
			ret(0);
			}
		}
	else if(a_ind . s_i==(9+NUMIST))
		{
		if(but==254)
			{
			bRESET_INT_WDT=1;
			}
		}
	else if(a_ind . s_i==(10+NUMIST))
		{
		if(but==254)
			{
			bRESET_EXT_WDT=1;
			}
		}					
	}
#line 12613 "main.c"

#line 12823 "main.c"


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
#line 13528 "main.c"
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
	ret_ind(0,0,0);
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
else if(a_ind . i==iAvt_set)
	{
	ret(1000);
	if(but==251)
		{
		a_ind . s_i++;
		if((a_ind . s_i==1)||(a_ind . s_i==2))a_ind . s_i=3;
		gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==253)
		{
		a_ind . s_i--;
		if((a_ind . s_i==1)||(a_ind . s_i==2))a_ind . s_i=0;
		gran_char(&a_ind . s_i,0,3);
		phase=0;
		}
	else if(but==123)
		{
		a_ind . s_i=3;
		}
 	else if (a_ind . s_i == 0)
		{
		temp_SS=lc640_read_int(0x10+100+80);
		if(but==239)temp_SS++;
		else if(but==111)temp_SS+=2;
		else if(but==247)temp_SS--;
		else if(but==119)temp_SS-=2;
		else if(but==126)mcp2515_transmit(a_ind . s_i1,a_ind . s_i1,0x16,0xee,0xee,0,0,0);   
		



















		lc640_write_int(0x10+100+80,temp_SS);
		
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

		
but_an_end:
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


if(modbus_timeout_cnt<6)
	{
	modbus_timeout_cnt++;
	if(modbus_timeout_cnt>=6)
		{
		bMODBUS_TIMEOUT=1;
		}
	}
else if (modbus_timeout_cnt>6)
	{
	modbus_timeout_cnt=0;
	bMODBUS_TIMEOUT=0;
	}


  return;          




}



__irq void timer0_interrupt(void) 
{	




 
}





int main (void) 
{
char ind_reset_cnt=0;

char mac_adr[6] = { 0x00,0x73,0x04,50,60,70 };




SystemInit();

bTPS=1;

((SysTick_Type *) ((0xE000E000) + 0x0010))->LOAD = (SystemFrequency / 2000) - 1;
((SysTick_Type *) ((0xE000E000) + 0x0010))->CTRL = 0x07;






bps[0]._state=bsOFF_AV_NET;
bps[1]._state=bsOFF_AV_NET;
bps[2]._state=bsOFF_AV_NET;
bps[3]._state=bsOFF_AV_NET;
bps[4]._state=bsOFF_AV_NET;
bps[5]._state=bsOFF_AV_NET;
bps[6]._state=bsOFF_AV_NET;

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

a_ind . i=iMn_VD;












	
	bgnd_par(		"                    ",
     		"    Инициализация   ",
     		"      Ethernet      ",
     		"                    ");
	
	
	

	
	








adc_init();

((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIODIR|=(1<<11);
((LPC_GPIO_TypeDef *) ((0x2009C000UL) + 0x00000) )->FIOSET|=(1<<11);


lc640_write_int(100,134);

#line 14397 "main.c"



memo_read();


UARTInit(0, (uint32_t)MODBUS_BAUDRATE*10UL);	 








mac_adr[5]=*((char*)&AUSW_MAIN_NUMBER);
mac_adr[4]=*(((char*)&AUSW_MAIN_NUMBER)+1);
mac_adr[3]=*(((char*)&AUSW_MAIN_NUMBER)+2);
mem_copy (own_hw_adr, mac_adr, 6);

snmp_Community[0]=(char)lc640_read_int(0x10+500+200+270); 

snmp_Community[1]=(char)lc640_read_int(0x10+500+200+270+2);
if((snmp_Community[1]==0)||(snmp_Community[1]==' '))snmp_Community[1]=0;
snmp_Community[2]=(char)lc640_read_int(0x10+500+200+270+4);
if((snmp_Community[2]==0)||(snmp_Community[2]==' '))snmp_Community[2]=0;
snmp_Community[3]=(char)lc640_read_int(0x10+500+200+270+6);
if((snmp_Community[3]==0)||(snmp_Community[3]==' '))snmp_Community[3]=0;
snmp_Community[4]=(char)lc640_read_int(0x10+500+200+270+8);
if((snmp_Community[4]==0)||(snmp_Community[4]==' '))snmp_Community[4]=0;
snmp_Community[5]=(char)lc640_read_int(0x10+500+200+270+10);
if((snmp_Community[5]==0)||(snmp_Community[5]==' '))snmp_Community[5]=0;
snmp_Community[6]=(char)lc640_read_int(0x10+500+200+270+12);
if((snmp_Community[6]==0)||(snmp_Community[6]==' '))snmp_Community[6]=0;
snmp_Community[7]=(char)lc640_read_int(0x10+500+200+270+14);
if((snmp_Community[7]==0)||(snmp_Community[7]==' '))snmp_Community[7]=0;
snmp_Community[8]=(char)lc640_read_int(0x10+500+200+270+16);
if((snmp_Community[8]==0)||(snmp_Community[8]==' '))snmp_Community[8]=0;
snmp_Community[9]=0;  

if(lc640_read_int(0x10+500+200)==1)
	{
	bgnd_par(		"                    ",
     		"    Инициализация   ",
     		"      Ethernet      ",
     		"                    ");
	bitmap_hndl();
	lcd_out(lcd_bitmap);
	init_TcpNet ();
	lcd_out(lcd_bitmap);
	init_ETH();
	

	}

ind_reset_cnt=58;

if(__ee_spc_stat==spcVZ)
	{
	if(__ee_vz_cnt)
		{
		spc_stat=spcVZ;  
		vz_cnt_h=__ee_vz_cnt/60;
		vz_cnt_h_=(lc640_read_int(0x10+480+14)-__ee_vz_cnt)/60;
		if(vz_cnt_h_<0)vz_cnt_h_=0;
		vz_cnt_s_=(short)(((lc640_read_int(0x10+480+14)-__ee_vz_cnt)*60)%3600UL);

		vz_cnt_s=0;
		}
	}
else if(__ee_spc_stat==spcKE)
	{
	spc_stat=spcKE;
	spc_bat=__ee_spc_bat;
	bat[spc_bat]._zar_cnt_ke=0;
	spc_phase=__ee_spc_phase;
	}
watchdog_enable();
if((AUSW_MAIN==2400)||(AUSW_MAIN==4800)||(AUSW_MAIN==6000)||(BAT_TYPE==1))
	{
	cntrl_stat=350;
	cntrl_stat_old=350;
	}







#line 14505 "main.c"










can_mcp2515_init();



sc16is700_init((uint32_t)(MODBUS_BAUDRATE*10UL));



reload_hndl();

socket_tcp = tcp_get_socket (0x01, 0, 10, tcp_callback);
if (socket_tcp != 0) 
	{
    tcp_listen (socket_tcp, 502);
  	}

UOUT_=UOUT;


  		
while (1)  
	{
	bTPS=0; 
     
     main_TcpNet ();

	

	if(bMCP2515_IN)
		{
		bMCP2515_IN=0;
		can_in_an1();
		}

	if(bMODBUS_TIMEOUT)
		{
		bMODBUS_TIMEOUT=0;
		
		modbus_in();
		}

	if(bRXIN0) 
		{
		bRXIN0=0;
	
		uart_in0();
		} 






 

	





  
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

		can_mcp2515_hndl();
		



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
		char i;

     timer_tick ();
     tick = 1;

		b10Hz=0;
				


		
		ind_hndl(); 

		bitmap_hndl();
		if(!bRESET_EXT_WDT)
			{
			lcd_out(lcd_bitmap);
			}

		
		

		adc_window_cnt=0;  

		ret_hndl();  
		mess_hndl();

		cntrl_hndl();
			  

		
		ext_drv();
		avt_hndl();
		
		u_avar_hndl();
		t_sys_avar_hndl();
		overload_hndl();
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
		
		rele_av_hndl();
		rele_hndl();
		if(!bRESET_EXT_WDT)avar_hndl();
		zar_superviser_drv();
		snmp_data();
		
		

 		cntrl_hndl();
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
		num_necc_hndl();
		
		ubat_old_drv();
		beep_hndl();
		avg_hndl();
		u_out_reg_hndl();
		
		
		
	
		vent_hndl();

		plazma_plazma_plazma++;

		if(++ind_reset_cnt>=60)
			{
			ind_reset_cnt=0;
			lcd_init();
			lcd_on();
			lcd_clear();
			}
               
          vent_hndl();


		  
		if(t_ext_can_nd<10) t_ext_can_nd++;
		
		


		can_reset_hndl();
		npn_hndl();




 	
 
		
		
	



 

		powerAntiAliasingHndl();

		

		
		vent_resurs_hndl();
		


		vd_is_work_hndl();

		printf("a %s \r\n","abc");
		}
	if(b1min)
		{
		b1min=0;

		if((tloaddisable_cmnd)&&(tloaddisable_cmnd<=10))
			{
			tloaddisable_cmnd--;
			if(!tloaddisable_cmnd)tloaddisable_cmnd=20;
			}
		if((tbatdisable_cmnd)&&(tbatdisable_cmnd<=10))
			{
			if(!tbatdisable_cmnd)tbatdisable_cmnd=20;
			}
		
		numOfForvardBps_hndl();			
		}

	}
}
