void ActionSitNearestPlaceable(object oSubject);
void ActionPlayEmoteDance(object oSubject);
void ActionPlayEmoteSmoke(object oSubject);

// Used by smoke animation.
location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight);

void ActionPlayEmote(object oSubject, int iEmote)
{
    float fDur = 9999.0f;
    
    switch(iEmote)
    {
        // ---------------------------------------------------------------------
        // FIREFORGET
        // ---------------------------------------------------------------------
        
        // bored
        case 0:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
            break;
        
        // bow 
        case 1:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
            break;
            
        // dodge 
        case 2:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
            break;
            
        // drink 
        case 3:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
            break;
            
        // duck 
        case 4:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0));
            break;
        
        // greet 
        case 5:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
            break;
            
        // read 
        case 6:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
            break;
            
        // salute 
        case 7:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
            break;
        
        // scratch head 
        case 8:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
            break;
            
        // steal 
        case 9:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0));
            break;
            
        // taunt 
        case 10:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
            break;
            
        // victory pose 1 
        case 11:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
            PlayVoiceChat(VOICE_CHAT_CHEER, oSubject);
            break;
            
        // victory pose 2 
        case 12:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
            PlayVoiceChat(VOICE_CHAT_CHEER, oSubject);
            break;
            
        // victory pose 3 
        case 13:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
            PlayVoiceChat(VOICE_CHAT_CHEER, oSubject);
            break;
            
        // battlecry 1 
        case 14:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
            PlayVoiceChat(VOICE_CHAT_BATTLECRY1, oSubject);
            break;
        
        // battlecry 2  
        case 15:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
            PlayVoiceChat(VOICE_CHAT_BATTLECRY2, oSubject);
            break;
            
        // battlecry 3  
        case 16:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
            PlayVoiceChat(VOICE_CHAT_BATTLECRY3, oSubject);
            break;
        
        //----------------------------------------------------------------------
        // LOOPING
        // ---------------------------------------------------------------------
        
        // beg 
        case 17:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, fDur));
            break;
        
        // conjure 1 
        case 18:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, fDur));
            break;
            
        // conjure 2 
        case 19:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, fDur));
            break;
        
        // drunk 
        case 20:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, fDur));
            break;
        
        // fall back 
        case 21:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, fDur));
            break;
            
        // fall forward 
        case 22:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, fDur));
            break;
            
        // get low 
        case 23:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fDur));
            break;
            
        // get middle 
        case 24:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, fDur));
            break;
            
        // laught 
        case 25:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, fDur));
            PlayVoiceChat(VOICE_CHAT_LAUGH, oSubject);
            break;
        
        // look far 
        case 26:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, fDur));
            break;
        
        // meditate 
        case 27:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, fDur));
            break;
            
        // spasm 
        case 28:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, fDur));
            break;
            
        // tired 
        case 29:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, fDur));
            break;
        
        // threaten 
        case 30:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, fDur));
            break;
            
        // worship 
        case 31:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, fDur));
            break;
        
        // sit on ground 
        case 32:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
            break;
            
        // sit chair-like 
        case 33:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_SIT_CHAIR, 1.0, fDur));
            break;
            
        //----------------------------------------------------------------------
        // CUSTOM AND LATER-ADDED
        //----------------------------------------------------------------------
        
        // sit nearest placeable
        case 34:
            ActionSitNearestPlaceable(oSubject);
            break;
        
        // drink while sitting
        case 35:
            AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
            DelayCommand(1.0f, AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0)));
            DelayCommand(3.0f, AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));
            break;
            
        // read while sitting
        case 36:
            AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
            DelayCommand(1.0f, AssignCommand(oSubject, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0)));
            DelayCommand(3.0f, AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));
            break;
        
        // nod
        case 37:
            AssignCommand(oSubject, PlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 3.0f));
            break;
        
        // dance
        case 38:
            ActionPlayEmoteDance(oSubject);
            break;
            
        // smoke
        case 39:
            ActionPlayEmoteSmoke(oSubject);
            break;
            
        default:
            break;
    }
}

void ActionSitNearestPlaceable(object oSubject)
{
    object oPlaceable = GetNearestObject(OBJECT_TYPE_PLACEABLE, oSubject);
    if (GetIsObjectValid(oPlaceable))
        AssignCommand(oSubject, ActionSit(oPlaceable));
}

void ActionPlayEmoteDance(object oSubject)
{
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
    AssignCommand(oSubject, ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH, oSubject)));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 2.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
    AssignCommand(oSubject, ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH, oSubject)));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 2.0));
    AssignCommand(oSubject, ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH, oSubject)));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
    AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
}

void ActionPlayEmoteSmoke(object oSubject)
{
    float fHeight = 1.7;
    float fDistance = 0.1;
    
    // Set height based on race and gender
    if (GetGender(oSubject) == GENDER_MALE)
    {
        switch (GetRacialType(oSubject))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.7; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.55; fDistance = 0.08; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.15; fDistance = 0.12; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.12; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.9; fDistance = 0.2; break;
        }
    }
    else
    {
        // FEMALES
        switch (GetRacialType(oSubject))
        {
            case RACIAL_TYPE_HUMAN:
            case RACIAL_TYPE_HALFELF: fHeight = 1.6; fDistance = 0.12; break;
            case RACIAL_TYPE_ELF: fHeight = 1.45; fDistance = 0.12; break;
            case RACIAL_TYPE_GNOME:
            case RACIAL_TYPE_HALFLING: fHeight = 1.1; fDistance = 0.075; break;
            case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.1; break;
            case RACIAL_TYPE_HALFORC: fHeight = 1.8; fDistance = 0.13; break;
        }
    }
    location lAboveHead = GetLocationAboveAndInFrontOf(oSubject, fDistance, fHeight);
    
    // glow red
    AssignCommand(oSubject, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oSubject, 0.15)));
    // wait a moment
    AssignCommand(oSubject, ActionWait(3.0));
    // puff of smoke above and in front of head
    AssignCommand(oSubject, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lAboveHead)));
    // if female, turn head to left
    if ((GetGender(oSubject) == GENDER_FEMALE) && (GetRacialType(oSubject) != RACIAL_TYPE_DWARF))
        AssignCommand(oSubject, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 5.0));
}

location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight)
{
    float fDistance = -fDist;
    object oTarget = (oPC);
    object oArea = GetArea(oTarget);
    vector vPosition = GetPosition(oTarget);
    vPosition.z += fHeight;
    float fOrientation = GetFacing(oTarget);
    vector vNewPos = AngleToVector(fOrientation);
    float vZ = vPosition.z;
    float vX = vPosition.x - fDistance * vNewPos.x;
    float vY = vPosition.y - fDistance * vNewPos.y;
    fOrientation = GetFacing(oTarget);
    vX = vPosition.x - fDistance * vNewPos.x;
    vY = vPosition.y - fDistance * vNewPos.y;
    vNewPos = AngleToVector(fOrientation);
    vZ = vPosition.z;
    vNewPos = Vector(vX, vY, vZ);
    return Location(oArea, vNewPos, fOrientation);
}