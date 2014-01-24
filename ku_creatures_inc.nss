#include "nwnx_structs"
#include "nwnx_funcs"

const string KU_BODYPART_DELIMITER=":";


string ku_GetCreatureAppearance(object oNPC);
void ku_RestoreCreatureAppearance(object oNPC, string sParts);

string ku_GetCreatureAppearance(object oNPC) {
  int i;
  string sParts="";

  int iAppearance = GetAppearanceType(oNPC);
  sParts = sParts+IntToString(iAppearance)+KU_BODYPART_DELIMITER;

  sParts = sParts+IntToString(GetGender(oNPC))+KU_BODYPART_DELIMITER;
  sParts = sParts+IntToString(GetSoundset(oNPC))+KU_BODYPART_DELIMITER;
  sParts = sParts+IntToString(GetFootstepType(oNPC))+KU_BODYPART_DELIMITER;

  // If creature is not dynamic, do not check bodyparts
  if(Get2DAString("appearance","MODELTYPE",iAppearance) != "P" ) {
//    SendMessageToPC(GetFirstPC(),"RACE =  '"+Get2DAString("appearance","MODELTYPE",iAppearance)+"'");
    return sParts;
  }

  sParts = sParts+IntToString(GetCreatureTailType(oNPC))+KU_BODYPART_DELIMITER;
  sParts = sParts+IntToString(GetCreatureWingType(oNPC))+KU_BODYPART_DELIMITER;
  sParts = sParts+IntToString(GetPhenoType(oNPC))+KU_BODYPART_DELIMITER;

  /* Bodyparts */
  for(i=0;i<=20;i++) {
    // Jump 17->20
    if(i==18) {
      i=20;
    }
    sParts = sParts+IntToString(GetCreatureBodyPart(i,oNPC))+KU_BODYPART_DELIMITER;
  }

  /* colors */
  for(i=0;i<=3;i++) {
    sParts = sParts+IntToString(GetColor(oNPC,i))+KU_BODYPART_DELIMITER;
  }

  return sParts;
}

void ku_RestoreCreatureAppearance(object oNPC, string sParts) {
  int i;
  int iFrom = 0;
  int iTo = 0;
  int iPart;
  string sPart;
  int iAppearance;

  //Base appearance
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  iAppearance = StringToInt(GetSubString(sParts,iFrom,iTo - iFrom));
//  SetCreatureAppearanceType(oNPC,iAppearance);

  // Gender
  iFrom = iTo + 1;
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  sPart = GetSubString(sParts,iFrom,iTo - iFrom);
  iPart = StringToInt(sPart);
  if(GetGender(oNPC) != iPart) {
    SetGender(oNPC,StringToInt(sPart));
//    SendMessageToPC(GetFirstPC(),"Applying gender '"+IntToString(iPart)+"' on "+GetName(oNPC));
  }

  if(GetAppearanceType(oNPC) != iAppearance) {
    SetCreatureAppearanceType(oNPC,iAppearance);
//    SendMessageToPC(GetFirstPC(),"Applying appearance '"+IntToString(iPart)+"' on "+GetName(oNPC));
  }

  // Soundset
  iFrom = iTo + 1;
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  sPart = GetSubString(sParts,iFrom,iTo - iFrom);
//  iPart = StringToInt(GetSubString(sParts,iFrom,iTo - iFrom));
  SetSoundset(oNPC,StringToInt(sPart));

  // Footsteps
  iFrom = iTo + 1;
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  sPart = GetSubString(sParts,iFrom,iTo - iFrom);
  SetFootstepType(StringToInt(sPart),oNPC);

  // If creature is not dynamic, do not check bodyparts
  if(Get2DAString("appearance","MODELTYPE",iAppearance) != "P" ) {
//    SendMessageToPC(GetFirstPC(),"RACE =  '"+Get2DAString("appearance","MODELTYPE",iAppearance)+"'");
    return;
  }

  // Tail
  iFrom = iTo + 1;
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  sPart = GetSubString(sParts,iFrom,iTo - iFrom);
  SetCreatureTailType(StringToInt(sPart),oNPC);

  // Wings
  iFrom = iTo + 1;
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  sPart = GetSubString(sParts,iFrom,iTo - iFrom);
  SetCreatureWingType(StringToInt(sPart),oNPC);

  // Phenotype
  iFrom = iTo + 1;
  iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
  sPart = GetSubString(sParts,iFrom,iTo - iFrom);
  SetPhenoType(StringToInt(sPart),oNPC);

  // If creature is not dynamic, do not check bodyparts
//  if(Get2DAString("appearance","RACE",iAppearance) != "Character_model" ) {
//    return;
//  }

  // Bodyparts
  for(i=0;i<=20;i++) {
    iFrom = iTo + 1;
    iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
    // Jump 17->20
    if(i==18) {
      i=20;
    }
//    sPart = GetSubString(sParts,iFrom,iTo - iFrom);
    iPart = StringToInt(GetSubString(sParts,iFrom,iTo - iFrom));
//    SendMessageToPC(GetFirstPC(),"Applying part '"+sPart+"'");
//    if(iPart != GetCreatureBodyPart(i,oNPC)){
      SetCreatureBodyPart(i,iPart,oNPC);
//      SendMessageToPC(GetFirstPC(),"Applying part '"+IntToString(iPart)+"' on "+GetName(oNPC));
//    }
  }

  //colors
  for(i=0;i<=3;i++) {
    iFrom = iTo + 1;
    iTo = FindSubString(sParts,KU_BODYPART_DELIMITER,iFrom);
//    sPart = GetSubString(sParts,iFrom,iTo - iFrom);
    iPart = StringToInt(GetSubString(sParts,iFrom,iTo - iFrom));
//    SendMessageToPC(GetFirstPC(),"Applying part '"+sPart+"'");
    /*if(iPart != GetColor(oNPC,i)) */{
//      SendMessageToPC(GetFirstPC(),"Applying color "+IntToString(i)+" '"+IntToString(iPart)+"' orig:'"+IntToString(GetColor(oNPC,i))+"' on "+GetName(oNPC));
      SetColor(oNPC,i,iPart);
    }
  }

}

