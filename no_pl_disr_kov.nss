//kvuli preotevirani a podobnym kravinam
#include "no_pl_func"
// kvuli lvlu kovare
//#include "no_pl_inc"
#include "no_nastcraft_ini"
//kvuli lvlu kovare
#include "tc_xpsystem_inc"

#include "ku_persist_inc"
object no_Item;
object no_oPC;


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
//11 - zmena vzhledu helmy tag: no_vzhled_helm
//0  - Zpet do menu        tag: no_zpet
//


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
SetLocalString (OBJECT_SELF,"no_menu",GetStringRight(GetTag(no_vzataItem),2) );
// SendMessageToPC(no_oPC,"Material co vyrabim je: " + GetLocalString(OBJECT_SELF,"no_menu"));
 }

///////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////Krouzkova kosile - zakladni obranne cislo 4/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_krouz" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba krouzkove kosile",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
DelayCommand(0.1,SetLocalInt(OBJECT_SELF,"no_menu",1));
} //////////////////////////////////////////////

/////////////////////////////Hrudn pancir - Zakladni obranne cislo 5/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_hrudn" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba hrudniho pancire",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",2);
} //////////////////////////////////////////////

/////////////////////////////Destickova zbroj - zakladni obranne cislo 6/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_desti" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba destikove zbroje",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",3);
} //////////////////////////////////////////////

/////////////////////////////Polovicni platova zbroj- zakladni obranne cislo 7/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_pulpl" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba polovicni platove zbroje",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",4);
} /////////////////////////////////////////////

/////////////////////////////Plnopatova zbroj - zakladni obranne cislo 8/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_plnpl" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba plne platove zbroje",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",5);
} ////////////////////////////////////////

/////////////////////////////Helma /////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_helma" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba helmy",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",6);
} //////////////////////////////////////////

/////////////////////////////7-NASTAVIT vyroba okovanychbot/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_okbot" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba okovanych bot",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",7);
} //////////////////////////////////////////

/////////////////////////////8-NASTAVIT vyroba okovanycrukavic/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_okruk" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba okovanych rukavic",no_oPC,FALSE );
    no_reknimat(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",8);
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

//////////////////////////////10 - zmena vzhledu stitu tag: no_vzhled_stit/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vzhled_stit" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
//no_reknimat(no_oPC);
//FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );



SetLocalInt (OBJECT_SELF, "no_stit_typ",0);
SetLocalInt (OBJECT_SELF, "no_puvodni_vzhled_stitu",0);
object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",1);
if (GetBaseItemType(oItem) ==BASE_ITEM_LARGESHIELD) SetLocalInt (OBJECT_SELF, "no_stit_typ",2);
if (GetBaseItemType(oItem) ==BASE_ITEM_TOWERSHIELD)  SetLocalInt (OBJECT_SELF, "no_stit_typ",3);

//timhle si ulozime stit primo k prekupnikovi
if (GetLocalInt(OBJECT_SELF,"no_stit_typ") >0 )   {

if ( GetIsObjectValid(oItem) == TRUE )     {
int no_apperance = GetItemAppearance(oItem,0,0);
SetLocalInt(OBJECT_SELF,"no_puvodni_vzhled_stitu",no_apperance);

FloatingTextStringOnCreature(" Stit ulozen se vzhledem : " +IntToString(no_apperance) ,no_oPC,FALSE);
//jeste ulozime objekt, kdyby byl neplatny vzhled stitu !
SetLocalObject(OBJECT_SELF, "no_" + GetName( GetPCSpeaker()) ,oItem);
}

}
if ( GetIsObjectValid(oItem) == FALSE )  FloatingTextStringOnCreature(" Neplatny objekt v leve ruce ! " ,GetPCSpeaker() ,FALSE);


DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_dals"),"Dalsi vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_pred"),"Predchozi vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_puvo"),"Puvodni vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_zapa"),"Zapamatovat vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",10);
} ////////////////////////////////////////////



//////////////////////////////11 - zmena vzhledu helmy tag: no_vzhled_helm/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vzhled_helm" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
//no_reknimat(no_oPC);
//FloatingTextStringOnCreature("Volba materialu pro vyrobu",no_oPC,FALSE );



SetLocalInt (OBJECT_SELF, "no_helm_typ",0);
SetLocalInt (OBJECT_SELF, "no_puvodni_vzhled_helm",0);
object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,no_oPC);

if (GetBaseItemType(oItem) == BASE_ITEM_HELMET) SetLocalInt (OBJECT_SELF, "no_helm_typ",1);


//timhle si ulozime stit primo k prekupnikovi
if (GetLocalInt(OBJECT_SELF,"no_helm_typ") >0 )   {

if ( GetIsObjectValid(oItem) == TRUE )     {
int no_apperance = GetItemAppearance(oItem,0,0);
SetLocalInt(OBJECT_SELF,"no_puvodni_vzhled_helm",no_apperance);

FloatingTextStringOnCreature(" helma ulozena se vzhledem : " +IntToString(no_apperance) ,no_oPC,FALSE);
//jeste ulozime objekt, kdyby byl neplatny vzhled stitu !
SetLocalObject(OBJECT_SELF, "no_" + GetName( GetPCSpeaker()) ,oItem);
}

}
if ( GetIsObjectValid(oItem) == FALSE )  FloatingTextStringOnCreature(" Neplatny objekt na hlave ! " ,GetPCSpeaker() ,FALSE);


DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_dals"),"Dalsi vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_pred"),"Predchozi vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_puvo"),"Puvodni vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_zapa"),"Zapamatovat vzhled"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",11);
} ////////////////////////////////////////////

/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_krouz"),"Krouzkova kosile"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_hrudn"),"Hrudni pancir"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_desti"),"Destickova zbroj"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pulpl"),"Pulovicni platova zbroj"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_plnpl"),"Plna platova zbroj"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_helma"),"Helma"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_okbot"),"Okovane boty"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_okruk"),"Okovane rukavice"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba materialu pro vyrobu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_vzhled_stit"),"Zmena vzhledu stitu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_vzhled_helm"),"Zmena vzhledu helmy"));
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////////////////////////////

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
int no_level = TC_getLevel(no_oPC,TC_platner);  // TC kovar = 33
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


if (GetTag(no_vzataItem) == "no_vzhled_dals") {
no_men_vzhled_dalsi(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_dals"),"Dalsi vzhled")); //pridame tlacitko zpet

}
if (GetTag(no_vzataItem) == "no_vzhled_pred") {
no_men_vzhled_predchozi(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_pred"),"Predchozi vzhled")); //pridame tlacitko zpet

}
if (GetTag(no_vzataItem) == "no_vzhled_puvo") {
no_men_vzhled_puvodni(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_puvo"),"Puvodni vzhled")); //pridame tlacitko zpet
}
if (GetTag(no_vzataItem) == "no_vzhled_zapa") {
no_men_vzhled_zapamatovat(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_zapa"),"Zapamatovat vzhled")); //pridame tlacitko zpet
}



//////////helmy //////////
if (GetTag(no_vzataItem) == "no_vzhled_helm_dals") {
no_men_vzhled_helm_dalsi(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_dals"),"Dalsi vzhled")); //pridame tlacitko zpet

}
if (GetTag(no_vzataItem) == "no_vzhled_helm_pred") {
no_men_vzhled_helm_predchozi(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_pred"),"Predchozi vzhled")); //pridame tlacitko zpet

}
if (GetTag(no_vzataItem) == "no_vzhled_helm_puvo") {
no_men_vzhled_helm_puvodni(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_puvo"),"Puvodni vzhled")); //pridame tlacitko zpet
}
if (GetTag(no_vzataItem) == "no_vzhled_helm_zapa") {
no_men_vzhled_helm_zapamatovat(no_oPC);
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vzhled_helm_zapa"),"Zapamatovat vzhled")); //pridame tlacitko zpet
}
//////konec helmy ////////////

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
/*if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {

Persist_SaveItemToDB(GetInventoryDisturbItem(), Persist_InitContainer(OBJECT_SELF));

} */


}
