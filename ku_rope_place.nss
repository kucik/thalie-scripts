void main()
{
   object oPC = GetPCSpeaker();

   /* Do not allow if we are standing under the rope */
   if(GetStringLength(GetLocalString(OBJECT_SELF,"DEST_UP")) > 0 &&
      GetStringLength(GetLocalString(OBJECT_SELF,"DEST_DOWN")) <= 0) {
     return;
   }

   /* Get down waypoint */
   string sDown = GetLocalString(OBJECT_SELF,"DEST_DOWN");
   object oDown = GetNearestObjectByTag(sDown);
   if(!GetIsObjectValid(oDown)) {
     oDown = GetObjectByTag(sDown);
   }
   if(!GetIsObjectValid(oDown)) {
     SpeakString("Chyba! Neni mozne najit cilovy waypoint '"+sDown+"' Je spravne nastavena promenna 'DEST_DOWN' ?");
     return;
   }
   else {
     SetLocalObject(OBJECT_SELF,"DEST_DOWN",oDown);
   }

   /* check possibility to remove rope */
   if(GetLocalInt(OBJECT_SELF,"ROPE_PLACED")) {
     if(GetLocalInt(OBJECT_SELF,"ROPE_REMOVABLE")) {
       /* odstranime lano */
       object oRope = GetLocalObject(OBJECT_SELF,"ROPE");
       /* OK, so lets try to find rope */
       if(!GetIsObjectValid(oRope)) {
         oRope = GetNearestObjectByTag("ku_rope",oDown);
       }
       if(GetIsObjectValid(oRope)) {
         DestroyObject(oRope);
         CreateItemOnObject("ku_rope",oPC);;
       }
       DeleteLocalInt(OBJECT_SELF,"ROPE_PLACED");
     }
   }
   /* check possibility to place rope */
   else {
     object oRope = GetItemPossessedBy(oPC,"ku_rope");
     /* If PC has rope */
     if(GetIsObjectValid(oRope)) {
       /* Place rope */
       DestroyObject(oRope);
       oRope = CreateObject(OBJECT_TYPE_PLACEABLE,"ku_rope",GetLocation(oDown),TRUE);
       /* Set waypoints */
       string sUp = GetLocalString(OBJECT_SELF,"DEST_UP");
       object oUp;
       if(GetStringLength(sUp) <= 0 ) {
         oUp = OBJECT_SELF;
       }
       else {
         oUp = GetNearestObjectByTag(sUp);
         if(!GetIsObjectValid(oUp)) {
           oUp = OBJECT_SELF;
           SpeakString("Chyba! Neni mozne najit cilovy waypoint '"+sUp+"' Je spravne nastavena promenna 'DEST_UP' ?");
         }
       }
       SetLocalObject(oRope,"DEST_UP",oUp);
       SetLocalString(oRope,"DEST_UP",sUp);
       SetLocalInt(oRope,"ROPE_REMOVABLE",TRUE);
       SetLocalInt(OBJECT_SELF,"ROPE_REMOVABLE",TRUE);
       SetLocalInt(oRope,"ROPE_PLACED",TRUE);
       SetLocalInt(OBJECT_SELF,"ROPE_PLACED",TRUE);
       SetLocalInt(oRope,"DC",GetLocalInt(OBJECT_SELF,"DC"));
     }
   }

   /* Nic */
}
