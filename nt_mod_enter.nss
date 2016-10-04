#include "me_soul_inc"
#include "aps_include"
//#include "persistence"
//#include "zep_inc_phenos"
//#include "ja_inc_stamina"
//#include "me_pcneeds_inc"
#include "ja_inc_frakce"
//#include "ku_libbase"
#include "ku_exp_time"
// kuly alchymii
#include "tc_constants"
//#include "sh_classes_inc"
#include "sh_deity_inc"
//#include "ku_dlg_inc"
#include "sh_lang_start"
#include "mys_mount_lib"
#include "mys_hen_lib"

void __tellBugged(object oPC, string sMessage);
void __checkInvalidFeats(object oPC, int Remove = FALSE);

int __checkPolymorf(object oPC) {

    effect ePoly = GetFirstEffect(oPC);

    //WriteTimestampedLogEntry("BEFORE polymorph check");
    while(GetIsEffectValid(ePoly)){
        if(GetEffectType(ePoly) == EFFECT_TYPE_POLYMORPH){
          return TRUE;
        }
        ePoly = GetNextEffect(oPC);
    }
    return FALSE;
}

int __checkFeatAbiliesReq(object oPC, int iFeat) {
  int iReq;

  // STR
  iReq = StringToInt(Get2DAString("feat","MINSTR",iFeat));
  if(iReq > 0 && GetAbilityScore(oPC,  ABILITY_STRENGTH, TRUE) < iReq) {
    WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat)+" for STR="+IntToString(GetAbilityScore(oPC,  ABILITY_STRENGTH, TRUE)));
    return FALSE;
  }
  // DEX
  iReq = StringToInt(Get2DAString("feat","MINDEX",iFeat));
  if(iReq > 0 && GetAbilityScore(oPC,   ABILITY_DEXTERITY , TRUE) < iReq) {
    WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat)+" for DEX="+IntToString(GetAbilityScore(oPC,   ABILITY_DEXTERITY , TRUE)));
    return FALSE;
  }
  // INT
  iReq = StringToInt(Get2DAString("feat","MININT",iFeat));
  if(iReq > 0 && GetAbilityScore(oPC,  ABILITY_INTELLIGENCE, TRUE) < iReq) {
    WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat)+" for INT="+IntToString(GetAbilityScore(oPC,ABILITY_INTELLIGENCE, TRUE)));
    return FALSE;
  }
  // WIS
  iReq = StringToInt(Get2DAString("feat","MINWIS",iFeat));
  if(iReq > 0 && GetAbilityScore(oPC,ABILITY_WISDOM , TRUE) < iReq) {
    WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat)+" for WIS="+IntToString(GetAbilityScore(oPC, ABILITY_WISDOM , TRUE)));
    return FALSE;
  }
  // CON
  iReq = StringToInt(Get2DAString("feat","MINCON",iFeat));
  if(iReq > 0 && GetAbilityScore(oPC, ABILITY_CONSTITUTION , TRUE) < iReq) {
    WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat)+" for CON="+IntToString(GetAbilityScore(oPC,   ABILITY_CONSTITUTION , TRUE)));
    return FALSE;
  }
  // CHA
  iReq = StringToInt(Get2DAString("feat","MINCHA",iFeat));
  if(iReq > 0 && GetAbilityScore(oPC, ABILITY_CHARISMA , TRUE) < iReq) {
    WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat)+" for CHA="+IntToString(GetAbilityScore(oPC, ABILITY_CHARISMA , TRUE)));
    return FALSE;
  }

  return TRUE;
}

void __tellBugged(object oPC, string sMessage) {

  if(!GetIsObjectValid(oPC))
    return;

  FloatingTextStringOnCreature(sMessage, oPC, FALSE);
  SendMessageToPC(oPC, sMessage);
  DelayCommand(10.0, __tellBugged(oPC, sMessage));

}

void __buggedPC(object oPC, string sMessage) {

  SetLocalInt(oPC,"JE_POSTAVA_ZABUGOVANA",TRUE);
  WriteTimestampedLogEntry("Bad character: Player "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+": "+sMessage);

  __tellBugged(oPC, sMessage);
  AssignCommand(oPC, SetCommandable(FALSE));
  
}

void __checkInvalidFeats(object oPC, int Remove = FALSE) {
  int iFeats = GetTotalKnownFeatsByLevel(oPC, 1);

  while( iFeats > 0) {
    iFeats--;
    /* If feat did not meet requirements */
    int iFeat = GetKnownFeatByLevel(oPC, 1, iFeats);
    if(!__checkFeatAbiliesReq(oPC, iFeat)) {
      if(Remove)
        RemoveKnownFeat(oPC, iFeat);
      WriteTimestampedLogEntry("BUG! "+GetPCPlayerName(oPC)+" - "+GetName(oPC)+" has invalid feat "+IntToString(iFeat));
    }
  }

}

void __checkSkillPointsProgress(object oPC) {
 int  iSkill = 0;
 for (iSkill=0;iSkill<=27;iSkill++)
 {
    if (GetSkillIncreaseByLevel(oPC,1,iSkill)>0)
    {
         SetLocalInt(oPC,"JE_POSTAVA_ZABUGOVANA",1); //zrusi postave prijem zkusenosti
         break;
    }
 }
}


void DismountAfterActions(object oPC, object oSoul);

// Compose text info about Thalie-datum
string GetInGameDateMessage()
{
    return "Datum: hodina " + IntToString(GetTimeHour()) + "., "
           + "dne " + IntToString(GetCalendarDay()) + "., "
           + "mìsíce " + IntToString(GetCalendarMonth()) + "., "
           + "roku " + IntToString(GetCalendarYear()) + " k.l.";
}

void SendDMWelcomeMessages(object oPC)
{
    SendMessageToPC(oPC, GetInGameDateMessage());
}

void SendPCWelcomeMessages(object oPC)
{
    SendMessageToPC(oPC, GetInGameDateMessage());
}

void DestroyTHSkins(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        if (GetTag(oItem) == "th_pcskin") DestroyObject (oItem,1.0);
        oItem = GetNextItemInInventory(oPC);
    }
}

void SafeJump(object oPC, location lLoc){
    string sAre = GetTag(GetArea(oPC));
    if(sAre == "VitejtevThalii"){
        //zep_Dismount(oPC, "ja_kun_getdown");
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void __saveAllPlayers() {
  object oPC = GetFirstPC();

  while(GetIsObjectValid(oPC)) {
    if(!GetIsDM(oPC))
      SavePlayer(oPC,0);

    oPC = GetNextPC();
  }

}
/*
void UnspellItems(object oPC){
     object oItem = GetFirstItemInInventory(oPC);
     int iGold, iWeight;

    //ohen na zbrani
    itemproperty prop = GetFirstItemProperty(oItem);
    //Search for properties
    while(GetIsItemPropertyValid(prop))
    {
       if(GetItemPropertyDurationType(prop) == DURATION_TYPE_TEMPORARY)
           RemoveItemProperty(oItem, prop);
       prop = GetNextItemProperty(oItem);
    }

    // Vaha a cena predmetu
    iGold = GetLocalInt(oItem,"GOLDPIECEVALUE");
    iWeight = GetLocalInt(oItem,"WEIGHT");
    if(iGold > 0 && iGold != GetGoldPieceValue(oItem))
      SetGoldPieceValue(oItem,iGold);
    if(iWeight > 0 && iWeight != GetWeight(oItem))
      SetItemWeight(oItem,iWeight);

    oItem = GetNextItemInInventory(oPC);

    //~ohen na zbrani

}
 */
void FixMovementSpeed(object oPC) {
  int iAppearance = GetAppearanceType(oPC);
  if(GetIsDM(oPC))
    return;

  switch(iAppearance) {
    case 984: //Kobold
    case 985: //Half ogre
    case 1000: //Wemic
    case 1002: //Brownie
    case 1030: //Armor stand
    case 1052: //Illithid
    case 1769: //Skeleton
      SetMovementRate(oPC,MOVEMENT_RATE_PC);
      break;
    default:
      //none
      break;
  }
}

void AddPlayerToDump(object oPC){
    string sPC = SQLEncodeSpecialChars(GetName(oPC));
    int iID    = GetLocalInt(GetModule(), "JA_DUMP_ID");

    SetLocalInt(GetModule(), "JA_DUMP_ID", iID+1);
    SetLocalInt(oPC, "JA_DUMP_ID", iID);
    string sPortrait = GetPortrait(oPC);

    string sql = "INSERT INTO dump (id, name, portrait) VALUES ("+IntToString(iID)+", '"+sPC+"', '"+sPortrait+"');";
    SQLExecDirect(sql);
}

void CheckHasSpecialItems(object oPC){

    //SendMessageToPC(oPC, "DAVAM PREDMETY");
    /*if(!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_follow"))){
       CreateItemOnObject("dmfi_pc_follow", oPC);
    }
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_dicebag"))){
       CreateItemOnObject("dmfi_pc_dicebag", oPC);
    }
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, "dmfi_pc_emote"))){
       CreateItemOnObject("dmfi_pc_emote", oPC);
    }*/
    if(!GetIsObjectValid(GetSoulStone(oPC))){
       CreateItemOnObject("sy_soulstone", oPC);
    }
}

void UpdateLoginIP(object oPC)
{

     if(!GetIsObjectValid(oPC))
       return;

     string Player = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
     string IP     = GetPCIPAddress(oPC);
     string sql = "UPDATE pwplayers SET ip_last_logged = '"+IP+"' WHERE login='"+Player+"';";
     SQLExecDirect(sql);
}

// Set dislike to all PCs of oposite faction (underdark/surf)
void DislikeFactions(object oPC) {
  object oSoul = GetSoulStone(oPC);
  int iAutodislike = GetLocalInt(oSoul,"KU_AUTODISLIKE");


  int iUnderdark = Subraces_GetIsCharacterFromUnderdark(oPC);
  object oTarget = GetFirstPC();
  int iFaction = GetFactionId (oPC);
  while(GetIsObjectValid(oTarget)) {

    if(iAutodislike || GetLocalInt(GetSoulStone(oTarget),"KU_AUTODISLIKE")) {
      if(GetFactionId (oTarget) != iFaction &&
         Subraces_GetIsCharacterFromUnderdark(oTarget) != iUnderdark) {
        SetPCDislike(oPC,oTarget);
      }
    }
    oTarget = GetNextPC();
  }

}

void GiveStartpackage(object oPC) {
  object oItem;
  int i;
  GiveGoldToCreature(oPC, 5000);
  //kresadlo
  CreateItemOnObject("sy_kresadlo00", oPC, 1);
  // Lektary
  for(i = 0; i<10; i++) {
    CreateItemOnObject("sh_it_elx10_heal", oPC, 10);
  }
  // Lekarny
  CreateItemOnObject("sh_it_band1", oPC, 10);
  oItem = CreateItemOnObject("sy_cutora_full", oPC, 1);
  SetLocalInt(oItem,"VodaType",1);
  //Jídlo
  CreateItemOnObject("ke_oblhousk", oPC, 10);
  
}

void main()
{
    object oPC = GetEnteringObject();
// FAZE 1. BANY-------------------------------------------------------------------
//safety

    string Player = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
    string IP     = GetPCIPAddress(oPC);
    string CDKEY  = GetPCPublicCDKey(oPC);

    WriteTimestampedLogEntry("Try to login: Player "+Player+" from "+IP+":"+IntToString(GetPCPort(oPC))+" CDKEY:"+CDKEY+", with character: "+GetName(oPC)+".");

    string sql = "SELECT IP, CDKEY, NOIPCHECK, privilegies FROM pwplayers WHERE login='"+Player+"';";
    SQLExecDirect(sql);
    if (SQLFetch() == SQL_SUCCESS){
        string n_IP = SQLDecodeSpecialChars(SQLGetData(1));
        string n_CDKEY = SQLDecodeSpecialChars(SQLGetData(2));
        int n_NOIPCHECK = StringToInt(SQLGetData(3));
        int n_priv = StringToInt(SQLGetData(4));

        SetLocalInt(oPC, "KU_PLAYER_PRIVILEGIES",n_priv);

        if( (n_IP != IP && n_NOIPCHECK == 0) || n_CDKEY != CDKEY ){
         BootPC(oPC);
         WriteTimestampedLogEntry("UNAUTHORIZED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", should be "+n_IP+", "+n_CDKEY);
         return;
        }

        if( GetIsDM(oPC) && (n_priv % 2 < 1) ) {
          BootPC(oPC);
          WriteTimestampedLogEntry("UNAUTHORIZED DM LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", should be "+n_IP+", "+n_CDKEY+" Don't have  DM privilegies");
          return;
        }
        if( (n_priv < 0) ) {
          BootPC(oPC);
          WriteTimestampedLogEntry("BANNED OR NOT AUTHORIZED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", should be "+n_IP+", "+n_CDKEY+" Don't have  DM privilegies");
          return;
        }
    }
    else{
         BootPC(oPC);
         WriteTimestampedLogEntry("UNAUTHORIZED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", he has no registration.");
         return;
    }

    /* IP bany */

    int iFrom=0, iTo;
    string ip_1, ip_2, ip_3, ip_4;
    int iBaned = FALSE;
    string sBanIP = "";
    iTo = FindSubString(IP,".",iFrom);
    ip_1 = GetSubString(IP,iFrom,iTo - iFrom);
    iFrom = iTo + 1;
    iTo = FindSubString(IP,".",iFrom);
    ip_2 = GetSubString(IP,iFrom,iTo - iFrom);
    iFrom = iTo + 1;
    iTo = FindSubString(IP,".",iFrom);
    ip_3 = GetSubString(IP,iFrom,iTo - iFrom);
    iFrom = iTo + 1;
    ip_4 = GetSubString(IP,iFrom,3);

    sql = "SELECT id, ip FROM IP_BANS WHERE IP IN ('"+IP+"','"+ip_1+"."+ip_2+"."+ip_3+"','"+ip_1+"."+ip_2+"','"+ip_1+"');";
    SQLExecDirect(sql);
    if (SQLFetch() == SQL_SUCCESS){
      iBaned = TRUE;
      sBanIP = SQLGetData(2);
    }

    /* IF this IP is BANNED */
    if (iBaned){
      sql = "SELECT id FROM IP_BANS WHERE excludes='"+Player+"';";
      SQLExecDirect(sql);
      if (SQLFetch() != SQL_SUCCESS){
         BootPC(oPC);
         WriteTimestampedLogEntry("BANNED LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", tried to login from BANNED IP '"+sBanIP+"'");
         return;
      }
    }
    /* ~IP bany */
    if(GetIsDM(oPC))
    {
        // Send welcome messages to DM player
        DelayCommand(30.0, SendDMWelcomeMessages(oPC));

        return;
    }
//~safety*/


 // DestroyTHSkins(oPC);
 /* Jestli je dobrodruh*/
 if (GetClassByPosition(1,oPC)!=CLASS_TYPE_ROGUE)
   {
        //WriteTimestampedLogEntry("LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", NENI DOBRODRUH.");
     __buggedPC(oPC, "Chyba! Postava nebyla zalozena s povolanim DOBRODRUH!");
   }
 
 if(GetHitDice(oPC)==1) {
   int iSkillSum = 0;
   int iSkill = 0;
   for (iSkill=0;iSkill<=27;iSkill++) 
     iSkillSum +=GetSkillRank(iSkill,oPC,TRUE);

   if (iSkillSum >0 )
   {
//      WriteTimestampedLogEntry("LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", dal body do skillu.");
     __buggedPC(oPC, "Chyba! Pri zakladani postavy jsi dal body do skillu! Zaloz postavu znovu!");
   }
 }

 // Check duplicit character
 int iPlayed = GetPersistentInt(oPC, "PLAYED","pwchars");
 object oSoulStone = GetSoulStone(oPC);
 if(iPlayed && !GetIsObjectValid(oSoulStone)) {
    BootPC(oPC);
    WriteTimestampedLogEntry("LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", Duplicit character "+GetName(oPC)+".");
    return;
 }

 //------- PODVODY
 // kontrola na to zda postava na prvnim lvlu dala body do skillu
 DelayCommand(15.0, __checkSkillPointsProgress(oPC));

 if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)
 {
        int iDomain1 = GetClericDomain(oPC,1);
        int iDomain2 = GetClericDomain(oPC,2);
        int iDeity = GetThalieDeity(oPC);
        if (!GetIsDeityAndDomainsValid(iDeity, iDomain1,iDomain2))
        {
            SetLocalInt(oPC,"JE_POSTAVA_ZABUGOVANA",1); //zrusi postave prijem zkusenosti
        }
 }
 //Opravy chyb//
 int iMonkLevel = GetLevelByClass(CLASS_TYPE_MONK,oPC);
 if (iMonkLevel > 0 && iMonkLevel<11) RemoveKnownFeat(oPC,FEAT_MONK_AC_BONUS);
 //~Opravy chyb//
 // Craft tools
 if(!GetHasFeat(1400, oPC)) // FEAT_POUZITI_ZBRANE_LEHKY_KRUMPAC_neprirazeno
   AddKnownFeat(oPC, 1400, 1);
 if(GetHasFeat(1419, oPC)) // FEAT_POUZITI_ZBRANE_TEZKY_KRUMPAC_neprirazeno
   RemoveKnownFeat(oPC, 1419);
   //AddKnownFeat(oPC, 1419, 1);
 if(!GetHasFeat(1410, oPC)) // FEAT_POUZITI_ZBRANE_RUCNI_SEKERA_neprirazeno
   AddKnownFeat(oPC, 1410, 1);
 //~Craft tools
 DelayCommand(120.0,UpdateLoginIP(oPC));

 AddPlayerToDump(oPC);

 //zapoznakovani Shaman - vyhazuje ze serveru
 // FAZE 2. ROZDELENI - PRVNI VSTUP-------------------------------------------------------------------
 int iPlayedAfterReboot = GetLocalInt(oPC, "PLAYED");
 if (iPlayed)  //uz tady byl
 {
    int iHP = GetPersistentInt(oPC, "HP");
    if(!iPlayedAfterReboot)
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oPC)-iHP,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
 }
 else //prvni lognuti
 {
       //je tu poprvy
        object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            DestroyObject(oItem, 0.2); // always destroy item after delay.
            oItem = GetNextItemInInventory(oPC);
        }

        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
        int i;
        for(i = 0; i<=17; i++) {
          oItem = GetItemInSlot(i, oPC);
          if(GetIsObjectValid(oItem)) {
            DestroyObject(oItem, 0.2); // always destroy item after delay.
          }
        }
        TakeGoldFromCreature(GetGold(oPC), oPC, TRUE);
        //GiveGoldToCreature(oPC, 3000);
        SetPersistentInt(oPC, "HP", GetCurrentHitPoints(oPC));
        RepairObcanThalie(oPC);
        GiveStartpackage(oPC);
        SetPersistentInt(oPC, "PLAYED",1,0,"pwchars");
        /* remove feats which player should not have */
        __checkInvalidFeats(oPC,TRUE);

 }
 // Get soul
 oSoulStone = CreateSoulStone(oPC);

 // Subdual damage
 SetLocalInt(oPC,"SUBDUAL_MODE",GetLocalInt(oSoulStone,"SUBDUAL_MODE"));

 setFactionsToPC(oPC, getFaction(oPC));
 ku_OnClientEnter(oPC); // Inicializace eXPiciho systemu pri loginu hrace.
 Subraces_InitSubrace( oPC ); //Inicializace subrasy
 //KU_CalcAndGiveSkillPoints(oPC); //Nastav postave spravne volne skillpointy

 // PC Skin
 object oPCSkin = GetPCSkin(oPC);
 SetLocalObject(oSoulStone,"PCSKIN",oPCSkin);


 //povolani
 OnEnterClassSystem(oPC);
 //~povolani
 AddLanguagesOnClientEnter(oPC);
/*

  */
 /* Check for bad duplicit characters */
 /*Promenou PLAYED na soulstone vyuzivam na neco jineho.
 if(iPlayed && !GetLocalInt(oSoulStone,"PLAYED") && GetXP(oPC) < 100) {
   SendMessageToAllDMs("Player "+Player+" logged with duplicit character "+GetName(oPC)+"!!!");
   BootPC(oPC);
   return;
 }
 */
 SetLocalInt(oPC, "HP", GetCurrentHitPoints(oPC));

// string spells = GetPersistentString(oPC, "SPELLS");
// string feats  = GetPersistentString(oPC, "FEATS");
 string sChram = GetPersistentString(oPC, "CHRAM");

 location lLoc = GetPersistentLocation(oPC, "LOCATION");

 SetLocalString(oPC, "CHRAM", sChram);
 SetLocalLocation(oPC, "LOCATION", lLoc);

 SetLocalString(oPC, "NAME", GetName(oPC));
 SetLocalString(oPC, "PLAYERNAME", GetPCPlayerName(oPC));

// pSetSpells(oPC, spells);
// pSetFeats(oPC, feats);

// UnspellItems(oPC);

//horses
 object oTest = GetLocalObject(oPC, "JA_HORSE_OBJECT");
 /*
 if(!GetIsObjectValid(oTest)){
     string sResRef = GetPersistentString( oPC, "HORSE", "pwhorses" );
     if( sResRef != "" ){
         location lHorseLoc = GetPersistentLocation( oPC, "LOCATION", "pwhorses");
         if(!GetIsObjectValid(GetAreaFromLocation(lHorseLoc)))
            lHorseLoc = lLoc;
         object oHorse = CreateObject( OBJECT_TYPE_CREATURE, sResRef, lHorseLoc );
         SetLocalObject(oHorse, "JA_HORSE_PC", oPC);
         SetLocalObject(oPC, "JA_HORSE_OBJECT", oHorse);
         /* Horse name
         string sName = GetPersistentString( oPC, "HORSE_NAME", "pwhorses");
         if(GetStringLength(sName) > 0) {
           SetName(oHorse,sName);
         }
     }
 }  */
//~horses

//stamina
 float fStamina = GetPersistentFloat( oPC, "STAMINA" );
 if( fStamina <= 0.0 )
    fStamina = getMaxStamina(oPC);
 if( fStamina > getMaxStamina(oPC))
    fStamina = getMaxStamina(oPC);

 SetLocalFloat(oPC, "JA_STAMINA", fStamina);
//~stamina

//needs
    float fWaterR = GetPersistentFloat(oPC, VARNAME_WATER);
    float fAlcoholR = GetPersistentFloat(oPC, VARNAME_ALCOHOL);
    float fFoodR = GetPersistentFloat(oPC, VARNAME_FOOD);
    if (fWaterR <= 0.0) fWaterR = MAX_WATER;
    if (fFoodR <= 0.0) fFoodR = MAX_FOOD;
    SetLocalFloat(oPC, VARNAME_FOOD  ,fFoodR);
    SetLocalFloat(oPC, VARNAME_WATER ,fWaterR);
    SetLocalFloat(oPC, VARNAME_ALCOHOL  ,fAlcoholR);
//~needs

//Alchymie
    SetLocalObject(oPC, "oSoulStone", oSoulStone);

    int iAlchemyXP = GetPersistentInt(oPC, TC_XP_PREFIX + IntToString(TC_ALCHEMY));
    if( iAlchemyXP != 0)
    {
       // object oSoulStone = GetSoulStone(oPC);
        SetLocalInt(oSoulStone, TC_XP_PREFIX  + IntToString(TC_ALCHEMY), iAlchemyXP);
    }
//~Alchymie

//skill sbirani
    SetLocalInt(oPC,"iAmDigging",0);
//~skill sbirani

// Get XP and GOLD backup from DB
 if(GetLocalInt(oSoulStone,"LOGED_OUT") == 0) {
   int iXP = GetPersistentInt(oPC,"XP_BACKUP");
   if(iXP > GetXP(oPC))
     SetXP(oPC,iXP);
   int iGold = GetPersistentInt(oPC,"GOLD_BACKUP");
   if(iGold > GetGold(oPC))
     GiveGoldToCreature(oPC,iGold - GetGold(oPC));

 }
 SetLocalInt(oSoulStone,"LOGED_OUT",0);
//~Get XP and GOLD backup from DB

// DelayCommand(1.0, CheckHasSpecialItems(oPC));

// Set dislike automagicaly
 DelayCommand(60.0, DislikeFactions(oPC));

// ExecuteScript("cnr_module_oce", OBJECT_SELF);
//povoleni kurtizany pro zeny
  if (GetGender(oPC) == GENDER_FEMALE)
  {
    SetLocalInt(oSoulStone,"sh_AllowKurtizana",1);
  }

  // Send welcome messages to player
  DelayCommand(30.0, SendPCWelcomeMessages(oPC));


  /* Bugfixy */
  DeleteLocalInt(oPC,"ku_sleeping");
  DeleteLocalInt(oPC,"KU_DEATH_NOLOG");
  DelayCommand(10.0,FixMovementSpeed(oPC));
  DelayCommand(30.0,__checkInvalidFeats(oPC));

  SetLocalInt(oPC, "PLAYED",TRUE);

  // Dismount mounted PC
  if (GetLocalInt(oSoulStone, "MOUNTED"))
  {
    AssignCommand(oPC, DelayCommand(0.0f, Dismount(oPC, oSoulStone)));
    AssignCommand(oPC, DelayCommand(1.0f, DismountAfterActions(oPC, oSoulStone)));
  }

  // Save character filename
  if(GetStringLength(GetPersistentString(oPC,"FILENAME")) <= 0)
    SetPersistentString(oPC, "FILENAME", GetPCFileName(oPC));
  if(__checkPolymorf(oPC) == FALSE )
    SetPersistentString(oPC, "PORTRAIT", GetPortrait(oPC));

  //ku_EtherealClientEnter(oPC);
  SkinCleanup(oPC);
}

void DismountAfterActions(object oPC, object oSoul)
{
    object oHenchman = GetLocalObject(OBJECT_SELF, "MOUNT_OBJECT");
    object oKey = GetKeyByName(oPC, GetLocalString(oSoul, "MOUNT_CREATURE_NAME"));
    DeleteLocalObject(OBJECT_SELF, "MOUNT_OBJECT");

    // Restore key uses
    SetLocalInt(oKey, "HENCHMAN_USES", 1);
}












