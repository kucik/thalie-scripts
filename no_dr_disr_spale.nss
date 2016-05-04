#include "ku_libtime"
#include "no_dr_functions"

#include "ku_persist_inc"
object no_Item;
object no_oPC;



/////////////////////////
//no_menu:
//1 - sekani               tag:no_sekani
//2 - deska                tag:no_vyr_deska
//3 - lat                  tag:no_vyr_lat
//4 - nasada               tag:no_vyr_nasada
//0 - zpet na start        tag:no_zpet
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

/////////////////////////////1-NASTAVIT SEKANI/////////////////////////////////
if (GetTag(no_vzataItem) == "no_sekani" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Sekani dreva ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",1);
} ///////////////////////////KONEC NASTAVIT SEKANI////////////////////

/////////////////////////////2-NASTAVIT DESKA/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_deska" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Vyroba desek ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",2);
} ///////////////////////////KONEC NASTAVIT DESKA////////////////////


/////////////////////////////3-NASTAVIT LAT/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_lat" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Vyroba lati ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",3);
} ///////////////////////////KONEC NASTAVIT LAT////////////////////

/////////////////////////////4-NASTAVIT NASADA/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_nasada" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature(" Vyroba rukojeti ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",4);
} ///////////////////////////KONEC NASTAVIT NASADA///////////////////



/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_sekani"),"Sekani dreva ");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_deska"),"Vyroba desek");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_lat"),"Vyroba lati");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_nasada"),"Vyroba rukojeti");
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////KONEC NASTAVIT ZPET  /////////////////////////
} //kdyz se z pece neco odstrani



}
