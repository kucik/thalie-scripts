void main()
{
    object oPC = GetPCSpeaker();
    int iStr = GetAbilityModifier(ABILITY_STRENGTH, oPC);

    int iDice = d20();

    if(iDice == 1 || iDice + iStr < 2){
        FloatingTextStringOnCreature( "*snazi se vypacit zamek, ale poranil se*", oPC);
        effect eDam = EffectDamage( d8()+iStr, DAMAGE_TYPE_BLUDGEONING);
        ApplyEffectToObject( DURATION_TYPE_INSTANT, eDam, oPC );
    }
    else if( iDice + iStr > 15 ){
        FloatingTextStringOnCreature( "*vypacil zamek*", oPC);
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        SetLocalInt( OBJECT_SELF, "JA_MAJAK1_OPEN", 1 );
    }
    else{
        FloatingTextStringOnCreature( "*snazi se vypacit zamek, ale nejde mu to*", oPC);
    }

}
