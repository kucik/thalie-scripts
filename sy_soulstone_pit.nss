//script vola z dialogu duse bytosti - napit sa zo zdroja tekutiny

#include "me_pcneeds_inc"

void main()
{
    object oPC   = GetPCSpeaker();
    int iTypVody = GetLocalInt(oPC, "TypVody");
    //ak niesom pri vode tak mozem skoncit
    if (iTypVody==0)
    {
        SendMessageToPC(oPC,"<cDa >Musis stat u vodneho zdroja ak sa chces napit</c>");
        return;
    }

    //pitna voda
    if (iTypVody==1)
    {
        PC_ConsumeItValues(oPC ,0.0, 1000.0, 0.0);
        FloatingTextStringOnCreature("*napije se*", oPC, TRUE);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
    }
}
