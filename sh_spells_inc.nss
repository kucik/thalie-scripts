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
    int iBonus = 0;
    //Epic DC bonus - +1 za kazde 2 lvly nad epic
    int iClass = GetLastSpellCastClass();
    switch(iClass) {
      case CLASS_TYPE_SORCERER:
      case CLASS_TYPE_WIZARD:
      case CLASS_TYPE_CLERIC:
      case CLASS_TYPE_DRUID:
      case CLASS_TYPE_BARD:
        if(GetLevelByClass(iClass,oPCNPC) >= 21)
          iBonus += (GetLevelByClass(iClass,oPCNPC)-19)/2;
        break;
      default: //nothing
        break;
    }


    return iBonus;
}
// nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel);
//+GetThalieSpellDCBonus(OBJECT_SELF)
// nCasterLevel = GetThalieCaster(OBJECT_SELF,oTarget,nCasterLevel,FALSE);
