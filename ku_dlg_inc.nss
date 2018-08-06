/*
 * 25. 04. 2010 Extended persistent NPCs.
 */
#include "ja_lib"
#include "ku_libbase"
#include "ku_persist_inc"
#include "ku_libchat"
//#include "nwnx_funcs"
#include "nwnx_funcsext"
#include "dmaction_inc"
#include "ku_resizer"
#include "me_pcneeds_inc"

const int TOTAL_SKILLS = 27;
const int TOTAL_FEATS  = 1268;

const string KU_DLG = "KU_UNI_DIALOG";
const string KU_WAND_TARGET = "KU_WAND_TARGET";
const string KU_WAND_TARGET_LOC = "KU_WAND_TARGET_LOC";



/* Declaration */

/* Subraces */
void KU_subrace_setting(int act);
void KU_subrace_set_tokens(object oPC);
void KU_DM_Wand(int act);
void KU_DM_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_Persistent_Wand(int iState);
void KU_DM_Persistent_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_NPC_Handling_Wand(int iState);
void KU_DM_NPC_Handling_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_Effects_Wand(int iState);
void KU_DM_Effects_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_CRStatsWand_Wand(int iState);
void KU_DM_CRStatsWand_SetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_PortalsAct(int act);
void KU_DM_PortalsSetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DM_FactionsAct(int act);
void KU_DM_FactionsSetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_DicesAct(int act);
void KU_DicesSetTokens(int iState, object oPC = OBJECT_INVALID);
void KU_SummonsAct(int act);
void KU_SummonsSetTokens(int iState, object oPC = OBJECT_INVALID);

/* Function definitions */

void ku_dlg_act(int act) {
  object oPC = GetPCSpeaker();
  int iDialog = GetLocalInt(oPC,KU_DLG+"dialog");
  switch(iDialog) {
    case 1: KU_subrace_setting(act); break;
    case 2: KU_DM_Wand(act); break;
    case 3: KU_DM_Persistent_Wand(act); break;
    case 4: KU_DM_NPC_Handling_Wand(act); break;
    case 5: KU_DM_Effects_Wand(act); break;
    case 6: KU_DM_CRStatsWand_Wand(act); break;
    case 7: KU_DM_PortalsAct(act); break;
    case 8: KU_DM_FactionsAct(act); break;
    case 9: KU_DicesAct(act); break;
    case 10: KU_SummonsAct(act); break;
  }
  return;
}

void ku_dlg_init(int act, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID)
    oPC = GetPCSpeaker();
  SetLocalInt(oPC,KU_DLG+"state",0);
  int iDialog = act; //GetLocalInt(oPC,KU_DLG+"dialog");

  switch(iDialog) {
    case 1: KU_subrace_set_tokens(oPC); break;
    case 2:
        KU_DM_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka.");
        break;
    case 3:
        KU_DM_Persistent_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka Persistence.");
        break;
     case 4:
        KU_DM_NPC_Handling_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
//        SetCustomToken(6300,"DM hulka uprav NPC.");
        break;
     case 5:
        KU_DM_Effects_Wand_SetTokens(0,oPC);
        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
        SetCustomToken(6300,"DM hulka efektu");
        break;
    case 6:
        KU_DM_CRStatsWand_SetTokens(0,oPC);
//        SetLocalInt(oPC,KU_DLG+"_allow_0",1);
//        SetCustomToken(6300,"DM Statu postavy. Pozor pri hrani s PC!!!");
        break;
    case 7:
        KU_DM_PortalsSetTokens(0,oPC);
        break;
    case 8:
        KU_DM_FactionsSetTokens(0,oPC);
        break;
    case 9:
        KU_DicesSetTokens(0,oPC);
        break;
    case 10:
        KU_SummonsSetTokens(0, oPC);
        break;
  }
  return;
}

int ku_dlg_is(int q) {
  object oPC = GetPCSpeaker();
//  SendMessageToPC(oPC,"Get On "+GetName(oPC)+" State "+IntToString(q)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(q))));
  return GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(q));
}

void ku_dlg_SetAll(int state) {
  object oPC = GetPCSpeaker();
  int i;
  for(i=0;i<=10;i++) {
//    SendMessageToPC(oPC,"Set On "+GetName(oPC)+" State "+IntToString(i)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(i))));
    SetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(i),state);
//    SendMessageToPC(oPC,"Set On "+GetName(oPC)+" State "+IntToString(i)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(i))));
  }
}

void ku_dlg_SetConv(int conv, int state) {
  object oPC = GetPCSpeaker();

  SetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(conv),state);

//  SendMessageToPC(oPC,"Set On "+GetName(oPC)+" State "+IntToString(conv)+"="+IntToString(GetLocalInt(oPC,KU_DLG+"_allow_"+IntToString(conv))));

}

void __dlgSetToken(int i, string s) {
  ku_dlg_SetConv(i,1);
  SetCustomToken(6300+i,s);
}

/* custom dialog functions */

/**********************************************
 *                DM hulka                    *
 **********************************************/
void KU_DM_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
  object oSoul = SEI_GetSoul(oTarget);
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    /* Init hulky */
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka zamirena na: "+GetName(oTarget));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Nastavit jako hledanou osobu");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit phenotyp");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Nastavit FootStepSound");
        ku_dlg_SetConv(4,1);
        if(GetLocalInt(oSoul,"STOP_XP") > 0) {
          SetCustomToken(6304,"Obnovit prisun casovych XP");
        }
        else {
          SetCustomToken(6304,"Zrusit prisun casovych XP");
        }
        if(GetLocalInt(oSoul,"KU_ZLODEJ") < ku_GetTimeStamp()) {
          ku_dlg_SetConv(5,1);
          SetCustomToken(6305,"Oznacit za zlodeje");
        }
        else {
          ku_dlg_SetConv(5,1);
          SetCustomToken(6305,"Zrusit oznaceni za  zlodeje");
        }
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Nastavit unavu/hlad/zizen/opilost");
        break;
    case 1:
    /* Hledane osoby */
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Kde ma byt "+GetName(oTarget)+ " hledany?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Straz Karathy");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Ivory");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Garda S'Zai");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Chmurna straz");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Murgond");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Nordova garda");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Druidove");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"Isilska pevnost");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Dalsi");
        break;
    /* Stale hledane osoby */
    case 10:
//        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Kde ma byt "+GetName(oTarget)+ " hledany?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Predchozi");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Kel A Hazr");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Khar Durn");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
    case 13:
    /* Hledane osoby */
//        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"S jakou pravdepodobnosti maji jit po "+GetName(oTarget)+ "?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"0%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"2%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"5%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"10%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"20%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"30%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"50%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"80%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
    /* Phenotypy */
    case 2:
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Jaky phenotyp se ma "+GetName(oTarget)+ " nastavit?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Normal");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Skinny");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Large");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Normal Mounted");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Large Mounted");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Normal Jousting Mounted");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"Zpet");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Normal Jousting Mounted");
        break;
     case 3:
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Jaky zvuk kroku se ma pro "+GetName(oTarget)+ " nastavit?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Normal");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Large");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Horse");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
     case 6:
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Co chces postave "+GetName(oTarget)+ " nastavit?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zrusit hlad, zizen, unavu, opilost a spanek ");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,sy_num_to_percent("Hlad : ", MAX_FOOD, GetLocalFloat(oTarget, "FoodRating"))+" +10%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,sy_num_to_percent("Zizen : ", MAX_WATER, GetLocalFloat(oTarget, "WaterRating"))+" +10%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,sy_num_to_percent("Alkohol : ", MAX_ALCOHOL, GetLocalFloat(oTarget, "AlcoholRating"))+" +10%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,sy_num_to_percent("Unava : ", getMaxStamina(oTarget), getMaxStamina(oTarget))+" +10%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"zpet");
        break;
  } /* switch act  end */

}

void KU_DM_Wand(int act) {
  object oPC = GetPCSpeaker();
  object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
  object oSoul = SEI_GetSoul(oTarget);
  int iState = GetLocalInt(oPC,KU_DLG+"state");
//  SendMessageToPC(oPC,"state = "+IntToString(iState)+" act = "+IntToString(act));
  switch(iState) {
    /* Spusteni hulky */
    case 0: {
      switch(act) {
        /* Nic nezmacknuto */
        case 0:
          KU_DM_Wand_SetTokens(iState);
          break;
        /* Hledani osob */
        case 1:
        /* Nastaveni Phenotypu */
        case 2:
        /* Nastaveni footstepsound */
        case 3:
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_Wand_SetTokens(act);
          break;
        case 4:
          if(GetLocalInt(oSoul,"STOP_XP") > 0) {
            DeleteLocalInt(oSoul,"STOP_XP");
          }
          else {
            SetLocalInt(oSoul,"STOP_XP",1);
          }
          break;
        case 5:
          if(GetLocalInt(oSoul,"KU_ZLODEJ") < ku_GetTimeStamp()) {
            SetLocalInt(oSoul,"KU_ZLODEJ",ku_GetTimeStamp(0,0,0,90));
          }
          else {
            SetLocalInt(oSoul,"KU_ZLODEJ",0);
          }
          break;
        case 6:
          SetLocalInt(oPC,KU_DLG+"state",act);
          break;
      } /* switch act  end */
      break;
    } /* case 0 end */
    /* Hledane osoby */
    case 1: {
       switch(act) {
         case 1:
         case 2:
         case 3:
         case 4:
         case 5:
         case 6:
         case 7:
         case 8:
           SetLocalInt(oPC,"dm_wanted",act);
           SetLocalInt(oPC,KU_DLG+"state",13);
           KU_DM_Wand_SetTokens(13);
           break;
         case 9:
           KU_DM_Wand_SetTokens(10);
           SetLocalInt(oPC,KU_DLG+"state",10);
           break;

       }
       break;
    }
    case 10: {
      switch(act) {
         case 1:
           SetLocalInt(oPC,KU_DLG+"state",1);
           KU_DM_Wand_SetTokens(1);
           break;
         case 2:
         case 3:
           SetLocalInt(oPC,"dm_wanted",act+7);
           SetLocalInt(oPC,KU_DLG+"state",13);
           KU_DM_Wand_SetTokens(13);
           break;
         case 9:
           KU_DM_Wand_SetTokens(0);
           SetLocalInt(oPC,KU_DLG+"state",0);
           break;
      }
      break;
    }
    case 13: {
      string sWanted = "KU_WANTED"+IntToString(GetLocalInt(oPC,"dm_wanted"));
//      object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
//      object oSoul = GetSoulStone(oTarget);
      switch(act) {
        case 0: KU_DM_Wand_SetTokens(13); return;
        case 1: DeleteLocalInt(oSoul,sWanted); break;
        case 2: SetLocalInt(oSoul,sWanted,2); break;
        case 3: SetLocalInt(oSoul,sWanted,5); break;
        case 4: SetLocalInt(oSoul,sWanted,10); break;
        case 5: SetLocalInt(oSoul,sWanted,20); break;
        case 6: SetLocalInt(oSoul,sWanted,30); break;
        case 7: SetLocalInt(oSoul,sWanted,50); break;
        case 8: SetLocalInt(oSoul,sWanted,80); break;
        case 9:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      if(act < 9) {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Po "+GetName(oTarget)+ " pujdou straze na "+IntToString(GetLocalInt(oSoul,sWanted))+"%");
      }
      break;
    }
    /* Phenotypes */
    case 2: {
//      object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
      switch(act) {
        case 0: KU_DM_Wand_SetTokens(2); return;
        case 1:
        case 2:
        case 3:
        case 4:
        case 6:
        case 7:
        case 9:
          SetPhenoType(act-1,oTarget);
          ku_dlg_SetAll(0);
          ku_dlg_SetConv(0,1);
          SetCustomToken(6300,GetName(oTarget)+" Nastaven Phenotype "+IntToString(act));
          break;
        case 8:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      break;
    }/*End Phenotypes */
    /* Foootstepsounds */
    case 3: {
//      object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );

      switch(act) {
        case 0: KU_DM_Wand_SetTokens(3); return;
        case 1:
        case 2:
          SetFootstepType(act-1,oTarget);
          ku_dlg_SetAll(0);
          ku_dlg_SetConv(0,1);
          SetCustomToken(6300,GetName(oTarget)+" Nastaven FootStepSound "+IntToString(act));
          break;
        case 3:
          SetFootstepType(17,oTarget);
          ku_dlg_SetAll(0);
          ku_dlg_SetConv(0,1);
          SetCustomToken(6300,GetName(oTarget)+" Nastaven FootStepSound Horse");
          break;
        case 9:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      break;
    }/*End Footstepsounds*/
    case 6: {
      switch(act) {
        case 0: KU_DM_Wand_SetTokens(6); return;
        // zrus opilost,unavu,hlad...
        case 1:
          SetLocalFloat(oTarget, VARNAME_WATER,  MAX_WATER);
          SetLocalFloat(oTarget, VARNAME_FOOD, MAX_FOOD);
          SetLocalFloat(oTarget, VARNAME_ALCOHOL,  MAX_ALCOHOL);
          restoreStamina(oTarget, getMaxStamina(oTarget));
          break;
        //jidlo
        case 2:
          SetLocalFloat(oTarget, VARNAME_FOOD,GetLocalFloat(oTarget, VARNAME_FOOD)- MAX_FOOD/10.0);
          break;
        //zizen
        case 3:
          SetLocalFloat(oTarget, VARNAME_WATER,GetLocalFloat(oTarget, VARNAME_WATER)- MAX_WATER/10.0);
          break;
        //alcohol
        case 4:
          SetLocalFloat(oTarget, VARNAME_ALCOHOL,GetLocalFloat(oTarget, VARNAME_ALCOHOL)- MAX_ALCOHOL/10.0);
          break;
        //unava
        case 5:
          woundStamina(oTarget,getMaxStamina(oTarget)/10);
          break;
        case 9:
          KU_DM_Wand_SetTokens(0);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }

      break;
    }

  } /* Switch state end */

}


/****************************************************
 ***           Propriety pro upravy subrasy       ***
 ****************************************************/
void KU_subrace_set_tokens(object oPC) {


   int app =  GetLocalInt(oPC,"KU_STANDART_APPEARANCE");

   switch(app) {
      // Halfogre
      case 985: {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nastaveni Hlavy. Vyberte vzhled hlavy a ukoncete dialog");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Hlava cislo 1");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Hlava cislo 2");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Hlava cislo 3");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Hlava cislo 4");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Hlava cislo 5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Hlava cislo 6");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
      }
      // Kobold
      case 984: {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nastaveni Hlavy. Vyberte vzhled hlavy a ukoncete dialog");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Hlava cislo 1");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Hlava cislo 2");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Hlava cislo 3");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Hlava cislo 4");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
      }
      default : {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nastaveni Hlavy. Vyberte vzhled hlavy a ukoncete dialog");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Predchozi hlava");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"Nasledujici hlava");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
      }
   }

}

void KU_subrace_setting(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");

  object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
  if(!GetIsObjectValid(oTarget) || !GetIsDM(oPC)) {
    oTarget = oPC;
  }

  switch(iState) {
    case 0: {
      switch(act) {
        // Default
        case 0: {
         KU_subrace_set_tokens(oPC);
         break;
        }
        // Predchozi
        case 1: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,1,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 2: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,2,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 3: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,3,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 4: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,4,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 5: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,5,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 6: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,6,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 7: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget) - 1,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 8: {
         SetCreatureBodyPart(CREATURE_PART_HEAD,GetCreatureBodyPart(CREATURE_PART_HEAD,oTarget) + 1,oTarget);
         KU_subrace_set_tokens(oPC);
         break;
        }
        case 9: {
         ku_dlg_SetAll(0);
         break;
        }

      } // 2nd switch end
      break;
    }
  } //st switch end

}



/*************************************************
 *            Persistentni hulka                 *
 *************************************************/

void KU_DM_Persistent_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_Persistent_Wand_SetTokens(iState);
          break;
        /// Zpersistentneni
        case 1: {
            object oArea = GetArea(oPC);
            object oPlc = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oPlc)) {
              if(GetLocalInt(oPlc,"ku_plc_origin") == 0) {
                switch(GetObjectType(oPlc)) {
                  case OBJECT_TYPE_PLACEABLE:
                    SendMessageToPC(oPC,"Ukladam "+GetName(oPlc));
                    Persist_SavePlaceable(oPlc,oArea);
                    SetLocalInt(oPlc,"ku_plc_origin",2);
                    break;
                  default:
                   break;
                }
              }
              oPlc = GetNextObjectInArea(oArea);
            }
          }
          break;
        // Vymazat objekty z DB
        case 2: {
            object oArea = GetArea(oPC);
            Persist_DeletePlaceablesInArea(oArea);
          }
          break;
        // Odstranit persistentni placeably
        case 3: {
          object oArea = GetArea(oPC);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_PLACEABLE);
        }
        break;
        // Odstranit persistentni placeably
        case 4: {
            object oArea = GetArea(oPC);
            Persist_DestroyObjectsInArea(oArea,0,OBJECT_TYPE_PLACEABLE);
          }
          break;
        case 5: {
          object oArea = GetArea(oPC);
          Persist_DestroyObjectsInArea(oArea,0,OBJECT_TYPE_PLACEABLE);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_PLACEABLE);
          Persist_DestroyObjectsInArea(oArea,2,OBJECT_TYPE_CREATURE);
          Persist_LoadAddedPlaceables(oArea);
          }
          break;
        //Zpersistentni/zrus NPC
        case 6: {
          object oTarget = GetLocalObject(GetPCSpeaker(),KU_WAND_TARGET );
          object oArea = GetArea(oTarget);
          if(GetLocalInt(oTarget,"ku_plc_origin") == 2 ) {
            Persist_DeleteNPCSInArea(oArea,oTarget);
            AssignCommand(oTarget,SpeakString("NPC odstraneno z persistence"));
          }
          else {
            Persist_SavePlaceable(oTarget,oArea);
            AssignCommand(oTarget,SpeakString("NPC zpersistentneno"));
          }
        }
        break;
        //odstran NPC z DB
        case 7: {
            object oArea = GetArea(oPC);
            Persist_DeleteNPCSInArea(oArea);
          }
          break;
        //Vypni spawn
        case 8:
          if(GetLocalInt(GetArea(oPC),"KU_LOC_DISABLE_SPAWN")) {
            Persist_SetSpawnInAreaDisabled(GetArea(oPC),0);
          }
          else {
            Persist_SetSpawnInAreaDisabled(GetArea(oPC),1);
          }
          break;
        //zapni spawn
//        case 9:
//          Persist_SetSpawnInAreaDisabled(GetArea(oPC),0);
//          break;


      }
    } // case 0 end
    break;

  } // Switch state end

}


void KU_DM_Persistent_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM Persistentni hulka zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zpersistentnit nove placeably");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Zrusit persistenci na placeablech (objekty zustanou do restartu)");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odstranit ted persistentni objekty z lokace (zustanou v DB a objevi se po restartu)");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Odstranit nove pridane, nepersistentni placeably");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Vycistit lokaci a znovunacist persistentni placeably");
        ku_dlg_SetConv(6,1);
        if(GetLocalInt(oTarget,"ku_plc_origin") == 2 ) {
          SetCustomToken(6306,"Odstran z persistence NPC '"+sTargetName+"' ");
        }
        else {
          SetCustomToken(6306,"Zpersistentnit NPC '"+sTargetName+"' ");
        }
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Odstranit persistentni NPC z databaze. (vsechny v lokaci)");
        ku_dlg_SetConv(8,1);
        if(GetLocalInt(GetArea(oPC),"KU_LOC_DISABLE_SPAWN")) {
          SetCustomToken(6308,"Zapnout spawn v lokaci.");
        }
        else {
          SetCustomToken(6308,"Vypnout spawn v lokaci.");
        }
//        ku_dlg_SetConv(9,0);
//        SetCustomToken(6309,"Zapnout spawn v lokaci.");
        break;

  } // switch act  end

}


/**************************************
************ NPC HANDLING ************
**************************************/

void ku_SetDescriptionByPC(object oPC,object oTarget,int iStart) {
  int iStop = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = "";
  SendMessageToPC(oPC,"Nastavuju popis "+sStr);

  int i = iStart;
  while(i != iStop) {
   i = (i + 1) % KU_CHAT_CACHE_SIZE;
   sStr = sStr+" "+ GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  }
     SendMessageToPC(oPC,"Nastavuju popis:"+sStr);
  SetDescription(oTarget,sStr);

}

void ku_SetNameByPC(object oPC,object oTarget) {
  int i = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  SendMessageToPC(oPC,"Nastavuju jmeno "+sStr);
  SetName(oTarget,sStr);
}

void ku_SetPortraitByPC(object oPC,object oTarget) {
  int i = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  string sStr = GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i));
  SendMessageToPC(oPC,"Nastavuju portret "+sStr);
  SetPortrait(oTarget, sStr);
}

void dmw_changeWings(int change, object oTarget) {
  int iWings = GetCreatureWingType(oTarget) + change;
  if(iWings < 0)
    iWings = 0;

  SetCreatureWingType(iWings, oTarget);
}

void dmw_changeTail(int change, object oTarget) {
  int iWings = GetCreatureWingType(oTarget) + change;
  if(iWings < 0)
    iWings = 0;

  SetCreatureTailType(iWings, oTarget);
}

void dmw_changeColor(int change,int channel, object oTarget) {
  int iColor = GetColor(oTarget, channel) + change;
  if(iColor < 0)
    iColor = 0;

  if(iColor > 255)
    iColor = 255;

  SetColor(oTarget, channel, iColor);
}

void KU_DM_NPC_Handling_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );

  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;

        // Kopirovat NPC
        case 1: {
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          ku_CopyNPCWithEquipedItems(oTarget,GetLocation(oPC));
          }
          break;
        // Nastavit jmeno, description, portret
        case 2: {
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          int indexMark = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
          SetLocalInt(oPC,KU_DLG+"_PARAM_1",indexMark);
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_NPC_Handling_Wand_SetTokens(act);
          }
          break;
        // Nastav kridla
        case 3:
        // Ocas
        case 4:
        //Barva
        case 5:
        //Velikost
        case 6: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_NPC_Handling_Wand_SetTokens(act);
          }
          break;
      }
      break;
    }
    // nastavovani popis/desc/portrait
    case 2: {
      switch(act){
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        // nastav popis
        case 1: {
          SpeakString("Nastavuju popis");
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          int iMark = GetLocalInt(oPC,KU_DLG+"_PARAM_1");
          ku_SetDescriptionByPC(oPC,oTarget,iMark);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
        }
       // nastav jmeno
       case 2: {
          SpeakString("Nastavuju jmeno");
          int iMark = GetLocalInt(oPC,KU_DLG+"_PARAM_1");
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          ku_SetNameByPC(oPC,oTarget);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
        }
       // nastav portret
       case 3: {
          SpeakString("Nastavuju portret ");
          int iMark = GetLocalInt(oPC,KU_DLG+"_PARAM_1");
//          object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
          ku_SetPortraitByPC(oPC,oTarget);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
       }
       // back
       case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
      }
    } // case 0 end
    break;
    case 3: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          dmw_changeWings(1, oTarget);
          break;
        case 2:
          dmw_changeWings(10, oTarget);
          break;
        case 3:
          dmw_changeWings(100, oTarget);
          break;
        case 4:
          dmw_changeWings(-100, oTarget);
          break;
        case 5:
          dmw_changeWings(-10, oTarget);
          break;
        case 6:
          dmw_changeWings(-1, oTarget);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
      }
    }
    break;
    case 4: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          dmw_changeTail(1, oTarget);
          break;
        case 2:
          dmw_changeTail(10, oTarget);
          break;
        case 3:
          dmw_changeTail(100, oTarget);
          break;
        case 4:
          dmw_changeTail(-100, oTarget);
          break;
        case 5:
          dmw_changeTail(-10, oTarget);
          break;
        case 6:
          dmw_changeTail(-1, oTarget);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
      }
    }
    break;
    case 5: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        }
        default :
          SetLocalInt(oPC,KU_DLG+"state",50+act);
          KU_DM_NPC_Handling_Wand_SetTokens(50+act - 1);
          break;
      }
    }
    break;
    case 50:
    case 51:
    case 52:
    case 53: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          dmw_changeColor(1, iState - 50, oTarget);
          break;
        case 2:
          dmw_changeColor(10, iState - 50, oTarget);
          break;
        case 3:
          dmw_changeColor(100, iState - 50, oTarget);
          break;
        case 4:
          dmw_changeColor(-100, iState - 50, oTarget);
          break;
        case 5:
          dmw_changeColor(-10, iState - 50, oTarget);
          break;
        case 6:
          dmw_changeColor(-1, iState - 50, oTarget);
          break;
        // back
        case 9: {
          SetLocalInt(oPC,KU_DLG+"state",5);
          KU_DM_NPC_Handling_Wand_SetTokens(5);
          break;
        }
      }
    }
    break;
    case 6: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          SetLocalInt(oPC,KU_DLG+"state",61);
          KU_DM_NPC_Handling_Wand_SetTokens(61);
          break;
        case 8:
          SetLocalInt(oPC,KU_DLG+"state",62);
          KU_DM_NPC_Handling_Wand_SetTokens(62);
          break;
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_NPC_Handling_Wand_SetTokens(0);
          break;
        default:
          Resizer_ResizeCreature(oTarget,act -5);
          break;
      }
    }
    break;
    case 61: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_NPC_Handling_Wand_SetTokens(6);
          break;
        default:
          Resizer_ResizeCreature(oTarget,act -10);
          break;
      }
    }
    break;
    case 62: {
      switch(act) {
        case 0:
          KU_DM_NPC_Handling_Wand_SetTokens(iState);
          break;
        case 1:
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_NPC_Handling_Wand_SetTokens(6);
          break;
        default:
          Resizer_ResizeCreature(oTarget,act +1);
          break;
      }
    }
    break;
  } // Switch state end

}


void KU_DM_NPC_Handling_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka uprav NPC zamirena na: "+sTargetName+"("+GetTag(oTarget)+")("+GetResRef(oTarget)+")");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zkopirovat NPC");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit jmeno/popis/portert");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Kridla");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Ocas");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Barva");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Velikost");
        break;

    // nastavit name / description
    case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Nyni napis text, stiskni enter a vyber pouziti na "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Nastavit jako popis");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit jako nazev");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Nastavit jako portret");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
    case 3:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni model kridel: "+IntToString(GetCreatureWingType(oTarget))+" -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+1 (Dalsi)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10 ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+100");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-100");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-1 (Predchozi)");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
     case 4:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni ocas: "+IntToString(GetCreatureTailType(oTarget))+" -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+1 (Dalsi)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10 ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+100");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-100");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-1 (Predchozi)");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
     case 5:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni barvy: "+
                           IntToString(GetColor(oTarget,0))+";"+
                           IntToString(GetColor(oTarget,1))+";"+
                           IntToString(GetColor(oTarget,2))+";"+
                           IntToString(GetColor(oTarget,3))+";"+
                           " -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Vlasy");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Kuze ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Tetovani #1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Tetovani #2");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
     case 50:
     case 51:
     case 52:
     case 53:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Aktualni barva: "+IntToString(GetColor(oTarget,iState-50))+" -  "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+1 (Dalsi)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10 ");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+100");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-100");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-1 (Predchozi)");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Hotovo");
        break;
     case 6:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zmena velikosti - funguje jen pro nektere nehumanoidy.");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"< 70%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"70%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"80%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"90%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"100%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"110%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"120%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"> 130%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
     case 61:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zmena velikosti - funguje jen pro nektere nehumanoidy.");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"10%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"20%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"30%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"40%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"50%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"60%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"70%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"80%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"> 80%");
        break;
     case 62:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zmena velikosti - funguje jen pro nektere nehumanoidy.");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"< 130%%");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"130%");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"140%");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"150%");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"160%");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"170%");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"180%");
        ku_dlg_SetConv(8,1);
        SetCustomToken(6308,"190%");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"200%");
        break;
  } // switch act  end


}

/**************************************
************ Hulka efektu ************
**************************************/
void ku_dlg_effect_fake_hellball(location lTarget)
{


    float fDelay;
    effect eExplode = EffectVisualEffect(464);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis3 = EffectVisualEffect(VFX_IMP_SONIC);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);


    while (GetIsObjectValid(oTarget))
    {


        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20 + 0.5f;

                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay+0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                DelayCommand(fDelay+0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

}



void KU_DM_Effects_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  location lTarget = GetLocalLocation(oPC,KU_WAND_TARGET_LOC);

  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;

        // instant efekty
        case 1: {
          SetLocalInt(oPC,KU_DLG+"state",act);

          }
          break;
        // perma efekty
        case 2: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_Effects_Wand_SetTokens(act);
          }
          break;
        // niceni efektu
        case 3: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          object oEff = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,lTarget,1);
          SetLocalObject(oPC,"ku_dlg_targeteffect",oEff);
          SetLocalInt(oPC,"ku_dlg_targeteffect",1);
          KU_DM_Effects_Wand_SetTokens(act);
          }
          break;
      }
      break;
    }
    case 1: {
      switch(act){
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;
        // nastav popis
        case 1: {
          ku_dlg_effect_fake_hellball(lTarget);
          break;
        }

      }
    } // case 0 end
    break;
    case 2: {
      switch(act){
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;
        // nastav popis
        case 1: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
        }

      }
    } // case 0 end
    break;
    case 3: {
      switch(act){
        case 0:
          KU_DM_Effects_Wand_SetTokens(iState);
          break;
        // znic object
        case 1: {
          DestroyObject(GetLocalObject(oPC,"ku_dlg_targeteffect"));
          break;
        }
        //vyber dalsi object
        case 2: {
          int iCnt = GetLocalInt(oPC,"ku_dlg_targeteffect") + 1;
          object oEff = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,lTarget,iCnt);
          SetLocalObject(oPC,"ku_dlg_targeteffect",oEff);
          SetLocalInt(oPC,"ku_dlg_targeteffect",iCnt);
        }

      }
    } // case 0 end
    break;
  } // Switch state end

  // back
  if(act==9) {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_Effects_Wand_SetTokens(0);
  }

}


void KU_DM_Effects_Wand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }


  object oTargetEffect = GetLocalObject(GetPCSpeaker(),"ku_dlg_targeteffect");
//  SetLocalInt(oPC,KU_DLG+"state",iState);
//  SendMessageToPC(GetPCSpeaker(),"Tokens: state = "+IntToString(iState));

  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka uprav NPC zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Vytvor okamzity efekt");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Vytvor trvaly efekt");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odstran nejblizsi efekt");
        break;

    // okamzity efekt
    case 1:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber efekt");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Hellball");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Nastavit jako nazev");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;

  // Vytvorit trvaly efekt
  case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Zadne efekty tu zatim nejsou ;).");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
  // odstranit efekt
  case 3:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Odstranit" +GetName(oTargetEffect)+" ("+GetTag(oTargetEffect)+")");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Dalsi");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Zpet");
        break;
  } // switch act  end


}

/********************************************
******** DM HULKA STATU N(PC) POSTAV ********
*********************************************/


void KU_DMW_GetFeatList(object oPC) {

  int iHD = GetHitDice(oPC);
  int i,iKnown;
  int ifcnt = 0;
  string sFeat;
  string sFeatList = ";";


//  SpeakString("*********** #2 detection ");
  ifcnt = GetTotalKnownFeats(oPC);
  for(i=0;i<ifcnt;i++) {
    iKnown = GetKnownFeat(oPC,i);
    sFeat = IntToString(iKnown);
    SetLocalInt(oPC,KU_DLG+"KNOWN_FEAT_"+IntToString(i),iKnown);
    sFeatList = sFeatList+sFeat+";";
//    SpeakString("Index "+IntToString(i)+" nalezen feat "+Get2DAString("feat","LABEL",iKnown)+"("+IntToString(iKnown)+")");

  }
  SetLocalInt(oPC,KU_DLG+"KNOWN_FEATSCNT",ifcnt);
  SetLocalString(oPC,KU_DLG+"KNOWN_FEATS",sFeatList);

}

void KU_DM_CRStatsWand_Wand(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  int iState2 = GetLocalInt(oPC,KU_DLG+"state_L2");
  int iCursor = GetLocalInt(oPC,KU_DLG+"cursor");


  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;

        // Nastaveni vlastnosti - vyber vlastnosti
        case 1: {
          SetLocalInt(oPC,KU_DLG+"state",act);
          KU_DM_CRStatsWand_SetTokens(act);
          }
          break;
        // Skilly
        case 2: {
          SetLocalInt(oPC,KU_DLG+"state",3);
          KU_DM_CRStatsWand_SetTokens(3);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
          }
          break;
        // Odeber feat
        case 3: {
          SetLocalInt(oPC,KU_DLG+"state",5);
          KU_DM_CRStatsWand_SetTokens(5);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
          KU_DMW_GetFeatList(oTarget);
          }
          break;
       // Pridej feat
        case 4: {
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_CRStatsWand_SetTokens(6);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
//          KU_DMW_GetFeatList(oTarget);
          }
          break;
        // Uprav AC
        case 5: {
          SetLocalInt(oPC,KU_DLG+"state",7);
          KU_DM_CRStatsWand_SetTokens(7);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
//          KU_DMW_GetFeatList(oTarget);
          }
          break;
        // Nastav savy
        case 6: {
          SetLocalInt(oPC,KU_DLG+"state",8);
          KU_DM_CRStatsWand_SetTokens(8);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
          }
          break;
        // Nastav HP
        case 7: {
          SetLocalInt(oPC,KU_DLG+"state",10);
          KU_DM_CRStatsWand_SetTokens(10);
          SetLocalInt(oPC,KU_DLG+"state_L2",0);
          SetLocalInt(oPC,KU_DLG+"cursor",0);
//          KU_DMW_GetFeatList(oTarget);
          }
          break;
      }
      break;
    }
    // Uprava ability - vyber ability
    case 1: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }
      if(act <=6 ) {
        SetLocalInt(oPC,KU_DLG+"state_L2",act -1);
        SetLocalInt(oPC,KU_DLG+"state",2);
        KU_DM_CRStatsWand_SetTokens(2);
      }
      // zpet
      if(act == 9) {
        SetLocalInt(oPC,KU_DLG+"state",0);
        KU_DM_CRStatsWand_SetTokens(0);
      }
      break;
    }
    // Uprava ability - zmena hodnoty ability
    case 2: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }
      if(iState2 <0 || iState2 > 5) {
          return;
        }
      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {
            ModifyAbilityScore(oTarget,iState2,iVal);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"ABILITY "+Get2DAString("iprp_abilities","Label",iState2), iVal);
            }
            KU_DM_CRStatsWand_SetTokens(2);
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",1);
          KU_DM_CRStatsWand_SetTokens(1);
          break;

      }
      break;
    }

    // Skilly - vyber skillu
    case 3: {
      switch(act) {
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;
        //prev
        case 1:
          iCursor = iCursor - 6;
          if(iCursor < 0) {
            iCursor = 0;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        case 8:
          iCursor = iCursor + 6;
          if(iCursor > TOTAL_SKILLS) {
            iCursor = TOTAL_SKILLS -5;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;
        default:
          SetLocalInt(oPC,KU_DLG+"state_L2",act - 2+iCursor);
          SetLocalInt(oPC,KU_DLG+"state",4);
          KU_DM_CRStatsWand_SetTokens(4);
          break;


      } //act switch end

    }
    break;
    // Uprava skillu - zmena hodnoty skillu
    case 4: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"Skill "+Get2DAString("skills","Label",iState2), iVal);
            }
            ModifySkillRank(oTarget,iState2,iVal);
            KU_DM_CRStatsWand_SetTokens(4);
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",3);
          KU_DM_CRStatsWand_SetTokens(3);
          break;

      }
      break;
    }
    // Featy - odeber feat
    case 5: {
      int iFeatCnt = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEATSCNT");
      switch(act) {
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;
        //prev
        case 1:
          iCursor = iCursor - 6;
          if(iCursor < 0) {
            iCursor = 0;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //next
        case 8:
          iCursor = iCursor + 6;
          if(iCursor > iFeatCnt) {
            iCursor = iFeatCnt -5;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //back
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;
        // remove feat
        default: {
          int iPos = act - 2+iCursor;
          int iFeat = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEAT_"+IntToString(iPos));
          if(GetHasFeat(iFeat,oTarget)) {
            RemoveKnownFeat(oTarget,iFeat);
            KU_DMW_GetFeatList(oTarget);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"RemFEAT "+Get2DAString("feat","Label",iFeat), -1);
            }
          }
//          SetLocalInt(oPC,KU_DLG+"state_L2",act - 2+iCursor);
          SetLocalInt(oPC,KU_DLG+"state",5);
          KU_DM_CRStatsWand_SetTokens(5);
          }
          break;


      } //act switch end

    }
    break;
    // Featy - pridej feat
    case 6: {
      switch(act) {
        case 0:
          KU_DM_CRStatsWand_SetTokens(iState);
          break;
        //prev
        case 1:
          iCursor = iCursor - 6;
          if(iCursor < 0) {
            iCursor = 0;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //next
        case 8:
          iCursor = iCursor + 6;
          if(iCursor > TOTAL_FEATS) {
            iCursor = TOTAL_FEATS -5;
          }
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          break;
        //back
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;
        // remove feat
        default: {
          int iFeat = GetLocalInt(oPC,KU_DLG+"feat_at_pos"+IntToString(act));
          if(!GetHasFeat(iFeat,oTarget)) {
            AddKnownFeat(oTarget,iFeat);
//            KU_DMW_GetFeatList(oTarget);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"AddFEAT "+Get2DAString("feat","Label",iFeat), 1);
            }
          }
//          SetLocalInt(oPC,KU_DLG+"state_L2",act - 2+iCursor);
          SetLocalInt(oPC,KU_DLG+"state",6);
          KU_DM_CRStatsWand_SetTokens(6);
          }
          break;


      } //act switch end

    }
    break;
    // Uprava AC - zmena hodnoty AC
    case 7: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {

            SetACNaturalBase(oTarget,GetACNaturalBase(oTarget)+iVal);
            KU_DM_CRStatsWand_SetTokens(7);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"AC change", iVal);
            }
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;

      }
      break;
    }
    break;
    // Uprava savu - vyber savu
    case 8: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }
      if(act <=4 ) {
        SetLocalInt(oPC,KU_DLG+"state_L2",act -1);
        SetLocalInt(oPC,KU_DLG+"state",9);
        KU_DM_CRStatsWand_SetTokens(9);
      }
      // zpet
      if(act == 9) {
        SetLocalInt(oPC,KU_DLG+"state",0);
        KU_DM_CRStatsWand_SetTokens(0);
      }
      break;
    }
    // End AC
    // Uprava savu - zmena hodnoty savu
    case 9: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 10;
        case 2: if(iVal == 0) iVal = 5;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -5;
        case 6: if(iVal == 0) iVal = -10;
          {
            ModifySavingThrowBonus(oTarget,iState2,iVal);
            KU_DM_CRStatsWand_SetTokens(9);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"Save "+Get2DAString("iprp_savingthrow","NameString",iState2), iVal);
            }
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",8);
          KU_DM_CRStatsWand_SetTokens(8);
          break;

      }
      break;
    }
     // Uprava HP - zmena hodnoty HP
    case 10: {
      if(act == 0) {
        KU_DM_CRStatsWand_SetTokens(iState);
        break;
      }

      int iVal = FALSE;
      switch(act) {
        case 0: KU_DM_CRStatsWand_SetTokens(iState);
          break;
        case 1: if(iVal == 0) iVal = 100;
        case 2: if(iVal == 0) iVal = 10;
        case 3: if(iVal == 0) iVal = 1;
        case 4: if(iVal == 0) iVal = -1;
        case 5: if(iVal == 0) iVal = -10;
        case 6: if(iVal == 0) iVal = -100;
          {
            SetMaxHitPoints(oTarget,GetMaxHitPoints(oTarget)+iVal);
//            SetCurrentHitPoints(oTarget,GetMaxHitPoints(oTarget)+iVal);
            KU_DM_CRStatsWand_SetTokens(10);
            // Log it
            if(GetIsPC(oTarget)) {
              LogDMAction(oPC,oTarget,"HP change", iVal);
            }
          }
          break;
        // zpet
        case 9:
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_CRStatsWand_SetTokens(0);
          break;

      }
      break;
    }
    break;
  } // Switch state end

}



void KU_DM_CRStatsWand_SetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
  int iState2 = GetLocalInt(oPC,KU_DLG+"state_L2");
  int iCursor = GetLocalInt(oPC,KU_DLG+"cursor");
  int iFeatCnt = 0;


  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka uprav statu postavy (PC/NPC) zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Uprav vlastnost");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Uprav skill");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odeber feat");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Pridej feat");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Uprav AC");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Uprav savy");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"Uprav HP (nefunguje na PC)");
        break;

    // Ability
/*
int    ABILITY_STRENGTH         = 0; // should be the same as in nwseffectlist.cpp
int    ABILITY_DEXTERITY        = 1;
int    ABILITY_CONSTITUTION     = 2;
int    ABILITY_INTELLIGENCE     = 3;
int    ABILITY_WISDOM           = 4;
int    ABILITY_CHARISMA         = 5;*/
    case 1:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber vlastnost upravovanou na "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Strength");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Dexterity");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Constitution");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Intelligence");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Wisdom");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Charisma");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // Ability - zmen hodnotu
    case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprava vlastnosti "+Get2DAString("iprp_abilities","Label",iState2)+" postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetAbilityScore(oTarget,iState2,TRUE)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // Skilly
    case 3:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber skill k uprave na "+sTargetName);
        ku_dlg_SetConv(1,0);
        if(iCursor > 0) {
          ku_dlg_SetConv(1,1);
          SetCustomToken(6301,"<<== <Predchozi>");
        }

        //sest skillu
        {
          int i = 0;
//          SpeakString("Cursor = "+IntToString(iCursor));
          while((i < 6) && (i+iCursor <= TOTAL_SKILLS)) {
//            SpeakString("Print skill number ("+IntToString(iCursor)+"+"+IntToString(i)+")");
            ku_dlg_SetConv(2+i,1);
            SetCustomToken(6302+i,Get2DAString("skills","Label",i+iCursor));
            i++;
          }
        }
        ku_dlg_SetConv(8,0);
        if( iCursor+5 < TOTAL_SKILLS) {
          ku_dlg_SetConv(8,1);
          SetCustomToken(6308,"<Dalsi> ==>>");
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // Skilly - zmen hodnotu
    case 4:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprava skillu "+Get2DAString("skills","Label",iState2)+" postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetSkillRank(iState2,oTarget,TRUE)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Odebrani featu - vyber feat
    case 5:
        iFeatCnt = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEATSCNT");
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Odeber feat na "+sTargetName);
        ku_dlg_SetConv(1,0);
        if(iCursor > 0) {
          ku_dlg_SetConv(1,1);
          SetCustomToken(6301,"<<== <Predchozi>");
        }
        //sest featu
        {
//          SetLocalString(oPC,KU_DLG+"KNOWN_FEATS",sFeatList);
          int i = 0;
//          SpeakString("Cursor = "+IntToString(iCursor));
          while((i < 6) && (i+iCursor < iFeatCnt)) {
//            SpeakString("Print skill number ("+IntToString(iCursor)+"+"+IntToString(i)+")");
            ku_dlg_SetConv(2+i,1);
            int iFeat = GetLocalInt(oTarget,KU_DLG+"KNOWN_FEAT_"+IntToString(i+iCursor));
            SetCustomToken(6302+i,Get2DAString("feat","LABEL",iFeat)+"("+IntToString(iFeat)+")");
            i++;
          }
        }
        ku_dlg_SetConv(8,0);
        if( iCursor+5 < iFeatCnt) {
          ku_dlg_SetConv(8,1);
          SetCustomToken(6308,"<Dalsi>> ==>");
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Pridej feat
     case 6: {
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Vyber Feat k pridani na "+sTargetName+".     Pro skok na vzdaleny feat napis /dmc cursor <cislo featu> a zmackni dalsi/predchozi");
        ku_dlg_SetConv(1,0);
        if(iCursor > 0) {
          ku_dlg_SetConv(1,1);
          SetCustomToken(6301,"<<== <Predchozi>");
        }

        //list sest featu
        int iList = 0;
        {
          int i = 0;
//          SpeakString("Cursor = "+IntToString(iCursor));
          iList = iCursor;
          while((i < 6) && (iList <= TOTAL_FEATS)) {
//            SpeakString("Print skill number ("+IntToString(iCursor)+"+"+IntToString(i)+")");
            string sFeat = Get2DAString("feat","LABEL",iList);
            if(sFeat == "" ||  GetHasFeat(iList,oTarget)) {
              iList++;
              continue;
            }
            ku_dlg_SetConv(2+i,1);
            SetLocalInt(oPC,KU_DLG+"feat_at_pos"+IntToString(i+2),iList);
            SetCustomToken(6302+i,Get2DAString("feat","LABEL",iList)+" ("+IntToString(iList)+")");
            i++;
            iList++;
          }
        }
        ku_dlg_SetConv(8,0);
        if( iList-1 < TOTAL_FEATS) {
          ku_dlg_SetConv(8,1);
          SetCustomToken(6308,"<Dalsi> ==>>");
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        }
        break;
    // AC - uprav AC
    case 7:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprav AC postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetACNaturalBase(oTarget)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Save - vyber save
    case 8:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprav AC postavy "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetACNaturalBase(oTarget)));
        ku_dlg_SetConv(1,0);
        SetCustomToken(6301,"All");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Fortitude");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Reflex");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Will");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
     // Save - uprav save
    case 9:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        {
          string sSave = "";
          switch(iState2) {
            case 0: sSave ="All"; break;
            case 1: sSave ="Fortitude"; break;
            case 2: sSave ="Reflex"; break;
            case 3: sSave ="Will"; break;
          }
          SetCustomToken(6300,"Uprav save "+sSave+" postavy "
                             +sTargetName+" Aktualni hodnota je :"+IntToString(GetSavingThrowBonus(oTarget,iState2)));
        }
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+10");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+5");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-5");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-10");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;
    // HP - uprav HP
    case 10:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Uprav HP postavy - funguje pouze pro NPC "
                            +sTargetName+" Aktualni hodnota je :"+IntToString(GetMaxHitPoints(oTarget)));
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"+100");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"+10");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"+1");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"-1");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"-10");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"-100");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"<<Zpet>>");
        break;

  } // switch act  end


}


/*****************************************
 *****************************************
 ********* Portaly ***********************
 *****************************************/

void KU_DMPortalsSetTransitionScript(object oTarget) {

  int iEvent = PLACEABLE_SCRIPT_USED;
  switch(GetObjectType(oTarget)) {
    case OBJECT_TYPE_DOOR: iEvent = DOOR_SCRIPT_TRANSITION_CLICK; break;
    case OBJECT_TYPE_PLACEABLE: iEvent = PLACEABLE_SCRIPT_USED; break;
    case OBJECT_TYPE_TRIGGER: iEvent = TRIGGER_SCRIPT_TRANSITION_CLICK; break;
  }
  SetScript(oTarget, iEvent, "funcsext_trgclk");
}

void KU_DM_PortalsAct(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  location lTarget = GetLocalLocation(oPC,KU_WAND_TARGET_LOC);
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );

  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_PortalsSetTokens(iState);
          break;

        // Zacni portal na objektu
        case 1: {
          SetLocalObject(oPC,"KU_TRANS_A",oTarget);
          string sTag = "trans_"+GetStringLeft(GetPCPlayerName(oPC),10)+IntToString(ku_GetTimeStamp());
          SetLocalString(oPC,"KU_TRANS_TAG",sTag);
          SendMessageToPC(oPC,"***** Portal zapocat ****** ");
          ku_dlg_SetConv(0,0);
        }
        break;
        // Zacni portal trigger
        case 2: {
          string sTag = "trans_"+GetStringLeft(GetPCPlayerName(oPC),10)+IntToString(ku_GetTimeStamp());
          object oTrans = CreateAreaTransitionAtLocation(lTarget,AREA_TRANSITION_LINK_NONE,sTag,1.0,sTag);
          SetLocalObject(oPC,"KU_TRANS_A",oTrans);
          SetLocalString(oPC,"KU_TRANS_TAG",sTag);
          SendMessageToPC(oPC,"***** Portal zapocat ****** ");
          ku_dlg_SetConv(0,0);
        }
        break;
        // Dokonci na objektu
        case 3: {
          object oTransA = GetLocalObject(oPC,"KU_TRANS_A");
          if(!GetIsObjectValid(oTransA)) {
            return;
          }
          if(!GetIsObjectValid(oTarget)) {
            return;
          }
          SetLocalObject(oTarget,"FUNCSEXT_TRANSITION_TARGET",oTransA);
          SetLocalObject(oTransA,"FUNCSEXT_TRANSITION_TARGET",oTarget);

          KU_DMPortalsSetTransitionScript(oTarget);
          KU_DMPortalsSetTransitionScript(oTransA);

          SendMessageToPC(oPC,"***** Portal dokoncen ****** ");
          ku_dlg_SetConv(0,0);
        }
        break;
        // Dokonci jako trigger
        case 4: {
          object oTransA = GetLocalObject(oPC,"KU_TRANS_A");
          if(!GetIsObjectValid(oTransA)) {
            return;
          }
          string sTag = GetLocalString(oPC,"KU_TRANS_TAG");
          object oTransB = CreateAreaTransitionAtLocation(lTarget,AREA_TRANSITION_LINK_NONE,sTag,1.0,sTag);

          SetLocalObject(oTransB,"FUNCSEXT_TRANSITION_TARGET",oTransA);
          SetLocalObject(oTransA,"FUNCSEXT_TRANSITION_TARGET",oTransB);

          KU_DMPortalsSetTransitionScript(oTransB);
          KU_DMPortalsSetTransitionScript(oTransA);
          SendMessageToPC(oPC,"***** Portal dokoncen ****** ");
          ku_dlg_SetConv(0,0);

        }
        break;
        // Smaz prechod
        case 5: {
          object oTrans = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER,lTarget,1);
          if(!GetIsObjectValid(oTrans)) {
            SendMessageToPC(oPC,"Trigger nenalezen!");
            break;
          }
          AssignCommand(oTrans,SpeakString("Prechod zacilen ke zniceni!"));
          SetLocalObject(oPC,"KU_TRANS_A",oTrans);
          SetLocalInt(oPC,KU_DLG+"cursor",1);
          SetLocalInt(oPC,KU_DLG+"state",1);
          KU_DM_PortalsSetTokens(1);
        }
        break;
      }
    break;
    }
    case 1: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_PortalsSetTokens(iState);
          break;

        // odstran trigger
        case 1: {
          object oTrans = GetLocalObject(oPC,"KU_TRANS_A");
          if(GetIsObjectValid(oTrans)) {
            AssignCommand(oTrans,SpeakString("Nicim prechod!"));
            DestroyObject(oTrans);
            ku_dlg_SetConv(0,0);
          }
          SendMessageToPC(oPC,"Chyba: Ztratil se zacileny trigger!");
        }
        break;
        // Dalsi prechod
        case 2: {
          int iCursor = GetLocalInt(oPC,KU_DLG+"cursor") + 1;
          object oTrans = GetNearestObjectToLocation(OBJECT_TYPE_TRIGGER,lTarget,iCursor);
          if(!GetIsObjectValid(oTrans)) {
            SendMessageToPC(oPC,"Trigger nenalezen!");
            break;
          }
          AssignCommand(oTrans,SpeakString("Prechod zacilen ke zniceni!"));
          SetLocalObject(oPC,"KU_TRANS_A",oTrans);
          SetLocalInt(oPC,KU_DLG+"cursor",iCursor);
          SetLocalInt(oPC,KU_DLG+"state",1);
          KU_DM_PortalsSetTokens(1);
        }
        break;
        //Zpet
        case 3: {
          SetLocalInt(oPC,KU_DLG+"state",0);
          KU_DM_PortalsSetTokens(0);

        }
        break;
      }
    break;
    }
  }
}


void KU_DM_PortalsSetTokens(int iState, object oPC = OBJECT_INVALID) {
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
  object oTransA = GetLocalObject(oPC,"KU_TRANS_A");


  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka portalu zamirena na: "+sTargetName);
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Zacni portal na objektu");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Zacni prechod na tomto miste.");
        if(GetIsObjectValid(oTransA)) {
          ku_dlg_SetConv(3,1);
          SetCustomToken(6303,"Dokonci portal timto objektem.");
          ku_dlg_SetConv(4,1);
          SetCustomToken(6304,"Dokonci portal prechodem zde.");
        }
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Smaz nejblizsi prechod");
        break;
    case 1:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Smazat prechod "+GetTag(oTransA)+"?");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Smazat");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Jiny");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Zpet");
        break;
  } // switch act  end


}


/***********************************
***** FRAKCE ***********************
***********************************/


void KU_DM_FactionsAct(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  location lTarget = GetLocalLocation(oPC,KU_WAND_TARGET_LOC);
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );

/*  switch(iState) {
    // Spusteni hulky
    case 0: {*/
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DM_FactionsSetTokens(iState);
          break;
        // +8
        case 1:
          SetLocalInt(oPC,KU_DLG+"state",iState + 8);
          break;
        // -8
        case 10:
          iState = iState -8;
          if(iState < 0)
            iState == 0;
          SetLocalInt(oPC,KU_DLG+"state",iState);
          break;
        // Set faction
        default: {
          int iFaction = iState + act-1;
          string sFaction = GetFactionByID(iFaction);

          SetNPCFaction(oTarget, sFaction);
          SendMessageToPC(oPC,GetName(oTarget)+" - Nastavena frakce:"+sFaction);
        }
        break;
      }
/*    break;
    }
  }*/
}


void KU_DM_FactionsSetTokens(int iState, object oPC = OBJECT_INVALID) {
  int i;
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }

  int shift = iState;
/*  switch(iState) {
    // Init hulky
    case 0:*/
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"DM hulka zamirena na: "+sTargetName+"; Aktuální frakce: "+GetNPCFaction(oTarget)+" Nastav:");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Předchozí");
        for(i = 1; i < 8; i++) {
          ku_dlg_SetConv(shift + i + 1,1);
          SetCustomToken(6300 + shift + i + 1,"#"+IntToString(shift + i)+" "+GetFactionByID(shift + i));
        }
        ku_dlg_SetConv(10,1);
        SetCustomToken(6310,"Další");
/*        break;
  } // switch act  end*/


}

/****************************************
 ****** PC/DM kostky ****************
 *************************************/

void KU_DicesSayThrow(object oPC, object oTarget, int iThrow, int iDice, int iVisibility, string sText = "") {
  string sSay = GetName(oTarget)+" hazi d("+IntToString(iDice)+")"+sText+" : "+IntToString(iThrow);
  string sFloat = "Hod d("+IntToString(iDice)+") "+sText+" : "+IntToString(iThrow);

  SendMessageToPC(oPC,sSay);

  // Tel to DM/ targeted player
  if(iVisibility == 2) {
    if(GetIsDM(oPC)) {
      if(GetIsPC(oTarget))
        SendMessageToPC(oTarget, sSay);
    }
    else
      SendMessageToAllDMs(sSay);
    return;
  }

  // Tell to all around
  if(iVisibility == 3) {
    FloatingTextStringOnCreature(sFloat, oTarget, FALSE);
    object oTell = GetFirstPC();
    while(GetIsObjectValid(oTell)) {
      if( oPC != oTell) {
        if(iVisibility == 3) {
          float fDistance = GetDistanceBetween(oPC, oTell);
          if(fDistance > 0.0 &&
             fDistance < 20.1)
            SendMessageToPC(oTell,sSay);
        }
      }
      oTell = GetNextPC();
    }
  }

}

string __abilityToString(int Ability) {
  switch(Ability) {
    case 0: return "Silu";
    case 1: return "Obratnost";
    case 2: return "Odolnost";
    case 3: return "Intelingenci";
    case 4: return "Moudrost";
    case 5: return "Charisma";
  }
  return "";
}

string __saveToString(int iSave) {
   switch(iSave) {
     case 1: return "Obecnou zachranu";
     case 2: return "Fortitude";
     case 3: return "Reflex";
     case 4: return "Will";
   }
   return "";
}

int KU_DicesDoThrow(object oPC,object oTarget) {
  object oSoul = GetSoulStone(oPC);
  if(GetIsDM(oPC))
    oSoul = oPC;

  int iVisibility = GetLocalInt(oSoul,"KU_DICES_VISIBILITY");
  int iType1 = GetLocalInt(oPC,"KU_DICES_TYPE1");
  int iType2 = GetLocalInt(oPC,"KU_DICES_TYPE2");
  int iDice = GetLocalInt(oPC, "KU_DICES_DICE");

  int iThrow = Random(iDice) + 1;
  if(iType1 == 4) {
    KU_DicesSayThrow(oPC, oTarget, iThrow, iDice, iVisibility, "");
    return iThrow;
  }

  string sAdd = "";
  int iAdd = 0;
  switch(iType1) {
    case 1:
      iAdd = GetAbilityModifier(iType2, oTarget);
      sAdd = __abilityToString(iType2);
      break;
    case 2:
      switch(iType2) {
        case 1: iAdd = 0; break;
        case 2: GetFortitudeSavingThrow(oTarget); break;
        case 3: GetReflexSavingThrow(oTarget); break;
        case 4: GetWillSavingThrow(oTarget); break;
      }
      sAdd = __saveToString(iType2);
      break;
    case 3:
      iAdd =  GetSkillRank(iType2, oTarget);
      sAdd = Get2DAString("skills","Label",iType2);
      break;
  }
  KU_DicesSayThrow(oPC, oTarget, iThrow + iAdd, iDice, iVisibility, "na "+sAdd);
  return iThrow;

}


void KU_DicesAct(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  location lTarget = GetLocalLocation(oPC,KU_WAND_TARGET_LOC);
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  object oSoul = GetSoulStone(oPC);

  if(GetIsDM(oPC)) {
    oSoul = oPC;
  }

  // Only DM can do throw on others
  if(!GetIsDM(oPC))
    oTarget = oPC;

  // Back - same for all states
  if(act == 10) {
    iState = iState /10;
    SetLocalInt(oPC,KU_DLG+"state",iState);
    return;
  }

  switch(iState) {
    // Spusteni hulky
    case 0: {
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        // Moving in dialog
        case 1:
        case 2:
          SetLocalInt(oPC,KU_DLG+"state",act);
          break;
        // Do throw
        case 9:
          KU_DicesDoThrow(oPC, oTarget);
          break;
      }
    break;
    }
    // Set visibility
    case 1:
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        // Moving in dialog
        case 1:
        case 2:
        case 3:
          SetLocalInt(oSoul,"KU_DICES_VISIBILITY",act);
          SetLocalInt(oPC,KU_DLG+"state",0);
          break;
      }
      break;
    // Set throw type
    case 2:
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        // Moving in dialog
        case 1:
        case 2:
        case 3:
        case 4:
          SetLocalInt(oPC,"KU_DICES_TYPE1",act);
          SetLocalInt(oPC,KU_DLG+"state",20 + act);
          break;
      }
      break;
    // Ability throw
    case 21:
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
          SetLocalInt(oPC,"KU_DICES_TYPE2",act - 1);
          SetLocalInt(oPC,KU_DLG+"state",24);
          break;
      }
      break;
    // Save throw
    case 22:
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          SetLocalInt(oPC,"KU_DICES_TYPE2",act);
          SetLocalInt(oPC,KU_DLG+"state",24);
          break;
      }
      break;
    // Skill throw
    case 23:
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        // Moving in dialog
        case 9: {
          int iDlgShift = GetLocalInt(oPC, KU_DLG+"shift");
          iDlgShift = iDlgShift + 8;
          if(iDlgShift > 27)
            iDlgShift = 0;
          SetLocalInt(oPC, KU_DLG+"shift", iDlgShift);
          break;
        }
        default:
          SetLocalInt(oPC,"KU_DICES_TYPE2",act - 1 + GetLocalInt(oPC, KU_DLG+"shift"));
          SetLocalInt(oPC,KU_DLG+"state",24);
          break;
      }
      break;
    // Choose Dice and throw
    case 24:
      int iDice = 2;
      switch(act) {
        // Nic nezmacknuto
        case 0:
          KU_DicesSetTokens(iState);
          break;
        case 1: iDice = 2; break;
        case 2: iDice = 4; break;
        case 3: iDice = 6; break;
        case 4: iDice = 10; break;
        case 5: iDice = 12; break;
        case 6: iDice = 20; break;
        case 7: iDice = 100; break;
      }
      if(act > 0) {
        SetLocalInt(oPC,"KU_DICES_DICE",iDice);
        SetLocalInt(oPC,KU_DLG+"state",0);
        KU_DicesDoThrow(oPC, oTarget);
      }
      break;
  }
}

void KU_DicesSetTokens(int iState, object oPC = OBJECT_INVALID) {
  int i;
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }
  int bIsDM = GetIsDM(oPC);
  int iDlgShift = GetLocalInt(oPC, KU_DLG+"shift");
  int shift = iState;
  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Hracske kostky:");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Viditelnost hodu");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Typ hodu");
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Opakovat hod");
        break;
    //Viditelnost hodu
    case 1:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Kdo uvidi hod:");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Jen ja");
        ku_dlg_SetConv(2,1);
        if(bIsDM)
          SetCustomToken(6302,"DM a hráč");
        else
          SetCustomToken(6302,"Ja a DM");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Vsichni okolo" );
        ku_dlg_SetConv(10,1);
        SetCustomToken(6310,"Zpet");
        break;
    //Typ hody hodu
    case 2:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Na co chces hazet:");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Vlastnost (Ability)");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Zachrana (Save)");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Skill" );
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Jen tak" );
        ku_dlg_SetConv(10,1);
        SetCustomToken(6310,"Zpet");
        break;
    // Ability throw
    case 21:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Hazet na vlastnost:");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"Sila");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Obratnost");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Odolnost" );
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Inteligence" );
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"Moudrost" );
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"Charisma" );
        ku_dlg_SetConv(10,1);
        SetCustomToken(6310,"Zpet");
        break;
    // Save throw
    case 22:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Hazet na Zachranu:");
//        ku_dlg_SetConv(1,1);
//        SetCustomToken(6301,"Obecný");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"Fortitude");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"Reflex" );
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"Will" );
        ku_dlg_SetConv(10,1);
        SetCustomToken(6310,"Zpet");
        break;
    // Skill
    case 23:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Hazet na skill");
        for(i=0;i < 8; i++) {
          ku_dlg_SetConv(i+1,1);
          SetCustomToken(6300 + i + 1,Get2DAString("skills","Label",i + iDlgShift));
        }
        ku_dlg_SetConv(9,1);
        SetCustomToken(6309,"Dalsi skill");
        ku_dlg_SetConv(10,1);
        SetCustomToken(6310,"Zpet");
        break;
    // Choose dice
    case 24:
        ku_dlg_SetAll(0);
        ku_dlg_SetConv(0,1);
        SetCustomToken(6300,"Kostka:");
        ku_dlg_SetConv(1,1);
        SetCustomToken(6301,"d2");
        ku_dlg_SetConv(2,1);
        SetCustomToken(6302,"d4");
        ku_dlg_SetConv(3,1);
        SetCustomToken(6303,"d6");
        ku_dlg_SetConv(4,1);
        SetCustomToken(6304,"d10");
        ku_dlg_SetConv(5,1);
        SetCustomToken(6305,"d12");
        ku_dlg_SetConv(6,1);
        SetCustomToken(6306,"d20");
        ku_dlg_SetConv(7,1);
        SetCustomToken(6307,"d100");
        break;
  } // switch act  end

}


//**//////////////////////////////////////////////////
//** Summons book
//**/////////////////////////////////////////////////

string __getSummoningClass(object oPC) {

  if(GetLevelByClass(CLASS_TYPE_WIZARD, oPC) > 0)
    return "CLS_WIZ";

  if(GetLevelByClass(CLASS_TYPE_CLERIC, oPC) > 0)
    return "CLS_CLER";

  if(GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0)
    return "CLS_DRUID";

  if(GetLevelByClass(CLASS_TYPE_BARD, oPC) > 0)
    return "CLS_BARD";

  return "";
}

void KU_SummonsSetTokens(int iState, object oPC = OBJECT_INVALID) {
  int i;
  if(oPC == OBJECT_INVALID) {
    oPC = GetPCSpeaker();
  }
  object oTarget = GetLocalObject(oPC,KU_WAND_TARGET );
  string sTargetName = "Nic";
  if(GetIsObjectValid(oTarget)) {
    sTargetName = GetName(oTarget)+" v lokaci "+GetName(GetArea(oTarget));
  }

  string sClass = __getSummoningClass(oPC);
  int nAlignment;
  switch(GetAlignmentGoodEvil(oPC)) {
    case ALIGNMENT_EVIL: nAlignment = 16; break;
    case ALIGNMENT_GOOD: nAlignment = 8; break;
    case ALIGNMENT_NEUTRAL: nAlignment = 1; break;
  }


  int bIsDM = GetIsDM(oPC);
  int iDlgShift = GetLocalInt(oPC, KU_DLG+"shift");
  int shift = iState;
  switch(iState) {
    // Init hulky
    case 0:
        ku_dlg_SetAll(0);
        __dlgSetToken(0,"Kniha povolavani. Zvol kruh.");
        __dlgSetToken(1," I.");
        __dlgSetToken(2," II.");
        __dlgSetToken(3," III.");
        __dlgSetToken(4," IV.");
        __dlgSetToken(5," V.");
        __dlgSetToken(6," VI.");
        __dlgSetToken(7," VII.");
        __dlgSetToken(8," VIII.");
        __dlgSetToken(9," IX.");
        break;
    // All summon levels
    default:
      ku_dlg_SetAll(0);
      __dlgSetToken(0,"Kniha povolavani. "+IntToString(iState)+". kruh.");

      int sum = 0;
      int iSummonAlignment;
      int iRow;
      for(sum = 0; sum <= 8; sum++) { // We have 8 types of summons
        iRow = sum * 9 + iState - 1; //9 levels of summons
        iSummonAlignment = StringToInt(Get2DAString("summon","ALIGNMENT",iRow));
        // Check summoner alignment
        if((iSummonAlignment & nAlignment) == 0)
          continue;

        // Check aviability for class
        if(Get2DAString("summon",sClass,iRow) == "0")
          continue;

        __dlgSetToken(sum+1,Get2DAString("summon","NAME",iRow));
      }
      __dlgSetToken(10," Zpet.");
   }

}

void KU_SummonsAct(int act) {
  object oPC = GetPCSpeaker();
  int iState = GetLocalInt(oPC,KU_DLG+"state");
  object oSoul = GetSoulStone(oPC);

  // Back - same for all states
  if(act == 10) {
    iState = 0;
    SetLocalInt(oPC,KU_DLG+"state",iState);
    return;
  }

  // Do nothing
  if(act == 0) {
    KU_SummonsSetTokens(iState);
    return;
  }

  switch(iState) {
    // Spusteni hulky
    case 0: {
      SetLocalInt(oPC,KU_DLG+"state",act);
      break;
    }
    // Set summon
    default: {
//      int iRow = (iState-1) * 9 + act -1 ; //9 levels of summons
      int iRow = (act-1) * 9 + iState - 1; //9 levels of summons
      SetLocalString(oSoul,"KU_SUMMON_"+IntToString(iState),Get2DAString("summon","BASERESREF",iRow) + "0" + IntToString(iState));
      SendMessageToPC(oPC, "Vybran "+Get2DAString("summon","NAME",iRow)+" pro "+IntToString(iState)+". kruh.");
    }
  }

  iState = GetLocalInt(oPC,KU_DLG+"state");
  KU_SummonsSetTokens(iState);
}
