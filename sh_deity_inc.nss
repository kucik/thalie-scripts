#include "sh_classes_inc_e"
#include "nwnx_funcs"

int GetIsDeityAndDomainsValid(object oPC);
void SetDomainsByDeity(object oPC, int iDeity);
int GetHasDomain(object oPC, int iDomain);
//DEITY
const string DEITY_DEI_ANANG = "Dei-Anang";
const string DEITY_JUANA = "Juana";
const string DEITY_NORD = "Nord";
const string DEITY_LOTHIAN = "Lothian";
const string DEITY_AZHAR = "Azhar";
const string DEITY_THAL = "Thal";
const string DEITY_MORUS = "Morus";
const string DEITY_LILITH = "Lilith";
const string DEITY_GORDUL = "Gordul";
const string DEITY_HELGARON = "Helgaron";
const string DEITY_ZEIR = "Xian";
const string DEITY_XIAN = "Zeir";

const int DOMAIN_BEZVEREC1 = 0;
const int DOMAIN_BEZVEREC2 = 1;
const int DOMAIN_ZVIRATA = 2;
const int DOMAIN_VZDUCH = 3;
const int DOMAIN_SMRT = 4;
const int DOMAIN_NICENI = 5;
const int DOMAIN_ZEME = 6;
const int DOMAIN_ZLO = 7;
const int DOMAIN_OHEN = 8;
const int DOMAIN_DOBRO = 9;
const int DOMAIN_LECENI = 10;
const int DOMAIN_VEDENI = 11;
const int DOMAIN_MAGIE = 12;
const int DOMAIN_ROSTLINY = 13;
const int DOMAIN_OCHRANA = 14;
const int DOMAIN_SILA = 15;
const int DOMAIN_SLUNCE = 16;
const int DOMAIN_PUTOVANI = 17;
const int DOMAIN_KLAM = 18;
const int DOMAIN_VALKA = 19;
const int DOMAIN_VODA = 20;

const int DOMAIN_BOURE = 22;
const int DOMAIN_PODZEMI = 23;
const int DOMAIN_HROB = 24;
const int DOMAIN_CHAOS = 25;
const int DOMAIN_ILUZE = 26;
const int DOMAIN_KOV = 27;
const int DOMAIN_MILOSRDENSTVI = 28;
const int DOMAIN_OBCHOD = 29;
const int DOMAIN_OSUD = 30;
const int DOMAIN_PORTAL = 31;
const int DOMAIN_ROVNOVAHA = 32;
const int DOMAIN_SEN = 33;
const int DOMAIN_TEMNOTA = 34;
const int DOMAIN_UTONUTI = 35;
const int DOMAIN_VYTRVALOST = 36;
const int DOMAIN_VYHEN = 37;

const int DOMAIN_ELF = 39;
const int DOMAIN_GNOM = 40;
const int DOMAIN_PULCIK = 41;
const int DOMAIN_TRPASLIK = 42;

int GetIsDomainValid(string sDeity,int iDomain)
{
    switch (iDomain)
    {
        case DOMAIN_ELF:
        case DOMAIN_GNOM:
        case DOMAIN_PULCIK:
        case DOMAIN_TRPASLIK:
        return TRUE;
    }
    //JUANA
    if (sDeity==DEITY_JUANA)
    {
        switch (iDomain)
        {
            case DOMAIN_DOBRO:
            case DOMAIN_VEDENI:
            case DOMAIN_LECENI:
            case DOMAIN_SLUNCE:
            case DOMAIN_MAGIE:
            case DOMAIN_MILOSRDENSTVI:
            case DOMAIN_SEN:
            return TRUE;
        }
    }
    //DEI ANANG
    else if (sDeity==DEITY_DEI_ANANG)
    {
        switch (iDomain)
        {
            case DOMAIN_DOBRO:
            case DOMAIN_SILA:
            case DOMAIN_VALKA:
            case DOMAIN_OCHRANA:
            case DOMAIN_SLUNCE:
            case DOMAIN_BOURE:
            case DOMAIN_KOV:
            case DOMAIN_PORTAL:
            case DOMAIN_VYTRVALOST:
            return TRUE;
        }
    }
    //NORD
    else if (sDeity==DEITY_NORD)
    {
        switch (iDomain)
        {
            case DOMAIN_SILA:
            case DOMAIN_ZEME:
            case DOMAIN_DOBRO:
            case DOMAIN_VALKA:
            case DOMAIN_PODZEMI:
            case DOMAIN_KOV:
            case DOMAIN_OBCHOD:
            case DOMAIN_VYTRVALOST:
            case DOMAIN_VYHEN:
            return TRUE;
        }
    }
     //LOTHIAN
    else if (sDeity==DEITY_LOTHIAN)
    {
        switch (iDomain)
        {
            case DOMAIN_ZVIRATA:
            case DOMAIN_PUTOVANI:
            case DOMAIN_VODA:
            case DOMAIN_VZDUCH:
            case DOMAIN_ZEME:
            case DOMAIN_LECENI:
            case DOMAIN_MAGIE:
            case DOMAIN_BOURE:
            case DOMAIN_TEMNOTA:
            return TRUE;
        }
    }
     //AZHAR
    else if (sDeity==DEITY_AZHAR)
    {
        switch (iDomain)
        {
            case DOMAIN_ROSTLINY:
            case DOMAIN_ZVIRATA:
            case DOMAIN_LECENI:
            case DOMAIN_ZEME:
            case DOMAIN_VODA:
            case DOMAIN_VZDUCH:
            case DOMAIN_OCHRANA:
            case DOMAIN_SILA:
            case DOMAIN_ROVNOVAHA:
            case DOMAIN_UTONUTI:
            return TRUE;
        }
    }
     //MORUS
    else if (sDeity==DEITY_MORUS)
    {
        switch (iDomain)
        {
            case DOMAIN_VZDUCH:
            case DOMAIN_MAGIE:
            case DOMAIN_PUTOVANI:
            case DOMAIN_VEDENI:
            case DOMAIN_CHAOS:
            case DOMAIN_ILUZE:
            case DOMAIN_OBCHOD:
            case DOMAIN_TEMNOTA:
            return TRUE;
        }
    }
     //LILITH
    else if (sDeity==DEITY_LILITH)
    {
        switch (iDomain)
        {
            case DOMAIN_OHEN:
            case DOMAIN_MAGIE:
            case DOMAIN_NICENI:
            case DOMAIN_PUTOVANI:
            case DOMAIN_OCHRANA:
            case DOMAIN_BOURE:
            case DOMAIN_CHAOS:
            case DOMAIN_ILUZE:
            case DOMAIN_PORTAL:
            return TRUE;
        }
    }
     //Thal
    else if (sDeity==DEITY_THAL)
    {
        switch (iDomain)
        {
            case DOMAIN_OCHRANA:
            case DOMAIN_PUTOVANI:
            case DOMAIN_VEDENI:
            case DOMAIN_BOURE:
            case DOMAIN_OBCHOD:
            case DOMAIN_OSUD:
            case DOMAIN_ROVNOVAHA:
            case DOMAIN_SEN:
            return TRUE;
        }
    }
     //XIAN
    else if (sDeity==DEITY_XIAN)
    {
        switch (iDomain)
        {
            case DOMAIN_KLAM:
            case DOMAIN_ZLO:
            case DOMAIN_NICENI:
            case DOMAIN_SMRT:
            case DOMAIN_PODZEMI:
            case DOMAIN_SEN:
            case DOMAIN_TEMNOTA:
            return TRUE;
        }
    }
     //GORDUL
    else if (sDeity==DEITY_GORDUL)
    {
        switch (iDomain)
        {
            case DOMAIN_SILA:
            case DOMAIN_VALKA:
            case DOMAIN_NICENI:
            case DOMAIN_ZLO:
            case DOMAIN_PODZEMI:
            case DOMAIN_CHAOS:
            case DOMAIN_VYTRVALOST:
            return TRUE;
        }
    }
    //HELGARON
    else if (sDeity==DEITY_HELGARON)
    {
        switch (iDomain)
        {
            case DOMAIN_ZLO:
            case DOMAIN_SILA:
            case DOMAIN_VALKA:
            case DOMAIN_NICENI:
            case DOMAIN_PODZEMI:
            case DOMAIN_KOV:
            case DOMAIN_PORTAL:
            return TRUE;
        }
    }
    //ZEIR
    else if (sDeity==DEITY_ZEIR)
    {
        switch (iDomain)
        {
            case DOMAIN_ZLO:
            case DOMAIN_SMRT:
            case DOMAIN_VEDENI:
            case DOMAIN_PUTOVANI:
            case DOMAIN_HROB:
            case DOMAIN_SEN:
            return TRUE;
        }
    }
    return FALSE;
}


int GetIsDeityAndDomainsValid(object oPC)
{
    string sDeity= GetDeity(oPC);
    int iDomain1 = GetClericDomain(oPC,1);
    int iDomain2 = GetClericDomain(oPC,2);
    return ((GetIsDomainValid(sDeity,iDomain1))&& (GetIsDomainValid(sDeity,iDomain2)));
}

int GetHasDomain(object oPC, int iDomain)
{
    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC)==0)
    {
        return FALSE;
    }
    return  (GetClericDomain(oPC,1)==iDomain) || (GetClericDomain(oPC,2)==iDomain);
}

void CheckRacialDomain(object oPC,int iDomainOrder,int iInvalidDomain)
{
    int iDomain = GetClericDomain(oPC,iDomainOrder);
    if ((iDomain==DOMAIN_ELF) && (GetRacialType(oPC)!=RACIAL_TYPE_ELF))
    {
        if (GetRacialType(oPC)==RACIAL_TYPE_HALFELF) return;
        SetClericDomain(oPC,iDomainOrder,iInvalidDomain);
        return;
    }
    if ((iDomain==DOMAIN_GNOM) && (GetRacialType(oPC)!=RACIAL_TYPE_GNOME))
    {
        SetClericDomain(oPC,iDomainOrder,iInvalidDomain);
        return;
    }
    if ((iDomain==DOMAIN_PULCIK) && (GetRacialType(oPC)!=RACIAL_TYPE_HALFLING))
    {
        SetClericDomain(oPC,iDomainOrder,iInvalidDomain);
        return;
    }
    if ((iDomain==DOMAIN_TRPASLIK) && (GetRacialType(oPC)!=RACIAL_TYPE_DWARF))
    {
        SetClericDomain(oPC,iDomainOrder,iInvalidDomain);
        return;
    }
}

void CheckDomainRules(object oPC)
{
    int iDomain1 = GetClericDomain(oPC,1);
    int iDomain2 = GetClericDomain(oPC,2);
    //Kontrola na elementarni domeny
    int iElements = 0;
    if ((iDomain1==DOMAIN_OHEN) || (iDomain1==DOMAIN_VODA) || (iDomain1==DOMAIN_ZEME)|| (iDomain1==DOMAIN_VZDUCH))
    {
        iElements +=1;
    }
    if ((iDomain2==DOMAIN_OHEN) || (iDomain2==DOMAIN_VODA) || (iDomain2==DOMAIN_ZEME)|| (iDomain2==DOMAIN_VZDUCH))
    {
        iElements +=1;
    }
    if (iElements==2)
    {
        SetClericDomain(oPC,2,DOMAIN_BEZVEREC2);
        return;
    }
    //Kontrola na rasove domeny
    CheckRacialDomain(oPC,1,DOMAIN_BEZVEREC1);
    CheckRacialDomain(oPC,2,DOMAIN_BEZVEREC2);
}


void RepairDomainFeats(object oPC,int iOldDomain,int iNewDomain)
{
    //Odstraneni puvodniho featu
    string sOldFeat = Get2DAString("domains", "GrantedFeat", iOldDomain);
    int iOldFeat = StringToInt(sOldFeat);
    if(iOldFeat>0)
    {
        RemoveKnownFeat(oPC,iOldFeat);
    }
    //Pridani noveho featu
    string sNewFeat = Get2DAString("domains", "GrantedFeat", iNewDomain);
    int iNewFeat = StringToInt(sNewFeat);
    if(iNewFeat>0)
    {
        AddKnownFeat(oPC,iNewFeat);
    }
    SendMessageToPC(oPC, "Prosim provedte relog.");
}



void DialogSetDomain(object oPC,object oNPC,int iNewDomain)
{
    int iDomainOrder= GetLocalInt(oNPC,"DOMAIN");
    int iOldDomain = GetClericDomain(oPC,iDomainOrder);
    SetClericDomain(oPC,iDomainOrder,iNewDomain);
    SendMessageToPC(oPC,"Puvodni domena: "+IntToString(iOldDomain));
    SendMessageToPC(oPC,"Nova domena: "+IntToString(iNewDomain));
    RepairDomainFeats(oPC,iOldDomain,iNewDomain);
}
