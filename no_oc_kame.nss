#include "tc_xpsystem_inc"
#include "no_nastcraft_ini"
#include "ku_items_inc"
//jen rekne, kdyz nahodou nestihnem chytit dusi a spravne nastavi hodnoty pro nova chytani..
void no_rekni(object no_oPC, object no_oPotvora,int no_lvl_potvora);
//////zjisti, zda je potvora mrtva, ci ne
void no_zjisti(object no_oPC, object no_oPotvora,int no_lvl_potvora,object no_activated);
///zjisti, zda se to ma povest, vyhodnoti xpy za cinnost + zmeni tag veci.
void no_vyhodnotxpy(object no_oPC,int no_lvl_potvora,object no_oPotvora,object no_activated);
//// znici momentalni predmet a udela novej se spravnym tagem a nastavenyma vlastnostma.
void no_udelejvyrobek(int no_procentaduse,object no_oPC, object no_activated);
////////////////////////////////////////////////////////
void no_udelejvyrobek(int no_procentaduse,object no_oPC,object no_activated)
{

string no_tag = IntToString(no_procentaduse); // tam je ulozene cislo pridavaneho kamene
if (GetStringLength(no_tag) ==1) {no_tag =  "00" + no_tag; }
if (GetStringLength(no_tag) ==2) {no_tag = "0" + no_tag;} // ulozi nam to string nazev kamene.

if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"name object_self =" + GetName(OBJECT_SELF)  );

if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"name GetItemActivated() =" + GetName(no_activated)  );
if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"no_tag=" + no_tag  );

object no_Item = CreateItemOnObject(GetResRef(no_activated),no_oPC,1,"no_oc_kame_" + no_tag );
SetName(no_Item,"Kamen duse : " + no_tag + "%");
 if (GetItemStackSize(no_activated)== 1) DestroyObject(no_activated);
 if (GetItemStackSize(no_activated)> 1) SetItemStackSize(no_activated,GetItemStackSize(no_activated)-1);

if  ((GetResRef(no_Item) == "no_oc_kame11") || (GetResRef(no_Item) == "no_oc_kame10"))
{SetLocalInt(no_Item,"tc_cena",no_cena_kame10+no_procentaduse/2); }
if  ((GetResRef(no_Item) == "no_oc_kame21") || (GetResRef(no_Item) == "no_oc_kame20"))
{SetLocalInt(no_Item,"tc_cena",no_cena_kame20+no_procentaduse); }
if  ((GetResRef(no_Item) == "no_oc_kame31") || (GetResRef(no_Item) == "no_oc_kame30"))
{SetLocalInt(no_Item,"tc_cena",no_cena_kame30+no_procentaduse); }
if  ((GetResRef(no_Item) == "no_oc_kame41") || (GetResRef(no_Item) == "no_oc_kame40"))
{SetLocalInt(no_Item,"tc_cena",no_cena_kame40+no_procentaduse); }
if  ((GetResRef(no_Item) == "no_oc_kame51") || (GetResRef(no_Item) == "no_oc_kame50"))
{SetLocalInt(no_Item,"tc_cena",no_cena_kame50+no_procentaduse); }



ku_SetItemDescription(no_activated," Dusi do tohoto kamene chytil: " + GetName(no_oPC) + " ." + "                // crft. v.:"+ no_verzecraftu+ " //");
SetLocalString(no_activated, "no_verze_craftu",no_verzecraftu);

} // konec procedury




void no_vyhodnotxpy(object no_oPC,int no_lvl_potvora,object no_oPotvora,object no_activated)
{       //volam to pomoci : no_vyhodnotxpy(no_oPC,no_lvl_potvora,no_oPotvora,no_activated);
int no_DC=1000;// radsi velke, kdyby nahodou se neprepsalo
int no_level = TC_getLevel(no_oPC,TC_ocarovavac);  // TC kovar = 33
//int TC_VLASTNOST  = GetAbilityScore(no_oPC, ABILITY_INTELLIGENCE,TRUE);

///na Stare Thalii se ocekavalo, ze boss bude mit max. lvl 35
///  to by nam dalo : 5+35*5 +10=190
//int no_procentaduse = FloatToInt (5+ GetChallengeRating(no_oPotvora)*5.5 + d10() );

///na nove thalii to udelame spojene ze dvou polovin.
//1. polovina budou challenge rating
int no_challenge = 0;
if (GetLocalInt(no_oPotvora,"CR")>0)
{
no_challenge = GetLocalInt(no_oPotvora,"CR");
}
else
{
no_challenge = FloatToInt(GetChallengeRating(no_oPotvora));
}
int no_procentaduse = FloatToInt ( (5+ no_challenge*5.5 + d10())/2 );
//2. polovina budou HP vetsi, nez 5000
    if ( (GetMaxHitPoints(no_oPotvora)/30) < 100 ) {
    no_procentaduse = no_procentaduse + GetMaxHitPoints(no_oPotvora)/30;
                                               }
    else  no_procentaduse = no_procentaduse + 100;


if(no_procentaduse > 250)
  no_procentaduse = 250;
/////////////odstranime, nejka to blblo, stejnak to dalo xpy//////////////
//if ((GetLocalInt(no_oPotvora,"AI_BOSS")!=1) || (GetLocalInt(no_oPotvora,"AI_BOSS")!=2))
     //nemame bosse
//     {
//     FloatingTextStringOnCreature("Tahle duse nepatri nacelnikovi. Je tedy moc slaba na zachyceni !",no_oPC,FALSE );
//        no_procentaduse = 0;
//        }

int no_tezkost_kamene = 0;
int no_preskoc_hody = FALSE;
//if  (GetRacialType(no_oPotvora) == RACIAL_TYPE_ANIMAL  )
//{               // zvirata sou lehci na zabiti
//no_procentaduse = 2* no_procentaduse /3;
//}

if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"no_procenta duse = " + IntToString(no_procentaduse)  );

if  (  ((GetResRef(no_activated) == "no_oc_kame11") || (GetResRef(no_activated) == "no_oc_kame10")) & (no_procentaduse>40) )
{no_procentaduse = 40;
FloatingTextStringOnCreature("Na tuhle dusi by to chtelo vetsi kamen",no_oPC,FALSE );
if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"maly kamen"  );
}
if  (  ((GetResRef(no_activated) == "no_oc_kame21") || (GetResRef(no_activated) == "no_oc_kame20")) & (no_procentaduse>80) )
{no_procentaduse = 80;
FloatingTextStringOnCreature("Na tuhle dusi by to chtelo vetsi kamen",no_oPC,FALSE );
if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"stredni kamen"  );
}
if  (  ((GetResRef(no_activated) == "no_oc_kame21") || (GetResRef(no_activated) == "no_oc_kame20")) & (no_procentaduse<40) )
{
no_tezkost_kamene = 40;
no_preskoc_hody = TRUE;
FloatingTextStringOnCreature("Takto mala duse se nemuzes v tak silnem kameni zachytnout",no_oPC,FALSE );
}

if  (  ((GetResRef(no_activated) == "no_oc_kame31") || (GetResRef(no_activated) == "no_oc_kame30")) & (no_procentaduse>120) )
{no_procentaduse = 120;
FloatingTextStringOnCreature("Na tuhle dusi by to chtelo vetsi kamen",no_oPC,FALSE );
if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"velky kamen"  );
}
if  (  ((GetResRef(no_activated) == "no_oc_kame31") || (GetResRef(no_activated) == "no_oc_kame30")) & (no_procentaduse<80) )
{
no_tezkost_kamene = 80;
no_preskoc_hody = TRUE;
FloatingTextStringOnCreature("Takto mala duse se nemuzes v tak silnem kameni zachytnout",no_oPC,FALSE );
}

if  (  ((GetResRef(no_activated) == "no_oc_kame41") || (GetResRef(no_activated) == "no_oc_kame40")) & (no_procentaduse>160) )
{no_procentaduse = 160;
FloatingTextStringOnCreature("Na tuhle dusi by to chtelo vetsi kamen",no_oPC,FALSE );
if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"legendarni kamen"  );
}

if  (  ((GetResRef(no_activated) == "no_oc_kame41") || (GetResRef(no_activated) == "no_oc_kame40")) & (no_procentaduse<120) )
{
no_tezkost_kamene = 120;
no_preskoc_hody = TRUE;
FloatingTextStringOnCreature("Takto mala duse se nemuzes v tak silnem kameni zachytnout",no_oPC,FALSE );
}

if  (  ((GetResRef(no_activated) == "no_oc_kame51") || (GetResRef(no_activated) == "no_oc_kame50")) )
{
if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"legendarni kamen"  );
}

if  (  ((GetResRef(no_activated) == "no_oc_kame51") || (GetResRef(no_activated) == "no_oc_kame50")) & (no_procentaduse<160) )
{
no_tezkost_kamene = 160;
FloatingTextStringOnCreature("Takto mala duse se nemuzes v tak silnem kameni zachytnout",no_oPC,FALSE );
no_preskoc_hody = TRUE;
}



no_DC = no_procentaduse - 10*no_level;
int no_chance = 100 - (no_DC) ;
if (no_chance < 0) no_chance = 0;
         if ( NO_oc_DEBUG == TRUE )  SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();

         if ( NO_oc_DEBUG == TRUE )  SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));
if (no_preskoc_hody == FALSE )  {  //preskocim hody bo mame moc velkej sutr


if (no_hod <= no_chance ) {
      SendMessageToPC(no_oPC,"===================================");

        if (no_chance >= 100) {FloatingTextStringOnCreature("Ziskani teto duse bylo pro tebe trivialni",no_oPC,FALSE );
                         TC_setXPbyDifficulty(no_oPC,TC_ocarovavac,no_chance,TC_dej_vlastnost(TC_ocarovavac,no_oPC));
                         }
        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_ocarovavac,no_chance,FloatToInt(1.2*TC_dej_vlastnost(TC_ocarovavac,no_oPC)));
                            }
                        no_udelejvyrobek(no_procentaduse,no_oPC,no_activated);


                       FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
        SendMessageToPC(no_oPC,"===================================");

}
else if (no_hod > no_chance )  {
FloatingTextStringOnCreature(" Nepovedlo se ti zachytit dusi " + GetName(no_oPotvora) + "- Kamen duse byl znehodnocen." ,no_oPC,FALSE);

 if (GetItemStackSize(no_activated)== 1) DestroyObject(no_activated);
 if (GetItemStackSize(no_activated)> 1) SetItemStackSize(no_activated,GetItemStackSize(no_activated)-1);

if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovanim by si mel radeji pockat ",no_oPC,FALSE );}
}
}//if no_preskoc_hody = FALSE;

}///konec  no_vyhodnotxpy(object no_oPC,int no_lvl_potvora)


void no_rekni(object no_oPC, object no_oPotvora,int no_lvl_potvora)
{
if  ((GetCurrentHitPoints(no_oPotvora)> 0)&(GetLocalInt(no_oPC,"no_chytam_dusi")==TRUE)&(GetLocalObject(no_oPC,"no_posledni_chytana_duse") == no_oPotvora) )
{
FloatingTextStringOnCreature(" Nestihl si zachytit dusi. " + GetName(no_oPotvora) ,no_oPC,FALSE);
SetLocalInt(no_oPC,"no_chytam_dusi",FALSE);
SetLocalObject(no_oPC,"no_posledni_chytana_duse",no_oPC);
SetLocalInt(no_oPotvora,"no_chytam_dusi",FALSE);
}


}


void no_zjisti(object no_oPC, object no_oPotvora,int no_lvl_potvora,object no_activated)
{

if  ((GetCurrentHitPoints(no_oPotvora)< 1)&(GetLocalInt(no_oPC,"no_chytam_dusi")==TRUE)&(GetLocalObject(no_oPC,"no_posledni_chytana_duse") == no_oPotvora) )  {
//if (NO_DEBUG) SendMessageToPC(no_oPC,"GetIsObjectValid(no_oPotvora) == FALSE"  );
no_vyhodnotxpy(no_oPC,no_lvl_potvora,no_oPotvora,no_activated);
SetLocalInt(no_oPC,"no_chytam_dusi",FALSE);
SetLocalObject(no_oPC,"no_posledni_chytana_duse",no_oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(20),no_oPC,3.0);
}

}




void main()
{

object no_oPotvora = GetItemActivatedTarget();
object no_oPC = GetItemActivator();

if ( GetIsObjectValid(GetLocalObject(no_oPC,"no_posledni_chytana_duse")) == FALSE )
{SetLocalObject(no_oPC,"no_posledni_chytana_duse",no_oPC);}

if ( (GetLocalObject(no_oPC,"no_posledni_chytana_duse")) != no_oPC )
{FloatingTextStringOnCreature("Mas stale aktivovanou jinou dusi !",no_oPC,FALSE);  }

if (( GetLocalInt(no_oPC,"no_chytam_dusi")==TRUE  ))
{ FloatingTextStringOnCreature("Najednou Muzes mit zamerenou pouze jednu dusi !",no_oPC,FALSE);
}

if (( GetLocalInt(no_oPotvora,"no_chytam_dusi")==TRUE  ))
{ FloatingTextStringOnCreature("Tato duse je jiz zamerena jinym kamenem ! ",no_oPC,FALSE);
}

if (GetIsPC(no_oPotvora)==TRUE )
{ SendMessageToPC(no_oPC,"//Nemuzes zamerit PC kvuli zneuzitelnosti ! ");
}
if ((FloatToInt(GetChallengeRating(no_oPotvora)))==0 )
{ FloatingTextStringOnCreature("Tato vec nema dusi, nebo je duse prilis mala na zachyceni ",no_oPC,FALSE);
}



////17 duben  = opatreni proti silenym boggerum..
int no_level = TC_getLevel(no_oPC,TC_ocarovavac);  // TC kovar = 33
object no_activated  = GetItemActivated();

//SendMessageToPC(no_oPC,"kamen resref:" + GetResRef(no_activated));

if( ( (GetResRef(no_activated) == "no_oc_kame21")  || (GetResRef(no_activated) == "no_oc_kame20")) & (no_level<2)   )
{
SendMessageToPC(no_oPC,"Na pouziti tohoto kamene jeste nemas dostatecne zkusenosti");
no_oPotvora=no_oPC; //aby to zrusilo ocarovavani
}
if( ( (GetResRef(no_activated) == "no_oc_kame31")  || (GetResRef(no_activated) == "no_oc_kame30")) & (no_level<4)   )
{
SendMessageToPC(no_oPC,"Na pouziti tohoto kamene jeste nemas dostatecne zkusenosti");
no_oPotvora=no_oPC; //aby to zrusilo ocarovavani
}
if( ( (GetResRef(no_activated) == "no_oc_kame41")  || (GetResRef(no_activated) == "no_oc_kame40")) & (no_level<6)   )
{
SendMessageToPC(no_oPC,"Na pouziti tohoto kamene jeste nemas dostatecne zkusenosti");
no_oPotvora=no_oPC; //aby to zrusilo ocarovavani
}
if( ( (GetResRef(no_activated) == "no_oc_kame51")  || (GetResRef(no_activated) == "no_oc_kame50")) & (no_level<9)   )
{
SendMessageToPC(no_oPC,"Na pouziti tohoto kamene jeste nemas dostatecne zkusenosti");
no_oPotvora=no_oPC; //aby to zrusilo ocarovavani
}


if ((GetLocalInt(no_oPC,"no_chytam_dusi")==FALSE)&(GetIsPC(no_oPotvora)==FALSE )&(FloatToInt(GetChallengeRating(no_oPotvora))>0))
{

if  ( GetIsObjectValid(no_oPotvora)&(GetLocalObject(no_oPC,"no_posledni_chytana_duse") == no_oPC )&( GetLocalInt(no_oPotvora,"no_chytam_dusi")==FALSE  )  )
{
SetPCDislike(no_oPC,no_oPotvora);
SetLocalInt(no_oPotvora,"no_chytam_dusi",TRUE);
SetLocalInt(no_oPC,"no_chytam_dusi",TRUE);
FloatingTextStringOnCreature("Zamerena duse: " + GetName(no_oPotvora) ,no_oPC,FALSE);

if (NO_oc_DEBUG) SendMessageToPC(no_oPC,"potvora ma lvl:" + FloatToString(GetChallengeRating(no_oPotvora),5,3) );

SetLocalObject(no_oPC,"no_posledni_chytana_duse",no_oPotvora);

ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(16),no_oPotvora,31.0);
//DelayCommand(10.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(16),no_oPotvora,31.0));
DelayCommand(10.0,no_zjisti(no_oPC,no_oPotvora,FloatToInt(GetChallengeRating(no_oPotvora)),no_activated));
//DelayCommand(15.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(16),no_oPotvora,5.0));
DelayCommand(15.0,no_zjisti(no_oPC,no_oPotvora,FloatToInt(GetChallengeRating(no_oPotvora)),no_activated));
//DelayCommand(20.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(16),no_oPotvora,5.0));
DelayCommand(20.0,no_zjisti(no_oPC,no_oPotvora,FloatToInt(GetChallengeRating(no_oPotvora)),no_activated));
//DelayCommand(25.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(16),no_oPotvora,5.0));
DelayCommand(25.0,no_zjisti(no_oPC,no_oPotvora,FloatToInt(GetChallengeRating(no_oPotvora)),no_activated));
//DelayCommand(29.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(16),no_oPotvora,5.0));
DelayCommand(30.0,no_zjisti(no_oPC,no_oPotvora,FloatToInt(GetChallengeRating(no_oPotvora)),no_activated));
DelayCommand(31.0,no_rekni(no_oPC,no_oPotvora,FloatToInt(GetChallengeRating(no_oPotvora))));
}//kdyz je object valid  (aktivovana bytost)
}//if chytam dusi = false !
}
