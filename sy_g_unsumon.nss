/*
    - funkcia sluzi na odvolanie pritelicka ak nieje pod vplyvom negativneho efektu
*/

#include "me_soul_inc"

/*
    zistujem rozne negativne efekty ci ma na sebe potvora, ak ano neda sa odvolat
    kym to hrac potvore nevylieci
*/
int sy_is_beast_ok(object oBeast)
{
    /*
        dufam ze som tu dal tie najbeznejsie negativne efekty ktore sa vyskytnu
        take ako petrify,dazed a confusion som nedal lebo v tom momente by nemal
        ist dialog zvierata zapnut (snad, tiez neviem vsetko)
    */
    effect eFX = GetFirstEffect(oBeast);
    while (GetIsEffectValid(eFX))
    {
        int nType = GetEffectType(eFX);
        switch (nType)
        {
            case EFFECT_TYPE_ABILITY_DECREASE :
            case EFFECT_TYPE_AC_DECREASE :
            case EFFECT_TYPE_BLINDNESS :
            case EFFECT_TYPE_DAMAGE_DECREASE :
            case EFFECT_TYPE_CURSE :
            case EFFECT_TYPE_DISEASE :
            case EFFECT_TYPE_MOVEMENT_SPEED_DECREASE :
            case EFFECT_TYPE_NEGATIVELEVEL :
            case EFFECT_TYPE_POISON :
                return FALSE;
                break;
        }
        eFX = GetNextEffect(oBeast);
    }
    return TRUE;
}

//==============================================================================

/*
    - tu som pouzil 1 script na osetrenie 2 stavov, pre familiara i pre animal
      companiona
*/

void main()
{
    object oPC        = GetPCSpeaker();
    object oFamiliar  = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oAnimal    = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oSoulStone = GetSoulStone(oPC);
    int    nHP;

    if (oAnimal!=OBJECT_INVALID)
    {
        //overim ci je zdravy
        if (sy_is_beast_ok(oAnimal)==FALSE)
        {
            SendMessageToPC(oPC,"Nemozes odvolat zviera ked je pod vplyvom negativneho efektu");
            return;
        }

        //ulozim HP na dusu
        nHP = GetMaxHitPoints(oAnimal) - GetCurrentHitPoints(oAnimal);
        SetLocalInt(oSoulStone, "hp_ani", nHP);

        //znicim potvoru a obnovim feat
        DestroyObject(oAnimal);
        IncrementRemainingFeatUses(oPC,FEAT_ANIMAL_COMPANION);
        return;
    }

    if (oFamiliar!=OBJECT_INVALID)
    {
        //overim ci je zdravy
        if (sy_is_beast_ok(oFamiliar)==FALSE)
        {
            SendMessageToPC(oPC,"Nemozes odvolat familiara ked je pod vplyvom negativneho efektu");
            return;
        }

        //ulozim HP na dusu
        nHP = GetMaxHitPoints(oFamiliar) - GetCurrentHitPoints(oFamiliar);
        SetLocalInt(oSoulStone, "hp_fam", nHP);

        //znicim potvoru a obnovim feat
        DestroyObject(oFamiliar);
        IncrementRemainingFeatUses(oPC,FEAT_SUMMON_FAMILIAR);
        return;
    }
}
