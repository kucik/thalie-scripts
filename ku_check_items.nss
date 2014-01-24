#include "ku_items_inc"

void maketest(object oItem);

void main()
{
  object oChest = OBJECT_SELF;

  object oItem = GetFirstItemInInventory(oChest);
  while(GetIsObjectValid(oChest)) {
    if(!GetLocalInt(oItem,"ku_testitem")) {
      maketest(oItem);
    }
    else {
      DestroyObject(oItem,0.5);
    }
    oItem = GetNextItemInInventory(oChest);
  }
}

void maketest(object oItem) {
  object oChest = OBJECT_SELF;
  string sResRef = GetResRef(oItem);
  string sProps;

  object oNew = CreateItemOnObject(sResRef,oChest);
  if(GetIsObjectValid(oNew)) {
    SetLocalInt(oNew,"ku_testitem",TRUE);
    SpeakString("Predmet "+GetName(oItem)+" ma svuj podklad v palete. Je treba zkontrolovat vlastnosti kontrolnich predmetu.");
    sProps = GetItemPropertiesString(oItem);
    SetName(oNew,GetName(oNew)+" (puvodni obraz)");
    SetIdentified(oNew,TRUE);
    //////////////

    oNew = CreateItemOnObject(sResRef,oChest);
    SetLocalInt(oNew,"ku_testitem",TRUE);
    ParseItemPropertiesString(oNew,sProps);
    SetName(oNew,GetName(oItem)+" (vysledne vlastnosti)");
    SetIdentified(oNew,TRUE);
  }
  else {
    SpeakString("Predmet "+GetName(oItem)+" muze byt vpusten do hry. Jeho predloha v palete neexistuje.");
    oNew = CreateItemOnObject(Persist_GetResRefByBaseType(GetBaseItemType(oItem)),oChest);
    SetLocalInt(oNew,"ku_testitem",TRUE);
    sProps = GetItemPropertiesString(oItem);
    ParseItemPropertiesString(oNew,sProps);
    SetName(oNew,GetName(oItem)+" (kontrolni predmet)");
    SetIdentified(oNew,TRUE);
  }
}
