#include "aps_include"
#include "persistence"
//#include "zep_inc_phenos"
#include "ja_inc_stamina"
#include "me_pcneeds_inc"
#include "ja_inc_frakce"
#include "ku_libbase"
// kuly alchymii
#include "tc_constants"
#include "sh_classes_inc"
#include "sh_deity_inc"
#include "ku_dlg_inc"
#include "sh_lang_start"

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
  int iSubrace = Subraces_GetCharacterSubrace(oPC);
  /*if(iSubrace == SUBRACE_HALFORC_HALFOGRE ||
     iSubrace == SUBRACE_HALFORC_BLACK_HALFOGRE) {

    SetMovementRate(oPC,MOVEMENT_RATE_PC);
  }    */
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

void main()
{
 object oPC = GetEnteringObject();
// FAZE 1. BANY-------------------------------------------------------------------
//safety

    string Player = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
    string IP     = GetPCIPAddress(oPC);
    string CDKEY  = GetPCPublicCDKey(oPC);
    object oSoulStone = GetSoulStone(oPC);

    object oPCSkin = GetPCSkin(oPC);
    SetLocalObject(oSoulStone,"PCSKIN",oPCSkin);
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

        if( GetIsDM(oPC) && (n_priv < 1) ) {
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
        BootPC(oPC);
        WriteTimestampedLogEntry("LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", NENI DOBRODRUH.");
        return;

   }
 int iSkillSum = 0;
 int iSkill = 0;
 for (iSkill=0;iSkill<=27;iSkill++) iSkillSum +=GetSkillRank(iSkill,oPC,TRUE);
 if (iSkillSum >0 && GetHitDice(oPC)==1)
 {
    BootPC(oPC);
    WriteTimestampedLogEntry("LOGIN: Player "+Player+" from "+IP+" CDKEY:"+CDKEY+", dal body do skillu.");
    return;
 }
 //------- PODVODY
 // kontrola na to zda postava na prvnim lvlu dala body do skillu
 iSkill = 0;
 for (iSkill=0;iSkill<=27;iSkill++)
 {
    if (GetSkillIncreaseByLevel(oPC,1,iSkill)>0)
    {
         SetLocalInt(oPC,"JE_POSTAVA_ZABUGOVANA",1); //zrusi postave prijem zkusenosti
         break;
    }
 }

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
 SetLocalInt(oPC,"SUBDUAL_MODE",GetLocalInt(oSoulStone,"SUBDUAL_MODE"));
 DelayCommand(120.0,UpdateLoginIP(oPC));

 AddPlayerToDump(oPC);

 //zapoznakovani Shaman - vyhazuje ze serveru
 // FAZE 2. ROZDELENI - PRVNI VSTUP-------------------------------------------------------------------
 int iPlayed = GetPersistentInt(oPC, "PLAYED","pwchars");
 if (iPlayed)  //uz tady byl
 {
    int iHP = GetPersistentInt(oPC, "HP");
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oPC)-iHP,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);
 }
 else //prvni lognuti
 {
       //je tu poprvy
        object oItem = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oItem))
        {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory(oPC);
        }

        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
        DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
        TakeGoldFromCreature(GetGold(oPC), oPC, TRUE);
        GiveGoldToCreature(oPC, 3000);
        SetPersistentInt(oPC, "HP", GetCurrentHitPoints(oPC));
        RepairObcanThalie(oPC);
        SetPersistentInt(oPC, "PLAYED",1,0,"pwchars");

 }
 CheckHasSpecialItems(oPC);
 setFactionsToPC(oPC, getFaction(oPC));
 ku_OnClientEnter(oPC); // Inicializace eXPiciho systemu pri loginu hrace.
 Subraces_InitSubrace( oPC ); //Inicializace subrasy
 //KU_CalcAndGiveSkillPoints(oPC); //Nastav postave spravne volne skillpointy


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

 DelayCommand(1.0, CheckHasSpecialItems(oPC));

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

  //ku_EtherealClientEnter(oPC);
}












