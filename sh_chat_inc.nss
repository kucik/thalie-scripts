#include "sh_chat_colors"
#include "mys_emote_lib"

void FollowNearestPDM(object oSelf)
{
    location lTarget =GetLocation(oSelf);
    object oPDM;
    oPDM = GetFirstObjectInShape(SHAPE_SPHERE,50.0,lTarget,FALSE,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oPDM))
    {
        if(GetIsDMPossessed(oPDM))
        {
            string sFname =GetName(oPDM,FALSE);
            AssignCommand(oSelf, ActionForceFollowObject(oPDM, 3.5f));
            SetPCChatMessage("");
            AssignCommand(oSelf,SpeakString("I am following "+sFname+" now", GetPCChatVolume()));
            return;
        }
    oPDM =GetNextObjectInShape(SHAPE_SPHERE,50.0,lTarget,FALSE,OBJECT_TYPE_CREATURE);
    }
}

void DmSpeakFunction(object oSpeaker, object oSoul, string sSpoken, int iPlayerType)
{
    int iDM, iDMp;
    object oItem = GetObjectByTag("dm_tool");
    object oDMtool = GetItemPossessor(oItem);
    object oCarmour = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oSpeaker);
    int iLength = GetStringLength(sSpoken);

    iDM = iPlayerType == PLAYER_TYPE_DM ? TRUE : FALSE;
    if(iPlayerType==PLAYER_TYPE_DM_POSSESSED || oSpeaker == oDMtool)iDM =TRUE;

    //DM String
    int iDmString = TestStringAgainstPattern("**/dms**",sSpoken);
    if(iDmString==TRUE && iDM ==TRUE)
    {
        string sDMright = GetStringRight(sSpoken,iLength-5);
        SetLocalString(oSpeaker,"DMstring",sDMright);
        SendMessageToPC(oSpeaker,"DM string set");
        SetPCChatMessage("");
    }

    //DM Interger
    int iDminteger = TestStringAgainstPattern("**/dmi**",sSpoken);
    if(iDminteger==TRUE && iDM ==TRUE)
    {
        string sDMright = GetStringRight(sSpoken,iLength-5);
        int iDmConstant =StringToInt(sDMright);
        SetLocalInt(oCarmour,"DMSetNumber",iDmConstant);
        SendMessageToPC(oSpeaker,"DM constant set");
        SetPCChatMessage("");
    }

    // DM Craft
    string sCraftcheck = GetSubString(sSpoken,5,1);
    int iDmCraftInt = TestStringAgainstPattern("**/dmci**",sSpoken);
    if(iDmCraftInt==TRUE && iDM ==TRUE && sCraftcheck != "2")
    {
        string sDMright = GetStringRight(sSpoken,iLength-6);
        int iDmCraftconstent =StringToInt(sDMright);
        SetLocalInt(oSoul,"DMCNumber",iDmCraftconstent);
        SendMessageToPC(oSpeaker,"DM Craft int set");
        //SendMessageToPC(oSpeaker,sCraftcheck);
        SetPCChatMessage("");
    }

    //DM Craft 2
    int iDmCraftInt2 = TestStringAgainstPattern("**/dmci2**",sSpoken);
    if(iDmCraftInt2==TRUE && iDM ==TRUE && sCraftcheck == "2")
    {
        string sDMright = GetStringRight(sSpoken,iLength-7);
        int iDmCraftconstent2 =StringToInt(sDMright);
        SetLocalInt(oSoul,"DMCNumber2",iDmCraftconstent2);
        SendMessageToPC(oSpeaker,"DM Craft int 2 set");
        //SendMessageToPC(oSpeaker,sCraftcheck);
        SetPCChatMessage("");
    }
}

void PCEmoteFunction(object oSpeaker, string sSpoken)
{
//give pc PC tool if they do not already have it.
int iPCtool = TestStringAgainstPattern("**/pctool**",sSpoken);
object oPCtool = GetItemPossessedBy(oSpeaker,"cf_em_info");

//emotes
int iPCdodge = TestStringAgainstPattern("**/dodge**",sSpoken);
int iPCdrink = TestStringAgainstPattern("**/drink**",sSpoken);
int iPCduck = TestStringAgainstPattern("**/duck**",sSpoken);
int iPCFback = TestStringAgainstPattern("**/Fback**",sSpoken);
int iPCFprone = TestStringAgainstPattern("**/Fprone**",sSpoken);
int iPCread = TestStringAgainstPattern("**/read**",sSpoken);
int iPCsit = TestStringAgainstPattern("**/sit**",sSpoken);
//continuous emots
int iPCbeg = TestStringAgainstPattern("**/beg**",sSpoken);
int iPCconjure1 = TestStringAgainstPattern("**/conjure1**",sSpoken);
int iPCconjure2 = TestStringAgainstPattern("**/conjure2**",sSpoken);
int iPCgetlow = TestStringAgainstPattern("**/getlow**",sSpoken);
int iPCgetmid = TestStringAgainstPattern("**/getmid**",sSpoken);
int iPCmeditate = TestStringAgainstPattern("**/meditate**",sSpoken);
int iPCthreaten = TestStringAgainstPattern("**/threaten**",sSpoken);
int iPCworship = TestStringAgainstPattern("**/worship**",sSpoken);

int iPCdance = TestStringAgainstPattern("**/dance**",sSpoken);
int iPCdrunk = TestStringAgainstPattern("**/drunk**",sSpoken);
int iPCfollowPC = TestStringAgainstPattern("**/followpc**",sSpoken);
int iPCfollowDM = TestStringAgainstPattern("**/followdm**",sSpoken);
int iPCsitchair = TestStringAgainstPattern("**/sitchair**",sSpoken);
int iPCsitdrink = TestStringAgainstPattern("**/sitdrink**",sSpoken);
int iPCsitread = TestStringAgainstPattern("**/sitread**",sSpoken);
int iPCspasm = TestStringAgainstPattern("**/spasm**",sSpoken);
int iPCsmoke = TestStringAgainstPattern("**/smoke**",sSpoken);

//standards missed
int iPCbow = TestStringAgainstPattern("**/bow**",sSpoken);
int iPCgreet = TestStringAgainstPattern("**/greet**",sSpoken);
int iPCwaves = TestStringAgainstPattern("**/wave**",sSpoken);
int iPCbored = TestStringAgainstPattern("**/bored**",sSpoken);
int iPCscratch = TestStringAgainstPattern("**/scratch**",sSpoken);
int iPCsalute = TestStringAgainstPattern("**/salute**",sSpoken);
int iPCsteal = TestStringAgainstPattern("**/steal**",sSpoken);
int iPCtaunt = TestStringAgainstPattern("**/taunt**",sSpoken);
int iPCvic1 = TestStringAgainstPattern("**/vic1**",sSpoken);
int iPCvic2 = TestStringAgainstPattern("**/vic2**",sSpoken);
int iPCvic3 = TestStringAgainstPattern("**/vic3**",sSpoken);
int iPCnod = TestStringAgainstPattern("**/nod**",sSpoken);
int iPClookf = TestStringAgainstPattern("**/looks**",sSpoken);
int iPCtired = TestStringAgainstPattern("**/tired**",sSpoken);
int iPClaugh = TestStringAgainstPattern("**/laugh**",sSpoken);
int ibattleCry = TestStringAgainstPattern("**/battle1**",sSpoken);
int ibattleCry2 = TestStringAgainstPattern("**/battle2**",sSpoken);
int ibattleCry3 = TestStringAgainstPattern("**/battle3**",sSpoken);


float fDur = 9999.0f;

if(iPCtool==TRUE && oPCtool == OBJECT_INVALID)
{
CreateItemOnObject("cf_em_info",oSpeaker,1);
SetPCChatMessage("");
}

if(iPCtool==TRUE && oPCtool != OBJECT_INVALID)
{
DestroyObject(oPCtool,0.0);
SetPCChatMessage("");
}

if(iPCdodge==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
SetPCChatMessage("");
}
if(iPCdrink==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
SetPCChatMessage("");
}
if(iPCduck==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK, 1.0));
SetPCChatMessage("");
}
if(iPCFback==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCFprone==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCread==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_READ,1.0));
DelayCommand(3.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0)));
SetPCChatMessage("");
}
if(iPCsit==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCbeg==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCconjure1==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCconjure2==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCgetlow==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCgetmid==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCmeditate==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCthreaten==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCworship==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCdance==TRUE)
{
//ActionPlayEmoteDance(oSpeaker);
SetPCChatMessage("");
}
if(iPCdrunk==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0,fDur));
SetPCChatMessage("");
}
if(iPCfollowPC==TRUE && GetIsPC(oSpeaker)||iPCfollowPC==TRUE && GetIsDM(oSpeaker) || iPCfollowPC==TRUE && GetIsDMPossessed(oSpeaker))
{
object oFollowing = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSpeaker);
string sFname =GetName(oFollowing,FALSE);
AssignCommand(oSpeaker, ActionForceFollowObject(oFollowing, 3.5f));
SetPCChatMessage("");
SendMessageToPC(oSpeaker,"You start following "+sFname+" now");
}
if(iPCsitchair==TRUE)
{
//SitInNearestChair(oSpeaker);
SetPCChatMessage("");
}
if(iPCsitdrink==TRUE)
{
AssignCommand(oSpeaker, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); DelayCommand(1.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_DRINK, 1.0))); DelayCommand(3.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));
SetPCChatMessage("");
}
if(iPCsitread==TRUE)
{
AssignCommand(oSpeaker, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)); DelayCommand(1.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_FIREFORGET_READ, 1.0))); DelayCommand(3.0f, AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur)));
SetPCChatMessage("");
}
if(iPCspasm==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_SPASM, 1.0, fDur));
SetPCChatMessage("");
}
if(iPCsmoke==TRUE)
{
ActionPlayEmoteSmoke(oSpeaker);
SetPCChatMessage("");
}

if(iPCbow==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
SetPCChatMessage("");
}
if(iPCgreet==TRUE ||iPCwaves==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
SetPCChatMessage("");
}

if(iPCbored==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
SetPCChatMessage("");
}

if(iPCscratch==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
SetPCChatMessage("");
}
if(iPCsalute==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
SetPCChatMessage("");
}
if(iPCsteal==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_STEAL, 1.0));
SetPCChatMessage("");
}
if(iPCtaunt==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
PlayVoiceChat(VOICE_CHAT_TAUNT, oSpeaker);
SetPCChatMessage("");
}

if(iPCvic1==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
PlayVoiceChat(VOICE_CHAT_CHEER, oSpeaker);
SetPCChatMessage("");
}
if(iPCvic2==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY2, 1.0));
PlayVoiceChat(VOICE_CHAT_CHEER, oSpeaker);
SetPCChatMessage("");
}
if(iPCvic3==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
PlayVoiceChat(VOICE_CHAT_CHEER, oSpeaker);
SetPCChatMessage("");
}
if(iPCnod==TRUE)
{
//it really nod animation, weird
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0,fDur));
SetPCChatMessage("");
}
if(iPClookf==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0,fDur));
SetPCChatMessage("");
}

if(iPCtired==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0,fDur));
SetPCChatMessage("");
}
if(iPClaugh==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 1.0, fDur));
PlayVoiceChat(VOICE_CHAT_LAUGH, oSpeaker);
SetPCChatMessage("");
}
if(ibattleCry==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0));
PlayVoiceChat(VOICE_CHAT_BATTLECRY1, oSpeaker);
SetPCChatMessage("");
}
if(ibattleCry2==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
PlayVoiceChat(VOICE_CHAT_BATTLECRY2, oSpeaker);
SetPCChatMessage("");
}
if(ibattleCry3==TRUE)
{
AssignCommand(oSpeaker, PlayAnimation(ANIMATION_FIREFORGET_VICTORY3, 1.0));
PlayVoiceChat(VOICE_CHAT_BATTLECRY3, oSpeaker);
SetPCChatMessage("");
}
int iAnimate = TestStringAgainstPattern("**/Animate**",sSpoken);
if(iAnimate==TRUE)
{
 if (GetLocalInt(oSpeaker, "dmfi_dice_no_animate")==1)
{
SetLocalInt(oSpeaker, "dmfi_dice_no_animate", 0);
 FloatingTextStringOnCreature("Rolls will show animation", oSpeaker);
 SetPCChatMessage("");
 }
else
{
SetLocalInt(oSpeaker, "dmfi_dice_no_animate", 1);
FloatingTextStringOnCreature("Rolls will NOT show animation", oSpeaker);
SetPCChatMessage("");
}
}
if(iPCfollowDM==TRUE && GetIsPC(oSpeaker))
{
FollowNearestPDM(oSpeaker);
SetPCChatMessage("");
}

if(!GetIsPC(oSpeaker) && iPCfollowDM != TRUE)
{
SetPCChatMessage("");
}
if(iPCfollowDM==TRUE && !GetIsPC(oSpeaker))
{
FollowNearestPDM(oSpeaker);
SetPCChatMessage("");
}
}

void PCDiceFuntion(object oSpeaker, string sSpoken)
{
    int iLength = GetStringLength(sSpoken);

    int iRandom = TestStringAgainstPattern("**/Random**",sSpoken);
    int iSTR = TestStringAgainstPattern("**/STR.**",sSpoken);
    int iDEX = TestStringAgainstPattern("**/DEX.**",sSpoken);
    int iCON = TestStringAgainstPattern("**/CON.**",sSpoken);
    int iINT = TestStringAgainstPattern("**/INT.**",sSpoken);
    int iWIS = TestStringAgainstPattern("**/WIS.**",sSpoken);
    int iCHA = TestStringAgainstPattern("**/CHA.**",sSpoken);

    int iFORTITUDE = TestStringAgainstPattern("**/FOR.**",sSpoken);
    int iREFLEX = TestStringAgainstPattern("**/REF.**",sSpoken);
    int iWILL = TestStringAgainstPattern("**/WILL.**",sSpoken);

    int iAnimalEmp = TestStringAgainstPattern("**/A.E.**",sSpoken);
    int iAppraise = TestStringAgainstPattern("**/Appraise**",sSpoken);
    int iBluff = TestStringAgainstPattern("**/Bluff**",sSpoken);
    int iConcentration = TestStringAgainstPattern("**/Concentration**",sSpoken);
    int iCArmor = TestStringAgainstPattern("**/CArmor**",sSpoken);
    int iCTrap = TestStringAgainstPattern("**/CTrap**",sSpoken);
    int iCWeapon = TestStringAgainstPattern("**/CWeapon**",sSpoken);
    int iDTrap = TestStringAgainstPattern("**/DTrap**",sSpoken);
    int iDis = TestStringAgainstPattern("**/Dis.**",sSpoken);
    int iHeal = TestStringAgainstPattern("**/Heal**",sSpoken);
    int iHide = TestStringAgainstPattern("**/Hide**",sSpoken);
    int iIntimidate = TestStringAgainstPattern("**/Intimidate**",sSpoken);
    int iListen = TestStringAgainstPattern("**/Listen**",sSpoken);
    int iLore = TestStringAgainstPattern("**/Lore**",sSpoken);
    int iMS = TestStringAgainstPattern("**/M.S.**",sSpoken);
    int iOL = TestStringAgainstPattern("**/O.L.**",sSpoken);
    int iParry = TestStringAgainstPattern("**/Parry**",sSpoken);
    int iPerform= TestStringAgainstPattern("**/Perform**",sSpoken);
    int iRide= TestStringAgainstPattern("**/Ride**",sSpoken);
    int iPersuade= TestStringAgainstPattern("**/Persuade**",sSpoken);
    int iPP= TestStringAgainstPattern("**/P.P.**",sSpoken);
    int iSearch= TestStringAgainstPattern("**/Search**",sSpoken);
    int iST= TestStringAgainstPattern("**/S.T.**",sSpoken);
    int iSpellcraft= TestStringAgainstPattern("**/Spellcraft**",sSpoken);
    int iSpot= TestStringAgainstPattern("**/Spot**",sSpoken);
    int iTaunt= TestStringAgainstPattern("**/sTaunt**",sSpoken);
    int iTumble= TestStringAgainstPattern("**/Tumble**",sSpoken);
    int iUMD= TestStringAgainstPattern("**/U.M.D.**",sSpoken);


    if(iSTR==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 61);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iDEX==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 62);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCON==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 63);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iINT==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 64);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iWIS==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 65);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCHA==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 66);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iFORTITUDE==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 67);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iREFLEX==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 68);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iWILL==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 69);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iAnimalEmp==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 71);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iAppraise==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 72);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iBluff==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 73);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iConcentration==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 74);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCArmor==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 75);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCTrap==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 76);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iCWeapon==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 77);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iDTrap==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 78);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iDis==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 79);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iHeal==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 81);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iHide==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 82);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iIntimidate==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 83);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iListen==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 84);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iLore==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 85);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iMS==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 86);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iOL==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 87);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iParry==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 88);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iPerform==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 89);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iRide==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 90);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iPersuade==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 91);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iPP==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 92);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iSearch==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 93);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iST==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 94);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iSpellcraft==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 95);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iSpot==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 96);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iTaunt==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 97);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iTumble==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 98);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }
    if(iUMD==TRUE)
    {
    SetLocalInt(oSpeaker, "dmfi_univ_int", 99);
    SetPCChatMessage("");
    SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
    ExecuteScript("sh_dm_execute", oSpeaker);
            return;
    }

/*
BCMP Broadcast Mode set to Private
BCMG Broadcast Mode set to Global
BCML Broadcast Mode set to Local
*/


int iBroadP= TestStringAgainstPattern("**/BCMP**",sSpoken);
int iBroadG= TestStringAgainstPattern("**/BCMG**",sSpoken);
int iBroadL= TestStringAgainstPattern("**/BCML**",sSpoken);

if(iBroadL==TRUE)
{
SetLocalInt(oSpeaker, "dmfi_univ_int", 101);
SetPCChatMessage("");
SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
ExecuteScript("sh_dm_execute", oSpeaker);
        return;
}
if(iBroadG==TRUE)
{
SetLocalInt(oSpeaker, "dmfi_univ_int", 102);
SetPCChatMessage("");
SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
ExecuteScript("sh_dm_execute", oSpeaker);
        return;
}
if(iBroadP==TRUE)
{
SetLocalInt(oSpeaker, "dmfi_univ_int", 103);
SetPCChatMessage("");
SetLocalString(oSpeaker, "dmfi_univ_conv", "pc_dicebag");
ExecuteScript("sh_dm_execute", oSpeaker);
        return;
}




if(iRandom==TRUE)
{
string sRright = GetStringRight(sSpoken,iLength-8);
int iRandom =StringToInt(sRright);
int iTotal =Random(iRandom)+1;
string sTotal =IntToString(iTotal);
string sNew ="Random Roll from 1 - "+sRright+" = "+sTotal;
SetPCChatMessage(sNew);
ColorSet(sNew);
}

string sFirst =GetStringLeft(sSpoken,1);
int iDnumber = TestStringAgainstPattern("**d**",sSpoken);
string sSecond =GetSubString(sSpoken,1,1);
int iSecond =StringToInt(sSecond);

if(iDnumber == TRUE && sFirst == "/" && iSecond != 0)
{
//SendMessageToPC(oSpeaker,"DEBUG");

int iFind_d =FindSubString(sSpoken,"d",1);
int iFind_big_D =FindSubString(sSpoken,"D",1);
int iCount;
if(iFind_d >=1 && iFind_big_D == -1)
{
int iCount = iFind_d;
int iNCount = iCount+1;
int iLength =GetStringLength(sSpoken);
string sRightNumber = GetStringRight(sSpoken,iLength-iNCount);
string sLeftNumber =GetSubString(sSpoken,1,iCount-1);
int iLeftNumber =StringToInt(sLeftNumber);
int iRightNumber =StringToInt(sRightNumber);
int iDice;
int iValidnumber=0;
if(iRightNumber==2)iDice = d2(iLeftNumber);
if(iRightNumber==3)iDice = d3(iLeftNumber);
if(iRightNumber==4)iDice = d4(iLeftNumber);
if(iRightNumber==6)iDice = d6(iLeftNumber);
if(iRightNumber==8)iDice = d8(iLeftNumber);
if(iRightNumber==10)iDice = d10(iLeftNumber);
if(iRightNumber==12)iDice = d12(iLeftNumber);
if(iRightNumber==20)iDice = d20(iLeftNumber);
if(iRightNumber==100)iDice = d100(iLeftNumber);
if(iRightNumber != 100 && iRightNumber != 20 && iRightNumber != 12
&& iRightNumber != 10 && iRightNumber != 8 && iRightNumber != 6
&& iRightNumber != 4 && iRightNumber != 3 && iRightNumber != 2)iValidnumber=1;
string sDice =IntToString(iDice);
string sRoll ="Roll "+sLeftNumber+"d"+sRightNumber+" = "+sDice;
if(iValidnumber==1)sRoll = "Not a valid die, 2, 3, 4, 6, 8, 10, 12, 20, 100 are valid";
SetPCChatMessage(sRoll);
ColorSet(sRoll);
}
if(iFind_d ==-1 && iFind_big_D >= 1)
{
int iCount = iFind_big_D;
int iNCount = iCount+1;
int iLength =GetStringLength(sSpoken);
string sRightNumber = GetStringRight(sSpoken,iLength-iNCount);
string sLeftNumber =GetSubString(sSpoken,1,iCount-1);
int iLeftNumber =StringToInt(sLeftNumber);
int iRightNumber =StringToInt(sRightNumber);
int iDice;
int iValidnumber=0;
if(iRightNumber==2)iDice = d2(iLeftNumber);
if(iRightNumber==3)iDice = d3(iLeftNumber);
if(iRightNumber==4)iDice = d4(iLeftNumber);
if(iRightNumber==6)iDice = d6(iLeftNumber);
if(iRightNumber==8)iDice = d8(iLeftNumber);
if(iRightNumber==10)iDice = d10(iLeftNumber);
if(iRightNumber==12)iDice = d12(iLeftNumber);
if(iRightNumber==20)iDice = d20(iLeftNumber);
if(iRightNumber==100)iDice = d100(iLeftNumber);
if(iRightNumber != 100 && iRightNumber != 20 && iRightNumber != 12
&& iRightNumber != 10 && iRightNumber != 8 && iRightNumber != 6
&& iRightNumber != 4 && iRightNumber != 3 && iRightNumber != 2)iValidnumber=1;
string sDice =IntToString(iDice);
string sRoll ="Roll "+sLeftNumber+"d"+sRightNumber+" = "+sDice;
if(iValidnumber==1)sRoll = "Not a valid die, 2, 3, 4, 6, 8, 10, 12, 20, 100 are valid(Number on the right)";
SetPCChatMessage(sRoll);
ColorSet(sRoll);
}
}
}