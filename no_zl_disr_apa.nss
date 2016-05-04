#include "ku_libtime"
#include "no_zl_functions"
#include "ku_persist_inc"
object no_Item;
object no_oPC;



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
/////////////////////////////////////////////////////////////////////////
void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z aparatu neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();

///doplnena perzistence 5.5.2014

            //    DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru



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
if (GetTag(no_vzataItem) == "no_vyr_prst" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);

FloatingTextStringOnCreature("Vyroba prstenu",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
DelayCommand(0.1,SetLocalInt(OBJECT_SELF,"no_menu",1));
} //////////////////////////////////////////////

/////////////////////////////2-NASTAVIT vyroba drevcovych zbrani/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_amul" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyroba amuletu",no_oPC,FALSE );
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"));
SetLocalInt(OBJECT_SELF,"no_menu",2);
} //////////////////////////////////////////////
//no_menu:
//1 - Vyroba prstenu      tag: no_vyr_prst
//2 - Vyroba amuletu      tag: no_vyr_amul
//9 - vyber  kamenu       tag: no_men_mater
//0  - Zpet do menu       tag: no_zpet

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
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_prst"),"Vyroba prstenu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_amul"),"Vyroba amuletu"));
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac002",OBJECT_SELF,1,"no_men_mater"),"Volba materialu pro vyrobu"));
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////////////////////////////


///////////////////////////////////////////////////////////
if (GetTag(no_vzataItem) == "no_men_hlmat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
FloatingTextStringOnCreature("Vyber hlavniho materialu",no_oPC,FALSE );
no_reknimat(no_oPC);
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
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_nef"),"nefrit")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_mal"),"malachit")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oha"),"ohnivy achat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ave"),"aventurin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_fen"),"fenelop")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ame"),"ametyst")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ziv"),"zivec")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_gra"),"granat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ale"),"alexandrit")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_top"),"topaz")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_saf"),"safir")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oho"),"ohnivy opal")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_dia"),"diamant")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rub"),"rubin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sma"),"smaragd")); //pridame tlacitko zpet

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
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_nef"),"nefrit")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_mal"),"malachit")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oha"),"ohnivy achat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ave"),"aventurin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_fen"),"fenelop")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ame"),"ametyst")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ziv"),"zivec")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_gra"),"granat")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ale"),"alexandrit")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_top"),"topaz")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_saf"),"safir")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oho"),"ohnivy opal")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_dia"),"diamant")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rub"),"rubin")); //pridame tlacitko zpet
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sma"),"smaragd")); //pridame tlacitko zpet

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
int no_level = TC_getLevel(no_oPC,TC_zlatnik);  // TC kovar = 33
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

if (GetTag(no_vzataItem) == "no_men_nef" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_nef"),"nefrit")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",1);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",1);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz cin

if (GetTag(no_vzataItem) == "no_men_mal" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_mal"),"malachit")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",2);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz med
if (GetTag(no_vzataItem) == "no_men_oha" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oha"),"ohnivy achat")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",3);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",3);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz bro
if (GetTag(no_vzataItem) == "no_men_ave" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ave"),"aventurin")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",4);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz zelezo
if (GetTag(no_vzataItem) == "no_men_fen" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_fen"),"fenelop")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",5);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",5);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz zlato
if (GetTag(no_vzataItem) == "no_men_ame" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ame"),"ametyst")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",6);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz platina
if (GetTag(no_vzataItem) == "no_men_ziv" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ziv"),"zivec")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",7);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",7);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz mithril
if (GetTag(no_vzataItem) == "no_men_gra" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_gra"),"granat")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",8);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz adamantin
if (GetTag(no_vzataItem) == "no_men_ale" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_ale"),"alexandrit")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",9);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",9);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz titan
if (GetTag(no_vzataItem) == "no_men_top" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_top"),"topaz")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",10);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz stribro
if (GetTag(no_vzataItem) == "no_men_saf" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_saf"),"safir")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",11);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",11);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz stinova ocel
if (GetTag(no_vzataItem) == "no_men_oho" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_oho"),"ohnivy opal")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",12);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_dia" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_dia"),"diamant")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",13);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",13);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_rub" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_rub"),"rubin")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",14);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",14);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
}// kdyz meteo ocel

if (GetTag(no_vzataItem) == "no_men_sma" ) {
no_znicit(no_oPC);
no_reopen(no_oPC);
DelayCommand(0.1,SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_men_sma"),"smaragd")); //pridame tlacitko zpet

if ( GetLocalInt(OBJECT_SELF,"no_menu") == 85 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_hl_mat",15);
    no_reknimat(no_oPC);  } // rekni, co je nastaveno
if ( GetLocalInt(OBJECT_SELF,"no_menu") == 86 ) //hlavni material
    { SetLocalInt(OBJECT_SELF,"no_ve_mat",15);
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




}
