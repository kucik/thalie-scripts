// * Script pro boost abilit NPC by Igor
// * script: ig_boost_npc
// * je treba upravit promennou IG_MODIFY_ABILITY_XP xp ve scriptu pro rozdelovani xp
// * Kucik 19.10.2008 Upraveno jen na NPC z DYN, spawnu
//                    Snizeni vzdy o lichej pocet, zvyseni o sudej.

#include "ja_lib"
#include "ku_resizer"

int Modify() {         // gausovo rozdeleni (stred 0, rozptyl 1)

//Urcime modifikaci 0-5
/*    int nModify = Random(Random(6)+1);
    return nModify;*/

    float n1 = 1-randomFloat(); //(0,1]
    float n2 = 1-randomFloat();

    float R = sqrt( -2.0 * log(n1) );
    float O = 360.0 * n2;

    int i = FloatToInt(R*sin(O));
    if(i > 5) i = 5;
    else if(i < -5) i = -5;

    return i;
}

int ModifyAbility(int nAbility, int nModify) { //Aplikujeme modifikaci

     if(nModify == 0)
       return 0;

     effect eChange;
     if(nModify > 0) {
       nModify = nModify / 2;  // Udelame sude cislo
       nModify = nModify * 2;
       eChange = EffectAbilityIncrease(nAbility,nModify);
     }
     else {
       nModify = (1 - nModify) / 2;
       nModify = (nModify * 2) - 1;
       eChange = EffectAbilityDecrease(nAbility,nModify);
     }

     ApplyEffectToObject(DURATION_TYPE_PERMANENT, eChange, OBJECT_SELF);

     return nModify;
}

int AplyImmunities(object oNPC, int AI_BOSS) {

  int iProb = 2;
  if(AI_BOSS)
    iProb = 70;

  effect eff;
  int cnt = 0;

  if(Random(100) < iProb) {
    eff = EffectImmunity(IMMUNITY_TYPE_DOMINATE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eff,oNPC);
    cnt++;
  }

  return cnt;

}

void main()
{
        object oNPC = OBJECT_SELF;
        if(GetLocalInt(OBJECT_SELF,"IG_BOOSTED"))
          return;

        int AI_BOSS = GetLocalInt(oNPC,"AI_BOSS");

        if(!GetLocalInt(OBJECT_SELF,"KU_DYNAMICALY_SPAWNED") &&
           (AI_BOSS == 0)) {
          return;
        }

        int nSum = 0;
        int iSize = 0;

        nSum += ModifyAbility(ABILITY_STRENGTH, Modify());
        nSum += ModifyAbility(ABILITY_CONSTITUTION, Modify());
        iSize = nSum / 2;
        nSum += ModifyAbility(ABILITY_DEXTERITY, Modify());
        nSum += ModifyAbility(ABILITY_INTELLIGENCE, Modify());
        nSum += ModifyAbility(ABILITY_WISDOM, Modify());
        nSum += ModifyAbility(ABILITY_CHARISMA, Modify());

        nSum += 2*(AplyImmunities(oNPC,AI_BOSS));

// * Prumerne je soucet boostu nSum 7.5, proto vypocitame fXP pomoci vzorce
// * s modifikatorem fModifier. Pokud je NPC slabsi, obdrzi hrac mene XP, pokud
// * je postava silnejsi dostane vic.
        /*
        float fModifier = 1.3;
        float fSum = IntToFloat(nSum);
        float fXP = ((((nSum - 7.5) * fModifier)/100) + 1);*/

        float fXP = 1 + (nSum * 0.1);
        SetLocalFloat(OBJECT_SELF, "IG_MODIFY_ABILITY_XP", fXP);

        /**
         * Random size */
        if(iSize != 0) {
          Resizer_ResizeCreature(oNPC,iSize);
          AssignCommand(oNPC, ActionRandomWalk());
        }

        SetLocalInt(OBJECT_SELF,"IG_BOOSTED",TRUE);

}


