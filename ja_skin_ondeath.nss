/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_skin_ondeath
//
//  Desc:  The OnDeath handler for skinnable animals.
//
//  Author: David Bobeck 18Feb03
//
/////////////////////////////////////////////////////////
//#include "cnr_config_inc"

void FadeCorpse()
{
  object oBones = GetLocalObject(OBJECT_SELF, "CnrCorpseBones");
  if (GetIsObjectValid(oBones))
  {
    DeleteLocalObject(OBJECT_SELF, "CnrCorpseBones");
    DestroyObject(oBones);
  }
  DestroyObject(OBJECT_SELF);
}

object CreatePlaceable(string sObject, location lPlace, float fDuration)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
  return oPlaceable;
}



void destroyAllOn(object oObj)
{
    object oItem = GetFirstItemInInventory(oObj);
    while(oItem != OBJECT_INVALID){
        string sRR = GetResRef(oItem);
        if ( sRR=="nw_it_msmlmisc13" || sRR=="nw_it_msmlmisc08" || sRR=="nw_it_msmlmisc10" ||
             sRR=="nw_it_msmlmisc06" || sRR=="nw_it_msmlmisc09" || sRR=="cnrstinkgland"  ||
             sRR=="cnrfeatherfalcon" || sRR=="cnrfeatherowl" || sRR=="cnrfeatherraven" ||
             sRR=="cnrbellbomb" || sRR=="kh_zublicha" || sRR=="zihadlo_vosy" || sRR=="nw_bulette" ||
             sRR=="ry_vino_spory" || sRR=="ja_cockatrice" || sRR=="ry_grif_peri" || sRR=="it_amt_feath001" ||
             sRR=="ry_baz_oko" || sRR=="masokraba001" || sRR=="ry_mant_osten" || sRR=="ry_netdl_kridlo" ||
             sRR=="ry_klep_klep" || sRR=="ry_kel_prase" || sRR=="it_cmat_elmw005" || sRR=="it_cmat_elmw004" ||
             sRR=="kh_hlassireny" || sRR=="bodakstira" || sRR=="kh_krovohnivkral" || sRR=="nw_it_msmlmisc07" ||
             sRR=="sporymykoida" || sRR=="ry_krok_kuze" || sRR=="ry_zral_kuze"|| sRR=="ry_kuz_yetti"

           ) {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oObj);
    }
}

void main()
{
//  ExecuteScript("nw_c2_default7" , OBJECT_SELF);


    if(GetStringLength(GetLocalString(OBJECT_SELF, "sPelt") ) == 0 ) {
      DelayCommand(2.0,ExecuteScript("me_nc_kill_corps",OBJECT_SELF));
      return;
    }

    /* Get creature CR */
    float fCR = IntToFloat(GetLocalInt(OBJECT_SELF,"CR"));
    if(fCR <= 0.0)
      fCR = GetChallengeRating(OBJECT_SELF);
    int ai_boss = GetLocalInt(OBJECT_SELF, "AI_BOSS");

    SetIsDestroyable(FALSE,FALSE,FALSE);
    object oTemp = CreatePlaceable("corpse",GetLocation(OBJECT_SELF),240.0);

    SetLocalString(oTemp,"sPelt",GetLocalString(OBJECT_SELF, "sPelt"));
    SetLocalString(oTemp,"sMeat",GetLocalString(OBJECT_SELF, "sMeat"));
    SetLocalString(oTemp,"sMisc",GetLocalString(OBJECT_SELF, "sMisc"));
    SetLocalInt(oTemp,"iPenalty",GetLocalInt(OBJECT_SELF, "iPenalty"));
    SetLocalObject(oTemp,"oCorpse",OBJECT_SELF);

    
    SetLocalFloat(oTemp, "MonsterCR", fCR);
    if(ai_boss > 0)
      SetLocalInt(oTemp, "AI_BOSS", ai_boss);


    //destroyAllOn(OBJECT_SELF);
    SetName(oTemp, GetName(OBJECT_SELF));
    DelayCommand(240.0,SetIsDestroyable(TRUE,FALSE,FALSE));
    DelayCommand(241.0,DestroyObject(OBJECT_SELF));
  //object oCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrcorpseskin", locDeath, FALSE);
  //object oBones = CreateObject(OBJECT_TYPE_PLACEABLE, "cnrcorpsebones", locDeath, FALSE);
  //SetLocalObject(oCorpse, "CnrCorpseBones", oBones);
  //SetLocalString(oCorpse, "CnrCorpseType", GetTag(OBJECT_SELF));

  //SetName(oCorpse, GetName(OBJECT_SELF));

  //AssignCommand(oCorpse, DelayCommand(CNR_FLOAT_SKINNABLE_CORPSE_FADE_TIME_SECS, FadeCorpse()));
  //ExecuteScript("me_nc_skincorpse" , OBJECT_SELF);
}

