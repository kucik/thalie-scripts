void Make_Unlootable(object oClone)
{
  // make undroppable everthing in the inventory.
  object item = GetFirstItemInInventory(oClone);
  while (GetIsObjectValid(item))
  {
    SetDroppableFlag(item, FALSE);
    item = GetNextItemInInventory(oClone);
  }
  // make undroppable everything in slots
  int slot;
  for (slot=INVENTORY_SLOT_HEAD; slot<= INVENTORY_SLOT_CARMOUR; slot++)
  {
    SetDroppableFlag(GetItemInSlot(slot,oClone), FALSE);
  }
  // take the gold
  TakeGoldFromCreature(GetGold(oClone),oClone, TRUE);
}

void EvilPCCopy (object oDominate)
{
    effect eDom = EffectCutsceneDominated();
    ApplyEffectToObject ( DURATION_TYPE_PERMANENT, eDom, oDominate);

    object oEvilCopy = CopyObject ( oDominate, GetLocation(GetWaypointByTag("JA_CHRAM3_MEGAGUARD")), OBJECT_INVALID, "JA_COPY");

    SetIsTemporaryEnemy( OBJECT_SELF, oEvilCopy );
    ChangeToStandardFaction ( oEvilCopy, STANDARD_FACTION_HOSTILE);

    DestroyObject (oDominate);

    SetAILevel(oEvilCopy, AI_LEVEL_HIGH);

    Make_Unlootable( oEvilCopy );
    CreateItemOnObject("JA_CHRAM3_KEY1", oEvilCopy);

    effect eKnock = EffectKnockdown();
    ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eKnock, oEvilCopy, 0.1f);
}

void main()
{
    object oPC = GetLastUsedBy();
    if(!GetLocalInt(OBJECT_SELF, "JA_CHRAM3_USED") && GetIsPC(oPC) && !GetIsDM(oPC)){

        object oPCCopy = CopyObject(oPC, GetLocation(GetWaypointByTag("JA_CHRAM3_MEGAGUARD")));
        AssignCommand( oPC, EvilPCCopy( oPCCopy ) );
        SetLocalInt(OBJECT_SELF, "JA_CHRAM3_USED", TRUE);
    }

    AssignCommand( oPC, JumpToObject( GetWaypointByTag("ja_chram2_chram3") ) );
}
