#include <iostm8s.h>
#include "watchdog.h"

//-----------------------------------------------
void watchdog_enable(void)
{
IWDG_KR=KEY_ENABLE;
IWDG_KR=KEY_ACCESS;
IWDG_PR=6;
IWDG_RLR=250;

}

//-----------------------------------------------
void watchdog_reset(void)
{
IWDG_KR=KEY_REFRESH;
}
