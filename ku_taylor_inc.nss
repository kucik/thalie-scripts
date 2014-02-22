string IntToHexStringShort(int iNum) {
  int c;
  int i=0;
  c = iNum;
  while(c > 0) {
    c = c / 16;
    i++;
  }
  if(i == 0) {
    i = 1;
  }
  
  string sHex =  IntToHexString(iNum);
  sHex = GetStringRight(sHex, i);
  return sHex;
}


string ku_TaylorGet2DAFileNameForPart(int iPart) {
  switch(iPart) {
    case ITEM_APPR_ARMOR_MODEL_BELT:
      return "parts_belt";
    case ITEM_APPR_ARMOR_MODEL_LBICEP:
    case ITEM_APPR_ARMOR_MODEL_RBICEP:
      return "parts_bicep";
    case ITEM_APPR_ARMOR_MODEL_LFOOT:
    case ITEM_APPR_ARMOR_MODEL_RFOOT:
      return "parts_foot";
    case ITEM_APPR_ARMOR_MODEL_LFOREARM:
    case ITEM_APPR_ARMOR_MODEL_RFOREARM:
      return "parts_forearm";
    case ITEM_APPR_ARMOR_MODEL_LHAND:
    case ITEM_APPR_ARMOR_MODEL_RHAND:
      return "parts_hand";
    case ITEM_APPR_ARMOR_MODEL_LSHIN:
    case ITEM_APPR_ARMOR_MODEL_RSHIN:
      return "parts_shin";
    case ITEM_APPR_ARMOR_MODEL_LSHOULDER:
    case ITEM_APPR_ARMOR_MODEL_RSHOULDER:
      return "parts_shoulder";
    case ITEM_APPR_ARMOR_MODEL_LTHIGH:
    case ITEM_APPR_ARMOR_MODEL_RTHIGH:
      return "parts_legs";
    case ITEM_APPR_ARMOR_MODEL_NECK:
      return "parts_neck";
    case ITEM_APPR_ARMOR_MODEL_PELVIS:
      return "parts_pelvis";
    case ITEM_APPR_ARMOR_MODEL_ROBE:
      return "parts_robe";
    case ITEM_APPR_ARMOR_MODEL_TORSO:
      return "parts_chest";
  }
  return "";
}

string ku_TaylorGetPCModelType(object oPC) {
  string race = "h";
  switch(GetAppearanceType(oPC)) {
    case APPEARANCE_TYPE_ELF:      race = "e"; break;
    case APPEARANCE_TYPE_DWARF:    race = "d"; break;
    case APPEARANCE_TYPE_GNOME:    race = "g"; break;
    case APPEARANCE_TYPE_HALFLING: race = "a"; break;
    case APPEARANCE_TYPE_HALF_ELF:
    case APPEARANCE_TYPE_HUMAN:    race = "h"; break;
    case APPEARANCE_TYPE_HALF_ORC: race = "o"; break;
    case 984:                      race = "k"; break; //kobold
    case 985:                      race = "u"; break; // holf ogre
    case 1000:                     race = "w"; break; //Wemic
    case 1002:                     race = "b"; break; //brownie
    case 1030:                     race = "s"; break; // armor stand
    case 1769:                     race = "v"; break; //skeleton
  }
  string gender = "f";

  switch(GetGender(oPC)) {
    case GENDER_MALE:   gender = "m"; break;
    case GENDER_FEMALE: gender = "f"; break;
  }

  return "p"+gender+race;
}

int ku_TaylorGetNearestNextPartBy2DA(int iPart, int iPrev, string sModelType = "pfh",int order =1) {
  string sPartAC;

  string s2DAfile = ku_TaylorGet2DAFileNameForPart(iPart);
  string sDisallowedVarName = "KU_TAYLOR_"+s2DAfile+"_"+sModelType;
  string sDisallowedStr = "xxx"+GetLocalString(OBJECT_SELF,sDisallowedVarName);
//  SpeakString("Disallowed name="+sDisallowedVarName);

  if(iPart == ITEM_APPR_ARMOR_MODEL_TORSO) {
    int i = iPrev ;
    string sAC = Get2DAString(s2DAfile,"ACBONUS",iPrev);
//    SpeakString("Begin - AC: "+sAC);
    if(sAC == "") {
      sAC = "0.00";
    }
    int iAC = StringToInt(sAC);
    string sGot = "";
    while((GetStringLength(sGot) == 0) || (sGot != sAC )) {
      i = i + order;
      if(i > 254) {
        i = 1;
      }
      if(i < 1) {
        i = 254;
      }
      /* "1" is always allowed */
      if(i == 1 && sAC == "0.00") {
        break;
      }
      sGot = Get2DAString(s2DAfile,"ACBONUS",i);
//      SpeakString("Got: "+sGot);
      if((GetStringLength(sGot) > 0) && FindSubString(sDisallowedStr,","+IntToHexStringShort(i)+",") > 0) {
        sGot = "";
      }
    }
    return i;
  }
  else {
    int i = iPrev ;
    string sGot = "";
    while(GetStringLength(sGot) == 0) {
      i = i + order;
      if(i > 254) {
        i = 1;
      }
      if(i < 1) {
        i = 254;
      }
      /* "1" is always allowed */
      if(i == 1 ) {
        break;
      }
      sGot = Get2DAString(s2DAfile,"ACBONUS",i);
//      SpeakString("Got: "+sGot);
//      SpeakString("Searching "+","+IntToString(i)+","+" in "+sDisallowedStr);
//      SpeakString("Length="+IntToString(GetStringLength(sGot))+"; Find="+IntToString(FindSubString(sDisallowedStr,","+IntToString(i)+",")));
      if((GetStringLength(sGot) > 0) && FindSubString(sDisallowedStr,","+IntToHexStringShort(i)+",") > 0) {
        sGot = "";
//        SpeakString("disallowed");
      }
    }
    return i;
  }

}

int ku_TaylorCheckModel(object oPC, object oCloth, int iPart, int iModel, int iPrev) {

  string s2DAfile = ku_TaylorGet2DAFileNameForPart(iPart);
  if(iModel == 1) {
    if(StringToFloat(Get2DAString(s2DAfile,"ACBONUS",iPrev)) == 0.00) {
      return TRUE;
    }
  }
  string sModelType = ku_TaylorGetPCModelType(oPC);
  string sDisallowedVarName = "KU_TAYLOR_"+s2DAfile+"_"+sModelType;
  string sDisallowedStr = "xxx"+GetLocalString(OBJECT_SELF,sDisallowedVarName);
  if(FindSubString(sDisallowedStr,","+IntToHexStringShort(iModel)+",") > 0) {
    return FALSE;
  }
  string sGot = Get2DAString(s2DAfile,"ACBONUS",iModel);
  if(sGot == "")
    return FALSE;

  if(iPart == ITEM_APPR_ARMOR_MODEL_TORSO) {
    string sAC = Get2DAString(s2DAfile,"ACBONUS",iPrev);
    if(sAC != sGot)
      return FALSE;
  }

  return TRUE;
}

void ku_TaylorNextPart() {
   object oPC = GetPCSpeaker();
   object oCloth = GetLocalObject(OBJECT_SELF,"ITEM");
   int iPart = GetLocalInt(OBJECT_SELF,"KU_PART");
//   int iNum = GetLocalInt(OBJECT_SELF,"KU_MODEL_"+IntToString(iPart));
//   int iOldMod = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart);

   int iNum = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart);
   int iOldMod = iNum;//GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart);

//   iNum++;
   string sModelType = ku_TaylorGetPCModelType(oPC);
   iNum = ku_TaylorGetNearestNextPartBy2DA(iPart,iNum,sModelType,1);

   object oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart,iNum,TRUE);
          AssignCommand(oPC,ActionEquipItem(oNCloth,INVENTORY_SLOT_CHEST));
          DestroyObject(oCloth);
//   SetLocalInt(OBJECT_SELF,"KU_MODEL_"+IntToString(iPart),iNum);
   SetCustomToken(6001,"Puvodni model "+IntToString(iOldMod)+". Aktualni model "+IntToString(iNum));
    SetLocalObject(OBJECT_SELF,"ITEM",oNCloth);

}

void ku_TaylorPrevPart() {
   object oPC = GetPCSpeaker();
   object oCloth = GetLocalObject(OBJECT_SELF,"ITEM");
   int iPart = GetLocalInt(OBJECT_SELF,"KU_PART");

//   int iNum = GetLocalInt(OBJECT_SELF,"KU_MODEL_"+IntToString(iPart));
   int iNum = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart);
   int iOldMod = iNum;//GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart);

//   iNum--;
   string sModelType = ku_TaylorGetPCModelType(oPC);
   iNum = ku_TaylorGetNearestNextPartBy2DA(iPart,iNum,sModelType,-1);

   object oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart,iNum,TRUE);
          AssignCommand(oPC,ActionEquipItem(oNCloth,INVENTORY_SLOT_CHEST));
          DestroyObject(oCloth);
   SetLocalInt(OBJECT_SELF,"KU_MODEL_"+IntToString(iPart),iNum);

   SetCustomToken(6001,"Puvodni model "+IntToString(iOldMod)+". Aktualni model "+IntToString(iNum));
   SetLocalObject(OBJECT_SELF,"ITEM",oNCloth);

 }

void ku_DyerRememberColors(object oCloth) {
  int i;
  object oDyer = OBJECT_SELF;
  for(i=0;i<=5;i++) {
     SetLocalInt(oDyer,"DYE"+IntToString(i),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,i));
  }
}

int ku_DyerGetColorChangesCount(object oCloth) {
  int i,old,new;
  int count = 0;
  object oDyer = OBJECT_SELF;
  for(i=0;i<=5;i++) {
     old = GetLocalInt(oDyer,"DYE"+IntToString(i));
     new = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_COLOR,i);
     if(old != new) {
       count++;
     }
  }
  return count;
}

void ku_TaylorRememberModels(object oCloth) {
  int i;
  object oDyer = OBJECT_SELF;
  for(i=0;i<=18;i++) {
     SetLocalInt(oDyer,"MODEL"+IntToString(i),GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,i));
  }
}

int ku_TaylorGetModelChangesCount(object oCloth) {
  int i,old,new;
  int count = 0;
  object oDyer = OBJECT_SELF;
  for(i=0;i<=18;i++) {
     old = GetLocalInt(oDyer,"MODEL"+IntToString(i));
     new = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,i);
     if(old != new) {
       count++;
     }
  }
  return count;
}

int ku_TaylorCalculatePrice(object oCloth, object oOldCloth) {

  int cCount = ku_DyerGetColorChangesCount(oCloth);
  int mCount = ku_TaylorGetModelChangesCount(oCloth);
  int iCost = GetGoldPieceValue(oOldCloth);
//  SpeakString("Counts:"+IntToString(cCount)+";"+IntToString(mCount)+" cost="+IntToString(iCost));
  //if(iCost < 1000)
    iCost = 1000;
  int iPrice = FloatToInt((20 * cCount) + (0.02 * iCost * mCount));
  return iPrice;
}

 void ku_TaylorInit(object oMem) {

// Roby hex 
// 308
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmh",",9,a,11,1a,1b,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,68,69,78,7a,7b,7c,7d,7e,7f,a6,a7,ac,af,b0,b2,b4,b5,bc,bd,c6,c7,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa");
// 313
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmd",",7,9,a,11,1a,1b,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,65,68,69,78,7a,7b,7c,7d,7e,7f,a6,a7,ac,ae,b0,b2,b4,b5,bc,bd,c6,c7,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa");
// 311
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pme",",9,a,11,1a,1b,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,68,69,78,7a,7b,7c,7d,7e,7f,a6,a7,ac,ae,b0,b1,b2,b4,b5,bc,bd,c6,c7,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa");
// 310
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmo",",7,9,a,11,1a,1b,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,68,69,78,7a,7b,7c,7d,7e,7f,a6,a7,ac,ae,b0,b2,b4,b5,bc,bd,c6,c7,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa");
// 481
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmu",",7,8,9,a,b,c,d,e,f,10,11,12,13,14,15,16,17,18,19,1a,1b,1c,22,23,29,2a,2b,2c,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,64,65,66,67,68,69,6a,6b,6c,6d,76,77,78,7a,7b,7c,7d,7e,7f,80,94,95,a6,a7,ac,ad,ae,af,b0,b1,b2,b4,b5,ba,bb,bc,bd,bf,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,ca,cb,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,da,db,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe");
// 310
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmg",",7,9,a,11,1a,1b,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,68,69,78,7a,7b,7c,7d,7e,7f,a6,a7,ac,ae,b0,b2,b4,b5,bc,bd,c6,c7,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa");
// 310
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pma",",7,9,a,11,1a,1b,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,68,69,78,7a,7b,7c,7d,7e,7f,a6,a7,ac,ae,b0,b2,b4,b5,bc,bd,c6,c7,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa");
// 643
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmb",",7,8,9,a,b,c,d,e,f,10,11,12,13,14,15,16,17,18,19,1a,1b,1c,1d,1e,1f,20,21,22,23,24,25,26,27,28,29,2a,2b,2c,2d,2e,2f,30,31,32,33,34,35,36,37,38,39,3a,3b,3c,3d,3e,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,64,65,66,67,68,69,6a,6b,6c,6d,75,76,77,78,7a,7b,7c,7d,7e,7f,80,81,82,83,84,85,86,87,88,89,8a,8b,8c,8d,8e,8f,90,91,92,93,94,95,aa,ac,ad,ae,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf,c0,"); //c1,c2,c3,c4,c5,c6,c7,c8,c9,ca,cb,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,da,db,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe");
// 730
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmk",",7,8,9,a,b,c,d,e,f,10,11,12,13,14,15,16,17,18,19,1a,1b,1c,1d,1e,1f,20,21,22,23,24,25,26,27,28,29,2a,2b,2c,2d,2e,2f,30,31,32,33,34,35,36,37,38,39,3a,3b,3c,3d,3e,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,64,65,66,67,68,69,6a,6b,6c,6d,6e,6f,70,71,72,73,74,75,76,77,78,79,7a,7b,7c,7d,7e,7f,80,81,82,83,84,85,86,87,88,89,8a,8b,8c,8d,8e,8f,90,91,92,93,94,95,96,97,98,99,9a,9b,9c,9d,9e,9f,a0,a1,a2,"); //a3,a4,a5,a6,a7,a8,a9,aa,ab,ac,ad,ae,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,ca,cb,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,da,db,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe");

// 243
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfh",",b,c,e,f,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,7a,7b,7c,7d,7e,7f,ad,bc,bd,c6,c7,cd,ce,cf,d0,d1,d2,d7,d8,d9,da,db,e2,e3,e4,e5,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9");
// 255
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfd",",b,c,e,f,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,7a,7b,7c,7d,7e,7f,ad,af,b2,b4,bc,bd,c6,c7,c8,cd,ce,cf,d0,d1,d2,d7,d8,d9,da,db,e2,e3,e4,e5,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9");
// 243
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfe",",b,c,e,f,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,7a,7b,7c,7d,7e,7f,ad,bc,bd,c6,c7,cd,ce,cf,d0,d1,d2,d7,d8,d9,da,db,e2,e3,e4,e5,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9");
// 252
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfo",",b,c,e,f,13,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,78,7a,7b,7c,7d,7e,7f,ad,b4,bc,bd,c6,c7,cd,ce,cf,d0,d1,d2,d7,d8,d9,da,db,e2,e3,e4,e5,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9");
// 554
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfu",",8,9,a,b,c,d,e,f,10,11,12,13,14,15,16,17,18,19,1a,1c,22,23,29,2a,2c,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,63,64,65,66,67,68,69,6a,6b,6c,6d,74,75,76,77,78,7a,7b,7c,7d,7e,7f,80,81,82,83,84,85,86,87,88,89,8a,8b,8c,8d,8e,8f,90,91,92,93,94,95,ac,ad,ae,af,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,ca,cb,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,da,db,dc,dd,de,df,");//e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe");
// 249
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfg",",b,c,e,f,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,7a,7b,7c,7d,7e,7f,ad,b4,b5,bc,bd,c6,c7,cd,ce,cf,d0,d1,d2,d7,d8,d9,da,db,e2,e3,e4,e5,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9");
// 249
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfa",",b,c,e,f,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,61,62,7a,7b,7c,7d,7e,7f,ad,b4,b5,bc,bd,c6,c7,cd,ce,cf,d0,d1,d2,d7,d8,d9,da,db,e2,e3,e4,e5,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9");
// 640
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfb",",7,8,9,a,b,c,d,e,f,10,11,12,13,14,15,16,17,18,19,1a,1b,1c,1d,1e,1f,20,21,22,23,24,25,26,27,28,29,2a,2b,2c,2d,2e,2f,30,31,32,33,34,35,36,37,38,39,3a,3b,3c,3d,3e,3f,40,41,42,43,44,45,46,47,48,49,4a,4b,4c,4d,4e,4f,50,51,52,53,54,55,56,57,58,59,5a,5b,5c,5d,5e,5f,60,61,62,63,64,65,66,67,68,69,6a,6b,6c,6d,75,76,77,78,7a,7b,7c,7d,7e,7f,80,81,82,83,84,85,86,87,88,89,8a,8b,8c,8d,8e,8f,90,91,92,93,94,95,ac,ad,ae,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf,c0,c1,"); //c2,c3,c4,c5,c6,c7,c8,c9,ca,cb,cc,cd,ce,cf,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,da,db,dc,dd,de,df,e0,e1,e2,e3,e4,e5,e6,e7,e9,ea,eb,ec,ed,ee,ef,f0,f1,f2,f3,f4,f5,f6,f7,f8,f9,fa,fb,fc,fd,fe");
 
 //roby
/* SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmh",",9,10,17,26,27,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,104,105,120,122,123,124,125,126,127,166,167,172,175,176,178,180,181,188,189,198,199,204,205,206,207,208,209,210,211,212,213,214,215,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmd",",7,9,10,17,26,27,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,101,104,105,120,122,123,124,125,126,127,166,167,172,174,176,178,180,181,188,189,198,199,204,205,206,207,208,209,210,211,212,213,214,215,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pme",",9,10,17,26,27,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,104,105,120,122,123,124,125,126,127,166,167,172,174,176,177,178,180,181,188,189,198,199,204,205,206,207,208,209,210,211,212,213,214,215,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmo",",7,9,10,17,26,27,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,104,105,120,122,123,124,125,126,127,166,167,172,174,176,178,180,181,188,189,198,199,204,205,206,207,208,209,210,211,212,213,214,215,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmu",",7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,34,35,41,42,43,44,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,118,119,120,122,123,124,125,126,127,128,148,149,166,167,172,173,174,175,176,177,178,180,181,186,187,188,189,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmg",",7,9,10,17,26,27,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,104,105,120,122,123,124,125,126,127,166,167,172,174,176,178,180,181,188,189,198,199,204,205,206,207,208,209,210,211,212,213,214,215,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pma",",7,9,10,17,26,27,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,104,105,120,122,123,124,125,126,127,166,167,172,174,176,178,180,181,188,189,198,199,204,205,206,207,208,209,210,211,212,213,214,215,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmb",",7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,117,118,119,120,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,170,172,173,174,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmk",",7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,");


SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfh",",11,12,14,15,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,122,123,124,125,126,127,173,188,189,198,199,205,206,207,208,209,210,215,216,217,218,219,226,227,228,229,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfd",",11,12,14,15,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,122,123,124,125,126,127,173,175,178,180,188,189,198,199,200,205,206,207,208,209,210,215,216,217,218,219,226,227,228,229,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfe",",11,12,14,15,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,122,123,124,125,126,127,173,188,189,198,199,205,206,207,208,209,210,215,216,217,218,219,226,227,228,229,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfo",",11,12,14,15,19,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,120,122,123,124,125,126,127,173,180,188,189,198,199,205,206,207,208,209,210,215,216,217,218,219,226,227,228,229,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfu",",8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,34,35,41,42,44,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,99,100,101,102,103,104,105,106,107,108,109,116,117,118,119,120,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfg",",11,12,14,15,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,122,123,124,125,126,127,173,180,181,188,189,198,199,205,206,207,208,209,210,215,216,217,218,219,226,227,228,229,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfa",",11,12,14,15,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,97,98,122,123,124,125,126,127,173,180,181,188,189,198,199,205,206,207,208,209,210,215,216,217,218,219,226,227,228,229,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,");
SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfb",",7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,117,118,119,120,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,172,173,174,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,");
*/

 /*
  // belt
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfe",",126,155,181,182,183,184,185,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfd",",,126,155,181,182,183,184,185,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfg",",,126,155,181,182,183,184,185,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfa",",126,155,181,182,183,184,185,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfh",",,126,155,181,182,183,184,185,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfo",",,126,155,181,182,183,184,185,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pfu",",,20,21,23,24,26,27,63,100,101,102,103,104,105,106,107,108,109,116,117,118,119,120,121,122,123,124,125,126,126,155,156,167,168,181,182,182,183,183,184,184,185,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pme",",23,24,26,27,102,103,104,118,119,120,126,155,167,168,181,182,183,184,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pmd",",,23,24,26,27,102,103,104,118,119,120,126,155,167,168,181,182,183,184,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pmg",",,23,24,26,27,102,103,104,118,119,120,126,155,167,168,181,182,183,184,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pma",",23,24,26,27,102,103,104,118,119,120,126,155,167,168,181,182,183,184,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pmh",",,23,24,26,27,102,103,104,118,119,120,126,155,167,168,181,182,183,184,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pmo",",,23,24,26,27,102,103,104,118,119,120,126,155,167,168,181,182,183,184,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pmu",",,20,21,23,24,26,27,63,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,126,150,151,152,153,154,155,155,156,167,168,181,181,182,182,183,183,184,184,185,185,196,197,");
  SetLocalString(oMem,"KU_TAYLOR_parts_belt_pmk",",,20,21,23,24,26,27,63,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,126,150,151,152,153,154,155,155,156,167,168,181,181,182,182,183,183,184,184,185,185,196,197,");
  // bicep
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfe",",17,100,176,177,178,179,181,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfd",",,17,100,176,177,178,179,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfg",",,17,100,176,177,178,179,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfa",",17,100,176,177,178,179,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfh",",,17,176,177,178,179,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfo",",,17,100,176,177,178,179,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pfu",",,17,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,63,99,100,135,136,137,138,139,140,141,142,143,144,145,146,147,176,177,178,179,180,181,183,184,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pme",",17,24,26,27,28,37,38,42,43,45,99,100,112,120,146,147,175,180,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pmd",",,17,24,26,27,28,37,38,42,43,45,99,100,112,120,146,147,175,180,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pmg",",,17,24,26,27,28,37,38,42,43,45,99,100,112,120,146,147,175,180,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pma",",17,24,26,27,28,37,38,42,43,45,99,100,112,120,146,147,175,180,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pmh",",,24,26,27,28,37,38,42,43,45,99,100,112,120,146,147,175,180,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pmo",",,17,24,26,27,28,37,38,42,43,45,99,100,112,120,146,147,175,180,181,183,184,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pmu",",,17,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,63,99,100,112,120,135,136,137,138,139,140,141,142,143,144,145,146,147,175,176,177,178,179,180,181,183,184,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_bicep_pmk",",,17,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,63,99,100,110,111,112,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,150,151,152,153,154,155,156,157,158,159,160,161,163,175,176,177,178,179,180,181,183,184,186,");
  // foot
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfe",",110,114,115,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfd",",,110,114,115,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfg",",,110,114,115,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfa",",110,114,115,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfh",",,110,114,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfo",",,110,114,115,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pfu",",,63,110,114,115,116,117,118,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pme",",98,100,101,102,103,104,110,112,113,114,115,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pmd",",,98,100,101,102,103,104,110,112,113,114,115,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pmg",",,98,100,101,102,103,104,110,112,113,114,115,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pma",",98,100,101,102,103,104,110,112,113,114,115,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pmh",",,98,100,101,102,103,104,110,112,113,114,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pmo",",,98,100,101,102,103,104,110,112,113,114,115,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pmu",",,63,98,100,101,102,103,104,110,112,113,114,115,116,117,118,120,180,181,182,");
  SetLocalString(oMem,"KU_TAYLOR_parts_foot_pmk",",,50,51,63,80,81,82,83,98,99,100,101,102,103,104,106,107,108,109,110,110,111,112,113,114,114,115,116,116,117,117,118,118,120,122,150,151,152,153,154,155,156,157,158,160,175,180,181,182,186,");
  // forearm
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfe",",92,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfd",",,92,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfg",",,92,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfa",",92,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfh",",,92,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfo",",,92,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pfu",",,63,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,113,114,115,116,117,118,119,166,167,175,181,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pme",",100,101,112,113,120,166,175,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pmd",",,100,101,112,113,120,166,175,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pmg",",,100,101,112,113,120,166,175,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pma",",100,101,112,113,120,166,175,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pmh",",,100,101,112,113,120,166,175,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pmo",",,100,101,112,113,120,166,175,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pmu",",,63,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,112,113,114,115,116,117,118,119,120,166,175,181,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_forearm_pmk",",,63,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,124,125,126,127,128,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,175,181,186,");
  // hand
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfe",",");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfd",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfg",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfa",",");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfh",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfo",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pfu",",,9,63,100,101,102,103,104,105,106,107,108,155,175,181,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pme",",13,100,101,102,103,106,107,112,175,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pmd",",,13,100,101,102,103,106,107,112,175,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pmg",",,13,100,101,102,103,106,107,112,175,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pma",",13,100,101,102,103,106,107,112,175,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pmh",",,13,100,101,102,103,106,107,112,175,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pmo",",,13,100,101,102,103,106,107,112,175,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pmu",",,9,13,63,100,101,102,103,104,105,106,107,108,112,155,175,181,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_hand_pmk",",,9,13,63,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,121,122,150,151,152,153,154,155,175,181,186,");
  // chest
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfe",",135,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfd",",,135,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfg",",,135,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfa",",135,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfh",",,164,165,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfo",",,135,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pfu",",,71,72,73,74,77,78,89,98,100,101,102,103,104,105,106,107,108,109,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,147,148,149,160,161,162,164,165,177,182,186,189,190,191,192,195,212,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pme",",74,77,99,100,101,102,112,113,114,115,116,120,131,132,133,134,135,137,138,139,144,147,148,162,182,189,190,191,192,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pmd",",,74,77,99,100,101,102,112,113,114,115,116,120,131,132,133,134,135,137,138,139,144,147,148,162,182,189,190,191,192,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pmg",",,74,77,99,100,101,102,112,113,114,115,116,120,131,132,133,134,135,137,138,139,144,147,148,162,182,189,190,191,192,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pma",",74,77,99,100,101,102,112,113,114,115,116,120,131,132,133,134,135,137,138,139,144,147,148,162,182,189,190,191,192,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pmh",",,74,77,99,100,101,102,112,113,114,115,116,120,131,132,133,134,137,138,139,144,147,148,162,164,165,182,189,190,191,192,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pmo",",,74,77,99,100,101,102,112,113,114,115,116,120,131,132,133,134,135,137,138,139,144,147,148,162,182,189,190,191,192,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pmu",",,64,71,72,73,74,77,78,89,98,99,100,101,102,103,104,105,106,107,108,109,112,113,114,115,116,120,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,147,148,149,160,161,162,164,165,177,182,186,189,190,191,192,195,212,");
  SetLocalString(oMem,"KU_TAYLOR_parts_chest_pmk",",,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,77,78,89,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,182,186,189,190,191,192,195,210,212,");
  // legs
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfe",",110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfd",",,110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfg",",,110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfa",",110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfh",",,110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfo",",,110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pfu",",,50,110,117,150,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pme",",110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pmd",",,110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pmg",",,110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pma",",50,110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pmh",",,110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pmo",",,110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pmu",",,50,110,117,123,124,127,150,175,181,202,");
  SetLocalString(oMem,"KU_TAYLOR_parts_legs_pmk",",,50,63,80,81,82,83,84,85,86,87,88,89,90,91,92,93,104,105,106,107,108,109,110,110,111,113,114,115,116,117,117,118,119,121,122,123,124,125,127,128,129,130,131,132,150,150,151,152,153,154,155,156,157,158,159,160,161,162,164,175,181,186,200,201,202,");
  // neck
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfe",",181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfd",",,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfg",",,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfa",",181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfh",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfo",",,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pfu",",,112,113,120,123,124,125,126,127,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pme",",50,99,105,106,160,161,162,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pmd",",,50,99,105,106,160,161,162,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pmg",",,50,99,105,106,160,161,162,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pma",",50,99,105,106,160,161,162,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pmh",",,50,99,105,106,160,161,162,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pmo",",,50,99,105,106,160,161,162,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pmu",",,50,99,105,106,112,113,120,123,124,125,126,127,160,161,162,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_neck_pmk",",,30,31,50,63,99,105,106,107,108,109,112,113,120,121,122,123,124,125,126,127,150,151,152,153,154,155,156,157,158,159,160,161,162,164,165,166,167,181,");
  // pelvis
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfe",",52,55,56,57,58,59,60,61,62,65,66,215,216,216,217,218,219,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfd",",,52,55,56,57,58,59,60,61,62,65,66,215,216,216,217,218,219,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfg",",,52,55,56,57,58,59,60,61,62,65,66,99,215,216,216,217,218,219,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfa",",52,55,56,57,58,59,60,61,62,65,66,99,215,216,216,217,217,218,219,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfh",",,215,216,217,219,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfo",",,52,55,56,57,58,59,60,61,62,65,66,99,215,216,216,217,218,219,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pfu",",,38,39,40,45,49,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,99,101,102,103,104,106,107,108,109,110,111,119,125,126,127,128,129,130,131,139,140,141,142,143,144,145,146,151,152,160,161,168,169,171,175,176,177,186,215,216,216,217,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pme",",38,39,40,45,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,68,99,103,104,106,107,112,113,114,115,116,117,118,120,142,143,144,145,146,160,168,169,171,175,176,177,216,216,217,217,218,238,239,240,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pmd",",,38,39,40,45,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,68,99,103,104,106,107,112,113,114,115,116,117,118,120,142,143,144,145,146,160,168,169,171,175,176,177,215,216,216,217,217,218,238,239,240,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pmg",",,38,39,40,45,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,68,99,103,104,106,107,112,113,114,115,116,117,118,120,142,143,144,145,146,160,168,169,171,175,176,177,216,216,217,217,218,238,239,240,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pma",",38,39,40,45,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,68,99,103,104,106,107,112,113,114,115,116,117,118,120,142,143,144,145,146,160,168,169,171,175,176,177,216,216,217,217,218,238,239,240,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pmh",",,38,39,40,45,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,68,99,103,104,106,107,112,113,114,115,116,117,118,120,142,143,144,145,146,160,168,169,171,175,176,177,216,216,217,217,218,238,239,240,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pmo",",,38,39,40,45,52,53,54,55,56,57,58,59,60,61,62,64,65,66,67,68,99,103,104,106,107,112,113,114,115,116,117,118,120,142,143,144,145,146,160,168,169,171,175,176,177,216,216,217,217,218,238,239,240,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pmu",",,38,39,40,45,49,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,99,101,102,103,104,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,125,126,127,128,129,130,131,139,140,141,142,143,144,145,146,151,152,160,168,169,171,175,176,177,186,215,216,216,217,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  SetLocalString(oMem,"KU_TAYLOR_parts_pelvis_pmk",",,38,39,40,45,49,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,99,101,102,103,104,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,139,140,141,142,143,144,145,146,151,152,153,154,155,156,157,158,159,160,161,168,169,171,175,176,177,186,215,216,216,217,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,238,239,239,240,240,241,241,");
  // robe
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfe",",,7,9,11,14,15,17,18,19,29,35,36,63,64,181,198,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfd",",,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,22,24,26,28,29,30,31,32,33,34,35,36,38,63,64,108,110,111,112,113,114,115,116,117,118,121,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,180,181,182,183,184,185,186,187,198,235,254,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfg",",,7,9,11,14,15,17,18,19,29,35,36,63,64,180,181,198,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfa",",,7,9,11,14,15,17,18,19,29,35,36,63,64,180,181,198,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfh",",,11,14,15,17,18,19,29,36,63,64,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfo",",,7,9,11,14,15,17,18,19,29,35,36,63,64,180,181,198,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pfu",",,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,34,35,36,63,64,108,116,117,118,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,172,173,180,181,182,183,184,185,186,187,198,200,235,254,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pme",",9,10,12,17,24,25,35,36,166,167,172,180,181,186,187,198,235,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmd",",,7,9,10,11,12,17,24,25,29,35,36,166,167,172,180,181,186,187,198,235,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmg",",,7,9,10,11,12,17,24,25,29,35,36,166,167,172,180,181,186,187,198,235,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pma",",7,9,10,11,12,17,21,23,24,25,29,35,36,166,167,172,180,181,186,187,198,235,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmh",",,9,10,12,24,25,35,166,167,172,180,181,186,187,198,235,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmo",",,7,9,10,11,12,17,24,25,29,35,36,166,167,172,180,181,186,187,198,235,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmu",",,7,9,10,11,12,13,14,15,16,17,20,21,22,23,24,25,27,28,29,34,35,36,108,118,128,148,149,166,167,172,180,181,186,187,198,200,235,254,");
  SetLocalString(oMem,"KU_TAYLOR_parts_robe_pmk",",,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,38,63,64,108,110,111,112,113,114,115,116,117,118,121,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,180,181,182,183,184,185,186,187,198,200,235,254,");
  // shin
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfe",",181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfd",",,180,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfg",",,180,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfa",",180,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfh",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfo",",,99,180,181,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pfu",",,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,151,152,153,154,155,156,157,158,159,160,161,162,163,175,180,181,186,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pme",",99,101,102,103,104,133,134,135,161,175,180,181,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pmd",",,99,101,102,103,104,133,134,135,161,175,180,181,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pmg",",,99,101,102,103,104,133,134,135,161,175,180,181,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pma",",99,101,102,103,104,133,134,135,161,175,180,181,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pmh",",,99,101,102,103,104,133,134,135,161,175,180,181,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pmo",",,99,101,102,103,104,133,134,135,161,175,180,181,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pmu",",,99,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,151,152,153,154,155,156,157,158,159,160,161,162,163,175,180,181,186,195,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shin_pmk",",,50,51,52,53,54,63,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,99,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,151,152,153,154,155,156,157,158,159,160,161,162,163,175,180,181,186,195,");
  // shoulder
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfe",",");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfd",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfg",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfa",",186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfh",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfo",",,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pfu",",,50,51,52,53,100,101,102,103,104,105,106,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pme",",120,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pmd",",,120,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pmg",",,120,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pma",",120,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pmh",",,120,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pmo",",,120,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pmu",",,50,51,52,53,100,101,102,103,104,105,106,120,186,");
  SetLocalString(oMem,"KU_TAYLOR_parts_shoulder_pmk",",,50,51,52,53,100,101,102,103,104,105,106,120,121,122,186,");
  */

 }
