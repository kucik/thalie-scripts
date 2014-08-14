void main()
{


//SendMessageToPC(GetLastOpenedBy(),"on_used");
SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",GetLocalInt(OBJECT_SELF,"no_MULTIKLIK")+1);


if  ( GetLocalInt(OBJECT_SELF,"no_MULTIKLIK") > 6 )  {
         object no_oPC = GetLastOpenedBy();

///////////nomis nema rad neviditelne craftery (. //////////////
effect no_effect=GetFirstEffect(no_oPC);
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
   no_effect=GetNextEffect(no_oPC);
   }

/////////////////////////////////////////////////////////////////

         FloatingTextStringOnCreature(" Safra je to znicene ! ",no_oPC,TRUE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIREBALL),OBJECT_SELF);
         AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 3.0));
         AssignCommand(no_oPC, SetCommandable(FALSE));
         DelayCommand(1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
         ActionLockObject(OBJECT_SELF);
         location locForge = GetLocation(OBJECT_SELF);
         float    fForgeFacing =GetFacingFromLocation(locForge);
         object no_novapec = CreateObject(OBJECT_TYPE_PLACEABLE,GetResRef(OBJECT_SELF),locForge,TRUE,"");
         ActionLockObject(no_novapec);
///////////prekopirujeme veci co nejsou tlacitky///////////////////////////////
         object  no_Item = GetFirstItemInInventory(OBJECT_SELF);

                 while (GetIsObjectValid(no_Item)) {

                        if (GetStringLeft(GetTag(no_Item),8) != "prepinac" ) {
                        CopyItem(no_Item,no_novapec,TRUE);
                         }
               // SendMessageToPC(GetLastOpenedBy(),"next item");
                no_Item = GetNextItemInInventory(OBJECT_SELF);
                 }
///////////prekopirujeme veci co nejsou tlacitky///////////////////////////////

         DestroyObject(OBJECT_SELF,4.0);
         DelayCommand(2.0,ActionUnlockObject(no_novapec));

         DelayCommand(3.0,FloatingTextStringOnCreature(" Spravce dilny opravil " + GetName(OBJECT_SELF,FALSE),no_oPC,TRUE ));
            }



}
