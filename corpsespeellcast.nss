//#include "aps_include"
#include "raiseinc"




void main()
{

    int i = GetLastSpell();
    object oCaster = GetLastSpellCaster();
    string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
    string sPCName = GetLocalString(OBJECT_SELF, "PC");
    location lRaise = GetLocation(OBJECT_SELF);
    if( i == SPELL_RESURRECTION || i == SPELL_RAISE_DEAD  || i == 972  )
    {
        FindAndRaisePlayer(i,oCaster,sPlayerName,sPCName,TRUE,lRaise);
    }
}
