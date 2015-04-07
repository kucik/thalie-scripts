/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_bash_onused
//
//  Desc:  When a player uses a placeable, begin bashing it.
//
//  Author: David Bobeck 03Feb03
//
/////////////////////////////////////////////////////////

/*
v cnr_gemdep_ou a

*/
#include "cnr_persist_inc"
#include "nw_i0_generic"
#include "nwnx_funcs"
#include "ku_libtime"

// Metal and coal
const int CNR_RESOURCE_MIN_METAL = 1; //category marker
const int CNR_RESOURCE_COAL = 1;
const int CNR_RESOURCE_TIN  = 2;
const int CNR_RESOURCE_COPPER = 3;
const int CNR_RESOURCE_VERMAIL = 4;
const int CNR_RESOURCE_IRON = 5;
const int CNR_RESOURCE_GOLD = 6;
const int CNR_RESOURCE_PLATINUM = 7;
const int CNR_RESOURCE_MITHRIL = 8;
const int CNR_RESOURCE_ADAMANTIN = 9;
const int CNR_RESOURCE_TITAN = 10;
const int CNR_RESOURCE_SILVER = 11;
const int CNR_RESOURCE_STINOVKA = 12;
const int CNR_RESOURCE_METEORIT = 13;
const int CNR_RESOURCE_MAX_METAL = 13; //category marker

// Minerals
const int CNR_RESOURCE_MIN_MINERAL = 21; //category marker
const int CNR_RESOURCE_NEFRIT = 21;
const int CNR_RESOURCE_MALACHIT = 22;
const int CNR_RESOURCE_ACHAT = 23;
const int CNR_RESOURCE_AVENTURIN = 24;
const int CNR_RESOURCE_FENALOP = 25;
const int CNR_RESOURCE_AMETYST = 26;
const int CNR_RESOURCE_ZIVEC = 27;
const int CNR_RESOURCE_GRANAT = 28;
const int CNR_RESOURCE_ALEXANDRIT = 29;
const int CNR_RESOURCE_TOPAZ = 30;
const int CNR_RESOURCE_SAFIR = 31;
const int CNR_RESOURCE_OPAL = 32;
const int CNR_RESOURCE_DIAMANT = 33;
const int CNR_RESOURCE_RUBIN = 34;
const int CNR_RESOURCE_SMARAGD = 35;
const int CNR_RESOURCE_MAX_MINERAL = 35; //category marker

// Wood
const int CNR_RESOURCE_MIN_WOOD = 41; //category marker
const int CNR_RESOURCE_OAK = 41;
const int CNR_RESOURCE_MAHAGON = 42;
const int CNR_RESOURCE_HICKORY = 43;
const int CNR_RESOURCE_VRBA = 44;
const int CNR_RESOURCE_TIS = 45;
const int CNR_RESOURCE_JILM = 46;
const int CNR_RESOURCE_ZELEZNY = 47;
const int CNR_RESOURCE_PRADUB = 48;

void CheckAction(object oPC, object oSelf);
void CreateAnObject(string sResource, object oPC);
void ReplaceSelf(object oSelf, string sAppearance);
void CreateNew(location lSelf, string sResSelf, int iAppearance, string sTag);
void CreatePlaceable(string sObject, location lPlace, float fDuration);

void RemoveEffects(object oPC);
void CallEnemyCreatures(object oPC);


int __getResourceID(string sTag) {

  // Coal
  if(sTag == "cnrDepositCoal" ) return CNR_RESOURCE_COAL;

  // Metal
  if(GetStringLeft(sTag,7) == "cnrRock") {
    if(sTag == "cnrRockTin") return CNR_RESOURCE_TIN;
    if(sTag == "cnrRockCopp") return CNR_RESOURCE_COPPER;
    if(sTag == "cnrRockVerm") return CNR_RESOURCE_VERMAIL;
    if(sTag == "cnrRockIron") return CNR_RESOURCE_IRON;
    if(sTag == "cnrRockGold") return CNR_RESOURCE_GOLD;
    if(sTag == "cnrRockPlat") return CNR_RESOURCE_PLATINUM;
    if(sTag == "cnrRockMith") return CNR_RESOURCE_MITHRIL;
    if(sTag == "cnrRockAdam") return CNR_RESOURCE_ADAMANTIN;
    if(sTag == "cnrRockTita") return CNR_RESOURCE_TITAN;
    if(sTag == "cnrRockSilv") return CNR_RESOURCE_SILVER;
    if(sTag == "cnrRockStin") return CNR_RESOURCE_STINOVKA;
    if(sTag == "cnrRockMete") return CNR_RESOURCE_METEORIT;
  }

  // Minerals
  if(GetStringLeft(sTag,13) == "cnrGemDeposit") {
    int iGem = StringToInt(GetStringRight(sTag,3));
    switch(iGem) {
      case 1:  return CNR_RESOURCE_NEFRIT;
      case 2:  return CNR_RESOURCE_MALACHIT;
      case 7:  return CNR_RESOURCE_ACHAT;
      case 14:  return CNR_RESOURCE_AVENTURIN;
      case 4:  return CNR_RESOURCE_FENALOP;
      case 3:  return CNR_RESOURCE_AMETYST;
      case 15:  return CNR_RESOURCE_ZIVEC;
      case 11:  return CNR_RESOURCE_GRANAT;
      case 13:  return CNR_RESOURCE_ALEXANDRIT;
      case 10:  return CNR_RESOURCE_TOPAZ;
      case 8:  return CNR_RESOURCE_SAFIR;
      case 9:  return CNR_RESOURCE_OPAL;
      case 5:  return CNR_RESOURCE_DIAMANT;
      case 6:  return CNR_RESOURCE_RUBIN;
      case 12:  return CNR_RESOURCE_SMARAGD;
      default: return -1;
    }
  }

  // Wood
  if(GetStringLeft(sTag,7) == "cnrTree") {
    if(sTag == "cnrTreeOak") return CNR_RESOURCE_OAK;
    if(sTag == "cnrTreeMahogany") return CNR_RESOURCE_MAHAGON;
    if(sTag == "cnrTreeHickory") return CNR_RESOURCE_HICKORY;
    if(sTag == "cnrTreeVrba") return CNR_RESOURCE_VRBA;
    if(sTag == "cnrTreeTis") return CNR_RESOURCE_TIS;
    if(sTag == "cnrTreeJil") return CNR_RESOURCE_JILM;
    if(sTag == "cnrTreeZel") return CNR_RESOURCE_ZELEZNY;
    if(sTag == "cnrTreePra") return CNR_RESOURCE_PRADUB;
  }

  return -1;
}

int __getDigAmmount(int iResource) {

  // All resources same
  return d4(2);

  switch(iResource) {
    // Coal
    case CNR_RESOURCE_COAL: return 10+d10(2);
    // Metal
    case CNR_RESOURCE_TIN:
    case CNR_RESOURCE_COPPER:
    case CNR_RESOURCE_VERMAIL: return 6+d10(1);
    case CNR_RESOURCE_IRON:
    case CNR_RESOURCE_GOLD: return 3+d10(1);
    case CNR_RESOURCE_PLATINUM: return 3+d8(1);
    case CNR_RESOURCE_MITHRIL: return 2+d8(1);
    case CNR_RESOURCE_ADAMANTIN: return 2+d6(1);
    case CNR_RESOURCE_TITAN: return 1+d6(1);
    case CNR_RESOURCE_SILVER: return 1+d4(1);
    case CNR_RESOURCE_STINOVKA: return 1+d4(1);
    case CNR_RESOURCE_METEORIT: return 1;
    // Mineral
    case CNR_RESOURCE_NEFRIT:
    case CNR_RESOURCE_MALACHIT:
    case CNR_RESOURCE_ACHAT: return 6+d10(2);
    case CNR_RESOURCE_AVENTURIN:
    case CNR_RESOURCE_FENALOP:
    case CNR_RESOURCE_AMETYST: return 6+d10(1);
    case CNR_RESOURCE_ZIVEC:
    case CNR_RESOURCE_GRANAT: return 3+d10(1);
    case CNR_RESOURCE_ALEXANDRIT:
    case CNR_RESOURCE_TOPAZ: return 2+d8(1);
    case CNR_RESOURCE_SAFIR:
    case CNR_RESOURCE_OPAL: return 1+d6(1);
    case CNR_RESOURCE_DIAMANT:
    case CNR_RESOURCE_RUBIN: return 1+d4(1);
    case CNR_RESOURCE_SMARAGD: return 1;
    // Wood
    case CNR_RESOURCE_OAK: return 6+d10(2);
    case CNR_RESOURCE_MAHAGON: return 6+d10(1);
    case CNR_RESOURCE_HICKORY: return 4+d10(1);
    case CNR_RESOURCE_VRBA: return 3+d8(1);
    case CNR_RESOURCE_TIS: return 2+d6(1);
    case CNR_RESOURCE_JILM: return 1+d4(1);
    case CNR_RESOURCE_ZELEZNY: return 0+d4(1);
    case CNR_RESOURCE_PRADUB: return 0;
  }

  return 0;
}

string __getResourceItem(int iResource) {

  switch(iResource) {
    // Coal
    case CNR_RESOURCE_COAL: return "cnrLumpOfCoal";
    // Metal
    case CNR_RESOURCE_TIN: return "cnrNuggetTin";
    case CNR_RESOURCE_COPPER: return "cnrNuggetCopp";
    case CNR_RESOURCE_VERMAIL: return "cnrNuggetVerm";
    case CNR_RESOURCE_IRON: return "cnrNuggetIron";
    case CNR_RESOURCE_GOLD: return "cnrNuggetGold";
    case CNR_RESOURCE_PLATINUM: return "cnrNuggetPlat";
    case CNR_RESOURCE_MITHRIL: return "cnrNuggetMith";
    case CNR_RESOURCE_ADAMANTIN: return "cnrNuggetAdam";
    case CNR_RESOURCE_TITAN: return "cnrNuggetTita";
    case CNR_RESOURCE_SILVER: return "cnrNuggetSilv";
    case CNR_RESOURCE_STINOVKA: return "tc_nug_stin";
    case CNR_RESOURCE_METEORIT: return "tc_nug_meteor";
    // Mineral
    case CNR_RESOURCE_NEFRIT: return "cnrGemMineral001";
    case CNR_RESOURCE_MALACHIT: return "cnrGemMineral002";
    case CNR_RESOURCE_ACHAT: return "cnrGemMineral007";
    case CNR_RESOURCE_AVENTURIN: return "cnrGemMineral014";
    case CNR_RESOURCE_FENALOP: return "cnrGemMineral004";
    case CNR_RESOURCE_AMETYST: return "cnrGemMineral003";
    case CNR_RESOURCE_ZIVEC: return "cnrGemMineral015";
    case CNR_RESOURCE_GRANAT: return "cnrGemMineral011";
    case CNR_RESOURCE_ALEXANDRIT: return "cnrGemMineral013";
    case CNR_RESOURCE_TOPAZ: return "cnrGemMineral010";
    case CNR_RESOURCE_SAFIR: return "cnrGemMineral008";
    case CNR_RESOURCE_OPAL: return "cnrGemMineral009";
    case CNR_RESOURCE_DIAMANT: return "cnrGemMineral005";
    case CNR_RESOURCE_RUBIN: return "cnrGemMineral006";
    case CNR_RESOURCE_SMARAGD: return "cnrGemMineral012";
    // Wood
    case CNR_RESOURCE_OAK: return "cnrBranchOak";
    case CNR_RESOURCE_MAHAGON: return "cnrBranchMah";
    case CNR_RESOURCE_HICKORY: return "cnrBranchHic";
    case CNR_RESOURCE_VRBA: return "tc_drev_vrb";
    case CNR_RESOURCE_TIS: return "tc_drev_tis";
    case CNR_RESOURCE_JILM: return "tc_drev_jil";
    case CNR_RESOURCE_ZELEZNY: return "tc_drev_zel";
    case CNR_RESOURCE_PRADUB: return "tc_drev_pra";
  }

  return "";
}


int __initResource() {
  int iResource = GetLocalInt(OBJECT_SELF, "KU_CRAFT_RESOURCE_ID");
  if(iResource > 0)
    return iResource;

  string sTag = GetTag(OBJECT_SELF);
  iResource = __getResourceID(sTag);
  int iMaxDig = __getDigAmmount(iResource);

  SetLocalInt(OBJECT_SELF, "KU_CRAFT_RESOURCE_ID", iResource);
  SetLocalInt(OBJECT_SELF,"iMaxDig",iMaxDig);
  return iResource;
}

int __checkTool(object oPC, int iResource) {
  object oTool = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  string sTooltag = GetTag(oTool);

  // Mining tools
  if(iResource <= CNR_RESOURCE_MAX_MINERAL && sTooltag == "ZEP_HEAVYPICK")
    return TRUE;
  if(iResource <= CNR_RESOURCE_MAX_MINERAL && sTooltag == "ZEP_LIGHTPICK")
    return TRUE;
  // Woodcut tools
  if(iResource >= CNR_RESOURCE_MIN_WOOD && sTooltag == "cnrWoodCutterAxe")
    return TRUE;

  // Dont have a tool
  if(iResource <= CNR_RESOURCE_MAX_MINERAL) {
    SendMessageToPC(oPC,"K tezbe potrebujes krumpac.");
    return FALSE;
  }

  // Dont have a tool
  if(iResource >= CNR_RESOURCE_MIN_WOOD) {
    SendMessageToPC(oPC,"K tezbe potrebujes sekeru.");
    return FALSE;
  }
  return FALSE;
}

string __getSuccesString(int iResource) {
  if(iResource <= CNR_RESOURCE_MAX_METAL)
    return "Podařilo se ti vykopat pěkný kus rudy.";
  if(iResource <= CNR_RESOURCE_MAX_MINERAL)
    return "Podařilo se ti vykopat pěkný kus nerostu.";

  return "Podařilo se ti osekat pěkný kus dřeva.";

}


void __increaseSkill(object oPC, int iSkill, int bMiningSkillType, int iMaxDig) {

  // First random
  if (Random(1000) <= iSkill)
    return;

  // Second random ??
  if (d10(1)+1 < iSkill/1000)
    return;


  // Check skill gain interval
  if (GetLocalInt(oPC,"iSkillGain")) {
    //Safety 5min reset
    DelayCommand(300.0,DeleteLocalInt(oPC,"iSkillGain"));
    return;
  }

  if (iMaxDig>1)
    SetLocalInt(oPC,"iSkillGain",99);

  // Set skill gain interval
  DelayCommand(10.0,DeleteLocalInt(oPC,"iSkillGain"));
  iSkill++;
  string sSkill = IntToString(iSkill/10)+"."+IntToString(iSkill%10);
  // Second check - no needed
  if (iSkill > 1000)
    return;


  // Increase skill
  if(bMiningSkillType)
    DelayCommand(6.0,CnrSetPersistentInt(oPC,"iMiningSkill",iSkill));
  else
    DelayCommand(6.0,CnrSetPersistentInt(oPC,"iWoodCutSkill",iSkill));
  DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
  DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepšila!"));
  if(bMiningSkillType)
    DelayCommand(6.0,SendMessageToPC(oPC,"Současná dovednost hornictví je : "+sSkill+"%"));
  else
    DelayCommand(6.0,SendMessageToPC(oPC,"Současná dovednost dřevorubectví je : "+sSkill+"%"));
  DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
}

void __tellFailString(object oPC, int bMiningSkillType) {
  string sFailString="";

  if(bMiningSkillType) {
    switch (d8(1)) {
       case 1:{sFailString="Tvuj pokrok jde pomalu...";break;}
       case 2:{sFailString="Radsi bych se na to mel vykaslat...";break;}
       case 3:{sFailString="Paze zacinaji byt unaveny...";break;}
       case 4:{sFailString="Asi to nikdy nenajdu..";break;}
       case 5:{sFailString="Mel jsem radsi zustat doma";break;}
       default:{sFailString="Chvilku jsi kopal(a), ale napodarilo se Ti vykopak zadnou rudu."; break;}
    }
  }
  else {
    switch (d8(1)) {
       case 1:{sFailString="Ten strom tu musel stat tisice let...";break;}
       case 2:{sFailString="Tak na tom si asi zlomim sekeru...";break;}
       case 3:{sFailString="radsi bych si mel dat pivo, nez to dosekam...";break;}
       case 4:{sFailString="Tak to je nejvetsi strom co sem videl..";break;}
       case 5:{sFailString="Mel bych toho nechat, nez na me tu nachytaji druidi !";break;}
       default:{sFailString = "Chvilku jsi sek(a), ale napodarilo se Ti zadny pouzitelny kus dreva."; break;}
    }
  }

  DelayCommand(5.0,FloatingTextStringOnCreature(sFailString,oPC,FALSE));

}

void __toolBreak(object oPC) {

  // Not every try can damage tool
  if(Random(3))  // 2:1 for no damage
    return;

  object oTool = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  int iToolBreak = GetLocalInt(oTool,"iToolWillBreak");

  // increment damage
  iToolBreak++;

  // damage limit
  if (iToolBreak > 40) {
    DelayCommand(6.0,FloatingTextStringOnCreature("Zlomil se ti nástroj.",oPC,FALSE));
    DestroyObject(oTool,6.0);
  }
  else {
    SetLocalInt(oTool,"iToolWillBreak",iToolBreak);
  }
}

void main()
{
  object oPC = GetLastUsedBy();
  object oSelf = OBJECT_SELF;
  int iResource = __initResource();
  int iSkill;
  int iMaxDig = GetLocalInt(OBJECT_SELF, "iMaxDig");
  int bMiningSkillType = TRUE;

  if(iResource <= 0)
    return;

  if(iMaxDig <= 0)
    return;

  //Check if PC has tool
  if(!__checkTool(oPC, iResource))
    return;

  // Check if already digging
  if (GetLocalInt(oPC,"iAmDigging")!= 0) return;
  if (GetLocalInt(oSelf,"iAmSetToDie")==0)
    SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(5.0,DeleteLocalInt(oPC,"iAmDigging"));

  // Metal or mineral
  if(iResource <= CNR_RESOURCE_MAX_MINERAL) {
    iSkill = CnrGetPersistentInt(oPC,"iMiningSkill");
    bMiningSkillType = TRUE;
  }
  // Wood
  else {
    iSkill = CnrGetPersistentInt(oPC,"iWoodCutSkill");
    bMiningSkillType = FALSE;
  }

  RemoveEffects(oPC);
  CallEnemyCreatures(oPC);

  int iDigChance = iSkill;
  // Weird skill override if skill is too low
  if (iDigChance < 350) {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350)
      iDigChance = 350;
    if (iSkill>iDigChance)
      iDigChance=iSkill;
  }

  // Play digging sound
  if (!bMiningSkillType) {
    // Woodcut sounds
    AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("it_materialhard")));
    AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("it_materialhard")));
  }
  else {
    // Dig sound
    AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("cb_ht_metblston1")));
    AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("cb_ht_metblston2")));
  }



  // Animation
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,1.0,5.0));

  // Success
  if ( Random(1000) <= iDigChance) {
     DelayCommand(5.0,FloatingTextStringOnCreature(__getSuccesString(iResource),oPC,FALSE));

     // Decrement ammount
     iMaxDig--;
     SetLocalInt(oSelf,"iMaxDig",iMaxDig);
     // Last one
     if (iMaxDig<=1)
      {
       SetLocalInt(oSelf,"iAmSetToDie",99);
       SetLocalInt(oPC,"iAmDigging",0);
       DelayCommand(3.0,FloatingTextStringOnCreature("Zdroj je pryč!",oPC,FALSE));
       DelayCommand(6.5,ReplaceSelf(oSelf,"temp_placeable"));
      }
     // Give item
     DelayCommand(6.0,CreateAnObject(__getResourceItem(iResource),oPC));
     // Repeat dig action
     if (iMaxDig>1)
       DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));

     //Check and increase skill
     __increaseSkill(oPC, iSkill, bMiningSkillType, iMaxDig);

     // Too brake check
     __toolBreak(oPC);
  }
  // Fail
  else {
    __tellFailString(oPC, bMiningSkillType);
    // Dig again
    DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
    return;
  }

}

void CheckAction(object oPC, object oSelf)
 {
  int iCurrentAction = GetCurrentAction(oPC);
  switch(iCurrentAction) {
    case ACTION_MOVETOPOINT:
    case ACTION_ATTACKOBJECT:
    case ACTION_CASTSPELL:
    case ACTION_REST:
    case ACTION_PICKUPITEM:
    case ACTION_SIT: return;
  }

  if (GetDistanceBetween(oPC,oSelf) >2.5)
    return;

  AssignCommand(oPC,ActionInteractObject(oSelf));

 }

void CreateAnObject(string sResource, object oPC)
 {
  CreateItemOnObject(sResource,oPC,1);
  return;
 }

void ReplaceSelf(object oSelf, string sAppearance) {
  object oTemp;
  location lSelf;
  string sResSelf;
  sResSelf = GetResRef(oSelf);
  string sTag = GetTag(oSelf);
  lSelf = GetLocation(oSelf);
  int iAppearance = GetAppearanceType(oSelf);
  oTemp = CreateObject(OBJECT_TYPE_PLACEABLE,sAppearance,lSelf,FALSE);
  DestroyObject(oSelf,1.0);
  AssignCommand(oTemp,DelayCommand(5400.0,CreateNew(lSelf, sResSelf, iAppearance, sTag)));
  DestroyObject(oTemp,5430.0);
  return;
}

void CreateNew(location lSelf, string sResSelf, int iAppearance, string sTag)
 {
  object oNew = CreateObject(OBJECT_TYPE_PLACEABLE,sResSelf,lSelf,FALSE, sTag);
  SetPlaceableAppearance(oNew, iAppearance);
  return;
 }

void CreatePlaceable(string sObject, location lPlace, float fDuration)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
}

void RemoveEffects(object oPC) {

////////////nomis odstraneni effektu invis a hide..///////////////////////
//AssignCommand(oPC, SetCommandable(FALSE));
//DelayCommand(1.0,AssignCommand(oPC, SetCommandable(TRUE)));
//SetActionMode(oPC,ACTION_MODE_STEALTH,0);
  effect no_effect=GetFirstEffect(oPC);
  while (GetIsEffectValid(no_effect)) {
    switch(GetEffectType(no_effect)) {
      case EFFECT_TYPE_SANCTUARY:
      case EFFECT_TYPE_INVISIBILITY:
      case EFFECT_TYPE_IMPROVEDINVISIBILITY:
      case EFFECT_TYPE_ETHEREAL:
        RemoveEffect(oPC,no_effect);
        break;
    }

    switch(GetEffectSpellId(no_effect)) {
      case SPELL_SANCTUARY:
      case SPELL_ETHEREALNESS:
      case SPELL_INVISIBILITY:
      case SPELL_IMPROVED_INVISIBILITY:
      case SPELL_INVISIBILITY_SPHERE:
        RemoveEffect(oPC,no_effect);
        break;
    }

    no_effect=GetNextEffect(oPC);
  }

  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,50),oPC,RoundsToSeconds(5));
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,50),oPC,RoundsToSeconds(5));

}

void CallEnemyCreatures(object oPC) {
  //zavolani potvor na misto tezeni////////////////

  /* Call only once a time */
  if(GetLocalInt(OBJECT_SELF,"NPC_CALL_TIMEOUT") > ku_GetTimeStamp()) {
    return;
  }
  SetLocalInt(OBJECT_SELF,"NPC_CALL_TIMEOUT",ku_GetTimeStamp(60));

  location no_lokace = GetLocation(oPC);
  int i=1;

  object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC,OBJECT_SELF,i);
  while(GetIsObjectValid(oNPC) && i < 10) {
    if ( !GetIsFighting(oNPC) && GetReputation(oNPC, oPC) <=10 )  {
      AssignCommand(oNPC,ActionMoveToObject(oPC,TRUE) );
    }
    i++;
    oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC,OBJECT_SELF,i);
  }

}
