void main()
{


//SendMessageToPC(GetLastOpenedBy(),"on_used");
//SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",GetLocalInt(OBJECT_SELF,"no_MULTIKLIK")+1);
int CRAFT_PLACEABLE = FALSE;
object no_oPC = GetItemActivator();

if (GetResRef(GetItemActivatedTarget())=="AlchemistsApparatus") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_keram") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_sleva") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="Loom") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_susak") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_spalek") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_platner") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_tr_koza") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="tc_alchemy_kotel") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_brusnykamen") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="no_kovadlina") CRAFT_PLACEABLE = TRUE;
else if (GetResRef(GetItemActivatedTarget())=="X2_PLC_STUBE") CRAFT_PLACEABLE = TRUE;


else if (GetTag(GetItemActivatedTarget())=="No_kara_zl_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_zl_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_br_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_br_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_dr_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_dr_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_ke_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_ke_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_ko_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_ko_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_oc_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_oc_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_pl_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_pl_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_sl_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_sl_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_zb_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_zb_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_si_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_si_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_tr_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kara_tr_02") CRAFT_PLACEABLE = TRUE;

else if (GetTag(GetItemActivatedTarget())=="No_kazh_zl_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_zl_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_br_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_br_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_dr_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_dr_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_ke_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_ke_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_ko_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_ko_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_oc_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_oc_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_pl_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_pl_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_sl_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_sl_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_zb_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_zb_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_si_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_si_02") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_tr_01") CRAFT_PLACEABLE = TRUE;
else if (GetTag(GetItemActivatedTarget())=="No_kazh_tr_02") CRAFT_PLACEABLE = TRUE;


if  ( GetIsObjectValid(GetItemActivatedTarget()) == FALSE )  {
FloatingTextStringOnCreature(" Neplatny cil !" ,no_oPC,FALSE);
            }
if  ( (CRAFT_PLACEABLE == FALSE))  {
FloatingTextStringOnCreature(" Tento objekt nemuze spravce dilny opravit" ,no_oPC,FALSE);
            }
if  ( GetIsObjectValid(GetItemActivatedTarget()) & (CRAFT_PLACEABLE == TRUE))  {

///////////// kdyby to udelal umyslne, toz ho aspon musi script objevit/////////

effect no_effect=GetFirstEffect(no_oPC);
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
   no_effect=GetNextEffect(no_oPC);
   }

         FloatingTextStringOnCreature(" Safra je to znicene ! ",no_oPC,TRUE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),GetItemActivatedTarget());
       

         AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 4.0));
         AssignCommand(no_oPC, SetCommandable(FALSE));
         DelayCommand(1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
         ActionLockObject(GetItemActivatedTarget());
         location locForge = GetLocation(GetItemActivatedTarget());
         float    fForgeFacing =GetFacingFromLocation(locForge);
         object no_novapec = CreateObject(OBJECT_TYPE_PLACEABLE,GetResRef(GetItemActivatedTarget()),locForge,TRUE,"");
         ActionLockObject(no_novapec);
///////////prekopirujeme veci co nejsou tlacitky///////////////////////////////
         object  no_Item = GetFirstItemInInventory(GetItemActivatedTarget());

                 while (GetIsObjectValid(no_Item)) {

                        if (GetStringLeft(GetTag(no_Item),8) != "prepinac" ) {
                        CopyItem(no_Item,no_novapec,TRUE);
                         }
               // SendMessageToPC(GetLastOpenedBy(),"next item");
                no_Item = GetNextItemInInventory(GetItemActivatedTarget());
                 }
///////////prekopirujeme veci co nejsou tlacitky///////////////////////////////

         DestroyObject(GetItemActivatedTarget(),4.0);
         DelayCommand(2.0,ActionUnlockObject(no_novapec));

         DelayCommand(4.0,FloatingTextStringOnCreature(" Spravce dilny opravil " + GetName(GetItemActivatedTarget(),FALSE),no_oPC,TRUE ));
            }



}
