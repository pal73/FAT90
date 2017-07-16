//-----------------------------------------------
#define RX_BUFFER_1_SIZE	128
#define TX_BUFFER_1_SIZE	128
extern @near char rxBuffer1[RX_BUFFER_1_SIZE];			//�������� ����� UART1
extern @near char txBuffer1[TX_BUFFER_1_SIZE];			//���������� ����� UART1
extern @near short rx_wr_index1;						//��������� �� ��������� ����������� ����
extern @near short tx_wr_index1;						//��������� �� ��������� ������ ����������� ����
extern @near short tx_rd_index1;						//��������� �� ��������� ������������ �� ���� ����
extern @near short tx_counter1;							//������� ������������� ����������� ����
extern @near char uart1_an_buffer[100];					//����� ��� ������� �������� �� UART1 �����
extern @near char bRXIN1;								//��������� �������� ������ � uart3_an_buffer



//-----------------------------------------------
//�������
extern char uart1_plazma;

//-----------------------------------------------
void uart1_init (void);
//-----------------------------------------------
@far @interrupt void UART1RxInterrupt (void);
//-----------------------------------------------
@far @interrupt void UART1TxInterrupt (void);
//-----------------------------------------------
void uart1_in_an (void);