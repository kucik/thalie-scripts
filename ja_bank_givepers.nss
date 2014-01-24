void main()
{
    object oPC = GetPCSpeaker();

    if(GetGold(oPC) >= 50000){
        TakeGoldFromCreature( 50000, oPC, TRUE );
        CreateItemOnObject( "ja_pers_bank", oPC );

        SpeakString( "Tady mate klic od Vaseho trezoru. Hezky den.", TALKVOLUME_TALK );
    }
    else{
        SpeakString( "Bohuzel nemate dost zlata.", TALKVOLUME_TALK );
    }
}
