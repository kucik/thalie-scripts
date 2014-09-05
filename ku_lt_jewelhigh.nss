//::///////////////////////////////////////////////////
//:: ku_lt_jewelhigh.nss
//:: OnOpened/OnDeath script for a treasure container.
//:: Treasure type: Gem and gold
//:: Treasure level: TREASURE_TYPE_HIGH
//::
//:: Created By: kucik
//:: Created On: 2014-09-05
//::///////////////////////////////////////////////////

#include "nw_o2_coninclude"

void main() {
  
  nt_GenerateSpecificTreasure(LOOT_TYPE_GOLD + LOOT_TYPE_GEM, TREASURE_HIGH, GetLastOpener(), OBJECT_SELF);
}
