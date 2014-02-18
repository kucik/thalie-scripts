//script vola z dialogu duse bytosti - napit sa zo zdroja tekutiny

#include "me_pcneeds_inc"
#include "ku_water_inc"

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
    if (ku_GetIsDrinkable(iTypVody))
    {
        if(ku_GetIsSickWater(iTypVody) && !GetLocalInt(oPC,"ku_water_warn")) {
            FloatingTextStringOnCreature("Voda divne zapacha. Opravdu zde chces nabrat vodu?", oPC,TRUE);
            SetLocalInt(oPC,"ku_water_warn",TRUE);
            DelayCommand(10.0, DeleteLocalInt(oPC,"ku_water_warn"));
            return;
        }

        PC_ConsumeItValues(oPC ,0.0, 1000.0, 0.0);
        FloatingTextStringOnCreature("*napije se*", oPC, TRUE);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
        
        if (ku_GetIsSickWater(iTypVody)) {
            FloatingTextStringOnCreature("Uff, nejak nechuti dobre.", oPC,TRUE);
            effect eEfx = EffectDisease(DISEASE_SHAKES);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEfx,oPC,0.0f);
        }
    }
}
