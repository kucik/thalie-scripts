#include "ku_libtime"
#include "no_pl_func"
#include "ku_persist_inc"
object no_oPC;
object no_Item;
int no_menu;
void main()

/////////////////////////
//no_menu:
//1 - Vyroba krouzkova     tag: no_vyr_krouz
//2 - Vyroba hrudni krunyr tag: no_vyr_hrudn
//3 - Vyroba destickova    tag: no_vyr_desti
//4 - Vyroba pulplatova    tag: no_vyr_pulpl
//5 - Vyroba plnaplatova   tag: no_vyr_plnpl
//6 - Vyroba helma         tag: no_vyr_helma
//7 - Vyroba ok.boty       tag: no_vyr_okbot
//8 - Vyroba ok.rukavice   tag: no_vyr_okruk
//9 - vyber  materialu     tag: no_men_mater
//10 - zmena vzhledu stitu tag: no_vzhled_stit
//0  - Zpet do menu        tag: no_zpet
//

{
no_oPC=GetLastOpenedBy();

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
SetLocalInt(OBJECT_SELF,"no_menu",0);
SetLocalInt(OBJECT_SELF,"no_hl_mat",1);
SetLocalInt(OBJECT_SELF,"no_ve_mat",1);
SetLocalInt(OBJECT_SELF,"no_hl_proc",10); }

/////////////////////////////////////////////////////////////////////////////////
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");


no_reknimat(no_oPC); /// Rekne co je tam za material

//}/////////////znicime prepinace///////////////////////

if(no_menu == 0)   // zacatek menu
{
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);


DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_krouz"),"Krouzkova kosile"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_hrudn"),"Hrudni pancir"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_desti"),"Destickova zbroj"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pulpl"),"Polovicni platova zbroj"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_plnpl"),"Plna platova zbroj"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_helma"),"Helma"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_okbot"),"Okovane boty"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_okruk"),"Okovane rukavice"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba materialu pro vyrobu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_vzhled_stit"),"Zmena vzhledu stitu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_vzhled_helm"),"Zmena vzhledu helmy"));

}
 else
   if(no_menu == 1)
   {
 FloatingTextStringOnCreature("Krouzkova kosile",no_oPC,FALSE );
 }
 else
   if(no_menu == 2)
   {
 FloatingTextStringOnCreature("Hrudni pancir",no_oPC,FALSE );
 }
 else
   if(no_menu == 3)
   {
 FloatingTextStringOnCreature("Destickova zbroj",no_oPC,FALSE );

 }
 else
   if(no_menu == 4)
   {
 FloatingTextStringOnCreature("Polovicni platova zbroj",no_oPC,FALSE );
 }
 else
   if(no_menu == 5)
   {
    FloatingTextStringOnCreature("Plna platova zbroj",no_oPC,FALSE );
 }
 else
   if(no_menu == 6)
   {
FloatingTextStringOnCreature("Helma",no_oPC,FALSE );
 }
 else
   if(no_menu ==7)
   {
FloatingTextStringOnCreature("Okovane boty",no_oPC,FALSE );
 }
 else
   if(no_menu == 8)
   {
FloatingTextStringOnCreature("Okovane rukavice",no_oPC,FALSE );
 }
 else
   if(no_menu ==9)
   {
FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );
}
//10 - zmena vzhledu stitu tag: no_vzhled_stit
 else
   if(no_menu == 10)
   {
 FloatingTextStringOnCreature("Zmena vzhledu stitu",no_oPC,FALSE );
}

 else
   if(no_menu == 11)
   {
 FloatingTextStringOnCreature("Zmena vzhledu helmy",no_oPC,FALSE );
}
 else
   if ( (no_menu > 84)& (no_menu< 87) )
   {
 FloatingTextStringOnCreature("Vyber hlavniho materialu",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_met"),"meteoriticka ocel")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sti"),"stinova ocel")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_str"),"stribro")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_tit"),"titan")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ada"),"adamantin")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_mit"),"mithril")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pla"),"platina")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_zla"),"zlato")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_zel"),"zelezo")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_bro"),"bronz")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_med"),"med")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_cin"),"cin")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_mater"),"Zpet")); //pridame tlacitko zpet
 }
 else
   if ( (no_menu == 87) )
   {
 FloatingTextStringOnCreature("Pomer hlavniho materialu",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_10"),"100%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_08"),"80%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_06"),"60%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_04"),"40%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_02"),"20%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_mater"),"Zpet")); //pridame tlacitko zpet
 }


; //kvuli poslednimu elsu

}
