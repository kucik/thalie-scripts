#include "ku_libtime"
#include "no_br_functions"

#include "ku_persist_inc"
object no_Item;
object no_oPC;



/////////////////////////
//no_menu:
//1 - brouseni               tag:no_brouseni
//2 - lesteni                tag:no_lesteni
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

              //  DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

/////////////////////////////1-NASTAVIT brouseni/////////////////////////////////
if (GetTag(no_vzataItem) == "no_brouseni" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Brouseni ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",1);
} ///////////////////////////KONEC NASTAVIT brouseni////////////////////

/////////////////////////////2-NASTAVIT lesteni/////////////////////////////////
if (GetTag(no_vzataItem) == "no_lesteni" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Lesteni ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",2);
} ///////////////////////////KONEC NASTAVIT lesteni////////////////////



/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_brouseni"),"Brouseni kamenu ");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_lesteni"),"Lesteni kamenu");

SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////KONEC NASTAVIT ZPET  /////////////////////////
} //kdyz se z pece neco odstrani




}
