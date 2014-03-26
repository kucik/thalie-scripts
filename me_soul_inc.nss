// Get PC Soulstone
object GetSoulStone(object oPC);

// Returns a soulstone of PC
object GetSoulStone(object oPC){
    object oSoul = GetLocalObject(oPC,"SoulStone");
    if(GetIsObjectValid(oSoul)) {
      return oSoul;
    }

    oSoul = GetItemPossessedBy(oPC, "sy_soulstone");
    if(!GetIsObjectValid(oSoul)) {
      WriteTimestampedLogEntry("Error. No soul on Player "+GetPCPlayerName(oPC)+" char:."+GetName(oPC));
      return OBJECT_INVALID;
    }
    SetLocalObject(oPC,"SoulStone",oSoul);
    return oSoul;
}

object CreateSoulStone(object oPC) {
   object oSoul = GetSoulStone(oPC);

   if(!GetIsObjectValid(oSoul)){
     oSoul = CreateItemOnObject("sy_soulstone", oPC);
     SetLocalObject(oPC,"SoulStone",oSoul);
      WriteTimestampedLogEntry("Created soul on Player "+GetPCPlayerName(oPC)+" char:."+GetName(oPC));
   }
   return oSoul;
}
