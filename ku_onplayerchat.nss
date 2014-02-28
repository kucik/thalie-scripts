/* ku_onplayerchat
 * Script executed on player chat event
 *
 * Created 19. 10. 2008 By kucik
 */

//#include "ku_libbase"
#include "ku_exp_time"
#include "ku_libchat"




void main()
{
  string mess = GetPCChatMessage();
  int volume = GetPCChatVolume();
  object oPC = GetPCChatSpeaker();
  int HideText = FALSE;

// Now system check last #(KU_MASSAGE_CACHE) messages that player sent for xp system
  int i;
  int match = FALSE;
  for(i=0;i < KU_CHAT_CACHE_SIZE ;i++) {
    if(mess == GetLocalString(oPC,KU_CHAT_CACHE+IntToString(i)) ) {
      match = TRUE;
      break;
    }
  }
  // Prodluz pridelovani xp
  if(!match) {
    SetLocalInt(oPC,"ku_LastActionStamp",ku_GetTimeStamp(0,5)); // +5 minutes
  }
  int CacheIndex = GetLocalInt(oPC,"KU_CHAT_CACHE_INDEX");
  CacheIndex = (CacheIndex + 1) % KU_CHAT_CACHE_SIZE;
  SetLocalString(oPC,KU_CHAT_CACHE+IntToString(CacheIndex),mess);
  SetLocalInt(oPC,"KU_CHAT_CACHE_INDEX",CacheIndex);
//  SendMessageToPC(oPC,"chat index="+IntToString(CacheIndex));
  SetLocalInt(oPC,"ku_LastActionType",KU_ACTIONS_SPEAK);
// End of xp system

// Execute chat command
  string left = GetStringLeft(mess,3);
  if(left == "/pc") {
    ku_ChatCommand(oPC,mess,volume);
    HideText = TRUE;
  }

  int bCreatureCommand = FALSE;
  object oFam = OBJECT_INVALID;
  if(left == "/f ") {
    oFam = GetLocalObject(oPC,"FAMILIAR");
    bCreatureCommand = TRUE;
  }
  if(left == "/c ") {
    bCreatureCommand = TRUE;
    oFam = GetLocalObject(oPC,"COMPANION");
  }
  if(left == "/h ") {
    bCreatureCommand = TRUE;
    oFam = GetLocalObject(oPC,"JA_HORSE_OBJECT");
  }
  if( (bCreatureCommand) &&
      (GetIsObjectValid(oFam)) ) {
    string sRight = GetSubString(mess,3,100);
    float fDur = 9999.0f; //Duration
    if(sRight == "*sedni*") {
      AssignCommand(oFam, PlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0, fDur));
    } else if(sRight == "*lehni*") {
      AssignCommand(oFam, PlayAnimation( ANIMATION_LOOPING_DEAD_BACK, 1.0, fDur));
    } else if(sRight == "*uhni*") {
      AssignCommand(oFam, PlayAnimation( ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
    } else {
      AssignCommand(oFam,SpeakString(sRight));
    }
    HideText = TRUE;
  }


  if(HideText) {
    SetPCChatVolume(TALKVOLUME_TELL);
    SetPCChatMessage("");
  }


}

