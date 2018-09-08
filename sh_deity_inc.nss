#include "sh_classes_inc_e"

int GetIsDeityAndDomainsValid(int iDeityFeat, int iDomain1,int iDomain2);
void SetDomainsByDeity(object oPC, int iDeity);
//DEITY
const int DEITY_BEZVEREC = 0;
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
//domains
const int DOMENA_BEZVEREC1 = 22;
const int DOMENA_BEZVEREC2 = 23;
const int DOMENA_JUANA1 = 24;
const int DOMENA_JUANA2 = 25;
const int DOMENA_DEI_ANANG1 = 26;
const int DOMENA_DEI_ANANG2 = 27;
const int DOMENA_NORD1 = 28;
const int DOMENA_NORD2 = 29;
const int DOMENA_LOTHIAN1 = 30;
const int DOMENA_LOTHIAN2 = 31;
const int DOMENA_AZHAR1 = 32;
const int DOMENA_AZHAR2 = 33;
const int DOMENA_MORUS1 = 34;
const int DOMENA_MORUS2 = 35;
const int DOMENA_LILITH1 = 36;
const int DOMENA_LILITH2 = 37;
const int DOMENA_THAL1 = 38;
const int DOMENA_THAL2 = 39;
const int DOMENA_XIAN1 = 40;
const int DOMENA_XIAN2 = 41;
const int DOMENA_GORDUL1 = 42;
const int DOMENA_GORDUL2 = 43;
const int DOMENA_HELGARON1 = 44;
const int DOMENA_HELGARON2 = 45;
const int DOMENA_ZEIR1 = 46;
const int DOMENA_ZEIR2 = 47;



string GetDeityName(object oPC)
{
    object oDuse =GetSoulStone(oPC);
    int iDeity= GetLocalInt(oDuse,"DEITY");
    if (iDeity==DEITY_BEZVEREC)
    {
        return "Ateista";
    }
    else if (iDeity==DEITY_AZHAR)
    {
        return "Azhar";
    }
    else if (iDeity==DEITY_DEI_ANANG)
    {
        return "Dei-Anang";
    }
    else if (iDeity==DEITY_GORDUL)
    {
        return "Gordul";
    }
    else if (iDeity==DEITY_HELGARON)
    {
        return "Helgaron";
    }
    else if (iDeity==DEITY_JUANA)
    {
        return "Juana";
    }
    else if (iDeity==DEITY_LILITH)
    {
        return "Lilith";
    }
    else if (iDeity==DEITY_LOTHIAN)
    {
        return "Lothian";
    }
    else if (iDeity==DEITY_MORUS)
    {
        return "Morus";
    }
    else if (iDeity==DEITY_NORD)
    {
        return "Nord";
    }
    else if (iDeity==DEITY_THAL)
    {
        return "Thal";
    }
    else if (iDeity==DEITY_XIAN)
    {
        return "Xian";
    }
    else if (iDeity==DEITY_ZEIR)
    {
        return "Zeir";
    }
    return "Postava ma chybne nastaveno bozstvo.";
}

/*Vraci 1 pokud uspesne nastavil bozstvo, 0 pokud nerozpoznal text, -1 pokud jsou spatne domeny
*/
int DM_SetThalieDeity(object oPC, string sDeity)
{
    string sLowDeity = GetStringLowerCase(sDeity);
    int iDeity = 0;
    int iDomain1,iDomain2;
    if (sLowDeity == "ateista" || sLowDeity == "bezverec")
    {
        iDeity = DEITY_BEZVEREC;
    }
    else if (sLowDeity == "azhar")
    {
        iDeity = DEITY_AZHAR;

    }
    else if (sLowDeity == "dei-anang" || sLowDeity == "deianang")
    {
        iDeity = DEITY_DEI_ANANG;

    }
    else if (sLowDeity == "gordul")
    {
        iDeity = DEITY_GORDUL;

    }
    else if (sLowDeity == "helgaron")
    {
        iDeity = DEITY_HELGARON;

    }
    else if (sLowDeity == "juana")
    {
        iDeity = DEITY_JUANA;

    }
    else if (sLowDeity == "lilith")
    {
        iDeity = DEITY_LILITH;
    }
    else if (sLowDeity == "lothian")
    {
        iDeity = DEITY_LOTHIAN;

    }
    else if (sLowDeity == "morus")
    {
        iDeity = DEITY_MORUS;
    }
    else if (sLowDeity == "nord")
    {
        iDeity = DEITY_NORD;
    }
    else if (sLowDeity == "thal")
    {
        iDeity = DEITY_THAL;
    }
    else if (sLowDeity == "xian" || sLowDeity == "xi'an")
    {
        iDeity = DEITY_XIAN;
    }
    else if (sLowDeity == "zeir")
    {
        iDeity = DEITY_ZEIR;
    }
    else return 0;
    object oDuse =GetSoulStone(oPC);
    SetLocalInt(oDuse,"DEITY",iDeity);
    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)  //zkontroluj domeny
    {
        iDomain1 = GetClericDomain(oPC,1);
        iDomain2 = GetClericDomain(oPC,2);
        if (!GetIsDeityAndDomainsValid(iDeity, iDomain1,iDomain2))
        {
            SetDomainsByDeity(oPC,iDeity);
        }
    }
    return 1;
}

int GetIsDeityAndDomainsValid(int iDeity, int iDomain1, int iDomain2)
{
    switch (iDeity)
    {
        case DEITY_BEZVEREC:
                    if (iDomain1 == DOMENA_BEZVEREC1 || iDomain2 == DOMENA_BEZVEREC2) return 1;
                    break;
        case DEITY_JUANA:
                    if (iDomain1 == DOMENA_JUANA1 || iDomain2 == DOMENA_JUANA2) return 1;
                    break;
        case DEITY_DEI_ANANG:
                    if (iDomain1 == DOMENA_DEI_ANANG1 || iDomain2 == DOMENA_DEI_ANANG2) return 1;
                    break;
        case DEITY_NORD:
                    if (iDomain1 == DOMENA_NORD1 || iDomain2 == DOMENA_NORD2) return 1;
                    break;
        case DEITY_LOTHIAN:
                    if (iDomain1 == DOMENA_LOTHIAN1 || iDomain2 == DOMENA_LOTHIAN2) return 1;
                    break;
        case DEITY_AZHAR:
                    if (iDomain1 == DOMENA_AZHAR1 || iDomain2 == DOMENA_AZHAR2) return 1;
                    break;
        case DEITY_MORUS:
                    if (iDomain1 == DOMENA_MORUS1 || iDomain2 == DOMENA_MORUS2) return 1;
                    break;
        case DEITY_LILITH:
                    if (iDomain1 == DOMENA_LILITH1 || iDomain2 == DOMENA_LILITH2) return 1;
                    break;
        case DEITY_THAL:
                    if (iDomain1 == DOMENA_THAL1 || iDomain2 == DOMENA_THAL2) return 1;
                    break;
        case DEITY_XIAN:
                    if (iDomain1 == DOMENA_XIAN1 || iDomain2 == DOMENA_XIAN2) return 1;
                    break;
        case DEITY_GORDUL:
                    if (iDomain1 == DOMENA_GORDUL1 || iDomain2 == DOMENA_GORDUL2) return 1;
                    break;
        case DEITY_HELGARON:
                    if (iDomain1 == DOMENA_HELGARON1 || iDomain2 == DOMENA_HELGARON2) return 1;
                    break;
        case DEITY_ZEIR:
                    if (iDomain1 == DOMENA_ZEIR1 || iDomain2 == DOMENA_ZEIR2) return 1;
                    break;

    }
    return 0;
}


void SetDomainsByDeity(object oPC, int iDeity)
{
    switch (iDeity)
    {
        case DEITY_BEZVEREC:
            SetClericDomain(oPC,1,DOMENA_BEZVEREC1);
            SetClericDomain(oPC,2,DOMENA_BEZVEREC2);
            break;
        case DEITY_JUANA:
            SetClericDomain(oPC,1,DOMENA_JUANA1);
            SetClericDomain(oPC,2,DOMENA_JUANA2);
            break;
        case DEITY_DEI_ANANG:
            SetClericDomain(oPC,1,DOMENA_DEI_ANANG1);
            SetClericDomain(oPC,2,DOMENA_DEI_ANANG2);
            break;
        case DEITY_NORD:
            SetClericDomain(oPC,1,DOMENA_NORD1);
            SetClericDomain(oPC,2,DOMENA_NORD2);
            break;
        case DEITY_LOTHIAN:
            SetClericDomain(oPC,1,DOMENA_LOTHIAN1);
            SetClericDomain(oPC,2,DOMENA_LOTHIAN2);
            break;
        case DEITY_AZHAR:
            SetClericDomain(oPC,1,DOMENA_AZHAR1);
            SetClericDomain(oPC,2,DOMENA_AZHAR2);
            break;
        case DEITY_MORUS:
            SetClericDomain(oPC,1,DOMENA_MORUS1);
            SetClericDomain(oPC,2,DOMENA_MORUS2);
            break;
        case DEITY_LILITH:
            SetClericDomain(oPC,1,DOMENA_LILITH1);
            SetClericDomain(oPC,2,DOMENA_LILITH2);
            break;
        case DEITY_THAL:
            SetClericDomain(oPC,1,DOMENA_THAL1);
            SetClericDomain(oPC,2,DOMENA_THAL2);
            break;
        case DEITY_XIAN:
            SetClericDomain(oPC,1,DOMENA_XIAN1);
            SetClericDomain(oPC,2,DOMENA_XIAN2);
            break;
        case DEITY_GORDUL:
            SetClericDomain(oPC,1,DOMENA_GORDUL1);
            SetClericDomain(oPC,2,DOMENA_GORDUL2);
            break;
        case DEITY_HELGARON:
            SetClericDomain(oPC,1,DOMENA_HELGARON1);
            SetClericDomain(oPC,2,DOMENA_HELGARON2);
            break;
        case DEITY_ZEIR:
            SetClericDomain(oPC,1,DOMENA_ZEIR1);
            SetClericDomain(oPC,2,DOMENA_ZEIR2);
            break;
    }

}




int GetThalieDeity(object oPC)
{
    object oDuse = GetSoulStone(oPC);
    return GetLocalInt(oDuse,"DEITY");
}

int GetThalieClericDeity(object oPC)
{
    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)
    {
        return GetThalieDeity(oPC);
    }
    return DEITY_BEZVEREC;
}
