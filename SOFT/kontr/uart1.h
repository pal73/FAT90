//-----------------------------------------------
#define RX_BUFFER_1_SIZE	128
#define TX_BUFFER_1_SIZE	128
extern @near char rxBuffer1[RX_BUFFER_1_SIZE];			//Приемный буфер UART1
extern @near char txBuffer1[TX_BUFFER_1_SIZE];			//Передающий буфер UART1
extern @near short rx_wr_index1;						//Указатель на следующий принимаемый байт
extern @near short tx_wr_index1;						//Указатель на следующую ячейку передающего ФИФО
extern @near short tx_rd_index1;						//Указатель на следующий отправляемый из ФИФО байт
extern @near short tx_counter1;							//Счетчик заполненности передающего ФИФО
extern @near char uart1_an_buffer[100];					//Буфер для анализа принятых по UART1 строк
extern @near char bRXIN1;								//Индикатор принятой строки в uart3_an_buffer



//-----------------------------------------------
//Отладка
extern char uart1_plazma;

//-----------------------------------------------
void uart1_init (void);
//-----------------------------------------------
@far @interrupt void UART1RxInterrupt (void);
//-----------------------------------------------
@far @interrupt void UART1TxInterrupt (void);
//-----------------------------------------------
void uart1_in_an (void);