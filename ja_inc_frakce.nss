/*
 * rev. Kucik 06.01.2008 funkce pro zjisteni frakce
 */

#include "ja_lib"
#include "subraces"

// Get penguin member of this faction
object GetFactionMember(string sFaction);

// Override faction if variable FACTION_OVERRIDE is set on OBJECT SELF
// or on Area.
int OverrideFaction(object oNPC);

// Get faction memory object
object GetFactionMemory();

// Get NPC faction identification. Wo not work for PC and party members.
string GetNPCFaction(object oNPC);

// Set NPC as member of passed faction/
int SetNPCFaction(object oNPC, string sFac);

void SetFactionReputation(object oPC, object oFirst, int reputation){

   object oMember = GetFirstFactionMember(oFirst, FALSE);
   while (GetIsObjectValid(oMember))
   {
       int now = GetReputation(oPC, oMember);
//       SendMessageToPC(oPC, "Adjusting " +GetName(oMember)+" to "+IntToString(reputation));
       AdjustReputation(oPC, oMember, reputation-now);

       oMember = GetNextFactionMember(oFirst, FALSE);
   }
}

/*
void setFactionsToPC(object oPC, int frakce){
   //SendMessageToPC(oPC, "Prave updatuji tvoje frakce");

   SetLocalInt(GetSoulStone(oPC),"KU_SPEC_FACTIONS",frakce);
   string col;

   switch(frakce){
       case 0: col = "Povrch"; break;
       case 1: col = "Podtemnan"; break;
       case 2: col = "Pritel"; break;
       case 3: col = "Otrok"; break;
       default: return;
   }

   int i;
   for( i = 0; i <= 30 ; i++ ){ //nastav frakce
       string sMember = Get2DAString("factions", "FactionMember", i);
       int reputation = StringToInt(Get2DAString("factions", col, i));
       object oMember = GetObjectByTag(sMember);

       SendMessageToPC(oPC, sMember+ ": "+IntToString(reputation)+" Object: "+ ObjectToString(oMember));
       SetFactionReputation(oPC, oMember, reputation);
   }
}
*/

void setFactionsToPC(object oPC, int frakce){
   //SendMessageToPC(oPC, "Prave updatuji tvoje frakce");

   SetLocalInt(GetSoulStone(oPC),"KU_SPEC_FACTIONS",frakce);
   string col;
   object oMod = GetModule();
   object oMem = GetFactionMemory();

   switch(frakce){
       case 0: col = "POVRCH"; break;
       case 1: col = "PODTEMNO"; break;
//       case 2: col = "Pritel"; break;
//       case 3: col = "Otrok"; break;
       default: return;
   }

   int i=1;
   int row=0;
   int reputation = 100;
   int iFacId;
   string cachename;
/*   object oNullFaction = GetLocalObject(OBJECT_SELF,"KU_FACTION_NULLFACTION_NPC");
   if(!GetIsObjectValid(oNullFaction)) {
     oNullFaction = GetObjectByTag("ku_faction_null_creature");
     SetLocalObject(OBJECT_SELF,"KU_FACTION_NULLFACTION_NPC",oNullFaction);
   }*/
   object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC,oPC,i);
   while(GetIsObjectValid(oNPC)) {
//     SendMessageToPC(oPC,GetName(oNPC));
//     row = GetReputation(oNullFaction,oNPC);
     iFacId = GetFactionId(oNPC);

     // Ted zjistime, jestli mame frakci cachenutou, nebo ji musime tahat z .2da
/*     cachename = "KU_FACTIONCACHE_"+ col +"x"+IntToString(row);
     reputation = GetLocalInt(oMod,cachename);
     if(reputation==0) {
       reputation = StringToInt(Get2DAString("factions", col, row));
       SetLocalInt(oMod,cachename,reputation+1);
//       SendMessageToPC(oPC,"cached:"+cachename);
     }
     else
       reputation--;*/

     reputation = GetLocalInt(oMem,"fac_"+IntToString(iFacId)+"_"+col);

//     SendMessageToPC(oPC,"Adjusting reputation "+IntToString(GetReputation(oNPC,oPC))+" of "+GetName(oNPC)+" to "+IntToString(reputation)+" - 50" );

     ClearPersonalReputation(oPC,oNPC);
     AdjustReputation(oPC, oNPC, reputation - 50);
//     AdjustReputation(oNPC, oPC, reputation);
//     SetFactionReputation(oPC, oNPC, reputation);
     //SendMessageToPC(oPC,"string="+Get2DAString("factions", "FACTION", iFacId)+"; row="+IntToString(iFacId)+" reputation = "+IntToString(reputation));
     i++;
     oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_NOT_PC,oPC,i);

   }
}

int getFaction(object oPC){
   int iFaction = GetLocalInt(GetSoulStone(oPC),"KU_SPEC_FACTIONS");

   // To je pekne na picu, zes dal pevninanovi frakci 0. Ted nepoznam,
   // jestli je to pevninan, nebo se frakce ztratila
   // Takze ted, pokud nevim o tom ze by byl otrok nebo pritel, urcim frakci podle subrasy
   if(iFaction < 1) {
     // Vypada to sice divne, ale hodnoty frakci a podtemno/povrch spolu koresponduji
     iFaction = Subraces_GetIsCharacterFromUnderdark(oPC );
   }
   return iFaction;
}

void updateAllPCs(){
   object oPC = GetFirstPC();

   while(GetIsObjectValid(oPC)){

       if(!GetIsDM(oPC))
           setFactionsToPC(oPC, getFaction(oPC));

       oPC = GetNextPC();
   }

}


object GetFactionMember(string sFaction) {
  object oMod = GetModule();
  object oMem = GetFactionMemory();
  int iFacId = GetLocalInt(oMem,"fac_"+sFaction);
  object oFac = GetLocalObject(oMem, "fac_"+IntToString(iFacId));

  if(GetIsObjectValid(oFac)) {
    return oFac;
  }

  return OBJECT_INVALID;

}

int OverrideFaction(object oNPC) {
  string sFac = GetLocalString(OBJECT_SELF,"FACTION_OVERRIDE");
  if(GetStringLength(sFac) == 0) {
    sFac = GetLocalString(GetArea(OBJECT_SELF),"FACTION_OVERRIDE");
  }
  if(GetStringLength(sFac) == 0) {
    return FALSE;
  }

  return SetNPCFaction(oNPC, sFac);
}

int SetNPCFaction(object oNPC, string sFac)  {
  object oFaction = GetFactionMember(sFac);
  if(GetIsObjectValid(oFaction)) {
      ChangeFaction(oNPC,oFaction);
      return TRUE;
  }

  return FALSE;
}

object GetFactionMemory() {
  object oMem;
  object oModule = GetModule();

  /* Check if memstone is already referenced from module */
  oMem = GetLocalObject(oModule,"FACTION_MEMORY");
  if(GetIsObjectValid(oMem))
    return oMem;

  /* Find it and make reference */
  oMem = GetObjectByTag("FACTION_MEMORY");
  SetLocalObject(oModule,"FACTION_MEMORY",oMem);
  return oMem;
}

void InitFactions() {
  object oMem = GetFactionMemory();
  int i=0;
  string sFaction;
  object oFac;
  int iFacId;
  int iPovrch;
  int iPodtemno;

  WriteTimestampedLogEntry("######### FACTIONS INIT BEGIN ##########");

  /* go through all factions */
  sFaction = Get2DAString("factions","FACTION",i);
  while(GetStringLength(sFaction) > 0) {
    /* Get faction penguin */
    oFac = GetNearestObjectByTag("FACTION_"+sFaction, oMem);
    iFacId = GetFactionId(oFac);

    /* Get reputations of PC factions */
    iPovrch   = StringToInt(Get2DAString("factions","POVRCH",i));
    iPodtemno = StringToInt(Get2DAString("factions","PODTEMNO",i));

    /* Set to cache */
    SetLocalString(oMem,"fac_"+IntToString(iFacId)+"_name", sFaction);
    SetLocalInt(oMem,"fac_"+IntToString(iFacId)+"_POVRCH",   iPovrch);
    SetLocalInt(oMem,"fac_"+IntToString(iFacId)+"_PODTEMNO", iPodtemno);
    SetLocalObject(oMem, "fac_"+IntToString(iFacId), oFac);
    SetLocalInt(oMem,"fac_"+sFaction, iFacId);

    /* Mark penguin */
    SetLocalInt(oFac, "FACTION_ID", iFacId);

    /* Make log output */
    WriteTimestampedLogEntry("#"+IntToString(i)+" ID:"+IntToString(iFacId)+" fac: "+sFaction+
                          " POVRCH:"+ IntToString(iPovrch)+" PODTEMNO:"+IntToString(iPodtemno));

    /* continue */
    i++;
    sFaction = Get2DAString("factions","FACTION",i);
  }

  SetLocalInt(GetModule(),"FACTION_INITIALIZED", TRUE);
  WriteTimestampedLogEntry("######### FACTIONS INIT END ##########");

  return;
}

string GetNPCFaction(object oNPC) {
  int iFacId = GetFactionId(oNPC);
  object oMem = GetFactionMemory();

  string sFac = GetLocalString(oMem,"fac_"+IntToString(iFacId)+"_name");
  
  return sFac;

}

string GetFactionByID(int iFacId) {
  object oMem = GetFactionMemory();
  
  return GetLocalString(oMem,"fac_"+IntToString(iFacId)+"_name");
}
