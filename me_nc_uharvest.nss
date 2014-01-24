//#include "_persist_01a"
#include "cnr_persist_inc"
#include "ku_libtime"
void CreateAnObject(string sResource, object oPC, int iStackSize);
void CreatePlaceable(string sObject, location lPlace, float fDuration, string sNewTag);
void  DestroiPlant(float fRespawnTime, object oPC);

void main()
{
  int iDebug = TRUE;
  float fRespawnTime = 6000.0;
  int iStand = FALSE;
  object oSelf = OBJECT_SELF;
  object oPC = GetLastUsedBy();
  object oItem = OBJECT_SELF;
  string sTagSelf = GetTag(OBJECT_SELF);
  string sResRefSelf= GetResRef(OBJECT_SELF);
  string sItemResRef = "";  // resref plodiny
  int iAddQ = 0; // pocet max plodin v rostlince navic
  string sSuccess = "";
  int iSkillGain = 0;
  int iPenalty = 0;

  if (GetLocalInt(oPC,"iAmDigging")!= 0)
   {
    FloatingTextStringOnCreature("Uz sbiras!",oPC,FALSE);
    DelayCommand(8.1,SetLocalInt(oPC,"iAmDigging",0));
    return;
   }
  SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(8.0,SetLocalInt(oPC,"iAmDigging",0));


  int iHarvestSkill = CnrGetPersistentInt(oPC,"iHarvestSkill");
  int iHarvestChance = iHarvestSkill;
  if (iHarvestSkill <350)
   {
    iHarvestChance = GetAbilityScore(oPC,ABILITY_INTELLIGENCE)*5;
    iHarvestChance = iHarvestChance + (GetAbilityScore(oPC,ABILITY_WISDOM)*3);
    iHarvestChance = iHarvestChance + (GetAbilityScore(oPC,ABILITY_CHARISMA)*2);
    iHarvestChance = iHarvestChance *3;
    if (iHarvestChance>350)iHarvestChance = 350;
    if (iHarvestSkill>iHarvestChance) iHarvestChance = iHarvestSkill;
   }

   // houby
   if (GetStringLeft(sTagSelf,8)=="tc_houba")
   {
        sItemResRef = sTagSelf;
        iAddQ = 10;
   }

   // bylinky
   else if (GetStringLeft(sTagSelf,9)=="tc_bylina")
   {
        sItemResRef = sTagSelf;
        iAddQ = 10;
   }
// stare houby
  else if(sTagSelf == "Mushroom001")
    {
        sItemResRef = "cnrmushroomwht";
        iAddQ = 4;
    }
  else if(sTagSelf == "Mushroom002")
    {
        sItemResRef = "cnrmushroomblk";
        iAddQ = 4;
    }
  else if(sTagSelf == "Mushroom003")
    {
        sItemResRef = "cnrmushroomred";
        iAddQ = 4;
    }
  else if(sTagSelf == "Mushroom004")
    {
        sItemResRef = "cnrmushroompurp";
        iAddQ = 4;
    }
  else if(sTagSelf == "Mushroom005")
    {
        sItemResRef = "cnrmushroomspot";
        iAddQ = 4;
    }
  else if(sTagSelf == "Mushroom006")
    {
        sItemResRef = "cnrmushroomyel";
        iAddQ = 4;
    }

   // rostlinky
   else if (sTagSelf == "cnrBluberryPlant")
    {
        sItemResRef = "cnrbluberryfruit"; // boruvky
        iAddQ = 3;
    }
   else if (sTagSelf == "cnrBirchPlant")
    {
        sItemResRef = "cnrbirchbark"; // brezova kura
        iAddQ = 1;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrCottonPlant")
    {
        sItemResRef = "cnrcotton";
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrEldberryPlant")
    {
        sItemResRef = "cnreldberryfruit"; //
        iAddQ = 3;
    }
   else if (sTagSelf == "cnrThistlePlant")
    {
        sItemResRef = "cnrthistleleaf"; //
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrCrnberryPlant")
    {
        sItemResRef = "cnrcrnberryfruit"; //
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrHazelPlant")
    {
        sItemResRef = "cnrhazelleaf"; //
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrGarlicPlant")
    {
        sItemResRef = "cnrgarlicclove"; //
        iAddQ = 1;
    }
   else if (sTagSelf == "cnrEchinaceaPlant")
    {
        sItemResRef = "cnrechinacearoot"; //
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrChamomilePlant")
    {
        sItemResRef = "cnrchamomilefwr"; //
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrHawthornPlant")
    {
        sItemResRef = "cnrhawthornfwr"; //
        iAddQ = 0;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrGrapePlant")
    {
        sItemResRef = "cnrgrapefruit"; //
        iAddQ = 2;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrPearPlant")
    {
        sItemResRef = "cnrpearfruit"; //
        iAddQ = 2;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrHopsPlant")
    {
        sItemResRef = "cnrHopsFlower"; //
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrApplePlant")
    {
        sItemResRef = "cnrapplefruit"; //
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrJuniperPlant")
    {
        sItemResRef = "cnrjuniperfruit"; //
        iAddQ = 2;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrMaplePlant")
    {
        sItemResRef = "cnrmaplesyrup"; //
        iAddQ = 2;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrBarleyPlant")
    {
        sItemResRef = "cnrbarleyraw"; //
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrCoverPlant")
    {
        sItemResRef = "cnrcloverleaf"; //
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrChestnutPlant")
    {
        sItemResRef = "cnrchestnutfruit"; //
        iAddQ = 2;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrNettlePlant")
    {
        sItemResRef = "cnrnettleleaf"; //
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrComfreyPlant")
    {
        sItemResRef = "cnrcomfryroot"; //
        iAddQ = 2;

    }
   else if (sTagSelf == "cnrCornPlant")
    {
        sItemResRef = "cnrcornraw"; //
        iAddQ = 1;
    }
   else if (sTagSelf == "cnrCatnipPlant")
    {
        sItemResRef = "cnrcatnipleaf"; //
        iAddQ = 1;
    }
   else if (sTagSelf == "cnrGinsengPlant")
    {
        sItemResRef = "cnrginsengroot"; //
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrHazelnutPlant")
    {
        sItemResRef = "cnrhazelnutfruit"; //
        iStand = TRUE;
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrRspberryPlant")
    {
        sItemResRef = "cnrrspberryfruit"; //
        iStand = TRUE;
        iAddQ = 3;
    }
   else if (sTagSelf == "cnrAlmondPlant")
    {
        sItemResRef = "cnralmondfruit"; //
        iStand = TRUE;
        iAddQ = 3;
    }
   else if (sTagSelf == "cnrPepmintPlant")
    {
        sItemResRef = "cnrpepmintleaf"; //;
        iAddQ = 1;
    }
   else if (sTagSelf == "cnrCalendulaPlant")
    {
        sItemResRef = "cnrcalendulafwr"; //;
        iAddQ = 4;
    }
   else if (sTagSelf == "cnrPecanPlant")
    {
        sItemResRef = "cnrpecanfruit"; //;
        iAddQ = 3;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrWalnutPlant")
    {
        sItemResRef = "cnrwalnutfruit"; //;
        iAddQ = 3;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrBlkberryPlant")
    {
        sItemResRef = "cnrblkberryfruit"; //;
        iAddQ = 3;
        iStand = TRUE;
    }
   else if (sTagSelf == "cnrOatsPlant")
    {
        sItemResRef = "cnroatsraw"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrWheatPlant")
    {
        sItemResRef = "cnrwheatraw"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrAloePlant")
    {
        sItemResRef = "cnraloeleaf"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrAngelicaPlant")
    {
        sItemResRef = "cnrangelicaleaf"; //;
        iAddQ = 1;
    }
   else if (sTagSelf == "cnrRicePlant")
    {
        sItemResRef = "cnrriceraw"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrBkCohoshPlant")
    {
        sItemResRef = "cnrblkcohoshroot"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrSagePlant")
    {
        sItemResRef = "cnrsageleaf"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrSkullcapPlant")
    {
        sItemResRef = "cnrskullcapleaf"; //;
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrCherryPlant")
    {
        sItemResRef = "cnrcherryfruit"; //;
        iAddQ = 2;
    }
   else if (sTagSelf == "cnrGingerPlant")
    {
        sItemResRef = "cnrgingerroot"; //;
        iAddQ = 0;
    }
   else if (sTagSelf == "cnrRyePlant")
    {
        sItemResRef = "cnrryeraw"; //;
        iAddQ = 2;
    }

   //nastaveni poctu surovin
   int iMaxHarvest = GetLocalInt(OBJECT_SELF,"iMaxHarvest");
   if (iMaxHarvest==0)
    {
      iMaxHarvest = iAddQ/2 + 1 + d3(2)/2;
      SetLocalInt(OBJECT_SELF,"iMaxHarvest",iMaxHarvest);
    }

  if (iStand)
   {
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,8.0));
   }
  else
   {
      AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,8.0));
   }
  PlaySound("as_na_grassmove1");
  DelayCommand(2.5,PlaySound("as_na_grassmove1"));
  DelayCommand(5.0,PlaySound("as_na_grassmove1"));
  // pocet rostlinek podle skillu
  // uprava poctu hub
  int plantNum = 1;
  if (iHarvestSkill >= 100)
      {
      if (Random(10)>= 5) plantNum = plantNum + 1;
      }
  if (iHarvestSkill >= 250)
      {
      if (Random(10)>= 5) plantNum = plantNum + 1;
      }
  if (iHarvestSkill >= 500)
      {
      if (Random(10)>= 5) plantNum = plantNum + 1;
      }
  if (iHarvestSkill >= 750)
      {
      if (Random(10)>= 5) plantNum = plantNum + 1;
      }

  // oprava obtiznosti   if (Random(1000)<=iHarvestChance)
  if (Random(10) > 1)
    {
     if (Random(1000)>=iHarvestSkill)
      {
       if (d10(1)+1 >= iHarvestChance/100) iSkillGain = 1;
      }
     //AssignCommand(oPC,DelayCommand(7.5,PlaySound("as_cv_woodbreak3")));
     DelayCommand(8.0,AssignCommand(oPC,CreateAnObject(sItemResRef,oPC,plantNum)));
     DelayCommand(8.0,FloatingTextStringOnCreature("Sklizen se dari!",oPC,FALSE));
     iMaxHarvest = iMaxHarvest -1;
     SetLocalInt(OBJECT_SELF,"iMaxHarvest",iMaxHarvest);
     if (iMaxHarvest==0||GetLocalInt(OBJECT_SELF,"iAmDestroyed")==99)
      {
         SetUseableFlag(OBJECT_SELF, FALSE);
         SetLocalInt(oPC,"iAmDigging",0);
         DestroiPlant(fRespawnTime,oPC);
      }
    }
   else
    {
     DelayCommand(8.0,FloatingTextStringOnCreature("Nezadarilo se ti nic ziskat..",oPC,FALSE));
     iMaxHarvest = iMaxHarvest -1;
     SetLocalInt(OBJECT_SELF,"iMaxHarvest",iMaxHarvest);
     if (iMaxHarvest==0||GetLocalInt(OBJECT_SELF,"iAmDestroyed")==99)
      {
         SetUseableFlag(OBJECT_SELF, FALSE);
         SetLocalInt(oPC,"iAmDigging",0);
        DestroiPlant(fRespawnTime,oPC);
      }
    }


   //Ensure no more than 1 skill gain every 10 seconds to avoid token droppage.
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

  if (iSkillGain ==1)
    {
     string sOldSkill = "";
     string sOldSkill2 = "";
     iHarvestSkill++;
     sOldSkill2 = IntToString(iHarvestSkill);
     sOldSkill = "."+GetStringRight(sOldSkill2,1);
     if (iHarvestSkill > 9)
       {
        sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
       }
      else
       {
        sOldSkill = "0"+sOldSkill;
       }
     if (iHarvestSkill <= 1000)
      {

       DelayCommand(8.1,CnrSetPersistentInt(oPC,"iHarvestSkill",iHarvestSkill));
       DelayCommand(8.1,SendMessageToPC(oPC,"==================================="));
       DelayCommand(8.2,SendMessageToPC(oPC,"Tvoje dovednost sberu se zvysila!"));
       DelayCommand(8.3,SendMessageToPC(oPC,"Aktualni dovednost sberu je : "+ sOldSkill+"%"));
       DelayCommand(8.4,SendMessageToPC(oPC,"==================================="));
      }
    }




}

void DestroiPlant(float fRespawnTime, object oPC)
 {
       object oTemp = OBJECT_INVALID;
       DelayCommand(8.1,SetLocalInt(oPC,"iAmDigging",0));
       oTemp = CreateObject(OBJECT_TYPE_PLACEABLE,"temp_placeable",GetLocation(OBJECT_SELF),FALSE);
       string sResSelf = GetResRef(OBJECT_SELF);
       string sTagSelf = GetTag(OBJECT_SELF);
       AssignCommand(oTemp,DelayCommand(6.5 + fRespawnTime,CreatePlaceable(sResSelf,GetLocation(OBJECT_SELF),0.0,sTagSelf)));
       DestroyObject(oTemp,20.0 + fRespawnTime);
       DestroyObject(OBJECT_SELF,0.0);
 }


void CreateAnObject(string sResource, object oPC, int iStackSize)
 {
  object oItem = CreateItemOnObject(sResource,oPC,iStackSize);
  SetIdentified( oItem, TRUE);
  return;
 }

void CreatePlaceable(string sObject, location lPlace, float fDuration, string sNewTag)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE,sNewTag);
  if (GetStringLeft(sNewTag,9)=="tc_bylina")
  {
    SetName(oPlaceable, "Bylinka");
  }
  if (GetStringLeft(sNewTag,8)=="tc_houba")
  {
    SetName(oPlaceable, "Trs hub");
  }
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
}


