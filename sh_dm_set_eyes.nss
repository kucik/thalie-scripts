object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
int iSize =GetCreatureSize(oTarget);
effect eEyes;
int iGender =GetGender(oTarget);
int iRacial =GetRacialType(oTarget);
int iColor;
string sRace;
void main()
{
    effect eEffect = GetFirstEffect(oTarget);
    int iType, iSub;

    while (GetIsEffectValid(eEffect))
    {
        iType = GetEffectType(eEffect);
        iSub = GetEffectSubType(eEffect);
        if (iType == EFFECT_TYPE_VISUALEFFECT && iSub == SUBTYPE_SUPERNATURAL)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
       }

 if(iDMSetNumber ==0)return;

//Green Eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==1)eEyes = EffectVisualEffect(VFX_EYES_GREEN_HALFORC_FEMALE);
//Green Eyes End

//Red Flame eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==2 )eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==2)eEyes = EffectVisualEffect(VFX_EYES_RED_FLAME_HALFORC_FEMALE);
//Red Flame eyes End

//Cyn eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==3)eEyes = EffectVisualEffect(VFX_EYES_CYN_HALFORC_FEMALE);
//Cyn eyes end


//ORG eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==4)eEyes = EffectVisualEffect(VFX_EYES_ORG_HALFORC_FEMALE);
//ORG eyes end

//PUR eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==5)eEyes = EffectVisualEffect(VFX_EYES_PUR_HALFORC_FEMALE);
//PUR eyes end

//Wht eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==6)eEyes = EffectVisualEffect(VFX_EYES_WHT_HALFORC_FEMALE);
//WHT eyes end

//YEL eyes start
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_MALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_HUMAN_MALE);
if(iRacial==RACIAL_TYPE_HUMAN && iGender ==GENDER_FEMALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_HUMAN_FEMALE);

if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_MALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_DWARF_MALE);
if(iRacial==RACIAL_TYPE_DWARF && iGender ==GENDER_FEMALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_DWARF_FEMALE);

if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_MALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_ELF_MALE);
if(iRacial==RACIAL_TYPE_ELF && iGender ==GENDER_FEMALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_ELF_FEMALE);

if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_MALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_GNOME_MALE);
if(iRacial==RACIAL_TYPE_GNOME && iGender ==GENDER_FEMALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_GNOME_FEMALE);

if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_MALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_HALFLING_MALE);
if(iRacial==RACIAL_TYPE_HALFLING && iGender ==GENDER_FEMALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_HALFLING_FEMALE);

if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_MALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_HALFORC_MALE);
if(iRacial==RACIAL_TYPE_HALFORC && iGender ==GENDER_FEMALE && iDMSetNumber ==7)eEyes = EffectVisualEffect(VFX_EYES_YEL_HALFORC_FEMALE);
//YEL eyes end

effect eEyesS =  SupernaturalEffect(eEyes);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eEyesS,oTarget);
}

