// Get PC Soulstone
object GetSoulStone(object oPC);

// Returns a soulstone of PC
object GetSoulStone(object oPC){
    object oSoul = GetLocalObject(oPC,"SoulStone");
    if(GetIsObjectValid(oSoul)) {
      return oSoul;
    }

    oSoul = GetItemPossessedBy(oPC, "sy_soulstone");
    SetLocalObject(oPC,"SoulStone",oSoul);
    return oSoul;
}

object CreateSoulStone(object oPC) {
   object oSoul = GetSoulStone(oPC);

   if(!GetIsObjectValid(oSoul)){
     oSoul = CreateItemOnObject("sy_soulstone", oPC);
     SetLocalObject(oPC,"SoulStone",oSoul);
   }
   return oSoul;
}
