#include "ku_libtime"
#include "no_oc_func"
#include "ku_persist_inc"


object no_oPC;
object no_Item;
int no_menu;
void main()

/////////////////////////
//no_menu:
//1 - Ocarovani zbrani     tag: no_vyr_zbran
//9 - volba ocarovani      tag: no_men_mater
//0  - Zpet do menu        tag: no_zpet
//
////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
//85 - vyber hl. mat       tag: no_men_hlmat
//86 - vyber vedl.mat      tag: no_men_vemat
//87 - vyber proc.mat      tag: no_men_proc

//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
//91 - prirad 100%         tag:no_men_10  //////// %% a mater se uz pridavaji do:
//92 - prirad  80%         tag:no_men_08  /// no_hl_mat
//93 - prirad  60%         tag:no_men_06  /// no_hl_proc
//94 - prirad  40%         tag:no_men_04  /// no_ve_mat
//95 - prirad  20%         tag:no_men_02

////////////////////////////////////////////////////////////////////////////////////
//101 - prirad el-kys      tag_no_men_kys
//102 - prirad el-ele      tag_no_men_ele
//103 - prirad el-ohe      tag_no_men_ohe
//104 - prirad el-chl      tag_no_men_chl
//105 - prirad zpiva.      tag_no_men_zvu
//106 - prirad ostro       tag_no_men_ost
//107 - prirad drze        tag_no_men_drz
//108 - prirad hlucho      tag_no_men_hlu
//109 - prirad omam        tag_no_men_oma
//110 - prirad tich        tag_no_men_tic
//111 - prirad strach      tag_no_men_str
//112 - zhouba nemrtv      tag_no_men_zne
//113 - zhouba obri        tag_no_men_zob
//114 - zhouba drak        tag_no_men_zdr
//115 - zhouba ork         tag_no_men_zor
//116 - zhouba jester      tag_no_men_zje
//117 - zhouba zvir        tag_no_men_zvi
//118 - zhouba sliz        tag_no_men_zsl
//119 - zhouba skret       tag_no_men_zsk
//120 - zhouba odchyl      tag_no_men_zod
//121 - zhouba menav       tag_no_men_zme
//122 - poprav nemrtv      tag_no_men_pne
//123 - poprav obri        tag_no_men_pob
//124 - poprav drak        tag_no_men_pdr
//125 - poprav ork         tag_no_men_por
//126 - poprav jester      tag_no_men_pje
//127 - poprav zvir        tag_no_men_pvi
//128 - poprav sliz        tag_no_men_psl
//129 - poprav skret       tag_no_men_psk
//130 - poprav odchyl      tag_no_men_pod
//131 - poprav menav       tag_no_men_pme
//132 - svaty              tag_no_men_sva
//133 - bezbozny           tag_no_men_bez
//134 - chaot              tag_no_men_cha
//135 - zakony             tag_no_men_zak
//136 - upiri              tag_no_men_upi
//137 - vybus              tag_no_men_vyb
//138 - zranuji            tag_no_men_zra
//139 - rusici             tag_no_men_rus
//140 - jedovy - str       tag_no_men_jst
//141 - jedovy - iq        tag_no_men_jiq
//142 - jedovy - wis       tag_no_men_jwi
//143 - jedovy - cha       tag_no_men_jch
//144 - jedovy - dex       tag_no_men_jde
//145 - jedovy - cons      tag_no_men_jco
//146 - oslabujici         tag_no_men_osl
//147 - prokle - str       tag_no_men_rst
//148 - prokle - iq        tag_no_men_riq
//149 - prokle - wis       tag_no_men_rwi
//150 - prokle - cha       tag_no_men_rch
//151 - prokle - dex       tag_no_men_rde
//152 - prokle - cons      tag_no_men_rco
//153 - odlehceny          tag_no_men_osl

/////////////////////////////////////////////////////////////////////////

{
no_oPC=GetLastOpenedBy();



//doplnena perzistence 5.5.2014
/*if  (GetLocalInt(OBJECT_SELF,"no_prvni_otevreni")==0)   {
      SetLocalInt(OBJECT_SELF,"no_prvni_otevreni",1);
      Persist_OnContainerOpen(OBJECT_SELF, no_oPC);             }   */
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
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_zbran"),"Ocarovavani zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba ocarovani pro vyrobu"));
}
 else
   if(no_menu == 1)
   {
 FloatingTextStringOnCreature("Ocarovavani zbrani",no_oPC,FALSE );
 }
  else
   if(no_menu == 9)
   {
 FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );
}
 else
   if ( (no_menu =85) )
   {
 FloatingTextStringOnCreature("Vyber hlavniho ocarovani",no_oPC,FALSE );
 //85 - vyber hl. mat       tag: no_men_hlmat
//86 - vyber vedl.mat      tag: no_men_vemat
//87 - vyber proc.mat      tag: no_men_proc
 }

  else
   if ( (no_menu =86) )
   {
 FloatingTextStringOnCreature("Vyber vedlejsiho ocarovani",no_oPC,FALSE );
 }
 else
   if ( (no_menu == 87) )
   {
 FloatingTextStringOnCreature("Pomer hlavniho ocarovani",no_oPC,FALSE );
 }


; //kvuli poslednimu elsu

}
