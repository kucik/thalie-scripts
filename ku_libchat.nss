/* ku_libchat script
 * Library used to handle player chat commands

 * Created: 19. 10. 2008
 * rev. Kucik 05.01.2008 Pridano ukladani postavy

 * coding test: "Øešeto ožužlává knížeèku s pìkným názvem 'Ó náš kùò jménem ŽŠÈØ(CJ)ÏÒ'."
*/
#include "ja_lib"
#include "nwnx_funcs"
#include "x0_i0_position"
#include "strings_inc"
#include "ku_exp_inc"

const int KU_CHAT_CACHE_SIZE = 50;
const string KU_CHAT_CACHE = "KU_CHAT_CACHE_";

/* Commandy */
const int KU_CHAT_CMD_EMO = 1;
const int KU_CHAT_CMD_SOUL = 2;
const int KU_CHAT_CMD_SIT = 3;
const int KU_CHAT_CMD_SLOW = 4;
const int KU_CHAT_CMD_SLOWMEW = 5;


// Functions declaration
void ku_ExecChatCommand(object oPC, string cmd, string param);
void ku_DefineChatCommand(int cmd, string str);
void ku_ChatCommand(object oPC,string mess,int volume);
void ku_RunChatCommand(object oPC,int cmdn, string param);
void ku_ChatCommandsInit();
void ku_SlowMe(int speed);
vector ku_GetSmokePossition(int iApp, int iGender);
void ku_makeSmoke(object oTarget);
void SetBackpack(object oPC, int iType);
void PerformDiceRoll(object oPC, string sParam);
void SetBodyColor(object oPC, int iChannel, int iColor, string sSubject = "");

string ku_GetLastChatMesage(object oPC) {
  int CacheIndex = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
//  CacheIndex = (CacheIndex + 1) % KU_CHAT_CACHE_SIZE;
  return GetLocalString(oPC,KU_CHAT_CACHE+IntToString(CacheIndex));
}

string sy_num_to_percent(string sText, float fMax, float fAkt, int nInvert = 0)
{
    float fPer = ( fAkt / fMax )*100;
    int   nPer = FloatToInt(fPer);
    if (nInvert==0) nPer = 100 - nPer;
    return (sText + IntToString(nPer) + " %");
}

void ku_ChatCommand(object oPC,string mess,int volume)
{
  int len = GetStringLength(mess);
  string command = GetStringRight(mess,len - 4);
  while(GetStringLeft(command,1) == " ") {
    len--;
    command = GetStringRight(command,len);
  }

  string cmd = command;
  int space = -1;
  string param = "";
  space = FindSubString(command," ");
  if(space > 0) {
    cmd = GetStringLeft(command,space);
    param = GetSubString(command,space + 1,len - space);
  }

  ku_ExecChatCommand(oPC,cmd,param);

}

void ku_ExecChatCommand(object oPC, string cmd, string param) {
//  SendMessageToPC(oPC,"Executing *"+cmd+"* with param *"+param+"*");

  object oMod = GetModule();
  int cmdn = GetLocalInt(oMod,"KU_CHATCMD"+cmd);

//  SendMessageToPC(oPC,"Executing number"+IntToString(cmdn));
  if(cmdn > 0)
    ku_RunChatCommand(oPC,cmdn,param);


//  SendMessageToPC(oPC,"Executing *"+cmd+"*");


}

void ku_RunChatCommand(object oPC,int cmdn, string param) {
  switch(cmdn) {
    case KU_CHAT_CMD_SIT:
      AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 10000.0f));
    break;
    case KU_CHAT_CMD_EMO:
      // --------------------------------------------------
      // Start emote dialog
      // --------------------------------------------------
      // SetLocalObject(oPC, "dmfi_item",GetItemPossessedBy(oPC,"dmfi_pc_emote"));
      // SetLocalObject(oPC, "dmfi_target",OBJECT_SELF);
      // SetLocalLocation(oPC, "dmfi_location",GetLocation(oPC));
      // ExecuteScriptAndReturnInt("dmfi_activate",oPC);
      AssignCommand(oPC, ActionStartConversation(oPC, "myd_emote", TRUE, FALSE));
    break;
    case KU_CHAT_CMD_SOUL: {
      //ExportSingleCharacter(oPC);
      SavePlayer(oPC);
      // Save XP and GOLD to DB
      SetPersistentInt(oPC,"XP_BACKUP",GetXP(oPC));
      SetPersistentInt(oPC,"GOLD_BACKUP",GetGold(oPC));
      //~Save XP and GOLD to DB
      float fFoodR    = GetLocalFloat(oPC, "FoodRating");
      float fWaterR   = GetLocalFloat(oPC, "WaterRating");
      float fStaminaR = GetLocalFloat(oPC, "JA_STAMINA");
      float fMaxStamina = getMaxStamina(oPC);
      float fAlcoholR = GetLocalFloat(oPC, "AlcoholRating");
      object oSoul = GetSoulStone(oPC);
      int iDebt = ku_GetXpDebt(oPC);
      SendMessageToPC(oPC,"<cX >Postih za smrt</c> : "+IntToString(iDebt) +" XP");
      SetCustomToken(7006, sy_num_to_percent("<c X >Hlad</c> : ", MAX_FOOD, fFoodR) );
      SetCustomToken(7007, sy_num_to_percent("<c XX>Zizen</c> : ", MAX_WATER, fWaterR) );
      SetCustomToken(7008, sy_num_to_percent("<cD c>Unava</c> : ", fMaxStamina, fStaminaR) );
      SetCustomToken(7009, sy_num_to_percent("<cX  >Alkohol</c> : ", MAX_ALCOHOL, fAlcoholR, 1) );

      AssignCommand(oPC, ActionStartConversation(oPC, "sy_soulstone", TRUE, FALSE));
      break;
    }
    case KU_CHAT_CMD_SLOW: {
      AssignCommand(oPC,ku_SlowMe(StringToInt(param)));
      break;
    }
/*    case 5: {
      CreateItemOnObject(param,oPC);
      break;
    }
*/
    /* DISLIKE */
    case 6: {
      object oTarget = GetFirstPC();
      int iFaction = GetFactionId (oPC);
      while(GetIsObjectValid(oTarget)) {
        if(GetFactionId (oTarget) != iFaction) {
          SetPCDislike(oPC,oTarget);
        }
        oTarget = GetNextPC();
      }
      break;
    }
    /* HELP */
    case 7: {
      SendMessageToPC(oPC,"Soupis prikazu:");
      SendMessageToPC(oPC,"/pc emo - vyvola seznam prikazu emoci");
      SendMessageToPC(oPC,"/pc duse - Ulozi postavu a vyvola dialog duse bytosti.");
      SendMessageToPC(oPC,"/pc sedni - Postava se posadi na zem.");
      SendMessageToPC(oPC,"/pc slow <cislo> - Nastavi zpomaleni postavy.");
      SendMessageToPC(oPC,"/pc dislike - Nastavi odpor vsem vyjma clunu party.");
      SendMessageToPC(oPC,"/pc portrait - Vypise nazev vaseho portretu.");
      SendMessageToPC(oPC,"/pc slowme ");
      SendMessageToPC(oPC,"/pc zpomal - Zpomali/zrusi zpomaleni pomoci pretizeni postavy.");
      SendMessageToPC(oPC,"/pc skills - Vypise hodnoty craftovych skillu.");
      SendMessageToPC(oPC,"/pc unmount ");
      SendMessageToPC(oPC,"/pc sesednout - Sesednout z kone.");
      SendMessageToPC(oPC,"/pc smoke");
      SendMessageToPC(oPC,"/pc kourit - Spusti animaci koureni.");
      SendMessageToPC(oPC,"/pc desc+ <text> - Prida odstavec do popisu postavy.");
      SendMessageToPC(oPC,"/pc desc- - Odebere posledni odstavec do popisu postavy.");
      SendMessageToPC(oPC,"/pc barvat1 <0-175> - Zmeni barvu tetovani1.");
      SendMessageToPC(oPC,"/pc barvat2 <0-175> - Zmeni barvu tetovani2.");
      SendMessageToPC(oPC,"/pc barvavlasu <0-175> - Zmeni barvu vlasu (pouze v lokaci dotvarejici postavu).");
      SendMessageToPC(oPC,"/pc barvakuze <0-175> - Zmeni barvu kuze (pouze v lokaci dotvarejici postavu).");
      SendMessageToPC(oPC,"/pc autodislike - Zapne/vypne automaticke nastavovani odporu po prihlaseni.");
      SendMessageToPC(oPC,"/pc meditace <1-3> - Zmeni animaci pri meditaci/modleni.");
      SendMessageToPC(oPC,"/pc batoh <0-11> - Zobrazi/skryje model batohu/mece atd na zadech postavy.");
      SendMessageToPC(oPC,"/pc hod <kostky> - Provede hod kostkami (pøíklad: '/pc hod k10', '/pc hod 3k6'");
      SendMessageToPC(oPC,"/pc kostky - Otevre dialog s pokrocilymi hody");
      SendMessageToPC(oPC,"/pc strip - Svlekani casti odevu.");
      SendMessageToPC(oPC,"/pc help ");
      SendMessageToPC(oPC,"/pc ? - vypise tento vypis");
      SendMessageToPC(oPC,"/h <text> - vypise text jako by mluvil tvuj kun.");
      SendMessageToPC(oPC,"/c <text> - vypise text jako by mluvil tvuj animal companion.");
      SendMessageToPC(oPC,"/f <text> - vypise text jako by mluvil tvuj familiar.");
      if(GetIsDM(oPC)) {
        SendMessageToPC(oPC,"**************************************");
        SendMessageToPC(oPC," DM ONLY :");
        SendMessageToPC(oPC,"/pc item <resref itemu> - Vytvori item do invu.");
      }
      break;
    }
    case 8: {
      SendMessageToPC(oPC,"Vas portret je: '"+GetPortrait(oPC)+"'");
      break;
    }
    case 9: {
      object oSoul = GetSoulStone(oPC);
      int iSoulWeight = GetWeight(oSoul);
      int iPCWeight = GetWeight(oPC);
//      SendMessageToPC(oPC,"Soul:"+IntToString(iSoulWeight)+" oTotal:"+IntToString(iPCWeight));

      if(iSoulWeight > 10) {
        SetItemWeight(oSoul,1);
//        SendMessageToPC(oPC,"Unsetting slow");
        //ku_pers_smisc2
        DestroyObject(CreateItemOnObject("ku_pers_smisc2",oPC,1,"tempobject"),0.2);
      }
      else {
        int iEnc = StringToInt(Get2DAString("encumbrance","Normal",GetAbilityScore(oPC,ABILITY_STRENGTH)));
//        SendMessageToPC(oPC,"Setting slow");
        int iWeight = iEnc - iPCWeight - iSoulWeight + 10;
        if(iWeight < 1) {
          iWeight = 1;
        }
        SetItemWeight(oSoul,iWeight);
        DestroyObject(CreateItemOnObject("ku_pers_smisc2",oPC,1,"tempobject"),0.2);
      }
      break;
    }
    // CNR SKILLS
    case 10: {
       int iVal, iC, iDec;
       SendMessageToPC(oPC,"==================================");
       SendMessageToPC(oPC,"== Tvoje craftove skilly jsou : ==");
       SendMessageToPC(oPC,"==================================");
       iVal = GetPersistentInt(oPC,"iHarvestSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Sber: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iMiningSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Kutani: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iSkinSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Stahovani: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iDigSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Kopani: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iSummonSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Povolavani: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iWoodCutSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Kacenii: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iFishingSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Rybareni: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iShroomSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Houbareni: "+IntToString(iC)+","+IntToString(iDec)+"%");
       iVal = GetPersistentInt(oPC,"iBeeSkill","cnr_misc");
       iC = iVal / 10;
       iDec = iVal % 10;
       SendMessageToPC(oPC,"Vcelareni: "+IntToString(iC)+","+IntToString(iDec)+"%");
       SendMessageToPC(oPC,"==================================");
       break;
    }

    // sesednout z kone
    case 11: {
      object oItem = GetItemPossessedBy(oPC,"ja_kun_getdown");
      if(GetTag(oItem) == "ja_kun_getdown"){
        SignalEvent(oPC,EventActivateItem(oItem,GetLocation(oPC),oPC));
      }
      break;
    }
    // Smoke
    case 12:
      ku_makeSmoke(oPC);
      break;

    //desc+
    case 13: {
      SendMessageToPC(oPC,"Updating desc + '"+param+"'");
      string sDesc = GetDescription(oPC);
      SetDescription(oPC, sDesc+"\n"+param);
      break;
    }
    //desc-
    case 14: {
      SendMessageToPC(oPC,"cutting desc - '"+param+"'");
      string sDesc = GetDescription(oPC);
      int iPos = GetLastOccurence(sDesc,"\n");
      if(iPos == -1) {
        sDesc = "  ";
      }
      else {
        sDesc = GetStringLeft(sDesc,iPos);
      }
      SetDescription(oPC, sDesc);
      break;
    }
    //autodislike on/off
    case 15: {
      object oSoul = GetSoulStone(oPC);
      if(GetLocalInt(oSoul,"KU_AUTODISLIKE")) {
        SendMessageToPC(oPC,"Automaticke zapinani odporu VYPNUTO.");
        SetLocalInt(oSoul, "KU_AUTODISLIKE", FALSE);
      }
      else {
        SendMessageToPC(oPC,"Automaticke zapinani odporu ZAPNUTO.");
        SetLocalInt(oSoul, "KU_AUTODISLIKE", TRUE);
      }
      break;
    }
    // Zmena animace modleni
    case 16: {
      SendMessageToPC(oPC,"Mozna nastaveni meditace jsou 1,2,3");
      int iType = StringToInt(param);
      object oSoul = GetSoulStone(oPC);
      switch(iType) {
        case 1:
          SendMessageToPC(oPC,"Nastavena meditace v klece");
          SetLocalInt(oSoul,"KU_MEDITATE_ANIM",3);
          break;
        case 2:
          SendMessageToPC(oPC,"Nastavena meditace - uctívání");
          SetLocalInt(oSoul,"KU_MEDITATE_ANIM",4);
          break;
        case 3:
          SendMessageToPC(oPC,"Nastavena meditace krec");
          SetLocalInt(oSoul,"KU_MEDITATE_ANIM",20);
          break;
        default:
          SendMessageToPC(oPC,"Neplatná hodnota: "+param);
      }
      break;
    }
    // Batoh - kridla
    case 17: {
      SetBackpack(oPC,StringToInt(param));
      break;
    }
    // Hod kostkami
    case 18: {
      PerformDiceRoll(oPC,param);
      break;
    }
    // Emote commands help list
    case 19:
      SendMessageToPC(oPC,"Soupis prikazu emoci - jednorazove:");
      SendMessageToPC(oPC,"/nod, /scratch, /salute, /bow, /greet, /wave, /steal, /taunt, /bored");
      SendMessageToPC(oPC,"/smoke");
      SendMessageToPC(oPC,"=================================");
      SendMessageToPC(oPC,"Soupis prikazu emoci - nekonecne:");
      SendMessageToPC(oPC,"/conjure1");
      SendMessageToPC(oPC,"/conjure2");
      SendMessageToPC(oPC,"/meditate");
      SendMessageToPC(oPC,"/worship");
      SendMessageToPC(oPC,"/dance");
      SendMessageToPC(oPC,"/spasm");
      SendMessageToPC(oPC,"/tired");
      SendMessageToPC(oPC,"/drunk");
      SendMessageToPC(oPC,"/laught");
      SendMessageToPC(oPC,"/beg");
      SendMessageToPC(oPC,"/looks");
      SendMessageToPC(oPC,"/threaten");
      SendMessageToPC(oPC,"/getmid");
      SendMessageToPC(oPC,"/getlow");
      SendMessageToPC(oPC,"/sit");
      SendMessageToPC(oPC,"/sitchair");
      SendMessageToPC(oPC,"/sitread");
      SendMessageToPC(oPC,"/sitdrink");
      SendMessageToPC(oPC,"/fprone");
      SendMessageToPC(oPC,"/fback");
      break;
    // Tattoo 1 color change
    case 20: {
      SetBodyColor(oPC, COLOR_CHANNEL_TATTOO_1, StringToInt(param), "tetování 1");
      break;
    }
    case 21: {
      SetBodyColor(oPC, COLOR_CHANNEL_TATTOO_2, StringToInt(param), "tetování 2");
      break;
    }
    case 22: {
      if (GetTag(GetArea(oPC)) == "th_start_gp")
          SetBodyColor(oPC, COLOR_CHANNEL_HAIR, StringToInt(param), "vlasù");
      break;
    }
    case 23: {
      if (GetTag(GetArea(oPC)) == "th_start_gp")
          SetBodyColor(oPC, COLOR_CHANNEL_SKIN, StringToInt(param), "kùže");
      break;
    }
    case 24:
      AssignCommand(oPC, ActionStartConversation(oPC, "myd_strip", TRUE, FALSE));
      break;
    case 25: {
                string KU_DLG = "KU_UNI_DIALOG";
/*                SetLocalInt(oPC,KU_DLG+"dialog",9);
                SetCustomToken(6300,"Hody kostkou");
                SetLocalInt(oPC,KU_DLG+"_allow_0",1);
                AssignCommand( oPC, ClearAllActions() );
                AssignCommand( oPC, ActionStartConversation( oPC, "ku_uni_dlg", TRUE ) );*/
      SetLocalInt(oPC,KU_DLG+"dialog",9);
      SetLocalObject(oPC,"KU_WAND_TARGET",oPC);
      ExecuteScript("ku_dlg_start",oPC);
      }
      break;
     // DM only item creation
     case 26:
      if(GetIsDM(oPC)) {
        CreateItemOnObject(param, oPC);
      }
      break;
  }
}

void ku_DefineChatCommand(int cmd, string str) {
  object oMod = GetModule();

  SetLocalInt(oMod,"KU_CHATCMD"+str,cmd);

}

void ku_ChatCommandsInit() {
   ku_DefineChatCommand(KU_CHAT_CMD_EMO,"emo");
   ku_DefineChatCommand(KU_CHAT_CMD_SOUL,"soul");
   ku_DefineChatCommand(KU_CHAT_CMD_SOUL,"duse");
   ku_DefineChatCommand(KU_CHAT_CMD_SOUL,"dusa");
   ku_DefineChatCommand(KU_CHAT_CMD_SIT,"sit");
   ku_DefineChatCommand(KU_CHAT_CMD_SIT,"sednout");
   ku_DefineChatCommand(KU_CHAT_CMD_SIT,"sedni");
   ku_DefineChatCommand(KU_CHAT_CMD_SLOW,"slow");
   ku_DefineChatCommand(KU_CHAT_CMD_SLOW,"pomalu");
//   ku_DefineChatCommand(5,"create"); //create item
   ku_DefineChatCommand(6,"dislike");
   ku_DefineChatCommand(7,"?");
   ku_DefineChatCommand(7,"help");
   ku_DefineChatCommand(8,"portrait");
   ku_DefineChatCommand(9,"slowme");
   ku_DefineChatCommand(9,"zpomal");
   ku_DefineChatCommand(10,"skills");
   ku_DefineChatCommand(11,"sesednout");
   ku_DefineChatCommand(11,"unmount");
   ku_DefineChatCommand(12,"kourit");
   ku_DefineChatCommand(12,"smoke");
   ku_DefineChatCommand(13,"desc+");
   ku_DefineChatCommand(14,"desc-");
   ku_DefineChatCommand(15,"autodislike");
   ku_DefineChatCommand(16,"meditace");
   ku_DefineChatCommand(17,"batoh");
   ku_DefineChatCommand(18,"hod");
   ku_DefineChatCommand(19,"emo ?");
   ku_DefineChatCommand(20,"barvat1");
   ku_DefineChatCommand(21,"barvat2");
   ku_DefineChatCommand(22,"barvavlasu");
   ku_DefineChatCommand(23,"barvakuze");
   ku_DefineChatCommand(24,"strip");
   ku_DefineChatCommand(25,"kostky");
   ku_DefineChatCommand(26,"item");
}

void ku_SlowMe(int speed) {
  if(speed < 0)
    return;
  object oPC = OBJECT_SELF;

  effect slow;
  int ActSlow = GetLocalInt(oPC,"KU_CHAT_CMD_SLOWEDSPEED");
  if( (ActSlow != 0) && (ActSlow != speed) ) {
    // Najdi a odstran zpomaleni
    slow = GetFirstEffect(oPC);
    while(GetIsEffectValid(slow)) {
      if( (GetEffectType(slow) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE) &&
          (GetEffectSubType(slow) == SUBTYPE_EXTRAORDINARY) &&
          (GetEffectDurationType(slow) == DURATION_TYPE_PERMANENT) &&
          (GetEffectCreator(slow) == oPC )
        )
        break;
      slow = GetNextEffect(oPC);
    }
    if(GetIsEffectValid(slow)) {
      RemoveEffect(oPC,slow);
      SendMessageToPC(oPC,"Zpomaleni zruseno");
      DeleteLocalInt(oPC,"KU_CHAT_CMD_SLOWEDSPEED");
    }
  }
  if(ActSlow == speed) {
    SendMessageToPC(oPC,"Zpomaleni "+IntToString(speed)+"% trva.");
    return;
  }

  if(speed > 0) {
    SendMessageToPC(OBJECT_SELF,"Nastavuji zpomaleni "+IntToString(speed)+"%");
    slow = EffectMovementSpeedDecrease(speed);
    slow = ExtraordinaryEffect(slow);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,slow,oPC);
    SetLocalInt(oPC,"KU_CHAT_CMD_SLOWEDSPEED",speed);
  }
}


vector ku_GetSmokePossition(int iApp, int iGender) {
  vector v;
/*  v.z = 1.73;
  v.x = 0.15;
  v.y = 0.07.*/
  float fZ, fF, fR;
  fZ =  1.73;
  fF =  0.15;
  fR = -0.07;

  if(iGender == GENDER_FEMALE) {
    switch(iApp) {
      case APPEARANCE_TYPE_DWARF:
        fZ =  1.17;
        fF =  0.15;
        fR = -0.06;
        break;
      case APPEARANCE_TYPE_ELF:
        fZ =  1.42;
        fF =  0.0;
        fR = -0.11;
        break;
      case APPEARANCE_TYPE_GNOME:
        fZ =  1.11;
        fF =  0.02;
        fR = -0.06;
        break;
      case APPEARANCE_TYPE_HALFLING:
        fZ =  1.03;
        fF =  0.02;
        fR = -0.06;
        break;
      case APPEARANCE_TYPE_HALF_ELF:
        fZ =  1.58;
        fF =  0.01;
        fR = -0.1;
        break;
      case APPEARANCE_TYPE_HALF_ORC:
        fZ =  1.75;
        fF =  0.21;
        fR = -0.1;
        break;
      case APPEARANCE_TYPE_HUMAN:
        fZ =  1.59;
        fF =  0.01;
        fR = -0.13;
        break;
      // halfogre
      case 985:
        fZ =  2.00;
        fF =  0.19;
        fR = -0.06;
        break;
    }

  }
  else {
    switch(iApp) {
      case APPEARANCE_TYPE_DWARF:
        fZ =  1.29;
        fF =  0.20;
        fR = -0.05;
        break;
      case APPEARANCE_TYPE_ELF:
        fZ =  1.54;
        fF =  0.14;
        fR = -0.07;
        break;
      case APPEARANCE_TYPE_GNOME:
        fZ =  1.19;
        fF =  0.15;
        fR = -0.07;
        break;
      case APPEARANCE_TYPE_HALFLING:
        fZ =  1.15;
        fF =  0.15;
        fR = -0.07;
        break;
      case APPEARANCE_TYPE_HALF_ELF:
      case APPEARANCE_TYPE_HUMAN:
        fZ =  1.73;
        fF =  0.15;
        fR = -0.07;
        break;
      case APPEARANCE_TYPE_HALF_ORC:
        fZ =  1.89;
        fF =  0.22;
        fR = -0.09;
        break;
      // halfogre
      case 985:
        fZ =  2.31;
        fF =  0.34;
        fR = -0.14;
        break;
      // kobold
      case 984:
        fZ =  1.03;
        fF =  0.24;
        fR = -0.06;
        break;

    }
  }
  v.z = fZ;
  v.x = fF;
  v.y = fR;

  return v;

}

void ku_makeSmoke(object oTarget) {

    int i;
    int iMultiple = 1;
    location lLoc ;
    object oArea = GetArea(oTarget);
    vector vPos = GetPosition(oTarget);
    vector v = ku_GetSmokePossition(GetAppearanceType(oTarget), GetGender(oTarget));


    vPos.z = vPos.z + v.z;
    vPos = GetChangedPosition(vPos, v.x, GetFacing(oTarget));
    vPos = GetChangedPosition(vPos, v.y, (GetFacing(oTarget)+90.0) );

// SendMessageToPC(oTarget,"Possition Z:"+FloatToString(vPos.z)+"; F:"+FloatToString(fF)+"; R:"+FloatToString(fR));

 AssignCommand(oTarget, PlayAnimation(22,0.7, 1.5));

 for(i=1;i <= iMultiple; i++) {
   lLoc = Location(oArea,vPos,IntToFloat(Random(360)));
   DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, "ku_smoke", lLoc, FALSE),5.0);
   lLoc = Location(oArea,vPos,IntToFloat(Random(360)));
   DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, "ku_smoke", lLoc, FALSE),5.0);
   lLoc = Location(oArea,vPos,IntToFloat(Random(360)));
   DelayCommand(1.5, DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, "ku_smoke", lLoc, FALSE),3.0));
   lLoc = Location(oArea,vPos,IntToFloat(Random(360)));
   DelayCommand(1.5, DestroyObject(CreateObject(OBJECT_TYPE_PLACEABLE, "ku_smoke", lLoc, FALSE),3.0));
 }


}

void SetBackpack(object oPC, int iType) {
    object oSoul = GetSoulStone(oPC);

    /* Get last used backpack */
    int iLast = GetLocalInt(oSoul,"KU_BACKPACK_LAST");
    int iActual = GetCreatureWingType(oPC);

    /* Check wings */
    if(iActual > 0 && (iActual < 79 || 89 <iActual )) {
      SendMessageToPC(oPC," S kridly neni mozne pouzit vzhled batohu.");
      return;
    }

    /* Check input */
    if(iType < 0 || iType > 11) {
      SendMessageToPC(oPC,"Neplatny model batohu "+IntToString(iType));
      return;
    }
    iType = iType + 78;

    /* Remove backpack */
    if( (iType == 78 && iActual > 0) || iType == iActual) {
      SetCreatureWingType(0, oPC);
      SendMessageToPC(oPC,"Odstranuji batoh.");
      return;
    }

    /* Use last used model */
    if(iType == 78 ) {
      if(iLast > 0) {
        iType = iLast;
      }
      /* default */
      else {
        iType = 79;
      }
    }

    /* Apply backpack */
    SendMessageToPC(oPC,"Nastaven batoh #"+IntToString(iType - 78));
    SetCreatureWingType(iType, oPC);
    SetLocalInt(oSoul,"KU_BACKPACK_LAST",iType);

}

void PerformDiceRoll(object oPC, string sParam)
{
    string sMsg;
    int iKpos = FindSubString(sParam, "k");
    int iResult = 0;
    int i;
    if (iKpos >= 0)
    {
        int iMod = StringToInt(GetSubString(sParam, 0, iKpos));
        if(iMod > 20) {
          SendMessageToPC(oPC, "Neni povoleno vice nez 20 kostek");
          return;
        }
        int iDice = StringToInt(GetStringRight(sParam, GetStringLength(sParam) - iKpos - 1));
          sMsg = "";
        for(i=1; i <= iMod; i++) {
          if(i > 1)
            sMsg = sMsg+" + ";
          int iRoll = Random(iDice) + 1;
          iResult = iResult + iRoll;;
          sMsg = sMsg+IntToString(iRoll);
        }
        if (iMod && iDice)
        {
            sMsg = "<cÍf >" + GetName(oPC) + "</c> hází " + sParam + ": <cÍf >"+sMsg+" = "+ IntToString(iResult) + "</c>";
        }
    }
    if (sMsg != "")
    {
        // Send roll result as message to PC/DM/Possessed/Familiar in radius.
        float fRadius = 6.0f;
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oPC), TRUE, OBJECT_TYPE_CREATURE);
        while (GetIsObjectValid(oTarget))
        {
            if (GetIsPC(oTarget))
            {
                if (GetIsObjectValid(GetMaster(oTarget)))
                {
                    oTarget = GetMaster(oTarget);
                }
                SendMessageToPC(oTarget, sMsg);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, GetLocation(oPC), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    else
    {
        SendMessageToPC(oPC, "Špatnì zadané parametry pro hod kostkou (pøíklady: '/pc hod k10','/pc hod 3k6').");
    }
}

void SetBodyColor(object oPC, int iChannel, int iColor, string sSubject)
{
    sSubject = sSubject != "" ? sSubject + " " : sSubject;
    int iPrevColor = GetColor(oPC, iChannel);
    if (iColor > 0 && iColor < 176)
    {
        SetColor(oPC, iChannel, iColor);
        SendMessageToPC(oPC, "Barva " + sSubject + "zmìnìna: " + IntToString(iPrevColor) + " -> " + IntToString(iColor));
    }
}
