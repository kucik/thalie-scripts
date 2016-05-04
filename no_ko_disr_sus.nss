#include "ku_libtime"
#include "no_ko_functions"

#include "ku_persist_inc"
//#include "no_ko_inc"
#include "no_nastcraft_ini"
object no_Item;
object no_oPC;




/////////////////////////
//no_menu:
//1 - suseni                tag:no_suseni
//2 - louhovani kozek       tag:no_louhovani
//3 - louhovani kuzi        tag: no_kozky
//0 - zpet na start         tag:no_zpet
//
//////////////////////////


void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z pece neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();


///doplnena perzistence 5.5.2014

             //   DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

/////////////////////////////1-NASTAVIT suseni/////////////////////////////////
if (GetTag(no_vzataItem) == "no_suseni" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Suseni kuzi ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",1);
} ///////////////////////////KONEC NASTAVIT suseni////////////////////

/////////////////////////////2-NASTAVIT louhovani kuzi/////////////////////////////////
if (GetTag(no_vzataItem) == "no_louhovani" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Vyroba kuzi ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",2);
} ///////////////////////////KONEC NASTAVIT moreni////////////////////

/////////////////////////////3-NASTAVIT louhovani kozek/////////////////////////////////
if (GetTag(no_vzataItem) == "no_kozky" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Vyroba kozek ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",3);
} ///////////////////////////KONEC NASTAVIT moreni////////////////////

/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_suseni"),"Suseni kuzi");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_louhovani"),"Vyroba kuzi");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_kozky"),"Vyroba kozek");
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////KONEC NASTAVIT ZPET  /////////////////////////

} //kdyz se z objektu neco vezme


//////////////////////nevim proc, ale proste mi nesel zavrit inv, tzn se dalo dat milion kuzi najednou.
///if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
///object no_vzataItem = GetInventoryDisturbItem();

///if (GetResRef(no_vzataItem) == "no_polot_ko") {
///ActionLockObject(OBJECT_SELF);
///AssignCommand(no_oPC,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE));
///AssignCommand(no_oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(OBJECT_SELF),no_oPC,1),PLACEABLE_ACTION_USE)));
///AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_delay));

///DelayCommand(no_delay,no_xp_kuze(no_oPC,OBJECT_SELF));
///DelayCommand(no_delay,ActionUnlockObject(OBJECT_SELF));
///}                          ////int ACTION_LOCK

///} ////kdz se neco da dovnitr


}
