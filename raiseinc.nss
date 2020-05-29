#include "subraces"
#include "sh_deity_inc"

void UnequipItemsAfterDelevel(object oPC);


void Raise(object oPlayer)
{
 effect eEff = GetFirstEffect(oPlayer);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
 ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

 //Search for effects
 while(GetIsEffectValid(eEff))
 {
   //Shaman - nesmim rusit efekty co ma postava skrze upravy povolani
   if (GetEffectDurationType(eEff)==DURATION_TYPE_TEMPORARY)
   {
     RemoveEffect(oPlayer, eEff);
   }
   eEff = GetNextEffect(oPlayer);
 }
 Subraces_RespawnSubrace( oPlayer );

 DelayCommand( 1.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(10.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(30.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(60.0,UnequipItemsAfterDelevel(oPlayer));
 DelayCommand(90.0,UnequipItemsAfterDelevel(oPlayer));
}

int GetItemRequiedLevel(object oItem) {

  int iPlot,iStolen;
  iStolen = GetStolenFlag(oItem);
  iPlot = GetPlotFlag(oItem);
  SetStolenFlag(oItem,0);
  SetPlotFlag(oItem,0);

  int iPrice= GetGoldPieceValue(oItem);
  int iLevel;
  int iRow = 0;
  while( StringToInt(Get2DAString("itemvalue","MAXSINGLEITEMVALUE",iRow)) < iPrice) {
    iRow++;
  }

  // Level je vzdy radek + 1;
  iRow++;
  return iRow;
}

void UnequipItemsAfterDelevel(object oPC) {
  if(!GetIsPC(oPC)) {
    return;
  }

  int i;
  object oItem;
  int iHD = GetHitDice(oPC);
  int ILR;

  for(i=0;i<NUM_INVENTORY_SLOTS;i++) {
    oItem = GetItemInSlot(i,oPC);
    if(GetIsObjectValid(oItem)) {
      ILR = GetItemRequiedLevel(oItem);
      if(ILR > iHD) {
        AssignCommand(oPC,ActionUnequipItem(oItem));
      }
    }
  }

}

void JumpToCleric(object oCleric)
{
    ClearAllActions();
    DelayCommand(1.0,JumpToObject(oCleric));
}


void FindAndRaisePlayer(int iSpell,object oCaster,string sPlayerName, string sCharacterName, int iDestroyObjectSelf, location lRaise)
{
        object oPC = GetFirstPC();

        while(oPC != OBJECT_INVALID)
        {
            if((GetPCPlayerName(oPC) == sPlayerName) && (GetName(oPC) == sCharacterName))
            {
                // Levelup on raise bugfix
                if(GetLocalInt(oPC,"RELEVELING"))
                {
                  SendMessageToAllDMs("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
                  WriteTimestampedLogEntry("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
                  return;
                }

                // Pokud si hrac nepreje byt oziven, bDisRes = TRUE
                int bDisRes = GetLocalInt(oPC,"KU_ZAKAZ_OZIVENI");
                if(!bDisRes)
                {
                  Raise(oPC);

                  //edit Sylm : po oziveni zmazem priznak smrti isDead = 0
                  object oSoulItem = GetSoulStone(oPC);
                  DeleteLocalInt(oSoulItem,"isDead");
                  //end Sylm

                  AssignCommand(oPC, JumpToCleric(oCaster));
                  if (iSpell == 972 )                           //Epic spell ressurection
                  {
                        effect eDam1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,100);
                        effect eDam2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,100);
                        effect eDam3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,100);
                        effect eLink = EffectLinkEffects(eDam1,eDam2);
                        eLink = EffectLinkEffects(eLink,eDam3);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC,9.0f);

                  }
                  else if (iSpell == SPELL_RAISE_DEAD){
                      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetCurrentHitPoints(oPC)-1),oPC);
                  }

                  if (iSpell==SPELL_RESURRECTION)
                  {
                    if (GetThalieClericDeity(oCaster)==DEITY_JUANA)
                    {
                        effect ef1 = EffectImmunity(IMMUNITY_TYPE_ABILITY_DECREASE);
                        effect ef2 = EffectImmunity(IMMUNITY_TYPE_DEATH);
                        effect ef3 = EffectImmunity(IMMUNITY_TYPE_FEAR);
                        effect ef4 = EffectImmunity(IMMUNITY_TYPE_NEGATIVE_LEVEL);
                        effect ef5 = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
                        effect ef6 = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
                        effect ef7 = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
                        effect ef8 = EffectImmunity(IMMUNITY_TYPE_STUN);
                        effect eL = EffectLinkEffects(ef1,ef2);
                        eL = EffectLinkEffects(eL,ef3);
                        eL = EffectLinkEffects(eL,ef4);
                        eL = EffectLinkEffects(eL,ef5);
                        eL = EffectLinkEffects(eL,ef6);
                        eL = EffectLinkEffects(eL,ef7);
                        eL = EffectLinkEffects(eL,ef8);
                        eL = SupernaturalEffect(eL);
                        DelayCommand(0.5,AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eL,oPC,TurnsToSeconds(1))));
                    }
                  }

                  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), lRaise);
                  SetLocalLocation(oPC, "LOCATION", lRaise);
                  SetPersistentLocation(oPC, "LOCATION", lRaise);

                  if (iDestroyObjectSelf) DestroyObject(OBJECT_SELF, 1.0f);

                  DeleteLocalInt(oPC, "LastHourRest");
                  DeleteLocalInt(oPC, "LastDayRest");
                  DeleteLocalInt(oPC, "LastYearRest");
                  DeleteLocalInt(oPC, "LastMonthRest");
                  SendMessageToPC(oPC,"Postava "+sCharacterName+" byla ozivena.");
                  return;
                }
                SendMessageToPC(oPC,"Nepodarilo se vyprostit dusi z podsveti.");
            }
            oPC = GetNextPC();
        }
        SpeakString("//Hrac "+sCharacterName+" s postavou "+sPlayerName+" neni ve hre!");
}
