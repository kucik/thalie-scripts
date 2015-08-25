//#include "_persist_01a"
#include "cnr_persist_inc"
#include "ku_libtime"
#include "ku_water_inc"

void CreatePlaceable(object oPC, string sObject, location lPlace, float fDuration);
void CreateAMonster(string sMonster, object oPC, int iNumberOfMonsters);
void CreateAnObject(string sResource, object oPC, int iStackSize);
void CancelFishing(object oPC, location lCurrent);
void DelayText(object oPC, string sMessage);
void DelaySkill(object oPC, int iFishingSkill, string sOldSkill);

void main()
{

  int iFishingSkill = 0;
  int iFishingChance = 0;
  object oPC = OBJECT_SELF;
  int iTypVody = ku_FishWater(GetLocalInt(oPC, "TypVody"));

  if (
        (iTypVody == 0) 
     )
     {
        FloatingTextStringOnCreature("Tady ryby nechytis.",oPC,FALSE);
        return;
     }
  //if (GetResRef(oPC) == "fishinghole") oPC = GetClickingObject();

  if (GetLocalInt(oPC,"iAmFishing") != 0) return;
  if (GetLocalInt(oPC,"iCancelFishing") != 0)
   {
    SetLocalInt(oPC,"iCancelFishing",0);
    return;
   }
  object oPole = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  string sPoleTag = "ITEM_FISHINGPOLE";

/*  if (GetRacialType(oPC) == RACIAL_TYPE_HALFLING) sPoleTag = "ITEM_FISHINGROD";
  if (GetRacialType(oPC) == RACIAL_TYPE_GNOME) sPoleTag = "ITEM_FISHINGROD";
  if (GetRacialType(oPC) == RACIAL_TYPE_DWARF) sPoleTag = "ITEM_FISHINGROD";
  if (GetStringLeft(GetTag(oPole),16) != sPoleTag)
   {
    oPole = GetItemPossessedBy(oPC,sPoleTag);
    if (oPole == OBJECT_INVALID)
     {
      if (sPoleTag =="ITEM_FISHINGPOLE")
        {
         FloatingTextStringOnCreature("Na chytani ryb potrebujes rybarsky prut.",oPC,FALSE);
        }
       else
        {
         FloatingTextStringOnCreature("Na chytani ryb potrebujes rybarsky prut.",oPC,FALSE);
        }
      return;
     }
    AssignCommand(oPC,ActionEquipItem(oPole,INVENTORY_SLOT_RIGHTHAND));
   }*/
  SetLocalInt(oPC,"iAmFishing",99);
  AssignCommand(oPC,DelayCommand(12.0,SetLocalInt(oPC,"iAmFishing",0)));
  DelayCommand(1.0,FloatingTextStringOnCreature("Nahodil si navnadu do vody...",oPC,FALSE));
  SetLocalLocation(oPC,"lIWasHere",GetLocation(oPC));
  AssignCommand(oPC,DelayCommand(13.0,CancelFishing(oPC,GetLocation(OBJECT_SELF))));
  AssignCommand(oPC,DelayCommand(1.0,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE,1.0,1.0)));
  AssignCommand(oPC,DelayCommand(4.0,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED,1.0,6.0)));
  AssignCommand(oPC,DelayCommand(10.0,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,2.0)));
  switch (Random(3))
   {
    case 1:{AssignCommand(oPC,DelayCommand(1.5,PlaySound("as_na_drip4")));break;}
    case 2:{AssignCommand(oPC,DelayCommand(1.5,PlaySound("as_na_drip5")));break;}
    default:{AssignCommand(oPC,DelayCommand(1.5,PlaySound("as_na_drip4")));break;}
   }

  iFishingSkill = CnrGetPersistentInt(oPC,"iFishingSkill");
  iFishingChance = iFishingSkill;
  if (iFishingChance <350)
   {
    iFishingChance = GetAbilityScore(oPC,ABILITY_CHARISMA)*5;
    iFishingChance = iFishingChance+(GetAbilityScore(oPC,ABILITY_STRENGTH)*3);
    iFishingChance = iFishingChance+(GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iFishingChance = iFishingChance*3;
    if (iFishingChance >350) iFishingChance = 350;
    if (iFishingSkill > iFishingChance) iFishingChance = iFishingSkill;
   }

  int iFishRange = 3;
  if (iFishingChance > 250) iFishRange++;    //smallmouth
  if (iFishingChance > 350) iFishRange++;    // largemouth
  if (iFishingChance > 450) iFishRange++;    // trout
  if (iFishingChance > 500) iFishRange++;    // small channel cat
  if (iFishingChance > 550) iFishRange++;    // small channel cat

  int iRandom = Random(1000);
  int iRandom2 = Random(1000);
  int iSuccess = 0;
  int iSkillGain = 0;
  string sFishResRef = "";
  string sSuccessMessage = "";
  string sFailMessage = "Ani po zbesilem nahazovani... zadna rybka...";

  if ((iRandom <= iFishingChance)&&(iRandom2 <= iFishingChance))
    {
     iSuccess = 1;
    }
   else
    {
     AssignCommand(oPC,DelayCommand(11.0,DelayText(oPC,sFailMessage)));
    }

  if (iSuccess == 1)
   {
    if (Random(1000)<500)
      {
       AssignCommand(oPC,DelayCommand(11.0,PlaySound("as_na_splash1")));
      }
     else
      {
       AssignCommand(oPC,DelayCommand(11.0,PlaySound("as_na_splash2")));
      }
    iRandom = Random(1000);
    if (iRandom >= iFishingSkill)
      {
       if (d10(1)+1 >= iFishingChance/100) iSkillGain = 1;
      }
    int iFishNormalFlag = 0;
    iRandom = Random(iFishRange)+1;

    // Sladka voda 
    if(iTypVody == 1) {
      switch (iRandom)
       {
          // fish001 - okoun - ry_ryba_okoun
          // fish002 - kapr potocni - ry_ryba_kapp
          // fish003 - rak - ry_rak
          // fish004 - kapr - ry_ryba_kapr
          // fish005 - pstruh - ry_ryba_pstruh
          // fish006 - lin - ry_ryba_lin
          // fish007 - cejn - ry_ryba_cejn
          // fish008 - uhor - ry_ryba_uhor
        case 1:
         {
          sFishResRef = "ry_ryba_okoun";
          sSuccessMessage = "Podarilo se Ti chytit okounka...";
          break;
         }
        case 2:
         {
          sFishResRef = "ry_ryba_kapp";
          sSuccessMessage = "Podarilo se ti chytit kaprika potocniho...";
          break;
         }
        case 3:
         {
          sFishResRef = "ry_rak";
          sSuccessMessage = "Na navnadu se chytil rak.";
          break;
         }
        case 4:
         {
          sFishResRef = "ry_ryba_kapr";
          sSuccessMessage = "Pdarilo se ti chytit pekneho kapra.";
          break;
         }
        case 5:
         {
          sFishResRef = "ry_ryba_pstruh";
          sSuccessMessage = "Podarilo se Ti chytit pstruha.";
          break;
         }
        case 6:
         {
          sFishResRef = "ry_ryba_lin";
          sSuccessMessage = "Podaril se ti ulovek. Je to lin.";
          break;
         }
        case 7:
         {
          sFishResRef = "ry_ryba_cejn";
          sSuccessMessage = "Podarilo se. Krasny cejnek.";
          break;
         }
        case 8:
         {
          sFishResRef = "ry_ryba_uhor";
          sSuccessMessage = "To je ulovek. Uhor.";
          break;
         }
        default:
         {
          sFishResRef = "ry_rak";
          sSuccessMessage = "A rak je tvuj.";
          break;
         }
       }
     }
     // Slaná voda
     else if(iTypVody == 2) {
       switch (iRandom)
       {
            // ---------------begin saltwater fish descriptors
  // fish01 - treska - ry_ryba_treska
  // fish02 - ry_ryba_modm
  // fish03 - ry_ryba_zralok
        case 1:
         {
          sFishResRef = "ry_ryba_treska";
          sSuccessMessage = "Podarilo se Ti chytit tresku...";
          break;
         }
        case 2:
         {
          sFishResRef = "ry_ryba_modm";
          sSuccessMessage = "Chytil jsi pořádnou rybu";
          break;
         }
        default:
         {
           sFishResRef = "ry_ryba_zralok";
           sSuccessMessage = "Chytil jsi Zraloka";
           break;
         }
       }
     }
     else {
       sFishResRef = "";
       sSuccessMessage = "Voda nevypadá dobře a divně páchne. Nevidíš žádné ryby";
     }

    //Assign a 1 in 20 chance of a non-fish retrieval
    if (d20(1) == 10)
     {
      iFishNormalFlag = Random(6);
      switch (iFishNormalFlag)
       {
        case 1:
         {
          sFishResRef = "me_jung_001";
          AssignCommand(oPC,DelayCommand(11.5,CreateAnObject(sFishResRef,oPC,1)));
          sSuccessMessage = "Po chvilce chytani si ti podarilo vytahnout lidskou lebku.";
          break;
         }
        case 2:
         {
          sFishResRef = "me_jung_001";
          AssignCommand(oPC,DelayCommand(11.5,CreateAnObject(sFishResRef,oPC,1)));
          sSuccessMessage = "Po chvilce chytani se ti podarilo vytahnout hroudu spinavych hadru.";
          break;
         }
        case 3:
         {
          sFishResRef = "me_jung_001";
          AssignCommand(oPC,DelayCommand(11.5,CreateAnObject(sFishResRef,oPC,1)));
          sSuccessMessage = "Po chvilce chytani se ti podarilo vytahnout mrtvolku nejakeho zviratka.";
          break;
         }
        case 4:
         {
          AssignCommand(oPC,DelayCommand(11.0,PlaySound("al_an_bugs1")));
          sFishResRef = "nw_btlstink";  // lesser water beetle
          if (GetHitDice(oPC) > 6) sFishResRef = "nw_btlstink"; // water beetle
          if (GetHitDice(oPC) > 9) sFishResRef = "nw_btlstink";  // greater water beetle
          if (Random(1000)<300) sFishResRef = "nw_btlstink";
          if (Random(1000)<100) sFishResRef = "nw_btlstink";
          AssignCommand(oPC,DelayCommand(11.5,CreateAMonster(sFishResRef,oPC,1)));
          sSuccessMessage = "Vyrusil(a) jsi vodniho brouka!";
          break;
         }
        case 5:
         {
          AssignCommand(oPC,DelayCommand(11.0,PlaySound("al_an_bugs1")));
          sFishResRef = "nw_spidgiant";   // small water spider
          if (GetHitDice(oPC) > 6) sFishResRef = "nw_spidgiant";   // water spider
          if (GetHitDice(oPC) > 9) sFishResRef = "nw_spidgiant";   // large water spider
          if (Random(1000)<300) sFishResRef = "nw_spidgiant";
          if (Random(1000)<100) sFishResRef = "nw_spidgiant";
          AssignCommand(oPC,DelayCommand(11.5,CreateAMonster(sFishResRef,oPC,1)));
          sSuccessMessage = "Vyrusil(a) jsi vodniho pavouka!";
          break;
         }
        default:
         {
          AssignCommand(oPC,DelayCommand(11.5,(CreatePlaceable(oPC, "zep_cps_trod_005",GetLocation(oPC),600.0))));
          sSuccessMessage = "Podarilo se ti vytahnout z vody mrtvolu!";
          break;
         }
       }

     }
    AssignCommand(oPC,DelayCommand(11.0,DelayText(oPC,sSuccessMessage)));
    if (iFishNormalFlag == 0)
      {
       //chance of fishing up map
       if (iFishingChance>800)
        {
         if (Random(1000)>950)
          {
           if (Random(1000)>990) iFishNormalFlag++;
           if (iFishingChance>900)
            {
             if (Random(1000)>990) iFishNormalFlag++;
            }
           if (iFishingChance>999)
            {
             if (Random(1000)>990) iFishNormalFlag++;
            }
          }
        }
       if (iFishNormalFlag==0)
         {
          AssignCommand(oPC,DelayCommand(11.5,CreateAnObject(sFishResRef,oPC,1)));
         }
        else
         {
          string sTempResRef;
          if (iFishNormalFlag==1) sTempResRef="_undecoded_tmap1";
          if (iFishNormalFlag==2) sTempResRef="_undecoded_tmap2";
          if (iFishNormalFlag==3) sTempResRef="_undecoded_tmap3";

          AssignCommand(oPC,DelayCommand(11.1,DelayText(oPC,sSuccessMessage)));
          AssignCommand(oPC,DelayCommand(11.5,CreateAnObject(sFishResRef,oPC,1)));
          AssignCommand(oPC,DelayCommand(11.9,CreateAnObject(sTempResRef,oPC,1)));
          AssignCommand(oPC,DelayCommand(12.1,DelayText(oPC,"You also pull out a waterlogged piece of old parchment!")));
         }
      }

   }




  //Begin freshwater fish descriptors
  // fish001 - okoun - ry_ryba_okoun
  // fish002 - kapr potocni - ry_ryba_kapp
  // fish003 - rak - ry_rak
  // fish004 - kapr - ry_ryba_kapr
  // fish005 - pstruh - ry_ryba_pstruh
  // fish006 - lin - ry_ryba_lin
  // fish007 - cejn - ry_ryba_cejn
  // fish008 - uhor - ry_ryba_uhor


  // ---------------begin saltwater fish descriptors
  // fish01 - treska - ry_ryba_treska
  // fish02 - ry_ryba_modm
  // fish03 - ry_ryba_zralok



  //Ensure no more than 1 skill gain every 10 seconds to avoid token droppage.
      if (iSkillGain ==1)
       {
        if (GetLocalInt(oPC,"iSkillGain")!= 0)
          {
           iSkillGain = 0;
          }
         else
          {
           SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
          }
       }


  if (iSkillGain ==1)
    {
     string sOldSkill = "";
     string sOldSkill2 = "";
     iFishingSkill++;
     sOldSkill2 = IntToString(iFishingSkill);
     sOldSkill = "."+GetStringRight(sOldSkill2,1);
     if (iFishingSkill > 9)
       {
        sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
       }
      else
       {
        sOldSkill = "0"+sOldSkill;
       }
     if (iFishingSkill <= 1000)
      {
       AssignCommand(oPC,DelayCommand(12.0,DelaySkill(oPC,iFishingSkill, sOldSkill)));
       //DelayCommand(12.0,SetTokenPair(oPC,14,13,iFishingSkill));
       //DelayCommand(12.0,SendMessageToPC(oPC,"=================================="));
       //DelayCommand(12.0,SendMessageToPC(oPC,"Your skill in fishing has gone up!"));
       //DelayCommand(12.0,SendMessageToPC(oPC,"Current fishing skill : "+ sOldSkill+"%"));
       //DelayCommand(12.0,SendMessageToPC(oPC,"=================================="));
      }
    }


}

void CreateAnObject(string sResource, object oPC, int iStackSize)
 {
  if (GetDistanceBetweenLocations(GetLocalLocation(oPC,"lIWasHere"),GetLocation(oPC))<0.9)
  CreateItemOnObject(sResource,oPC,iStackSize);
  return;
 }

void CreateAMonster(string sMonster, object oPC, int iNumberOfMonsters)
 {
  if (GetDistanceBetweenLocations(GetLocalLocation(oPC,"lIWasHere"),GetLocation(oPC))>0.8) return;
  object oTemp = OBJECT_INVALID;
  location lSelf = GetLocation(oPC);
  vector vSelf = GetPosition(oPC);
  object oArea = GetArea(oPC);
  vector vFire;
  int vDirection;
  float fSelf;
  int iRandom;
  float fDistance;
  location lFire;

  for (iNumberOfMonsters; iNumberOfMonsters>0; iNumberOfMonsters--)
   {
    SendMessageToPC(oPC,"Oops!  You disturbed a Monster!!");
    fSelf = GetFacing(oPC)+Random(360);

    fDistance = (IntToFloat(Random(100)+1)/10.0);
    vFire = vSelf + (AngleToVector(fSelf) * fDistance);
    lFire = Location(oArea,vFire,fSelf);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE,sMonster,lFire,FALSE);
    AssignCommand(oTemp,SetFacingPoint(AngleToVector(GetFacing(oPC))));
    AssignCommand(oTemp, ActionAttack(oPC,FALSE));
   }
  return;
 }

void CancelFishing(object oPC, location lCurrent)
 {
  if (GetDistanceBetweenLocations(GetLocalLocation(oPC,"lIWasHere"),GetLocation(oPC))>0.4)
   {
    SetLocalInt(oPC,"iCancelFishing",99);
   }
  if (GetIsDead(oPC)==TRUE) SetLocalInt(oPC,"iCancelFishing",99);
  if (GetArea(oPC)!=GetAreaFromLocation(GetLocalLocation(oPC,"lIWasHere"))) SetLocalInt(oPC,"iCancelFishing",99);
  if(GetLocalInt(oPC,"ku_fishingtime") > ku_GetTimeStamp() )
    AssignCommand(oPC,ExecuteScript("me_nc_cfishfresh",oPC));
  return;
 }

void CreatePlaceable(object oPC, string sObject, location lPlace, float fDuration)
{
  if (GetDistanceBetweenLocations(GetLocalLocation(oPC,"lIWasHere"),GetLocation(oPC))>0.8) return;
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
  return ;
}

void DelayText(object oPC, string sMessage)
 {
  if (GetDistanceBetweenLocations(GetLocalLocation(oPC,"lIWasHere"),GetLocation(oPC))>0.8) return;
  FloatingTextStringOnCreature(sMessage,oPC,FALSE);
  return;
 }

void DelaySkill(object oPC, int iFishingSkill, string sOldSkill)
 {
  if (GetDistanceBetweenLocations(GetLocalLocation(oPC,"lIWasHere"),GetLocation(oPC))>0.8) return;
  //SetTokenPair(oPC,14,13,iFishingSkill);
  CnrSetPersistentInt(oPC,"iFishingSkill",iFishingSkill);
  SendMessageToPC(oPC,"==================================");
  SendMessageToPC(oPC,"Tvoje dovednost rybareni se zlepsila!");
  SendMessageToPC(oPC,"Soucasna dovednost je : "+ sOldSkill+"%");
  SendMessageToPC(oPC,"==================================");
  //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0) GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP"));
  return;
 }

