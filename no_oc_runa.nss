void no_odblokuj(object no_oPC);
////////////////////////////////////////////////////////
void no_odblokuj(object no_oPC)
{
SetLocalObject(no_oPC,"no_posledni_chytana_duse",no_oPC);
SetLocalInt(no_oPC,"no_chytam_dusi",FALSE);


} // konec procedury


void main()
{

object no_oPotvora = GetItemActivatedTarget();
object no_oPC = GetItemActivator();
FloatingTextStringOnCreature("***  Snazis se odstranit pozustatky dusi ***" ,no_oPC,FALSE );
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 30.0));
DelayCommand(1.0,SetCommandable(FALSE,no_oPC));
DelayCommand(31.0,no_odblokuj(no_oPC));
DelayCommand(31.0,SetCommandable(TRUE,no_oPC));
}
