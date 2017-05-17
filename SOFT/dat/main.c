#include "stm8s.h"
#include <iostm8s103.h>

//-----------------------------------------------
void t4_init(void)
{
TIM4->PSCR = 3;
TIM4->ARR= 158;
TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt

TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{

	GPIOC->DDR|=(1<<6);
	GPIOC->CR1|=(1<<6);
	GPIOC->CR2|=(1<<6);	
	GPIOC->ODR^=(1<<6);


	TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
	return;
}

//***********************************************
@far @interrupt void UARTTxInterrupt (void) 
{

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
GPIOC->DDR|=(1<<6);
GPIOC->CR1|=(1<<6);
GPIOC->CR2|=(1<<6);

t4_init();

enableInterrupts();
while (1)
	{

	};
	
}