#include    "sh_classes_inc_e"
object oPCspeaker = GetPCSpeaker();
string sDMstring = GetLocalString(oPCspeaker,"DMstring");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oPCtool = GetSoulStone(oTarget);
object oCheck = GetSoulStone(oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
int iNum;

void main()
{
if(GetIsPC(oTarget) && iDMSetNumber >=1)
{
iNum =1;
}

if(GetIsPC(oTarget) && iDMSetNumber <=-1)
{
iNum =0;
iDMSetNumber= -1*iDMSetNumber;
}
switch(iDMSetNumber)
    {
case 0:SetLocalInt(oPCtool,"L_COMMON",iNum);break;
case 1:SetLocalInt(oPCtool,"L_ABYSSAL",iNum);break;
case 2:SetLocalInt(oPCtool,"L_AQUAN",iNum);break;
case 3:SetLocalInt(oPCtool,"L_AURAN",iNum);break;
case 4:SetLocalInt(oPCtool,"L_CELESTIAL",iNum);break;
case 5:SetLocalInt(oPCtool,"L_DRACONIC",iNum);break;
case 6:SetLocalInt(oPCtool,"L_DRUIDIC",iNum);break;
case 7:SetLocalInt(oPCtool,"L_DWARVEN",iNum);break;
case 8:SetLocalInt(oPCtool,"L_ELVEN",iNum);break;
case 9:SetLocalInt(oPCtool,"L_GIANT",iNum);break;
case 10:SetLocalInt(oPCtool,"L_GNOME",iNum);break;
case 11:SetLocalInt(oPCtool,"L_GOBLIN",iNum);break;
case 12:SetLocalInt(oPCtool,"L_GNOLL",iNum);break;
case 13:SetLocalInt(oPCtool,"L_HALFLING",iNum);break;
case 14:SetLocalInt(oPCtool,"L_IGNAN",iNum);break;
case 15:SetLocalInt(oPCtool,"L_INFERNAL",iNum);break;
case 16:SetLocalInt(oPCtool,"L_ORC",iNum);break;
case 17:SetLocalInt(oPCtool,"L_SYLVAN",iNum);break;
case 18:SetLocalInt(oPCtool,"TERRAN",iNum);break;
case 19:SetLocalInt(oPCtool,"UNDERCOMMON",iNum);break;
}


}
