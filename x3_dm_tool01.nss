#include "x3_inc_horse"
void main()
{
object oUser=OBJECT_SELF;
string sDMid = "DM_"+GetName(oUser)+"_"+GetPCPlayerName(oUser);
object oOther = GetLocalObject(oUser, "dmfi_target");
if (!GetIsObjectValid(oOther))oOther=GetSpellTargetObject();
location lLocation=GetLocalLocation(oUser, "dmfi_location");
if (!GetIsObjectValid(GetAreaFromLocation(lLocation))) lLocation = GetSpellTargetLocation();

//*************************************INITIALIZATION CODE***************************************
//***************************************RUNS ONE TIME ***************************************





    if (GetLocalInt(GetModule(), "dmfi_initialized")!=1)
        {
        SetLocalInt(GetModule(), "dmfi_initialized", 1);
        int iLoop = 20610;
        string sText;
        while (iLoop<20680)
            {
            sText = GetCampaignString(sDMid, "hls" + IntToString(iLoop));
            SetCustomToken(iLoop, sText);
            iLoop++;
            }
        SendMessageToAllDMs("Voice custom tokens initialized.");
        }

//remainder of settings are user based

    if ((GetLocalInt(oUser, "dmfi_initialized")!=1) && GetIsDM(oUser))
    {
    //if you have campaign variables set - use those settings
    if (GetCampaignInt(sDMid, "Settings", oUser)==1)
        {
        FloatingTextStringOnCreature("Settings Restored", oUser, FALSE);
        SetLocalInt(oUser, "dmfi_initialized", 1);


         string sNotes  =GetCampaignString(sDMid,"Notes");

        if(sNotes == "")
        {
        SetCampaignString(sDMid,"Notes", "EMPTY", oUser);
        }

        int n = GetCampaignInt(sDMid, "dmfi_alignshift", oUser);
        SetCustomToken(20781, IntToString(n));
        SetLocalInt(oUser, "dmfi_alignshift", n);
        SendMessageToPC(oUser, "Settings: Alignment shift: "+IntToString(n));


        n = GetCampaignInt(sDMid, "dmfi_safe_factions", oUser);
        SetLocalInt(oUser, "dmfi_safe_factions", n);
        SendMessageToPC(oUser, "Settings: Factions (1 is DMFI Safe Faction): "+IntToString(n));

        n = GetCampaignInt(sDMid, "dmfi_damagemodifier", oUser);
        SetLocalInt(oUser, "dmfi_damagemodifier",n);
        SendMessageToPC(oUser, "Settings: Damage Modifier: "+IntToString(n));

        n = GetCampaignInt(sDMid,"dmfi_buff_party",oUser);
        SetLocalInt(oUser, "dmfi_buff_party", n);
        if (n==1)
            SetCustomToken(20783, "Party");
        else
            SetCustomToken(20783, "Single Target");

        SendMessageToPC(oUser, "Settings: Buff Party (1 is Party): "+IntToString(n));

        string sLevel = GetCampaignString(sDMid, "dmfi_buff_level", oUser);
        SetCustomToken(20782, sLevel);
        SetLocalString(oUser, "dmfi_buff_level", sLevel);
        SendMessageToPC(oUser, "Settings: Buff Level: "+ sLevel);

        n = GetCampaignInt(sDMid, "dmfi_dicebag", oUser);
        SetLocalInt(oUser, "dmfi_dicebag", n);

        string sText;
        if (n==0)
                {SetCustomToken(20681, "Private");
                 sText = "Private";
                 }
        else  if (n==1)
                {SetCustomToken(20681, "Global");
                sText = "Global";
                }
        else if (n==2)
                {SetCustomToken(20681, "Local");
                sText = "Local";
                }
        else if (n==3)
                {SetCustomToken(20681, "DM Only");
                sText = "DM Only";
                }
        SendMessageToPC(oUser, "Settings: Dicebag Reporting: "+sText);

        n = GetCampaignInt(sDMid, "dmfi_dice_no_animate", oUser);
        SetLocalInt(oUser, "dmfi_dice_no_animate", n);
        SendMessageToPC(oUser, "Settings: Roll Animations (1 is OFF): "+IntToString(n));

        float f = GetCampaignFloat(sDMid, "dmfi_reputaion", oUser);
        SetLocalFloat(oUser, "dmfi_reputation", f);
        SendMessageToPC(oUser, "Settings: Reputation Adjustment: "+FloatToString(f));

               f = GetCampaignFloat(sDMid, "dmfi_effectduration", oUser);
               SetLocalFloat(oUser, "dmfi_effectduration", f);
               SendMessageToPC(oUser, "Settings: Effect Duration: "+FloatToString(f));

               f = GetCampaignFloat(sDMid, "dmfi_sound_delay", oUser);
               SetLocalFloat(oUser, "dmfi_sound_delay", f);
               SendMessageToPC(oUser, "Settings: Sound Delay: "+FloatToString(f));

               f = GetCampaignFloat(sDMid, "dmfi_beamduration", oUser);
               SetLocalFloat(oUser, "dmfi_beamduration", f);
               SendMessageToPC(oUser, "Settings: Beam Duration: "+FloatToString(f));

               f = GetCampaignFloat(sDMid, "dmfi_stunduration", oUser);
               SetLocalFloat(oUser, "dmfi_stunduration", f);
               SendMessageToPC(oUser, "Settings: Stun Duration: "+FloatToString(f));

               f = GetCampaignFloat(sDMid, "dmfi_saveamount", oUser);
               SetLocalFloat(oUser, "dmfi_saveamount", f);
               SendMessageToPC(oUser, "Settings: Save Adjustment: "+FloatToString(f));

               f = GetCampaignFloat(sDMid, "dmfi_effectdelay", oUser);
               SetLocalFloat(oUser, "dmfi_effectdelay", f);
               SendMessageToPC(oUser, "Settings: Effect Delay: "+FloatToString(f));


        }
        else
        {
        FloatingTextStringOnCreature("Default Settings Initialized", oUser, FALSE);
        //Setting FOUR campaign variables so 1st use will be slow.
        //Recommend initializing your preferences with no players or
        //while there is NO fighting.
        SetLocalInt(oUser, "dmfi_initialized", 1);
        SetCampaignInt(sDMid, "Settings", 1, oUser);

        SetCustomToken(20781, "5");
        SetLocalInt(oUser, "dmfi_alignshift", 5);
        SetCampaignInt(sDMid, "dmfi_alignshift", 5, oUser);
        SendMessageToPC(oUser, "Settings: Alignment shift: 5");

        SetCustomToken(20783, "Single Target");
        SetLocalInt(oUser, "dmfi_buff_party", 0);
        SetCampaignInt(sDMid, "dmfi_buff_party", 0, oUser);
        SendMessageToPC(oUser, "Settings: Buff set to Single Target: ");

        SetCustomToken(20782, "Low");
        SetLocalString(oUser, "dmfi_buff_level", "LOW");
        SetCampaignString(sDMid, "dmfi_buff_level", "LOW", oUser);
        SendMessageToPC(oUser, "Settings: Buff Level set to LOW: ");

        SetLocalInt(oUser, "dmfi_dicebag", 0);
        SetCustomToken(20681, "Private");
        SetCampaignInt(sDMid, "dmfi_dicebag", 0, oUser);
        SendMessageToPC(oUser, "Settings: Dicebag Rolls set to PRIVATE");

        SetLocalInt(oUser, "", 0);
        SetCampaignInt(sDMid, "dmfi_safe_factions", 0, oUser);
        SendMessageToPC(oUser, "Settings: Factions set to BW base behavior");

        SetLocalFloat(oUser, "dmfi_reputation", 5.0);
        SetCustomToken(20784, "5");
        SetCampaignFloat(sDMid, "dmfi_reputation", 5.0, oUser);
        SendMessageToPC(oUser, "Settings: Reputation adjustment: 5");

        SetCampaignFloat(sDMid, "dmfi_effectduration", 60.0, oUser);
        SetLocalFloat(oUser, "dmfi_effectduration", 60.0);
        SetCampaignFloat(sDMid, "dmfi_sound_delay", 0.2, oUser);
        SetLocalFloat(oUser, "dmfi_sound_delay", 0.2);
        SetCampaignFloat(sDMid, "dmfi_beamduration", 5.0, oUser);
        SetLocalFloat(oUser, "dmfi_beamduration", 5.0);
        SetCampaignFloat(sDMid, "dmfi_stunduration", 1000.0,  oUser);
        SetLocalFloat(oUser, "dmfi_stunduration", 1000.0);
        SetCampaignFloat(sDMid, "dmfi_saveamount", 5.0, oUser);
        SetLocalFloat(oUser, "dmfi_saveamount", 5.0);
        SetCampaignFloat(sDMid, "dmfi_effectdelay", 1.0, oUser);
        SetLocalFloat(oUser, "dmfi_effectdelay", 1.0);

        SendMessageToPC(oUser, "Settings: Effect Duration: 60.0");
        SendMessageToPC(oUser, "Settings: Effect Delay: 1.0");
        SendMessageToPC(oUser, "Settings: Beam Duration: 5.0");
        SendMessageToPC(oUser, "Settings: Stun Duration: 1000.0");
        SendMessageToPC(oUser, "Settings: Sound Delay: 0.2");
        SendMessageToPC(oUser, "Settings: Save Adjustment: 5.0");

     }

    }


SetLocalLocation(oUser, "dmfi_univ_location", lLocation);
SetLocalObject(oUser,"dmfi_univ_target",oOther);
SetLocalString(oUser,"dmfi_univ_conv","onering");


object oTarget = GetLocalObject(oUser, "dmfi_univ_target");
int iGettype =  GetObjectType(oTarget);
int iMonsterCheck = GetLocalInt(oTarget,"Monstercheck");
if(iGettype==OBJECT_TYPE_CREATURE && !GetIsPC(oTarget) && iMonsterCheck !=1)
{
int iAppearance =GetAppearanceType(oTarget);
string sModel =Get2DAString("appearance","MODELTYPE",iAppearance);
string sTail =Get2DAString("apptail","TAILNumber",iAppearance);
int iTail = StringToInt(sTail);
int iO_tail =GetCreatureTailType(oTarget);


///to give all creature DM power when you posses them
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);
itemproperty ip_dmfeat = ItemPropertyBonusFeat(43);
itemproperty ip_DmSpeak = ItemPropertyBonusFeat(44);

if(oCheck!=OBJECT_INVALID)
{
AddItemProperty(DURATION_TYPE_PERMANENT,ip_dmfeat,oCheck);
AddItemProperty(DURATION_TYPE_PERMANENT,ip_DmSpeak,oCheck);
}

if(oCheck==OBJECT_INVALID)
{
  CreateItemOnObject("dmfi_onering", oTarget);
  object oHide2=GetObjectByTag("dmfi_onering");
  AssignCommand(oTarget, ActionEquipItem(oHide2, INVENTORY_SLOT_CARMOUR));

}
///to give all creature DM power /when you posses them

//setting the tail this creature going to use for scaling by the DM
SetLocalInt(oTarget,"OriginTail",iTail);

//if there no tail support for this creature
if(sTail == "****")
{
SetLocalInt(oTarget,"OriginTail",-1);
}
//Trog need custom scale
if(iAppearance == 451 || iAppearance == 452 || iAppearance == 453)
{
SetLocalInt(oTarget,"CustomScale",11);
}

//So Dm can reset creature to original appearance and tail quickly.
SetLocalInt(oTarget,"O_App",iAppearance);
SetLocalInt(oTarget,"O_tail",iO_tail);
SetLocalInt(oTarget,"Monstercheck",1);
//SendMessageToPC(oUser,"DEBUG");
}
// give the DM the skin piece if he/she missing it
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oUser);
if(oCheck2==OBJECT_INVALID) HorseAddHorseMenu(oUser);
// give the DM the skin piece if he/she missing it


DeleteLocalInt(oUser, "sh_dm_univ_int");
AssignCommand(oUser, ClearAllActions());
AssignCommand(oUser, ActionStartConversation(OBJECT_SELF, "sh_dmt_area", TRUE, FALSE)); // former Shaman's version, it has been changed on 2014_03_22
// BeginConversation("sh_dmt_area", OBJECT_SELF); // added on 2014_03_22

}

