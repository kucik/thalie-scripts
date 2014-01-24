////////////////////////////////////////////////////////////////////////////////
// npcact_h_core - NPC ACTIVITIES 6.0 Core Functions
//------------------------------------------------------------------------------
// by Deva Bryson Winblood.
//------------------------------------------------------------------------------
// Last Modified by: Deva Bryson Winblood
// Last Modified Date: 05/30/2004
////////////////////////////////////////////////////////////////////////////////
#include "npcactivitiesh"
#include "nw_i0_generic"
#include "npcact_h_anim"
////////////////////////////
// PROTOTYPES
////////////////////////////

// FILE: npcact_h_core              FUNCTION: fnNPCACTModeSet()
// This function will enable you to set the action modes that were provided
// with the HoTU expansion.
float fnNPCACTModeSet(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTSetAppearance()
// This function will enable you to access the SetCreatureAppearanceType
// that was supplied with HoTU expansion.  This function is called via
// ]# where # can be any integer # or it can be an integer variable name
// stored on the NPC.  This is useful for storing the original appearance
// in a variable before the first change and being able to revert to it
float fnNPCACTSetAppearance(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTAnimate()
// Currently this function supports animating 40 animation types
// and durations from 0.2 seconds up.
float fnNPCACTAnimate(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTNonVFX()
// This allows the NPC to have non-visual effects added to them such
// as sleep, sanctuary, etc.
float fnNPCACTNonVFX(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTAttackObject()
// This causes the NPC to attack an object within 30 meters that
// has the specified tag.
float fnNPCACTAttackObject(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTEnterCombat()
// This will cause the NPC to enter combat with specified creature
// via tag.
float fnNPCACTEnterCombat(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTChangeClothes()
// This will cause the NPC to change to the clothing type specified by tag
// if they are carrying it.
float fnNPCACTChangeClothes(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTCloseDoors()
// This will cause the NPC to close any doors within 5 meters that are open.
float fnNPCACTCloseDoors();

// FILE: npcact_h_core              FUNCTION: fnNPCACTDestroyObject()
// This will destroy any object within 8 meters of the NPC with the specified tag.
float fnNPCACTDestroyObject(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTEquipWeapons()
// This function will cause the NPC to equip a weapon.  They will equip a melee
// weapon first and if they do not have a melee weapon they will equip a ranged
// weapon.   If you wish them to equip a specific weapon then use the library
// command #na/6/<WeaponTag>/<Slot#> as described in the NPC ACTIVITIES document.
float fnNPCACTEquipWeapons();

// FILE: npcact_h_core              FUNCTION: fnNPCACTFollowByTag()
// This function will cause the NPC to follow another NPC with the specified
// tag provided they can see them.  They will follow them for a duration
// specified in heartbeats (6 second intervals).
float fnNPCACTFollowByTag(string sCom);

// FILE: npcact_h_core              FUNCTION: fnNPCACTLockThings()
// This function will cause the NPC to lock any doors, or containers within
// 5 meters.
float fnNPCACTLockThings();

// FILE: npcact_h_core              FUNCTION: fnNPCACTRandomWalk()
// This will use the NPC ACTIVITIES version of random walking
float fnNPCACTRandomWalk();

// FILE: npcact_h_core              FUNCTION: fnNPCACTSitForSpecified()
// This function will direct the NPC to sit in a nearby chair or sittable
// object for specified amount of heartbeats.
float fnNPCACTSitForSpecified(string sCommand);

// FILE: npcact_h_core              FUNCTION: fnNPCACTSetFacing()
// This function will set the NPC facing to the direction specified.
float fnNPCACTSetFacing(string sCommand);

// FILE: npcact_h_core              FUNCTION: fnNPCACTUnequipWeapons()
// This will cause the NPC to put away any weapons they have equipped.
float fnNPCACTUnequipWeapons();

// FILE: npcact_h_core              FUNCTION: fnNPCACTWait()
// This function will cause the NPC to do nothing for specified amount of
// seconds.
float fnNPCACTWait(string sCommand);

// FILE: npcact_h_core              FUNCTION: fnNPCACTUnlock()
// This function will cause the NPC to unlock a nearby door or container.
// if the container requires a key it will make sure the NPC possesses the
// key before permitting them to unlock the object.
float fnNPCACTUnlock();

// FILE: npcact_h_core              FUNCTION: fnNPCACTTakeItem()
// Take nearby item (within 10 meters) with specified tag.
float fnNPCACTTakeItem(string sCommand);

// FILE: npcact_h_core              FUNCTION: fnNPCACTSleep()
// Apply SLEEP effect to NPC.  NOTE: will not work if NPC is
// immune to sleep. If you want such an NPC to act like they
// are sleeping try using the REST command.
float fnNPCACTSleep();

// FILE: npcact_h_core              FUNCTION: fnNPCACTRest()
// This will cause the NPC to simulate resting and this is
// completely interruptable.  They will respond to conversation,
// will respond to attacks etc.  IF this command is called by
// fnNPCACTSleep() for a creature that cannot be interrupted then
// this will not be interruptable either.
float fnNPCACTRest();

// FILE: npcact_h_core              FUNCTION: fnNPCACTRandomCommand()
// This will call a random command within X amount within the waypoint
// as it did in NPC ACTIVITIES 5.x.
float fnNPCACTRandomCommand(string sCom);

////////////////////////////
// FUNCTIONS
////////////////////////////

float fnNPCACTAnimate(string sCom)
{ // PURPOSE: To provide access to all the animation types for the NPC
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDelay=0.1;
  string sS=GetStringRight(sCom,GetStringLength(sCom)-4);
  string sAnim=fnParse(sS,"/");
  string sDur=fnRemoveParsed(sS,sAnim,"/");
  int nAnim=0;
  int nDur=StringToInt(sDur);
  if (nDur>0&&GetStringLength(sAnim)>0)
  { // valid
    fDelay=IntToFloat(nDur)*0.2;
    nAnim=fnNPCACTAnimMagicNumber(sAnim);
    if (nAnim==0) fDelay=0.1;
    AssignCommand(OBJECT_SELF,ActionPlayAnimation(nAnim,1.0,fDelay));
  } // valid
  return fDelay;
} // fnNPCACTAnimate()

float fnNPCACTSetAppearance(string sCom)
{ // PURPOSE: To set the appearance of the NPC
  // LAST MODIFIED BY: Deva Bryson Winblood
  string sS=GetStringRight(sCom,GetStringLength(sCom)-1);
  int nAp=StringToInt(sS);
  if (nAp==0) nAp=GetLocalInt(OBJECT_SELF,sS);
  SetCreatureAppearanceType(OBJECT_SELF,nAp);
  return 0.5;
} // fnNPCACTSetAppearance()

float fnNPCACTModeSet(string sCom)
{ // PURPOSE: To set the action modes introduced with HoTU expansion
  // LAST MODIFIED BY:  Deva Bryson Winblood
  string sS=GetStringRight(sCom,GetStringLength(sCom)-1);
  string sMode=fnParse(sS,"/");
  string sSet=fnRemoveParsed(sS,sMode,"/");
  int nMode=0;
  int nTRUE=FALSE;
  if (sMode=="CS"||sMode=="COUNTERSPELL") nMode=ACTION_MODE_COUNTERSPELL;
  else if (sMode=="DC"||sMode=="DEFENSIVECAST") nMode=ACTION_MODE_DEFENSIVE_CAST;
  else if (sMode=="D"||sMode=="DETECT") nMode=ACTION_MODE_DETECT;
  else if (sMode=="DF"||sMode=="DIRTYFIGHTING") nMode=ACTION_MODE_DIRTY_FIGHTING;
  else if (sMode=="E"||sMode=="EXPERTISE") nMode=ACTION_MODE_EXPERTISE;
  else if (sMode=="FoB"||sMode=="FOB") nMode=ACTION_MODE_FLURRY_OF_BLOWS;
  else if (sMode=="IE") nMode=ACTION_MODE_IMPROVED_EXPERTISE;
  else if (sMode=="IPA") nMode=ACTION_MODE_IMPROVED_POWER_ATTACK;
  else if (sMode=="P"||sMode=="PARRY") nMode=ACTION_MODE_PARRY;
  else if (sMode=="PA"||sMode=="POWERATTACK") nMode=ACTION_MODE_POWER_ATTACK;
  else if (sMode=="RS"||sMode=="RAPIDSHOT") nMode=ACTION_MODE_RAPID_SHOT;
  else if (sMode=="S"||sMode=="STEALTH"||sMode=="H"||sMode=="HIDE") nMode=ACTION_MODE_STEALTH;
  if (nMode!=0)
  { // valid mode was found
    if (sSet=="T"||sSet=="t"||sSet=="TRUE"||sSet=="1"||sSet=="Y"||sSet=="YES") nTRUE=TRUE;
    SetActionMode(OBJECT_SELF,nMode,nTRUE);
  } // valid mode was found
  return 0.1;
} // fnNPCACTModeSet()


float fnNPCACTNonVFX(string sCom)
{ // PURPOSE: To apply a non-VFX effect to an NPC
  // LAST MODIFIED BY: Deva Bryson Winblood
  // FORMAT: <effect code>/<duration type>/<duration in complete seconds>
  string sS=GetStringRight(sCom,GetStringLength(sCom)-1);
  string sENum=fnParse(sS,"/");
  string sDurType;
  string sDur;
  effect eEffect;
  int nDurType=DURATION_TYPE_TEMPORARY;
  float fDur;
  int nENum;
  int nParm1;
  int nParm2;
  int nDurQ=0; // duration qualifier 1=Extraordinary   2 = supernatural
  sS=fnRemoveParsed(sS,sENum,"/");
  sDurType=fnParse(sS,"/");
  sDur=fnRemoveParsed(sS,sDurType,"/");
  // determine duration type
  if (sDurType=="T"||sDurType=="TEMPORARY") nDurType=DURATION_TYPE_TEMPORARY;
  else if (sDurType=="I"||sDurType=="INSTANT") nDurType=DURATION_TYPE_INSTANT;
  else if (sDurType=="P"||sDurType=="PERMANENT") nDurType==DURATION_TYPE_PERMANENT;
  else if (sDurType=="EXT")  { nDurType=DURATION_TYPE_TEMPORARY; nDurQ=1; }
  else if (sDurType=="SNT")  { nDurType=DURATION_TYPE_TEMPORARY; nDurQ=2; }
  else if (sDurType=="EXI")  { nDurType=DURATION_TYPE_INSTANT; nDurQ=1; }
  else if (sDurType=="SNI")  { nDurType=DURATION_TYPE_INSTANT; nDurQ=2; }
  else if (sDurType=="EXP")  { nDurType=DURATION_TYPE_PERMANENT; nDurQ=1; }
  else if (sDurType=="SNP")  { nDurType=DURATION_TYPE_PERMANENT; nDurQ=2; }
  // Determine Duration
  fDur=IntToFloat(StringToInt(sDur));
  // Determine Effect to use
  if(GetStringLeft(sENum,3)=="ABD")
  { // ability decrease
    sENum=GetStringRight(sENum,2);
    nParm2=StringToInt(GetStringRight(sENum,1));
    sENum=GetStringLeft(sENum,1);
    if (sENum=="S") nParm1=ABILITY_STRENGTH;
    else if (sENum=="D") nParm1=ABILITY_DEXTERITY;
    else if (sENum=="C") nParm1=ABILITY_CONSTITUTION;
    else if (sENum=="I") nParm1=ABILITY_INTELLIGENCE;
    else if (sENum=="W") nParm1=ABILITY_WISDOM;
    else if (sENum=="A") nParm1=ABILITY_CHARISMA;
    eEffect=EffectAbilityDecrease(nParm1,nParm2);
  } // ability decrease
  else if(GetStringLeft(sENum,3)=="ABI")
  { // ability increase
    sENum=GetStringRight(sENum,2);
    nParm2=StringToInt(GetStringRight(sENum,1));
    sENum=GetStringLeft(sENum,1);
    if (sENum=="S") nParm1=ABILITY_STRENGTH;
    else if (sENum=="D") nParm1=ABILITY_DEXTERITY;
    else if (sENum=="C") nParm1=ABILITY_CONSTITUTION;
    else if (sENum=="I") nParm1=ABILITY_INTELLIGENCE;
    else if (sENum=="W") nParm1=ABILITY_WISDOM;
    else if (sENum=="A") nParm1=ABILITY_CHARISMA;
    eEffect=EffectAbilityIncrease(nParm1,nParm2);
  } // ability increase
  else if(GetStringLeft(sENum,3)=="ACD")
  { // AC Decrease
    nParm1=StringToInt(GetStringRight(sENum,1));
    eEffect=EffectACDecrease(nParm1);
  } // AC Decrease
  else if(GetStringLeft(sENum,3)=="ACI")
  { // AC Decrease
    nParm1=StringToInt(GetStringRight(sENum,1));
    eEffect=EffectACIncrease(nParm1);
  } // AC Decrease
  else if (GetStringLeft(sENum,3)=="ATD")
  { // attack decrease
    nParm1=StringToInt(GetStringRight(sENum,1));
    eEffect=EffectAttackDecrease(nParm1);
  } // attack decrease
  else if (GetStringLeft(sENum,3)=="ATI")
  { // attack increase
    nParm1=StringToInt(GetStringRight(sENum,1));
    eEffect=EffectAttackIncrease(nParm1);
  } // attack increase
  else if (sENum=="BLIND")
  { // Blindness
    eEffect=EffectBlindness();
  } // Blindness
  else if (sENum=="CHARM")
  { // Charmed
    eEffect=EffectCharmed();
  } // Charmed
  else if (GetStringLeft(sENum,4)=="CONC")
  { // concealment
    sENum=GetStringRight(sENum,GetStringLength(sENum)-4);
    eEffect=EffectConcealment(StringToInt(sENum));
  } // concealment
  else if (sENum=="CONFUSE")
  { // confused
    eEffect=EffectConfused();
  } // confused
  else if (sENum=="CURSE")
  { // cursed
    eEffect=EffectCurse();
  } // cursed
  else if (sENum=="CSGHOST")
  { // cutscene ghost
    eEffect=EffectCutsceneGhost();
  } // cutscene ghost
  else if (sENum=="DAZE")
  { // dazed
    eEffect=EffectDazed();
  } // dazed
  else if (sENum=="DEAF")
  { // deaf
    eEffect=EffectDeaf();
  } // deaf
  else if (sENum=="DISPALL")
  { // Dispel Magic All
    eEffect=EffectDispelMagicAll(15);
  } // Dispel Magic All
  else if (sENum=="DISPBEST")
  { // Dispel Magic Best
    eEffect=EffectDispelMagicBest(15);
  } // Dispel Magic Best
  else if (sENum=="ENTANGLE")
  { // entangle
    eEffect=EffectEntangle();
  } // entangle
  else if (sENum=="ETHEREAL")
  { // ethereal
    eEffect=EffectEthereal();
  } // ethereal
  else if (sENum=="FRIGHTEN")
  { // frighten
    eEffect=EffectFrightened();
  } // frighten
  else if (sENum=="HASTE")
  { // haste
    eEffect=EffectHaste();
  } // haste
  else if (GetStringLeft(sENum,4)=="HEAL")
  { // heal
    sENum=GetStringRight(sENum,GetStringLength(sENum)-4);
    eEffect=EffectHeal(StringToInt(sENum));
  } // heal
  else if (sENum=="INVISIBLE")
  { // make invisible
    eEffect=EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
  } // make invisible
  else if (sENum=="KNOCKDOWN")
  { // knockdown
    eEffect=EffectKnockdown();
  } // knockdown
  else if (sENum=="PARALYZE")
  { // paralyze
    eEffect=EffectParalyze();
  } // paralyze
  else if (sENum=="PETRIFY")
  { // petrify
    eEffect=EffectPetrify();
  } // petrify
  else if (sENum=="SEEINVIS")
  { // See invisible
    eEffect=EffectSeeInvisible();
  } // see invisible
  else if (sENum=="SILENCE")
  { // silence
    eEffect=EffectSilence();
  } // silence
  else if (sENum=="SLEEP")
  { // sleep
    eEffect=EffectSleep();
  } // sleep
  else if (sENum=="SLOW")
  { // slow
    eEffect=EffectSlow();
  } // slow
  else if (sENum=="STUN")
  { // stunned
    eEffect=EffectStunned();
  } // stunned
  else if (sENum=="TIMESTOP")
  { // time stop
    eEffect=EffectTimeStop();
  } // time stop
  else if (sENum=="TRUESEE")
  { // true seeing
    eEffect=EffectTrueSeeing();
  } // true seeing
  else if (sENum=="TURNED")
  { // turned
    eEffect=EffectTurned();
  } // turned
  else if (sENum=="ULTRA")
  { // ultravision
    eEffect=EffectUltravision();
  } // ultravision
  // apply the effect
  if (nDurQ==0) ApplyEffectToObject(nDurType,eEffect,OBJECT_SELF,fDur);
  else if (nDurQ==1) ApplyEffectToObject(nDurType,ExtraordinaryEffect(eEffect),OBJECT_SELF,fDur);
  else if (nDurQ==2) ApplyEffectToObject(nDurType,SupernaturalEffect(eEffect),OBJECT_SELF,fDur);
  return 0.1;
} // fnNPCACTNonVFX()


float fnNPCACTAttackObject(string sCom)
{ // PURPOSE: To attack an object via a specified tag
  // LAST MODIFIED BY: Deva Bryson Winblood
  string sOb=GetStringRight(sCom,GetStringLength(sCom)-2);
  object oOb=GetNearestObjectByTag(sOb);
  if (GetIsObjectValid(oOb)==TRUE&&GetDistanceBetween(OBJECT_SELF,oOb)<=30.0)
  { // valid target
    AssignCommand(OBJECT_SELF,ActionAttack(oOb));
    DelayCommand(5.9,AssignCommand(OBJECT_SELF,ClearAllActions(TRUE)));
    return 6.0;
  } // valid target
  return 0.1;
} // fnNPCACTAttackObject()

float fnNPCACTEnterCombat(string sCom)
{ // PURPOSE: To cause the NPC to enter combat with a nearby creature
  // with specified tag as long as they can perceive them.
  // LAST MODIFIED BY: Deva Bryson Winblood
  string sOb=GetStringRight(sCom,GetStringLength(sCom)-2);
  object oOb=GetNearestObjectByTag(sOb);
  if (GetIsObjectValid(oOb)==TRUE&&GetObjectSeen(oOb)==TRUE)
  { // valid target
    SetIsTemporaryEnemy(oOb);
    DetermineCombatRound();
    return 6.0;
  } // valid target
  return 0.1;
} // fnNPCACTEnterCombat()

float fnNPCACTChangeClothes(string sCom)
{ // PURPOSE: If NPC has clothes specified by tag have them wear them
  // LAST MODIFIED BY: Deva Bryson Winblood
  string sOb=GetStringRight(sCom,GetStringLength(sCom)-2);
  object oOb=GetItemPossessedBy(OBJECT_SELF,sOb);
  fnDebug("fnNPCACTChangeClothes("+sOb+")",TRUE);
  if (GetIsObjectValid(oOb)==TRUE)
  { // have the clothing
    fnDebug("   Had clothing... simply put it on.");
    AssignCommand(OBJECT_SELF,ClearAllActions());
    AssignCommand(OBJECT_SELF,ActionEquipItem(oOb,INVENTORY_SLOT_CHEST));
    return 4.0;
  } // have the clothing
  else if (sOb=="NONE")
  { // destroy worn clothing
    oOb=GetItemInSlot(INVENTORY_SLOT_CHEST);
    if (GetIsObjectValid(oOb)) DestroyObject(oOb);
  } // destroy worn clothing
  else
  { // create the clothes
    oOb=CreateItemOnObject(sOb);
    if (GetIsObjectValid(oOb))
    { // put it on
      AssignCommand(OBJECT_SELF,ClearAllActions());
      AssignCommand(OBJECT_SELF,ActionEquipItem(oOb,INVENTORY_SLOT_CHEST));
    } // put it on
  } // create the clothes
  return 0.1;
} // fnNPCACTChangeClothes()

float fnNPCACTCloseDoors()
{ // PURPOSE: Close open doors within 8 meters
  // LAST MODIFIED BY: Deva Bryson Winblood
  int nC=1;
  object oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nC);
  float fDist=GetDistanceBetween(oDoor,OBJECT_SELF);
  while(GetIsObjectValid(oDoor)==TRUE&&fDist<=8.0)
  { // valid
    if (GetIsOpen(oDoor)==TRUE)
    {
      AssignCommand(oDoor,ActionCloseDoor(oDoor));
    }
    nC++;
    oDoor=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nC);
    fDist=GetDistanceBetween(oDoor,OBJECT_SELF);
  } // valid
  return 1.0;
} // fnNPCACTCloseDoors()

float fnNPCACTDestroyObject(string sCom)
{ // PURPOSE: Destroy object within 8 meters with specified tag
  // LAST MODIFIED BY: Deva Bryson Winblood
  string sOb=GetStringRight(sCom,GetStringLength(sCom)-2);
  object oOb=GetNearestObjectByTag(sOb);
  if (GetIsObjectValid(oOb)==TRUE&&GetDistanceBetween(oOb,OBJECT_SELF)<=8.0)
  { // valid object
    DestroyObject(oOb);
  } // valid object
  return 0.1;
} // fnNPCACTDestroyObject()

void NPCACTMakeSureEquipped()
{ // PURPOSE: Support function for fnNPCACTEquipWeapons()
  // checks to see if a weapon is equipped and if one is
  // not it attempts to equip a ranged weapon.
  // LAST MODIFIED BY: Deva Bryson Winblood
  if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND))==FALSE)
  { // there is no item in this NPCs right hand
    AssignCommand(OBJECT_SELF,ActionEquipMostDamagingRanged());
  } // there is no item in this NPCs right hand
} // NPCACTMakeSureEquipped()

float fnNPCACTEquipWeapons()
{ // PURPOSE: To equip melee weapons then ranged weapons
  // LAST MODIFIED BY: Deva Bryson Winblood
  AssignCommand(OBJECT_SELF,ActionEquipMostDamagingMelee());
  DelayCommand(2.0,NPCACTMakeSureEquipped());
  return 3.0;
} // fnNPCACTEquipWeapons()

float fnNPCACTFollowByTag(string sCom)
{ // PURPOSE: This will cause the NPC to follow a specified NPC if they
  // can be seen.  They will follow this NPC for a specified number of
  // 6 second intervals.
  float fDur=0.1;
  string sC=sCom;
  string sTag;
  object oNPC;
  int nLoop;
  if (GetStringLeft(sC,2)=="FT") sC=GetStringRight(sC,GetStringLength(sC)-2); // remove FT from beginning
  else { sC=GetStringRight(sC,GetStringLength(sC)-4); } // remove FOTG from beginning
  sTag=fnParse(sC,"/");
  sC=fnRemoveParsed(sC,sTag,"/");
  if (sTag!="PC"&&sTag!="ANY"&&sTag!="F"&&sTag!="M"&&sTag!="FP"&&sTag!="FM") oNPC=GetNearestObjectByTag(sTag);
  else { // special tag
    if (sTag=="PC") oNPC=GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,OBJECT_SELF,1,CREATURE_TYPE_IS_ALIVE,TRUE,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
    else if (sTag=="ANY") oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,1,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
    else if (sTag=="F")
    { // any female
      nLoop=1;
      oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
      while(oNPC!=OBJECT_INVALID&&GetGender(oNPC)!=GENDER_FEMALE)
      { // find a female
        nLoop++;
        oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
      } // find a female
    } // any female
    else if (sTag=="M")
    { // any male
      nLoop=1;
      oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
      while(oNPC!=OBJECT_INVALID&&GetGender(oNPC)!=GENDER_MALE)
      { // find a female
        nLoop++;
        oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN);
      } // find a female
    } // any male
    else if (sTag=="FP")
    { // any female PC
      nLoop=1;
      oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
      while(oNPC!=OBJECT_INVALID&&GetGender(oNPC)!=GENDER_FEMALE)
      { // find a female
        nLoop++;
        oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
      } // find a female
    } // any female PC
    else if (sTag=="MP")
    { // any male PC
      nLoop=1;
      oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
      while(oNPC!=OBJECT_INVALID&&GetGender(oNPC)!=GENDER_MALE)
      { // find a female
        nLoop++;
        oNPC=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,OBJECT_SELF,nLoop,CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC);
      } // find a female
    } // any male PC
  } // special tag
  if (GetIsObjectValid(oNPC)&&GetObjectSeen(oNPC)&&GetObjectType(oNPC)==OBJECT_TYPE_CREATURE)
  { // valid target found
    fDur=IntToFloat(StringToInt(sC)*6);
    if (fDur>5.9)
    { // valid duration
      AssignCommand(OBJECT_SELF,ActionForceFollowObject(oNPC,3.0));
      DelayCommand(fDur-0.1,AssignCommand(OBJECT_SELF,ClearAllActions()));
    } // valid duration
  } // valid target found
  return fDur;
} // fnNPCACTFollowByTag()

float fnNPCACTLockThings()
{ // PURPOSE: To lock nearby doors and containers
  // LAST MODIFIED BY: Deva Bryson Winblood
  object oOb;
  int nC;
  float fDist;
  nC=1;
  oOb=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nC);
  fDist=GetDistanceBetween(oOb,OBJECT_SELF);
  while(GetIsObjectValid(oOb)&&fDist<=5.0)
  { // doors
    if (GetLocked(oOb)!=TRUE&&GetIsDoorActionPossible(oOb,DOOR_ACTION_UNLOCK)==FALSE)
    { // lock the door
      AssignCommand(oOb,SetLocked(oOb,TRUE));
      AssignCommand(oOb,SpeakString("*locked*"));
    } // lock the door
    nC++;
    oOb=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nC);
    fDist=GetDistanceBetween(oOb,OBJECT_SELF);
  } // doors
  nC=1;
  oOb=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nC);
  fDist=GetDistanceBetween(oOb,OBJECT_SELF);
  while(GetIsObjectValid(oOb)&&fDist<=5.0)
  { // placeables
    if (GetHasInventory(oOb)==TRUE&&GetLocked(oOb)!=TRUE)
    { // lock it
      AssignCommand(oOb,SetLocked(oOb,TRUE));
      AssignCommand(oOb,SpeakString("*locked*"));
    } // lock it
    nC++;
    oOb=GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nC);
    fDist=GetDistanceBetween(oOb,OBJECT_SELF);
  } // placeables
  return 0.5;
} // fnNPCACTLockThings()

float fnNPCACTRandomWalk()
{ // PURPOSE: This is a replacement for Bioware's random walk.  It uses nearby
  // objects as destinations instead of vectors.
  // LAST MODIFIED BY: Deva Bryson Winblood
  object oDest;
  int nR;
  int nC=1;
  object oMe=OBJECT_SELF;
  float fTime;
  while(nC<3)
  { // queue up 3 walk destinations
    nR=d6();
    if (nR<3) oDest=GetNearestObject(OBJECT_TYPE_WAYPOINT,oMe,d6());
    else if (nR==3) oDest=GetNearestObject(OBJECT_TYPE_PLACEABLE,oMe,d6());
    else if (nR==4) oDest=GetNearestObject(OBJECT_TYPE_ITEM,oMe,d6());
    else if (nR==5) oDest=GetNearestObject(OBJECT_TYPE_TRIGGER,oMe,d6());
    else if (nR==6) oDest=GetNearestObject(OBJECT_TYPE_DOOR,oMe,d6());
    if (!GetIsObjectValid(oDest))
    { // try another destination
      if (nR<3) oDest=GetNearestObject(OBJECT_TYPE_WAYPOINT,oMe,1);
      else if (nR==3) oDest=GetNearestObject(OBJECT_TYPE_PLACEABLE,oMe,1);
      else if (nR==4) oDest=GetNearestObject(OBJECT_TYPE_ITEM,oMe,1);
      else if (nR==5) oDest=GetNearestObject(OBJECT_TYPE_TRIGGER,oMe,1);
      else if (nR==6) oDest=GetNearestObject(OBJECT_TYPE_DOOR,oMe,1);
    } // try another destination
    if (GetIsObjectValid(oDest))
    { // destination found
      fTime=IntToFloat((nC-1)*5);
      DelayCommand(fTime,AssignCommand(oMe,ClearAllActions()));
      DelayCommand(fTime+0.1,AssignCommand(oMe,ActionMoveToObject(oDest,FALSE,3.0)));
    } // destination found
    nC++;
  } // queue up 3 walk destinations
  DelayCommand(17.9,AssignCommand(oMe,ClearAllActions()));
  return 18.0;
} // fnNPCACTRandomWalk()

object NPCACTFindChair()
{ // PURPOSE: Support function to find a chair with no one sitting on
  // it already within 10 meters to sit on.
  // LAST MODIFIED BY: Deva Bryson Winblood
  object oChair=OBJECT_INVALID;
  object oTest;
  int nC;
  string sTag;
  float fDist;
  nC=1;
  oTest=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nC);
  fDist=GetDistanceBetween(oTest,OBJECT_SELF);
  while(GetIsObjectValid(oTest)&&fDist<=10.0&&oChair==OBJECT_INVALID)
  { // check for chairs
    sTag=GetTag(oTest);
    if (TestStringAgainstPattern("(Chair|Couch|Stool|BenchPew|ThroneEvil|ThroneGood|InvisChair)",sTag)&&GetSittingCreature(oTest)==OBJECT_INVALID) oChair=oTest;
    // next placeable
    nC++;
    oTest=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nC);
    fDist=GetDistanceBetween(oTest,OBJECT_SELF);
  } // check for chairs
  return oChair;
} // NPCACTFindChair()

float fnNPCACTSitForSpecified(string sCommand)
{ // PURPOSE: Directs the NPC to sit for a specified number of heartbeats
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDur=0.1;
  string sHB=GetStringRight(sCommand,GetStringLength(sCommand)-4);
  int nDur=StringToInt(sHB);
  object oChair;
  if (nDur>0)
  { // okay to sit since duration was greater than 0
    fDur=IntToFloat(nDur*6);
    oChair=NPCACTFindChair();
    if (GetIsObjectValid(oChair))
    { // sit on chair
      if (GetDistanceBetween(OBJECT_SELF,oChair)>2.5) AssignCommand(OBJECT_SELF,ActionMoveToObject(oChair,FALSE,1.0));
      AssignCommand(OBJECT_SELF,ActionSit(oChair));
      DelayCommand(fDur-0.5,AssignCommand(OBJECT_SELF,ClearAllActions()));
    } // sit on chair
    else
    { // sit crosslegged
      AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,1.0,fDur));
    } // sit crosslegged
  } // okay to sit since duration was greater than 0
  return fDur;
} // fnNPCACTSitForSpecified()

float fnNPCACTSetFacing(string sCommand)
{ // PURPOSE: Directs the NPC to set their facing direction to 0-360 degrees
  // LAST MODIFIED BY: Deva Bryson Winblood
  string sS;
  int nFacing;
  if (GetStringLeft(sCommand,2)=="SF") sS=GetStringRight(sCommand,GetStringLength(sCommand)-2);
  else { sS=GetStringRight(sCommand,GetStringLength(sCommand)-4); }
  nFacing=StringToInt(sS);
  if (nFacing>360) nFacing=0;
  else if (nFacing<0) nFacing=0;
  AssignCommand(OBJECT_SELF,SetFacing(IntToFloat(nFacing)));
  return 1.0;
} // fnNPCACTSetFacing()

float fnNPCACTUnequipWeapons()
{ // PURPOSE: Causes the NPC to unequip weapons
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDur=0.1;
  object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
  if (GetIsObjectValid(oItem)) { fDur=fDur+1.0; AssignCommand(OBJECT_SELF,ActionUnequipItem(oItem)); }
  oItem=GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
  if (GetIsObjectValid(oItem)) { fDur=fDur+1.0; AssignCommand(OBJECT_SELF,ActionUnequipItem(oItem)); }
  return fDur;
} // fnNPCACTUnequipWeapons()

float fnNPCACTWait(string sCommand)
{ // PURPOSE: Causes the NPC to do nothing for specified amount of time
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDur=0.1;
  string sS;
  string sPre;
  string sSuf;
  int nN;
  if (GetStringLeft(sCommand,2)=="WT") sS=GetStringRight(sCommand,GetStringLength(sCommand)-2);
  else {sS=GetStringRight(sCommand,GetStringLength(sCommand)-4); }
  sPre=fnParse(sS,"/");
  sSuf=fnRemoveParsed(sS,sPre,"/");
  nN=StringToInt(sPre);
  fDur=fDur+IntToFloat(nN);
  nN=StringToInt(sSuf);
  fDur=fDur+(IntToFloat(nN)*0.1);
  return fDur;
} // fnNPCACTWait()

float fnNPCACTUnlock()
{ // PURPOSE: Causes the NPC to unlock doors or containers provided they have the key if one is required
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDur=0.1;
  int nC;
  object oOb;
  float fDist;
  string sKey;
  object oMe=OBJECT_SELF;
  // Doors
  nC=1;
  oOb=GetNearestObject(OBJECT_TYPE_DOOR,oMe,nC);
  fDist=GetDistanceBetween(oOb,oMe);
  while(GetIsObjectValid(oOb)&&fDist<=8.0)
  { // check for locked doors
    if (GetLocked(oOb)==TRUE)
    { // this door is locked
      if (GetLockKeyRequired(oOb)==TRUE)
      { // requires a key
        sKey=GetLockKeyTag(oOb);
        if (GetItemPossessedBy(oMe,sKey)!=OBJECT_INVALID)
        { // has key
          AssignCommand(oOb,SetLocked(oOb,FALSE));
          AssignCommand(oOb,SpeakString("*unlocked*"));
          fDur=2.0;
        } // has key
        else
        { //
          PrintString("NPC ACT:"+GetTag(oMe)+" requires a key to unlock "+GetTag(oOb)+" but, does not possess one.");
        } //
      } // requires a key
      else
      { // no key required
        AssignCommand(oOb,SetLocked(oOb,FALSE));
        AssignCommand(oOb,SpeakString("*unlocked*"));
        fDur=2.0;
      } // no key required
    } // this door is locked
    nC++;
    oOb=GetNearestObject(OBJECT_TYPE_DOOR,oMe,nC);
    fDist=GetDistanceBetween(oOb,oMe);
  } // check for locked doors
  // placeables
  nC=1;
  oOb=GetNearestObject(OBJECT_TYPE_PLACEABLE,oMe,nC);
  fDist=GetDistanceBetween(oOb,oMe);
  while(GetIsObjectValid(oOb)&&fDist<=8.0)
  { // check for locked doors
    if (GetLocked(oOb)==TRUE&&GetHasInventory(oOb)==TRUE)
    { // this door is locked
      if (GetLockKeyRequired(oOb)==TRUE)
      { // requires a key
        sKey=GetLockKeyTag(oOb);
        if (GetIsObjectValid(GetItemPossessedBy(oMe,sKey)))
        { // has key
          AssignCommand(oOb,SetLocked(oOb,FALSE));
          AssignCommand(oOb,SpeakString("*unlocked*"));
          fDur=2.0;
        } // has key
        else
        { //
          PrintString("NPC ACT:"+GetTag(oMe)+" requires a key to unlock "+GetTag(oOb)+" but, does not possess one.");
        } //
      } // requires a key
      else
      { // no key required
        AssignCommand(oOb,SetLocked(oOb,FALSE));
        AssignCommand(oOb,SpeakString("*unlocked*"));
        fDur=2.0;
      } // no key required
    } // this door is locked
    nC++;
    oOb=GetNearestObject(OBJECT_TYPE_PLACEABLE,oMe,nC);
    fDist=GetDistanceBetween(oOb,oMe);
  } // check for locked doors
  return fDur;
} // fnNPCACTUnlock()

float fnNPCACTTakeItem(string sCommand)
{ // PURPOSE: Take nearby object (within 10m) with specified tag
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDur=0.1;
  string sTag;
  object oItem;
  if (GetStringLeft(sCommand,2)=="TK") sTag=GetStringRight(sCommand,GetStringLength(sCommand)-2);
  else { sTag=GetStringRight(sCommand,GetStringLength(sCommand)-4); }
  fnDebug(" fnNPCACTTakeItem("+sTag+")",TRUE);
  oItem=GetNearestObjectByTag(sTag);
  if (GetIsObjectValid(oItem)&&GetDistanceBetween(OBJECT_SELF,oItem)<=10.0)
  { // valid target
    fDur=4.0;
    if (GetDistanceBetween(OBJECT_SELF,oItem)>2.0)
    { // move to object
      AssignCommand(OBJECT_SELF,ActionMoveToObject(oItem,FALSE,1.0));
      fDur=12.0;
    } // move to object
    AssignCommand(OBJECT_SELF,ActionPickUpItem(oItem));
  } // valid target
  return fDur;
} // fnNPCACTTakeItem()

float fnNPCACTSleep()
{ // PURPOSE: Apply sleep effect to NPC.  Will not work if NPC is immune to sleep.
  // LAST MODIFIED BY: Deva Bryson Winblood
  float fDur=60.0;
  effect eSleep=EffectSleep();
  effect eSnore=EffectVisualEffect(VFX_IMP_SLEEP);
  if (!GetIsImmune(OBJECT_SELF,IMMUNITY_TYPE_SLEEP))
  { // not immune to sleep
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSleep,OBJECT_SELF,fDur);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSnore,OBJECT_SELF,4.0);
    DelayCommand(fDur/3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSnore,OBJECT_SELF,4.0));
    DelayCommand((fDur/3.0)*2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSnore,OBJECT_SELF,4.0));
  } // not immune to sleep
  else
  { // immune to sleep
    DelayCommand(2.0,SetCommandable(FALSE,OBJECT_SELF));
    fDur=fnNPCACTRest();
    DelayCommand(fDur+2.0,SetCommandable(TRUE,OBJECT_SELF));
  } // immune to sleep
  return fDur;
} // fnNPCACTSleep()

float fnNPCACTRest()
{ // PURPOSE: To provide a simulated sleeping for NPCs that you
  // wish the sleep to be interruptable or those who are immune to the sleep effect.
  float fDur=60.0;
  effect eSnore=EffectVisualEffect(VFX_IMP_SLEEP);
  if (d4()<4) AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,fDur));
  else { AssignCommand(OBJECT_SELF,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,fDur));     }
  ApplyEffectToObject(DURATION_TYPE_INSTANT,eSnore,OBJECT_SELF,4.0);
  DelayCommand(fDur/3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSnore,OBJECT_SELF,4.0));
  DelayCommand((fDur/3.0)*2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSnore,OBJECT_SELF,4.0));
  return fDur;
} // fnNPCACTRest()

float fnNPCACTRandomCommand(string sCom)
{ // PURPOSE: To choose randomly fron n amount of random commands
  // LAST MODIFIED BY: Deva Bryson Winblood
  int nTotalCommands=StringToInt(GetStringRight(sCom,2));
  string sActions=GetLocalString(OBJECT_SELF,"sAct");
  string sOut="";
  string sCommand;
  int nRnd=Random(nTotalCommands)+1;
  int nC=0;
  fnDebug("RANDOM COMMANDS:"+IntToString(nTotalCommands)+" PICKED#:"+IntToString(nRnd));
  while (GetStringLength(sActions)>0)
  { // get command to do
    sCommand=fnParse(sActions);
    sActions=fnRemoveParsed(sActions,sCommand);
    nC++;
    //fnDebug("  #"+IntToString(nC)+":"+sCommand+" '"+sActions+"'");
    if (nC==nRnd||nC>nTotalCommands)
    { // build command string
      if (GetStringLength(sOut)>0) { sOut=sOut+"."+sCommand;}
      else { sOut=sCommand; }
    } // build command string
  } // get command to do
  SetLocalString(OBJECT_SELF,"sAct",sOut);
  return 0.1;
} // fnNPCACTRandomCommand()

//void main(){}
