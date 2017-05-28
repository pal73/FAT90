#include "stm8s.h"
#include <iostm8s103.h>
#include "main.h"
#include <stdio.h>
#include <string.h>
#include <stdio.h>


@near bool b100Hz=0,b10Hz=0,b5Hz=0,b1Hz=0;
@near static char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0;

@near bool bCONV;
@near ibatton_in[9];
char buf[100];
char* out_string;
char* out_string1;
char* out_string2;

//char* buf;
//-----------------------------------------------
void t4_init(void)
{
TIM4->PSCR = 3;
TIM4->ARR= 158;
TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt

TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//-----------------------------------------------
char ibatton_w1ts(void)
{
short i,ii,num_out;
GPIOC->DDR|=(1<<7);
GPIOC->ODR&=~(1<<7);

//импульс 10мкс
for(i=0;i<10;i++)
	{
	__nop();
	}
GPIOC->ODR|=(1<<7);

//выдержка 90мкс
for(i=0;i<90;i++)
	{
	__nop();
	}
}

//-----------------------------------------------
char ibatton_w0ts(void)
{
short i,ii,num_out;
GPIOC->DDR|=(1<<7);
GPIOC->ODR&=~(1<<7);

//импульс 90мкс
for(i=0;i<90;i++)
	{
	__nop();
	}
GPIOC->ODR|=(1<<7);

//выдержка 10мкс
for(i=0;i<10;i++)
	{
	__nop();
	}
}

//-----------------------------------------------
void ibatton_send_byte(char in)
{
char i,ii;
ii=in;

for(i=0;i<8;i++)
	{
	if(ii&0x01)ibatton_w1ts();
	else ibatton_w0ts();
	ii>>=1;
	}
}

//-----------------------------------------------
char ibatton_read_byte(void)
{
char i,ii;
ii=0;

for(i=0;i<8;i++)
	{
	ii>>=1;
	if(ibatton_rts())ii|=0x80;
	else ii&=0x7f;
	}
return ii;
}

//-----------------------------------------------
char ibatton_rts(void)
{
short i,ii,num_out;

GPIOC->DDR|=(1<<7);
GPIOC->ODR&=~(1<<7);

//импульс 10мкс
for(i=0;i<2;i++)
	{
	__nop();
	}

GPIOC->ODR|=(1<<7);
//импульс 20мкс
for(i=0;i<10;i++)
	{
	__nop();
	}
if(GPIOC->IDR&(1<<7))	ii=1;
else ii=0;

//выдержка 30мкс
for(i=0;i<50;i++)
	{
	__nop();
	}
return ii;
}
//-----------------------------------------------
char ibatton_polling(void)
{
short i,ii,num_out;
GPIOC->CR1&=~(1<<7);
GPIOC->CR2&=~(1<<7);
GPIOC->DDR|=(1<<7);


GPIOC->ODR&=~(1<<7);

//импульс сброса 600мкс
for(i=0;i<600;i++)
	{
	__nop();
	}
GPIOC->ODR|=(1<<7);

//выдержка 15мкс
for(i=0;i<15;i++)
	{
	__nop();
	}

//еще 45мкс ждем сигнала от таблетки
for(i=0;i<20;i++)
	{
	__nop();
	__nop();
	__nop();
	if(!(GPIOC->IDR&(1<<7)))goto ibatton_polling_lbl_000;
	}
goto ibatton_polling_lbl_zero_exit;

ibatton_polling_lbl_000:

//измер€ем длительность ответного импульса не дольше 300мкс
for(i=0;i<220;i++)
	{
	if(GPIOC->IDR&(1<<7))
		{
		__nop();
		__nop();
		num_out=10;
		goto ibatton_polling_lbl_001;	//continue;
		}
	}
num_out=5;
goto ibatton_polling_lbl_zero_exit;

ibatton_polling_lbl_001:
//выдержка 15мкс
for(i=0;i<30;i++)
	{
	__nop();
	}
ibatton_polling_lbl_success_exit:
return 1;
ibatton_polling_lbl_zero_exit:
return 0;
}

//-----------------------------------------------
void uart_init (void){
	UART1->CR1&=~UART1_CR1_M;					
	UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
	UART1->BRR2= 0x01;//0x03;
	UART1->BRR1= 0x1a;//0x68;
	UART1->CR2|= UART1_CR2_TEN /*| UART3_CR2_REN | UART3_CR2_RIEN*/;	
}

//-----------------------------------------------
void putchar(char c)
{
while (tx_counter == TX_BUFFER_SIZE);
///#asm("cli")
if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
   {
   tx_buffer[tx_wr_index]=c;
   if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
   ++tx_counter;
   }
else UART1->DR=c;

UART1->CR2|= UART1_CR2_TIEN;
///#asm("sei")
}

//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{
if(++t0_cnt0>=125)
	{
  t0_cnt0=0;
  b100Hz=1;

	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;
		}
		
	if(++t0_cnt3>=100)
		{
		t0_cnt3=0;
		b1Hz=1;
		}
	}
TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
return;
}

//***********************************************
@far @interrupt void UARTTxInterrupt (void) 
{
if (tx_counter)
	{
	--tx_counter;
	UART1->DR=tx_buffer[tx_rd_index];
	if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	}
else 
	{
	//bOUT_FREE=1;
	UART1->CR2&= ~UART1_CR2_TIEN;
	}
#endif	
}
}

//***********************************************
@far @interrupt void UARTRxInterrupt (void) 
{

}

//===============================================
//===============================================
//===============================================
//===============================================
main()
{
CLK->CKDIVR=0;

GPIOC->DDR|=(1<<6);
GPIOC->CR1|=(1<<6);
GPIOC->CR2|=(1<<6);

t4_init();

enableInterrupts();

/*			if(ibatton_polling())
				{
				ibatton_send_byte(0xCC);
				ibatton_send_byte(0x44);
				}*/
while (1)
	{
	if(b100Hz)
		{
		b100Hz=0;
		
		//GPIOC->DDR|=(1<<7);
		//GPIOC->CR1|=(1<<7);
		//GPIOC->CR2|=(1<<7);	
		//GPIOC->ODR^=(1<<7);
		}  
      	
	if(b10Hz)
		{
		b10Hz=0;
/*   	if(ibatton_polling())
			{
			ibatton_send_byte(0x44);
			}*/
		}
      	 
	if(b5Hz)
		{
		b5Hz=0;
		

			
		}
      	      	
	if(b1Hz)
		{
		b1Hz=0;
		if(!bCONV)
			{
			bCONV=1;
			if(ibatton_polling())
				{
				ibatton_send_byte(0xCC);
				ibatton_send_byte(0x44);
				}			
			}
		else 
			{
			bCONV=0;
			if(ibatton_polling())
				{
				ibatton_send_byte(0xCC);
				ibatton_send_byte(0xBE);
				ibatton_in[0]=ibatton_read_byte();
				ibatton_in[1]=ibatton_read_byte();
				ibatton_in[2]=ibatton_read_byte();
				ibatton_in[3]=ibatton_read_byte();
				ibatton_in[4]=ibatton_read_byte();
				ibatton_in[5]=ibatton_read_byte();
				ibatton_in[6]=ibatton_read_byte();
				ibatton_in[7]=ibatton_read_byte();
				ibatton_in[8]=ibatton_read_byte();
				}			
			}

/*		out_string="temper=";
		buf[0] = '0';
		buf[1] = '\r';
		buf[2] = '\n';
		strcpy(buf, "first string");
		//strcpy(buf, "string");
		strcpy(out_string1, "abcdef");
		strcpy(buf, out_string);
		printf(buf);
		//strcat(buf, У, second stringФ);
		//sprintf(out_string1,out_string);*/ 
		printf("mama");
		}     	     	      
	};
	
}