/*
    -do TOKENU 7000 dava hlasku podla aktualnej moznosti trenera voci hracovi
     a do TOKENU 7001 sa uklada nazov povolania ktore trener uci
    -ak hrac nema potrebne peniaze ci nesplna podmienku <min;max> lvl tak sa
     vypise sprava o zlyhani

 * rev. Kucik 05.01.2008 rozruzneni cen pro jednotliva povolani, uprava ceny.
 *
 */
#include "sh_classes_const"
string sy_get_remeslo()
{
    int nClass = GetClassByPosition(1,OBJECT_SELF);
    switch (nClass)
    {
        case CLASS_TYPE_ARCANE_ARCHER   : return "mysticke lucistniky";
        case CLASS_TYPE_ASSASSIN        : return "vrahy";
        case CLASS_TYPE_BARBARIAN       : return "barbary";
        case CLASS_TYPE_BARD            : return "bardy";
        case CLASS_TYPE_BLACKGUARD      : return "heretiky";
        case CLASS_TYPE_CLERIC          : return "kneze";
        case CLASS_TYPE_DIVINE_CHAMPION : return "sampiony";
        case CLASS_TYPE_DRAGON_DISCIPLE : return "ucedniky cerveneho draka";
        case CLASS_TYPE_DRUID           : return "druidy";
        case CLASS_TYPE_DWARVEN_DEFENDER : return "trpaslici obrance";
        case CLASS_TYPE_FIGHTER         : return "bojovniky";
        case CLASS_TYPE_HARPER          : return "zvedy harfeniku";
        case CLASS_TYPE_MONK            : return "mnichy";
        case CLASS_TYPE_PALADIN         : return "paladiny";
        case CLASS_TYPE_PALE_MASTER     : return "pany smrti";
        case CLASS_TYPE_RANGER          : return "hranicare";
        case CLASS_TYPE_ROGUE           : return "tulaky";
        case CLASS_TYPE_SHADOWDANCER    : return "stinovye tanecniky";
        case CLASS_TYPE_SHIFTER         : return "menavce";
        case CLASS_TYPE_SORCERER        : return "zaklinace";
        case CLASS_TYPE_WEAPON_MASTER   : return "pany zbrane";
        case CLASS_TYPE_WIZARD          : return "carodeje";
        case CLASS_TYPE_SHINOBI          : return "shinobi";
        case CLASS_TYPE_CERNOKNEZNIK          : return "cernoknezniky";
        case CLASS_TYPE_SERMIR          : return "sermire";
        case CLASS_TYPE_SAMURAJ          : return "samuraje";
        case CLASS_TYPE_EXORCISTA          : return "exorcisty";
        case CLASS_TYPE_PURPLE_DRAGON_KNIGHT          : return "vojevudce";
        case CLASS_TYPE_KURTIZANA       : return "kurtizany";
    }
    return "BUG:spatny parametre na NPC trenerovi v povolani c.1";
}

int KU_GetPriceForClass()
{
    int nClass = GetClassByPosition(1,OBJECT_SELF);
    switch (nClass)
    {
        case CLASS_TYPE_ARCANE_ARCHER   : return 15;
        case CLASS_TYPE_ASSASSIN        : return 15;
        case CLASS_TYPE_BARBARIAN       : return 13;
        case CLASS_TYPE_BARD            : return 20;
        case CLASS_TYPE_BLACKGUARD      : return 15;
        case CLASS_TYPE_CLERIC          : return 20;
        case CLASS_TYPE_DIVINE_CHAMPION : return 18;
        case CLASS_TYPE_DRAGON_DISCIPLE : return 0;
        case CLASS_TYPE_DRUID           : return 20;
        case CLASS_TYPE_DWARVEN_DEFENDER : return 20;
        case CLASS_TYPE_FIGHTER         : return 20;
        case CLASS_TYPE_HARPER          : return 25;
        case CLASS_TYPE_MONK            : return 25;
        case CLASS_TYPE_PALADIN         : return 15;
        case CLASS_TYPE_PALE_MASTER     : return 20;
        case CLASS_TYPE_RANGER          : return 15;
        case CLASS_TYPE_ROGUE        : return 10;
        case CLASS_TYPE_SHADOWDANCER    : return 25;
        case CLASS_TYPE_SHIFTER         : return 25;
        case CLASS_TYPE_SORCERER        : return 15;
        case CLASS_TYPE_WEAPON_MASTER   : return 25;
        case CLASS_TYPE_WIZARD          : return 15;
        case CLASS_TYPE_SHINOBI          : return 15;
        case CLASS_TYPE_CERNOKNEZNIK          : return 25;
        case CLASS_TYPE_SERMIR          : return 20;
        case CLASS_TYPE_SAMURAJ          : return 20;
        case CLASS_TYPE_EXORCISTA          : return 15;
        case CLASS_TYPE_PURPLE_DRAGON_KNIGHT          : return 15;
        case CLASS_TYPE_KURTIZANA       : return 20;
    }
    return 20;
}

int StartingConditional()
{
    object oPC   = GetPCSpeaker();

    //zistim min. a max. rozsah ktory dokaze NPC naucit v svojom remesle
    int nMinLvl  = GetLevelByPosition(1, OBJECT_SELF);
    int nMaxLvl  = GetLevelByPosition(2, OBJECT_SELF);

    //ziskam celkovy level postavy na vypocet ceny
    int nLevel   = GetHitDice(GetPCSpeaker()) + 1;

    //ziskam nazov remesla co uci trener
    SetCustomToken(7001,sy_get_remeslo());

    //u prestiznych povolani je pozadovana urcita hranica levelu
    //inac sa nedaju vziat
    int nPrcLevel = GetLevelByPosition(3,OBJECT_SELF);
    if (nPrcLevel > nLevel)
    {
        SetCustomToken(7000,"Abych te mohl/a neco naucit, tak musis mit nejake zaklady. Pozaduji, abys byl/a minimalne na "+IntToString(nPrcLevel)+" stupni, abychom mohli zacit s vyukou. Vrat se, az budes splnovat moje pozadavky. Potom se podivam, co se s tebou da delat.");
        return 1;
    }

    //vyratam celkovu cenu za vsetky lvl postavy
    //(vzorec sa pouzije na vypocet ceny prestupu na dalsi lvl)
    int nLvlCost;
    float fLevel = IntToFloat(nLevel);
    if(nLevel <= 3){
        nLvlCost = nLevel*15;
    }
    else{
        nLvlCost = FloatToInt(1.123*fLevel*fLevel*fLevel*fLevel - 23.421*fLevel*fLevel*fLevel + 227.34*fLevel*fLevel - 669.7*fLevel + 500.85);
    }
    float fPrice = 0.1 * IntToFloat(GetAbilityScore(OBJECT_SELF,ABILITY_CHARISMA,TRUE));
    nLvlCost = FloatToInt(fPrice * nLvlCost);
    nLvlCost = nLvlCost * KU_GetPriceForClass() / 100;


    //takto vyzera zakladny dialog ak hrac splna vsetky predpoklady
    string sToken = "A vidim, ze ty splnujes me pozadavky! Doufam, ze z tebe bude dobry zak. Muzeme zacit, az budes pripraven Moje standartni cena je "+IntToString(nLvlCost);

    //test ci hrac uz ma lvl (vidno ikonu levelup)
    int nLevel2 = GetXP(oPC) - (((nLevel * (nLevel - 1)) / 2) * 5000);
    if (nLevel2<0)
    {
        sToken = "Jak tak na tebe koukam, jeste nejsi dost zkuseny/a, abych te mohl/a neco noveho naucit. Vrat se pozdeji a snad pro tebe budu moci neco udelat...";
        nLvlCost = 0;
    }

    //zistim aky lvl budem mat po lvlupe v danom remesle, podla hlavneho remesla
    //trenera, vzdy je aspon hodnota 1
    nLevel = GetLevelByClass(GetClassByPosition(1,OBJECT_SELF),oPC) + 1;

    //hrac uz vie trenerove remeslo ale trener ma vyzsi lvl ako hrac v remesle
    if (nLevel<nMinLvl)
    {
        sToken   = "Jeste nejsi dostatecne zdatny/a na to, abys pochopil/a moji vyuku a ja te mohl/a naucit neco noveho. Prijd az naberes vic zkusenosti. (Vyzaduji uroven "+IntToString(nMinLvl)+")";
        nLvlCost = 0;
    }

    //ak trener uz nedokaze hraca naucit nic, cize hrac ma vyssi lvl ako trener
    if (nLevel>nMaxLvl)
    {
        sToken   = "Bohuzel jsem te jiz naucil/a vse, co sam umim. Jsem na tebe pysny/a muj sverence. Budes si muset najit lepsiho ucitele, nez jsem ja. Hodne stesti a nekdy se za mnou stav, rad se dozvim, jak pokracujes na tve ceste...";
        nLvlCost = 0;
    }

    //zapisem cenu v GP za dany lvl, ak majster nevie trenovat ucna v rozsahu lvl
    //alebo ucen nema peniaze oznacim si premennu na hracovi ako 0, inac tam bude
    //cena priamo v GP ktoru potom script zoberie po uspesnom lvlupe
    SetLocalInt(oPC,"sy_gp_cost",nLvlCost);
    SetCustomToken(7000, sToken);

    return 1;
}
