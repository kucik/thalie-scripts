#include "ku_libtime"
#include "ku_persist_inc"

object no_oPC;
int no_menu;
void main()


/////////////////////////
//no_menu:
//1 - sekani               tag:no_sekani
//2 - deska                tag:no_vyr_deska
//3 - lat                  tag:no_vyr_lat
//4 - nasada               tag:no_vyr_nasada
//0 - zpet na start        tag:no_zpet
//
//////////////////////////
{
no_oPC=GetLastDisturbed();


// budto horime od zacatku, nebo to znovu nastavi cas horeni od ted na 5minut

/////////////////////////////////////////////////////////////////////////////////
/////zjistime zda ted otvira stejne pc jako minule, jestli ne, nastavime menu na zacatek
no_oPC = GetLastOpenedBy();
if  (GetLocalObject(OBJECT_SELF,"no_lastopened") == no_oPC  ) {
no_oPC = GetLastOpenedBy();
SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",GetLocalInt(OBJECT_SELF,"no_MULTIKLIK")+1);}
else {      // neni to stejne, takze menu na start
SetLocalObject(OBJECT_SELF,"no_lastopened",no_oPC);
SetLocalInt(OBJECT_SELF,"no_menu",0);        }

/////////////////////////////////////////////////////////////////////////////////
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
if(no_menu == 0)   // zacatek menu
  {

SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_sekani"),"Sekani dreva ");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_deska"),"Vyroba desek");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lat"),"Vyroba lati");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_nasada"),"Vyroba rukojeti");
} else
  if(no_menu == 1)
  {
FloatingTextStringOnCreature(" Sekani dreva ",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}  else
  if(no_menu == 2)
  {
FloatingTextStringOnCreature(" Vyroba desek ",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
} else
  if(no_menu == 3)
  {
FloatingTextStringOnCreature(" Vyroba lati ",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
} else
  if(no_menu == 4)
  {
FloatingTextStringOnCreature(" Vyroba rukojeti ",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
};



}
