void main()
{
  object oPC = GetPCSpeaker();
  string sUp = GetLocalString(OBJECT_SELF,"DEST_UP");
  string sDown = GetLocalString(OBJECT_SELF,"DEST_DOWN");
  string sWayTag;
  string sWayVar;
  object oWay = OBJECT_INVALID;
  int iUp = FALSE;

  /* Check, if we go up or down */
  if(GetStringLength(sUp) > 0 &&
     GetStringLength(sDown) <= 0) {
    sWayVar = "DEST_UP";
    sWayTag = sUp;
    iUp = TRUE;
  }
  else {
    sWayVar = "DEST_DOWN";
    sWayTag = sDown;
  }

  /* Find destination tag */
  oWay = GetLocalObject(OBJECT_SELF,sWayVar);
  if(!GetIsObjectValid(oWay)) {
    oWay = GetNearestObjectByTag(sWayTag);
    if(!GetIsObjectValid(oWay)) {
      GetObjectByTag(sWayTag);
    }
    if(!GetIsObjectValid(oWay)) {
      SpeakString("Chyba! Nemuzu najit cilovy waypoint podle tagu '"+sWayTag+"' z promenne '"+sWayVar+"'");
    }
    SetLocalObject(OBJECT_SELF,sWayVar,oWay);
  }

  /* Here place some DC checks */
  int iDC = GetLocalInt(OBJECT_SELF,"DC");
  int succes = TRUE;
  if(iDC) {
    succes = d20() + GetAbilityScore(oPC,ABILITY_DEXTERITY) > iDC;
  }
  /* Fail when trying to get up */
  if(iUp && !succes) {
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetReflexAdjustedDamage(d12(),oPC,iDC),DAMAGE_TYPE_BLUDGEONING),oPC);
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,2.0));
    FloatingTextStringOnCreature("Spadl jsi z lana,",oPC,FALSE);
    return;
  }

  /* Jump To location */
  AssignCommand(oPC, ClearAllActions());
  AssignCommand(oPC, JumpToLocation(GetLocation(oWay)));
  /* Fail when going down */
  if(!succes) {
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetReflexAdjustedDamage(d12(),oPC,iDC),DAMAGE_TYPE_BLUDGEONING),oPC);
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,2.0));
    FloatingTextStringOnCreature("Spadl jsi z lana,",oPC,FALSE);
    return;
  }
}
