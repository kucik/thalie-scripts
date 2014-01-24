void main()
{
object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 100) {
        TakeGoldFromCreature(100, oPC);
        ClearAllActions();
        ActionCastSpellAtObject( SPELL_REMOVE_DISEASE, oPC, METAMAGIC_ANY, TRUE );
        ActionSpeakString("Doufam, ze to pomohlo.");

    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}

