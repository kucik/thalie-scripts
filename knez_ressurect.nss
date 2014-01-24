/*
 * Versions
 *
 * Kucik 05.01.2008 uprava vypoctu ceny
 * jaara 28.1.08
 */


void main()
{
    object oPC = GetPCSpeaker();
    object oCleric = OBJECT_SELF;
    object oCorpse = GetLocalObject(oPC, "mrtvola");

    int iPrice = GetLocalInt(oPC, "JA_RESSURECT_PRICE");

    if (GetGold(oPC) >= iPrice) {
//        object oCorpse = GetLocalObject(oPC, "mrtvola");
        DeleteLocalObject(oPC, "mrtvola");
        if(!GetIsObjectValid(oCorpse)){
            ActionSpeakString("Myslim, ze jsi tu mrtvolu nekde ztratil");
            return;
        }

        TakeGoldFromCreature(iPrice, oPC);

        string sPlayerName = GetLocalString(oCorpse, "PLAYER");
        string sPCName = GetLocalString(oCorpse, "PC");
        string sCorpseTag = GetTag(oCorpse);

        DestroyObject(oCorpse, 0.0f);

        location lCorpse = GetLocation(oPC);

        oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, "player_corpse", lCorpse, FALSE, sCorpseTag);
        SetName(oCorpse, sPCName);
        SetLocalString(oCorpse, "PLAYER", sPlayerName);
        SetLocalString(oCorpse, "PC", sPCName);
        SetLocalInt(oCorpse, "KU_CLERIC", TRUE);

        ClearAllActions();
        ActionMoveToObject(oCorpse, FALSE, 2.0f);
        ActionSpeakString("*modli se*");
        ActionCastSpellAtObject( SPELL_RESURRECTION, oCorpse, METAMAGIC_ANY, TRUE );
        ActionSpeakString("Myslim, ze se to povedlo *usmeje se*");
    }
    else{
        ActionSpeakString("Nemas tolik penez. Tohohle za mene jak " + IntToString(iPrice) + " neozivim!");
    }
}
