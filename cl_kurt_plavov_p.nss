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
#include "cl_kurt_plav_inc"
void main()
{
    object oSoul = GetSoulStone(OBJECT_SELF);
    //int iBaseBarva = GetLocalInt(oSoul,"KURTIZANA_ZAKLADNI_BARVA");
    SetLocalInt(oSoul,"KURTIZANA_PANOVE_RADEJI_PLAVOVLASKY_VYBER",PANOVE_RADEJI_PLAVOVLASKY_PLAVOVLASKY);
    SendMessageToPC(OBJECT_SELF,"Po meditaci budes plavovlaskou.");
    //SetColor(oTarget,COLOR_CHANNEL_HAIR,iDMSetNumber);
}
