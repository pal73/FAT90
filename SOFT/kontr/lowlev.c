#include "stm8s.h"
#include "main.h"
#include "lowlev.h"
#include <stdlib.h>

//-----------------------------------------------
//Обработка кнопок
char but_new;
char but_n, but_s, but;
char l_but, n_but;
short but0_cnt, but1_cnt;
char speed;
short but_onL_temp;
/*
//-----------------------------------------------
//Состояние питающего напряжения
enum_power_stat power_stat=psOFF,power_stat_old=psOFF;
char power_stat_cnt;*/

//-----------------------------------------------
//Самовозврат меню
char retCnt;
char retStep;

//-----------------------------------------------
void out_drv(void)
{
GPIOE->DDR|=0b00101001;
GPIOE->CR1&=0b11010110;
GPIOE->CR2&=0b11010110;

if(out_mode==osOFF)
	{
	GPIOE->ODR|=0b00101001;
	}
else
	{
	if(out_stat[0]==osON)		GPIOE->ODR&=0b11111110;
	else 						GPIOE->ODR|=0b00000001;
	if(out_stat[1]==osON)		GPIOE->ODR&=0b11110111;
	else 						GPIOE->ODR|=0b00001000;
	if(out_stat[2]==osON)		GPIOE->ODR&=0b11011111;
	else 						GPIOE->ODR|=0b00100000;
	}
}
/*
//-----------------------------------------------
void power_stat_drv(void)
{
GPIOA->DDR&=(1<<6);				//PA6 вход
GPIOA->CR1&=(1<<6);				//без подтяжки
GPIOA->CR2&=(1<<6);				//и без прерывания

if(GPIOA->IDR&0b01000000)
	{
	if(power_stat_cnt<50)
		{
		power_stat_cnt++;
		if(power_stat_cnt==50)
			{
			power_stat=psON;
			}
		}
	}
else
	{
	if(power_stat_cnt)
		{
		power_stat_cnt--;
		if(power_stat_cnt==0)
			{
			power_stat=psOFF;
			}
		}
	}
if(power_stat!=power_stat_old)
	{
	//TODO прописать обработку включени и выключения питания
	}
	
power_stat_old=power_stat;
}*/

//-----------------------------------------------
void delay_us(short num_of_delay)
{
short i;
for(i==0;i<num_of_delay;i++)
	{
	nop();
	}
}

//-----------------------------------------------
void but_drv(void)
{

but_n=(but_new)|0xf0; 	
if((but_n==0xff)||(but_n!=but_s))
 	{
 	speed=0;
 
	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
		{
   	n_but=1;
    but=(char)but_s;
    }
 	if (but1_cnt>=but_onL_temp)
 		{
    n_but=1;
		but=((char)but_s)&0x7f;
    }
	l_but=0;
	but_onL_temp=BUT_ONL;
	but0_cnt=0;
	but1_cnt=0;          
	goto but_drv_out;
  }
if(but_n==but_s)
 	{
  but0_cnt++;
	if(but0_cnt>=BUT_ON)
		{
		but0_cnt=0;
		but1_cnt++;
		if(but1_cnt>=but_onL_temp)
			{              
			but=(char)(but_s&0x7f);
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
void clear_ind(void)
{
char i;
for(i=0;i<4;i++)
	{
	ind_outB[i]=0xff;
	ind_outC[i]=0xff;
	ind_outG[i]=0xff;
	}
}

//-----------------------------------------------
void tree_down(signed char offset_ind,signed char offset_sub_ind)
{
ind_pointer--;
ind_pointer+=offset_ind;
a_ind=b_ind[ind_pointer];

sub_ind+=offset_sub_ind;
clear_ind();
ind_hndl();
}

//-----------------------------------------------
void tree_up(char tind, char tsub_ind, char tindex_set, char tsub_ind1)
{
b_ind[ind_pointer++]=a_ind;
ind=(ind_enum)tind;
sub_ind=tsub_ind;
index_set=tindex_set;
sub_ind1=tsub_ind1;
clear_ind();
ind_hndl();
}

//-----------------------------------------------
void gran_char(signed char *adr, signed char min, signed char max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void gran_uchar(unsigned char *adr, unsigned char min, unsigned char max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void gran_ring_char(signed char *adr, signed char min, signed char max)
{
if (*adr<min) *adr=max;
if (*adr>max) *adr=min; 
} 

//-----------------------------------------------
void bin2bcd_int(unsigned short in) 
{
char i=5;

for(i=0;i<5;i++)
	{
	dig[i]=in%10;
	in/=10;
	}
}

//-----------------------------------------------
void bcd2ind(void) 
{
char i;

for (i=4;i>0;i--)
	{
	ind_out_[i-1]=DIGISYM[dig[i-1]];
	}
}

//-----------------------------------------------
void bcd2ind_zero(void) 
{
char i;
zero_on=1;
for (i=4;i>0;i--)
	{
	if(zero_on&&(!dig[i-1])&&(i-1))
		{
		ind_out_[i-1]=0b11111111;
		}
	else
		{
		ind_out_[i-1]=DIGISYM[dig[i-1]];
		zero_on=0;
		}
	}
}

//-----------------------------------------------
void int2indI_slkuf(unsigned short in, char start, char len, char komma, char unzero, char fl) 
{
char i;

bin2bcd_int(in);
if(unzero)bcd2ind_zero();
else bcd2ind();
if(komma)ind_out_[komma]&=0b01111111; 
if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
	{
	for(i=0;i<len;i++) 
		{
		ind_out_[i]=DIGISYM[17];
		}
	}

for(i=0;i<len;i++) 
	{
	ind_outB[start+i]=ind_out_[i];
	}
}

//-----------------------------------------------
void int2indII_slkuf(unsigned short in, char start, char len, char komma, char unzero, char fl) 
{
char i;

bin2bcd_int(in);
if(unzero)bcd2ind_zero();
else bcd2ind();
if(komma)ind_out_[komma]&=0b01111111; 
if(((fl==1)&&(bFL2)) || ((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
	{
	for(i=0;i<len;i++) 
		{
		ind_out_[i]=DIGISYM[17];
		}
	}

for(i=0;i<len;i++) 
	{
	ind_outC[start+i]=(ind_out_[i]<<1);
	ind_outG[start+i]=0xff;
	if(!(ind_out_[i]&0x80)) ind_outG[start+i]&=0xfe;
	}
}

//-----------------------------------------------
void ret_ind(char r_c, char r_s)
{
retCnt=r_c;
retStep=r_s;
} 

//-----------------------------------------------
void ret_ind_hndl(void)
{
if(retCnt)
 	{
	if((--retCnt)==0)
	 	{
		tree_down(retStep,0);
		}
   	}		
}

//-----------------------------------------------
void led_set(signed char led_num, signed char led_stat)
{
gran_char(&led_num,1,8);
gran_char(&led_stat,0,2);

if(led_stat==0)
	{
	led_ind_out1|=(1<<(led_num-1));	
	led_ind_out2|=(1<<(led_num-1));		
	}
else if(led_stat==1)
	{
	led_ind_out1&=~(1<<(led_num-1));	
	led_ind_out2&=~(1<<(led_num-1));
	}
else if(led_stat==2)
	{
	led_ind_out1&=~(1<<(led_num-1));	
	led_ind_out2|=(1<<(led_num-1));	
	}
}

//-----------------------------------------------
void led_mask_off(signed char led_mask)
{
led_ind_out1|=~led_mask;	
led_ind_out2|=~led_mask;
}

//-----------------------------------------------
void led_mask_on(signed char led_mask)
{
led_ind_out1&=~led_mask;	
led_ind_out2&=~led_mask;
}

//-----------------------------------------------
void led_off(signed char led_num)
{
led_ind_out1|=(1<<(led_num-1));	
led_ind_out2|=(1<<(led_num-1));
}

//-----------------------------------------------
void led_on(signed char led_num)
{
led_ind_out1&=~(1<<(led_num-1));	
led_ind_out2&=~(1<<(led_num-1));
}

//-----------------------------------------------
void led_flash(signed char led_num)
{
led_ind_out1&=~(1<<(led_num-1));	
led_ind_out2|=(1<<(led_num-1));
}

//-----------------------------------------------
void random_gen(void)
{
currRandom=rand()%6;		
}
