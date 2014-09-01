#include "ku_klevety_inc"

void main()
{
 int irand = GetLocalInt(OBJECT_SELF,"KLEV_RAND");
 if(Random(irand) == 0) {
   ku_klevety_init();
   ku_klevety_shout();
 }
 return ;


}
