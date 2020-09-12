//#include "sh_classes_const"
//const float STAMINA_MAX = 5000.0;
const float STAMINA_MIN = 1.0;

float getMaxStamina(object oPC){
    float fLevelBonus = 250.0 * IntToFloat(GetHitDice(oPC));
    return 2500.0 + fLevelBonus;
}

void restoreStamina(object oPC, float f){
    float fStamina = GetLocalFloat(oPC, "JA_STAMINA");
    fStamina += f;

    if(fStamina > getMaxStamina(oPC))
     fStamina = getMaxStamina(oPC);

    SetLocalFloat(oPC, "JA_STAMINA", fStamina);

}

float getStamina(object oPC){
    return GetLocalFloat(oPC, "JA_STAMINA");
}

void woundStamina(object oPC, float f, int ignoreConst = FALSE){
    //Klerik s domenou putovani je o 15% odolnejsi
    if (GetHasFeat(FEAT_TRAVEL_DOMAIN_POWER,oPC) == TRUE)
    {
        if (d100(1)<=15) return;
    }
    float fStamina = GetLocalFloat(oPC, "JA_STAMINA");
    int iConst = GetAbilityScore(oPC,ABILITY_CONSTITUTION, TRUE);
    float fMod = (10 / (iConst + 5 ) - iConst * 0.002 + 0.25);

    if(ignoreConst)
      fMod = 1.0;

//    fStamina -= f*( 1 - (GetAbilityScore(oPC,ABILITY_CONSTITUTION, TRUE) - 10) * 0.06 );
    //fStamina -= f*pow(1.2,IntToFloat(-GetAbilityModifier(ABILITY_CONSTITUTION, oPC)));
    fStamina -= f * fMod;

    if(fStamina < STAMINA_MIN)
     fStamina = STAMINA_MIN;

    SetLocalFloat(oPC, "JA_STAMINA", fStamina);

}

int getStatusInt(object oPC){
    float fStamina = GetLocalFloat(oPC, "JA_STAMINA");
    float fMaxStamina = getMaxStamina(oPC)/5.0;

    int iState;
    if(fStamina > 4.0* fMaxStamina){      //100-80%
        iState = 5;
    }
    else if(fStamina > 3.0 * fMaxStamina){ //80-60%
        iState = 4;
    }
    else if(fStamina > 2.0 * fMaxStamina){ //60-40%
        iState = 3;
    }
    else if(fStamina > 1.0 * fMaxStamina){ //40-20%
        iState = 2;
    }
    else if(fStamina > STAMINA_MIN){//20-0%
        iState = 1;
    }
    else {//0%
        iState = 0;
    }

    return iState;

}

string getStatusString(object oPC){
    int iStatus = getStatusInt(oPC);
    string sState;

    switch(iStatus){
        case 5:
            sState = "odpocaty";
            break;
        case 4:
            sState = "mirne unaveny";
            break;
        case 3:
            sState = "unaveny";
            break;
        case 2:
            sState = "vycerpany";
            break;
        case 1:
            sState = "uplne vycerpany";
            break;
        case 0:
            sState = "jak ozivla mrtvola";
            break;
    }

    return sState;
}

void FatigueCheck(object oPC, int bStatusMessages = TRUE)
{
    if (!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC) || GetIsPossessedFamiliar(oPC))
        return;

    int iStatus = getStatusInt(oPC);

    if(iStatus < 4 && bStatusMessages)
        SendMessageToPC(oPC, "Prave jsi "+getStatusString(oPC)+".");

    if(iStatus < 3 && !GetLocalInt(oPC, "KU_STAMINA_PENALTY"))
    {
        SetLocalInt(oPC, "KU_STAMINA_PENALTY", 1);
        effect ePenalty = ExtraordinaryEffect(EffectAttackDecrease(2));
        ePenalty = EffectLinkEffects(ExtraordinaryEffect(EffectACDecrease(2)),ePenalty);
        ApplyEffectToObject( DURATION_TYPE_PERMANENT, ExtraordinaryEffect(ePenalty), oPC );
    }

    if(iStatus < 2 && !GetLocalInt(oPC, "JA_STAMINA_SLOWED"))
    {
        SetLocalInt(oPC, "JA_STAMINA_SLOWED", 1);
        effect eSlow = ExtraordinaryEffect(EffectSlow());

        ApplyEffectToObject( DURATION_TYPE_PERMANENT, eSlow, oPC );
    }

    if((iStatus < 1) && (!GetLocalInt(oPC,"ku_sleeping")))
    {
        AssignCommand(oPC, ActionRest(TRUE));
    }
}
