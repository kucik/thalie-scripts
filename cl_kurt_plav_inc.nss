/*
Pánové radìji plavovlásky - epická
Druh dovednosti: Povolání
Pøedpoklady: Kurtizána na 20. úrovni
Popis: Nìkteøí pánové mají radìji plavovlásky, jiní si potrpí více na tmavovlásky a další na zrzky. Žádná Kurtizána nechce pøijít o kšeft jen proto, že její barva vlasù není zrovna žádaná. Kurtizána dokáže hodinovou usilovnou meditací zmìnit svou barvu vlasù na 24 hodin. Spolu se zmìnou barvy získává také doèasné bonusy z této barvy plynoucí. Ze své pøírodní barvy vlasù nedostává Kurtizána žádný bonus, mùže však doèasnì "zmìnit" své vlasy na stejný odstín, èímž tyto bonusy po dobu 24 hodin má k dispozici. Jelikož jde o zvláštní schopnost, funguje i v oblastech, kde je jinak magie rušena.
Poskytuje:
PLAVOVLÁSKA - Blondýna umí odeèíst body ze své Inteligence až po hodnotu 10 a odeètené body mùže pøièíst do TO svých schopností.
BRUNETKA - Brunetka dokáže použít odbornost Obèas to pøedstírám tolikrát za den, jaký je její bonus Charismatu. Navíc umí "hrát na obì strany", což znamená, že všechny své schopnosti vázané na pohlaví obìti mùže po dobu 24 hodin využít i proti ženám.
ZRZKA - Když se rudovláska rozzuøí, vydá ze sebe všechno. Bìhem zuøivosti z Jak jsi mi to øekl?! se zrzka dokáže rozohnit tak, až doslova srší jiskrami. Kurtizána takto dává navíc zranìní ohnìm, které je rovno 1k6 za každé 2 úrovnì Kurtizány (napø. 10k6 pro postavu s 20 úrovnìmi tohoto povolání). Je imunní vùèi zranìní svým vlastním ohnìm a získává pohlcení 10/- vùèi jakémukoli jinému (magickému i bìžnému) ohni. Bonus do zuøivosti lze použít jen když Kurtizána bojuje dýkou.
Bruneta - 119
Zrzka- 35
Plavovláska - 154
*/
#include "sh_classes_inc_e"
#include "sh_classes_const"
const int PANOVE_RADEJI_PLAVOVLASKY_VYCHOZI = 0;
const int PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKY = 1;
const int PANOVE_RADEJI_PLAVOVLASKY_BRUNETY = 2;
const int PANOVE_RADEJI_PLAVOVLASKY_ZRZKY = 3;

const int PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKA_BARVA = 154;
const int PANOVE_RADEJI_PLAVOVLASKY_BRUNETA_BARVA = 119;
const int PANOVE_RADEJI_PLAVOVLASKY_ZRZKA_BARVA = 35;

void PanoveRadiPlavovlaskyBarvaVlasu(object oKurtizana)
{
    object oSoul = GetSoulStone(oKurtizana);
    int iBaseColor = GetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA");
    int iOldColor = GetColor(oKurtizana,COLOR_CHANNEL_HAIR);
    int iType = GetLocalInt(oSoul,"KURTIZANA_PANOVE_RADEJI_PLAVOVLASKY_VYBER");
    if (GetHasFeat(FEAT_KURTIZANA_PANOVE_RADEJI_PLAVOVLASKY,oKurtizana))
    {
        switch(iType)
        {
            case PANOVE_RADEJI_PLAVOVLASKY_VYCHOZI:
                SetColor(oKurtizana,COLOR_CHANNEL_HAIR,iBaseColor);
                SetLocalInt(oSoul,"KURTIZANA_BARVA_TYP",PANOVE_RADEJI_PLAVOVLASKY_VYCHOZI);
            break;
            case PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKY:
                if (iOldColor != PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKA_BARVA && iOldColor != PANOVE_RADEJI_PLAVOVLASKY_BRUNETA_BARVA && iOldColor != PANOVE_RADEJI_PLAVOVLASKY_ZRZKA_BARVA)SetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA",iOldColor);
                SetColor(oKurtizana,COLOR_CHANNEL_HAIR,PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKA_BARVA);
                SetLocalInt(oSoul,"KURTIZANA_BARVA_TYP",PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKY);
            break;
            case PANOVE_RADEJI_PLAVOVLASKY_BRUNETY:
                if (iOldColor != PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKA_BARVA && iOldColor != PANOVE_RADEJI_PLAVOVLASKY_BRUNETA_BARVA && iOldColor != PANOVE_RADEJI_PLAVOVLASKY_ZRZKA_BARVA)SetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA",iOldColor);
                SetColor(oKurtizana,COLOR_CHANNEL_HAIR,PANOVE_RADEJI_PLAVOVLASKY_BRUNETA_BARVA);
                SetLocalInt(oSoul,"KURTIZANA_BARVA_TYP",PANOVE_RADEJI_PLAVOVLASKY_BRUNETY);
            break;
            case PANOVE_RADEJI_PLAVOVLASKY_ZRZKY:
                if (iOldColor != PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKA_BARVA && iOldColor != PANOVE_RADEJI_PLAVOVLASKY_BRUNETA_BARVA && iOldColor != PANOVE_RADEJI_PLAVOVLASKY_ZRZKA_BARVA)SetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA",iOldColor);
                SetColor(oKurtizana,COLOR_CHANNEL_HAIR,PANOVE_RADEJI_PLAVOVLASKY_ZRZKA_BARVA);
                SetLocalInt(oSoul,"KURTIZANA_BARVA_TYP",PANOVE_RADEJI_PLAVOVLASKY_ZRZKY);
            break;

        }
        //int iBaseBarva = GetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA");
        //SetLocalInt(oSoul,"KURTIZANA_PANOVE_RADEJI_PLAVOVLASKY_VYBER",PANOVE_RADEJI_PLAVOVLASKY_VYCHOZI);
        //SendMessageToPC(OBJECT_SELF,"Po meditaci budes mit puvodni barvu vlasu.");
        //SetColor(oTarget,COLOR_CHANNEL_HAIR,iDMSetNumber);
    }

}
