/**
 * ku_write_inc script
 *
 * Simple Library to write books, letters, etc.
 *
 * /rm <cislo> - odstran konkretni text
 * /rm - odstran posledni text
 * /num - Zobraz/skryj cisla radku
 */

void PrintHelp(object oPC) {
  SendMessageToPC(oPC,"Ovladani:");
  SendMessageToPC(oPC,"<text> - Prida text na konec.");
  SendMessageToPC(oPC,"/rm - Smaz posledni radek.");
  SendMessageToPC(oPC,"/rm <cislo> - Smaz konkretni radek");
  SendMessageToPC(oPC,"/num - Zobraz/skryj cisla radku");
  SendMessageToPC(oPC,"/hotovo - Ukonci pisemnost - jiz do ni nelze psat.");
  SendMessageToPC(oPC,"/pecet - Zapeceti pisemnost. Nebude jej mozno cist do rozlomeni pecete.");

}

void RefresDesc(object oBook) {
  int iCount = GetLocalInt(oBook, "KU_WRITE_CNT");
  int iShowLines = GetLocalInt(oBook,"KU_WRITE_SHOWLN");
  int iPecet = GetLocalInt(oBook,"KU_WRITE_PECET");

  /* Do not refresh text in sealed list */
  if(iPecet == 1 || iPecet == 2) {
    return;
  }

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

  /* Lock item against overwriting */
  if(GetStringLeft(sText, 7) == "/hotovo") {
    DeleteLocalObject(oPC,"KU_WRITETEXT");
    SetLocalInt(oPC,"KU_WRITETEXT", FALSE);
    SetLocalInt(oBook, "KU_WRITELOCK", 1);
    SendMessageToPC(oPC, "Listina je ukoncena a dale ji nelze upravovat");
    return;
  }

  /* Seal message */
  if(GetStringLeft(sText, 6) == "/pecet") {
    DeleteLocalObject(oPC,"KU_WRITETEXT");
    SetLocalInt(oPC,"KU_WRITETEXT", FALSE);
    SetLocalInt(oBook, "KU_WRITE_PECET", 1);
    SendMessageToPC(oPC, "Listina je zapecetena a neni ji mozno cist do rozlomeni pecete.");
    SetDescription(oBook,"<Zapeceteno>\n\n   "+GetName(oPC));
    return;
  }

  TextAdd(oBook, sText);
}

void StartStopWriting(object oPC, object oBook) {
/*  object oBook = GetItemActivated();
  object oPC = GetItemActivator();*/
  int iWriting = !GetLocalInt(oPC,"KU_WRITETEXT");
  int iLock = GetLocalInt(oBook,"KU_WRITELOCK");
  int iPecet = GetLocalInt(oBook,"KU_WRITE_PECET");

  /* Pecet 1st attempt to brake */
  if(iPecet == 1) {
    SendMessageToPC(oPC, "Pisemnost "+GetName(oBook)+" je zapecetena. Dalsim pouzitim bude pecet rozlomena.");
    SetLocalInt(oPC,"KU_WRITE_PECET", 2);
    return;
  }

  /* Pecet 2nd attempt to brake */
  if(iPecet == 2) {
    SendMessageToPC(oPC, "Rozpeceteno: "+GetName(oBook));
    SetLocalInt(oPC,"KU_WRITE_PECET", 3);
    RefresDesc(oBook);
    return;
  }
  if(iPecet >= 3) {
    RefresDesc(oBook);
    return;
  }

  PrintHelp();

  /* List is locked */
  if(iLock) {
    DeleteLocalObject(oPC,"KU_WRITETEXT");
    SetLocalInt(oPC,"KU_WRITETEXT", FALSE);
    return;
  }

  /* Switch writing on/off by using item */
  if(iWriting) {
    SetLocalObject(oPC,"KU_WRITETEXT", oBook);
    SendMessageToPC(oPC, "Zapnuto psani do: "+GetName(oBook));
  }
  else {
    SendMessageToPC(oPC, "Vypnuto psani.");
    DeleteLocalObject(oPC,"KU_WRITETEXT");
  }

  SetLocalInt(oPC,"KU_WRITETEXT", iWriting);
}
