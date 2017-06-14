
extern char wire1_in[10];			//—читывание данных, буфер 1wire
extern char ds18b20ErrorHiCnt; 		//—четчик ошибок по замыканию линии в "+" (или отсутствию датчика)
extern char ds18b20ErrorLoCnt;		//—четчик ошибок по замыканию линии в "-" 
extern char ds18b20ErrorOffCnt;		//—четчик нормальных ответов датчика
typedef enum {dsesNORM=0x55,dsesHI=1,dsesLO=0} enumDsErrorStat; 
extern enumDsErrorStat waterSensorErrorStat;


//

//-----------------------------------------------
void ds18b20_temper_drv(void);
//-----------------------------------------------
char wire1_w1ts(void);
//-----------------------------------------------
char wire1_w0ts(void);
//-----------------------------------------------
void wire1_send_byte(char in);
//-----------------------------------------------
char wire1_read_byte(void);
//-----------------------------------------------
char wire1_rts(void);
//-----------------------------------------------
char wire1_polling(void);