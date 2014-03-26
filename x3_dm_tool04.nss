//::///////////////////////////////////////////////
//:: DM Tool 3 Instant Feat
//:: x3_dm_tool03
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 DM instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////
#include "x3_inc_horse"
void main()
{
    object oUser = OBJECT_SELF;
    //SendMessageToPC(oUser, "DM Tool 03 activated.");

string sDMid = "DM_"+GetName(oUser)+"_"+GetPCPlayerName(oUser);
object oOther = GetLocalObject(oUser, "dmfi_target");
if (!GetIsObjectValid(oOther))oOther=GetSpellTargetObject();
location lLocation=GetLocalLocation(oUser, "dmfi_location");
if (!GetIsObjectValid(GetAreaFromLocation(lLocation))) lLocation = GetSpellTargetLocation();

SetLocalLocation(oUser, "dmfi_Lang_location", lLocation);
SetLocalObject(oUser,"dmfi_Lang_target",oOther);


object oTarget = GetLocalObject(oUser, "dmfi_Lang_target");
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





//if(!IsInConversation(oUser)) AssignCommand(oUser, ActionStartConversation(oUser, "Languages", TRUE, FALSE));
AssignCommand(oUser, ActionStartConversation(oUser, "sh_languages", TRUE, FALSE)); // former Shaman's version, it has been changed on 2014_03_22
//BeginConversation("sh_languages", OBJECT_SELF); // added on 2014_03_22
}
