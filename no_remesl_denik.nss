#include "tc_xpsystem_inc"
#include "aps_include"

void main()
{
object no_oPC =  GetItemActivator();

int no_alchymie_lvl = TC_getLevel(no_oPC, 1);
int no_slevarenstvi_lvl = TC_getLevel(no_oPC, 20);
int no_drevarina_lvl = TC_getLevel(no_oPC, 21);
int no_keram_lvl = TC_getLevel(no_oPC, 22);
int no_brusicstvi_lvl = TC_getLevel(no_oPC, 23);
int no_kozesncstvi_lvl = TC_getLevel(no_oPC, 24);
int no_zlatnik_lvl = TC_getLevel(no_oPC, 30 );
int no_siti_lvl = TC_getLevel(no_oPC, 31 );
int no_truhlar_lvl = TC_getLevel(no_oPC, 32 );
int no_zbrane_lvl = TC_getLevel(no_oPC, 33 );
int no_platnerina_lvl = TC_getLevel(no_oPC, 2 );
int no_ocarovani_lvl = TC_getLevel(no_oPC, 35 );

int no_alchymie_xp = TC_getXP(no_oPC, 1);
int no_slevarenstvi_xp = TC_getXP(no_oPC, 20);
int no_drevarina_xp = TC_getXP(no_oPC, 21);
int no_keram_xp = TC_getXP(no_oPC, 22);
int no_brusicstvi_xp = TC_getXP(no_oPC, 23);
int no_kozesncstvi_xp = TC_getXP(no_oPC, 24);
int no_zlatnik_xp = TC_getXP(no_oPC, 30 );
int no_siti_xp = TC_getXP(no_oPC, 31 );
int no_truhlar_xp = TC_getXP(no_oPC, 32 );
int no_zbrane_xp = TC_getXP(no_oPC, 33 );
int no_platnerina_xp = TC_getXP(no_oPC, 2 );
int no_ocarovani_xp = TC_getXP(no_oPC, 35 );



// vrati xp postavy v craftu iCraftID
//  int TC_getXP(object oPC, int iCraftID)
// vrati level postavy v craftu iCraftID
// int TC_getLevel(object oPC, int iCraftID)


    SetCustomToken(9001, "Alchymie:" + IntToString(no_alchymie_xp) + " xp = " + IntToString(no_alchymie_lvl) + ". lvl");
    SetCustomToken(9002, "Brusicstv:" + IntToString(no_brusicstvi_xp) + " xp = " + IntToString(no_brusicstvi_lvl) + ". lvl");
    SetCustomToken(9003, "Drevarina:" + IntToString(no_drevarina_xp) + " xp = " + IntToString(no_drevarina_lvl) + ". lvl");
    SetCustomToken(9004, "Keramika:" + IntToString(no_keram_xp) + " xp = " + IntToString(no_keram_lvl) + ". lvl");
    SetCustomToken(9005, "Kozeluzstvi:" + IntToString(no_kozesncstvi_xp) + " xp = " + IntToString(no_kozesncstvi_lvl) + ". lvl");
    SetCustomToken(9006, "Slevarenstvi:" + IntToString(no_slevarenstvi_xp) + " xp = " + IntToString(no_slevarenstvi_lvl) + ". lvl");
    SetCustomToken(9007, "Kovarina:" + IntToString(no_zbrane_xp) + " xp = " + IntToString(no_zbrane_lvl) + ". lvl");
    SetCustomToken(9008, "Krejcovina:" + IntToString(no_siti_xp) + " xp = " + IntToString(no_siti_lvl) + ". lvl");
    SetCustomToken(9009, "Ocarovavani:" + IntToString(no_ocarovani_xp) + " xp = " + IntToString(no_ocarovani_lvl) + ". lvl");
    SetCustomToken(9010, "Platnerina:" + IntToString(no_platnerina_xp) + " xp = " + IntToString(no_platnerina_lvl) + ". lvl");
    SetCustomToken(9011, "Sperkarina:" + IntToString(no_zlatnik_xp) + " xp = " + IntToString(no_zlatnik_lvl) + ". lvl");
    SetCustomToken(9012, "Truhlarina:" + IntToString(no_truhlar_xp) + " xp = " + IntToString(no_truhlar_lvl) + ". lvl");

SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(1),no_alchymie_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_alchymie_xp,0,"tcXPSystem" + IntToString(1));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(20),no_slevarenstvi_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_brusicstvi_xp,0,"tcXPSystem" + IntToString(20));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(21),no_drevarina_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_drevarina_xp,0,"tcXPSystem" + IntToString(21));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(22),no_keram_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_keram_xp,0,"tcXPSystem" + IntToString(22));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(23),no_brusicstvi_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_kozesncstvi_xp,0,"tcXPSystem" + IntToString(23));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(24),no_kozesncstvi_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_slevarenstvi_xp,0,"tcXPSystem" + IntToString(24));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(30),no_zlatnik_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_zbrane_xp,0,"tcXPSystem" + IntToString(30));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(31),no_siti_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_siti_xp,0,"tcXPSystem" + IntToString(31));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(32),no_truhlar_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_ocarovani_xp,0,"tcXPSystem" + IntToString(32));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(33),no_zbrane_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_platnerina_xp,0,"tcXPSystem" + IntToString(33));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(2),no_platnerina_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_zlatnik_xp,0,"tcXPSystem" + IntToString(2));
SetPersistentInt(no_oPC,"tcXPSystem" + IntToString(35),no_ocarovani_xp,0);
//SetPersistentInt(no_oPC,"tcXPSystem",no_truhlar_xp,0,"tcXPSystem" + IntToString(35));

SendMessageToPC(no_oPC," Zkusenosti byli ulozeny do databaze ! ");
AssignCommand(no_oPC, ActionStartConversation(no_oPC, "no_remesl_denik", TRUE, FALSE));

}
