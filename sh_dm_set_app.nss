//set the apperance of the creature / pc
#include "sh_classes_inc_e"
object oPCspeaker = GetPCSpeaker();
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
string sDMSetnumber=IntToString(iDMSetNumber);
object oSoul = GetSoulStone(oTarget);
void main()
{
SetCreatureAppearanceType(oTarget,iDMSetNumber);
SetLocalInt(oSoul,"SUBRACE_APPEARANCE",iDMSetNumber);
int iAppearance =GetAppearanceType(oTarget);
string sModel =Get2DAString("appearance","MODELTYPE",iAppearance);
string sTail =Get2DAString("apptail","TAILNumber",iAppearance);
int iTail = StringToInt(sTail);
int iO_tail =GetCreatureTailType(oTarget);

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
}
