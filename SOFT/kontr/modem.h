
extern char modemStatCnt0;

extern signed char modemPowerStatCnt;			//������� ������������ ���������� ������� ������

typedef enum {MPS_POWEROFF, MPS_POWERON}enum_modemPowerState;
extern enum_modemPowerState modemPowerState;	//��������� ������� ������

extern signed char net_l_cnt_up,net_l_cnt_down;			//�������� ������������ ���������� �����
extern short net_l_cnt_one, net_l_cnt_zero, net_l_cnt_one_temp; 	//�������� �������� ���������� �����
typedef enum {MLS_UNKNOWN, MLS_UNLINKED, MLS_LINKED, MLS_GPRS}enum_modemLinkState;
extern enum_modemLinkState modemLinkState;		//��������� ����������� � ���������� ������
typedef enum {MS_UNKNOWN, MS_POWEROFF, MS_UNLINKED, MS_LINKED, MS_GPRS, MS_LINKED_INITIALIZED}enum_modemState;
extern enum_modemState modemState;				//��������� ������

extern signed char modemDrvPowerStartCnt;						//������� 100��-���������� �� ��������� ������� 
extern signed short modemDrvInitStepCnt;						//������� 100��-����� ������������� ������
extern signed short modemDrvSMSSendStepCnt;					//������� 100��-����� �������� ���
extern char *phoneNumberForSMS;											//��������� �� ������ � ������� �������� ��������� ���
extern char *textSMS;																//��������� �� ������ � ������� SMS
extern @near char textToSendSMS[200];													//��������� �� ������ � ������� SMS
extern @near char numberToSendSMS[20];												//��������� �� ������ � ������� �������� ��������� ���



/*
041E0422041F042004100412042C04220415002000370020042604180424042000200412042B0412041504140415041D041D042B04250020041D041000200418041D04140418041A04100422041E042000200423042104220420041E04190421042204120410002000280411041504170020041F0420041E04110415041B041E04120029

��������� 7 ���� ���������� �� ��������� ���������� (��� ��������)
*/

//-----------------------------------------------
void modem_gpio_init(void);
//-----------------------------------------------
//������ �������� ��������� ������
void modem_stat_drv(void);
//-----------------------------------------------
void modem_drv(void);
//-----------------------------------------------
void modem_send_sms(char mode, char *number, char *text);