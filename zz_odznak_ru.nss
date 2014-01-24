//::///////////////////////////////////////////////
//:: FileName zz_odznak_ru
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 15.3.2009 19:12:10
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Ujistit se, že postava má v inventáøi tyto pøedmìty
	if(!HasItem(GetPCSpeaker(), "od_kar_ru"))
		return FALSE;

	return TRUE;
}
