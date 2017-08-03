//-----------------------------------------------
#define RX_BUFFER_1_SIZE	256
#define TX_BUFFER_1_SIZE	350
extern @near char rxBuffer1[RX_BUFFER_1_SIZE];			//Приемный буфер UART1
extern @near char txBuffer1[TX_BUFFER_1_SIZE];			//Передающий буфер UART1
extern @near short rx_wr_index1;										//Указатель на следующий принимаемый байт
extern @near short tx_wr_index1;										//Указатель на следующую ячейку передающего ФИФО
extern @near short tx_rd_index1;										//Указатель на следующий отправляемый из ФИФО байт
extern @near short tx_counter1;											//Счетчик заполненности передающего ФИФО
extern @near char uart1_an_buffer[200];							//Буфер для анализа принятых по UART1 строк
extern @near char bRXIN1;														//Индикатор принятой строки в uart1_an_buffer
extern @near char incommingNumber[10];							//Буфер для хранения номера отправителя пришедшей смс
extern @near char incommingNumberToMain[10];				//Буфер для хранения номера просящегося в главные

extern bool bOK;											//Модем ответил "OK"
extern bool bERROR;											//Модем ответил "ERROR"
extern bool bINITIALIZED;									//Модем инициализирован
//-----------------------------------------------
//Отладка
extern @near char uart1_plazma;
extern @near char modem_plazma;
extern @near char modem_plazma1;

//-----------------------------------------------
void uart1_init (void);
//-----------------------------------------------
@far @interrupt void UART1RxInterrupt (void);
//-----------------------------------------------
@far @interrupt void UART1TxInterrupt (void);
//-----------------------------------------------
void uart1_in_an (void);