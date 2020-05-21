/*
 * Versions
 *
 * Kucik 05.01.2008 uprava vypoctu ceny
 * jaara 28.1.08
 */
#include "raiseinc"

void main()
{
    object oPC = GetPCSpeaker();
    object oCleric = OBJECT_SELF;
    object oCorpse = GetLocalObject(oPC, "mrtvola");

    DeleteLocalObject(oPC, "mrtvola");
    if(!GetIsObjectValid(oCorpse)){
       ActionSpeakString("Myslim, ze jsi tu mrtvolu nekde ztratil");
       return;
    }

   string sPlayerName = GetLocalString(oCorpse, "PLAYER");
   string sPCName = GetLocalString(oCorpse, "PC");
   string sCorpseTag = GetTag(oCorpse);

   DestroyObject(oCorpse, 0.0f);

   location lCorpse = GetLocation(oPC);

   FindAndRaisePlayer(SPELL_RESURRECTION,oCleric,sPlayerName,sPCName,FALSE,lCorpse);
   ActionSpeakString("Myslim, ze se to povedlo *usmeje se*");
}
