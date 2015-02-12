//skript pro odkooupeni veci

#include "ku_libtime"

const int ItemMaxAge = 129600; // 36hours in seconds

int CheckItem(object oItem, string sResref) {

/*  if(GetResRef(oItem) != sResref) { // Check item resref
    return FALSE;
  }*/

  int iStamp = GetLocalInt(oItem,"TROFEJ_TIMESTAMP");

  if(iStamp + ItemMaxAge <  ku_GetTimeStamp() ) { // Check if trophy isn't too old
    return FALSE;
  }

  return TRUE;

}

void main()
{
  object oPC = GetPCSpeaker();

  string sName = GetLocalString(OBJECT_SELF,"lovec_q_qname");
  string sTag = GetLocalString(OBJECT_SELF,"lovec_q_qtag");
  string sTrofName = GetLocalString(OBJECT_SELF,"lovec_q_qtrofnanem");

  if(GetStringLength(sTag) == 0) {
    SpeakString("Neni vypsana zadna odmena ");
    return;
  }



/*  no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");//nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");*/


  object oItem = GetFirstItemInInventory(oPC);  //pro kazde zavolani skriptu zacne od zacatku
                                            // DULEZITE!!! jinak se provede skript jednou a pamatuje si hodnotu itemu
                                            // nafurt i kdyz item nenajde..

  while(GetIsObjectValid(oItem))  {
    if(GetResRef(oItem) == sTag || GetTag(oItem) == sTag)
      break;
    oItem = GetNextItemInInventory(oPC);
  }
//takze projede vsechno a skonci bud pokud najde vec co je nastavena na postave, nebo pokud prohleda vsechno
  if (!GetIsObjectValid(oItem)) {
    SpeakString( " Je mi lito, ale toto neni "+sTrofName+".");
    return;
  }

  if (!CheckItem(oItem, sTag)) {
    SpeakString( "Trofej "+GetName(oItem)+" je prilis stara. Jak dlouho jsi to s sebou vlacel? To uz ti nevezmu.");
    return;
  }



  int cnt=0;
  if (GetIsObjectValid(oItem)) {


    int price = GetLocalInt(oItem,"TROFEJ");
    if(price == 0)
      price = 5;

/*    int stacksize = GetItemStackSize(oItem);      //zjisti kolik je toho ve stacku

    if (no_pocet>no_stacksize)   no_pocet=no_stacksize;
    if (no_pocet<no_stacksize)   no_pocet= no_pocet;
*/
    price=price*4; //cena 4x vetsi    // pokyn Rejtyho 7.srpen
/*    no_nazev = IntToString(price);
    no_pomocna = IntToString(no_pocet);*/

/// no_ 25 zari///
    cnt = GetItemStackSize(oItem);

    GiveGoldToCreature(oPC, cnt*price); //vykoupi 4x draze, nez normalne
    DestroyObject(oItem);
    SpeakString( " Dekuji. Kdyztak se zase nekdy zastav, mozna pro tebe budu mit i jinou praci. " );

    //remove quest
    SetLocalInt(OBJECT_SELF,"lovec_q_qid",0);
    SetLocalString(OBJECT_SELF,"lovec_q_qname","");
    SetLocalString(OBJECT_SELF,"lovec_q_qtag","");
    SetLocalInt(OBJECT_SELF,"lovec_q_lastquest",ku_GetTimeStamp());
  }
}




