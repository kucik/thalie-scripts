/*
  malo by to sposobit to ze ak niekto zautoci na mulicu ta
  zacne hned utekat a nebojuje
  -vlozit do ondamaged, onphysicaldmg, ondeath, onspellcastat, onuserdef
  -mulica by nemala byt nastvana voci tomu kto do nej kopal,
  namiesto toho len utecie o par metrov dalej
*/
void main()
{
    ClearAllActions(TRUE);
    object oAttacker = GetLastAttacker(OBJECT_SELF);

    ActionMoveAwayFromObject(oAttacker,TRUE,40.0f);
}
