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
#include "NW_I0_GENERIC"
#include "ku_libtime"

void CheckAction(object oPC, object oSelf);
void CreateAnObject(string sResource, object oPC);
void ReplaceSelf(object oSelf, string sAppearance);
void CreateNew(location lSelf, string sResSelf);
void CreatePlaceable(string sObject, location lPlace, float fDuration);

void RemoveEffects(object oPC);
void CallEnemyCreatures(object oPC);

void main()
{
  string sSelf=GetTag(OBJECT_SELF);

  // rozdil zda jde o drevarinu
  if (GetStringLeft(sSelf,7) != "cnrTree")
  {

  object oSelf=OBJECT_SELF;
  object oPC=GetLastUsedBy();
  string sTool = "ZEP_HEAVYPICK";
  string sToolOptional = "ZEP_LIGHTPICK";

////////////nomis odstraneni effektu invis a hide..///////////////////////
//AssignCommand(oPC, SetCommandable(FALSE));
//DelayCommand(1.0,AssignCommand(oPC, SetCommandable(TRUE)));
//SetActionMode(oPC,ACTION_MODE_STEALTH,0);
  RemoveEffects(oPC);
  CallEnemyCreatures(oPC);
//////////////////////////////////////////////////////////////


  if (GetLocalInt(oPC,"iAmDigging")!= 0) return;
  if (GetLocalInt(oSelf,"iAmSetToDie")==0)SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(5.0,SetLocalInt(oPC,"iAmDigging",0));


  string sSelf=GetTag(oSelf);
  string sResource = "";
  string sSuccessString = "";
  string sFailString = "";
  string sOldSkill = "";
  string sOldSkill2 = "";
  string sAppearance;
  //int iMiningSkill=GetTokenPair(oPC,14,3);
  int iMiningSkill = CnrGetPersistentInt(oPC,"iMiningSkill");
  int iDigChance=iMiningSkill;
  int iSuccess=0;
  int iToolBreak=GetLocalInt(oPC,"iToolWillBreak");
  int iRandom = 0;
  int iMaxDig = GetLocalInt(oSelf,"iMaxDig");
  if (iMaxDig==0)
   {
    iMaxDig=d4(2);
    SetLocalInt(oSelf,"iMaxDig",iMaxDig);
   }
  object oTool=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  if ((GetTag(oTool) != sTool)&&(GetTag(oTool) != sToolOptional))
    oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if ((GetTag(oTool) != sTool)&&(GetTag(oTool) != sToolOptional))
     {
        SendMessageToPC(oPC,"K tezbe potrebujes krumpac.");
        return;
     }

  if (iDigChance < 350)
   {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350) iDigChance = 350;
    if (iMiningSkill>iDigChance)iDigChance=iMiningSkill;
   }

   sFailString = "Chvilku jsi kopal(a), ale napodarilo se Ti vykopak zadnou rudu.";

   // zvuky kopani
   AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("cb_ht_metblston1")));
   AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("cb_ht_metblston2")));

  // rozdil zda jde o drevarinu
  if (GetStringLeft(sSelf,7) == "cnrTree")
   {
       // zvuky kopani
       AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("it_materialhard")));
       AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("it_materialhard")));
   } else
   {
       // zvuky kopani
       AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("cb_ht_metblston1")));
       AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("cb_ht_metblston2")));
   }


///////////////////////////////////////////////////////////////////////////////////////////////////////
//////////
//////////         NOMIS 21.SRPEN doplneni
//////////////////////////////////////////////////////////////////////////////////////////////////////
 // if (sSelf == "cnrTreeOak") //skala
//  {
//    sAppearance="temp_placeable";
//    sResource = "cnrBranchOak";
//   }
//  if (sSelf == "cnrTreeMahogany") //skala
//   {
//    sAppearance="temp_placeable";
//    sResource = "cnrBranchMah";
//   }
//  if (sSelf == "cnrTreeHickory") //skala
//   {
//    sAppearance="temp_placeable";
//    sResource = "cnrBranchHic";
//   }
///////////////////////////////////////////////////////////
  if (sSelf == "cnrRockTin") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetTin";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy cinu";
   }
  if (sSelf == "cnrRockAdam") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetAdam";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy adamantinu";
   }
  if (sSelf == "cnrRockGold") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetGold";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zlata";
   }
  if (sSelf == "cnrRockMith") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetMith";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy mithrilu";
   }
  if (sSelf == "cnrRockPlat") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetPlat";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy platiny";
   }
  if (sSelf == "cnrRockSilv") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetSilv";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy stribra";
   }
  if (sSelf == "cnrRockTita") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetTita";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy titanu";
   }
  if (sSelf == "cnrRockIron") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetIron";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if (sSelf == "cnrRockCopp") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrNuggetCopp";
    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy medi";
   }

  if (GetStringLeft(sSelf,13) == "cnrGemDeposit") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrGemMineral" + GetStringRight(sSelf,3);
    sSuccessString = "Podarilo se ti vytkutat pekny kus nerostu";
   }



///////////////////////////////////////////////////////////////////////////////////////////////////////
//////////
//////////         NOMIS 21.SRPEN doplneni
//////////////////////////////////////////////////////////////////////////////////////////////////////

  if (sSelf == "cnrDepositCoal") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrLumpOfCoal";
    sSuccessString = "Podarilo se ti vytkutat pekny kus uhli";
   }


if (sSelf == "cnrRockStin") //skala
   {
    sAppearance="temp_placeable";
    sResource = "tc_nug_stin";
    sSuccessString = "Podarilo se ti vytkutat pekny kus stinove oceli";
   }
if (sSelf == "cnrRockMete") //skala
   {
    sAppearance="temp_placeable";
    sResource = "tc_nug_meteor";
    sSuccessString = "Podarilo se ti vytkutat pekny kus meteoriticke oceli";
   }




////////////////////////nomis konec doplneni///////////////////////////////////
  iRandom = Random(1000);

  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,1.0,5.0));

  if (iRandom <= iDigChance)
    {
     DelayCommand(5.0,FloatingTextStringOnCreature(sSuccessString,oPC,FALSE));
     iMaxDig--;
     SetLocalInt(oSelf,"iMaxDig",iMaxDig);
     if (iMaxDig==1)
      {
       SetLocalInt(oSelf,"iAmSetToDie",99);
       SetLocalInt(oPC,"iAmDigging",0);
       DelayCommand(3.0,FloatingTextStringOnCreature("Zdroj je pryc!",oPC,FALSE));
       DelayCommand(6.5,ReplaceSelf(oSelf,sAppearance));
      }
     iSuccess = 1;
     DelayCommand(6.0,CreateAnObject(sResource,oPC));
     if (iMaxDig>1) DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     if (Random(1000)> iMiningSkill)
      {
       if (d10(1)+1>= iMiningSkill/1000)
        {
         if (GetLocalInt(oPC,"iSkillGain")==0)
          {
           if (iMaxDig>1)SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
           iMiningSkill++;
           sOldSkill2 = IntToString(iMiningSkill);
           sOldSkill = "."+GetStringRight(sOldSkill2,1);
           if (iMiningSkill > 9)
             {
              sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
             }
            else
             {
              sOldSkill = "0"+sOldSkill;
             }
           if (iMiningSkill <= 1000)
            {
             //DelayCommand(5.5,SetTokenPair(oPC,14,3,iMiningSkill));
             DelayCommand(6.0,CnrSetPersistentInt(oPC,"iMiningSkill",iMiningSkill));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepsila!"));
             DelayCommand(6.0,SendMessageToPC(oPC,"Soucasna dovednost hornictvi je : "+

sOldSkill+"%"));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0)

DelayCommand(6.0,GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP")));
            }
          }
        }
      }
    }
   else
    {
     switch (d8(1))
      {
       case 1:{sFailString="Tvuj pokrok jde pomalu...";break;}
       case 2:{sFailString="Zacinas mit ztuhla zada...";break;}
       case 3:{sFailString="Paze zacinaji byt unaveny...";break;}
       case 4:{sFailString="Nekde to tu prece je..";break;}
       case 5:{sFailString="To je zpatecnicke!";break;}
       default:{break;}
      }
     DelayCommand(5.0,FloatingTextStringOnCreature(sFailString,oPC,FALSE));
     DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     return;
    }

  if (iSuccess == 1)
   {
    iToolBreak++;
    if (iToolBreak > 100)
     {
      DelayCommand(6.0,FloatingTextStringOnCreature("Zlomil se ti nastroj..",oPC,FALSE));
      DestroyObject(oTool,6.0);
      iToolBreak = 0;
     }
   }

  SetLocalInt(oPC,"iToolWillBreak",iToolBreak);

 //
 } else {
   object oSelf=OBJECT_SELF;
  object oPC=GetLastUsedBy();
  string sTool = "cnrWoodCutterAxe";
  string sToolOptional = "cnrWoodCutterAxe";

  if (GetLocalInt(oPC,"iAmDigging")!= 0) return;
  if (GetLocalInt(oSelf,"iAmSetToDie")==0)SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(5.0,SetLocalInt(oPC,"iAmDigging",0));

////////////nomis odstraneni effektu invis a hide..///////////////////////
  RemoveEffects(oPC);
  CallEnemyCreatures(oPC);
//////////////////////////////////////////////////////////////


  string sResource = "";
  string sSuccessString = "";
  string sFailString = "";
  string sOldSkill = "";
  string sOldSkill2 = "";
  string sAppearance;
  //int iWoodCutSkill=GetTokenPair(oPC,14,3);
  int iWoodCutSkill = CnrGetPersistentInt(oPC,"iWoodCutSkill");
  int iDigChance=iWoodCutSkill;
  int iSuccess=0;
  int iToolBreak=GetLocalInt(oPC,"iToolWillBreak");
  int iRandom = 0;
  int iMaxDig = GetLocalInt(oSelf,"iMaxDig");
  if (iMaxDig==0)
   {
    iMaxDig=d4(2);
    SetLocalInt(oSelf,"iMaxDig",iMaxDig);
   }
  object oTool=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  if ((GetTag(oTool) != sTool)||(GetTag(oTool) != sToolOptional))
    oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if ((GetTag(oTool) != sTool)||(GetTag(oTool) != sToolOptional))
     {
        SendMessageToPC(oPC,"K tezbe potrebujes sekeru.");
        return;
     }

  if (iDigChance < 350)
   {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350) iDigChance = 350;
    if (iWoodCutSkill>iDigChance)iDigChance=iWoodCutSkill;
   }

   sFailString = "Chvilku jsi sek(a), ale napodarilo se Ti zadny pouzitelny kus dreva.";
   sSuccessString = "Odsekl(a) jsi poradny kus dreva";
   // zvuky kopani
   AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("it_materialhard")));
   AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("it_materialhard")));


  if (sSelf == "cnrTreeOak") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrBranchOak";
   }
  if (sSelf == "cnrTreeMahogany") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrBranchMah";
   }
  if (sSelf == "cnrTreeHickory") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrBranchHic";
   }
     /////////nomis 21.srpen
  if (sSelf == "cnrTreeVrba") // vrbovy drevo
   {
    sAppearance="temp_placeable";
    sResource = "tc_drev_vrb";
}
  if (sSelf == "cnrTreeTis") // tisove drevo
   {
    sAppearance="temp_placeable";
    sResource = "tc_drev_tis";
}
  if (sSelf == "cnrTreeJil") // jilmove drevo
   {
    sAppearance="temp_placeable";
    sResource = "tc_drev_jil";
}
  if (sSelf == "cnrTreeZel") //  drevo  zelezneho dubu
   {
    sAppearance="temp_placeable";
    sResource = "tc_drev_zel";
}
  if (sSelf == "cnrTreePra") // drevo prastareho dubu
   {
    sAppearance="temp_placeable";
    sResource = "tc_drev_pra";
}  ///nomis konec dodelavani

  iRandom = Random(1000);

  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,1.0,5.0));

  if (iRandom <= iDigChance)
    {
     DelayCommand(5.0,FloatingTextStringOnCreature(sSuccessString,oPC,FALSE));
     iMaxDig--;
     SetLocalInt(oSelf,"iMaxDig",iMaxDig);
     if (iMaxDig==1)
      {
       SetLocalInt(oSelf,"iAmSetToDie",99);
       SetLocalInt(oPC,"iAmDigging",0);
       DelayCommand(3.0,FloatingTextStringOnCreature("Zdroj je pryc!",oPC,FALSE));
       DelayCommand(6.5,ReplaceSelf(oSelf,sAppearance));
      }
     iSuccess = 1;
     DelayCommand(6.0,CreateAnObject(sResource,oPC));
     if (iMaxDig>1) DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     if (Random(1000)> iWoodCutSkill)
      {
       if (d10(1)+1>= iWoodCutSkill/1000)
        {
         if (GetLocalInt(oPC,"iSkillGain")==0)
          {
           if (iMaxDig>1)SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
           iWoodCutSkill++;
           sOldSkill2 = IntToString(iWoodCutSkill);
           sOldSkill = "."+GetStringRight(sOldSkill2,1);
           if (iWoodCutSkill > 9)
             {
              sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
             }
            else
             {
              sOldSkill = "0"+sOldSkill;
             }
           if (iWoodCutSkill <= 1000)
            {
             DelayCommand(6.0,CnrSetPersistentInt(oPC,"iWoodCutSkill",iWoodCutSkill));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepsila!"));
             DelayCommand(6.0,SendMessageToPC(oPC,"Soucasna dovednost drevorubectvi je : "+

sOldSkill+"%"));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
            }
          }
        }
      }
    }
   else
    {
     switch (d8(1))
      {
       case 1:{sFailString="Tvuj pokrok jde pomalu...";break;}
       case 2:{sFailString="Zacinas mit ztuhla zada...";break;}
       case 3:{sFailString="Paze zacinaji byt unaveny...";break;}
       case 4:{sFailString="Nekde to tu prece je..";break;}
       case 5:{sFailString="To je zpatecnicke!";break;}
       default:{break;}
      }
     DelayCommand(5.0,FloatingTextStringOnCreature(sFailString,oPC,FALSE));
     DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     return;
    }

  if (iSuccess == 1)
   {
    iToolBreak++;
    if (iToolBreak > 100)
     {
      DelayCommand(6.0,FloatingTextStringOnCreature("Zlomil se ti nastroj..",oPC,FALSE));
      DestroyObject(oTool,6.0);
      iToolBreak = 0;
     }
   }

  SetLocalInt(oPC,"iToolWillBreak",iToolBreak);
 }
}

void CheckAction(object oPC, object oSelf)
 {
  int iCurrentAction = GetCurrentAction(oPC);
  if (iCurrentAction == ACTION_MOVETOPOINT) return;
  if (iCurrentAction == ACTION_ATTACKOBJECT) return;
  if (iCurrentAction == ACTION_CASTSPELL) return;
  if (iCurrentAction == ACTION_REST) return;
  if (iCurrentAction == ACTION_PICKUPITEM) return;
  if (iCurrentAction == ACTION_SIT) return;
  if (GetDistanceBetween(oPC,oSelf) >2.5) return;

  AssignCommand(oPC,ActionInteractObject(oSelf));

 }

void CreateAnObject(string sResource, object oPC)
 {
  CreateItemOnObject(sResource,oPC,1);
  return;
 }

void ReplaceSelf(object oSelf, string sAppearance)
 {
  object oTemp;
  location lSelf;
  string sResSelf;
  sResSelf=GetResRef(oSelf);
  lSelf=GetLocation(oSelf);
  oTemp = CreateObject(OBJECT_TYPE_PLACEABLE,sAppearance,lSelf,FALSE);
  DestroyObject(oSelf,1.0);
  AssignCommand(oTemp,DelayCommand(1200.0,CreateNew(lSelf,sResSelf)));
  DestroyObject(oTemp,1230.0);
  return;
 }

void CreateNew(location lSelf, string sResSelf)
 {
  CreateObject(OBJECT_TYPE_PLACEABLE,sResSelf,lSelf,FALSE);
  return;
 }

void CreatePlaceable(string sObject, location lPlace, float fDuration)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
}



// zakomentovano melvik 20,8.2008


/*
void main()
{
  object oUser = GetLastUsedBy();
  object oTarget = OBJECT_SELF;
  AssignCommand(oUser, DoPlaceableObjectAction(oTarget, PLACEABLE_ACTION_BASH));
}
*/



// zakomentovano melvik 20,8.2008


/*
void main()
{
  object oUser = GetLastUsedBy();
  object oTarget = OBJECT_SELF;
  AssignCommand(oUser, DoPlaceableObjectAction(oTarget, PLACEABLE_ACTION_BASH));
}
*/



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
//////////////////////////////////////////////////////////////

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


