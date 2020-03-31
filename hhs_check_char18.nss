//::///////////////////////////////////////////////
//:: hhs_check_charis
//:: Copyright (c) 2006 harphield ^_^
//:://////////////////////////////////////////////
/*
    tento script vloz do zalozky Text Appears When v editore konverzacii a
    vybrana vetva rozhovoru sa objavi ak je podmienka splnena

    v tomto pripade ak ma postava viac charismy/int/str/etc ako dany pocet
*/
//:://////////////////////////////////////////////
//:: Created By: harph
//:: Created On: 2.2. 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;

    /*
    namiesto ABILITY_CHARISMA mozes dat inu konstantu zo zalozky Constants
    ABILITY_CONSTITUTION
    ABILITY_DEXTERITY
    ABILITY_CHARISMA
    ABILITY_INTELLIGENCE
    ABILITY_STRENGTH
    ABILITY_WISDOM

    namiesto 12 si daj hodnotu aku potrebujes aby postava splnala ;)
    */
    iResult = (GetAbilityScore(GetPCSpeaker(), ABILITY_CHARISMA) > 17);
    return iResult;
}
