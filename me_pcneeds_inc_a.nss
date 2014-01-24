#include "x2_inc_switches"

//------------------------------------------------------------------------------
//! Drunk Effect - Laughing for 10 secs
//!
//------------------------------------------------------------------------------
void DrunkenFoolOne(object oPC)
{
    AssignCommand(oPC,ClearAllActions());

    if (GetGender(oPC) == GENDER_MALE)
        AssignCommand(oPC,PlaySound("as_pl_laughingm2"));
    else
        AssignCommand(oPC,PlaySound("as_pl_laughingf2"));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10.0));

    DelayCommand(1.5,SetCommandable(FALSE,oPC));
    DelayCommand(11.0,SetCommandable(TRUE,oPC));
}

//------------------------------------------------------------------------------
//! Drunk Effect - Belching
//!
//------------------------------------------------------------------------------
void DrunkenFoolTwo(object oPC)
{
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,PlaySound("as_pl_belchingm2"));
}

//------------------------------------------------------------------------------
//! Drunk Effect - Hiccupping
//!
//------------------------------------------------------------------------------
void DrunkenFoolThree(object oPC)
{
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,PlaySound("as_pl_hiccupm1"));
}

//------------------------------------------------------------------------------
//! Drunk Effect - Take off clothes then "dance" - spasm
//!
//------------------------------------------------------------------------------
void DrunkenFoolFour(object oPC)
{
    object oItem1 = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    object oItem2 = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    object oItem3 = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oItem4 = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionUnequipItem(oItem1));
    AssignCommand(oPC,ActionUnequipItem(oItem2));
    AssignCommand(oPC,ActionUnequipItem(oItem3));
    AssignCommand(oPC,ActionUnequipItem(oItem4));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 5.0));
    DelayCommand(1.0,AssignCommand(oPC,SpeakString("Tanec!!! Jooo, tancime!!!")));
    DelayCommand(2.0,SetCommandable(FALSE,oPC));
    DelayCommand(7.0,SetCommandable(TRUE,oPC));
}
//------------------------------------------------------------------------------
//! Drunk Effects - Spell users will conjure (animation only) - then fall over backwards
//! non-spell classes will duck and weave for awhile
//------------------------------------------------------------------------------
void DrunkenFoolFive(object oPC)
{
    AssignCommand(oPC,ClearAllActions());
    if (GetLevelByClass(CLASS_TYPE_WIZARD,oPC)||
        GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC)||
        GetLevelByClass(CLASS_TYPE_BARD,oPC)||
        GetLevelByClass(CLASS_TYPE_DRUID,oPC)||
        GetLevelByClass(CLASS_TYPE_RANGER,oPC)||
        GetLevelByClass(CLASS_TYPE_SORCERER,oPC)||
        GetLevelByClass(CLASS_TYPE_PALADIN,oPC) ||
        GetLevelByClass(CLASS_TYPE_CLERIC,oPC))
    {
    if (GetGender(oPC) == GENDER_MALE)
        AssignCommand(oPC,PlaySound("vs_chant_evoc_lm"));
    else
        AssignCommand(oPC,PlaySound("vs_chant_evoc_lf"));
        DelayCommand(0.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 2.0)));
        DelayCommand(1.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0)));
        DelayCommand(2.5,SetCommandable(FALSE,oPC));
        DelayCommand(8.0,SetCommandable(TRUE,oPC));
    }

    else
    {
        AssignCommand(oPC, SpeakString ("Pojd sem, skus me trefit. No tak, pojd."));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK));
        DelayCommand(1.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE)));
        DelayCommand(2.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)));
        DelayCommand(3.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK)));
        DelayCommand(4.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE)));
        DelayCommand(5.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK)));
        DelayCommand(6.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE)));
        DelayCommand(7.5,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)));
    }
}
//------------------------------------------------------------------------------
//! Drunk Effects - Cleric/Paladin pray - Monks Meditate - All others cheer
//!
//------------------------------------------------------------------------------
void DrunkenFoolSix(object oPC)
{
    AssignCommand(oPC,ClearAllActions());
    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC)||
        GetLevelByClass(CLASS_TYPE_PALADIN,oPC))
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,5.0));
        AssignCommand(oPC, SpeakString("Muj boze odpust svemu sluzebnikovi jeho slabost. ALE KDYZ ONO TO JE TAK DOBRE!"));
        DelayCommand(2.0,SetCommandable(FALSE,oPC));
        DelayCommand(8.0,SetCommandable(TRUE,oPC));
    }

    else if (GetLevelByClass(CLASS_TYPE_MONK,oPC))
    {
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,5.0));
        AssignCommand(oPC, SpeakString("Cesta k vnitrni rovnovaze nevede pres CHLAST! Ooo jee jsem jak vejce *klimbe ze strany na stranu*."));
        DelayCommand(2.0,SetCommandable(FALSE,oPC));
        DelayCommand(8.0,SetCommandable(TRUE,oPC));
    }
    else
    {
       AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));
       DelayCommand(1.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2)));
       DelayCommand(2.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3)));
       DelayCommand(3.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2)));
       DelayCommand(4.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3)));
       DelayCommand(5.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1)));
       DelayCommand(6.0,AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)));
    }
}
//------------------------------------------------------------------------------
//! Drunk Effect - Go to the nearest living creature and declare undying love for them
//!
//------------------------------------------------------------------------------
void DrunkenFoolSeven(object oPC)
{
    object oLover = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oPC,d4());

    AssignCommand (oPC,ClearAllActions());
    AssignCommand(oPC,ActionMoveToObject(oLover,TRUE,0.5));
    switch (Random(24))
    {

        case 1:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Pokladam se pave a lojolalni srdce do tvych rukoou ")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }

        case 2:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Kde tu maj zachod?")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 3:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Rekni a pobliju se s drakem, abych te ziskal")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 4:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("*skyt* Jeste bych si dal.")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 5:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Ehm, kdo to zaplati...")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 6:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Kde to sem? *skyt*")));
            DelayCommand(3.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 7:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Jeste chvili budes cucet *skyt* a uvidis!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 8:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Heh, mit tvuj ksicht, tak radsi zustanu doma...")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 0:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Proc na me vsichni furt cumi?!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 9:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Hlad je prevlecena zizen. Hahaha.")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 10:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("To se mi libi.")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 11:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Proc mi nikdo nema rad?!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 12:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Zase blbej den jako dycky.")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 13:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Snad neco vydrzim. *skyt*")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 14:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Na to se napijem!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 15:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Dej bozicku stesticka a mne palenky trosicka!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 16:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Zase mi dali do toho korbelu diru.")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 17:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Noc je jeste mlada!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 18:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Poradne to roztocime!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 19:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Necum a chlastej!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 20:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("A prase se tociiiiii!")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 21:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Kdo si da se mnou?")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 22:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("Prece to tu nenechame...")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }

        case 23:
        {
            DelayCommand(3.0,AssignCommand(oPC,SpeakString("To je... Ehm... Teprve prvni...")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,1.0,5.0)));
            DelayCommand(1.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }     }
}


//------------------------------------------------------------------------------
//! Drunk Effect - Create Invisible placeable and make PC attack it
//!
//------------------------------------------------------------------------------
void DrunkenFoolEight(object oPC)
{
    object oArea = GetArea(oPC);
    vector vPC = GetPosition(oPC);
    float fSafePC =  GetFacing(oPC);

    // Where the placeable should be
    vector vFacingEnemy = AngleToVector(fSafePC);
    vFacingEnemy.x = vFacingEnemy.x * 2.0;
    vFacingEnemy.y = vFacingEnemy.y * 2.0;
    vector vEnemy = Vector((vPC.x+vFacingEnemy.x),(vPC.y+vFacingEnemy.y),0.0);
    location lEnemy = Location(oArea,vEnemy,fSafePC);

    object oEnemy = CreateObject(OBJECT_TYPE_PLACEABLE,"drink_inv_enemy",lEnemy);
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionAttack(oEnemy));
  //  AssignCommand(oPC,DetermineCombatRound());
    DelayCommand(2.0,SetCommandable(FALSE,oPC));
    DelayCommand(10.0,SetCommandable(TRUE,oPC));
    DelayCommand(10.0,AssignCommand(oPC,ClearAllActions()));
    DelayCommand(11.0,DestroyObject(oEnemy));


}
//------------------------------------------------------------------------------
//! Drunk Effect - Go to the nearest non-living object and declare undying love for
//! or threaten
//------------------------------------------------------------------------------
void DrunkenFoolNine(object oPC)
{
    object oLover = GetNearestObject(OBJECT_TYPE_ALL,oPC,d4());

    AssignCommand (oPC,ClearAllActions());
    AssignCommand(oPC,ActionMoveToObject(oLover,TRUE,0.5));


    switch (d8())
    {
        case 1:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Nebut takova lasko, dej mi pusu")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }

        case 2:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Bud pouze se mno, spolecne navzdy.")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 3:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Usekni me hlavu jestli lzu, ale jsi okouzlujici")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 4:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Je mi lito. Je mi opravdu lito. Je mi taaak strasne liito")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 5:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Rekni to znova a budu muset prolit tvou krev")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 6:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Chces dnes umrit?")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 7:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Chci si vychutnat srazeni tve hlavy")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
        case 8:
        {
            DelayCommand(2.0,AssignCommand(oPC,SpeakString("Hej ty , muzeme to vyresit venku")));
            DelayCommand(2.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.0,5.0)));
            DelayCommand(3.0,SetCommandable(FALSE,oPC));
            DelayCommand(5.0,SetCommandable(TRUE,oPC));
            break;
        }
    }
}
//------------------------------------------------------------------------------
//! Drunk Effect - Throwing Up
//!
//------------------------------------------------------------------------------
void DrunkenFoolTen(object oPC)
{

    object oArea = GetArea(oPC);
    vector vPC = GetPosition(oPC);
    float fSafePC =  GetFacing(oPC);

    // Where the vomit should be
    vector vFacingVomit = AngleToVector(fSafePC);
    vector vVomit = Vector((vPC.x+vFacingVomit.x),(vPC.y+vFacingVomit.y),0.0);
    location lVomit = Location(oArea,vVomit,fSafePC);

    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0,4.5));
    DelayCommand(1.0,AssignCommand(oPC,PlaySound("as_pl_hangoverf1")));
    DelayCommand(2.0,AssignCommand(oPC,PlaySound("as_an_sludggurg1")));
    DelayCommand(6.0,AssignCommand(oPC,ActionMoveAwayFromLocation(lVomit,FALSE,3.0)));

}


