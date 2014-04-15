#include "ku_libtime"

const int HENCHMAN_LEASE_PRICE_DEFAULT = 50000;
const int HENCHMAN_LEASE_LENGTH_DEFAULT = 4838400; // 1 IC rok
const string HENCHMAN_KEY_TAG = "myi_hen_key";
const string HENCHMAN_LEASE_TAG = "henchman_leasable";

// Info stored on key item
//object  HENCHMAN                    - object henchmana (když je nevalidní, mùžeme summonovat)
//string  HENCHMAN_TAG                - resref henchmana
//string  HENCHMAN_RESREF             - resref henchmana
//string  HENCHMAN_LESSOR_TAG         - tag najemnce henchmana (kvuli prodlouzeni najmu)
//int     HENCHMAN_LEASE_EXPIRATION   - cas vyprseni pronajmu henchmana v sekundach
//int     HENCHMAN_LEASE_PRICE        - cena pronajmu henchmana

// Dialog tokens
// Lease price token = 6891

// Returns henchman object.
object SummonHenchman(object oKey);

// Return TRUE if renaming was successful. FALSE otherwise.
int RenameHenchman(object oHenchman, string sNewName);

// Returns TRUE if key lease is expired.
int GetIsHenchmanKeyExpired(object oKey);

void CopyHenchmanVars(object oFrom, object oTo);

// Returns key object.
object HireHenchman(object oHenchman, object oPC, object oLessor = OBJECT_INVALID, float fDurModificator = 1.0f);
int ExtendHenchmanKey(object oKey, object oLessor = OBJECT_INVALID, int iEnlongation = 0);
int GetHenchmanHirePrice(object oHenchman);
object GetHenchmanByName(object oLessor, string sName);
object GetKeyByName(object oPC, string sName);
string GetDateFromTimeStamp(int iStamp, int bTime = FALSE);

object SummonHenchman(object oKey)
{
    object oPC = GetItemPossessor(oKey);
    string sResRef = GetLocalString(oKey, "HENCHMAN_RESREF");
    string sTag = GetLocalString(oKey, "HENCHMAN_TAG");
    int iHP = GetLocalInt(oKey, "HENCHMAN_HP");
    location lLocation = GetLocation(oPC);
    
    // Temporary setting
    sTag = "mount";
    
    if (sResRef != "")
    {
        object oHenchman = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLocation, FALSE, sTag);
        
        // Set proper hitpoints
        if (iHP && iHP < GetCurrentHitPoints(oHenchman))
        {
            AssignCommand(GetModule(), ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oHenchman) - iHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oHenchman));
            AssignCommand(oHenchman, ClearAllActions(TRUE));
        }
        
        AssignCommand(oHenchman, SetName(oHenchman, GetName(oKey)));
        AssignCommand(oHenchman, AddHenchman(oPC, oHenchman));
        SetLocalObject(oKey, "HENCHMAN", oHenchman);
        DeleteLocalInt(oKey, "HENCHMAN_USES");
        CopyHenchmanVars(oKey, oHenchman);
        return oHenchman;
    }
    return OBJECT_INVALID;
}

int RenameHenchman(object oHenchman, string sNewName)
{
    if (!GetIsObjectValid(oHenchman) || sNewName == "")
        return FALSE; 
    
    object oPC = GetMaster(oHenchman);
    object oItem = GetFirstItemInInventory(oPC);
    string sCurrentName = GetName(oHenchman);
    
    while (GetIsObjectValid(oItem))
    {
        if (GetName(oItem) == sCurrentName)
        {
            SetName(oItem, sNewName);
            SetName(oHenchman, sNewName);
            return TRUE;
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return FALSE;
}

int GetIsHenchmanKeyExpired(object oKey)
{
    if (GetTag(oKey) == HENCHMAN_KEY_TAG)
    {
        if (ku_GetTimeStamp() > GetLocalInt(oKey, "HENCHMAN_LEASE_EXPIRATION"))
            return TRUE;
    }
    return FALSE;
}

void __CopyInt(object oFrom, object oTo, string sVarName)
{
    if (GetLocalInt(oFrom, sVarName))
        SetLocalInt(oTo, sVarName, GetLocalInt(oFrom, sVarName));
}

void __CopyFloat(object oFrom, object oTo, string sVarName)
{
    if (GetLocalFloat(oFrom, sVarName) != 0.0f)
        SetLocalFloat(oTo, sVarName, GetLocalFloat(oFrom, sVarName));
}

void __CopyString(object oFrom, object oTo, string sVarName)
{
    if (GetLocalString(oFrom, sVarName) != "")
        SetLocalString(oTo, sVarName, GetLocalString(oFrom, sVarName));
}

void CopyHenchmanVars(object oFrom, object oTo)
{
    __CopyInt(oFrom, oTo, "MOUNT_TAIL");
    __CopyInt(oFrom, oTo, "MOUNT_PHENOTYPE");
    __CopyInt(oFrom, oTo, "MOUNT_PHENOTYPE_L");
    __CopyInt(oFrom, oTo, "MOUNT_SPEED");
    __CopyInt(oFrom, oTo, "HENCHMAN_LEASE_PRICE");
}

object HireHenchman(object oHenchman, object oPC, object oLessor, float fDurModificator)
{
    int iHenchmanHirePrice = GetHenchmanHirePrice(oHenchman);
    int iPrice = FloatToInt( IntToFloat(iHenchmanHirePrice) * fDurModificator );
    int iDur = FloatToInt( IntToFloat(HENCHMAN_LEASE_LENGTH_DEFAULT) * fDurModificator );
    
    //SendMessageToPC(oPC, "[DEBUG] iHenPrice = " + IntToString(GetHenchmanHirePrice(oHenchman)));
    //SendMessageToPC(oPC, "[DEBUG] fDurMod = " + FloatToString(fDurModificator));
    //SendMessageToPC(oPC, "[DEBUG] iDur = " + IntToString(iDur));
    //SendMessageToPC(oPC, "[DEBUG] iPrice = " + IntToString(iPrice));
    
    if (GetGold(oPC) < iPrice) {
        if (GetIsObjectValid(oLessor))
            AssignCommand(oLessor, ClearAllActions(TRUE));
        SendMessageToPC(oPC, "Nemáš u sebe dost grešlí.");
        return OBJECT_INVALID;
    }

    // Take gold
    AssignCommand(oPC, TakeGoldFromCreature(iPrice, oPC, TRUE));

    // Create key
    object oKey = CreateItemOnObject(HENCHMAN_KEY_TAG, oPC, 1, HENCHMAN_KEY_TAG);

    // Set key expiration
    int iTime = ku_GetTimeStamp();
    int iExpiresIn = iDur;
    if (iExpiresIn < 43200)
        DelayCommand(IntToFloat(iExpiresIn), DestroyObject(oKey));
    
    // Set key variables
    CopyHenchmanVars(oHenchman, oKey);
    SetLocalString(oKey, "HENCHMAN_RESREF", GetResRef(oHenchman));
    SetLocalInt(oKey, "HENCHMAN_LEASE_EXPIRATION", iTime + iExpiresIn);
    SetLocalInt(oKey, "HENCHMAN_LEASE_PRICE", iHenchmanHirePrice);
    SetLocalInt(oKey, "HENCHMAN_USES", 1);
    if (GetIsObjectValid(oLessor))
        SetLocalString(oKey, "HENCHMAN_LESSOR_TAG", GetTag(oLessor));
    SetName(oKey, GetName(oHenchman));
    SetDescription(oKey, "Konec pronájmu: " + GetDateFromTimeStamp(iTime + iExpiresIn));
    
    return oKey;
}

int ExtendHenchmanKey(object oKey, object oLessor, int iEnlongation)
{
    if (GetLocalString(oKey, "HENCHMAN_LESSOR_TAG") != "")
    {
        if (GetTag(oLessor) != GetLocalString(oKey, "HENCHMAN_LESSOR_TAG"))
            return FALSE;
    }
    
    if (!iEnlongation) iEnlongation = HENCHMAN_LEASE_LENGTH_DEFAULT;
    
    int iTime = ku_GetTimeStamp();
    int iExpireTime = GetLocalInt(oKey, "HENCHMAN_LEASE_EXPIRATION");
    
    iExpireTime = iTime > iExpireTime ? iTime : iExpireTime;
    iExpireTime += iEnlongation;
    
    SetLocalInt(oKey, "HENCHMAN_LEASE_EXPIRATION", iExpireTime);
    SetDescription(oKey, "Konec pronájmu: " + GetDateFromTimeStamp(iExpireTime));

    if (iExpireTime < iTime + 43200)
        DelayCommand(IntToFloat(iExpireTime), DestroyObject(oKey));
    
    return TRUE;
}

int GetHenchmanHirePrice(object oHenchman)
{
    int iPrice = GetLocalInt(oHenchman, "HENCHMAN_LEASE_PRICE");
    return iPrice ? iPrice : HENCHMAN_LEASE_PRICE_DEFAULT;
}

object GetHenchmanByName(object oLessor, string sName)
{
    if (!GetIsObjectValid(oLessor) || sName == "")
        return OBJECT_INVALID;
    
    object oArea = GetArea(oLessor);
    object oHenchman = GetFirstObjectInArea(oArea);
    
    while (GetIsObjectValid(oHenchman))
    {
        if (GetObjectType(oHenchman) == OBJECT_TYPE_CREATURE)
        {
            if (GetName(oHenchman) == sName)
            {
                if (GetTag(oHenchman) == HENCHMAN_LEASE_TAG
                && !GetIsDM(oHenchman)
                && !GetIsDMPossessed(oHenchman)
                && !GetIsObjectValid(GetMaster(oHenchman)))
                  return oHenchman;
            }
        }
        oHenchman = GetNextObjectInArea(oArea);
    }
    return OBJECT_INVALID;
}

object GetKeyByName(object oPC, string sName)
{
    if (!GetIsObjectValid(oPC) || sName == "")
        return OBJECT_INVALID;
    
    object oKey = GetFirstItemInInventory(oPC);
    
    while (GetIsObjectValid(oKey))
    {
        if (GetName(oKey) == sName)
        {
            if (GetTag(oKey) == HENCHMAN_KEY_TAG)
                return oKey;
        }
        oKey = GetNextItemInInventory(oPC);
    }
    return OBJECT_INVALID;
}

string GetDateFromTimeStamp(int iStamp, int bTime = FALSE)
{
    int iSec = iStamp % 60;
    iStamp = iStamp / 60;
    int iMin = iStamp % 10;
    iStamp = iStamp / 10;
    int iHour = iStamp % 24;
    iStamp = iStamp / 24;
    int iDay = (iStamp % 28) + 1;
    iStamp = iStamp / 28;
    int iMon = (iStamp % 12) + 1;
    iStamp = iStamp / 12;
    int iYear = iStamp + KU_NULLYEAR;
    string sDate = IntToString(iDay)+". "+IntToString(iMon)+". "+IntToString(iYear);
    if (bTime)
        sDate = sDate+" "+IntToString(iHour)+":"+IntToString(iMin);
    return sDate;
}
