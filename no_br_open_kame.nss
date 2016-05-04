#include "ku_libtime"
#include "ku_persist_inc"

object no_oPC;
int no_menu;
void main()


/////////////////////////
//no_menu:
//1 - brouseni               tag:no_brouseni
//2 - lesteni                tag:no_lesteni
//0 - zpet na start          tag:no_zpet
//
//////////////////////////
{
no_oPC=GetLastDisturbed();


//doplnena perzistence 5.5.2014
/*if  (GetLocalInt(OBJECT_SELF,"no_prvni_otevreni")==0)   {
      SetLocalInt(OBJECT_SELF,"no_prvni_otevreni",1);
      Persist_OnContainerOpen(OBJECT_SELF, no_oPC);             }*/
///////////////////////////////


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

SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_brouseni"),"Brouseni kamenu ");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_lesteni"),"Lesteni kamenu");
} else
  if(no_menu == 1)
  {
FloatingTextStringOnCreature(" Brouseni ",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}  else
  if(no_menu == 2)
  {
FloatingTextStringOnCreature(" Lesteni ",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
};



}
