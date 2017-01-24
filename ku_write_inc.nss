/**
 * ku_write_inc script
 *
 * Simple Library to write books, letters, etc.
 *
 * /rm <cislo> - odstran konkretni text
 * /rm - odstran posledni text
 * /num - Zobraz/skryj cisla radku
 */

void RefresDesc(object oBook) {
  int iCount = GetLocalInt(oBook, "KU_WRITE_CNT");
  int iShowLines = GetLocalInt(oBook,"KU_WRITE_SHOWLN");
  string sDesc = "";
  int i;

  /* Refresh description from stored texts */
  for(i = 1; i < iCount; i++) {
    if(iShowLines)
      sDesc = sDesc+IntToString(i)+". ";
    sDesc = sDesc+GetLocalString(oBook, "KU_WRITE"+IntToString(i))+"\n";
  }
  SetDescription(oItem, sDesc);
}

void TextRemove(object oBook, string sPar) {
  int iCount = GetLocalInt(oBook, "KU_WRITE_CNT");
  int iLn = StringToInt(sPar);
  int i;

  if(iLn == 0)
    iLn = iCount;

  iCount--;
  /* Shift strings down */
  for(i = iLn; i < iCount; i++) {
    SetLocalString(oBook, "KU_WRITE"+IntToString(i), GetLocalString(oBook, "KU_WRITE"+IntToString(i+1)));
  }

  /* Decrement line numbers */
  SetLocalInt(oBook, "KU_WRITE_CNT", iCount);
  RefresDesc(oBook);
}

void TextAdd(object oBookm, string sText) {
  int iCount = GetLocalInt(oBook, "KU_WRITE_CNT");
  iCount++;
  SetLocalInt(oBook, "KU_WRITE_CNT", iCount);
  SetLocalString(oBook, "KU_WRITE"+IntToString(iCount), sText);
  RefresDesc(oBook);
}

void WriteCheck(object oPC, string sText) {
  /* Check if we can write */
  if(!GetLocalInt(oPC,"KU_WRITETEXT"))
    return;

  /* Check if we can write */
  object oBook = GetLocalObject(oPC,"KU_WRITETEXT");
  if(!GetIsObjectValid(oBook))
    return;

  /* Remove one line of text */
  if(GetStringLeft(sText, 3) == "/rm") {
    TextRemove(oBook, GetSubString(sText, 4, 4));
    return;
  }

  /* Show/hide line numbers */
  if(GetStringLeft(sText, 4) == "/num") {
    SetLocalInt(oBook, "KU_WRITE_SHOWLN", !GetLocalInt(oBook, "KU_WRITE_SHOWLN"));
    SendMessageToPC(oPC, "Prepnuta viditelnost cisel radku.");
    RefresDesc(oBook);
    return;
  }

  TextAdd(oBook, sText);
}

void StartStopWriting(object oPC, object oBook) {
/*  object oBook = GetItemActivated();
  object oPC = GetItemActivator();*/
  int iWriting = !GetLocalInt(oPC,"KU_WRITETEXT");

  /* Switch writing on/off by using item */
  if(iWriting) {
    SetLocalObject(oPC,"KU_WRITETEXT", oBook);
    SendMessageToPC(oPC, "Zapnuto psani do: "+GetName(oBook));
  }
  else {
    SendMessageToPC(oPC, "Vypnuto psani.");
  }

  SetLocalInt(oPC,"KU_WRITETEXT", iWriting);
}
