//kvuli preotevirani a podobnym kravinam
#include "no_zb_func"
// kvuli lvlu kovare
//#include "no_zb_inc"
#include "no_nastcraft_ini"
//kvuli lvlu kovare
#include "tc_xpsystem_inc"

#include "ku_persist_inc"
object no_Item;
object no_oPC;




/////////////////////////
//no_menu:
//1 - Vyroba cepelove      tag: no_men_cepel
//2 - Vyroba drevcove      tag: no_men_drevc
//3 - Vyroba exoticke      tag: no_men_exoti
//4 - Vyroba oboustrane    tag: no_men_obous
//5 - Vyroba sekery        tag: no_men_seker
//6 - Vyroba tupe zbrane   tag: no_men_tupez
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
//25 - vyroba jednorucniho kopi  tag: no_vyr_ss
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

///////////7 - Vyroba spec. zbrani  tag: no_men_speci
//70 - vyroba  sai         tag: no_vyr_x2
//71 - vyroba ob.falch     tag: no_vyr_x3
//72 - vyroba katar        tag: no_vyr_x4
//73 - vyroba nunch        tag: no_vyr_x5
//74 - vyroba sap          tag: no_vyr_x6
//75 - vyroba ob.scimi     tag: no_vyr_x7
//76 - vyroba tezky pal.   tag: no_vyr_x8
//77 - vyroba krumpace     tag: no_vyr_hp
//78 - vyroba lehkeho krumpace  tag: no_vyr_lp
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
/////////////////////////////////////////////////////////////////////////

void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z aparatu neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();


///doplnena perzistence 5.5.2014
               // DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru


///////////////////// kdyz se jedna o vec, co se ma vyrabet//////////////////////
//string no_menu_tagveci = GetStringRight(GetTag(no_vzataItem),6);
//no_menu_tagveci =  GetStringLeft(no_menu_tagveci,3);

if (GetStringLeft( GetStringRight(GetTag(no_vzataItem),6),3) == "vyr" ) {
no_reknimat(no_oPC);
SetLocalString (OBJECT_SELF,"no_menu",GetStringRight(GetTag(no_vzataItem),2) );
// SendMessageToPC(no_oPC,"Material co vyrabim je: " + GetLocalString(OBJECT_SELF,"no_menu"));
 }

///////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////1-NASTAVIT vyroba cepelovych zbrani/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_cepel" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba cepelovych zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dl"),"Vyroba dlouheho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dy"),"Vyroba dyky"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_kr"),"Vyroba kratkeho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ba"),"Vyroba bastardu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vm"),"Vyroba velkeho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ka"),"Vyroba katany"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ra"),"Vyroba rapiru"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sc"),"Vyroba scimitaru"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_y1"),"Vyroba rtutoveho obriho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_y2"),"Vyroba rtutoveho dlouheho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
DelayCommand(0.1,SetLocalInt(OBJECT_SELF,"no_menu",1));
} //////////////////////////////////////////////

/////////////////////////////2-NASTAVIT vyroba drevcovych zbrani/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_drevc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba drevcovych zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ha"),"Vyroba halapartny"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ko"),"Vyroba kopi"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ks"),"Vyroba kosy"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_tr"),"Vyroba tridentu"));
//24 - vyroba hole         tag: no_vyr_hu
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_hu"),"Vyroba hole"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ss"),"Vyroba jednorucniho kopi"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",2);
} //////////////////////////////////////////////

/////////////////////////////3-NASTAVIT exoticke zbrane/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_exoti" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba exotickych zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_bc"),"Vyroba bice"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_km"),"Vyroba kamy"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ku"),"Vyroba kukri"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sr"),"Vyroba srpu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",3);
} //////////////////////////////////////////////

/////////////////////////////4-NASTAVIT vyroba voboustranych zbrani/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_obous" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba oboustrannych zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ds"),"Vyroba dvojstranne sekery"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dm"),"Vyroba oboustranneho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dp"),"Vyroba strasliveho palcatu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",4);
} /////////////////////////////////////////////

/////////////////////////////5-NASTAVIT vyrobu seker /////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_seker" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba seker",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_os"),"Vyroba velke sekery"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_rs"),"Vyroba rucni sekery"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ts"),"Vyroba trpaslici sekery"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_bs"),"Vyroba bitevni sekery"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",5);
} ////////////////////////////////////////

/////////////////////////////6-NASTAVIT vyroba tupych zbrani/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_tupez" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba tupych zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lc"),"Vyroba lehkeho cepu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_tc"),"Vyroba tezkeho cepu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lk"),"Vyroba lehkeho kladiva"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vk"),"Vyroba valecneho kladiva"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_kj"),"Vyroba kyje"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pa"),"Vyroba palcatu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_re"),"Vyroba remdihu"));
     //68 - vyroba obri kladivo tag: no_vyr_ma
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_ma"),"Vyroba obriho kladiva"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",6);
} //////////////////////////////////////////
 ///////////7 - Vyroba spec. zbrani  tag: no_men_speci

if (GetTag(no_vzataItem) == "no_men_speci" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba specielnich zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x2"),"Vyroba sai"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x3"),"Vyroba obourucniho falchionu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x4"),"Vyroba kataru"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x5"),"Vyroba nunchak"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x6"),"Vyroba sap"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x7"),"Vyroba obourucniho scimitaru"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_x8"),"Vyroba tezkeho palcatu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_y3"),"Vyroba maugova dvojiteho mece"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_hp"),"Vyroba krumpace"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lp"),"Vyroba lehkeho krupace"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",7);
} //////////////////////////////////////////

/////////////////////////////9-NASTAVIT volba materialu/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_mater" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
//no_reknimat(no_oPC);
FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_hlmat"),"Vyber hlavni material"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_vemat"),"Vyber vedlejsi material"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_proc"),"Urci pomer smichani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",9);
} ////////////////////////////////////////////


/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
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


SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////////////////////////////

/////////////////120 - Zmena vzhledu zbrani
if (GetTag(no_vzataItem) == "no_vzhled" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
//no_reknimat(no_oPC);
//FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );

SetLocalInt (OBJECT_SELF, "no_zbran_bot",0);
SetLocalInt (OBJECT_SELF, "no_zbran_bot_las",0);
SetLocalInt (OBJECT_SELF, "no_zbran_bot_barva",0);
SetLocalInt (OBJECT_SELF, "no_zbran_bot_barva_las",0);
SetLocalInt (OBJECT_SELF, "no_zbran_mid",0);
SetLocalInt (OBJECT_SELF, "no_zbran_mid_las",0);
SetLocalInt (OBJECT_SELF, "no_zbran_mid_barva",0);
SetLocalInt (OBJECT_SELF, "no_zbran_mid_barva_las",0);
SetLocalInt (OBJECT_SELF, "no_zbran_top",0);
SetLocalInt (OBJECT_SELF, "no_zbran_top_las",0);
SetLocalInt (OBJECT_SELF, "no_zbran_top_barva",0);
SetLocalInt (OBJECT_SELF, "no_zbran_top_barva_las",0);
object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC);
/////////tak mame vynulovano z minuleho pouziti///////////////

if ( GetIsObjectValid(oItem) == TRUE )     {
string no_zbran_jmenovzhledu = "";
int no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM);
SetLocalInt(OBJECT_SELF,"no_zbran_bot_las",no_apperance);
no_zbran_jmenovzhledu =IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_BOTTOM);
SetLocalInt(OBJECT_SELF,"no_zbran_bot_barva_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE);
SetLocalInt(OBJECT_SELF,"no_zbran_mid_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_MIDDLE);
SetLocalInt(OBJECT_SELF,"no_zbran_mid_barva_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP);
SetLocalInt(OBJECT_SELF,"no_zbran_top_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
no_apperance = GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_COLOR_TOP);
SetLocalInt(OBJECT_SELF,"no_zbran_top_barva_las",no_apperance);
no_zbran_jmenovzhledu =no_zbran_jmenovzhledu + ":" + IntToString(no_apperance);
SetLocalString(OBJECT_SELF,"no_zbran_jmenovzhledu",no_zbran_jmenovzhledu);

FloatingTextStringOnCreature(" Zbran byla ulozena s cisly: " +no_zbran_jmenovzhledu ,no_oPC,FALSE);
FloatingTextStringOnCreature("Graficky efekt stoji 5000 zlatych za kazdou zmenu !!! Na zbrani se projevi jen 1 zvoleny a prepise tak efekt dany od NWN z typu zbrane " ,no_oPC,FALSE);

//jeste ulozime objekt, kdyby byl neplatny vzhled stitu !
SetLocalObject(OBJECT_SELF, "no_" + GetName( GetPCSpeaker()) ,oItem);
} //kdyz je zbran valid object

if ( GetIsObjectValid(oItem) == FALSE )  FloatingTextStringOnCreature(" Neplatny objekt v prave ruce " ,GetPCSpeaker() ,FALSE);


DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_bot_dals"),"Dalsi vzhled konce"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_bot_pred"),"Predchozi vzhled konce"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_bot_dals"),"Dalsi barva konce"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_bot_pred"),"Predchozi barva konce"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_mid_dals"),"Dalsi vzhled stredu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_mid_pred"),"Predchozi vzhled stredu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_mid_dals"),"Dalsi barva stredu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_mid_pred"),"Predchozi barva stredu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_top_dals"),"Dalsi vzhled vrsku"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_top_pred"),"Predchozi vzhled vrsku"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_top_dals"),"Dalsi barva vrsku"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_top_pred"),"Predchozi barva vrsku"));
//jeste pridame barvicky
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_acid"),"kyselina (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_cold"),"chlad (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_electrical"),"elektrina (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_evil"),"zlo (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_fire"),"ohen (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_holy"),"svaty (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_sonic"),"zvuk (cena 5000zl)"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_delete"),"Odstranit pridany grafickyefekt"));
//konec barvicek

DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_zapa"),"Zapamatovat vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",120);
} ////////////////////////////////////////////

//////////menim vzhled zbrane //////////
if (GetTag(no_vzataItem) == "no_vzhled_bot_dals") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_bot_dals"),"Dalsi vzhled konce")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_vzhled_bot_pred") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_BOTTOM,-1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_bot_pred"),"Predchozi vzhled konce")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_barva_bot_dals") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_bot_dals"),"Dalsi barva konce")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_barva_bot_pred") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_BOTTOM,-1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_bot_pred"),"Predchozi barva konce")); //kdyz se sebralo, musime vratit
}
///midddle///

if (GetTag(no_vzataItem) == "no_vzhled_mid_dals") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_mid_dals"),"Dalsi vzhled stredu")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_vzhled_mid_pred") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_MIDDLE,-1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_mid_pred"),"Predchozi vzhled stredu")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_barva_mid_dals") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_mid_dals"),"Dalsi barva stredu")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_barva_mid_pred") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_MIDDLE,-1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_mid_pred"),"Predchozi barva stredu")); //kdyz se sebralo, musime vratit
}
//top
if (GetTag(no_vzataItem) == "no_vzhled_top_dals") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_top_dals"),"Dalsi vzhled vrsku")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_vzhled_top_pred") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_MODEL,ITEM_APPR_WEAPON_MODEL_TOP,-1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_top_pred"),"Predchozi vzhled vrsku")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_barva_top_dals") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_top_dals"),"Dalsi barva vrsku")); //kdyz se sebralo, musime vratit
}
if (GetTag(no_vzataItem) == "no_barva_top_pred") {
no_vzhled_zbrane(no_oPC,ITEM_APPR_TYPE_WEAPON_COLOR,ITEM_APPR_WEAPON_COLOR_TOP,-1);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_barva_top_pred"),"Predchozi barva vrsku")); //kdyz se sebralo, musime vratit
}
////posledni dva zapamatovani + obnovit vzhled
if (GetTag(no_vzataItem) == "no_vzhled_puvo") {
no_vzhled_puvo(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_uvo"),"Puvodni vzhled")); //pridame tlacitko zpet
}
if (GetTag(no_vzataItem) == "no_vzhled_zapa") {
no_vzhled_zapa(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_zapa"),"Zapamatovat vzhled")); //pridame tlacitko zpet
}
////barvicky :

if (GetTag(no_vzataItem) == "no_visual_acid") {
no_visual(no_oPC,ITEM_VISUAL_ACID);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_acid"),"kyselina 5000zl")); //pridame tlacitko zpet
}
if (GetTag(no_vzataItem) == "no_visual_cold") {
no_visual(no_oPC,ITEM_VISUAL_COLD);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_cold"),"chlad (cena 5000zl)")); //pridame tlacitko zpet
}
if (GetTag(no_vzataItem) == "no_visual_electrical") {
no_visual(no_oPC,ITEM_VISUAL_ELECTRICAL);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_electrical"),"elektrina (cena 5000zl)"));
}
if (GetTag(no_vzataItem) == "no_visual_evil") {
no_visual(no_oPC,ITEM_VISUAL_EVIL);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_evil"),"zlo (cena 5000zl)"));
}
if (GetTag(no_vzataItem) == "no_visual_fire") {
no_visual(no_oPC,ITEM_VISUAL_FIRE);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_fire"),"ohen (cena 5000zl)"));
}
if (GetTag(no_vzataItem) == "no_visual_holy") {
no_visual(no_oPC,ITEM_VISUAL_HOLY);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_holy"),"svaty (cena 5000zl)"));
}
if (GetTag(no_vzataItem) == "no_visual_sonic") {
no_visual(no_oPC,ITEM_VISUAL_SONIC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_sonic"),"zvuk (cena 5000zl)"));
}
if (GetTag(no_vzataItem) == "no_visual_delete") {
no_visual(no_oPC,10);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_visual_delete"),"Odstranit pridany graficky efekt"));
}




////////////////////////////10 - nastavit dl.mec/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_dl" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba dlouheho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",10);
} //////////////////////////////////////////////
////////////////////////////11 - nastavit dyka/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_dy" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba dyky",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",11);
} //////////////////////////////////////////////
////////////////////////////12 - nastavit kr mec/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_kr" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kratkeho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",12);
} //////////////////////////////////////////////
////////////////////////////13 - nastavit bastard/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ba" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba bastardu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",13);
} //////////////////////////////////////////////
////////////////////////////14 - nastavitvel.mec/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_vm" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba velkeho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",14);
} //////////////////////////////////////////////
////////////////////////////15 - nastavit katan/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ka" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba katany",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",15);
} //////////////////////////////////////////////
////////////////////////////16 - nastavit rapir/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ra" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba rapiru",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",16);
} //////////////////////////////////////////////
////////////////////////////17 - nastavit scimitar/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_sc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba scimitaru",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",17);
}
//18 - vyroba rt.obri mec  tag: no_vyr_y1
if (GetTag(no_vzataItem) == "no_vyr_y1" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba rtutoveho obriho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",18);
}
//19 - vyroba rtut dlouhy  tag: no_vyr_y2
if (GetTag(no_vzataItem) == "no_vyr_y2" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_cepel"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba rtutoveho dlouheho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",19);
}//////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ha" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_drevc"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba halapartny",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",20);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ko" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_drevc"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kopi",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",21);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ks" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_drevc"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kosy",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",22);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_tr" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_drevc"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba trojzubce",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",23);
} //////////////////////////////////////////////
/////////////24 - vyroba hole         tag: no_vyr_hu
if (GetTag(no_vzataItem) == "no_vyr_hu" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_drevc"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba hole",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",24);
}
///////////////////////////////////////////////////////////
//// vyroba jednorucniho kopi
if (GetTag(no_vzataItem) == "no_vyr_ss" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_drevc"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba jednorucniho kopi",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",25);
}
//////////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_bc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_exoti"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba bice",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",31);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_km" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_exoti"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kamy",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",32);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ku" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_exoti"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kukri",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",33);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_sr" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_exoti"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba srpu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",34);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ds" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_obous"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba dvojsecne sekery",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",41);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_dm" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_obous"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba oboustranneho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",42);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_dp" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_obous"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba strasliveho palcatu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",43);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_os" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_seker"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba velke sekery",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",51);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_rs" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_seker"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba rucni sekery",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",52);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_ts" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_seker"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba trpaslici sekery",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",53);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_bs" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_seker"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba bitevni sekery",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",54);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_lc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba lehkeho cepu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",61);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_tc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba tezkeho cepu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",62);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_lk" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba lehkeho kladiva",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",63);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_vk" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba valecneho kladiva",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",64);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_kj" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kyje",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",65);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_pa" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba palcatu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",66);
} //////////////////////////////////////////////
///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_re" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba remdihu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",67);
} //////////////////////////////////////////////
     //68 - vyroba obri kladivo tag: no_vyr_ma
if (GetTag(no_vzataItem) == "no_vyr_ma" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_tupez"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba obriho kladiva",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",68);
}

///////////7 - Vyroba spec. zbrani  tag: no_men_speci
//70 - vyroba  sai         tag: no_vyr_x2
if (GetTag(no_vzataItem) == "no_vyr_x2" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba sai",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",70);
}
//71 - vyroba ob.falch     tag: no_vyr_x3
if (GetTag(no_vzataItem) == "no_vyr_x3" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba obourcniho falchionu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",71);
}
//72 - vyroba katar        tag: no_vyr_x4
if (GetTag(no_vzataItem) == "no_vyr_x4" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kataru",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",72);
}
//73 - vyroba nunch        tag: no_vyr_x5
if (GetTag(no_vzataItem) == "no_vyr_x5" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba nunchak",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",73);
}
//74 - vyroba sap          tag: no_vyr_x6
if (GetTag(no_vzataItem) == "no_vyr_x6" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba sapu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",74);
}
//75 - vyroba ob.scimi     tag: no_vyr_x7
if (GetTag(no_vzataItem) == "no_vyr_x7" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba obourucni scimitar",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",75);
}
//76 - vyroba tezky pal.   tag: no_vyr_x8
if (GetTag(no_vzataItem) == "no_vyr_x8" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba tezkeho palcatu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",76);
}
//77 - vyroba krumpac.   tag: no_vyr_hp
if (GetTag(no_vzataItem) == "no_vyr_hp" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba krumpace",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",77);
}
//78 - vyroba lehky krumpac   tag: no_vyr_lp
if (GetTag(no_vzataItem) == "no_vyr_lp" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba tezkeho palcatu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",78);
}
//79 - vyroba maug dv. mec tag: no_vyr_y3
if (GetTag(no_vzataItem) == "no_vyr_y3" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba maugova dvojiteho mece",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",79);
}
////77 - vyroba krumpace
if (GetTag(no_vzataItem) == "no_vyr_hp" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba krumpac",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",77);
}
////78- vyroba lehky krumpac
if (GetTag(no_vzataItem) == "no_vyr_lp" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_speci"),"Zpet")); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba lehky krumpac",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",78);
}

///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_hlmat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyber hlavniho materialu",no_oPC,FALSE );
no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_met"),"meteoriticka ocel")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sti"),"stinova ocel")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_str"),"stribro")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tit"),"titan")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ada"),"adamantin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_mit"),"mithril")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pla"),"platina")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zla"),"zlato")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zel"),"zelezo")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_bro"),"vermajl")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_med"),"med")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cin"),"cin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_mater"),"Zpet")); //pridame tlacitko zpet

SetLocalInt(OBJECT_SELF,"no_menu",85);
} //////////////////////////////////////////////

///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_vemat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyber vedlejsiho materialu",no_oPC,FALSE );
no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_met"),"meteoriticka ocel")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sti"),"stinova ocel")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_str"),"stribro")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tit"),"titan")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ada"),"adamantin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_mit"),"mithril")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pla"),"platina")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zla"),"zlato")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zel"),"zelezo")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_bro"),"vermajl")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_med"),"med")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cin"),"cin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_mater"),"Zpet")); //pridame tlacitko zpet

SetLocalInt(OBJECT_SELF,"no_menu",86);
} //////////////////////////////////////////////

///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_proc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Pomer hlavniho materialu",no_oPC,FALSE );
no_reknimat(no_oPC);
///////////zjisitme lvl craftera
int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
if (no_level > 16) {
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_20"),"200%")); }//pridame tlacitko zpet
if (no_level > 13) {
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_18"),"180%")); }//pridame tlacitko zpet
if (no_level > 10) {
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_16"),"160%")); }//pridame tlacitko zpet
if (no_level > 7) {
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_14"),"140%")); }//pridame tlacitko zpet
if (no_level > 4) {
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_12"),"120%")); }//pridame tlacitko zpet

DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_10"),"100%")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_08"),"80%")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_06"),"60%")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_04"),"40%")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_02"),"20%")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_mater"),"Zpet")); //pridame tlacitko zpet

SetLocalInt(OBJECT_SELF,"no_menu",87);
} //////////////////////////////////////////////

if (GetTag(no_vzataItem) == "no_men_cin" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cin"),"cin")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",1);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",1);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz cin

if (GetTag(no_vzataItem) == "no_men_med" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_med"),"med")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz med
if (GetTag(no_vzataItem) == "no_men_bro" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_bro"),"vermajl")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",3);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",3);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz bro
if (GetTag(no_vzataItem) == "no_men_zel" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zel"),"zelezo")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz zelezo
if (GetTag(no_vzataItem) == "no_men_zla" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zla"),"zlato")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",5);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",5);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz zlato
if (GetTag(no_vzataItem) == "no_men_pla" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pla"),"platina")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz platina
if (GetTag(no_vzataItem) == "no_men_mit" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_mit"),"mithril")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",7);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",7);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz mithril
if (GetTag(no_vzataItem) == "no_men_ada" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ada"),"adamantin")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz adamantin
if (GetTag(no_vzataItem) == "no_men_tit" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tit"),"titan")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",9);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",9);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz titan
if (GetTag(no_vzataItem) == "no_men_str" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_str"),"stribro")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz stribro
if (GetTag(no_vzataItem) == "no_men_sti" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sti"),"stinova ocel")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",11);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",11);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz stinova ocel
if (GetTag(no_vzataItem) == "no_men_met" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_met"),"meteoriticka ocel")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
if (GetTag(no_vzataItem) == "no_men_20" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_20"),"200%")); //pridame tlacitko zpet
    SetLocalInt(OBJECT_SELF,"no_hl_proc",20);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno

if (GetTag(no_vzataItem) == "no_men_18" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_18"),"180%")); //pridame tlacitko zpet
    SetLocalInt(OBJECT_SELF,"no_hl_proc",18);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno

if (GetTag(no_vzataItem) == "no_men_16" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_16"),"160%")); //pridame tlacitko zpet
    SetLocalInt(OBJECT_SELF,"no_hl_proc",16);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno

if (GetTag(no_vzataItem) == "no_men_14" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_14"),"140%")); //pridame tlacitko zpet
    SetLocalInt(OBJECT_SELF,"no_hl_proc",14);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno

if (GetTag(no_vzataItem) == "no_men_12" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_12"),"120%")); //pridame tlacitko zpet
    SetLocalInt(OBJECT_SELF,"no_hl_proc",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno

if (GetTag(no_vzataItem) == "no_men_10" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_10"),"100%")); //pridame tlacitko zpet
    SetLocalInt(OBJECT_SELF,"no_hl_proc",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno

if (GetTag(no_vzataItem) == "no_men_08" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_08"),"80%")); //pridame tlacitko zpet

    SetLocalInt(OBJECT_SELF,"no_hl_proc",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if (GetTag(no_vzataItem) == "no_men_06" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_06"),"60%")); //pridame tlacitko zpet

    SetLocalInt(OBJECT_SELF,"no_hl_proc",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if (GetTag(no_vzataItem) == "no_men_04" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_04"),"40%")); //pridame tlacitko zpet

    SetLocalInt(OBJECT_SELF,"no_hl_proc",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if (GetTag(no_vzataItem) == "no_men_02" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_02"),"20%")); //pridame tlacitko zpet

    SetLocalInt(OBJECT_SELF,"no_hl_proc",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno


} //kdyz se z pece neco odstrani

////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
///doplnena perzistence 5.5.2014
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {

//Persist_SaveItemToDB(GetInventoryDisturbItem(), Persist_InitContainer(OBJECT_SELF));

}

}
