#include "subraces"
#include "sh_classes_inc"
// melvik upava na novy zpusob nacitani soulstone 16.5.2009


/*
    -povoli lvlup jedine ak hrac prehovoril s majstrom a ten mu to povolil
     prestup na dalsi lvl
    -pricom script potom testuje ci hrac nepodvadza (nedava si nasetrene body
     do statistik a ci nekombinuje zakazane povolania)

*/
void sy_relevel_retxp(object oPC, int nXpNow) {

 SetXP(oPC,nXpNow);
 DeleteLocalInt(oPC,"RELEVELING");

}

void sy_relevel(object oPC, int nLevel)
{
    //znizim mu XP na hranicu predosleho lvl a nasledne vratim povodne XP spet
    //tym sa zaruci relevel
    nLevel--;
    int nXP    = ((nLevel * (nLevel - 1)) / 2) * 5000;
    int nXpNow = GetXP(oPC);
    // mark to disable raising now
    SetLocalInt(oPC,"RELEVELING",TRUE);
    SetXP(oPC,nXP);

    DelayCommand(2.0f, sy_relevel_retxp(oPC,nXpNow));
}




//==============================================================================

void main()
{
    //ziskam hraca a jeho level

    object oPC  = GetPCLevellingUp();
    object oSoulStone = GetSoulStone(oPC);    //by jaara
    int nLevel  = GetHitDice(oPC);
    object oTrainer = GetLocalObject(oPC, "JA_LVL_TRAINER");
    if (nLevel <= 2)
    {
        return; //do lvlu 2 nemusi mit mistra -- Shaman
    }



    int oldClass = GetLocalInt(oSoulStone, "JA_LAST_CLASS");       //mohl umrit..
    int oldLevel = GetLocalInt(oSoulStone, "JA_LAST_LVL");

    //ziskam nejake potrebne premenne
    int nClass1 = GetClassByPosition(1, oPC);
    int nClass2 = GetClassByPosition(2, oPC);
    int nClass3 = GetClassByPosition(3, oPC);

    int iPaladinLevel = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
    if (iPaladinLevel >0)
    {
        if ((GetHitDice(oPC)-iPaladinLevel+10)>30)
        {
            SendMessageToPC(oPC, "</c>Pokud hrajes paladina, musis mit 10 urovni.</c>");
            sy_relevel(oPC, nLevel);
            return;
        }
    }
    int iMonkLevel = GetLevelByClass(CLASS_TYPE_MONK,oPC);
    if (iMonkLevel >0)
    {
        if ((GetHitDice(oPC)-iMonkLevel+10)>30)
        {
            SendMessageToPC(oPC, "</c>Pokud hrajes mnicha, musis mit 10 urovni.</c>");
            sy_relevel(oPC, nLevel);
            return;
        }
    }
    // Because of rage ability bonus
    if(GetLocalInt(oSoulStone,"rage") > 0) { // AKTIVNI_RAGE
      SendMessageToPC(oPC, "Nemuzes provadet lvlup s aktivni zurivosti!");
      sy_relevel(oPC, nLevel);
      return;
    }
    if (GetLocalInt(oSoulStone,"postoj") != 0) { //AKTIVNI_POSTOJ_OBRANCE
      SendMessageToPC(oPC, "Nemuzes provadet lvlup s aktivnim postojem obrance!");
      sy_relevel(oPC, nLevel);
      return;
    }


    OnLvlupClassSystem(oPC);
    Subraces_LevelUpSubrace( oPC ); // uprava vlastnosti subrasy zavislych na levelu

}

