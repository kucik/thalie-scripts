//#include "ku_libtime"
//#include "ku_persist_inc"
#include "tc_functions"

object no_oPC;
int no_menu;
void main()


/////////////////////////
//no_menu:
//1 - cistit                 tag:no_cistit
//2 - legovat                tag:no_legovat
//3 - slevat slitiny         tag:no_slevat
//0 - zpet na start          tag:no_zpet
//
//////////////////////////
{
no_oPC=GetLastDisturbed();

//doplnena perzistence 5.5.2014
/*if  (GetLocalInt(OBJECT_SELF,"no_prvni_otevreni")==0)   {
      SetLocalInt(OBJECT_SELF,"no_prvni_otevreni",1);
//      Persist_OnContainerOpen(OBJECT_SELF, no_oPC);
}  */
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
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature(" Pec uhasina, chtelo by to vice uhli ",no_oPC,FALSE );

else  FloatingTextStringOnCreature(" V peci jeste hori stare uhli ",no_oPC,FALSE );

  TC_MakeButton("no_cistit","Cistit kov");
  TC_MakeButton("no_legovat","Legovat kov");
} else
  if(no_menu == 1)
  {
  if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )
FloatingTextStringOnCreature("Teplota v peci je nastavena na cisteni nugetu",no_oPC,FALSE );
else    FloatingTextStringOnCreature("Pec uhasina, chtelo by to vice uhli",no_oPC,FALSE );
  TC_MakeButton("no_zpet","Zpet",3);
}  else
  if(no_menu == 2)
  {
    if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )
FloatingTextStringOnCreature("Teplota v peci je nastavena na legovani kovu",no_oPC,FALSE );
else    FloatingTextStringOnCreature("Pec uhasina, chtelo by to vice uhli",no_oPC,FALSE );
  TC_MakeButton("no_zpet","Zpet",3);
} else
  if(no_menu == 3)
  {
      if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )
FloatingTextStringOnCreature("Teplota v peci je nastavena na slevani slitin",no_oPC,FALSE );
else    FloatingTextStringOnCreature("Pec uhasina, chtelo by to vice uhli",no_oPC,FALSE );
  TC_MakeButton("no_zpet","Zpet",3);
};



}
