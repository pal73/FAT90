//-----------------------------------------------
#define RX_BUFFER_3_SIZE	64
extern @near char rxBuffer3[RX_BUFFER_3_SIZE];		//Приемный буфер UART3
extern @near short rx_wr_index3;						//Указатель на следующий принимаемый байт
extern @near char uart3_an_buffer[100];				//Буфер для анализа принятых по UART3 строк
extern @near char bRXIN3;								//Индикатор принятой строки в uart3_an_buffer



//-----------------------------------------------
//Отладка
extern char uart3_plazma;

//-----------------------------------------------
void uart3_init (void);
//-----------------------------------------------
@far @interrupt void UART3RxInterrupt (void);
//-----------------------------------------------
void uart3_in_an (void);