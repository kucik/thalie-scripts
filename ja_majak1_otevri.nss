void main()
{

    object oPC = GetPCSpeaker();

    if( GetIsObjectValid(GetItemPossessedBy(oPC, "JA_MAJAK1_KLIC")) ){
        FloatingTextStringOnCreature( "*odemknul klicem*", oPC);
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        SetLocalInt( OBJECT_SELF, "JA_MAJAK1_OPEN", 1 );
    }
    else{
        SendMessageToPC( oPC, "Nemas u sebe klic." );
    }
}
