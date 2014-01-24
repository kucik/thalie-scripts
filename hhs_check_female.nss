//::///////////////////////////////////////////////
//:: hhs_check_male
//:: Copyright (c) 2006 harphield ^_^
//:://////////////////////////////////////////////
/*
    tento script vloz do zalozky Text Appears When v editore konverzacii a
    vybrana vetva rozhovoru sa objavi ak je podmienka splnena

    v tomto pripade ak je pohlavie MUZ/ZENA
*/
//:://////////////////////////////////////////////
//:: Created By: harph
//:: Created On: 2.2. 2006
//:://////////////////////////////////////////////

int StartingConditional()
{
    int iResult;

    // namiesto GENDER_MALE (muz) si mozes dat GENDER_FEMALE (zena)
    iResult = (GetGender(GetPCSpeaker()) == GENDER_FEMALE);
    return iResult;
}
