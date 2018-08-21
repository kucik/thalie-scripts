#include "sh_classes_inc"
#include "sh_lang_const"
void AddLanguage(object oPC,int iLang,int iNum = 1)
{

    object oPCtool = GetSoulStone(oPC);
    switch(iLang)
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


void AddLanguagesOnClientEnter(object oPC)
{
    int i;
    for (i=0;i<22;i++)
    {
        AddLanguage(oPC,i,0);
    }
    object oSoul = GetSoulStone(oPC);
    AddLanguage(oPC,LANGUAGE_COMMON);
    int iSubrace = Subraces_GetCharacterSubrace(oPC);
       switch (iSubrace)
        {

             case NT2_SUBRACE_ELF_NONE:
             AddLanguage(oPC,LANGUAGE_ELVEN);
             break;

             case NT2_SUBRACE_ELF_WINGED:
             AddLanguage(oPC,LANGUAGE_ELVEN);
             break;

             case NT2_SUBRACE_ELF_DROW:
             AddLanguage(oPC,LANGUAGE_UNDERCOMMON);
             break;

             case NT2_SUBRACE_DWARF_NONE:
             AddLanguage(oPC,LANGUAGE_DWARVEN);
             break;

             case NT2_SUBRACE_DWARF_DUERGAR:
             AddLanguage(oPC,LANGUAGE_GOBLIN);
             break;

             case NT2_SUBRACE_ORC_NONE:
             AddLanguage(oPC,LANGUAGE_ORC);
             break;

             case NT2_SUBRACE_ORC_DEEP:
             AddLanguage(oPC,LANGUAGE_GIANT);
             break;

             case NT2_SUBRACE_ORC_HIRAN:
             AddLanguage(oPC,LANGUAGE_GIANT);
             break;

             case NT2_SUBRACE_GNOME_NONE:
             AddLanguage(oPC,LANGUAGE_GNOME);
             break;

             case NT2_SUBRACE_GNOME_SWIRFNEBLIN:
             AddLanguage(oPC,LANGUAGE_IGNAN);
             break;

             case NT2_SUBRACE_GNOME_GOBLIN_DEEP:
             AddLanguage(oPC,LANGUAGE_GIANT);
             break;

             case NT2_SUBRACE_GNOME_PIXIE:
             AddLanguage(oPC,LANGUAGE_ELVEN);
             break;

             case NT2_SUBRACE_HALFELF:
             AddLanguage(oPC,LANGUAGE_ELVEN);
             break;

    }
    //AddLanguage(oPC,LANGUAGE_DRUIDIC,0);
    int iLevelDruidic = GetLevelByClass(CLASS_TYPE_DRUID,oPC)+GetLevelByClass(CLASS_TYPE_RANGER,oPC);
    if (iLevelDruidic)
    {
        AddLanguage(oPC,LANGUAGE_DRUIDIC);
    }
    SetLocalInt(oSoul,"Language",LANGUAGE_COMMON);
    /*if (Subraces_GetIsCharacterFromUnderdark(oPC))
    {
        SetLocalInt(oSoul,"Language",LANGUAGE_INFERNAL);
    }
    else
    {
        SetLocalInt(oSoul,"Language",LANGUAGE_COMMON);
    }  */

}
