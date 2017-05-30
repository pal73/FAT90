#include "ds1307.h"
#include "i2c.h"

//-----------------------------------------------
void _ds1307_write_byte(char adr,char data)
{
i2c_Start();
i2c_SendByte(0xd0);
if(i2c_ReadAcknowledge()) goto Stop_label_ds1307_write_byte;
i2c_SendByte(adr);
if(i2c_ReadAcknowledge()) goto Stop_label_ds1307_write_byte;
i2c_SendByte(data);
i2c_ReadAcknowledge();
Stop_label_ds1307_write_byte: 
i2c_Stop();
}

//-----------------------------------------------
void _ds1307_read_time(char *buff)
{
char i;

i2c_Start();
i2c_SendByte(0xd0);
if(i2c_ReadAcknowledge()) goto Stop_label_ds1307_read_time;
i2c_SendByte(0x00);
if(i2c_ReadAcknowledge()) goto Stop_label_ds1307_read_time;
i2c_Restart();
i2c_SendByte(0xd1);
if(i2c_ReadAcknowledge()) goto Stop_label_ds1307_read_time;
for(i=0;i<7;i++)
	{
	buff[i]=i2c_ReadByte();
	i2c_SendAcknowledge(1);
	}
buff[7]=i2c_ReadByte();
i2c_SendAcknowledge(0);
Stop_label_ds1307_read_time: 
i2c_Stop();

}

/*----------------------------------------------------------------------------
 * end of file
 *---------------------------------------------------------------------------*/