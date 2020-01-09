#include "tc_xpsystem_inc"

void main()
{


object no_oPC = GetSpellTargetObject();
object no_oDM = OBJECT_SELF;

SetLocalObject(no_oDM,"no_crafter",no_oPC);
//object no_oPC =  GetItemActivator();

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


    SetCustomToken(9021, "Alchymie:" + IntToString(no_alchymie_xp) + " xp = " + IntToString(no_alchymie_lvl) + ". lvl");
    SetCustomToken(9022, "Brusicstv:" + IntToString(no_brusicstvi_xp) + " xp = " + IntToString(no_brusicstvi_lvl) + ". lvl");
    SetCustomToken(9023, "Drevarina:" + IntToString(no_drevarina_xp) + " xp = " + IntToString(no_drevarina_lvl) + ". lvl");
    SetCustomToken(9024, "Keramika:" + IntToString(no_keram_xp) + " xp = " + IntToString(no_keram_lvl) + ". lvl");
    SetCustomToken(9025, "Kozeluzstvi:" + IntToString(no_kozesncstvi_xp) + " xp = " + IntToString(no_kozesncstvi_lvl) + ". lvl");
    SetCustomToken(9026, "Slevarenstvi:" + IntToString(no_slevarenstvi_xp) + " xp = " + IntToString(no_slevarenstvi_lvl) + ". lvl");
    SetCustomToken(9027, "Kovarina:" + IntToString(no_zbrane_xp) + " xp = " + IntToString(no_zbrane_lvl) + ". lvl");
    SetCustomToken(9028, "Krejcovina:" + IntToString(no_siti_xp) + " xp = " + IntToString(no_siti_lvl) + ". lvl");
    SetCustomToken(9029, "Ocarovavani:" + IntToString(no_ocarovani_xp) + " xp = " + IntToString(no_ocarovani_lvl) + ". lvl");
    SetCustomToken(9030, "Platnerina:" + IntToString(no_platnerina_xp) + " xp = " + IntToString(no_platnerina_lvl) + ". lvl");
    SetCustomToken(9031, "Sperkarina:" + IntToString(no_zlatnik_xp) + " xp = " + IntToString(no_zlatnik_lvl) + ". lvl");
    SetCustomToken(9032, "Truhlarina:" + IntToString(no_truhlar_xp) + " xp = " + IntToString(no_truhlar_lvl) + ". lvl");
    SetCustomToken(9033, "PC = " + GetName(no_oPC));



AssignCommand(no_oDM, ActionStartConversation(no_oDM, "no_dmhulka", TRUE, FALSE));
}
