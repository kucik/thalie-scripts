//Prepinanie viditelnosti zbrani na JEDNOM hracovi. Viditelnost zbrani je v
//testovacej faze preto je pridana tato moznost. Ak vypustim finalnu verziu
//tento script ani riadok v dialogu tam uz nebude.

#include "sy_main_lib"

void main()
{
    object oPC   = GetPCSpeaker();
    if (GetIsDM(oPC))
    {
        SendMessageToPC(oPC,"<cDa >DM sa vizualne efekty davat nebudu!</c>");
        return;           //DM nemoze viditelne zbrane
    }

    object oItem = GetSoulStone(oPC);

    //zistim predosly stav a zmenim ho na opacny
    int   nState = GetLocalInt(oItem,"off");
    if (nState==0)
    {
        nState = 1;
        SendMessageToPC(oPC,"<cDa >Zakazal si zobrazenie zbrani na sebe.</c>");
        int nLoop;
        for (nLoop=0; nLoop<35; nLoop++) DeleteLocalInt(oItem, "slot"+IntToString(nLoop));
    }
    else
    {
        nState = 0;
        SendMessageToPC(oPC,"<cDa >Povolil si zobrazenie zbrani na sebe.</c>");
    }
    SetLocalInt(oItem,"off",nState);

    //prekreslim efekty
    sy_redraw_efx(oPC, oItem);
}
