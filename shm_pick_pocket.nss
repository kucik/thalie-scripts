#include "nwnx_funcsext"
#include "ja_inc_frakce"

/*
Vypracoval Shaman88
Verze 2.11
*/
/*

TODO:
1) Upravit funkci IsGuard - radek 205
2) Upravit funkci SetGuardAction - radek 214
3) Upravit kontrolu zda je postava obycejny obcan - radek 289
*/

/*
KOMENTAR:
Pokud by se to ujalo chtel bych to jeste rozsirit a to tak ze by si zlodej mohl vybrat kolik chce ukrast.
A cim vyssi suma by to byla vzhledem k tomu kolik ma cil penez tim vetsi TO by mel hod 1.
+ novou schopnost - odhad zlata ktere ma cil u sebe.
*/


//---------------- Declare Public functions ----------------------


/**
 * Make pickpocket action.
 *
 * @param  rogue   Pickpocketing player
 * @param  target  Victim PC/NPC
 */
void shm_PickPocket(object rogue, object target);




// -------------- KONSTANTY ----------------------------------------------------
// minimalni mnozstvi zlata ktere musi mit postava u sebe aby ji slo okrast - v pripade ze nechcete minimum nastavte na 0
 const int MIN_GOLD = 100;
//DC1 pro neutralni target
const int CHECK1_NEUTRAL = 20;
//DC1 pro hostile target
const int CHECK1_HOSTILE = 30;

//postih k skillu okradani po pokusu o okradeni
const int PENALIZACE_OKRADANI = 10;
// doba trvani tohoto postihu v sekundach
const float PENALIZACE_OKRADANI_TRVANI = 3600.0;

/*
Nastaveni penalizace.
Vzdy prvni cislo je vzdalenost a druhe penalizace k DC na vsimavost.
PODMINKA: vzdalenosti se musi zvysovat. tzn. B musi byt vetsi nez A, C nez B atd...
Pokud jsou parametry -1.0 nebo -1, tak se dana kontrola neprovede
*/
const float SPOT_DISTANCE_A = 5.0;
const int SPOT_DISTANCE_A_PENALTY = 10;
const float SPOT_DISTANCE_B = -1.0;
const int SPOT_DISTANCE_B_PENALTY = -1;
const float SPOT_DISTANCE_C = -1.0;
const int SPOT_DISTANCE_C_PENALTY = -1;
const float SPOT_DISTANCE_D = -1.0;
const int SPOT_DISTANCE_D_PENALTY = -1;
const float SPOT_DISTANCE_E = -1.0;
const int SPOT_DISTANCE_E_PENALTY = -1;
const float SPOT_DISTANCE_F = -1.0;
const int SPOT_DISTANCE_F_PENALTY = -1;
const float SPOT_DISTANCE_G = -1.0;
const int SPOT_DISTANCE_G_PENALTY = -1;

// --------- IMPLEMENTACE  -  FUNKCE -------------------------------------------

/*
Vrati penalizaci na vsimavost.
*/
int GetSpotPenalty(float distance)
{
if ((SPOT_DISTANCE_A >= distance) && (SPOT_DISTANCE_A!=-1.0))
    {
    return SPOT_DISTANCE_A_PENALTY;
    }
if ((SPOT_DISTANCE_B >= distance) && (SPOT_DISTANCE_B!=-1.0))
    {
    return SPOT_DISTANCE_B_PENALTY;
    }
if ((SPOT_DISTANCE_C >= distance) && (SPOT_DISTANCE_C!=-1.0))
    {
    return SPOT_DISTANCE_C_PENALTY;
    }
if ((SPOT_DISTANCE_D >= distance) && (SPOT_DISTANCE_D!=-1.0))
    {
    return SPOT_DISTANCE_D_PENALTY;
    }
if ((SPOT_DISTANCE_E >= distance) && (SPOT_DISTANCE_E!=-1.0))
    {
    return SPOT_DISTANCE_E_PENALTY;
    }
if ((SPOT_DISTANCE_F >= distance) && (SPOT_DISTANCE_F!=-1.0))
    {
    return SPOT_DISTANCE_F_PENALTY;
    }
if ((SPOT_DISTANCE_G >= distance) && (SPOT_DISTANCE_G!=-1.0))
    {
    return SPOT_DISTANCE_G_PENALTY;
    }
return 0;
}
/*
Vraci hodnoty penalizace k DC na vsimavost podle toho v jakym smerem se diva pozorujici postava




*/
float GetAnglePenalty(object rogue,object pozorujici)
{
float pozorujici_facing = GetFacing(pozorujici);
vector rogue_v = GetPosition(rogue);
vector pozorujici_v = GetPosition(pozorujici);
//--- posunuti zlodeje do souradnic vuci pozorujicimu o souradnicich 0 0 0
vector rogue_v_posunute = rogue_v - pozorujici_v;
//--- zmena vectoru na uhel
float rogue_a = VectorToAngle( rogue_v_posunute);
//-- vypocitani odchylky pro tento uhel a uhel pohledu npc
float odchylka =fabs (pozorujici_facing - rogue_a);
/* prevede odchylku na uhel o 0 do 180 - dalsi 2 kvadranty nemaji smysl protoze
je jedno jestli je odchlka z prave nebo leve strany
*/
if (odchylka > 180.0)  odchylka = 360.0 - odchylka;
//vrati 1 kdyz cil je celem k okradani, a cim dale tim je vyssi az kdyz jej nevidi ta vrati 2
return (odchylka/180.0)+1;
}

/*
Vraci DC prvniho hodu - tzn. jestli se povede okradani
-- object rogue - object okradajiciho
-- object target - cil okradnuti
*/
int GetPickPocketCheck1DC(object rogue,object target)
{
int check1DC;
if (GetReputation(rogue,target)<=10)
    {
    check1DC =CHECK1_HOSTILE;
    }
else
    {
    check1DC =CHECK1_NEUTRAL;
    }
return check1DC;
}

/*
Vrati hodnotu goldu ktere zlodej cili ukrade.
-- object rogue - object okradajiciho
-- object target - cil okradnuti
Funkce zpocita lvl v povolanich ktere maji skill okradani jako dovednost povolani
Nasledne podle lvlu vypocita kolik postava muze ukrast.
Pote provede random teto hodnoty.
A nakonec tuto hodnotu porovna s penezma cile, a pokud tolik nema tak se maximum nastavi na to kolik ma.
*/
int GetPickPocketGold(object rogue,object target)
{
int gold;
int rogue_pick_pocket = GetSkillRank(SKILL_PICK_POCKET,rogue);
// Secte lvl vsech class ktere maji skill okradani jako hlavni
int pick_pocket_level = GetLevelByClass(CLASS_TYPE_ROGUE,rogue);
pick_pocket_level += GetLevelByClass(CLASS_TYPE_BARD,rogue);
pick_pocket_level += GetLevelByClass(CLASS_TYPE_ASSASSIN,rogue);
pick_pocket_level += GetLevelByClass(CLASS_TYPE_SHADOWDANCER,rogue);
if (pick_pocket_level <= 10)
    {
    gold = rogue_pick_pocket * 10;
    }
else if (pick_pocket_level <= 20)
    {
    gold = rogue_pick_pocket * 50;
    }
else
    {
    gold = rogue_pick_pocket * 200;
    }
// udelam hodnoty nahodnou s danym stropem
gold = Random(gold)+1;
//kontrola jestli ma cil dany pocet gp
if (GetGold(target)< gold) gold = GetGold(target);

return gold;
}




/*
Vrati jmeno cile
*/
string GetTargetName(object target)
{
if (GetIsPC(target))
 {
 return GetPCPlayerName(target);

 }
else
 {
 return GetName(target);
 }
}

/*
Zjisti jestli je NPC strazny
*/
int IsGuard(object oNPC)
{
  // Check defender faction
  string sFaction = GetNPCFaction(oNPC);
  if(GetStringRight(sFaction,2) == "_D")
    return TRUE;
  else 
    return FALSE;
}

/*
Nastavi co npc strazny udela kdyz uvidi okradeni
*/
void SetGuardActions(object guard,object rogue, object pick_pocket_target)
{
  AssignCommand(guard,ActionSpeakString("Hej ty! Zanech sveho pocinani! Jsi zatcen!."));
  AdjustReputation(rogue, guard, -50);
}


//-------- IMPLEMENTACE - MAIN -------------------------------------------------
/*
void main()
{
  object rogue = OBJECT_SELF;
  object target = GetSpellTargetObject();
  shm_PickPocket(rogue,target);
}

*/

void shm_PickPocket(object rogue, object target) {
//nastaveni promenych
object pozorujici;
//object rogue = OBJECT_SELF;
//object target = GetSpellTargetObject();
int rogue_pick_pocket = GetSkillRank(SKILL_PICK_POCKET,rogue);
int target_spot =GetSkillRank(SKILL_SPOT,target);
int check1,k20_rogue,k20_target,pick_pocket_gp;
string text;

//---------------------------- Animace
AssignCommand(rogue,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));

// zkontroluje jestli je reputace HOSTILE a vrati DC podle toho jestli je hostile nebo neco jineho
check1 = GetPickPocketCheck1DC(rogue,target);
// samotna kontrola 1
k20_rogue = Random(20)+1;
pick_pocket_gp =GetPickPocketGold(rogue,target);
if (((rogue_pick_pocket+k20_rogue) >= (check1)) && (pick_pocket_gp > MIN_GOLD))
    {
    //debug text= IntToString(rogue_pick_pocket) +" + " + IntToString(k20_rogue) +"<"+ IntToString(check1)+" + " + IntToString(k20_target);
     RemoveGold(target,pick_pocket_gp); //nwnx funkce
     GiveGoldToCreature(rogue,pick_pocket_gp);
     text = "Podarilo se ti okrast " + GetTargetName(target) + " o " + IntToString(pick_pocket_gp) + ".";
     SendMessageToPC(rogue,text);
    }
else
    {
     //debug text= "Postava " + GetPCPlayerName(rogue) + " se podarilo okrast " + GetName(target);
     text = "Nepodarilo se ti okrast cil " + GetTargetName(target) + ".";
     SendMessageToPC(rogue,text);
     }
// 2. kontrola - vsimnuti si okradeneho ze je okraden
k20_rogue = Random(20)+1;
k20_target = Random(20)+1;
if ((rogue_pick_pocket+k20_rogue) < (target_spot + k20_target))
    {
    text = "Tvuj mesec se ti zda nejak lehci.";
    SendMessageToPC(target,text);
    }

//3. kotrola PC a NPC v okoli------------------------------------------------GetNearestCreature
int i = 1;
int spot_penalty;
int pozorujici_spot,k20_pozorujici;;
while ((pozorujici = GetNearestCreature(CREATURE_TYPE_PERCEPTION,PERCEPTION_SEEN,target,i))!= OBJECT_INVALID )
    {
    spot_penalty =GetSpotPenalty(GetDistanceBetween(target,pozorujici));
    pozorujici_spot = GetSkillRank(SKILL_SPOT,pozorujici);
    k20_rogue = Random(20)+1;
    k20_pozorujici = Random(20)+1;
    //----------------------------------
    if ((rogue_pick_pocket+k20_rogue) < (pozorujici_spot + k20_pozorujici-spot_penalty))
        {
        if  (GetIsPC(pozorujici))
            {
            // pozorujici je hrac
            text = "Vidis nekoho okradat";
            SendMessageToPC(target,text);
            }
        else if(IsGuard(pozorujici))
            {
           //pozorujici je straz
           SetGuardActions(pozorujici,rogue,target);
            }
        else if(GetReputation(rogue,pozorujici)>=11)
            {
            // misto tohoto nutna kontrola na to jestli je to npc obcan
            AssignCommand(pozorujici,ActionSpeakString("Podivejte okrada ho."));
            }
        }
    i=i+1;
    }
//aplikace docasneho snizeni skillu okradani
effect e = EffectSkillDecrease(SKILL_PICK_POCKET,PENALIZACE_OKRADANI);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e,rogue,PENALIZACE_OKRADANI_TRVANI);

}


