void main()
{
object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 300) {
        TakeGoldFromCreature(300, oPC);
        ClearAllActions();
        ActionCastSpellAtObject( SPELL_RESTORATION, oPC, METAMAGIC_ANY, TRUE );
        ActionSpeakString("Doufam, ze to pomohlo.");

    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}

