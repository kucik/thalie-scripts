#include "ku_libtime"
#include "no_zb_func"
#include "ku_persist_inc"
object no_oPC;
object no_Item;
int no_menu;
void main()

/////////////////////////
//no_menu:
//1 - Vyroba cepelove      tag: no_men_cepel
//2 - Vyroba drevcove      tag: no_men_drevc
//3 - Vyroba exoticke      tag: no_men_exoti
//4 - Vyroba oboustrane    tag: no_men_obous
//5 - Vyroba sekery        tag: no_men_seker
//6 - Vyroba tupe zbrane   tag: no_men_tupez
//7 - Vyroba spec. zbrani  tag: no_men_speci
//9 - vyber  materialu     tag: no_men_mater
//120 - zmena vzhledu zbr. tag: no_vzhled
//0  - Zpet do menu        tag: no_zpet
//
////////////////////////////////////////////////
//10 - vyroba dlouhe mece  tag: no_vyr_dl
//11 - vyroba dyky         tag: no_vyr_dy
//12 - vyroba kratke mece  tag: no_vyr_kr
//13 - vyroba bastardy     tag: no_vyr_ba
//14 - vyroba velky mece   tag: no_vyr_vm
//15 - vyroba katana       tag: no_vyr_ka
//16 - vyroba rapir        tag: no_vyr_ra
//17 - vyroba scimitar     tag: no_vyr_sc
//18 - vyroba rt.obri mec  tag: no_vyr_y1
//19 - vyroba rtut dlouhy  tag: no_vyr_y2
//////////////////////////
//20 - vyroba halapart     tag: no_vyr_ha
//21 - vyroba kopi         tag: no_vyr_ko
//22 - vyroba kosa         tag: no_vyr_ks
//23 - vyroba trident      tag: no_vyr_tr
//24 - vyroba hole         tag: no_vyr_hu
//25 - vyroba jednorucniho kopi         tag: no_vyr_ss
/////////////////////////
//31 - vyroba bice         tag: no_vyr_bc
//32 - vyroba kamy         tag: no_vyr_km
//33 - vyroba kukri        tag: no_vyr_ku
//34 - vyroba srpu         tag: no_vyr_sr
////////////////////////
//41 - vyroba dvoj.sek.    tag: no_vyr_ds
//42 - vyroba obous.mec    tag: no_vyr_dm
//43 - vyroba stras.pal    tag: no_vyr_dp
///////////////////////
//51 - vyroba velke sek.   tag: no_vyr_os
//52 - vyroba rucni sek.   tag: no_vyr_rs
//53 - vyroba trpas sek.   tag: no_vyr_ts
//54 - vyroba bitev sek.   tag: no_vyr_bs
//////////////////////
//61 - vyroba leh.cep      tag: no_vyr_lc
//62 - vyroba tez.cep      tag: no_vyr_tc
//63 - vyroba leh.kla      tag: no_vyr_lk
//64 - vyroba val.kla      tag: no_vyr_vk
//65 - vyroba kyj          tag: no_vyr_kj
//66 - vyroba palcat       tag: no_vyr_pa
//67 - vyroba remdih       tag: no_vyr_re
//68 - vyroba obri kladivo tag: no_vyr_ma
//
///////////7 - Vyroba spec. zbrani  tag: no_men_speci
//70 - vyroba  sai         tag: no_vyr_x2
//71 - vyroba ob.falch     tag: no_vyr_x3
//72 - vyroba katar        tag: no_vyr_x4
//73 - vyroba nunch        tag: no_vyr_x5
//74 - vyroba sap          tag: no_vyr_x6
//75 - vyroba ob.scimi     tag: no_vyr_x7
//76 - vyroba tezky pal.   tag: no_vyr_x8
//77 - vyroba krumpac      tag: no_vyr_hp
//78 - vyroba lehky krumpac  tag: no_vyr_lp
//79 - vyroba maug dv. mec tag: no_vyr_y3

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
//101 - prirad cin         tag_no_men_cin
//102 - prirad med         tag_no_men_med
//103 - prirad bro         tag_no_men_bro
//104 - prirad zel         tag_no_men_zel
//105 - prirad zla         tag_no_men_zla
//106 - prirad pla         tag_no_men_pla
//107 - prirad mit         tag_no_men_mit
//108 - prirad ada         tag_no_men_ada
//109 - prirad tit         tag_no_men_tit
//110 - prirad str         tag_no_men_str
//111 - prirad sti         tag_no_men_sti
//112 - prirad met         tag_no_men_met
/////////////////////////////////////////////////////////////////////////        //

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

DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cepel"),"Vyroba cepelovych zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_drevc"),"Vyroba drevcovych zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_exoti"),"Vyroba exotickych zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_obous"),"Vyroba oboustrannych zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_seker"),"Vyroba seker"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tupez"),"Vyroba tupych zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_speci"),"Vyroba specielnich zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba materialu pro vyrobu"));
//120 - zmena vzhledu zbr. tag: no_vzhled
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_vzhled"),"Zmena vzhledu zbrane"));
}
 else
   if(no_menu == 1)
   {
 FloatingTextStringOnCreature("Vyroba cepelovych zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dl"),"Vyroba dlouheho mece"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dy"),"Vyroba dyky"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_kr"),"Vyroba kratkeho mece"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ba"),"Vyroba bastardu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vm"),"Vyroba velkeho mece"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ka"),"Vyroba katany"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ra"),"Vyroba rapiru"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sc"),"Vyroba scimitaru"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
   if(no_menu == 2)
   {
 FloatingTextStringOnCreature("Vyroba drevcovych zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ha"),"Vyroba halapartny"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ko"),"Vyroba kopi"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ks"),"Vyroba kosy"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_tr"),"Vyroba tridentu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
   if(no_menu == 3)
   {
 FloatingTextStringOnCreature("Vyroba exotickych zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_bc"),"Vyroba bice"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_km"),"Vyroba kamy"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ku"),"Vyroba kukri"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sr"),"Vyroba srpu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
   if(no_menu == 4)
   {
 FloatingTextStringOnCreature("Vyroba oboustrannych zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ds"),"Vyroba dvojstranne sekery"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dm"),"Vyroba oboustranneho mece"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dp"),"Vyroba strasliveho palcatu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
   if(no_menu == 5)
   {
 FloatingTextStringOnCreature("Vyroba seker",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_os"),"Vyroba velke sekery"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_rs"),"Vyroba rucni sekery"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ts"),"Vyroba trpaslici sekery"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_bs"),"Vyroba bitevni sekery"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
   if(no_menu == 6)
   {
 FloatingTextStringOnCreature("Vyroba tupych zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lc"),"Vyroba lehkeho cepu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_tc"),"Vyroba tezkeho cepu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lk"),"Vyroba lehkeho kladiva"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vk"),"Vyroba valecneho cepu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_kj"),"Vyroba kyje"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pa"),"Vyroba palcatu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_re"),"Vyroba remdihu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
    if(no_menu == 7)
   {
 FloatingTextStringOnCreature("Vyroba specielnich zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lc"),"Vyroba lehkeho cepu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_tc"),"Vyroba tezkeho cepu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lk"),"Vyroba lehkeho kladiva"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vk"),"Vyroba valecneho cepu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_kj"),"Vyroba kyje"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pa"),"Vyroba palcatu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_re"),"Vyroba remdihu"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
 }
 else
   if(no_menu == 9)
   {
 FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_hlmat"),"Vyber hlavni material"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vemat"),"Vyber vedlejsi material"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_proc"),"Urci pomer smychani"));
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
}
 else
   if( (no_menu > 9)& (no_menu< 18) )
   {

// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_cepel"),"Zpet"));
 switch (no_menu)  {
     case 10: {FloatingTextStringOnCreature(" Vyroba dlouheho mece ",no_oPC,FALSE );    break; }
     case 11: {FloatingTextStringOnCreature(" Vyroba dyky ",no_oPC,FALSE );             break;  }
     case 12: {FloatingTextStringOnCreature(" Vyroba kratkeho mece ",no_oPC,FALSE );    break;  }
     case 13: {FloatingTextStringOnCreature(" Vyroba bastardu ",no_oPC,FALSE );    break;  }
     case 14: {FloatingTextStringOnCreature(" Vyroba velkeho mece ",no_oPC,FALSE );    break;  }
     case 15: {FloatingTextStringOnCreature(" Vyroba katany ",no_oPC,FALSE );    break;  }
     case 16: {FloatingTextStringOnCreature(" Vyroba rapiru ",no_oPC,FALSE );    break;  }
     case 17: {FloatingTextStringOnCreature(" Vyroba scimitaru ",no_oPC,FALSE );    break;  }
     case 18: {FloatingTextStringOnCreature(" Vyroba rtutoveho obriho mece ",no_oPC,FALSE );    break;  }
     case 19: {FloatingTextStringOnCreature(" Vyroba rtutoveho dlouheho mece ",no_oPC,FALSE );    break;  }
         }//konec switche
 }
 else
   if( (no_menu > 19)& (no_menu< 25) )
   {
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_drevc"),"Zpet"));

 switch (no_menu)  {
     case 20: {FloatingTextStringOnCreature(" Vyroba halapartny ",no_oPC,FALSE );    break; }
     case 21: {FloatingTextStringOnCreature(" Vyroba kopi ",no_oPC,FALSE );             break;  }
     case 22: {FloatingTextStringOnCreature(" Vyroba kosy ",no_oPC,FALSE );    break;  }
     case 23: {FloatingTextStringOnCreature(" Vyroba trojzubce ",no_oPC,FALSE );    break;  }
     //24 - vyroba hole         tag: no_vyr_hu
     case 24: {FloatingTextStringOnCreature(" Vyroba hole",no_oPC,FALSE );    break;  }
     case 25: {FloatingTextStringOnCreature(" Vyroba jednorucniho kopi",no_oPC,FALSE );    break;  }
         }//konec switche
 }
 else
   if( (no_menu > 29)& (no_menu< 35) )
   {
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_exoti"),"Zpet"));

 switch (no_menu)  {
     case 30: {FloatingTextStringOnCreature(" Vyroba bice ",no_oPC,FALSE );    break; }
     case 31: {FloatingTextStringOnCreature(" Vyroba kamy ",no_oPC,FALSE );             break;  }
     case 32: {FloatingTextStringOnCreature(" Vyroba kukri ",no_oPC,FALSE );    break;  }
     case 33: {FloatingTextStringOnCreature(" Vyroba srpu ",no_oPC,FALSE );    break;  }
         }//konec switche
 }
 else
   if( (no_menu > 40)& (no_menu< 44) )
   {
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_obous"),"Zpet"));
 switch (no_menu)  {
     case 41: {FloatingTextStringOnCreature(" Vyroba dvojsecne sekery ",no_oPC,FALSE );    break; }
     case 42: {FloatingTextStringOnCreature(" Vyroba oboustranneho mece ",no_oPC,FALSE );             break;  }
     case 43: {FloatingTextStringOnCreature(" Vyroba strasliveho palcatu ",no_oPC,FALSE );    break;  }
         }//konec switche
 }
 else
   if( (no_menu > 50)& (no_menu< 55) )
   {
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_seker"),"Zpet"));
 switch (no_menu)  {
     case 51: {FloatingTextStringOnCreature(" Vyroba vleke sekery ",no_oPC,FALSE );    break; }
     case 52: {FloatingTextStringOnCreature(" Vyroba rucni sekery ",no_oPC,FALSE );             break;  }
     case 53: {FloatingTextStringOnCreature(" Vyroba trpaslici sekery ",no_oPC,FALSE );    break;  }
     case 54: {FloatingTextStringOnCreature(" Vyroba bitevni sekery ",no_oPC,FALSE );    break;  }
         }//konec switche
 }
 else
   if( (no_menu > 60)& (no_menu< 68) )
   {
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_tupez"),"Zpet"));
 switch (no_menu)  {
     case 61: {FloatingTextStringOnCreature(" Vyroba lehkeho cepu ",no_oPC,FALSE );    break; }
     case 62: {FloatingTextStringOnCreature(" Vyroba tezkeho cepu ",no_oPC,FALSE );             break;  }
     case 63: {FloatingTextStringOnCreature(" Vyroba lehkeho kladiva ",no_oPC,FALSE );    break;  }
     case 64: {FloatingTextStringOnCreature(" Vyroba valecneho kladiva ",no_oPC,FALSE );    break;  }
     case 65: {FloatingTextStringOnCreature(" Vyroba kyje ",no_oPC,FALSE );             break;  }
     case 66: {FloatingTextStringOnCreature(" Vyroba palcatu ",no_oPC,FALSE );    break;  }
     case 67: {FloatingTextStringOnCreature(" Vyroba remdihu ",no_oPC,FALSE );    break;  }
     //68 - vyroba obri kladivo tag: no_vyr_ma
     case 68: {FloatingTextStringOnCreature(" Vyroba obriho kladiva ",no_oPC,FALSE );    break;  }
         }//konec switche
 }
 else
///////////7 - Vyroba spec. zbrani  tag: no_men_speci
//70 - vyroba  sai         tag: no_vyr_x2
//71 - vyroba ob.falch     tag: no_vyr_x3
//72 - vyroba katar        tag: no_vyr_x4
//73 - vyroba nunch        tag: no_vyr_x5
//74 - vyroba sap          tag: no_vyr_x6
//75 - vyroba ob.scimi     tag: no_vyr_x7
//76 - vyroba tezky pal.   tag: no_vyr_x8
//18 - vyroba rt.obri mec  tag: no_vyr_y1
//19 - vyroba rtut dlouhy  tag: no_vyr_y2
//79 - vyroba maug dv. mec tag: no_vyr_y3
   if( (no_menu > 69)& (no_menu< 80) )
   {
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_tupez"),"Zpet"));
 switch (no_menu)  {
     case 70: {FloatingTextStringOnCreature(" Vyroba sai ",no_oPC,FALSE );    break; }
     case 71: {FloatingTextStringOnCreature(" Vyroba obourucniho falchionu ",no_oPC,FALSE );             break;  }
     case 72: {FloatingTextStringOnCreature(" Vyroba kataru ",no_oPC,FALSE );    break;  }
     case 73: {FloatingTextStringOnCreature(" Vyroba nunchak ",no_oPC,FALSE );    break;  }
     case 74: {FloatingTextStringOnCreature(" Vyroba sap ",no_oPC,FALSE );             break;  }
     case 75: {FloatingTextStringOnCreature(" Vyroba obourucniho scimitaru",no_oPC,FALSE );    break;  }
     case 76: {FloatingTextStringOnCreature(" Vyroba tezkeho palcatu ",no_oPC,FALSE );    break;  }
     case 77: {FloatingTextStringOnCreature(" Vyroba krumpace ",no_oPC,FALSE );    break;  }
     case 78: {FloatingTextStringOnCreature(" Vyroba lehkeho krumpace ",no_oPC,FALSE );    break;  }
     case 79: {FloatingTextStringOnCreature(" Vyroba maugova dvojiteho mece ",no_oPC,FALSE );    break;  }
         }//konec switche
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

//120 - zmena vzhledu zbr. tag: no_vzhled
  else
   if ( (no_menu == 120) )
   {
 FloatingTextStringOnCreature("Zmena vzhledu zbrani",no_oPC,FALSE );
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_10"),"100%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_08"),"80%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_06"),"60%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_04"),"40%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_02"),"20%")); //pridame tlacitko zpet
// DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_vyr_mater"),"Zpet")); //pridame tlacitko zpet
 }

; //kvuli poslednimu elsu

}
