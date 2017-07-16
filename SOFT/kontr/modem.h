
extern char modemStatCnt0;

extern signed char modemPowerStatCnt;			//������� ������������ ���������� ������� ������

typedef enum {MPS_POWEROFF, MPS_POWERON}enum_modemPowerState;
extern enum_modemPowerState modemPowerState;	//��������� ������� ������

extern signed char net_l_cnt_up,net_l_cnt_down;			//�������� ������������ ���������� �����
extern short net_l_cnt_one, net_l_cnt_zero, net_l_cnt_one_temp; 	//�������� �������� ���������� �����
typedef enum {MLS_UNKNOWN, MLS_UNLINKED, MLS_LINKED, MLS_GPRS}enum_modemLinkState;
extern enum_modemLinkState modemLinkState;		//��������� ����������� � ���������� ������
typedef enum {MS_UNKNOWN, MS_POWEROFF, MS_UNLINKED, MS_LINKED, MS_GPRS}enum_modemState;
extern enum_modemState modemState;				//��������� ������

//-----------------------------------------------
void modem_gpio_init(void);
//-----------------------------------------------
//������ �������� ��������� ������
void modem_stat_drv(void);
