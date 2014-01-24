#include "sh_classes_inc_e"

int GetIsDeityAndDomainsValid(int iDeityFeat, int iDomain1,int iDomain2);
//DEITY
/*
const int DEITY_ATHEIST = 0;
const int DEITY_DEI_ANANG = 1;
const int DEITY_JUANA = 2;
const int DEITY_NORD = 3;
const int DEITY_LOTHIAN = 4;
const int DEITY_AZHAR = 5;
const int DEITY_THAL = 6;
const int DEITY_MORUS = 7;
const int DEITY_LILITH = 8;
const int DEITY_GORDUL = 9;
const int DEITY_HELGARON = 10;
const int DEITY_ZEIR = 11;
const int DEITY_XIAN = 12;
*/
//domains
const int DOMENA_VZDUCH = 0;
const int DOMENA_ZVIRATA = 1;
const int DOMENA_SMRT = 3;
const int DOMENA_NICENI = 4;
const int DOMENA_ZEME = 5;
const int DOMENA_SFERY= 6;
const int DOMENA_OHEN = 7;
const int DOMENA_LECENI = 9;
const int DOMENA_MAGIE = 13;
const int DOMENA_ROSTLINY = 14;
const int DOMENA_OCHRANA = 15;
const int DOMENA_SILA = 16;
const int DOMENA_SLUNCE = 17;
const int DOMENA_PUTOVANI = 18;
const int DOMENA_KLAM = 19;
const int DOMENA_VALKA = 20;
const int DOMENA_VODA = 21;
const int DOMENA_STESTI = 22;
const int DOMENA_KOV = 23;
const int DOMENA_PAVOUCI = 24;
const int DOMENA_ILUZE = 25;
const int DOMENA_ZIVOT = 26;
const int DOMENA_VEDENI = 27;
const int DOMENA_RAD = 28;
const int DOMENA_HNEV = 29;
const int DOMENA_PODZEMI = 30;
const int DOMENA_CHAOS = 31;
const int DOMENA_OBCHOD = 32;

void RemoveAllDeitys(object oPC)
{
    RemoveKnownFeat (oPC,FEAT_DEITY_ATHEIST );
    RemoveKnownFeat (oPC,FEAT_DEITY_AZHAR );
    RemoveKnownFeat (oPC,FEAT_DEITY_DEI_ANANG );
    RemoveKnownFeat (oPC,FEAT_DEITY_GORDUL );
    RemoveKnownFeat (oPC,FEAT_DEITY_HELGARON );
    RemoveKnownFeat (oPC,FEAT_DEITY_JUANA );
    RemoveKnownFeat (oPC,FEAT_DEITY_LILITH );
    RemoveKnownFeat (oPC,FEAT_DEITY_LOTHIAN );
    RemoveKnownFeat (oPC,FEAT_DEITY_MORUS );
    RemoveKnownFeat (oPC,FEAT_DEITY_NORD );
    RemoveKnownFeat (oPC,FEAT_DEITY_THAL );
    RemoveKnownFeat (oPC,FEAT_DEITY_XIAN );
    RemoveKnownFeat (oPC,FEAT_DEITY_ZEIR );

}


string GetDeityName(object oPC)
{
    if (GetHasFeat(FEAT_DEITY_ATHEIST,oPC))
    {
        return "Ateista";
    }
    else if (GetHasFeat(FEAT_DEITY_AZHAR,oPC))
    {
        return "Azhar";
    }
    else if (GetHasFeat(FEAT_DEITY_DEI_ANANG,oPC))
    {
        return "Dei-Anang";
    }
    else if (GetHasFeat(FEAT_DEITY_GORDUL,oPC))
    {
        return "Gordul";
    }
    else if (GetHasFeat(FEAT_DEITY_HELGARON,oPC))
    {
        return "Helgaron";
    }
    else if (GetHasFeat(FEAT_DEITY_JUANA,oPC))
    {
        return "Juana";
    }
    else if (GetHasFeat(FEAT_DEITY_LILITH,oPC))
    {
        return "Lilith";
    }
    else if (GetHasFeat(FEAT_DEITY_LOTHIAN,oPC))
    {
        return "Lothian";
    }
    else if (GetHasFeat(FEAT_DEITY_MORUS,oPC))
    {
        return "Morus";
    }
    else if (GetHasFeat(FEAT_DEITY_NORD,oPC))
    {
        return "Nord";
    }
    else if (GetHasFeat(FEAT_DEITY_THAL,oPC))
    {
        return "Thal";
    }
    else if (GetHasFeat(FEAT_DEITY_XIAN,oPC))
    {
        return "Xian";
    }
    else if (GetHasFeat(FEAT_DEITY_ZEIR,oPC))
    {
        return "Zeir";
    }
    return "Postava ma chybne nastaveno bozstvo.";
}

/*Vraci 1 pokud uspesne nastavil bozstvo, 0 pokud nerozpoznal text, -1 pokud jsou spatne domeny
*/
int SetThalieDeity(object oPC, string sDeity)
{
    string sLowDeity = GetStringLowerCase(sDeity);
    int iDeity = 0;
    int iDomain1,iDomain2;
    if (sLowDeity == "ateista" || sLowDeity == "bezverec")
    {
        iDeity = FEAT_DEITY_ATHEIST;


    }
    else if (sLowDeity == "azhar")
    {
        iDeity = FEAT_DEITY_AZHAR;

    }
    else if (sLowDeity == "dei-anang" || sLowDeity == "deianang")
    {
        iDeity = FEAT_DEITY_DEI_ANANG;

    }
    else if (sLowDeity == "gordul")
    {
        iDeity = FEAT_DEITY_GORDUL;

    }
    else if (sLowDeity == "helgaron")
    {
        iDeity = FEAT_DEITY_HELGARON;

    }
    else if (sLowDeity == "juana")
    {
        iDeity = FEAT_DEITY_JUANA;

    }
    else if (sLowDeity == "lilith")
    {
        iDeity = FEAT_DEITY_LILITH;
    }
    else if (sLowDeity == "lothian")
    {
        iDeity = FEAT_DEITY_LOTHIAN;

    }
    else if (sLowDeity == "morus")
    {
        iDeity = FEAT_DEITY_MORUS;
    }
    else if (sLowDeity == "nord")
    {
        iDeity = FEAT_DEITY_NORD;
    }
    else if (sLowDeity == "thal")
    {
        iDeity = FEAT_DEITY_THAL;
    }
    else if (sLowDeity == "xian" || sLowDeity == "xi'an")
    {
        iDeity = FEAT_DEITY_XIAN;
    }
    else if (sLowDeity == "zeir")
    {
        iDeity = FEAT_DEITY_ZEIR;
    }
    else return 0;
    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)  //zkontroluj domeny
    {
        iDomain1 = GetClericDomain(oPC,1);
        iDomain2 = GetClericDomain(oPC,2);
        if (!GetIsDeityAndDomainsValid(iDeity, iDomain1,iDomain2)) return -1;
    }
    RemoveAllDeitys(oPC);
    AddKnownFeat(oPC,iDeity);
    return 1;
}


int GetIsDeityAndDomainsValid(int iDeityFeat, int iDomain1,int iDomain2)
{
    switch (iDeityFeat)
    {
        case FEAT_DEITY_ATHEIST:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_AZHAR:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            //if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            //if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            //if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            //if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            //if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            //if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            //if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_DEI_ANANG:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            //if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            //if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            //if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            //if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            //if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            //if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            //if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_GORDUL:
            //if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            //if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            //if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            //if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            //if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            //if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            //if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_HELGARON:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            //if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            //if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            //if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            //if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            //if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            //if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            //if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            //if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_JUANA:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            //if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            //if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            //if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            //if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            //if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            //if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            //if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_LILITH:
            //if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            //if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            //if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            //if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            //if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            //if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            //if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_LOTHIAN:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            //if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            //if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            //if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            //if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            //if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            //if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            //if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_MORUS:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            //if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            //if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            //if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            //if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            //if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            //if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            //if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_NORD:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            //if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            //if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            //if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            //if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            //if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            //if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            //if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            //if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_THAL:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            //if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            //if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            //if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            //if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            //if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            //if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            //if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            //if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_XIAN:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            //if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            //if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            //if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            //if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            //if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            //if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            //if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            //if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;
        case FEAT_DEITY_ZEIR:
            if (iDomain1 == DOMENA_HNEV || iDomain2 == DOMENA_HNEV) return 0;
            if (iDomain1 == DOMENA_CHAOS || iDomain2 == DOMENA_CHAOS) return 0;
            if (iDomain1 == DOMENA_ILUZE || iDomain2 == DOMENA_ILUZE) return 0;
            if (iDomain1 == DOMENA_KLAM || iDomain2 == DOMENA_KLAM) return 0;
            if (iDomain1 == DOMENA_KOV || iDomain2 == DOMENA_KOV) return 0;
            if (iDomain1 == DOMENA_LECENI || iDomain2 == DOMENA_LECENI) return 0;
            //if (iDomain1 == DOMENA_MAGIE || iDomain2 == DOMENA_MAGIE) return 0;
            if (iDomain1 == DOMENA_NICENI || iDomain2 == DOMENA_NICENI) return 0;
            if (iDomain1 == DOMENA_OBCHOD || iDomain2 == DOMENA_OBCHOD) return 0;
            if (iDomain1 == DOMENA_OHEN || iDomain2 == DOMENA_OHEN) return 0;
            //if (iDomain1 == DOMENA_OCHRANA || iDomain2 == DOMENA_OCHRANA) return 0;
            if (iDomain1 == DOMENA_PAVOUCI || iDomain2 == DOMENA_PAVOUCI) return 0;
            //if (iDomain1 == DOMENA_PODZEMI || iDomain2 == DOMENA_PODZEMI) return 0;
            if (iDomain1 == DOMENA_PUTOVANI || iDomain2 == DOMENA_PUTOVANI) return 0;
            //if (iDomain1 == DOMENA_RAD || iDomain2 == DOMENA_RAD) return 0;
            if (iDomain1 == DOMENA_ROSTLINY || iDomain2 == DOMENA_ROSTLINY) return 0;
            if (iDomain1 == DOMENA_SFERY || iDomain2 == DOMENA_SFERY) return 0;
            if (iDomain1 == DOMENA_SILA || iDomain2 == DOMENA_SILA) return 0;
            if (iDomain1 == DOMENA_SLUNCE || iDomain2 == DOMENA_SLUNCE) return 0;
            //if (iDomain1 == DOMENA_SMRT || iDomain2 == DOMENA_SMRT) return 0;
            if (iDomain1 == DOMENA_STESTI || iDomain2 == DOMENA_STESTI) return 0;
            if (iDomain1 == DOMENA_VALKA || iDomain2 == DOMENA_VALKA) return 0;
            //if (iDomain1 == DOMENA_VEDENI || iDomain2 == DOMENA_VEDENI) return 0;
            if (iDomain1 == DOMENA_VODA || iDomain2 == DOMENA_VODA) return 0;
            if (iDomain1 == DOMENA_VZDUCH || iDomain2 == DOMENA_VZDUCH) return 0;
            if (iDomain1 == DOMENA_ZEME || iDomain2 == DOMENA_ZEME) return 0;
            //if (iDomain1 == DOMENA_ZIVOT || iDomain2 == DOMENA_ZIVOT) return 0;
            if (iDomain1 == DOMENA_ZVIRATA || iDomain2 == DOMENA_ZVIRATA) return 0;
        break;


    }
    return 1;
}

int GetThalieDeity(object oPC)
{
    if (GetHasFeat(FEAT_DEITY_ATHEIST,oPC))
    {
        return FEAT_DEITY_ATHEIST;
    }
    else if (GetHasFeat(FEAT_DEITY_AZHAR,oPC))
    {
        return FEAT_DEITY_AZHAR;
    }
    else if (GetHasFeat(FEAT_DEITY_DEI_ANANG,oPC))
    {
        return FEAT_DEITY_DEI_ANANG;
    }
    else if (GetHasFeat(FEAT_DEITY_GORDUL,oPC))
    {
        return FEAT_DEITY_GORDUL;
    }
    else if (GetHasFeat(FEAT_DEITY_HELGARON,oPC))
    {
        return FEAT_DEITY_HELGARON;
    }
    else if (GetHasFeat(FEAT_DEITY_JUANA,oPC))
    {
        return FEAT_DEITY_JUANA;
    }
    else if (GetHasFeat(FEAT_DEITY_LILITH,oPC))
    {
        return FEAT_DEITY_LILITH;
    }
    else if (GetHasFeat(FEAT_DEITY_LOTHIAN,oPC))
    {
        return FEAT_DEITY_LOTHIAN;
    }
    else if (GetHasFeat(FEAT_DEITY_MORUS,oPC))
    {
        return FEAT_DEITY_MORUS;
    }
    else if (GetHasFeat(FEAT_DEITY_NORD,oPC))
    {
        return FEAT_DEITY_NORD;
    }
    else if (GetHasFeat(FEAT_DEITY_THAL,oPC))
    {
        return FEAT_DEITY_THAL;
    }
    else if (GetHasFeat(FEAT_DEITY_XIAN,oPC))
    {
        return FEAT_DEITY_XIAN;
    }
    else if (GetHasFeat(FEAT_DEITY_ZEIR,oPC))
    {
        return FEAT_DEITY_ZEIR;
    }
    return -1;
}
