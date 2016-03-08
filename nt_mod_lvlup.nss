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

    // Zkontrolovat a dopocitat skillpointy
    KU_CalcAndGiveSkillPoints(oPC);

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
    int iLevel2UP = GetLocalInt(oSoulStone, "SH_LVL2_UP1");
    if (nLevel <= 2)
    {
        if (iLevel2UP ==0)
        {
            SendMessageToPC(oPC, "</c>Systemovy relevel - nutno prodelat.</c>");
            sy_relevel(oPC, nLevel);
            SetLocalInt(oSoulStone, "SH_LVL2_UP1",1);
            return;
        }
        else
        {

            return; //do lvlu 2 nemusi mit mistra -- Shaman
        }
    }



    int oldClass = GetLocalInt(oSoulStone, "JA_LAST_CLASS");       //mohl umrit..
    int oldLevel = GetLocalInt(oSoulStone, "JA_LAST_LVL");

    //ziskam nejake potrebne premenne
    int nClass2 = GetClassByPosition(2, oPC);
    int nClass3 = GetClassByPosition(3, oPC);

    int classPos = 0;
    if(nClass2 == oldClass)
      classPos = 2;
    else if(nClass3 == oldClass)
      classPos = 3;


    if(classPos != 0 && GetLevelByPosition(classPos, oPC) == oldLevel){
    if( (GetLevelByPosition(2, oPC) <= GetLocalInt(oSoulStone, "KU_LAST_LVL2") ) &&
        (GetLevelByPosition(3, oPC) <= GetLocalInt(oSoulStone, "KU_LAST_LVL3") ) &&
        (nClass2 == GetLocalInt(oSoulStone, "KU_LAST_CLASS2") )                  &&
        (nClass3 == GetLocalInt(oSoulStone, "KU_LAST_CLASS3") )                  ) {
        SendMessageToPC(oPC, "Protoze jsi umrel, je ti povoleno znovu nahazet level zadarmo a bez ucitele");
        return; //udelal znovu lvl
    }
    }

    //ak trener nepovolil trenink alebo nastal pad serveru a hrac ma tu premennu
    //nastavenu na 0, tak vypisem chybovu hlasku
    if (GetLocalInt(oPC, "sy_allowlvl")==0)
    {
        SendMessageToPC(oPC, "</c>Pokud se chces neco noveho naucit, mel/a bys vyhledat vhodneho trenera.</c>");
        sy_relevel(oPC, nLevel);
        return;
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

    int nLvl2       = GetLevelByPosition(2, oPC);
    int nLvl3       = GetLevelByPosition(3, oPC);
    int oldClass2Lvl = GetLocalInt(oPC, "sy_class2_lvl");            //lvl pociatocne povolanie
    int misterClass = GetLocalInt(oPC, "sy_class_mistra");            //typ - povolanie majstra
    int class;
    if (oldClass2Lvl == nLvl2)                               //zistim ktore povolanie ziskalo lvl
        class = 3;            //2. zustalo stejne, muselo tedy povysit 3.
        else
        class =2;

    if (GetClassByPosition(class, oPC) != misterClass)    //porovna majstrovo a hracove pridane povolanie
    {
        AssignCommand(oTrainer,SpeakString("Tomuhle povolani te nemohu naucit. Na to si najdi jineho ucitele a me nezdrzuj..."));
        sy_relevel(oPC, nLevel);
        return;
    }

    //6. test vysky skilov
    int nSkill, nSkillPC, nLoop;
    for (nLoop=0;nLoop<27;nLoop++)
    {
        //zadefinujem retazec hladanej premennej na hracovy o vyske skilu
        //zistim aktualnu vysku skilu a porovnam s tou pred levelom
        nSkill = GetSkillRank(nLoop, oPC, TRUE);
        nSkillPC = GetLocalInt(oPC, "sy_skill"+IntToString(nLoop));

        //ak je rozdiel vacsi ako 1 bod, tak hrac podvadza a da sa relevel
        //if ((nSkill-nSkillPC)>1)   //by jaara
        if ((nSkill-nSkillPC)>3)
        {
           AssignCommand(oTrainer,SpeakString("Pri kazdem treninku mohu zlepsit tve dovednosti maximalne o tri stupne."));
           sy_relevel(oPC, nLevel);
           return;
        }
    }

    //zistim ci ma hrac potrebne peniaze na lvlup
    //musim to testovat tu az ked uspesne potvrdi level, az tak sa odcitaju
    //zlataky, tak som rozhodol
    int nLvlCost = GetLocalInt(oPC, "sy_gp_cost");
    if (GetGold(oPC)<nLvlCost)
    {
        AssignCommand(oTrainer,SpeakString("Ty nemas "+IntToString(nLvlCost)+" zlatych?! To je moje cena. Dokud nebudes mit na zaplaceni, tak te nic noveho nenaucim!"));
        sy_relevel(oPC, nLevel);
        return;
    }
    AssignCommand(oTrainer, TakeGoldFromCreature(nLvlCost, oPC, TRUE));

    //zmazem docasne premenne na hracovi
    DeleteLocalInt(oPC, "sy_class_mistra");
    DeleteLocalInt(oPC, "sy_class2_lvl");
    DeleteLocalInt(oPC, "sy_gp_cost");
    DeleteLocalInt(oPC, "sy_allowlvl");
    for (nLoop = 0;nLoop<27;nLoop++) DeleteLocalInt(oPC, "sy_skill"+IntToString(nLoop));

    //uspesna sprava ked hrac naklika level
    AssignCommand(oTrainer,SpeakString("Blahopreji ti! Byl/a jsi skvelym zakem. Naucil/a ses vse, co bylo potreba, ani jsem to nemusel opakovat. Muzes jit, az naberes dostatek zkusenosti na dalsi trenink, tak vis, kde me najdes. Mej se!"));

    SetLocalInt(oSoulStone, "JA_LAST_CLASS", misterClass);       //by jaara
    SetLocalInt(oSoulStone, "JA_LAST_LVL", GetLevelByPosition(class, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_LVL2", GetLevelByPosition(2, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_LVL3", GetLevelByPosition(3, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_CLASS2", GetClassByPosition(2, oPC));
    SetLocalInt(oSoulStone, "KU_LAST_CLASS3", GetClassByPosition(3, oPC));
    OnLvlupClassSystem(oPC);
    Subraces_LevelUpSubrace( oPC ); // uprava vlastnosti subrasy zavislych na levelu

}

