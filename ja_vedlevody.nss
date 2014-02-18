#include "ku_water_inc"

int StartingConditional()
{
    object oPC   = GetPCSpeaker();
    int iTypVody = GetLocalInt(oPC, "TypVody");

    //pitna voda
    if (ku_GetIsDrinkable(iTypVody))
    {
        return TRUE;
    }

    return FALSE;
}

