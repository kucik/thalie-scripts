//::///////////////////////////////////////////////
//:: Death Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player dies.

    BK: October 8 2002: Overriden for Expansion
    * Kucik 27.05.2008 Upravy subdual
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:://////////////////////////////////////////////
#include "raiseinc"
#include "ja_lib"
#include "sh_classes_inc"
#include "pc_lib"

int GetSubdualMode(object oDammager)
{
    int nSubdual = GetLocalInt(oDammager, "SUBDUAL_MODE");

    if (!nSubdual)
    {
        if (GetIsPlayer(oDammager))
            nSubdual = GetLocalInt(GetSoulStone(oDammager), "SUBDUAL_MODE");

        else if (GetAssociateType(oDammager))
        {
            object oMaster = GetTopMaster(oDammager);
            nSubdual = GetLocalInt(oMaster, "SUBDUAL_MODE");
            if (!nSubdual)
                nSubdual = GetLocalInt(GetSoulStone(oMaster), "SUBDUAL_MODE");
        }
    }
    return nSubdual;
}

// Drop items which cannot be beared to Astharoth's kingdom
void DropDisallowedItems(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);
    {
        if(GetResRef(oItem) == "mrtvola")
        {
            object oCorpse = oItem;

            string sPlayerName = GetLocalString(oCorpse, "PLAYER");
            string sPCName = GetLocalString(oCorpse, "PC");
            string sCorpseTag = GetTag(oCorpse);
            int iSubdual = GetLocalInt(oCorpse,"SUBDUAL");

            DestroyObject(oCorpse, 0.0f);

            location lCorpse = GetLocation(oPC);

            oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, "player_corpse", lCorpse, FALSE, sCorpseTag);
            SetName(oCorpse, sPCName);
            SetLocalString(oCorpse, "PLAYER", sPlayerName);
            SetLocalString(oCorpse, "PC", sPCName);
            SetLocalInt(oCorpse,"SUBDUAL",iSubdual);
        }

        oItem = GetNextItemInInventory(oPC);
    }
}

void ClearAllFactionMembers(object oMember, object oPC)
{
//    AssignCommand(oMember, SpeakString("here"));
    AdjustReputation(oPC, oMember, 100);
//    SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
    object oClear = GetFirstFactionMember(oMember, FALSE);
    while (GetIsObjectValid(oClear) == TRUE)
    {
        ClearPersonalReputation(oPC, oClear);
        oClear = GetNextFactionMember(oMember, FALSE);
    }
}

void DeleteCorpse(object oCorpse){
 if(GetIsObjectValid(oCorpse))
  DestroyObject(oCorpse);
}

int CheckIsSubdualValid(object oPC) {
  effect eEff = GetFirstEffect(oPC);
  while(GetIsEffectValid(eEff)) {
    if( GetEffectType(eEff) == EFFECT_TYPE_PETRIFY)
      return FALSE;
    eEff = GetNextEffect(oPC);
  }
  return TRUE;
}

void DeathLog(object oPC, object oKiller, int nSubdual) {

  /* Disable twice death logging */
  if(GetLocalInt(oPC,"KU_DEATH_NOLOG")) {
    return;
  }

  // Arena
  object oArea = GetArea(oPC);
  if( GetIsObjectValid(oArea) ){
    if( GetTag(oArea) == GetLocalString( oPC, v_ArenaPermission ) ){
      return;
    }
  }

  //For twice logging
  SetLocalInt(oPC,"KU_DEATH_NOLOG",TRUE);
  DelayCommand(120.0,DeleteLocalInt(oPC,"KU_DEATH_NOLOG"));

  string sPlayer = "";
  string sName = "";
  if(GetIsObjectValid(oPC)) {
    sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oPC));
    sName = SQLEncodeSpecialChars(GetName(oPC));
  }
  string sKName, sKPlayer;
  sKName = SQLEncodeSpecialChars(GetName(oKiller));
  if(GetIsPC(oKiller)) {
    sKPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oKiller));
  }
  else {
    sKPlayer = "NPC";
  }

  string sValues = "'"+sPlayer+"',"+
                   "'"+sName+"',"+
                   "'"+IntToString(GetHitDice(oPC))+"',"+
                   "'"+IntToString(nSubdual)+"',"+
                   "'"+sKPlayer+"',"+
                   "'"+sKName+"',"+
                   "'"+IntToString(GetHitDice(oKiller))+"'";
  string sSQL = "INSERT INTO deathlog (player,name,level,subdual,killer_acc,killer_name,killer_lvl) VALUES ("+sValues+");";
  SQLExecDirect(sSQL);

}

void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nHD = GetHitDice(oDead);
    int nPenalty = nHD*250;

    object oSoul = GetSoulStone(oDead);

    int xpk = GetLocalInt(oSoul,"ku_XPLost");
    SetLocalInt(oSoul,"ku_XPLost",xpk + nPenalty);

    int nNewXP;
    if (nXP > nPenalty)
    {
        nNewXP = nXP - nPenalty;
    }
    else
    {
        nNewXP = 0;
    }

    SetXP(oDead, nNewXP);
}


void main()
{

    object oPC = GetLastPlayerDied();
    object oDammager = GetLastDamager(oPC);

    // Get subdual damage (stínovky)
    int nSubdual = GetLocalInt(oPC,"SUBDAMADE_TYPE");
    if (!nSubdual)
        nSubdual = GetSubdualMode(oDammager);

    OnDeathClassSystem(oPC);

//    SendMessageToPC(oPC,"//Debug info: Zabil te "+GetName(oDammager)+", subdual=."+IntToString(nSubdual));
    if(nSubdual == 2) {
      if(CheckIsSubdualValid(oPC))
        nSubdual = TRUE;
      else
        nSubdual = FALSE;
    }
    else
      nSubdual = FALSE;

    SetLocalInt(oPC,"SUBDAMADE_TYPE",0);

//    SendMessageToPC(oPC,"//Debug info: Zabil te "+GetName(oDammager)+", subdual=."+IntToString(nSubdual));

//ARENA

    object oArea = GetArea(oPC);
    if( GetIsObjectValid(oArea) ){
        if( GetTag(oArea) == GetLocalString( oPC, v_ArenaPermission ) ){
    //    if( GetTag(GetArea(oPC)) == "ry_karakv2" && GetLocalInt(oPC, v_ArenaPermission) == 1 ){
            object oWP = GetNearestObjectByTag("WP_ARENA");
            SendMessageToPC(oPC, "Za 60 vterin budes osetren.");
            DelayCommand(60.0f, Raise(oPC));
            return;
        }
    }

//~ARENA
//DEITY
    int iDeity = GetDeityAlignment(oPC);
    int iRandom = (Random(100) == 1);

/*    if(GetLocalInt(oPC, "JA_EX_SET1"))
     iRandom = 1;*/

    if(iDeity != 0 && iRandom){
        int iEffect;
        switch(iDeity){
            case 1: iEffect = VFX_FNF_WORD;
                    break;
            case 2: iEffect = VFX_FNF_NATURES_BALANCE;
                    break;
            case 3: iEffect = VFX_FNF_PWKILL;
                    break;
        }
        effect eEffect = EffectVisualEffect( iEffect );

        ApplyEffectAtLocation( DURATION_TYPE_INSTANT, eEffect, GetLocation(oPC) );

        DelayCommand(2.0f, Raise(oPC));
        return;
    }

  /*  if(GetLocalInt(oPC, "JA_EX_SET2"))
        return;*/
//~DEITY

    ExecuteScript("ja_horse_pldeath", oPC);

    // * make friendly to Each of the 3 common factions
    AssignCommand(oPC, ClearAllActions());
    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPC) <= 10)
    {   //SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPC);
        ClearAllFactionMembers(GetObjectByTag("NPC_FACTION_COMMONER"), oPC);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPC) <= 10)
    {   //SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPC);
        ClearAllFactionMembers(GetObjectByTag("NPC_FACTION_MERCHANT"), oPC);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPC) <= 10)
    {   //SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPC);
        ClearAllFactionMembers(GetObjectByTag("NPC_FACTION_DEFENDER"), oPC);
    }

    location lCorpse = GetLocation(oPC);
    string sCorpseTag = GetPCPlayerName(oPC)+"_"+GetName(oPC);

    object oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, "player_corpse", lCorpse, FALSE, sCorpseTag);

    SetLocalString(oPC, "CORPSETAG", GetTag(oCorpse));

    DelayCommand(1200.0f, DeleteCorpse(oCorpse));

    SetName(oCorpse, GetName(oPC));
    SetLocalString(oCorpse, "PLAYER", GetPCPlayerName(oPC));
    SetLocalString(oCorpse, "PC", GetName(oPC));
    SetLocalInt(oCorpse,"SUBDUAL",nSubdual);
//    SendMessageToPC(oPC,"subdual="+IntToString(nSubdual));

    /* Log death */
    object oKiller = GetLastKiller();
    if(!GetIsObjectValid(oKiller)) {
      oKiller = oDammager;
    }
    DeathLog(oPC,oKiller,nSubdual);

    DelayCommand(0.0f, DropDisallowedItems(oPC));

    DelayCommand(1.0f, Raise(oPC));
    object wpDeath = GetObjectByTag("WP_DEATH");
    SetLocalLocation(oPC, "LOCATION", GetLocation(wpDeath));
    //string ID = GetLocalString(oPC, "ID");
    SetPersistentLocation(oPC, "LOCATION", GetLocation(wpDeath));
    DelayCommand(0.9f, AssignCommand(oPC, ClearAllActions(TRUE)));
//    SendMessageToPC(oPC,"JUMP to "+GetTag(wpDeath));
    ApplyPenalty(oPC);
    DelayCommand(1.0f, AssignCommand(oPC, JumpToObject(wpDeath)));

    //edit Sylm : na zaver ulozim do duse bytosti premennu isDead = 1
    object oSoulItem = GetSoulStone(oPC);
    SetLocalInt(oSoulItem, "isDead", 1);
    //end Sylm

}

