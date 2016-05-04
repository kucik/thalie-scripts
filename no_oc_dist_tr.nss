//kvuli preotevirani a podobnym kravinam
#include "no_oc_func"
// kvuli lvlu kovare
#include "no_nastcraft_ini"
//kvuli lvlu kovare
#include "tc_xpsystem_inc"
#include "ku_persist_inc"
object no_Item;
object no_oPC;




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
//153 - odlehceny          tag_no_men_odl

void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z aparatu neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();


///doplnena perzistence 5.5.2014
//Persist_DeleteItemFromDB(GetInventoryDisturbItem());

///////////////////// kdyz se jedna o vec, co se ma vyrabet//////////////////////
//string no_menu_tagveci = GetStringRight(GetTag(no_vzataItem),6);
//no_menu_tagveci =  GetStringLeft(no_menu_tagveci,3);

if (GetStringLeft( GetStringRight(GetTag(no_vzataItem),6),3) == "vyr" ) {
no_reknimat(no_oPC);
SetLocalString (OBJECT_SELF,"no_menu",GetStringRight(GetTag(no_vzataItem),3) );
// SendMessageToPC(no_oPC,"Material co vyrabim je: " + GetLocalString(OBJECT_SELF,"no_menu"));
 }

///////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////1-NASTAVIT vyroba cepelovych zbrani/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_zbran" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
no_reknimat(no_oPC);
FloatingTextStringOnCreature("Ocarovavani zbrani",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
DelayCommand(0.1,SetLocalInt(OBJECT_SELF,"no_menu",1));
} //////////////////////////////////////////////


/////////////////////////////9-NASTAVIT volba materialu/////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_mater" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
//no_reknimat(no_oPC);
FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_hlmat"),"Vyber hlavniho ocarovani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_vemat"),"Vyber vedlejsiho ocarovani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_proc"),"Urci pomer ocarovani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",9);
} ////////////////////////////////////////////


/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_zbran"),"Ocarovavani zbrani"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba ocarovani pro vyrobu"));
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////////////////////////////

///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_hlmat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyber hlavniho ocarovani",no_oPC,FALSE );
no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_kys"),"kyselina")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ele"),"elektrina")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ohe"),"ohen")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_chl"),"chlad")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zvu"),"zvuk")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ost"),"ostrost")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_drz"),"drzeni")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_hlu"),"hluchota")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oma"),"omameni")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tic"),"ticho")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_str"),"strach")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zne"),"zhouba nemrtvych")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zob"),"zhouba obru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zdr"),"zhouba draku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zor"),"zhouba orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zje"),"zhouba jesteru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zvi"),"zhouba zvirat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zsl"),"zhouba slizu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zsk"),"zhouba skretu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zod"),"zhouba odchylek")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zme"),"zhouba menavcu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pne"),"poprava nemrtvych")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pob"),"poprava obru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pdr"),"poprava draku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_por"),"poprava orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pje"),"poprava jesteru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pvi"),"poprava zvirat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_psl"),"poprava slizu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_psk"),"poprava skretu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pod"),"poprava odchylek")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pme"),"poprava menavcu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sva"),"svaty")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_bez"),"bezbozny")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cha"),"chaoticky")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zak"),"zakonny")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_upi"),"upiri")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_vyb"),"vlastenec")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zra"),"zranujici")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rus"),"rusici")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jst"),"jed orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jiq"),"jed magu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jwi"),"jed knezu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jch"),"jed assimaru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jde"),"jed elfu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jco"),"jed gnomu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_osl"),"osalbujici")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rst"),"prokleti orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_riq"),"prokleti magu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rwi"),"prokleti knezu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rch"),"prokleti assimaru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rde"),"prokleti elfu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rco"),"prokleti gnomu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_odl"),"odlehceny")); //pridame tlacitko zpet

DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_mater"),"Zpet")); //pridame tlacitko zpet

SetLocalInt(OBJECT_SELF,"no_menu",85);
} //////////////////////////////////////////////

///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_vemat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyber vedlejsiho ocarovani",no_oPC,FALSE );
no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_kys"),"kyselina")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ele"),"elektrina")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ohe"),"ohen")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_chl"),"chlad")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zvu"),"zvuk")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ost"),"ostrost")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_drz"),"drzeni")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_hlu"),"hluchota")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oma"),"omameni")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tic"),"ticho")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_str"),"strach")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zne"),"zhouba nemrtvych")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zob"),"zhouba obru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zdr"),"zhouba draku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zor"),"zhouba orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zje"),"zhouba jesteru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zvi"),"zhouba zvirat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zsl"),"zhouba slizu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zsk"),"zhouba skretu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zod"),"zhouba odchylek")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zme"),"zhouba menavcu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pne"),"poprava nemrtvych")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pob"),"poprava obru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pdr"),"poprava draku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_por"),"poprava orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pje"),"poprava jesteru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pvi"),"poprava zvirat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_psl"),"poprava slizu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_psk"),"poprava skretu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pod"),"poprava odchylek")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pme"),"poprava menavcu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sva"),"svaty")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_bez"),"bezbozny")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cha"),"chaoticky")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zak"),"zakonny")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_upi"),"upiri")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_vyb"),"vlastenec")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zra"),"zranujici")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rus"),"rusici")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jst"),"jed orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jiq"),"jed magu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jwi"),"jed knezu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jch"),"jed assimaru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jde"),"jed elfu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jco"),"jed gnomu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_osl"),"osalbujici")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rst"),"prokleti orku")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_riq"),"prokleti magu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rwi"),"prokleti knezu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rch"),"prokleti assimaru")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rde"),"prokleti elfu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rco"),"prokleti gnomu")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_odl"),"odlehceny")); //pridame tlacitko zpet

DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_men_mater"),"Zpet")); //pridame tlacitko zpet

SetLocalInt(OBJECT_SELF,"no_menu",86);
} //////////////////////////////////////////////

///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_proc" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Pomer hlavniho ocarovani",no_oPC,FALSE );
no_reknimat(no_oPC);
///////////zjisitme lvl craftera
int no_level = TC_getLevel(no_oPC,TC_ocarovavac);  // TC kovar = 33
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


if (GetTag(no_vzataItem) == "no_men_kys" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_kys"),"kyselina")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",1);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",1);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz cin

if (GetTag(no_vzataItem) == "no_men_ele" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ele"),"elektrina")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz med
if (GetTag(no_vzataItem) == "no_men_ohe" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ohe"),"ohen")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",3);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",3);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz bro
if (GetTag(no_vzataItem) == "no_men_chl" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_chl"),"chlad")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz zelezo
if (GetTag(no_vzataItem) == "no_men_zvu" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zvu"),"zvuk")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",5);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",5);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz zlato
if (GetTag(no_vzataItem) == "no_men_ost" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ost"),"ostrost")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz platina
if (GetTag(no_vzataItem) == "no_men_drz" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_drz"),"drzeni")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",7);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",7);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz mithril
if (GetTag(no_vzataItem) == "no_men_hlu" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_hlu"),"hluchota")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz adamantin
if (GetTag(no_vzataItem) == "no_men_oma" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oma"),"omameni")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",9);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",9);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz titan
if (GetTag(no_vzataItem) == "no_men_tic" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_tic"),"ticho")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz stribro
if (GetTag(no_vzataItem) == "no_men_str" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_str"),"strach")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",11);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",11);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz stinova ocel
if (GetTag(no_vzataItem) == "no_men_zne" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zne"),"zhouba nemrtvych")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_zob" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zob"),"zhouba obru")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",13);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",13);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zdr" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zdr"),"zhouba draku")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",14);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",14);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zor" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zor"),"zhouba orku")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",15);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",15);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zje" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zje"),"zhouba jesteru")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",16);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",16);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zvi" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zvi"),"zhouba zvirat")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",17);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",17);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zsl" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zsl"),"zhouba slizu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",18);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",18);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zsk" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zsk"),"zhouba skretu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",19);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",19);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zod" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zod"),"zhouba odchylek")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",20);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",20);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zme" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zme"),"zhouba menavcu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",21);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",21);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_pne" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pne"),"poprava nemrtvych")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",22);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",22);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_pob" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pob"),"poprava obru")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",23);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",23);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_pdr" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pdr"),"poprava draku")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",24);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",24);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_por" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_por"),"poprava orku")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",25);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",25);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_pje" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pje"),"poprava jesteru")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",26);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",26);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_pvi" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pvi"),"poprava zvirat")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",27);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",27);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_psl" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_psl"),"poprava slizu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",28);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",28);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_psk" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_psk"),"poprava skretu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",29);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",29);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_pod" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pod"),"poprava odchylek")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",30);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",30);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_pme" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_pme"),"poprava menavcu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",31);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",31);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_sva" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sva"),"svaty")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",32);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",32);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_bez" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_bez"),"bezbozny")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",33);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",33);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_cha" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_cha"),"chaoticky")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",34);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",34);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zak" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zak"),"zakonny")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",35);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",35);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_upi" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_upi"),"upiri")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",36);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",36);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_vyb" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_vyb"),"vlastenec")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
   { SetLocalInt(OBJECT_SELF,"no_hl_mat",37);
   no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",37);
   no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_zra" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_zra"),"zranujici")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",38);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",38);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_rus" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rus"),"rusici")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",39);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",39);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_jst" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jst"),"jed orku")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",40);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",40);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_jiq" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jiq"),"jed magu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",41);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",41);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_jwi" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jwi"),"jed knezu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",42);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",42);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_jch" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jch"),"jed assimaru")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",43);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",43);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_jde" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jde"),"jed elfu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",44);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",44);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_jco" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_jco"),"jed gnomu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",45);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",45);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_osl" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_osl"),"oslabujici")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",46);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",46);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_rst" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rst"),"prokleti orku")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",47);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",47);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_riq" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_riq"),"prokleti magu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",48);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",48);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_rwi" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rwi"),"prokleti knezu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",49);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",49);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_rch" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rch"),"prokleti assimaru")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",50);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",50);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_rde" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rde"),"prokleti elfu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",51);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",51);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel
if (GetTag(no_vzataItem) == "no_men_rco" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rco"),"prokleti gnomu")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",52);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",52);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_odl" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_odl"),"odlehceny")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",53);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",53);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel



} //kdyz se z pece neco odstrani



}
