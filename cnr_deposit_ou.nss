//#include "_persist_01a"
#include "cnr_persist_inc"
void CheckAction(object oPC, object oSelf);
void CreateAnObject(string sResource, object oPC);
void ReplaceSelf(object oSelf, string sAppearance);
void CreateNew(location lSelf, string sResSelf);
void CreatePlaceable(string sObject, location lPlace, float fDuration);

void main()
{
  object oSelf=OBJECT_SELF;
  object oPC=GetLastUsedBy();

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
  //int iDigSkill=GetTokenPair(oPC,14,3);
  int iDigSkill = CnrGetPersistentInt(oPC,"iDigSkill");
  int iDigChance=iDigSkill;
  int iSuccess=0;
  int iToolBreak=GetLocalInt(oPC,"iToolWillBreak");
  int iRandom = 0;
  int iMaxDig = GetLocalInt(oSelf,"iMaxDig");
  if (iMaxDig==0)
   {
    iMaxDig=d4(3)+40;
    SetLocalInt(oSelf,"iMaxDig",iMaxDig);
   }
  object oTool=OBJECT_INVALID;



  if (iDigChance < 350)
   {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350) iDigChance = 350;
    if (iDigSkill>iDigChance)iDigChance=iDigSkill;
   }

  if (sSelf == "cnrDepositClay") //hlinka
   {
    oTool = GetItemPossessedBy(oPC,"cnrShovel");
    if (oTool==OBJECT_INVALID)
     {
      FloatingTextStringOnCreature("Ke kopani hlinky potrebujes lopatu.",oPC,FALSE);
      return;
     }
    sAppearance="temp_placeable";
    sResource = "cnrlumpofclay";
    sSuccessString = "Podarilo se ti vykopat pekny kus mazlave hlinky";
    sFailString = "Chvilkus kopal(a) ale napodarilo se Ti vykopak zadnou pouzitelnou hlinku.";
    PlaySound ("as_cv_mineshovl1");
   }

  if (sSelf == "cnrDepositSand")
   {
    oTool = GetItemPossessedBy(oPC,"cnrShovel");
    if (oTool==OBJECT_INVALID)
     {
      FloatingTextStringOnCreature("Ke kopani pisku potrebujes lopatu..",oPC,FALSE);
      return;
     }
    if (iDigChance > 300)
        { //me_cnrperla
            int iPearlPer = 1;
            if (iDigChance > 600)
                {
                    iPearlPer = 3;
                    if (iDigChance > 900) iPearlPer = 6;
                }
            if (Random(1000) < iPearlPer + 1)
                {
                     DelayCommand(5.0,FloatingTextStringOnCreature("Jejda... Perla...",oPC,FALSE));
                     DelayCommand(6.0,CreateAnObject("me_cnrperla",oPC));
                }

        }
    sResource = "cnrbagofsand";
    sAppearance="temp_placeable";
    sSuccessString = "Podarilo se ti vykopat plny pytklik kvalitniho pisku.";
    sFailString = "Chvilkus kopal(a) ale napodarilo se Ti vykopak zadny pouzitelny pisek.";
    PlaySound ("as_cv_mineshovl2");
   }

  if (sSelf == "DIG_SALT")
   {
    oTool = GetItemPossessedBy(oPC,"TOOL_SHOVEL");
    if (oTool==OBJECT_INVALID)
     {
      FloatingTextStringOnCreature("You must have a shovel in order to dig salt.",oPC,FALSE);
      return;
     }
    sResource = "saltblock";
    sAppearance="temp_placeable";
    sSuccessString = "You manage to dig out a chunk of pure salt.";
    sFailString = "You dig for a while but do not find any pure salt.";
    PlaySound ("as_cv_mineshovl3");
   }

  if (sSelf == "DIG_LIME")
   {
    oTool = GetItemPossessedBy(oPC,"TOOL_SHOVEL");
    if (oTool==OBJECT_INVALID)
     {
      FloatingTextStringOnCreature("You must have a shovel in order to dig lime.",oPC,FALSE);
      return;
     }
    sResource = "limeblock";
    sAppearance="temporaryrubble2";
    sSuccessString = "You manage to dig out a chunk of pure lime.";
    sFailString = "You dig for a while but do not find any pure lime.";
    PlaySound ("as_cv_mineshovl3");
   }

  if (sSelf == "DIG_SULPHUR")
   {
    oTool = GetItemPossessedBy(oPC,"TOOL_SHOVEL");
    if (oTool==OBJECT_INVALID)
     {
      FloatingTextStringOnCreature("You must have a shovel in order to dig sulphur.",oPC,FALSE);
      return;
     }
    sResource = "sulphur";
    sAppearance="temporaryrubble1";
    sSuccessString = "You manage to dig out a chunk of pure sulphur.";
    sFailString = "You dig for a while but do not find any pure sulphur.";
    PlaySound ("as_cv_mineshovl3");
   }
  //FloatingTextStringOnCreature("Digging...",oPC,FALSE);

  iRandom = Random(1000);


  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,5.0));

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
     if (Random(1000)> iDigSkill)
      {
       if (d10(1)+1>= iDigSkill/1000)
        {
         if (GetLocalInt(oPC,"iSkillGain")==0)
          {
           if (iMaxDig>1)SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
           iDigSkill++;
           sOldSkill2 = IntToString(iDigSkill);
           sOldSkill = "."+GetStringRight(sOldSkill2,1);
           if (iDigSkill > 9)
             {
              sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
             }
            else
             {
              sOldSkill = "0"+sOldSkill;
             }
           if (iDigSkill <= 1000)
            {
             //DelayCommand(5.5,SetTokenPair(oPC,14,3,iDigSkill));
             DelayCommand(6.0,CnrSetPersistentInt(oPC,"iDigSkill",iDigSkill));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepsila!"));
             DelayCommand(6.0,SendMessageToPC(oPC,"Soucana dovednost kopani je : "+ sOldSkill+"%"));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0) DelayCommand(6.0,GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP")));
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
  AssignCommand(oTemp,DelayCommand(3600.0,CreateNew(lSelf,sResSelf)));
  DestroyObject(oTemp,3630.0);
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
