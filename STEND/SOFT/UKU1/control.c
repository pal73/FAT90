#include "25lc640.h"
#include "control.h"
#include "mess.h"
#include "gran.h"
#include "common_func.h"
#include "eeprom_map.h"
//#include "avar_hndl.h"
#include "main.h"
#include "beep.h"
//#include "snmp_data_file.h" 
#include "sacred_sun.h"
#include "sc16is7xx.h"
//#include "modbus.h"
//#include "modbus_tcp.h"
#include <LPC17xx.h>

#define KOEFPOT  105L







extern signed short u_necc,u_necc_,u_necc_up,u_necc_dn;
extern signed short main_cnt_5Hz;
extern signed short num_necc;
extern signed short num_necc_Imax;
extern signed short num_necc_Imin;
//extern char bSAME_IST_ON;
//extern signed short Unet,unet_store;
//extern char bat_cnt_to_block[2];
//extern enum  {bisON=0x0055,bisOFF=0x00aa}BAT_IS_ON[2];
extern signed mat_temper;




//***********************************************
//Аварии
typedef struct  
	{
     unsigned int bAN:1; 
     unsigned int bAB1:1; 
     unsigned int bAB2:1;
     unsigned int bAS1:1;
     unsigned int bAS2:1;
     unsigned int bAS3:1;
     unsigned int bAS4:1;
     unsigned int bAS5:1;
     unsigned int bAS6:1;
     unsigned int bAS7:1;
     unsigned int bAS8:1;
     unsigned int bAS9:1;
     unsigned int bAS10:1;
     unsigned int bAS11:1;
     unsigned int bAS12:1;
     }avar_struct;
     
extern union 
{
avar_struct av;
int avar_stat;
}a__,a_;

//***********************************************
//АЦП
long adc_buff[16][16];
signed short adc_buff_max[12],adc_buff_min[12]={5000,5000,5000,5000,5000,5000,5000,5000,5000,5000},unet_buff_max,unet_buff_min=5000;
char adc_self_ch_cnt,adc_ch_net;
short adc_buff_[16];
char adc_cnt,adc_cnt1,adc_ch,adc_ch_cnt;
short zero_cnt;
enum_adc_stat adc_stat=asCH;
unsigned short net_buff[32],net_buff_,net_metr_buff_[3];
char net_buff_cnt;
short ADWR,period_cnt,non_zero_cnt;
char rele_stat=1;
char bRELE_OUT;
signed short adc_self_ch_buff[3],adc_self_ch_disp[3];
long main_power_buffer[8],main_power_buffer_;
short adc_result;
short main_power_buffer_cnt;
short adc_gorb_cnt,adc_zero_cnt;
char adc_window_flag;
short adc_window_cnt;
short adc_net_buff_cnt;


extern int mess_par0[MESS_DEEP],mess_par1[MESS_DEEP],mess_data[2];

extern signed short TBAT;
extern signed short Kunet;
extern signed short Kubat[2];
extern unsigned short ad7705_buff[2][16],ad7705_buff_[2];
extern unsigned short Kibat0[2];
extern signed short Kibat1[2];
extern signed short Ktbat[2];
//extern signed short bat_Ib[2];
short adc_buff_out_[3];
extern char kb_full_ver;
extern signed short Kuload;

signed short bat_ver_cnt=150;
extern signed short Isumm;
extern signed short Isumm_;
extern char ND_out[3];
//extern signed short tout[4];


short plazma_adc_cnt;
short plazma_sk;
extern char cntrl_plazma;

//extern const short ptr_bat_zar_cnt[2];

//***********************************************
//Управление вентилятором
signed char vent_stat=0;




//***********************************************
//Самокалиброввка
signed short samokalibr_cnt;



//***********************************************
//Выравнивание токов
short avg_main_cnt=20;
signed int i_avg_max,i_avg_min,i_avg_summ,i_avg; 
signed int avg;
char bAVG;
char avg_cnt_;  
char avg_num; 
char bAVG_BLOCK;
char bAVG_DIR;

short u_out_reg_main_cnt=10;

//**********************************************
//Контроль наличия батарей
signed short 	main_kb_cnt;
signed short 	kb_cnt_1lev;
signed short 	kb_cnt_2lev;
char 		kb_full_ver;
char kb_start[2],kb_start_ips;
signed short ibat_ips,ibat_ips_;

//**********************************************
//Работа с БПСами
char num_of_wrks_bps;
char bps_all_off_cnt,bps_mask_off_cnt,bps_mask_on_off_cnt;
char bps_hndl_2sec_cnt;
unsigned short bps_on_mask,bps_off_mask;
char num_necc_up,num_necc_down;
unsigned char sh_cnt0,b1Hz_sh;

//***********************************************
//Спецфункции
enum_spc_stat spc_stat;
char spc_bat;
char spc_phase;
unsigned short vz_cnt_s,vz_cnt_s_,vz_cnt_h,vz_cnt_h_;
char bAVZ;
enum_ke_start_stat ke_start_stat;
short cnt_end_ke;
unsigned long ke_date[2];
short __ee_vz_cnt;
short __ee_spc_stat;
short __ee_spc_bat;
short __ee_spc_phase;

//***********************************************
//Аварии
extern unsigned avar_stat;	 	//"Отображение" всех аварийных в данный момент устройств в одном месте
extern unsigned avar_ind_stat; 	//"Отображение" всех не просмотренных аварийных устройств в одном месте
extern unsigned avar_stat_old;
extern unsigned avar_stat_new,avar_stat_offed;
//Структура переменных
//1бит  - питающая сеть
//2бита - батареи
//12бит - БПСы
//5бит  - инверторы
//4бита - внешние датчики температуры
//4бита - внешние сухие контакты
//1бит	- контроль выходного напряжения


short cntrl_stat_blok_cnt,cntrl_stat_blok_cnt_,cntrl_stat_blok_cnt_plus[2],cntrl_stat_blok_cnt_minus[2];

//***********************************************
//Сухие контакты
const char sk_buff_KONTUR[4]={13,11,15,14};
const char sk_buff_RSTKM[4]={13,11,15,14};
const char sk_buff_GLONASS[4]={11,13,15,14};
const char sk_buff_3U[4]={11,13,15,14};
const char sk_buff_6U[4]={11,13,15,14};
const char sk_buff_220[4]={11,13,15,14};
const char sk_buff_TELECORE2015[4]={11,13,15,14};

char	plazma_inv[4];
char plazma_bat;
char plazma_cntrl_stat;

//***********************************************
//Ротация ведущего источника
char numOfForvardBps,numOfForvardBps_old;
char numOfForvardBps_minCnt;
short numOfForvardBps_hourCnt;

//***********************************************
// Параллельная работа в случае перегрева источника
//char bPARALLEL_NOT_ENOUG;
//char bPARALLEL_ENOUG;
//char bPARALLEL;

char cntrl_hndl_plazma;


//signed short u_avar_hndl_outu_max_cnt;
//signed short u_avar_hndl_outu_min_cnt;

//-----------------------------------------------
void ke_start(char in)
{          

}


//-----------------------------------------------
void samokalibr_init(void)
{
samokalibr_cnt=1785;
}
//-----------------------------------------------
void samokalibr_hndl(void)
{
if(++samokalibr_cnt>=1800)samokalibr_cnt=0;

if(samokalibr_cnt>=1785U)
	{
	mess_send(MESS2RELE_HNDL,PARAM_RELE_SAMOKALIBR,1,15);
	mess_send(MESS2IND_HNDL,PARAM_SAMOKALIBR,0,15);
	mess_send(MESS2MATEMAT,PARAM_SAMOKALIBR,0,15);
	} 

if(samokalibr_cnt==1799U)
	{
	if((Kibat0[0]!=ad7705_buff_[0])) lc640_write_int(ADR_KI0BAT[0],ad7705_buff_[0]);
	if((Kibat0[1]!=ad7705_buff_[1])) lc640_write_int(ADR_KI0BAT[1],ad7705_buff_[1]);
	
	}	 	
}



//-----------------------------------------------
void ubat_old_drv(void)
{        

}

//-----------------------------------------------
void matemat(void)
{
//signed short temp_SS;
signed long temp_SL/*,temp_SL_*/;
//signed short temp_SS;

#ifdef UKU_MGTS
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=110000L;
net_U=(signed short)temp_SL;
#endif

#ifdef UKU_RSTKM
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=110000L;
net_U=(signed short)temp_SL;
#endif

#ifdef UKU_3U
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=36000L;
net_U=(signed short)temp_SL;
#endif

#ifdef UKU_6U
//напряжение сети

if((AUSW_MAIN%10)||(AUSW_MAIN==2400)||(AUSW_MAIN==4800)||(AUSW_MAIN==6000))
	{

	if(bps[11]._device==dNET_METR)
		{
		net_metr_buff_[0]=((signed short)bps[11]._buff[0])+(((signed short)bps[11]._buff[1])<<8);
		net_metr_buff_[1]=((signed short)bps[11]._buff[2])+(((signed short)bps[11]._buff[3])<<8);
		net_metr_buff_[2]=((signed short)bps[11]._buff[4])+(((signed short)bps[11]._buff[5])<<8);

		temp_SL=(signed long)net_metr_buff_[0];
		temp_SL*=KunetA;
		temp_SL/=6000L;
		net_Ua=(signed short)temp_SL;
	
		temp_SL=(signed long)net_metr_buff_[1];
		temp_SL*=KunetB;
		temp_SL/=6000L;
		net_Ub=(signed short)temp_SL;
	
		temp_SL=(signed long)net_metr_buff_[2];
		temp_SL*=KunetC;
		temp_SL/=6000L;
		net_Uc=(signed short)temp_SL;
		}
	else
		{
		temp_SL=(signed long)net_buff_;
		temp_SL*=KunetA;
		temp_SL/=110000L;
		net_Ua=(signed short)temp_SL;
	
		temp_SL=(signed long)adc_buff_[3];
		temp_SL*=KunetB;
		temp_SL/=6000L;
		net_Ub=(signed short)temp_SL;
	
		temp_SL=(signed long)adc_buff_[10];
		temp_SL*=KunetC;
		temp_SL/=6000L;
		net_Uc=(signed short)temp_SL;
		}

	net_U=net_Ua;
	if(net_Ub<net_U)net_U=net_Ub;
	if(net_Uc<net_U)net_U=net_Uc;
	}
else 
	{
	temp_SL=(signed long)net_buff_;
	temp_SL*=Kunet;
	temp_SL/=110000L;
	net_U=(signed short)temp_SL;
	}




#endif

#ifdef UKU_GLONASS
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=110000L;
net_U=(signed short)temp_SL;
#endif

#ifdef UKU_KONTUR
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=110000L;
net_U=(signed short)temp_SL;
#endif


#ifdef UKU_220_V2
//напряжение сети

if(AUSW_MAIN==22033)
	{
	temp_SL=(signed long)net_buff_;
	temp_SL*=KunetA;
	temp_SL/=6000L;
	net_Ua=(signed short)temp_SL;

	temp_SL=(signed long)adc_buff_[3];
	temp_SL*=KunetB;
	temp_SL/=6000L;
	net_Ub=(signed short)temp_SL;

	temp_SL=(signed long)adc_buff_[10];
	temp_SL*=KunetC;
	temp_SL/=6000L;
	net_Uc=(signed short)temp_SL;

	net_U=net_Ua;
	if(net_Ub<net_U)net_U=net_Ub;
	if(net_Uc<net_U)net_U=net_Uc;
	}
else
	{
	temp_SL=(signed long)net_buff_;
	temp_SL*=Kunet;
	temp_SL/=5000L;
	net_U=(signed short)temp_SL;
	}
#endif


#ifdef UKU_220
//напряжение сети

if(AUSW_MAIN==22035)
	{
	temp_SL=(signed long)net_buff_;
	temp_SL*=KunetA;
	temp_SL/=6000L;
	net_Ua=(signed short)temp_SL;

	temp_SL=(signed long)adc_buff_[3];
	temp_SL*=KunetB;
	temp_SL/=6000L;
	net_Ub=(signed short)temp_SL;

	temp_SL=(signed long)adc_buff_[10];
	temp_SL*=KunetC;
	temp_SL/=6000L;
	net_Uc=(signed short)temp_SL;

	net_U=net_Ua;
	if(net_Ub<net_U)net_U=net_Ub;
	if(net_Uc<net_U)net_U=net_Uc;
	}
else
	{
	temp_SL=(signed long)net_buff_;
	temp_SL*=Kunet;
	#ifdef _ACDC_
	temp_SL/=500L;
	#else
	temp_SL/=5000L;
	#endif
	net_U=(signed short)temp_SL;
	
	}
#endif

#ifdef UKU_TELECORE2015
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=110000L;
net_U=(signed short)temp_SL;
#endif

#ifdef UKU_TELECORE2017
//напряжение сети
temp_SL=(signed long)net_buff_;
temp_SL*=Kunet;
temp_SL/=110000L;
net_U=(signed short)temp_SL;
#endif




//Напряжение нагрузки
temp_SL=(signed long)adc_buff_[2];
temp_SL*=Kuload;
temp_SL/=2000L;
load_U=(signed short)temp_SL;

#ifdef UKU_220 
//Напряжение нагрузки
temp_SL=(signed long)adc_buff_[2];
temp_SL*=Kuload;
temp_SL/=350L;
load_U=(signed short)temp_SL;
#endif

#ifdef UKU_220_V2 
//Напряжение нагрузки
temp_SL=(signed long)adc_buff_[2];
temp_SL*=Kuload;
temp_SL/=350L;
load_U=(signed short)temp_SL;
#endif

#ifdef UKU_VD
//Напряжение выхода
temp_SL=(signed long)adc_buff_[1];
temp_SL*=Kuout;
temp_SL/=500L;
out_U=(signed short)temp_SL;


//Напряжение вольтдобавки
temp_SL=(signed long)adc_buff_[2];
temp_SL*=Kuvd;
temp_SL/=500L;
vd_U=(signed short)temp_SL;

//Напряжение входа
in_U=out_U-vd_U;

//Напряжение выпрямителей
temp_SL=(signed long)adc_buff_[2];
temp_SL*=Kubps;
if(AUSW_MAIN==22010)temp_SL/=400L;
else temp_SL/=500L;
bps_U=(signed short)temp_SL;


#endif


#ifdef UKU_KONTUR
//Внешний датчик температуры №1(температура внешнего воздуха)
if((adc_buff_[5]>800)&&(adc_buff_[5]<3800))ND_EXT[0]=0;
else ND_EXT[0]=1;
temp_SL=(signed long)adc_buff_[5];
temp_SL*=Ktext[0];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[0]=(signed short)temp_SL;
#else 
//Внешний датчик температуры №1(температура внешнего воздуха)
if((adc_buff_[5]>800)&&(adc_buff_[5]<3800))ND_EXT[0]=0;
else ND_EXT[0]=1;
temp_SL=(signed long)adc_buff_[5];
temp_SL*=Ktext[0];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[0]=(signed short)temp_SL;
/*
if((adc_buff_[6]>800)&&(adc_buff_[6]<3800))ND_EXT[1]=0;
else ND_EXT[1]=1;
temp_SL=(signed long)adc_buff_[6];
temp_SL*=Ktext[1];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[1]=(signed short)temp_SL;	*/
#endif

#ifdef UKU_220

//Внешний датчик температуры №2(температура отсека ЭПУ)
if((adc_buff_[3]>800)&&(adc_buff_[3]<3800))ND_EXT[1]=0;
else ND_EXT[1]=1;
temp_SL=(signed long)adc_buff_[3];
temp_SL*=Ktext[1];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[1]=(signed short)temp_SL;

//Внешний датчик температуры №3(температура отсека MSAN)
if((adc_buff_[10]>800)&&(adc_buff_[10]<3800))ND_EXT[2]=0;
else ND_EXT[2]=1;
temp_SL=(signed long)adc_buff_[10];
temp_SL*=Ktext[2];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[2]=(signed short)temp_SL;

#else


#ifdef UKU_220_IPS_TERMOKOMPENSAT

//Внешний датчик температуры 
if((adc_buff_[6]>800)&&(adc_buff_[6]<3800))ND_EXT[0]=0;
else ND_EXT[0]=1;
temp_SL=(signed long)adc_buff_[6];
temp_SL*=Ktext[0];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[0]=(signed short)temp_SL;
sys_T=t_ext[0];
#else



//Внешний датчик температуры №2(температура отсека ЭПУ)
if((adc_buff_[6]>800)&&(adc_buff_[6]<3800))ND_EXT[1]=0;
else ND_EXT[1]=1;
temp_SL=(signed long)adc_buff_[6];
temp_SL*=Ktext[1];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[1]=(signed short)temp_SL;

//Внешний датчик температуры №3(температура отсека MSAN)
if((adc_buff_[3]>800)&&(adc_buff_[3]<3800))ND_EXT[2]=0;
else ND_EXT[2]=1;
temp_SL=(signed long)adc_buff_[3];
temp_SL*=Ktext[2];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[2]=(signed short)temp_SL;

#endif
#endif


#ifdef UKU_TELECORE2015

//Внешний датчик температуры №1
if((adc_buff_[7]>800)&&(adc_buff_[7]<3800))ND_EXT[0]=0;
else ND_EXT[0]=1;
temp_SL=(signed long)adc_buff_[7];
temp_SL*=Ktext[0];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[0]=(signed short)temp_SL;


//Внешний датчик температуры №2
if((adc_buff_[6]>800)&&(adc_buff_[6]<3800))ND_EXT[1]=0;
else ND_EXT[1]=1;
temp_SL=(signed long)adc_buff_[6];
temp_SL*=Ktext[1];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[1]=(signed short)temp_SL;

#endif

#ifdef UKU_TELECORE2017

//Внешний датчик температуры №1
if((adc_buff_[7]>800)&&(adc_buff_[7]<3800))ND_EXT[0]=0;
else ND_EXT[0]=1;
temp_SL=(signed long)adc_buff_[7];
temp_SL*=Ktext[0];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[0]=(signed short)temp_SL;


//Внешний датчик температуры №2
if((adc_buff_[6]>800)&&(adc_buff_[6]<3800))ND_EXT[1]=0;
else ND_EXT[1]=1;
temp_SL=(signed long)adc_buff_[6];
temp_SL*=Ktext[1];
temp_SL/=20000L;
temp_SL-=273L;
t_ext[1]=(signed short)temp_SL;

#endif

//напряжение ввода
temp_SL=(signed long)adc_buff_ext_[0];
temp_SL*=Kunet_ext[0];
temp_SL/=4000L;
Uvv[0]=(signed short)temp_SL;
if(Uvv[0]<100) Uvv0=Uvv[0];
else Uvv0=net_U;

//напряжение пэс
temp_SL=(signed long)adc_buff_ext_[1];
temp_SL*=Kunet_ext[1];
temp_SL/=4000L;
Uvv[1]=(signed short)temp_SL;


//напряжение ввода трехфазное
temp_SL=(signed long)eb2_data_short[0];
temp_SL*=Kvv_eb2[0];
temp_SL/=6000L;
Uvv_eb2[0]=(signed short)temp_SL;

temp_SL=(signed long)eb2_data_short[1];
temp_SL*=Kvv_eb2[1];
temp_SL/=6000L;
Uvv_eb2[1]=(signed short)temp_SL;

temp_SL=(signed long)eb2_data_short[2];
temp_SL*=Kvv_eb2[2];
temp_SL/=6000L;
Uvv_eb2[2]=(signed short)temp_SL;

//напряжение пэс трехфазное
temp_SL=(signed long)eb2_data_short[3];
temp_SL*=Kpes_eb2[0];
temp_SL/=6000L;
Upes_eb2[0]=(signed short)temp_SL;

temp_SL=(signed long)eb2_data_short[4];
temp_SL*=Kpes_eb2[1];
temp_SL/=6000L;
Upes_eb2[1]=(signed short)temp_SL;

temp_SL=(signed long)eb2_data_short[5];
temp_SL*=Kpes_eb2[2];
temp_SL/=6000L;
Upes_eb2[2]=(signed short)temp_SL;

//Вычисление температуры шкафа

ibt._T[0]=t_ext[1]+273;
ibt._T[1]=t_ext[2]+273;

ibt._nd[0]=ND_EXT[1];
ibt._nd[1]=ND_EXT[2];

#ifndef UKU_TELECORE2015
if((ibt._nd[0]==0) &&  (ibt._nd[1]==0))
	{
	t_box=((ibt._T[0]+ibt._T[1])/2)-273;
	}
else if((ibt._nd[0]==1) &&  (ibt._nd[1]==0))
	{
	t_box=ibt._T[1]-273;
	}
else if((ibt._nd[0]==0) &&  (ibt._nd[1]==1))
	{
	t_box=ibt._T[0]-273;
	}
else if((ibt._nd[0]==1) &&  (ibt._nd[1]==1))
	{
	if(t_ext_can_nd<5)t_box= t_ext_can;
	else t_box=20;
	}
#endif
/*
//Вычисление температуры шкафа

ibt._T[0]=bat[0]._Tb+273;
ibt._T[1]=bat[1]._Tb+273;
ibt._T[2]=t_ext[1]+273;
ibt._T[3]=t_ext[2]+273;

ibt._nd[0]=bat[0]._nd;
ibt._nd[1]=bat[1]._nd;
ibt._nd[2]=ND_EXT[1];
ibt._nd[3]=ND_EXT[2];

ibt._avg1=0;
ibt._avg_cnt=4;

if(ibt._nd[0]==0)
	{
	ibt._avg1+=ibt._T[0];
	}
else 
	{
	ibt._avg_cnt--;
	}

if(ibt._nd[1]==0)
	{
	ibt._avg1+=ibt._T[1];
	}
else 
	{
	ibt._avg_cnt--;
	}

if(ibt._nd[2]==0)
	{
	ibt._avg1+=ibt._T[2];
	}
else 
	{
	ibt._avg_cnt--;
	}

if(ibt._nd[3]==0)
	{
	ibt._avg1+=ibt._T[3];
	}
else 
	{
	ibt._avg_cnt--;
	}

if(ibt._avg_cnt==0)
	{
	}
else
	{
	ibt._avg1/=ibt._avg_cnt;
	}


if(ibt._nd[0]!=0)
	{
	ibt._T_dispers[0]=0;
	}
else 
	{
	ibt._T_dispers[0]=abs(ibt._T[0]-ibt._avg1);
	}

if(ibt._nd[1]!=0)
	{
	ibt._T_dispers[1]=0;
	}
else 
	{
	ibt._T_dispers[1]=abs(ibt._T[1]-ibt._avg1);
	}

if(ibt._nd[2]!=0)
	{
	ibt._T_dispers[2]=0;
	}
else 
	{
	ibt._T_dispers[2]=abs(ibt._T[2]-ibt._avg1);
	}

if(ibt._nd[3]!=0)
	{
	ibt._T_dispers[3]=0;
	}
else 
	{
	ibt._T_dispers[3]=abs(ibt._T[3]-ibt._avg1);
	}

if(	ibt._nd[0]&&
	ibt._nd[1]&&
	ibt._nd[2]&&
	ibt._nd[3]
	)
	{
	t_box=(bps[0]._Ti);
	}

else if(	ibt._nd[0]||
	ibt._nd[1]||
	ibt._nd[2]||
	ibt._nd[3]
	)
	{
	t_box=(ibt._avg1-273);
	}
else 
	{
	ibt._max_dispers_num=0;
	ibt._max_dispers=ibt._T_dispers[0];

	if(ibt._T_dispers[1]>ibt._max_dispers)
		{
		ibt._max_dispers_num=1;
		ibt._max_dispers=ibt._T_dispers[1];
		}
	if(ibt._T_dispers[2]>ibt._max_dispers)
		{
		ibt._max_dispers_num=2;
		ibt._max_dispers=ibt._T_dispers[2];
		}
	if(ibt._T_dispers[3]>ibt._max_dispers)
		{
		ibt._max_dispers_num=3;
		ibt._max_dispers=ibt._T_dispers[3];
		}

	ibt._avg2=0;

	if(ibt._max_dispers_num!=0)
		{
		ibt._avg2+=ibt._T[0];
		}
	if(ibt._max_dispers_num!=1)
		{
		ibt._avg2+=ibt._T[1];
		}
	if(ibt._max_dispers_num!=2)
		{
		ibt._avg2+=ibt._T[2];
		}
	if(ibt._max_dispers_num!=3)
		{
		ibt._avg2+=ibt._T[3];
		}

	t_box=(ibt._avg2/3)-273;

	}*/


//*********************************************


#ifdef TELECORE
Ibmax=0;
/*
if((NUMBAT_TELECORE>0)&&(lakb[0]._communicationFullErrorStat==0)&&(lakb[0]._ch_curr/10>Ibmax))Ibmax=lakb[0]._ch_curr/10;
if((NUMBAT_TELECORE>1)&&(lakb[1]._communicationFullErrorStat==0)&&(lakb[1]._ch_curr/10>Ibmax))Ibmax=lakb[1]._ch_curr/10;
if((NUMBAT_TELECORE>2)&&(lakb[2]._communicationFullErrorStat==0)&&(lakb[2]._ch_curr/10>Ibmax))Ibmax=lakb[2]._ch_curr/10;
*/
if((NUMBAT_TELECORE>0)&&(bat[0]._Ib/10>Ibmax))Ibmax=bat[0]._Ib/10;
if((NUMBAT_TELECORE>1)&&(bat[1]._Ib/10>Ibmax))Ibmax=bat[1]._Ib/10;
//if((BAT_IS_ON[0]==bisON)&&(bat[0]._Ub>200)) Ibmax=bat[0]._Ib/1;
//if((BAT_IS_ON[1]==bisON)&&(bat[1]._Ub>200)&&(bat[1]._Ib>bat[0]._Ib)) Ibmax=bat[1]._Ib;
#endif
//Ibmax=bat[0]._Ib;
//if((AUSW_MAIN==22063)||(AUSW_MAIN==22023)||(AUSW_MAIN==22043))Ibmax=Ib_ips_termokompensat;

#ifdef UKU_TELECORE2017
Ibmax=0;
if((NUMBAT_TELECORE>0)&&(bat[0]._Ib/10>Ibmax))Ibmax=bat[0]._Ib/10;
if((NUMBAT_TELECORE>1)&&(bat[1]._Ib/10>Ibmax))Ibmax=bat[1]._Ib/10;
#endif


load_I=0;
Isumm=0;




#ifdef UKU_GLONASS
inv[0]._Uio=6;
if (NUMINV)
	{
	for(i=0;i<NUMINV;i++)
		{
		if(bps[i+first_inv_slot]._cnt<25)
     		{
     		inv[i]._Ii=bps[i+first_inv_slot]._buff[0]+(bps[i+first_inv_slot]._buff[1]*256);
     		inv[i]._Uin=bps[i+first_inv_slot]._buff[2]+(bps[i+first_inv_slot]._buff[3]*256);
     		inv[i]._Uio=bps[i+first_inv_slot]._buff[4]+(bps[i+first_inv_slot]._buff[5]*256);
     		inv[i]._Ti=(signed)(bps[i+first_inv_slot]._buff[6]);
     		inv[i]._flags_tm=bps[i+first_inv_slot]._buff[8];
	    	//	inv[i]._rotor=bps[i+first_inv_slot]._buff[10]+(bps[i+first_inv_slot]._buff[11]*256);
			inv[i]._cnt=0;    
     		} 
		else 
     		{
     		inv[i]._Uio=0; 
     		inv[i]._Ii=0;
     		inv[i]._Uin=0;
     		inv[i]._Ti=0;
     		inv[i]._flags_tm=0; 
//	     	inv[i]._rotor0;
			inv[i]._cnt=25;    
     		}
     	}
   	}
#endif



#ifdef UKU_TELECORE2015
//вычисление параметров работы батареи
//TODO дописать для всех батарей все параметры и при отцепке батарей
li_bat._batStat=bsOK;
if(BAT_TYPE==1) //COSLIGHT
	{
	if(li_bat._batStat==bsOK)
		{
		li_bat._Ub=lakb[0]._tot_bat_volt/10;

		if(lakb[0]._ch_curr)li_bat._Ib=lakb[0]._ch_curr/10;
		else if(lakb[0]._dsch_curr) li_bat._Ib=bat[0]._Ib/10;//lakb[0]._dsch_curr/10;
	
		li_bat._ratCap=lakb[0]._rat_cap/100;
		li_bat._soc=lakb[0]._s_o_c;
		li_bat._soh=lakb[0]._s_o_h;
		li_bat._cclv=lakb[0]._c_c_l_v/10;
		li_bat._Tb=lakb[0]._max_cell_temp;
		li_bat._rbt=lakb[0]._r_b_t;
		}
	else 
		{
		li_bat._Ub=bat[0]._Ub;
		li_bat._Ib=bat[0]._Ib/10;
		li_bat._Tb=bat[0]._Tb;
		}

	if((li_bat._485Error)||(li_bat._canError))
		{
		li_bat._batStat=bsOFF;
		}
	else li_bat._batStat=bsOK;
	}
else if(BAT_TYPE==2) //SACRED SUN
	{
	}
else if(BAT_TYPE==3) //ZTT
	{
	if(li_bat._batStat==bsOK)
		{

		}
	}
#endif


/*
if((BAT_IS_ON[0]==bisON)&&(BAT_TYPE[0]==1)&&(BAT_LINK==0))
	{


	if(bat_drv_rx_buff[13]<=0x39)bbb[0]=bat_drv_rx_buff[13]-0x30;
	else bbb[0]=bat_drv_rx_buff[13]-55;
	if(bat_drv_rx_buff[14]<=0x39)bbb[1]=bat_drv_rx_buff[14]-0x30;
	else bbb[1]=bat_drv_rx_buff[14]-55;
	if(bat_drv_rx_buff[15]<=0x39)bbb[2]=bat_drv_rx_buff[15]-0x30;
	else bbb[2]=bat_drv_rx_buff[15]-55;
	if(bat_drv_rx_buff[16]<=0x39)bbb[3]=bat_drv_rx_buff[16]-0x30;
	else bbb[3]=bat_drv_rx_buff[16]-55;

	tempSS=0;
	tempSS=((bbb[0]*4096)+(bbb[1]*256)+(bbb[2]*16)+bbb[3]);

	bat[0]._max_cell_volt=(tempSS+5)/10;

	if(bat_drv_rx_buff[17]<=0x39)bbb[0]=bat_drv_rx_buff[17]-0x30;
	else bbb[0]=bat_drv_rx_buff[17]-55;
	if(bat_drv_rx_buff[18]<=0x39)bbb[1]=bat_drv_rx_buff[18]-0x30;
	else bbb[1]=bat_drv_rx_buff[18]-55;
	if(bat_drv_rx_buff[19]<=0x39)bbb[2]=bat_drv_rx_buff[19]-0x30;
	else bbb[2]=bat_drv_rx_buff[19]-55;
	if(bat_drv_rx_buff[20]<=0x39)bbb[3]=bat_drv_rx_buff[20]-0x30;
	else bbb[3]=bat_drv_rx_buff[20]-55;

	tempSS=0;
	tempSS=((bbb[0]*4096)+(bbb[1]*256)+(bbb[2]*16)+bbb[3]);

	bat[0]._min_cell_volt=(tempSS+5)/10;


	}*/



}



//-----------------------------------------------
void adc_init(void)
{

SET_REG(LPC_PINCON->PINSEL1,1,(25-16)*2,2);
SET_REG(LPC_PINCON->PINSEL1,1,(24-16)*2,2);
SET_REG(LPC_PINCON->PINSEL1,1,(23-16)*2,2);


SET_REG(LPC_PINCON->PINMODE1,2,(25-16)*2,2);
SET_REG(LPC_PINCON->PINMODE1,2,(24-16)*2,2);
SET_REG(LPC_PINCON->PINMODE1,2,(23-16)*2,2);

SET_REG(LPC_ADC->ADCR,0,24,3);

SET_REG(LPC_ADC->ADCR,1,21,1);
SET_REG(LPC_ADC->ADCR,0,16,1);
SET_REG(LPC_ADC->ADCR,1,8,8);

//SET_REG(LPC_GPIO0->FIODIR,7,5,3);
//SET_REG(LPC_GPIO0->FIOPIN,4,5,3);
	
	/*if(adc_ch<=7)*///SET_REG(LPC_ADC->ADCR,1<<5,0,8);
     /*else if(adc_ch==8) SET_REG(LPC_ADC->ADCR,1<<2,0,8);
     else SET_REG(LPC_ADC->ADCR,1<<4,0,8);*/

LPC_ADC->ADINTEN     =  (1<< 8);      /* global enable interrupt            */

NVIC_EnableIRQ(ADC_IRQn);             /* enable ADC Interrupt               */


}

//-----------------------------------------------
void adc_drv7(void) //(Uсети - постоянка)
{
//int temp_S;
//char i;
//signed short temp_SS;

adc_self_ch_disp[0]=abs_pal(adc_self_ch_buff[1]-adc_self_ch_buff[0]);//adc_self_ch_buff[0]&0x0f80;
adc_self_ch_disp[1]=abs_pal(adc_self_ch_buff[2]-adc_self_ch_buff[1]);//adc_self_ch_buff[1]&0x0f80;
adc_self_ch_disp[2]=abs_pal(adc_self_ch_buff[2]-adc_self_ch_buff[0]);//adc_self_ch_buff[2]&0x0f80;

//adc_self_ch_disp[0]=adc_self_ch_buff[0]&0x0ff0;
//adc_self_ch_disp[1]=adc_self_ch_buff[1]&0x0ff0;
//adc_self_ch_disp[2]=adc_self_ch_buff[2]&0x0ff0;


if(adc_self_ch_disp[2]<300)//==adc_self_ch_disp[2])
	{
	adc_result=adc_self_ch_buff[2];
	} 
else if(adc_self_ch_disp[1]<300)//==adc_self_ch_disp[2])
	{
	adc_result=adc_self_ch_buff[1];
	}
else if(adc_self_ch_disp[0]<300)//==adc_self_ch_disp[1])
	{
	adc_result=adc_self_ch_buff[0];
	}
    //adc_result=92;

if(adc_ch_net)
	{

	main_power_buffer[0]+=(long)(adc_result);
	main_power_buffer[1]+=(long)(adc_result);
	main_power_buffer[2]+=(long)(adc_result);
	main_power_buffer[3]+=(long)(adc_result);

	adc_net_buff_cnt++;
	if(adc_net_buff_cnt>=0x1000)
		{
		adc_net_buff_cnt=0;
		}
	if((adc_net_buff_cnt&0x03ff)==0)
		{
		#ifdef UKU_220
		net_buff_=(short)((main_power_buffer[adc_net_buff_cnt>>10])>>11);
		#else
		#ifdef UKU_220_V2
		net_buff_=(short)((main_power_buffer[adc_net_buff_cnt>>10])>>11);
		#else
		net_buff_=(short)((main_power_buffer[adc_net_buff_cnt>>10])>>8);
		#endif
		#endif
		main_power_buffer[adc_net_buff_cnt>>10]=0;
		}


	} 
else if(!adc_ch_net)
	{
	adc_buff[adc_ch][adc_ch_cnt]=(long)adc_result;
	
	if((adc_ch_cnt&0x03)==0)
		{
		long temp_L;
		char i;
		temp_L=0;
		for(i=0;i<16;i++)
			{
			temp_L+=adc_buff[adc_ch][i];
			}
		adc_buff_[adc_ch]= (short)(temp_L>>4);

		//adc_buff_[3]=346;
		}
	if(++adc_ch>=16) 
		{
		adc_ch=0;
		adc_ch_cnt++;
		if(adc_ch_cnt>=16)adc_ch_cnt=0;
		}
	}

//adc_buff[adc_ch][adc_cnt1]=(adc_self_ch_buff[2]+adc_self_ch_buff[1])/2;

//if(adc_buff[adc_ch][adc_cnt1]<adc_buff_min[adc_ch])adc_buff_min[adc_ch]=adc_buff[adc_ch][adc_cnt1];
//if(adc_buff[adc_ch][adc_cnt1]>adc_buff_max[adc_ch])adc_buff_max[adc_ch]=adc_buff[adc_ch][adc_cnt1];
/*
	{
	if((adc_cnt1&0x03)==0)
		{
		temp_S=0;
		for(i=0;i<16;i++)
			{
			temp_S+=adc_buff[adc_ch][i];
			} 
         	adc_buff_[adc_ch]=temp_S>>4;
          }
	}*/


		  

adc_self_ch_cnt=0;

adc_ch_net++;
adc_ch_net&=1;

//SET_REG(LPC_GPIO0->FIODIR,7,5,3);
//SET_REG(LPC_GPIO0->FIOPIN,adc_ch,5,3);

if(adc_ch_net)
	{
	//LPC_GPIO2->FIODIR|=(1<<7);
	//LPC_GPIO2->FIOPIN|=(1<<7);
	SET_REG(LPC_ADC->ADCR,1<<2,0,8);
	}
else
	{
	//LPC_GPIO2->FIODIR|=(1<<7);
	//LPC_GPIO2->FIOPIN&=~(1<<7);
	if(!(adc_ch&(1<<3)))SET_REG(LPC_ADC->ADCR,1<<0,0,8);
	else 			SET_REG(LPC_ADC->ADCR,1<<1,0,8);


	SET_REG(LPC_GPIO0->FIODIR,1,28,1);
	SET_REG(LPC_GPIO1->FIODIR,1,30,1);
	SET_REG(LPC_GPIO3->FIODIR,1,26,1);

	if(!(adc_ch&(1<<0)))SET_REG(LPC_GPIO0->FIOPIN,0,28,1);
	else 			SET_REG(LPC_GPIO0->FIOPIN,1,28,1);

	if(!(adc_ch&(1<<1)))SET_REG(LPC_GPIO1->FIOPIN,0,30,1);
	else 			SET_REG(LPC_GPIO1->FIOPIN,1,30,1);

	if(!(adc_ch&(1<<2)))SET_REG(LPC_GPIO3->FIOPIN,0,26,1);
	else 			SET_REG(LPC_GPIO3->FIOPIN,1,26,1);
	}
	



LPC_ADC->ADCR |=  (1<<24);

}

//-----------------------------------------------
void adc_drv6(void) //(с попыткой измерять горбы)
{
//int temp_S;
//char i;
//signed short temp_SS;

adc_self_ch_disp[0]=abs_pal(adc_self_ch_buff[1]-adc_self_ch_buff[0]);//adc_self_ch_buff[0]&0x0f80;
adc_self_ch_disp[1]=abs_pal(adc_self_ch_buff[2]-adc_self_ch_buff[1]);//adc_self_ch_buff[1]&0x0f80;
adc_self_ch_disp[2]=abs_pal(adc_self_ch_buff[2]-adc_self_ch_buff[0]);//adc_self_ch_buff[2]&0x0f80;

//adc_self_ch_disp[0]=adc_self_ch_buff[0]&0x0ff0;
//adc_self_ch_disp[1]=adc_self_ch_buff[1]&0x0ff0;
//adc_self_ch_disp[2]=adc_self_ch_buff[2]&0x0ff0;


if(adc_self_ch_disp[2]<300)//==adc_self_ch_disp[2])
	{
	adc_result=adc_self_ch_buff[2];
	} 
else if(adc_self_ch_disp[1]<300)//==adc_self_ch_disp[2])
	{
	adc_result=adc_self_ch_buff[1];
	}
else if(adc_self_ch_disp[0]<300)//==adc_self_ch_disp[1])
	{
	adc_result=adc_self_ch_buff[0];
	}
    //adc_result=92;

if(adc_ch_net)
	{

	if(adc_window_flag)
		{
		main_power_buffer[0]+=(long)(adc_result>>2);
		main_power_buffer[1]+=(long)(adc_result>>2);
		main_power_buffer[2]+=(long)(adc_result>>2);
		main_power_buffer[3]+=(long)(adc_result>>2);
		}
//	main_power_buffer[4]+=(long)(adc_result>>2);
//	main_power_buffer[5]+=(long)(adc_result>>2);
//	main_power_buffer[6]+=(long)(adc_result>>2);
//	main_power_buffer[7]+=(long)(adc_result>>2);
//	main_power_buffer_cnt++;


	if(adc_result<100)
		{
		adc_zero_cnt++;
		}
	else adc_zero_cnt=0;

	if(adc_zero_cnt>=2000)
		{
		adc_zero_cnt=2000;
		main_power_buffer[0]=0;
		main_power_buffer[1]=0;
		main_power_buffer[2]=0;
		main_power_buffer[3]=0;
		net_buff_=0;
		}

	if(adc_zero_cnt==5)
		{
		
		if(adc_window_flag)
			{
			adc_gorb_cnt++;
			if(adc_gorb_cnt>=512)
				{
				adc_gorb_cnt=0;
				//net_buff_=main_power_buffer[0]>>8;
				//main_power_buffer[0]=0;
			   	}

			if((adc_gorb_cnt&0x007f)==0)
				{
				net_buff_=main_power_buffer[adc_gorb_cnt>>7]>>8;
				main_power_buffer[adc_gorb_cnt>>7]=0;
				}
			}

		//LPC_GPIO2->FIODIR|=(1<<8);
		//LPC_GPIO2->FIOPIN^=(1<<8);

		if((adc_window_cnt>150)&&(adc_window_flag))
			{
			adc_window_flag=0;

			
			}
		if((adc_window_cnt>30)&&(adc_window_cnt<70)&&(!adc_window_flag))
			{
			adc_window_flag=1;

			//LPC_GPIO2->FIODIR|=(1<<8);
			//LPC_GPIO2->FIOPIN|=(1<<8);
			}
		}
	} 
else if(!adc_ch_net)
	{
	adc_buff[adc_ch][adc_ch_cnt]=(long)adc_result;
	
	if((adc_ch_cnt&0x03)==0)
		{
		long temp_L;
		char i;
		temp_L=0;
		for(i=0;i<16;i++)
			{
			temp_L+=adc_buff[adc_ch][i];
			}
		adc_buff_[adc_ch]= (short)(temp_L>>4);

		//adc_buff_[3]=346;
		}
	if(++adc_ch>=16) 
		{
		adc_ch=0;
		adc_ch_cnt++;
		if(adc_ch_cnt>=16)adc_ch_cnt=0;
		}
	}

//adc_buff[adc_ch][adc_cnt1]=(adc_self_ch_buff[2]+adc_self_ch_buff[1])/2;

//if(adc_buff[adc_ch][adc_cnt1]<adc_buff_min[adc_ch])adc_buff_min[adc_ch]=adc_buff[adc_ch][adc_cnt1];
//if(adc_buff[adc_ch][adc_cnt1]>adc_buff_max[adc_ch])adc_buff_max[adc_ch]=adc_buff[adc_ch][adc_cnt1];
/*
	{
	if((adc_cnt1&0x03)==0)
		{
		temp_S=0;
		for(i=0;i<16;i++)
			{
			temp_S+=adc_buff[adc_ch][i];
			} 
         	adc_buff_[adc_ch]=temp_S>>4;
          }
	}*/


		  

adc_self_ch_cnt=0;

adc_ch_net++;
adc_ch_net&=1;

//SET_REG(LPC_GPIO0->FIODIR,7,5,3);
//SET_REG(LPC_GPIO0->FIOPIN,adc_ch,5,3);

if(adc_ch_net)
	{
	//LPC_GPIO2->FIODIR|=(1<<7);
	//LPC_GPIO2->FIOPIN|=(1<<7);
	SET_REG(LPC_ADC->ADCR,1<<2,0,8);
	}
else
	{
	//LPC_GPIO2->FIODIR|=(1<<7);
	//LPC_GPIO2->FIOPIN&=~(1<<7);
	if(!(adc_ch&(1<<3)))SET_REG(LPC_ADC->ADCR,1<<0,0,8);
	else 			SET_REG(LPC_ADC->ADCR,1<<1,0,8);


	SET_REG(LPC_GPIO0->FIODIR,1,28,1);
	SET_REG(LPC_GPIO1->FIODIR,1,30,1);
	SET_REG(LPC_GPIO3->FIODIR,1,26,1);

	if(!(adc_ch&(1<<0)))SET_REG(LPC_GPIO0->FIOPIN,0,28,1);
	else 			SET_REG(LPC_GPIO0->FIOPIN,1,28,1);

	if(!(adc_ch&(1<<1)))SET_REG(LPC_GPIO1->FIOPIN,0,30,1);
	else 			SET_REG(LPC_GPIO1->FIOPIN,1,30,1);

	if(!(adc_ch&(1<<2)))SET_REG(LPC_GPIO3->FIOPIN,0,26,1);
	else 			SET_REG(LPC_GPIO3->FIOPIN,1,26,1);
	}
	



LPC_ADC->ADCR |=  (1<<24);

}
 /*
//-----------------------------------------------
void adc_drv_()
{
short temp_S;
char i;
adc_ch=4;
if(ADDR&0x00000001)
	{
	ADWR=ADDR_bit.VVDDA;
	
	if(++period_cnt>=200)
		{
		period_cnt=0;
		adc_buff[adc_ch][adc_cnt]=ADWR;
		
		if((adc_cnt&0x03)==0)
			{
			temp_S=0;
			for(i=0;i<16;i++)
				{
				temp_S+=adc_buff[adc_ch][i];
				}
			adc_buff_[adc_ch]=temp_S>>4;
			uart_out0(2,*((char*)&adc_buff_[adc_ch]),*(((char*)&adc_buff_[adc_ch])+1),0,0,0,0);

			}
		adc_cnt++;
		if(adc_cnt>=16)adc_cnt=0;
		
		}
	}

PINSEL1_bit.P0_28=1;	
PINSEL1_bit.P0_29=1;	
PINSEL1_bit.P0_30=1;	

PINSEL0_bit.P0_4=0;
PINSEL0_bit.P0_5=0;
PINSEL0_bit.P0_6=0;

IO0DIR_bit.P0_4=1;
IO0DIR_bit.P0_5=1;
IO0DIR_bit.P0_6=1;


if(adc_ch&0x02)IO0SET|=((long)1UL<<5);
else IO0CLR|=((long)1UL<<5);
if(adc_ch&0x04)IO0SET|=((long)1UL<<6);
else IO0CLR|=((long)1UL<<6);
if(adc_ch&0x08)IO0SET|=((long)1UL<<4);
else IO0CLR|=((long)1UL<<4);

ADCR_bit.PDN=1;
ADCR_bit.CLKDIV=14;
ADCR_bit.BURST=0;
ADCR_bit.CLKS=0;
ADCR_bit.TEST=0;

ADCR_bit.SEL=4;
ADCR_bit.START=1;
	

}
*/


//*************-----------------------------------------------
void rele_drv(void)
{
LPC_GPIO0->FIODIR|=(1UL<<8);

if(rele_stat)
	{
	LPC_GPIO0->FIOPIN|=(1UL<<8);
	}
else 
	{
	LPC_GPIO0->FIOPIN&=~(1UL<<8);
	}
}

//-----------------------------------------------
void bps_hndl(void)
{

}

//биты аварий в приходящих сообщениях от источников и инверторов
#define AV_OVERLOAD	0
#define AV_T	1
#define AVUMAX	3
#define AVUMIN	4


//-----------------------------------------------
void inv_drv(char in)
{


}	

//-----------------------------------------------
void ipsBlckHndl(char in)
{

ipsBlckStat=0;
if(ipsBlckSrc==1)
	{
	if(((ipsBlckLog==0)&&(adc_buff_[11]>2000)) || ((ipsBlckLog==1)&&(adc_buff_[11]<2000))) ipsBlckStat=1;
	}
else if(ipsBlckSrc==2)
	{
	if(((ipsBlckLog==0)&&(adc_buff_[13]>2000)) || ((ipsBlckLog==1)&&(adc_buff_[13]<2000))) ipsBlckStat=1;
	}
}


//-----------------------------------------------
void bat_hndl(void)
{
}

#ifdef UKU_TELECORE2015
//-----------------------------------------------
void lakb_hndl(void)
{
char i;
char temp;

//if()
temp=0;
for(i=0;i<3;i++)
	{
	if(i>=NUMBAT_TELECORE)lakb[i]._communicationFullErrorStat=0;
	else
		{
		if(lakbKanErrorStat)					lakb[i]._communicationFullErrorStat=1;
		if(lakb[i]._communication2lvlErrorStat)	lakb[i]._communicationFullErrorStat=2;
		else
			{
			 									lakb[i]._communicationFullErrorStat=0;
			temp++;
			}
		}
	}
lakbNotErrorNum=temp;





for(i=0;i<3;i++)
	{
	if((NUMBAT_TELECORE>i)&&(lakb[i]._communicationFullErrorStat==0))
		{
		signed short tempSS;
		tempSS=lakb[i]._s_o_c;
		tempSS*=10;
		tempSS/=(lakb[i]._s_o_h/10);
		gran(&tempSS,0,100);
		lakb[i]._zar_percent=tempSS;
		}
	else 
		{
		lakb[i]._zar_percent=0;
		}
	}


for(i=0;i<3;i++)
	{
	if((i>NUMBAT_TELECORE)||(lakb[i]._communicationFullErrorStat))
		{
		lakb[i]._ch_curr=0;	  
		lakb[i]._tot_bat_volt=0;
		lakb[i]._max_cell_temp=0;
		lakb[i]._s_o_c=0;
		lakb[i]._s_o_h=0;
		}
	}
}
#endif
#ifdef UKU_TELECORE2017
//-----------------------------------------------
void lakb_hndl(void)
{

}
#endif
#ifdef UKU_TELECORE2015
//-----------------------------------------------
void klimat_hndl_telecore2015(void)
{


}
#endif

#ifdef UKU_TELECORE2017
//-----------------------------------------------
void klimat_hndl_telecore2017(void)
{
//char i;
//char t_bps=20;
short delta_t;
 

if(TELECORE2017_KLIMAT_WARM_SIGNAL==0)
	{
	t_box_warm=t_ext[1];
	if(ND_EXT[1])t_box_warm=20;
	}
else if(TELECORE2017_KLIMAT_WARM_SIGNAL==1) 
	{
	t_box_warm=t_ext[0];
	if(ND_EXT[0])t_box_warm=20;
	}

if(TELECORE2017_KLIMAT_VENT_SIGNAL==0)
	{
	t_box_vent=t_ext[1];
	if(ND_EXT[1])t_box_vent=20;
	}
else if(TELECORE2017_KLIMAT_VENT_SIGNAL==1) 
	{
	t_box_vent=t_ext[0];
	if(ND_EXT[0])t_box_vent=20;
	}

TELECORE2017_KLIMAT_WARM_ON_temp=TELECORE2017_KLIMAT_WARM_ON;
if(
	(lakb_stat_comm_error)		//хотя бы у одной из литиевых батарей есть проблемы со связью 
	|| ((NUMBAT_TELECORE>0)&&(lakb[0]._zar_percent<TELECORE2017_KLIMAT_CAP)) //есть 1 батарея и ее заряд снизился ниже установленного порога
	|| ((NUMBAT_TELECORE>1)&&(lakb[1]._zar_percent<TELECORE2017_KLIMAT_CAP)) //есть 2-я батарея .....
	|| ((NUMBAT_TELECORE>2)&&(lakb[2]._zar_percent<TELECORE2017_KLIMAT_CAP)) //есть 3-я батарея	.....
  )	TELECORE2017_KLIMAT_WARM_ON_temp=0;

if(t_box_warm<TELECORE2017_KLIMAT_WARM_ON_temp) t_box_warm_on_cnt++;
else if(t_box_warm>TELECORE2017_KLIMAT_WARM_OFF) t_box_warm_on_cnt--;
gran(&t_box_warm_on_cnt,0,10);

if(t_box_warm_on_cnt>9) warm_stat_k=wsON;
else if(t_box_warm_on_cnt<1) warm_stat_k=wsOFF;


if(/*(t_box_vent>TELECORE2017_KLIMAT_VENT_ON0)&&*/(t_box_vent<TELECORE2017_KLIMAT_VENT_ON20)) 	TELECORE2017_EXT_VENT_PWM=0;
if((t_box_vent>TELECORE2017_KLIMAT_VENT_ON20)&&(t_box_vent<TELECORE2017_KLIMAT_VENT_ON40)) 	TELECORE2017_EXT_VENT_PWM=1;
if((t_box_vent>TELECORE2017_KLIMAT_VENT_ON40)&&(t_box_vent<TELECORE2017_KLIMAT_VENT_ON60)) 	TELECORE2017_EXT_VENT_PWM=2;
if((t_box_vent>TELECORE2017_KLIMAT_VENT_ON60)&&(t_box_vent<TELECORE2017_KLIMAT_VENT_ON80)) 	TELECORE2017_EXT_VENT_PWM=3;
if((t_box_vent>TELECORE2017_KLIMAT_VENT_ON80)&&(t_box_vent<TELECORE2017_KLIMAT_VENT_ON100)) TELECORE2017_EXT_VENT_PWM=4;
if((t_box_vent>TELECORE2017_KLIMAT_VENT_ON100) ) 											TELECORE2017_EXT_VENT_PWM=5;
if(warm_stat_k==wsON) TELECORE2017_EXT_VENT_PWM=0;

delta_t= abs(t_ext[0]-t_ext[1]);
if(/*(delta_t>TELECORE2017_KLIMAT_DVENT_ON0)&&*/(delta_t<TELECORE2017_KLIMAT_DVENT_ON20)) 		TELECORE2017_INT_VENT_PWM=0;
if((delta_t>TELECORE2017_KLIMAT_DVENT_ON20)&&(delta_t<TELECORE2017_KLIMAT_DVENT_ON40)) 		TELECORE2017_INT_VENT_PWM=1;
if((delta_t>TELECORE2017_KLIMAT_DVENT_ON40)&&(delta_t<TELECORE2017_KLIMAT_DVENT_ON60)) 		TELECORE2017_INT_VENT_PWM=2;
if((delta_t>TELECORE2017_KLIMAT_DVENT_ON60)&&(delta_t<TELECORE2017_KLIMAT_DVENT_ON80)) 		TELECORE2017_INT_VENT_PWM=3;
if((delta_t>TELECORE2017_KLIMAT_DVENT_ON80)&&(delta_t<TELECORE2017_KLIMAT_DVENT_ON100)) 	TELECORE2017_INT_VENT_PWM=4;
if((delta_t>TELECORE2017_KLIMAT_DVENT_ON100) ) 												TELECORE2017_INT_VENT_PWM=5;

gran_char(&TELECORE2017_EXT_VENT_PWM,0,5);
gran_char(&TELECORE2017_INT_VENT_PWM,0,5);

if(TELECORE2017_EXT_VENT_PWM)TELECORE2017_INT_VENT_PWM=TELECORE2017_EXT_VENT_PWM;

//ND_EXT[0]=0;
//ND_EXT[1]=0;

/*if((ND_EXT[0])||(ND_EXT[1]))
	{
	TELECORE2017_INT_VENT_PWM=3;
	TELECORE2017_EXT_VENT_PWM=3;
	} */


if((mess_find_unvol(MESS2KLIMAT_CNTRL))&&(mess_data[0]==PARAM_KLIMAT_CNTRL_VENT_INT))
	{
	TELECORE2017_INT_VENT_PWM=mess_data[1];
	}
/*else 
	{
	TELECORE2017_INT_VENT_PWM=0;
	}*/ 

if((mess_find_unvol(MESS2KLIMAT_CNTRL))&&(mess_data[0]==PARAM_KLIMAT_CNTRL_VENT_EXT))
	{
	TELECORE2017_EXT_VENT_PWM=mess_data[1];
	}
/*else 
	{
	TELECORE2017_EXT_VENT_PWM=0;
	}*/ 
	
if(TELECORE2017_INT_VENT_PWM||TELECORE2017_EXT_VENT_PWM) 	vent_stat_k=vsON;
else 														vent_stat_k=vsOFF;


if(t_box_warm<-20)
	{
	if(t_box_warm_minus20_cnt<60)
		{
		t_box_warm_minus20_cnt++;
		if(t_box_warm_minus20_cnt==60)
			{
			snmp_trap_send("Temperature at the bottom of box is below -20",20,1,1);
			}
		}
	}
else if(t_box_warm>-20)
	{
	if(t_box_warm_minus20_cnt>0)
		{
		t_box_warm_minus20_cnt--;
		if(t_box_warm_minus20_cnt==0)
			{
			snmp_trap_send("Temperature at the bottom of box is below -20  clear",20,1,0);
			}
		}
	} 

if(t_box_warm>65)
	{
	if(t_box_warm_plus65_cnt<60)
		{
		t_box_warm_plus65_cnt++;
		if(t_box_warm_plus65_cnt==60)
			{
			snmp_trap_send("Temperature at the bottom of box is above 65",20,2,1);
			}
		}
	}
else if(t_box_warm<65)
	{
	if(t_box_warm_plus65_cnt>0)
		{
		t_box_warm_plus65_cnt--;
		if(t_box_warm_plus65_cnt==0)
			{
			snmp_trap_send("Temperature at the bottom of box is above 65 clear",20,2,0);
			}
		}
	}
	
if(t_box_vent>70)
	{
	if(t_box_cool_plus70_cnt<60)
		{
		t_box_cool_plus70_cnt++;
		if(t_box_cool_plus70_cnt==60)
			{
			snmp_trap_send("Temperature at the top of box is above 70",20,3,1);
			}
		}
	}
else if(t_box_vent<70)
	{
	if(t_box_cool_plus70_cnt>0)
		{
		t_box_cool_plus70_cnt--;
		if(t_box_cool_plus70_cnt==0)
			{
			snmp_trap_send("Temperature at the top of box is above 70 clear",20,3,0);
			}
		}
	}	 
}

														
#endif

#ifndef UKU_KONTUR
//-----------------------------------------------
void klimat_hndl(void)
{


if(t_box>TBOXMAX)
	{
	av_tbox_cnt++;
	} 
else if(t_box<TBOXMAX)
	{
	av_tbox_cnt--;
	}
gran(&av_tbox_cnt,0,6);

if(av_tbox_cnt>5)
	{
	av_tbox_stat=atsON;
	}
if(av_tbox_cnt<1)
	{
	av_tbox_stat=atsOFF;
	}

if(t_box<(TBOXREG-2))
	{
	if(t_box_cnt<30)
		{
		t_box_cnt++;
		if(t_box_cnt>=30)
			{
			main_vent_pos--;
			t_box_cnt=0;
			}
		}
	}
else if(t_box>(TBOXREG))
	{
	if(t_box_cnt<30)
		{
		t_box_cnt++;
		if(t_box_cnt>=30)
			{
			main_vent_pos++;
			t_box_cnt=0;
			}
		}
	}
else
	{
	t_box_cnt=0;
	}

#ifndef UKU_KONTUR
if(t_box>TBOXVENTMAX)gran(&main_vent_pos,0,20); 
else gran(&main_vent_pos,0,pos_vent+9);

if((mess_find_unvol(MESS2VENT_HNDL))&&(mess_data[0]==PARAM_VENT_CB))
	{
	main_vent_pos=mess_data[1];
	}


if(main_vent_pos<=1)mixer_vent_stat=mvsON;
else mixer_vent_stat=mvsOFF;
#endif

#ifdef UKU_KONTUR

if(t_box>TBOXVENTON) t_box_vent_on_cnt++;
else if(t_box<TBOXVENTOFF) t_box_vent_on_cnt--;
gran(&t_box_vent_on_cnt,0,10);

if(t_box_vent_on_cnt>9) vent_stat_k=vsON;
else if(t_box_vent_on_cnt<1) vent_stat_k=vsOFF;

if(t_box<TBOXWARMON) t_box_warm_on_cnt++;
else if(t_box>TBOXWARMOFF) t_box_warm_on_cnt--;
gran(&t_box_warm_on_cnt,0,10);

if(t_box_warm_on_cnt>9) warm_stat_k=wsON;
else if(t_box_warm_on_cnt<1) warm_stat_k=wsOFF;

#endif

if((TBATDISABLE>=50) && (TBATDISABLE<=90))
	{
	if(t_box>TBATDISABLE)
		{
		tbatdisable_cnt++;
		}
	if(t_box<TBATENABLE)
		{
		tbatdisable_cnt--;
		}
	gran(&tbatdisable_cnt,0,6);

	if(tbatdisable_cnt>5)
		{
		tbatdisable_stat=tbdsOFF;
		}
	if(tbatdisable_cnt<1)
		{
		tbatdisable_stat=tbdsON;
		}
	}
else 
	{
	tbatdisable_stat=tbdsON;
	}

if((TLOADDISABLE>=50) && (TLOADDISABLE<=80))
	{
	if(t_box>TLOADDISABLE)
		{
		tloaddisable_cnt++;
		}
	if(t_box<TLOADENABLE)
		{
		tloaddisable_cnt--;
		}
	gran(&tloaddisable_cnt,0,6);

	if(tloaddisable_cnt>5)
		{
		tloaddisable_stat=tldsOFF;
		}
	if(tloaddisable_cnt<1)
		{
		tloaddisable_stat=tldsON;
		}
	}
else 
	{
	tloaddisable_stat=tldsON;
	}

}
#endif

#ifdef UKU_KONTUR
//-----------------------------------------------
void klimat_hndl(void)
{


if(t_box>TBOXMAX)
	{
	av_tbox_cnt++;
	} 
else if(t_box<TBOXMAX)
	{
	av_tbox_cnt--;
	}
gran(&av_tbox_cnt,0,6);

if(av_tbox_cnt>5)
	{
	av_tbox_stat=atsON;
	}
if(av_tbox_cnt<1)
	{
	av_tbox_stat=atsOFF;
	}

if(t_box<(TBOXREG-2))
	{
	if(t_box_cnt<30)
		{
		t_box_cnt++;
		if(t_box_cnt>=30)
			{
			main_vent_pos--;
			t_box_cnt=0;
			}
		}
	}
else if(t_box>(TBOXREG))
	{
	if(t_box_cnt<30)
		{
		t_box_cnt++;
		if(t_box_cnt>=30)
			{
			main_vent_pos++;
			t_box_cnt=0;
			}
		}
	}
else
	{
	t_box_cnt=0;
	}


if(t_box>TBOXVENTMAX)gran(&main_vent_pos,0,20); 
else gran(&main_vent_pos,0,pos_vent+9);

if((mess_find_unvol(MESS2VENT_HNDL))&&(mess_data[0]==PARAM_VENT_CB))
	{
	main_vent_pos=mess_data[1];
	}


if(main_vent_pos<=1)vent_stat_k=vsON;
else vent_stat_k=vsOFF;


if(t_box<TBOXWARMON) t_box_warm_on_cnt++;
else if(t_box>TBOXWARMOFF) t_box_warm_on_cnt--;
gran(&t_box_warm_on_cnt,0,10);

if(t_box_warm_on_cnt>9) warm_stat_k=wsON;
else if(t_box_warm_on_cnt<1) warm_stat_k=wsOFF;



if((TBATDISABLE>=50) && (TBATDISABLE<=90))
	{


	if(t_box>TBATDISABLE)
		{
		tbatdisable_cnt++;
		}
	if(t_box<TBATENABLE)
		{
		tbatdisable_cnt--;
		}
	gran(&tbatdisable_cnt,0,6);

	if(tbatdisable_cnt>5)
		{
		tbatdisable_stat=tbdsOFF;
		}
	if(tbatdisable_cnt<1)
		{
		tbatdisable_stat=tbdsON;
		}
	}
else 
	{
	tbatdisable_stat=tbdsON;
	}

if((TLOADDISABLE>=50) && (TLOADDISABLE<=80))
	{
	if(t_box>TLOADDISABLE)
		{
		tloaddisable_cnt++;
		}
	if(t_box<TLOADENABLE)
		{
		tloaddisable_cnt--;
		}
	gran(&tloaddisable_cnt,0,6);

	if(tloaddisable_cnt>5)
		{
		tloaddisable_stat=tldsOFF;
		}
	if(tloaddisable_cnt<1)
		{
		tloaddisable_stat=tldsON;
		}
	}
else 
	{
	tloaddisable_stat=tldsON;
	}

}
#endif








//-----------------------------------------------
void ext_drv(void)
{
//char i;
}


//-----------------------------------------------
void zar_superviser_drv(void)
{


}

//-----------------------------------------------
void zar_superviser_start(void)
{
sign_U[0]=1;
sign_I[0]=1;
sign_U[1]=1;
sign_I[1]=1;

}

//-----------------------------------------------
void npn_hndl(void)
{
}

//-----------------------------------------------
void speedChargeHndl(void)
{


}

//-----------------------------------------------
void speedChargeStartStop(void)
{

}


//-----------------------------------------------
void	numOfForvardBps_init(void)			//Программа сброса системы смены первого источника для равномерного износа БПСов
{									//Должна вызываться при изменении кол-ва источников в структуре

}


//-----------------------------------------------
void vent_resurs_hndl(void)
{

}

//-----------------------------------------------
void vent_hndl(void)
{

}


