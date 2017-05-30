#include "stm8s.h"

#define SDA_INIT() 	GPIOE->DDR|=(1<<2);GPIOE->CR1&=~(1<<2);GPIOE->CR2&=~(1<<2);GPIOE->ODR|=(1<<2);
#define SCL_INIT() 	GPIOE->DDR|=(1<<1);GPIOE->CR1&=~(1<<1);GPIOE->CR2&=~(1<<1);GPIOE->ODR|=(1<<1);

#define SCL_HIGH() 	GPIOE->ODR|=(1<<1);
#define SCL_LOW()  	GPIOE->ODR&=~(1<<1);
#define SCL_PIN 	(GPIOE->IDR)&(1<<1)

#define SDA_HIGH() 	GPIOE->ODR|=(1<<2);
#define SDA_LOW()  	GPIOE->ODR&=~(1<<2);
#define SDA_PIN 	(GPIOE->IDR)&(1<<2) 

//-----------------------------------------------
void i2c_init(void);
//-----------------------------------------------
void i2c_Start(void);
//-----------------------------------------------
void i2c_Restart(void);
//-----------------------------------------------
signed char i2c_ReadAcknowledge(void);
//-----------------------------------------------
char i2c_ReadByte(void);
//-----------------------------------------------
void i2c_SendAcknowledge(unsigned char status);
//-----------------------------------------------
unsigned char i2c_SendByte(unsigned char byte);
//-----------------------------------------------
void i2c_Stop(void);
