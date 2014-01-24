//STRINGS library

// Removes parts of strings
string StrTrim(string str, string substr);

// String replace
string StrReplace(string str, string substr, string replace);

// Find last occurence of sSub inside sStr
// * Return value on error: -1
int GetLastOccurence(string sStr, string sSub);

string StrTrim(string str, string substr) {
  int slen = GetStringLength(substr);
  if(slen == 0)
    return str;

  int iStart = 0;
  int iEnd = FindSubString(str,substr,iStart);
  string sNew = "";


  while(iEnd >=0 ) {
    if(iEnd > iStart)
      sNew = sNew+GetSubString(str,iStart,iEnd - iStart);
    iStart = iEnd + slen;
    iEnd = FindSubString(str,substr,iStart);
  }

  sNew = sNew + GetSubString(str,iStart,GetStringLength(str) - iStart);

  return sNew;
}

string StrReplace(string str, string substr, string replace) {
  int slen = GetStringLength(substr);
  if(slen == 0)
    return str;

  int iStart = 0;
  int iEnd = FindSubString(str,substr,iStart);
  string sNew = "";


  while(iEnd >=0 ) {
    if(iEnd > iStart) {
      sNew = sNew+GetSubString(str,iStart,iEnd - iStart);
    }
    sNew = sNew+replace;
    iStart = iEnd + slen;
    iEnd = FindSubString(str,substr,iStart);
  }

  sNew = sNew + GetSubString(str,iStart,GetStringLength(str) - iStart);

  return sNew;
}


string StrEncodeToCZ(object oMod, string sText) {
  string abeceda_out = "<cc><cd><ce><cn><cr><ct><cu><cC><cD><cE><cN><cR><cS><cT><cU>";
  string abeceda_in  = GetLocalString(oMod,"KU_ABECEDA_IN");
  int len = GetStringLength(abeceda_in);
  int i;

  for(i=0;i<len;i++) {
    sText = StrReplace(sText,GetSubString(abeceda_out,i*4,4),GetSubString(abeceda_in,i,1));
  }

  return sText;

}

int GetLastOccurence(string sString, string sSub) {
  int iLast = -1;
  int iPos = 0;

  iPos = FindSubString(sString, sSub, 0);
  while(iPos != -1 ) {
    iLast = iPos;
    iPos = FindSubString(sString, sSub, iLast + 1);
  }

  return iLast;
}

