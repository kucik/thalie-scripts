// OnClosed skript na placeably s inventarem
// V popisu placeablu se objevi jmeno postavy a pocet dreva kolik bylo
// do truhly vlozeno - s pomoci radku s podminkou (if) lze zmenit tagem
// predmety co se budou zaznamenavat

// Autori: Kucik, Shaman, Fryn
// Posledni uprava: 11.2. 2023


#include "aps_include"


void __setDescriptionWithItems(object oPC)
{
  // Definovani nazvu persistentni promenne
  string sVarName = "craft_truhla_pocet_"+GetTag(OBJECT_SELF);
  string sSqlVar = SQLEncodeSpecialChars(sVarName);

  string sSQL = "SELECT player, tag, val FROM pwdata WHERE name = '"+sSqlVar+"';";
  SQLExecDirect(sSQL);

  string sDescr = "";
  while(SQLFetch() == SQL_SUCCESS)
  {
    string sPlayer = SQLDecodeSpecialChars(SQLGetData(1));
    string sTag = SQLDecodeSpecialChars(SQLGetData(2));
    string sVal = SQLDecodeSpecialChars(SQLGetData(3));

    sDescr = sDescr + " \n" + sTag + sVal + " kusù døeva.";
  }

  SetDescription(OBJECT_SELF, sDescr, TRUE);
}

void main()
{
  // Nejak zjistit PC object
  object oPC = GetLastClosedBy();
  // Definovani nazvu persistentni promenne
  string sVarName = "craft_truhla_pocet_"+GetTag(OBJECT_SELF);

  // Nacteni persistentni promenne z db
  int nWood = GetPersistentInt(oPC,sVarName,"pwdata");
  object oCont = (OBJECT_SELF);
  object oItem = GetFirstItemInInventory(oCont);
  while(GetIsObjectValid(oItem))
  {
    string sTag = GetTag(oItem);
    // Cast pro urceni jake predmety se budou zaznamenavat
    // Je treba si najit unikatni tagy daneho predmetu
    if(sTag == "tc_Drev_Vrb" ||
    sTag == "cnrBranchOak" ||
    sTag =="tc_Drev_Zel"||
    sTag =="tc_Drev_Jil")
    {
      /* pricti pocet itemu */
      nWood++;
    }

    oItem = GetNextItemInInventory(oCont);
  }

  // Ulozit aktualizovany pocet nWood do persistentni db
  SetPersistentInt(oPC, sVarName, nWood);


  // Blok koš = funkcionalita koše - smaze vsechny itemy
  oItem = GetFirstItemInInventory(oCont);
  while(GetIsObjectValid(oItem))
  {
    DestroyObject(oItem);
    oItem = GetNextItemInInventory(oCont);
  }

  __setDescriptionWithItems(oPC);
}
