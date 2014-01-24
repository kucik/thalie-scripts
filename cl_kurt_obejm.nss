/*K zemi
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 5. úrovni
Popis: Pøiznejme si to, pokud si má èlovìk vybrat, zda-li ho srazí k zemi neurvalı ork nebo vnadná dìva, volba je jasná.
Poskytuje: Kdykoli se pokusí Kurtizána pouít sráení proti humanoidovi muského pohlaví, obì si háe na Vùli proti TO (10 + úroveò Kurtizány) jinak klesá k zemi.
Pouití: Kurtizána mùe pouít tuto odbornost libovolnì krát za den, ale vdy aspoò s odstupem 5 tahù. Pokud pouije schopnost opakovanì na stejnı cíl, tak je TO pøi kadém dalším takovém pokusu o 3 menší. Tato stupnice je zapomenuta spánkem èi meditací cíle.
Trvání: 1 kolo
Cíl: Humanoidní bytost muského pohlaví
*/
#include "sh_classes_inc_e"
#include "x0_i0_spells"
void main()
{

    object oTarget = GetSpellTargetObject();
    int iGold = GetGold(oTarget)/1000;
    switch (iGold)
    {
        case 0:
        SendMessageToPC(OBJECT_SELF,"Cíl u sebe nemá ádné mìšce.");
        break;

        case 1:
        SendMessageToPC(OBJECT_SELF,"Cíl u sebe má jeden mìšec.");
        break;

        case 2:
        case 3:
        case 4:
        SendMessageToPC(OBJECT_SELF,"Cíl u sebe má "+IntToString(iGold)+" mìšce.");
        break;

        default:
        SendMessageToPC(OBJECT_SELF,"Cíl u sebe má "+IntToString(iGold)+" mìšcù.");
        break;

    }

}

