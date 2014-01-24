// Name: zep_enc_tables
// Load Table "giants" Table "lvl1" and Group "skelly" onto the calling area
// Script by Malishara and Barry_1066 7/1/2009
// Use this format to call the tables:
// encounter_01    string     v2, always, 75, table, lvl1
void main()
{
    SetLocalString(OBJECT_SELF, "table_giants_01", " 25, creature, zep_gntfirek_001, 3-5, random, , walk, 1");
    SetLocalString(OBJECT_SELF, "table_giants_02", " 50, creature, zep_gntfrstw_001, 3-5, random, , walk, 1");
    SetLocalString(OBJECT_SELF, "table_giants_03", " 75, creature, zep_gntfirec_001, 3-5, random, , walk, 1");
    SetLocalString(OBJECT_SELF, "table_giants_04", "100, creature, zep_gntstone_001, 3-5, random, , walk, 1");

    SetLocalString(OBJECT_SELF, "table_lvl1_01", "25, creature, nw_kobold002, 3 - 12, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_02", "35, creature, zep_troll02, 1-2, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_03", "45, group, skelly");
    SetLocalString(OBJECT_SELF, "table_lvl1_04", "50, creature, zep_grayoozes, 1-3, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_05", "60, creature, zep_gobspidrider, 1-2, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_06", "75, creature, nw_ghoul, 1-2, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_07", "80, creature, zep_goblinworgg, 5-8, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_08", "90, creature, zep_skelogre, 1-2, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "table_lvl1_09", "100, table, giants");

    SetLocalString(OBJECT_SELF, "group_skelly_01", "npc, zep_skeldoll2, 3 - 5, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "group_skelly_02", "npc, zep_skelyellow, 1 - 3, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "group_skelly_03", "npc, zep_skelpurple, 1 - 2, random, , 1, 1");
    SetLocalString(OBJECT_SELF, "group_skelly_04", "npc, zep_skelflaming, 1 - 2, random, , 1, 1");
}
