void main()
{
object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 500) {
        TakeGoldFromCreature(500, oPC);
        ClearAllActions();
        ActionCastSpellAtObject( SPELL_GREATER_RESTORATION, oPC, METAMAGIC_ANY, TRUE );
        ActionSpeakString("Doufam, ze to pomohlo.");

    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}

