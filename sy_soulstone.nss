//script sa spusti po aktivacii predmetu dusa bytosti TAG = sy_soul_stone

#include "ja_lib"
#include "ku_exp_inc"
#include "x2_inc_switches"



string sy_num_to_percent(string sText, float fMax, float fAkt, int nInvert = 0)
{
    float fPer = ( fAkt / fMax )*100;
    int   nPer = FloatToInt(fPer);
    if (nInvert==0) nPer = 100 - nPer;
    return (sText + IntToString(nPer) + " %");
}

//vypnuti ci zapnuti pro jednotlive zbrane
void ku_switch_weapon_effect(object oPC, string sWType)
{
 string sWeapString = GetLocalString(GetSoulStone(oPC),"KU_NODYNWEAPONSTR");
 if(GetStringLength(sWeapString) == 0)
   sWeapString = ";";

 int iStrPos = FindSubString(sWeapString,";"+sWType+";");
 if(iStrPos==-1) {
   sWeapString = sWeapString+sWType+";";
   SendMessageToPC(oPC,"Zakazal jsi pouziti efektu teto zbrane.");
//   SendMessageToPC(oPC,sWeapString);
   SetLocalString(GetSoulStone(oPC),"KU_NODYNWEAPONSTR",sWeapString);
   return;
 }
 else {
   sWeapString = GetStringLeft(sWeapString,iStrPos)+GetStringRight(sWeapString,GetStringLength(sWeapString) - iStrPos - GetStringLength(sWType) -1);
   SendMessageToPC(oPC,"Povolil jsi pouziti efektu teto zbrane.");
//   SendMessageToPC(oPC,sWeapString);
   SetLocalString(GetSoulStone(oPC),"KU_NODYNWEAPONSTR",sWeapString);
   return;
 }


}

void main()
{

    int nEvent = GetUserDefinedItemEventNumber();
    if (nEvent != X2_ITEM_EVENT_ACTIVATE) return;

    //pouzite kamena "Dusa bytosti"
    object oPC = GetItemActivator();
    object oItem = GetItemActivatedTarget();
    object oSoul = GetItemActivated();
    // Efekty zbrani
    if( (GetObjectType(oItem)==OBJECT_TYPE_ITEM) && (GetIsObjectValid(oItem)) ) {
      ku_switch_weapon_effect(oPC,IntToString(GetBaseItemType(oItem)));
      return;
    }

    // Nastavovani frakce
    if( GetIsPC(oItem) ) {
      SetLocalObject(oPC,"ku_soul_target",oItem);

    }


    SavePlayer(oPC);

    float fFoodR    = GetLocalFloat(oPC, "FoodRating");
    float fWaterR   = GetLocalFloat(oPC, "WaterRating");
    float fStaminaR = GetLocalFloat(oPC, "JA_STAMINA");
    float fMaxStamina = getMaxStamina(oPC);
    float fAlcoholR = GetLocalFloat(oPC, "AlcoholRating");
    SetCustomToken(7006, sy_num_to_percent("<c X >Hlad</c> : ", MAX_FOOD, fFoodR) );
    SetCustomToken(7007, sy_num_to_percent("<c XX>Zizen</c> : ", MAX_WATER, fWaterR) );
    SetCustomToken(7008, sy_num_to_percent("<cD c>Unava</c> : ", fMaxStamina, fStaminaR) );
    SetCustomToken(7009, sy_num_to_percent("<cX  >Alkohol</c> : ", MAX_ALCOHOL, fAlcoholR, 1) );

    AssignCommand(oPC, ActionStartConversation(oPC, "sy_soulstone", TRUE, FALSE));



    // docasne - pridani dalsi vlastnosti dusi
    itemproperty ipProp = GetFirstItemProperty(oSoul);
    while(GetIsItemPropertyValid(ipProp)) {
      if(GetItemPropertySubType(ipProp)==329)
        return;
      ipProp = GetNextItemProperty(oSoul);
    }

    ipProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE);
    AddItemProperty(DURATION_TYPE_PERMANENT,ipProp,oSoul);
//    ipProp = GetFirstItemProperty(nItem);
//    while(GetIsItemPropertyValid(ipProp)) {
//      if(GetItemPropertyType(ipProp) == ITEM_PROPERTY_CAST_SPELL)
}

