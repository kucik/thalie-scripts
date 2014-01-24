/*
    TC-DS (Thalia Craft - Drog System)

    zavislost na drogach a chut na drogu se ukladaji do promenych na soustounu

    Melvik 3.4.2008
*/

#include "sh_classes_inc_e"

float DS_DROG_STRENGHT = 50.0;
int   DS_TYPE_ZAVISLOST = 0;
int   DS_TYPE_ABSTAK    = 1;
int   DS_MAX_ZAVISLOST = 1000;
int   DS_MAX_ABSTAK = 1000;

// snezeni drogy
//    iDrogStrPercent - sila drogy 0 - 100 procent
void ds_applyDrog(int iDrogStrPercent, object oPC);

// heart beat fce na operace s promenyma zavislosti Drog Systemu
void ds_doHB(object oPC);

// vrati promenou ds systemu
// dsType:
//   DS_TYPE_ZAVISLOST
//   DS_TYPE_ABSTAK
int  ds_get(object oPC, int dsType);

// nastavi promenou ds systemu
// dsType:
//   DS_TYPE_ZAVISLOST
//   DS_TYPE_ABSTAK
void ds_set(object oPC, int dsType, int iValue);

// efekty pri 100 procentech abstaku
void ds_criticalEff(object oPC);

// stredni efekty  abstaku
void ds_moderateEff(object oPC);

// lehke efekty abstaku
void ds_softEff(object oPC);



// snezeni drogy,
void ds_applyDrog(int iDrogStrPercent, object oPC)
{
    // zjisteni narustu zavislosti
    float increment = (IntToFloat(iDrogStrPercent)/100.0)*DS_DROG_STRENGHT;

    // zvyseni zavislosti
    int iZavislost = ds_get( oPC, DS_TYPE_ZAVISLOST);
    if(iZavislost > DS_MAX_ZAVISLOST) iZavislost = DS_MAX_ZAVISLOST;
    ds_set( oPC,  DS_TYPE_ZAVISLOST, iZavislost + FloatToInt(increment));
    // vynulovani abstaku
    ds_set( oPC,  DS_TYPE_ABSTAK, 0);
}

// jednou za cca 10 min
// pri zavislosti 1000 bodu abstak z 0 na 1000 za cca 100 min
// pri zavislosti 500  bodu abstak z 0 na 1000 za cca 200 min
// pri zavislosti 200  bodu abstak z 0 na 1000 za cca 500 min
void ds_doHB(object oPC)
{
    //   0 - 1000 bodu
    int iZavislost = ds_get( oPC, DS_TYPE_ZAVISLOST);
    //   0 - 1000 bodu
    int iAbstak = ds_get( oPC, DS_TYPE_ABSTAK);


    // pri hb se snizi iZavislost
    iZavislost -= 5;
    if (iZavislost < 0) iZavislost = 0;
    ds_set( oPC,  DS_TYPE_ZAVISLOST, iZavislost);


    // a zvysi se abstak a ulozi
    iAbstak += iZavislost/10;
    if (iAbstak > DS_MAX_ABSTAK) iAbstak = DS_MAX_ABSTAK;

    // snizeni abstaku pokud je zavislost 0
 //odkomentovat po testu   if ((iZavislost == 0)&&( iAbstak != 0)) iAbstak = 0;

    ds_set( oPC,  DS_TYPE_ABSTAK, iAbstak);

    //SendMessageToPC(oPC, "Drogovej HB");
    // a dem na nasledky abstaku
    int iAbstakProcent =(iAbstak / DS_MAX_ABSTAK)*100 ;

    /* nasledky abstaku */
    // 100 procent abstaku
    if ( iAbstakProcent == 100 )
    {

        ds_criticalEff(oPC);
    }
    // 80 - 99 procent abstaku
    else if (iAbstakProcent > 79)
    {
        ds_moderateEff(oPC);
    }
    // 50 - 79 procent abstaku
    else if (iAbstakProcent > 49)
    {
        ds_softEff(oPC);
    }
}
// vrati promenou ds systemu
// dsType:
//   DS_TYPE_ZAVISLOST
//   DS_TYPE_ABSTAK
int  ds_get(object oPC, int dsType)
{
  object oSoulStone = GetSoulStone(oPC);
  if (oSoulStone!=OBJECT_INVALID)
  {
    return GetLocalInt(oSoulStone, "ds_systemVar" + IntToString(dsType));
  }
  return 0;
}

// nastavi promenou ds systemu
// dsType:
//   DS_TYPE_ZAVISLOST
//   DS_TYPE_ABSTAK
void ds_set(object oPC, int dsType, int iValue)
{
  object oSoulStone = GetSoulStone(oPC);
  if (oSoulStone!=OBJECT_INVALID)
  {
    SetLocalInt(oSoulStone, "ds_systemVar" + IntToString(dsType),iValue);
  }
}


// efekty pri 100 procentech abstaku
void ds_criticalEff(object oPC)
{
    // 70 procentni sance na nejaky efekt
    if (d10() < 11)
    {
        switch (Random(1))
        {

            case 0:
            {
                SendMessageToPC(oPC, "*Boli te cele telo, nemuzes se hybat. Jestli nesezenes drogy, jiste zemres*");
                ClearAllActions(TRUE);
                DelayCommand(0.1,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 15.0)));
                DelayCommand(0.5,SetCommandable(FALSE,oPC));
                //SetCommandable(FALSE,oPC);
                //DelayCommand(1.9,SetCommandable(TRUE,oPC));
                //DelayCommand(2.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 15.0)));
                //DelayCommand(2.1,SetCommandable(FALSE,oPC));
                //DelayCommand(1.0,SetCommandable(FALSE,oPC));
                DelayCommand(16.0,SetCommandable(TRUE,oPC));
                break;
            }
        }
    }
}

// stredni efekty  abstaku
void ds_moderateEff(object oPC)
{
    // 50 procent sance na nejaky efekt
    if (d10() < 6)
    {
        switch (Random(2))
        {

            case 0:
            {
                SendMessageToPC(oPC, "*Zatocila se ti hlava, spadls a myslis jen uziti neceho omamneho*");

                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 0.5, 3.0));
                DelayCommand(1.0,SetCommandable(FALSE,oPC));
                DelayCommand(4.0,SetCommandable(TRUE,oPC));
                break;
            }
            case 1:
            {
                SendMessageToPC(oPC, "*Pokud nemas drogy, musis nejake ziskat jinak ti pukne hlava*");

                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 0.5, 3.0));
                DelayCommand(1.0,SetCommandable(FALSE,oPC));
                DelayCommand(4.0,SetCommandable(TRUE,oPC));
                break;
            }
        }
    }
}

// lehke efekty abstaku
void ds_softEff(object oPC)
{
    // 30 procentni sance na nejaky efekt
    if (d10() < 4)
    {
        switch (Random(2))
        {

            case 0:
            {
                SendMessageToPC(oPC, "Neco by sis slehnul..");
                break;
            }
            case 1:
            {
                SendMessageToPC(oPC, "Jestli mam v batohu povzbuzovadlo, tak je prave cas si ho dat..");
                break;
            }
        }
    }
}


