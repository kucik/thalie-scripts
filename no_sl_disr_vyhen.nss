#include "ku_libtime"
#include "no_sl_functions"

#include "ku_persist_inc"
object no_Item;
object no_oPC;



/////////////////////////
//no_menu:
//1 - cistit                 tag:no_cistit
//2 - legovat                tag:no_legovat
//3 - slevat slitiny         tag:no_slevat
//0 - zpet na start          tag:no_zpet
//
//////////////////////////

void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z pece neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();


///doplnena perzistence 5.5.2014

            //    DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru


/////////////////////////////1-NASTAVIT CISTIT/////////////////////////////////
if (GetTag(no_vzataItem) == "no_cistit" ) {
TC_DestroyButtons(OBJECT_SELF); //znicime vsechny prepinace
TC_DestroyButtons(no_oPC);
TC_Reopen(no_oPC);
TC_MakeButton("no_zpet","Zpet",3); //pridame tlacitko zpet
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature("Do pece bude potreba pridat vice uhli",no_oPC,FALSE );
else FloatingTextStringOnCreature("Teplota v peci je nastavena na cisteni nugetu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",1);
} ///////////////////////////KONEC NASTAVIT CISTIT////////////////////

/////////////////////////////2-NASTAVIT LEGOVAT/////////////////////////////////
if (GetTag(no_vzataItem) == "no_legovat" ) {
TC_DestroyButtons(OBJECT_SELF); //znicime vsechny prepinace
TC_DestroyButtons(no_oPC);
TC_Reopen(no_oPC);
TC_MakeButton("no_zpet","Zpet",3); //pridame tlacitko zpet
if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
FloatingTextStringOnCreature("Do pece bude potreba pridat vice uhli",no_oPC,FALSE );
else FloatingTextStringOnCreature("Teplota v peci je nastavena na legovani kovu",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",2);
} ///////////////////////////KONEC NASTAVIT LEGOVAT////////////////////


/////////////////////////////3-NASTAVIT SLEVAT/////////////////////////////////
//if (GetTag(no_vzataItem) == "no_slevat" ) {
//TC_DestroyButtons(OBJECT_SELF); //znicime vsechny prepinace
//TC_DestroyButtons(no_oPC);
//TC_Reopen(no_oPC);
//SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
//if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") < ku_GetTimeStamp() )
//FloatingTextStringOnCreature("Do pece bude potreba pridat vice uhli",no_oPC,FALSE );
//else FloatingTextStringOnCreature("Teplota v peci je nastavena na slevani slitin",no_oPC,FALSE );
//SetLocalInt(OBJECT_SELF,"no_menu",3);
//} ///////////////////////////KONEC NASTAVIT SLEVAT////////////////////



/////////////////////////////4-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
TC_DestroyButtons(OBJECT_SELF); //znicime vsechny prepinace
TC_DestroyButtons(no_oPC);
TC_Reopen(no_oPC);
TC_MakeButton("no_cistit","Cistit kov");
TC_MakeButton("no_legovat","Legovat kov");
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////KONEC NASTAVIT ZPET  /////////////////////////
} //kdyz se z pece neco odstrani


/////////////Kdyz se do pece neco prida ///////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
object no_pridanaItem = GetInventoryDisturbItem();

//////////Kdyz se pridalo uhli////////////////////////////////////
if(GetTag(no_pridanaItem) == "cnrLumpOfCoal") no_pridatuhli(OBJECT_SELF);
//////////Konec uhli////////////////////////////////////////





}/////////  kdyz se do pece neco prida //////////////////////////////////


}
