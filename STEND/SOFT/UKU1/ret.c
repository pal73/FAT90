#include "global_define.h"
#include "main.h"
#include "ret.h"
#include "common_func.h"

char ret_step,retsub,retindsec;
int retcnt,retcntsec;
unsigned char f0,fc0,f1,fc1;
short ret_duty;


//-----------------------------------------------
void ret_ind(char r_c,char r_s)
{
retcnt=r_c;
ret_step=r_s;
//retsub=r_s;
}    

//-----------------------------------------------
void ret_ind_hndl(void)
{
if(retcnt)
	{
	if((--retcnt)==0)
		{
		tree_down(ret_step,0);
        }
    }
}  


 
//---------------------------------------------
void ret_ind_sec(char r_i,int r_c)
{
retcntsec=r_c;
retindsec=r_i;
}

//-----------------------------------------------
void ret_ind_sec_hndl(void)
{
if(retcntsec)
 	{
	if((--retcntsec)==0)
	 	{
 		ind=(i_enum)retindsec;
 		sub_ind=0;
  		f0=0;
   		fc0=0;
   		f1=0;
   		fc1=0; 		
	 	}
   	}		
}

//-----------------------------------------------
void ret(short duty)
{
ret_duty=duty;
}

//-----------------------------------------------
void ret_hndl(void)
{
if(ret_duty)
     {
     ret_duty--;
     if(!ret_duty)
          {
          tree_down(0,0);
          }
     }
}


    
 
       

