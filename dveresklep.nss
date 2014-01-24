int FlipSwitch(object oLever = OBJECT_SELF)
{
    //lever animation
    if (GetLocalInt(OBJECT_SELF,"nToggle") == 0)
        {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
        SetLocalInt(OBJECT_SELF,"nToggle",1);//set "ON"
        return TRUE;
        }
    else
        {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
        SetLocalInt(OBJECT_SELF,"nToggle",0);//set "OFF"
        return FALSE;
        }
    //end level anaimation
}
void main()
{
    if(FlipSwitch())
        {
                 object oDoor = GetObjectByTag("sklepvezeni2");

              // Tell door to open itself.
               AssignCommand(oDoor, ActionOpenDoor(oDoor));
        }
    else
        {
         object oDoor = GetObjectByTag("sklepvezeni2");
         AssignCommand(oDoor, ActionCloseDoor(oDoor));
        }
}
