const int MAX_SPELLS = 804;
const int MAX_FEATS = 1071;

string pGetSpells(object oPC){
  int nSpell;
  int nNumSpell;
  string sSpellList = " ";
  for(nSpell=0; nSpell<MAX_SPELLS; nSpell++) {
    if (nNumSpell = GetHasSpell(nSpell,oPC)) {
      sSpellList += IntToString(nSpell)+":"+IntToString(nNumSpell)+" ";
    }
  }
  return sSpellList;
}

string pGetFeats(object oPC){
  int nFeat;
  int nNumFeat;
  string sFeatList = " ";
  for(nFeat=0; nFeat<MAX_FEATS; nFeat++) {
    if (nNumFeat = GetHasFeat(nFeat,oPC)) {
      sFeatList += IntToString(nFeat)+":"+IntToString(nNumFeat)+" ";
    }
  }
  return sFeatList;
}

void pSetSpells(object oPC, string sOldSpellList){
  int nNumSpell;
  int nSpell;

  if(sOldSpellList == "") return;

  for(nSpell=0; nSpell<MAX_SPELLS; nSpell++) {
    if (nNumSpell = GetHasSpell(nSpell,oPC)) {
      string sLookfor = " "+IntToString(nSpell)+":";
      int nStart = FindSubString(sOldSpellList,sLookfor);
      if (nStart >= 0) {
         while (GetSubString(sOldSpellList,nStart,1) != ":") nStart++;
         int nEnd = nStart+1;
         while (GetSubString(sOldSpellList,nEnd,1) != " ") nEnd++;
         string sSub = GetSubString(sOldSpellList,nStart+1,nEnd-nStart);
         int nOldNumSpell= StringToInt( sSub);
         int nSpellDiff = nNumSpell - nOldNumSpell;
         int suse;
         for (suse=0;suse<nSpellDiff;suse++) {
            DecrementRemainingSpellUses(oPC,nSpell);
         }
         // check to see if it worked
         int nNewNumSpell = GetHasSpell(nSpell,oPC);
         if (nNewNumSpell != nOldNumSpell) {
           PrintString("PWH anticheat - could not restore spell #"+sLookfor+ " old:"+sSub+
               ",new:"+IntToString(nNewNumSpell));
           //SendMessageToPC(oPC,"Debug - can't restore spell #"+sLookfor+" old="+
           //       sSub+" new="+IntToString(nNewNumSpell));
         }
      } else {
        // wipe all uses
        int suse;
        for (suse=0;suse<nNumSpell;suse++) {
            DecrementRemainingSpellUses(oPC,nSpell);
        }
      }
    }
  }
}

void pSetFeats(object oPC, string sOldFeatList){
  int nFeat;
  int nNumFeat;

  if(sOldFeatList == "") return;

  for(nFeat=0; nFeat<MAX_FEATS; nFeat++) {
    if (nNumFeat = GetHasFeat(nFeat,oPC)) {
      string sLookfor = " "+IntToString(nFeat)+":";
      int nStart = FindSubString(sOldFeatList,sLookfor);
      if (nStart >= 0) {
         while (GetSubString(sOldFeatList,nStart,1) != ":") nStart++;
         int nEnd = nStart+1;
         while (GetSubString(sOldFeatList,nEnd,1) != " ") nEnd++;
         string sSub = GetSubString(sOldFeatList,nStart+1,nEnd-nStart);
         int nOldNumFeat= StringToInt( sSub);
         int nFeatDiff = nNumFeat - nOldNumFeat;
         int suse;
         for (suse=0;suse<nFeatDiff;suse++) {
            DecrementRemainingFeatUses(oPC,nFeat);
         }
         // check to see if it worked
         int nNewNumFeat = GetHasFeat(nFeat,oPC);
         if (nNewNumFeat != nOldNumFeat) {
           PrintString("PWH anticheat - could not restore feat #"+sLookfor+ " old:"+sSub+
               ",new:"+IntToString(nNewNumFeat));
           //SendMessageToPC(oPC,"Debug - can't restore feat #"+sLookfor+" old="+
           //       sSub+" new="+IntToString(nNewNumFeat));
         }
      } else {
        // wipe all uses
        int suse;
        for (suse=0;suse<nNumFeat;suse++) {
            DecrementRemainingFeatUses(oPC,nFeat);
        }
      }
    }
  }
}

string pGetID(object oPC){
  return GetPCPlayerName(oPC)+"_"+GetName(oPC);
}

