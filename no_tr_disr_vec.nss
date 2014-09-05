#include "ku_libtime"
#include "no_tr_func_vec"
object no_Item;
object no_oPC;



/////////////////////////
//no_menu:
//1 - Vyroba kratkych luku       tag: no_vyr_krluk
//2 - Vyroba slouhych luku       tag: no_vyr_dlluk
//3 - Vyroba malych kusi         tag: no_vyr_mlkus
//4 - Vyroba velkych kusi        tag: no_vyr_vlkus
//5 - Vyroba sipu                tag: no_vyr_sip
//6 - Vyroba sipek               tag: no_vyr_sipka
///////////////////////23.brezen stity ///////////////////
//7 - Vyroba maleho stitu        tag: no_vyr_mstit
//8 - Vyroba velkeho   stitu     tag: no_vyr_vstit
//9 - Vyroba pavezy              tag: no_vyr_pstit
//0 - Zpet na start              tag:no_zpet
//
//////////////////////////

void main()
{
no_oPC=GetLastDisturbed();

////////////kdyz se z aparatu neco vezme/////////////////////////////////////////
if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_REMOVED) {
object no_vzataItem = GetInventoryDisturbItem();


/////////////////////////////1-NASTAVIT vyroba kratkych luku/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_krluk" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba kratkych luku",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",1);
} ///////////////////////////KONEC NASTAVIT sperk////////////////////

/////////////////////////////2-NASTAVIT vyroba slouhych luku/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_dlluk" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba dlouhych luku ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",2);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////

/////////////////////////////3-NASTAVIT malych kusi/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_mlkus" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba malych kusi ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",3);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////

/////////////////////////////4-NASTAVIT vyroba velkych kusi/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_vlkus" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba velkych kusi ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",4);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////

/////////////////////////////5-NASTAVIT vyrobaplastu/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_sip" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba sipu ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",5);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////

/////////////////////////////6-NASTAVIT vyroba rukavic/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_sipka" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba sipek ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",6);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////


/////////////////////////////7-NASTAVIT vyroba rukavic/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_mstit" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba maleho stitu ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",7);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////

/////////////////////////////8-NASTAVIT vyroba rukavic/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_vstit" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba velkeho stitu ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",8);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////

/////////////////////////////9-NASTAVIT vyroba rukavic/////////////////////////////////
if (GetTag(no_vzataItem) == "no_vyr_pstit" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac003",OBJECT_SELF,1,"no_zpet"),"Zpet"); //pridame tlacitko zpet
FloatingTextStringOnCreature("Vyroba pavezy ",no_oPC,FALSE );
SetLocalInt(OBJECT_SELF,"no_menu",9);
} ///////////////////////////KONEC NASTAVIT kamen////////////////////


/////////////////////////////0-NASTAVIT ZPET  /////////////////////////////////
if (GetTag(no_vzataItem) == "no_zpet" ) {
no_znicit(OBJECT_SELF); //znicime vsechny prepinace
no_znicit(no_oPC);
no_reopen(no_oPC);
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_krluk"),"Vyroba kratkych luku");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_dlluk"),"Vyroba dlouhych luku");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_mlkus"),"Vyroba malych kusi");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vlkus"),"Vyroba velkych kusi");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sip"),"Vyroba sipu");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_sipka"),"Vyroba sipek");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_mstit"),"Vyroba maleho stitu");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_vstit"),"Vyroba velkeho stitu");
SetName(CreateItemOnObject("prepinac001",OBJECT_SELF,1,"no_vyr_pstit"),"Vyroba pavezy");
SetLocalInt(OBJECT_SELF,"no_menu",0);
} ///////////////////////////KONEC NASTAVIT ZPET  /////////////////////////
} //kdyz se z pece neco odstrani



}

