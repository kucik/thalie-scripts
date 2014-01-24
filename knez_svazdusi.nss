#include "aps_include"
#include "persistence"

void main()
{
object oPC = GetPCSpeaker();

    if (GetGold(oPC) >= 1000) {
        string sChram = GetLocalString(OBJECT_SELF, "CHRAM");

        TakeGoldFromCreature(1000, oPC);
        SetPersistentString( oPC, "CHRAM", sChram);
        SetLocalString(oPC, "CHRAM", sChram);
        ClearAllActions();
        ActionCastFakeSpellAtObject(SPELL_WORD_OF_FAITH, oPC);
        ActionSpeakString("Tva duse je nyni svazana s timto chramem");
    }
    else{
        ActionSpeakString("Vzdyt ty nemas tolik penez!");
    }
}

