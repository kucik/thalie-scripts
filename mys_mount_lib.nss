// Notes:
// Neudelat jednu fci ridici all speed effects postavy?
// Zkusit restoration, dispell.


// Mount creature tag
const string MOUNT_TAG = "mount";

// Mounted default speed bonus
const int MOUNT_SPEED_DEFAULT = 50;

// Permanent creature info
//int     MOUNT_TAIL                      Mounted tail (standard nwn mount)
//int     MOUNT_PHENOTYPE                 Mounted phenotype (DLA mount)
//int     MOUNT_PHENOTYPE_L               Mounted phenotype large (DLA mount)
//int     MOUNT_SPEED                     Mounted speed bonus

// Temporary info about rider
//int     MOUNTED                         Mounted status: 1 = mounted; 0 = not
//int     MOUNT_RIDER_TAIL                Rider's original tail (nwn mount only)
//int     MOUNT_RIDER_PHENOTYPE           Rider's original phenotype (DLA mount only)

// Temporary info about mount creature
//string  MOUNT_CREATURE_RESREF           Unmounted creature resref
//string  MOUNT_CREATURE_NAME             Unmounted creature name
//int     MOUNT_CREATURE_APPEARANCE       Unmounted creature appearance
//string  MOUNT_CREATURE_PORTRAIT         Unmounted creature portrait
//int     MOUNT_CREATURE_RACE             Unmounted creature race
//int     MOUNT_CREATURE_FACTION          Unmounted creature faction


void Mount(object oRider, object oMount, object oSoul, int bJousting = FALSE);
void Dismount(object oRider, object oSoul);
void RemoveMountedEffects(object oRider);
void ApplyMountedSpeed(object oRider, int iSpeed);
void ApplyMountedSkillBonus(object oRider, int iSkill, int iValue);

// Returns appearance.2da index based on rider's race.
// To be applied on rider object.
int GetMountedRaceAppearance(object oRider);

// Returns appearance.2da index based on rider's race.
// To be applied on mount object.
int GetMountedNullAppearance(object oRider);

// Stores relevant mount properties as key variables
void StoreMountInfo(object oMount, object oKey);


// Notes
//lLoc=HORSE_SupportGetMountLocation(oHorse,oRider,-90.0);
//ActionPlayAnimation(HORSE_ANIMATION_MOUNT,1.0,fMonitorSpeed);
//const int HORSE_ANIMATION_MOUNT =                      41;
//const int HORSE_ANIMATION_DISMOUNT =                   42;


void StoreMountInfo(object oMount, object oKey)
{
    SetLocalInt(oKey, "MOUNT_TAIL", GetLocalInt(oMount, "MOUNT_TAIL"));
    SetLocalInt(oKey, "MOUNT_PHENOTYPE", GetLocalInt(oMount, "MOUNT_PHENOTYPE"));
    SetLocalInt(oKey, "MOUNT_PHENOTYPE_L", GetLocalInt(oMount, "MOUNT_PHENOTYPE_L"));
    SetLocalInt(oKey, "MOUNT_SPEED", GetLocalInt(oMount, "MOUNT_SPEED"));
    
    SetLocalString(oKey, "MOUNT_CREATURE_NAME", GetName(oMount));
    SetLocalInt(oKey, "MOUNT_CREATURE_APPEARANCE", GetAppearanceType(oMount));        
    SetLocalInt(oKey, "MOUNT_CREATURE_PORTRAIT", GetPortraitId(oMount));
}

void SetMountProperties(object oMount, object oKey)
{
    SetLocalInt(oMount, "MOUNT_TAIL", GetLocalInt(oKey, "MOUNT_TAIL"));
    SetLocalInt(oMount, "MOUNT_PHENOTYPE", GetLocalInt(oKey, "MOUNT_PHENOTYPE"));
    SetLocalInt(oMount, "MOUNT_PHENOTYPE_L", GetLocalInt(oKey, "MOUNT_PHENOTYPE_L"));
    SetLocalInt(oMount, "MOUNT_SPEED", GetLocalInt(oKey, "MOUNT_SPEED"));
    
    SetCreatureAppearanceType(oMount, GetLocalInt(oKey, "MOUNT_CREATURE_APPEARANCE"));
    SetPortraitId(oMount, GetLocalInt(oKey, "MOUNT_CREATURE_PORTRAIT"));
    SetName(oMount, GetLocalString(oKey, "MOUNT_CREATURE_NAME"));
}

void Mount(object oRider, object oMount, object oSoul, int bJousting)
{
    if (!GetIsObjectValid(oRider) || !GetIsObjectValid(oMount) || !GetIsObjectValid(oSoul) || GetTag(oMount) != MOUNT_TAG)
        return;

    int iOriginalPhenoType = GetPhenoType(oRider);
    int iOriginalTail = GetCreatureTailType(oRider);

    int iMountedTail = GetLocalInt(oMount, "MOUNT_TAIL");
    int iMountedPhenoType = iOriginalPhenoType == 2 ? GetLocalInt(oMount, "MOUNT_PHENOTYPE_L") : GetLocalInt(oMount, "MOUNT_PHENOTYPE");
    int iMountedSpeed = GetLocalInt(oMount, "MOUNT_SPEED");

    int iMountNullAppearance = !iMountedPhenoType ? GetMountedNullAppearance(oRider) : 0;
    int iMountedRaceAppearance = !iMountedPhenoType ? GetMountedRaceAppearance(oRider) : 0;
    
    // Set default values
    if (!iMountedPhenoType && iOriginalPhenoType < 3) iMountedPhenoType = bJousting ? iOriginalPhenoType + 6 : iOriginalPhenoType + 3;
    if (!iMountedSpeed) iMountedSpeed = MOUNT_SPEED_DEFAULT;
    //if (!iMountedTail) iMountedTail = StringToInt(Get2DAString("apptotail", "TAIL", where model = (Get2daString("appearance", "race", GetAppearanceType(oMount))) )

    
    
    int bMounted = GetLocalInt(oSoul, "MOUNTED");

    if (!bMounted)
    {
        // Store info about rider
        SetLocalInt(oSoul, "MOUNTED", 1);
        SetLocalInt(oSoul, "MOUNT_RIDER_TAIL", iOriginalTail);
        SetLocalInt(oSoul, "MOUNT_RIDER_PHENOTYPE", iOriginalPhenoType);

        // Store info about mount creature
        SetLocalInt(oSoul, "MOUNT_TAIL", GetLocalInt(oMount, "MOUNT_TAIL"));
        SetLocalInt(oSoul, "MOUNT_PHENOTYPE", GetLocalInt(oMount, "MOUNT_PHENOTYPE"));
        SetLocalInt(oSoul, "MOUNT_SPEED", GetLocalInt(oMount, "MOUNT_SPEED"));
        
        SetLocalString(oSoul, "MOUNT_CREATURE_RESREF", GetResRef(oMount));
        SetLocalString(oSoul, "MOUNT_CREATURE_NAME", GetName(oMount));
        SetLocalInt(oSoul, "MOUNT_CREATURE_APPEARANCE", GetAppearanceType(oMount));        
        SetLocalInt(oSoul, "MOUNT_CREATURE_PORTRAIT", GetPortraitId(oMount));
        
        if (iMountNullAppearance)
            SetCreatureAppearanceType(oMount, iMountNullAppearance);
        
        if (iMountedRaceAppearance)
            SetCreatureAppearanceType(oRider, iMountedRaceAppearance);
        
        SetPhenoType(iMountedPhenoType, oRider);

        if (iMountedTail)
        {
            SetCreatureTailType(iMountedTail, oMount);
            SetCreatureTailType(iMountedTail, oRider);
        }

        // Apply mounted effects
        ApplyMountedSpeed(oRider, iMountedSpeed);

        SetCommandable(TRUE, oMount);
        AssignCommand(oMount, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oMount));
        AssignCommand(oMount, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oMount));
        AssignCommand(oMount, SetIsDestroyable(TRUE, FALSE, FALSE));
        DestroyObject(oMount, 0.3f);
    }
}

void Dismount(object oRider, object oSoul)
{
    if (!GetIsObjectValid(oRider) || !GetIsObjectValid(oSoul))
        return;

    string sMountResRef = GetLocalString(oSoul, "MOUNT_CREATURE_RESREF");
    string sMountName = GetLocalString(oSoul, "MOUNT_CREATURE_NAME");
    int iMountAppearance = GetLocalInt(oSoul, "MOUNT_CREATURE_APPEARANCE");

    int iOriginalTail = GetLocalInt(oSoul, "MOUNT_RIDER_TAIL");
    int iOriginalPhenoType = GetLocalInt(oSoul, "MOUNT_RIDER_PHENOTYPE");

    int bMounted = GetLocalInt(oSoul, "MOUNTED");

    if (bMounted)
    {
        SetPhenoType(iOriginalPhenoType);
        SetCreatureTailType(iOriginalTail, oRider);
        object oMount = CreateObject(OBJECT_TYPE_CREATURE, sMountResRef, GetLocation(oRider), FALSE, MOUNT_TAG);
        SetCreatureAppearanceType(oMount, iMountAppearance);
        SetPortraitId(oMount, GetLocalInt(oSoul, "MOUNT_CREATURE_PORTRAIT"));
        SetCommandable(TRUE, oMount);
        SetName(oMount, sMountName);
        AssignCommand(oMount, AddHenchman(oRider, oMount));
        // Temporary storage - rework and delete this in future
        SetLocalObject(oRider, "MOUNT_OBJECT", oMount);
        
        SetLocalInt(oMount, "MOUNT_TAIL", GetLocalInt(oSoul, "MOUNT_TAIL"));
        SetLocalInt(oMount, "MOUNT_PHENOTYPE", GetLocalInt(oSoul, "MOUNT_PHENOTYPE"));
        SetLocalInt(oMount, "MOUNT_SPEED", GetLocalInt(oSoul, "MOUNT_SPEED"));        

        // Remove mounted effects
        RemoveMountedEffects(oRider);
        
        // Instantly invis mount creature to avoid "fade out" destroy effect
        AssignCommand(oMount, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneGhost(), oMount, 1.0f));
        AssignCommand(oMount, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oMount, 1.0f));

        // Sweep-out - rider info
        DeleteLocalInt(oSoul, "MOUNTED");
        DeleteLocalInt(oSoul, "MOUNT_RIDER_TAIL");
        DeleteLocalInt(oSoul, "MOUNT_RIDER_PHENOTYPE");

        // Sweep-out - mount creature info
        DeleteLocalString(oSoul, "MOUNT_CREATURE_RESREF");
        DeleteLocalString(oSoul, "MOUNT_CREATURE_NAME");
        DeleteLocalString(oSoul, "MOUNT_CREATURE_APPEARANCE");
        DeleteLocalString(oSoul, "MOUNT_CREATURE_PORTRAIT");
        
        DeleteLocalInt(oSoul, "MOUNT_TAIL");
        DeleteLocalInt(oSoul, "MOUNT_PHENOTYPE");
        DeleteLocalInt(oSoul, "MOUNT_PHENOTYPE_L");
        DeleteLocalInt(oSoul, "MOUNT_SPEED");
    }
}

void ApplyMountedSpeed(object oRider, int iSpeed)
{
    if (iSpeed <= 0)
        return;

    effect eEffect = GetFirstEffect(oRider);

    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE
        && GetEffectSubType(eEffect) == SUBTYPE_EXTRAORDINARY
        && GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT
        && GetEffectCreator(eEffect) == oRider)
        {
            RemoveEffect(oRider, eEffect);
            DeleteLocalInt(oRider, "KU_CHAT_CMD_SLOWEDSPEED");
        }
        else if (GetEffectType(eEffect) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE
        && GetEffectSubType(eEffect) == SUBTYPE_EXTRAORDINARY
        && GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT
        && GetEffectCreator(eEffect) == oRider)
        {
            RemoveEffect(oRider, eEffect);
        }
        eEffect = GetNextEffect(oRider);
    }

    if(iSpeed > 0)
    {
        eEffect = ExtraordinaryEffect(EffectMovementSpeedIncrease(iSpeed));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oRider);
    }
}

void ApplyMountedSkillBonus(object oRider, int iSkill, int iValue)
{
    effect eEffect = ExtraordinaryEffect(EffectSkillIncrease(iSkill, iValue));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oRider);
}

void RemoveMountedEffects(object oRider)
{
    int iCounter, iEffectType;
    effect eEffect = GetFirstEffect(oRider);

    while (GetIsEffectValid(eEffect))
    {
        // Nevim proc, ale GetEffectSpellId se nastavi spravne v main(), ale v dalsich metodach uz ne.
        // Mount spell_id = 813
        // Mount Jousting spell_id = 815
                
        if (GetEffectSpellId(eEffect) < 0
        && GetEffectSubType(eEffect) == SUBTYPE_EXTRAORDINARY
        && GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT
        && GetEffectCreator(eEffect) == oRider)
        {
            RemoveEffect(oRider, eEffect);
        }
        eEffect = GetNextEffect(oRider);
    }
}

int GetMountedRaceAppearance(object oRider)
{
    return 482 + GetRacialType(oRider) * 2 + !GetGender(oRider);
}

int GetMountedNullAppearance(object oRider)
{
    return 562 + GetRacialType(oRider);
}
