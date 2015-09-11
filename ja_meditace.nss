/*
    System meditace/modlitby
*/

#include "ja_inc_stamina"
#include "ja_inc_meditace"
#include "sh_cr_potions"
#include "sh_classes_inc"
//#include "cl_kurt_plav_inc"

string getRestString(int type){
    switch(type){
        case 0: return "Opetovne budes moci spat za ";
        case 1: return "Opetovne budes moci meditovat za ";
        case 2: return "Tve modlitby budou vyslyseny az za ";
    }

    return "---CHYBA - REPORTUJ DM TENTO UDAJ: (ja_meditace:"+IntToString(type)+")---";
}

void InventoryActions(object oPC)
{
    object oItem = GetFirstItemInInventory(oPC);

    while (GetIsObjectValid(oItem))
    {
        // Reset henchman key uses.
        if (GetTag(oItem) == "myi_hen_key")
            SetLocalInt(oItem, "HENCHMAN_USES", 1);

        oItem = GetNextItemInInventory(oPC);
    }
}

void finish(object oPC){

    if(GetCurrentAction(oPC) == ACTION_WAIT){   //uspech
        object oSoul = GetSoulStone(oPC);
        setMinutesAwake(oPC, "JA_MED_");
        SendMessageToPC(oPC, "Opet jsi nabyl svych schopnosti");

        int lastHP = GetCurrentHitPoints(oPC);
        ForceRest(oPC);
        OnLvlupClassSystem(oPC);
        OnRestClassSystem(oPC);
   //     PanoveRadiPlavovlaskyBarvaVlasu(oPC);
        int damage = GetCurrentHitPoints(oPC) - lastHP;
        if(lastHP > 0 && damage > 0){
            effect e = EffectDamage( damage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY);
            ApplyEffectToObject( DURATION_TYPE_INSTANT, e, oPC );
        }
        sh_OnRestResetElixirPoints(oPC,oSoul);
        FatigueCheck(oPC, FALSE);
        InventoryActions(oPC);
    }
    else{
        SendMessageToPC(oPC, "Prerusil jsi sve soustredeni!");
    }
}

void RemoveAllSpells(object oPC){
    int i;
    int remain;
    for(i = 0; i<805; i++) {
        remain = 15;
        // Fuj! Hnusna pojistka proti zacykleni.
        while(GetHasSpell(i, oPC) && remain > 0) {
            DecrementRemainingSpellUses( oPC, i );
            remain--;
        }
    }
}

void main()
{

    object oPC = OBJECT_SELF;
    object oSoul = GetSoulStone(oPC);

    // No meditation if mounted
    if (GetLocalInt(oSoul, "MOUNTED"))
    {
        SendMessageToPC(oPC, "Akci nelze provést v sedle.");
        return;
    }

    int restStyle = getRestStyle(oPC);
    if(restStyle == SPANEK){
        SendMessageToPC(oPC, "Pokud chces spat, zmackni R nebo klikni na ikonku spani.");
        return;
    }

    int length = 10 + GetHitDice(oPC); // v minutach (tazich)
    if(length > 30)
      length = 30;
    //KURTIZANA JE IMUNNI NA UNAVU
    if (GetHasFeat(FEAT_KURTIZANA_CELE_NOCI_OKA_NEZAMHOURI,oPC) == TRUE)
    {
        length = length/3;
    }
    int awake = getMinutesAwake(oPC, "JA_MED_");

    if(length <= awake){
        string act;
        int animation;

        if(restStyle == MEDITACE){
            act = "*medituje*";
            animation = ANIMATION_LOOPING_MEDITATE;
            RemoveAllSpells(oPC);

        }
        else if(restStyle == MODLITBA){
            act = "*modli se*";
            animation = ANIMATION_LOOPING_WORSHIP;
        }
        int iAltAnim = GetLocalInt(oSoul,"KU_MEDITATE_ANIM");
        if(iAltAnim > 0) {
          animation = iAltAnim;
        }

        FloatingTextStringOnCreature( act, oPC, FALSE );
        AssignCommand(oPC, PlayAnimation( animation, 1.0, 39.5 ));
        AssignCommand(oPC, ActionWait(1.0));

        DelayCommand( 40.0f, finish(oPC) );
    }
    else{
        SendMessageToPC(oPC, getRestString(restStyle)+IntToString(length-awake)+" minut.");
        return;
    }
}

