void main()
{
object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 60) {
        TakeGoldFromCreature(60, oPC);
        ClearAllActions();
        ActionPauseConversation();
        ActionCastSpellAtObject( SPELL_CURE_MODERATE_WOUNDS, oPC, METAMAGIC_ANY, TRUE );
        DelayCommand(6.0f, ActionResumeConversation());
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}
