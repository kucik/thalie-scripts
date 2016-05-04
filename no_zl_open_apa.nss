#include "ku_libtime"
#include "no_zl_functions"
#include "ku_persist_inc"

object no_oPC;
object no_Item;
int no_menu;
void main()

/////////////////////////
//no_menu:
//1 - Vyroba prstenu      tag: no_vyr_prst
//2 - Vyroba amuletu      tag: no_vyr_amul
//9 - vyber  kamenu       tag: no_men_mater
//0  - Zpet do menu       tag: no_zpet
//
////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
//85 - vyber hl. mat       tag: no_men_hlmat
//86 - vyber vedl.mat      tag: no_men_vemat
//87 - vyber proc.mat      tag: no_men_proc

//91 - prirad 100%         tag_no_men_10  //////// %% a mater se uz pridavaji do:
//92 - prirad  80%         tag_no_men_08  /// no_hl_mat
//93 - prirad  60%         tag_no_men_06  /// no_hl_proc
//94 - prirad  40%         tag_no_men_04  /// no_ve_mat
//95 - prirad  20%         tag_no_men_02

////////////////////////////////////////////////////////////////////////////////////
//101 - prirad nefrit         tag_no_men_nef
//102 - prirad malachit       tag_no_men_mal
//103 - prirad ahnivy ach     tag_no_men_oha
//104 - prirad aventurin      tag_no_men_ave
//105 - prirad fenelop        tag_no_men_fen
//106 - prirad ametyst        tag_no_men_ame
//107 - prirad zivec          tag_no_men_ziv
//108 - prirad granat         tag_no_men_gra
//109 - prirad alexandrit     tag_no_men_ale
//110 - prirad topaz          tag_no_men_top
//111 - prirad safir          tag_no_men_saf
//112 - prirad ohnivy opal    tag_no_men_oho
//113 - pridat diamant        tag_no_men_dia
//114 - pridat rubin          tag_no_men_rub
//115 - pridat smaragd        tag_no_men_sma
/////////////////////////////////////////////////////////////////////////        //

{
no_oPC=GetLastOpenedBy();

//doplnena perzistence 5.5.2014
/*if  (GetLocalInt(OBJECT_SELF,"no_prvni_otevreni")==0)   {
      SetLocalInt(OBJECT_SELF,"no_prvni_otevreni",1);
      Persist_OnContainerOpen(OBJECT_SELF, no_oPC);             }      */
///////////////////////////////


/////////////////////////////////////////////////////////////////////////////////
/////zjistime zda ted otvira stejne pc jako minule, jestli ne, nastavime menu na zacatek
no_oPC = GetLastOpenedBy();
if  (GetLocalObject(OBJECT_SELF,"no_lastopened") == no_oPC  ) {
//no_oPC = GetLastOpenedBy();
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

DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_prst"),"Vyroba prstenu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_amul"),"Vyroba amuletu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba materialu pro vyrobu"));

}
 else
   if(no_menu == 1)
   {
 FloatingTextStringOnCreature("Vyroba prstenu",no_oPC,FALSE );
 }
 else
   if(no_menu == 2)
   {
 FloatingTextStringOnCreature("Vyroba amuletu",no_oPC,FALSE );
 }
 else
   if(no_menu == 9)
   {
 FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );
}
 else
   if ( (no_menu > 84)& (no_menu< 87) )
   {
 FloatingTextStringOnCreature("Vyber hlavniho materialu",no_oPC,FALSE );
 }
 else
   if ( (no_menu == 87) )
   {
 FloatingTextStringOnCreature("Pomer hlavniho materialu",no_oPC,FALSE );
 }


; //kvuli poslednimu elsu

}
