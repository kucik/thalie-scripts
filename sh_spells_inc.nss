#include "sh_classes_const"
/*Nastavit bChange CL na FALSE, pokud nechceme omezovat podle caster level targetu*/
int GetThalieCaster(object oCaster,object oTarget,int iCasterLevel,int bChangeCL = TRUE,string params = "")
{
    int iModifiedCasterLevel =iCasterLevel;
    if (GetLevelByClass(CLASS_TYPE_EXORCISTA,oCaster)>0)
    {
         iModifiedCasterLevel+= GetLevelByClass(CLASS_TYPE_EXORCISTA,oCaster);
    }

    /* For boost spells always reduce caster level. Cannot be higher than caster 
       level*/
    if (bChangeCL)
    {
         int iHD = GetHitDice(oTarget);
         if (iModifiedCasterLevel>iHD) iModifiedCasterLevel=iHD;
    }

    return iModifiedCasterLevel;
}


int GetThalieSpellDCBonus(object oPCNPC)
{
    return 0;
}
// nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel);
//+GetThalieSpellDCBonus(OBJECT_SELF)
// nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel,FALSE);
