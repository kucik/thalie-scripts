#include "ku_libtime"
#include "cnr_persist_inc"

const int __TROF_PELT = 1;
const int __TROF_MEAT = 2;
const int __TROF_MISC = 3;

void CreateAnObject(string sResource, object oPC, int iSkill, int iType = 1, string sAnimalName = "");
void CreatePlaceable(string sObject, location lPlace, float fDuration);

int GetPeltCostByCR(float fCR) {
  return FloatToInt((pow(1.12, fCR) * 28.0) - 25.0);  
}

void main()
{
  if (GetLocalInt(OBJECT_SELF,"sIAmUsed") != 0) return;
  SetLocalInt(OBJECT_SELF,"sIAmUsed",99);
  object oPC = GetLastUsedBy();
  object oSelf = OBJECT_SELF;
  location lSelf = GetLocation(oSelf);
  int bMaso = 1;
 int bHasKnife = FALSE;
  object oTool = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
  string sAnimalName = GetName(OBJECT_SELF);
  if (GetIsObjectValid(oTool))
  {
    if (GetTag(oTool) == "cnrSkinningKnife")
    {
      bMaso = (GetLocalInt(oTool, "ME_MASO"));
      bHasKnife = TRUE;
    }
  }

  if (bHasKnife == FALSE)
  {
    oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if (GetIsObjectValid(oTool))
    {
      if (GetTag(oTool) == "cnrSkinningKnife")
      {
        bMaso = (GetLocalInt(oTool, "ME_MASO"));
        bHasKnife = TRUE;
      }
    }
  }


  if (bHasKnife == FALSE)
   {
    SetLocalInt(OBJECT_SELF,"sIAmUsed",0);
    FloatingTextStringOnCreature("Bez stahovaciho noze v ruce ji neziskas...",oPC,FALSE);
    return;
   }
  string sPeltTag = GetLocalString(OBJECT_SELF,"sPelt");
  string sMeatTag = GetLocalString(OBJECT_SELF,"sMeat");
  string sMisc = GetLocalString(OBJECT_SELF,"sMisc");
  object oCorpse = GetLocalObject(OBJECT_SELF,"oCorpse");

  int iSkinPenalty = GetLocalInt(OBJECT_SELF,"iPenalty");
  //int iSkinSkill = GetTokenPair(oPC,14,8);
  int iSkinSkill = CnrGetPersistentInt(oPC,"iSkinSkill");
  int iSkinChance = iSkinSkill;
  if (iSkinChance < 350)
   {
    iSkinChance = GetAbilityScore(oPC,ABILITY_DEXTERITY)*5;
    iSkinChance = iSkinChance+(GetAbilityScore(oPC,ABILITY_STRENGTH)*3);
    iSkinChance = iSkinChance+(GetAbilityScore(oPC,ABILITY_INTELLIGENCE)*2);
    iSkinChance = iSkinChance*3;
    if (iSkinChance >350) iSkinChance = 350;
    if (iSkinSkill > iSkinChance) iSkinChance = iSkinSkill;
   }
  iSkinChance = iSkinChance - iSkinPenalty;
  if (iSkinChance <1)
   {
    FloatingTextStringOnCreature("Nemas poneti jak dobre ziskat trofej.",oPC,FALSE);
    SetLocalInt(OBJECT_SELF,"sIAmUsed",0);
    return;
   }
  iSkinChance = iSkinChance+200;
  int iRandom = Random(1000);
  if (iRandom > iSkinChance)
   {
    //SendMessageToPC(oPC,"SkinChance: "+IntToString(iSkinChance));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
    AssignCommand(oPC,DelayCommand(5.0,FloatingTextStringOnCreature("Znicils trofej kdyz ses ji snazil(a) ziskat.",oPC,FALSE)));
    //AssignCommand(oPC,DelayCommand(2.5,CreatePlaceable("plc_pileskulls",lSelf,30.0)));
    AssignCommand(oPC,DelayCommand(2.0,CreatePlaceable("plc_bloodstain",lSelf,60.0)));
    AssignCommand(oCorpse,DelayCommand(2.0,ExecuteScript("me_nc_kill_corps",oCorpse)));
    DestroyObject(OBJECT_SELF);
    return;
   }
  iRandom = Random(1000);
  int iSkillGain = 0;
  if (iRandom > (iSkinSkill - iSkinPenalty))iSkillGain = 1;
  int iPeltQty = 1;
  int iMeatQty = 0;
  if (sMeatTag != "")
    {
      iMeatQty = StringToInt(sMeatTag);
    }
 /* if ((iMeatQty == 0)&&(GetStringLength(sMeatTag!=0)))
  {

  } */

  //SendMessageToPC(oPC,"iSkinSkill   : "+IntToString(iSkinSkill));
  //SendMessageToPC(oPC,"iSkinPenalty : "+IntToString(iSkinPenalty));
  //SendMessageToPC(oPC,"iRandom      : "+IntToString(iRandom));
  //SendMessageToPC(oPC,"iSkillGaiin  : "+IntToString(iSkillGain));

  // Determine 1-4 meat and/or pelts based on skill level and random determination checks.

  if (iSkinSkill/200 >= Random(100)) iPeltQty++;

  if (iSkinSkill>=500)
   {
    if ((Random(1000)<=iSkinChance)&&(iMeatQty > 0)) iMeatQty++;
   }

  string sPCMessage1 = "Podarilo se.."; //"You carefully skin the creature, collecting "+IntToString(iPeltQty)+" pelt";
  string sPCMessage2 = "";//"You also collect "+IntToString(iMeatQty)+" portion";
  //if (iPeltQty >1) sPCMessage1 = sPCMessage1;
  //if (iMeatQty >1) sPCMessage2 = sPCMessage2+"s";
  sPCMessage1 = sPCMessage1+".";
  //sPCMessage2 = sPCMessage2+" of meat.";
  AssignCommand(oPC,DelayCommand(5.0,FloatingTextStringOnCreature(sPCMessage1,oPC,FALSE)));
  //AssignCommand(oPC,DelayCommand(6.0,FloatingTextStringOnCreature(sPCMessage2,oPC,FALSE)));
  float fPause =0.0;
  for (iPeltQty; iPeltQty > 0; iPeltQty--)
   {

    AssignCommand(oPC,DelayCommand(4.0+fPause,CreateAnObject(sPeltTag,oPC,iSkinChance,__TROF_PELT)));
    fPause = fPause+0.3;
   }
  if (bMaso == 1)
    {
      for (iMeatQty; iMeatQty > 0; iMeatQty--)
       {
        if (Random(1000)<=iSkinChance)      sMeatTag = "ry_maso_1";
        if (Random(1000)<=(iSkinChance - 200))  sMeatTag = "ry_maso_2";
        if (Random(1000)<=(iSkinChance - 400))  sMeatTag = "ry_maso_3";

        if(GetStringLength(sMeatTag) > 1)
          AssignCommand(oPC,DelayCommand(4.0+fPause,CreateAnObject(sMeatTag,oPC,iSkinChance,__TROF_MEAT, sAnimalName)));
        fPause = fPause+0.3;
       }
     }
  if (sMisc != "") AssignCommand(oPC,DelayCommand(4.0+fPause,CreateAnObject(sMisc,oPC,iSkinChance,__TROF_MISC)));


  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
  //AssignCommand(oPC,DelayCommand(2.5,CreatePlaceable("plc_pileskulls",lSelf,300.0)));
  AssignCommand(oPC,DelayCommand(2.0,CreatePlaceable("plc_bloodstain",lSelf,600.0)));

  //Ensure no more than 1 skill gain every 5 seconds to avoid token droppage.
      if (iSkillGain ==1)
       {
        int iTimeStamp = GetLocalInt(oPC,"iSkillGainCr");
        if ((iTimeStamp < ku_GetTimeStamp()) || (iTimeStamp==0))
          {
           iSkillGain = 1;
           SetLocalInt(oPC,"iSkillGainCr",ku_GetTimeStamp(8));
          }
        else
          {
           iSkillGain = 0;
          }
       }

   //SetLocalInt(oPC,"iSkillGainCr",0)
  //ku_GetTimeStamp()

  if (iSkillGain)
    {
     string sOldSkill = "";
     string sOldSkill2 = "";
     iSkinSkill++;
     sOldSkill2 = IntToString(iSkinSkill);
     sOldSkill = "."+GetStringRight(sOldSkill2,1);
     if (iSkinSkill > 9)
       {
        sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
       }
      else
       {
        sOldSkill = "0"+sOldSkill;
       }
     if (iSkinSkill <= 1000)
      {
       //DelayCommand(5.0,SetTokenPair(oPC,14,8,iSkinSkill));
       DelayCommand(5.0,CnrSetPersistentInt(oPC,"iSkinSkill",iSkinSkill));
       AssignCommand(oPC,DelayCommand(7.0,SendMessageToPC(oPC,"================================")));
       AssignCommand(oPC,DelayCommand(7.0,SendMessageToPC(oPC,"Tvoje dovednost ziskavani tofeji se zlepsila!")));
       AssignCommand(oPC,DelayCommand(7.0,SendMessageToPC(oPC,"Tvoje dovednost je : "+ sOldSkill+"%")));
       AssignCommand(oPC,DelayCommand(7.0,SendMessageToPC(oPC,"================================")));
       //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0) AssignCommand(oPC,DelayCommand(6.9,GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP"))));
      }
    }
  AssignCommand(oCorpse,DelayCommand(2.0,ExecuteScript("me_nc_kill_corps",oCorpse)));
  DestroyObject(OBJECT_SELF,6.0);
}

void CreateAnObject(string sResource, object oPC, int iSkill, int iType = 1, string sAnimalName = "")
 {
  object oItem = CreateItemOnObject(sResource,oPC,1);
  if(!GetIsObjectValid(oItem))
  {
        SendMessageToPC(oPC, "Chybka! Nemuzu vytvorit kuzi '"+sResource+"'");
        return;
  }
  int iAct = GetLocalInt(oItem, "TROFEJ");
  float fCR = GetLocalFloat(OBJECT_SELF, "MonsterCR");
  /* Calculate cost from CR, but not for Bosses */
  if(fCR > 0.0 && GetLocalInt(OBJECT_SELF, "AI_BOSS") <= 0) {
    iAct = GetPeltCostByCR(fCR);
  }

  if (iAct == 0)  iAct = 5;  //navyseni zlatek

  if (GetItemStackSize(oItem)==1)
  {
    //navysim o procenta cenu
    int iAddPercent = (iSkill / 10)*3;
    float fKoeficient = IntToFloat(iAddPercent) / 100.0;
    iAct = FloatToInt(IntToFloat(iAct) * fKoeficient);
  }

  if(iType == __TROF_PELT)
    SetLocalInt(oItem,"TROFEJ", iAct);
  if(iType == __TROF_MEAT && !GetLocalInt(oItem,"HOSTINSKY"))
    SetLocalInt(oItem,"HOSTINSKY", iAct/5);

  if(GetStringLength(sAnimalName) > 0)
    SetLocalString(oItem,"ANIMAL_NAME",sAnimalName);

  return;
 }

void CreatePlaceable(string sObject, location lPlace, float fDuration)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
}
