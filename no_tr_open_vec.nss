#include "ku_libtime"

#include "ku_persist_inc"

object no_oPC;
int no_menu;
void main()


/////////////////////////
//no_menu:
//1 - Vyroba kratkych luku       tag: no_vyr_krluk
//2 - Vyroba slouhych luku       tag: no_vyr_dlluk
//3 - Vyroba malych kusi         tag: no_vyr_mlkus
//4 - Vyroba velkych kusi        tag: no_vyr_vlkus
//5 - Vyroba sipu                tag: no_vyr_sip
//6 - Vyroba sipek               tag: no_vyr_sipka
//
///////////////////////23.brezen stity ///////////////////
//7 - Vyroba maleho stitu        tag: no_vyr_mstit
//8 - Vyroba velkeho   stitu     tag: no_vyr_vstit
//9 - Vyroba pavezy              tag: no_vyr_pstit
//0 - Zpet na start              tag:no_zpet
//
//////////////////////////
{
no_oPC=GetLastDisturbed();




//doplnena perzistence 5.5.2014
/*if  (GetLocalInt(OBJECT_SELF,"no_prvni_otevreni")==0)   {
      SetLocalInt(OBJECT_SELF,"no_prvni_otevreni",1);
      Persist_OnContainerOpen(OBJECT_SELF, no_oPC);             } */
///////////////////////////////


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

SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_krluk"),"Vyroba kratkych luku");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dlluk"),"Vyroba dlouhych luku");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_mlkus"),"Vyroba malych kusi");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vlkus"),"Vyroba velkych kusi");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sip"),"Vyroba sipu");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sipka"),"Vyroba sipek");
///////////////////////23.brezen stity ///////////////////
//7 - Vyroba maleho stitu        tag: no_vyr_mstit
//8 - Vyroba velkeho   stitu     tag: no_vyr_vstit
//9 - Vyroba pavezy              tag: no_vyr_pstit
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_mstit"),"Vyroba maleho stitu");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vstit"),"Vyroba velkeho stitu");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pstit"),"Vyroba pavezy");
} else
  if(no_menu == 1)
  {
FloatingTextStringOnCreature("Vyroba kratkych luku",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 2)
  {
FloatingTextStringOnCreature("Vyroba dlouhych luku",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 3)
  {
FloatingTextStringOnCreature("Vyroba malych kusi",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 4)
  {
FloatingTextStringOnCreature("Vyroba velkych kusi",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 5)
  {
FloatingTextStringOnCreature("Vyroba sipu",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 6)
  {
FloatingTextStringOnCreature("Vyroba sipek",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 7)
  {
FloatingTextStringOnCreature("Vyroba maleho stitu",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 8)
  {
FloatingTextStringOnCreature("Vyroba velkeho stitu",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
}
else
  if(no_menu == 9)
  {
FloatingTextStringOnCreature("Vyroba pavezy",no_oPC,FALSE );
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet");
};



}

