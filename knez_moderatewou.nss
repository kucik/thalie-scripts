void main()
{
    object oPC = GetPCSpeaker();
    int iPrice = GetLocalString(OBJECT_SELF, "CHRAM") == "CHRAM_JUANA_KARATHA" ? 0 : 60;

    if (GetGold(oPC) >= iPrice) {
        if (iPrice) TakeGoldFromCreature(iPrice, oPC);
        ClearAllActions();
        ActionPauseConversation();
        ActionCastSpellAtObject( SPELL_CURE_MODERATE_WOUNDS, oPC, METAMAGIC_ANY, TRUE );
        DelayCommand(6.0f, ActionResumeConversation());
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}
