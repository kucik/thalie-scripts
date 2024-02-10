/* Zda muze byt umisteno/odstraneno lano */
int StartingConditional() {

   /* Do not allow if we are standing under the rope */
   if(GetStringLength(GetLocalString(OBJECT_SELF,"DEST_UP")) > 0 &&
      GetStringLength(GetLocalString(OBJECT_SELF,"DEST_DOWN")) <= 0) {
     return FALSE;
   }

   object oPC = GetPCSpeaker();
   /* check possibility to remove rope */
   if(GetLocalInt(OBJECT_SELF,"ROPE_PLACED")) {
     if(GetLocalInt(OBJECT_SELF,"ROPE_REMOVABLE")) {
       return TRUE;
     }
   }
   /* check possibility to place rope */
   else {
     if(GetIsObjectValid(GetItemPossessedBy(oPC,"ku_rope"))) {
       return TRUE;
     }
   }
   return FALSE;
}
