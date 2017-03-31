//#include "aps_include"
#include "raiseinc"
//#include "sy_main_lib"

//#include "ku_libbase"
#include "ku_exp_inc"
#include "ja_inc_stamina"

void ApplyPenalty(object oDead, float nPerc)
{
    if(nPerc < 1.0)
      nPerc = 1.0;
    int nXP = GetXP(oDead);
    int nPenalty = FloatToInt(nPerc * nXP / 100);            //nPerc %
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning under 4th level
/*    int nMin;
    if(nHD < 4)
        nMin = ((nHD * (nHD - 1)) / 2) * 1000;
    else
        nMin = 0;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;

    nPenalty = nXP - nNewXP;*/

    // Maximum 1% of 20. level
    if(nPenalty > 10000)
      nPenalty = 10000;


    object oSoul = GetSoulStone(oDead);
    /* CTF Mode penalta */
    if(GetLocalInt(oSoul,"CTF_DEATH")) {
      nPenalty = nPenalty / 10;
    }
    DeleteLocalInt(oSoul,"CTF_DEATH");

    int xpk = GetLocalInt(oSoul,"ku_XPLost");
    SetLocalInt(oSoul,"ku_XPLost",xpk + nPenalty);

//    SetXP(oDead, nNewXP);
    ku_GiveXPDebt(oDead,nPenalty);
}


void main()
{

    int i = GetLastSpell();
    object oCaster = GetLastSpellCaster();
    int iCasterlvl = GetCasterLevel(oCaster);
    if( i == SPELL_RESURRECTION || i == SPELL_RAISE_DEAD  || i == 972  ){
        object oPC = GetFirstPC();
        string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
        string sPCName = GetLocalString(OBJECT_SELF, "PC");
        int bIsItCleric = GetLocalInt(OBJECT_SELF, "KU_CLERIC");
        while(oPC != OBJECT_INVALID){
            if(GetPCPlayerName(oPC) == sPlayerName && GetName(oPC) == sPCName){
                // Levelup on raise bugfix
                if(GetLocalInt(oPC,"RELEVELING")) {
                  SendMessageToAllDMs("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
                  WriteTimestampedLogEntry("BUG!!! Postava"+GetName(oPC)+" hrac "+GetPCPlayerName(oPC)+" pokus o bug - revelup pri oziveni.");
                  return;
                }

                // Pokud si hrac nepreje byt oziven, bDisRes = TRUE
                int bDisRes = GetLocalInt(oPC,"KU_ZAKAZ_OZIVENI");
                if(!bDisRes) {

                  Raise(oPC);

                  //edit Sylm : po oziveni zmazem priznak smrti isDead = 0
                  object oSoulItem = GetSoulStone(oPC);
                  DeleteLocalInt(oSoulItem,"isDead");
                  //end Sylm

                  AssignCommand(oPC, ClearAllActions());
                  location lRaise = GetLocation(OBJECT_SELF);
                  AssignCommand(oPC, JumpToLocation(lRaise));
                  if (i == 972 )                           //Epic spell ressurection
                  {
                        effect eDam1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,100);
                        effect eDam2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,100);
                        effect eDam3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,100);
                        effect eLink = EffectLinkEffects(eDam1,eDam2);
                        eLink = EffectLinkEffects(eLink,eDam3);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC,9.0f);

                  }
                  else if (i == SPELL_RAISE_DEAD){
                      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetCurrentHitPoints(oPC)-1),oPC);
                      ApplyPenalty(oPC,1.0);
                      woundStamina(oPC, getMaxStamina(oPC),TRUE);
                  }
                  else {
                      ApplyPenalty(oPC,1.0);
                  }
                  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), lRaise);
                  SetLocalLocation(oPC, "LOCATION", lRaise);
                  SetPersistentLocation(oPC, "LOCATION", lRaise);

                  DestroyObject(OBJECT_SELF, 1.0f);

                  DeleteLocalInt(oPC, "LastHourRest");
                  DeleteLocalInt(oPC, "LastDayRest");
                  DeleteLocalInt(oPC, "LastYearRest");
                  DeleteLocalInt(oPC, "LastMonthRest");

                  return;
                }
              if (bIsItCleric)
                 SpeakString("Tuto dusi se bohuzel nedari vyprostit z podsveti.");
              else
                 SendMessageToPC(oPC,"Nepodarilo se vyprostit dusi z podsveti.");
            }
            oPC = GetNextPC();
        }
        SpeakString("//Hrac "+sPCName+" s postavou "+sPlayerName+" neni ve hre!");
    }
}
