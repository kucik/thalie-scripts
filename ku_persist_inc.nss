/* ku_persist_inc
 * Knihovna pro persistenci
 * ver. 0.4
 * 03. 03 2009 Kucik
 * 09. 06. 2009 Kucik: Opraveno ukladani local variables
 * 2009. 11. 03. Kucik: Pridano cteni string variables, + persistentni obchody
 * 2010-04-07 Kucik: Ukladani description na variables
 * 2010-04-17 Kucik: Persistentni inventory slots a creature appearance.
 * 2010-05-17 Kucik: Opraven vypis pridanych predmetu.
 */


#include "ku_items_inc"
#include "aps_include"
#include "ku_creatures_inc"
#include "ja_inc_frakce"

/* Global Constants */
const string KU_PERS_SPEC_VARNAME = "KU_PERS_SPECIAL";
const int PERSIST_MAX_ITEMS = 100;
const int PERSIST_MAX_ITEMS_SHOP = 300;
const int PERSIST_MAX_LOAD_PLC = 20;
const int PERSIST_ITEMS_LOAD_STEP = 20;
const float PERSIST_ITEMS_STEP_DELAY = 3.0;
const string KU_PERS_SHOP_ITEMPRICE = "PERS_SHOP_PRICE";


/*
 *
 * // Ochrana cen - kvuli obchodum
  int iGold = GetLocalInt(oItem,"GOLDPIECEVALUE");
  if(iGold > 0 && iGold != GetGoldPieceValue(oItem))
    SetGoldPieceValue(oItem,iGold);
 */

 /*
 // Vaha a cena predmetu
        iGold = GetLocalInt(oItem,"GOLDPIECEVALUE");
        iWeight = GetLocalInt(oItem,"WEIGHT");
        if(iGold > 0 && iGold != GetGoldPieceValue(oItem))
          SetGoldPieceValue(oItem,iGold);
        if(iWeight > 0 && iWeight != GetWeight(oItem))
          SetItemWeight(oItem,iWeight);
*/

/************************************/
/* Function prototypes              */
/************************************/

/* Public Functions */

//Remove all items and variables from container
void Persist_ClearContainer(object oCont);

// To use in OnOpen Event.
// Function initialize and fill container
int Persist_OnContainerOpen(object oCont, object oPC);

// To use in OnClose Event
// Save all items into database
int Persist_OnContainerClose(object oCont);

// To use in OnDisturbbed Event
// Remove Item when removed or prepare to save when added
int Persist_DisturbedItem();

/* ITEMS */

// Recreate specified persistent item from DB
object Persist_CreateItemFromDBByID(int id, object oCont=OBJECT_INVALID);

// Generate items in container
// Return number of generated items
void Persist_ReCreateItemsFromDB(object oCont);

// Generate items in container step by step
void Persist_ReCreateItemsStepFromDB(object oCont,int From,int Count, string sContID = "");

// Save item into DB
int Persist_SaveItemToDB(object oItem, string sContID="");

// Save all Items, that arent in DB
int Persist_SaveNewItemsToDB(object oCont);

void Persist_SaveNewItemsToDB_void(object oCont);

// Delete item with DB ID id from DB
int Persist_DeleteItemByIDFromDB(int id);

// Delete item from db (using Persist_DeleteItemByIDFromDB(int id))
int Persist_DeleteItemFromDB(object oItem);

// Delete all items in container.
// Warning! Due the delete of multiple records take care when using this function!!!
int DeleteAllInContainer(object oCont);

string Persist_GetLocalVariables(object oItem);

void Persist_SetLocalVariable(object oItem, string sIP);

int Persist_SetLocalVariables(object oItem, string sIP);

void Persist_RemoveFromDBItemsInCreatureSlots(string sItemIDs);


// Container initialization
string Persist_InitContainer(object oCont);

/* STRINGS */

// Decode string from DB format
string Persist_DecodeDescription(string sDesc);

// Encode string to be able to save in DB
string Persist_EncodeDescription(string sDesc);

/* SPECIALITIES */

// Set some specialities with item
void Persist_ParseSpecialitiesOnItem(object oItem, object oCont, string sSpec);

// Get some specialities about item
string Persist_GetSpecialitiesOnItem(object oItem);


/****************************************
 *        Persistent Shops              *
 ****************************************/

//Get Persistent Store object
object Persist_ShopGetShop(object oObj);

//Put item into persistent shop
int Persist_ShopPutItemToShop(object oItem, object oCrafter);

// Get Item true value without plot flag
int Persist_GetItemGPValue(object oItem);

/****************************************
 *        Persistent placeables         *
 ****************************************/
int Persist_SavePlaceable(object oPlc,object oArea);
int Persist_DeletePlaceablesInArea(object oArea);
void Persist_LoadAddedPlaceables(object oArea, int object_type = -1, int from = -1);
int  Persist_SetSpawnInAreaDisabled(object oArea,int state);

//
//Delete one persistant object (plc or creature) from DB. Not from location.
//
//return -1 - Missing persistant id on object
//return  0 - SQL processed
int Persist_DeleteObjectFromDB(object oPlc);

// Save items in creature inventory slots into DB with container id = sContID
string Persist_SaveItemsInCreatureSlots(object oNPC, string sContID = "0");

void Persist_RecreateItemsInCreatureSlots(object oNPC, string sItemIDs);


/************************************/
/* Functions Definition             */
/************************************/


/************************************/
/* CREATE ITEMS                     */
/************************************/

object Persist_CreateItemFromDBByID(int id, object oCont=OBJECT_INVALID) {

//  if(!GetIsObjectValid(oCont))
//     oCont = Persist_GetTempContainer();

  string sSql = "SELECT id, spec, attributes, descr, vars FROM pw_persist_items WHERE id = "+IntToString(id)+";";
//  SpeakString(sSql);
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
//    string sID = IntToString(id);
    string sSPEC = SQLGetData(2);
    string sAttr = SQLGetData(3);
    string sDesc = SQLGetData(4);
    string sVars = SQLGetData(5);
    object oItem = Persist_CreateItemFromAttributesString(sAttr,oCont);
    Persist_ParseSpecialitiesOnItem(oItem,oCont,sSPEC);
    SetLocalInt(oItem,"KU_PERSISTANT_DB_ID",id);
//    SetDescription(oItem,sDesc,TRUE);
    ku_SetItemDescription(oItem,sDesc);
    Persist_SetLocalVariables(oItem,sVars);
    return oItem;
  }
  else
   return OBJECT_INVALID;

}

void Persist_ReCreateItemsFromDB(object oCont) {

 if(!GetIsObjectValid(oCont))
   return; //-1

 string sContID = Persist_InitContainer(oCont);
 if(sContID == "") {
   return; //-2
 }

 /* New functionality hack */
 if(GetLocalInt(oCont,"KU_PERSISTANT_BLOCKED")) {
    SpeakString("Kontejner se prave obnovuje. Vyckejte.");
    return;
 }
 Persist_ReCreateItemsStepFromDB(oCont,0,0);
 return;
 /* ~ end hack */

  string sSql = "SELECT id, spec, attributes, descr, vars FROM pw_persist_items WHERE container = "+sContID+";";
//  SpeakString(sSql);
  SQLExecDirect(sSql);
  string sSPEC = "";
  string sAttr = "";
  string sDesc = "";
  string sVars = "";
  string sID;
  object oItem = OBJECT_INVALID;
  int i=0,id=0;
  while (SQLFetch() == SQL_SUCCESS &&  i <= PERSIST_MAX_ITEMS) {
    i++;
    sID = SQLGetData(1);
    id = StringToInt(sID);
    sSPEC = SQLGetData(2);
    sAttr = SQLGetData(3);
    sDesc = SQLGetData(4);
    sVars = SQLGetData(5);
    oItem = Persist_CreateItemFromAttributesString(sAttr,oCont);
    Persist_ParseSpecialitiesOnItem(oItem,oCont,sSPEC);
    SetLocalInt(oItem,"KU_PERSISTANT_DB_ID",id);
    SetLocalInt(oItem,"KU_PERSISTANT_CONT_POS",i);
//    SetDescription(oItem,sDesc,TRUE);
    ku_SetItemDescription(oItem,sDesc);
    Persist_SetLocalVariables(oItem,sVars);

    // identification in container
    //SetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+sID,oItem);
    SetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i),oItem);
    SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i),id);
  }
  // Too many items
  if(SQLFetch() == SQL_SUCCESS) {
    SpeakString("V kontejneru je prilis mnoho predmetu a nektere z nich nemohou byt vytvoreny. Uvolnete obsah truhly.");
  }
  else {
    SpeakString("Obnoveno "+IntToString(i)+" predmetu z databaze.");
  }
  SetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT",i);
  return; //i

}

void Persist_ReCreateItemsStepFromDB(object oCont,int From,int Count, string sContID = "") {

 if(!GetIsObjectValid(oCont))
   return; //-1


//  AssignCommand(oCont,SpeakString("DEBUG: Read step "+IntToString(Count)+" items from "+IntToString(From)));


 if(sContID == "") {
   sContID = Persist_InitContainer(oCont);
 }

 WriteTimestampedLogEntry("Persistance DEBUG: Read step "+IntToString(Count)+" items from "+IntToString(From)+ "from container "+GetName(oCont)+" id="+sContID);

 if(sContID == "") {
   DeleteLocalInt(oCont,"KU_PERSISTANT_BLOCKED");
   DeleteLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT");
   WriteTimestampedLogEntry("PERSISTANCE: Error: Empty sContID on Container "+GetName(oCont));
   return; //-2
 }

/*  if(GetLocalInt(oCont,"KU_PERSISTANT_BLOCKED")) {
    SpeakString("Kontejner se prave obnovuje. Vyckejte.");
    return;
  }*/
  int iMaxItems = PERSIST_MAX_ITEMS;
  if(GetLocalInt(oCont,"KU_PERSIST_SHOP")) {
    iMaxItems = PERSIST_MAX_ITEMS_SHOP;
  }

  SetLocalInt(oCont,"KU_PERSISTANT_BLOCKED",TRUE);
  object oOpener = GetLocalObject(oCont,"KU_PERSISTANCE_OPENER");

  string sSql = "SELECT id, spec, attributes, descr, vars FROM pw_persist_items WHERE container = "+sContID+" AND id >"+IntToString(From)+" ORDER BY id;";
//  SpeakString(sSql);
  SQLExecDirect(sSql);
  string sSPEC = "";
  string sAttr = "";
  string sDesc = "";
  string sVars = "";
  string sID;
  object oItem = OBJECT_INVALID;
  int i=Count,id=0;
  int start = Count;
  while (SQLFetch() == SQL_SUCCESS &&  i <= (PERSIST_ITEMS_LOAD_STEP + start)) {
    i++;
    sID = SQLGetData(1);
    id = StringToInt(sID);
    sSPEC = SQLGetData(2);
    sAttr = SQLGetData(3);
    sDesc = SQLGetData(4);
    sVars = SQLGetData(5);
    oItem = Persist_CreateItemFromAttributesString(sAttr,oCont);
    Persist_ParseSpecialitiesOnItem(oItem,oCont,sSPEC);
    SetLocalInt(oItem,"KU_PERSISTANT_DB_ID",id);
    SetLocalInt(oItem,"KU_PERSISTANT_CONT_POS",i);
//    SetDescription(oItem,sDesc,TRUE);
    ku_SetItemDescription(oItem,sDesc);
    Persist_SetLocalVariables(oItem,sVars);

    /* identification in container */
    //SetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+sID,oItem);
    SetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i),oItem);
    SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i),id);
  }
  /* Too many items */
  if(SQLFetch() == SQL_SUCCESS) {
    if(Count > iMaxItems) {
      SpeakString("V kontejneru je prilis mnoho predmetu a nektere z nich nemohou byt vytvoreny. Uvolnete obsah truhly.");
      WriteTimestampedLogEntry("Persistance ERROR: Too many items: "+IntToString(Count)+" items from container "+GetName(oCont)+" id="+sContID);
    }
    // Do next load step
    else {
      SetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT",i);
//      DelayCommand(PERSIST_ITEMS_STEP_DELAY/2,SpeakString("Obnovuji..."));
        SendMessageToPC(oOpener,"Obnovuji...");
//      DelayCommand(PERSIST_ITEMS_STEP_DELAY,SpeakString("Obnovuji..."));
      DelayCommand(PERSIST_ITEMS_STEP_DELAY,Persist_ReCreateItemsStepFromDB(oCont,id,i,sContID));
      return;
    }
  }
  else {
    SendMessageToPC(oOpener,"Hotovo. Obnoveno "+IntToString(i)+" predmetu z databaze.");
//    SpeakString("Hotovo. Obnoveno "+IntToString(i)+" predmetu z databaze.");
  }
  DeleteLocalInt(oCont,"KU_PERSISTANT_BLOCKED");
  SetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT",i);
  WriteTimestampedLogEntry("Persistance DEBUG: finished "+IntToString(Count)+" items from container "+GetName(oCont)+" id="+sContID);
  return; //i

}

/************************************/
/* SAVE ITEMS                     */
/************************************/

int Persist_SaveItemToDB(object oItem, string sContID="") {

 if(sContID == "") {
   sContID = Persist_InitContainer(GetItemPossessor(oItem));
 }
 if(sContID == "") {
   return -1;
 }

 if(GetBaseItemType(oItem) == BASE_ITEM_GOLD && GetItemStackSize(oItem) > 50000) {
   SpeakString("Chyba pri ukladani predmetu "+GetName(oItem)+"do databaze. Neni mozne ukladat vice nez 50 000 zlatych.");
   return -1;
 }

 string sAttr = Persist_GetItemAttributesString(oItem);
 string sDesc = Persist_EncodeDescription(ku_GetItemDescription(oItem));
// string sDesc = Persist_EncodeDescription(GetDescription(oItem));
 string sSpec = Persist_GetSpecialitiesOnItem(oItem);
 string sVars = Persist_GetLocalVariables(oItem);

 string sValues = "'"+sContID+"',"+
                  "'"+sSpec+"',"+
                  "'"+sAttr+"',"+
                  "'"+sVars+"',"+
                  "'"+sDesc+"'";

 /* Compose SQL statement */
// string sSQL = "INSERT INTO pw_persist_items  (container,spec,attributes,descr) VALUES ("+sValues+"); SELECT LAST_INSERT_ID();";
 string sSQL = "INSERT INTO pw_persist_items  (container,spec,attributes,vars,descr) VALUES ("+sValues+");";
// SpeakString(sSQL);
 SQLExecDirect(sSQL);
 SQLExecDirect("SELECT LAST_INSERT_ID();");
 if (SQLFetch() == SQL_SUCCESS) {
   string sRET = SQLGetData(1);
//   SpeakString(sRET);
   SetLocalInt(oItem,"KU_PERSISTANT_DB_ID",StringToInt(sRET));
   return StringToInt(sRET);
 }
 else {
   SpeakString("Chyba pri ukladani predmetu "+GetName(oItem)+"do databaze. Kontaktujte WB");
   return -1;
 }

}

void Persist_SaveNewItemsToDB_void(object oCont) {
  Persist_SaveNewItemsToDB(oCont);
}

int Persist_SaveNewItemsToDB(object oCont) {
  string sContID = Persist_InitContainer(oCont);

  if(sContID == "") {
   return -1;
  }
  int iAdded = 0;

  int  i = GetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT");
  int id;
  object oItem = GetFirstItemInInventory(oCont);
  while(GetIsObjectValid(oItem)) {
    if( GetLocalInt(oItem,"KU_PERSISTANT_DB_ID") > 0) {
      //Allready saved
    }
    else {
      id = Persist_SaveItemToDB(oItem,sContID);
      if(id > 0) {
        i++;
        iAdded++;
        SetLocalInt(oItem,"KU_PERSISTANT_DB_ID",id);
        SetLocalInt(oItem,"KU_PERSISTANT_CONT_POS",i);

        SetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i),oItem);
        SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i),id);
      }
      else{
        SpeakString("Chyba pri ukladani predmetu "+GetName(oItem)+"do databaze. Kontaktujte WB");
        WriteTimestampedLogEntry("Some Error when saving "+GetName(oItem)+" into "+sContID);
      }
    }
    oItem = GetNextItemInInventory(oCont);
  }

  string sSql = "SELECT COUNT(*) FROM pw_persist_items WHERE container = "+sContID+";";
  string count = "";
//  SpeakString("GetCount: "+sSql);
  SQLExecDirect(sSql);
  if (SQLFetch() == SQL_SUCCESS) {
    count = SQLGetData(1);
  }
  SpeakString("Do persistentni bedny bylo pridano "+IntToString(iAdded)+" predmetu. Celkem je v bedne "+count+" predmetu z maxima 100.");


  SetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT",i);
  return i;
}

/************************************/
/* DELETE ITEMS                     */
/************************************/

int Persist_DeleteItemByIDFromDB(int id) {
  if(id <= 0)
    return id;

  string sSQL = "DELETE FROM pw_persist_items WHERE id="+IntToString(id)+";";
//  SpeakString(sSQL);
  SQLExecDirect(sSQL);

  return 1;
}

int Persist_DeleteItemFromDB(object oItem) {
  return Persist_DeleteItemByIDFromDB(GetLocalInt(oItem,"KU_PERSISTANT_DB_ID"));
}

int Persist_DisturbedItem() {

  object oItem = GetInventoryDisturbItem();

  if(GetInventoryDisturbType() == INVENTORY_DISTURB_TYPE_ADDED) {
    DeleteLocalInt(oItem,"KU_PERSISTANT_DB_ID");
    DeleteLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
    return -1;
  }

  object oCont = OBJECT_SELF;
  object oPC = GetLastDisturbed();
  int id;

//  SpeakString("Removed from inventory");

  if(GetIsObjectValid(oItem))
    id = GetLocalInt(oItem,"KU_PERSISTANT_DB_ID");

  if(id > 0) {
    int pos = GetLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
    DeleteLocalInt(oItem,"KU_PERSISTANT_DB_ID");
    DeleteLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
    DeleteLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(pos));
    SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(pos),-1);
    Persist_DeleteItemByIDFromDB(id);
//    SpeakString("Deleted "+GetName(oItem));
    return id;
  }
  else {
    int iCnt = GetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT");
    int i;
    /* Projit vsechny vygenerovane itemy */
    for(i=1;i<=iCnt;i++) {
      /* DB id */
      id = GetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i));
//      SpeakString("Check "+IntToString(i)+" id = "+IntToString(id));
      /* Pokud uz item nebyl odebran */
      if(id != -1) {
        oItem = GetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i));
        /* Pokud uz tu item neni - prave zmizel */
        if( GetItemPossessor(oItem) != oCont) {
          DeleteLocalInt(oItem,"KU_PERSISTANT_DB_ID");
          DeleteLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
          DeleteLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i));
          SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i),-1);
          Persist_DeleteItemByIDFromDB(id);
//          SpeakString("Deleted "+IntToString(id));
          return id;
        }
      }
    }
    return -1;
  }

//SetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i),oItem);
//SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i),id);
}

int DeleteAllInContainer(object oCont) {
  if(!GetIsObjectValid(oCont))
    return -1;

  string sContID = Persist_InitContainer(oCont);

  string sSql = "DELETE FROM pw_persist_items WHERE container = "+sContID+";";
  SQLExecDirect(sSql);

  return 0;
}

/***********************
 * Container           *
 ***********************/

string Persist_InitContainer(object oCont) {
  if(!GetIsObjectValid(oCont))
    return "";

  int nType = GetLocalInt(oCont,"KU_PERSISTANCE_TYPE");
  object oPC = GetLocalObject(oCont,"KU_PERSISTANCE_OPENER");
//  SpeakString("~"+GetPCPlayerName(oPC)+"|"+GetName(oPC));

  /* If container was opened by different player */
  switch(nType) {
    /* Player only */
    case 3:
    /* Tag + Area + Player */
    case 2: {
      if(GetLocalObject(oCont,"KU_PERSISTANCE_PREV_OPENER") != oPC)
        SetLocalInt(oCont,"KU_PERSISTANCE_INITIALIZED",0);
      break;
    }
  }

  if(GetLocalInt(oCont,"KU_PERSISTANCE_INITIALIZED") == 1) {
    return GetLocalString(oCont,"KU_PERSISTANCE_CONTAINER_ID");
  }
  else {
    string sCont = "";
    string sArea = "~";
    string sTag = "~";
    string sPC = "~";
//    int nType = GetLocalInt(oCont"KU_PERSISTANCE_TYPE");
    switch(nType) {
      /* Player only */
      case 3: sPC = "~"+GetPCPlayerName(oPC)+"|"+GetName(oPC); break;
      /* Tag + Area + Player */
      case 2: sPC = "~"+GetPCPlayerName(oPC)+"|"+GetName(oPC);
      /* Tag + Area */
      case 1: sArea = "~"+GetTag(GetArea(oCont));
      /* Tag ONLY */
      default: sTag = "~"+GetTag(oCont);
    }

    sCont = StrTrim(sPC+sTag+sArea,"'");
    string sContID = "";
    string sSQL = "SELECT id from pw_persist_containers WHERE ident='"+sCont+"';";
//    SpeakString(sSQL);
    SQLExecDirect(sSQL);
    if (SQLFetch() == SQL_SUCCESS) {
      sContID = SQLGetData(1);
//      SpeakString(sContID);
    }
    else {
//      SpeakString("Vytvarim kontejner...");
      sSQL = "INSERT INTO pw_persist_containers (ident) VALUES ('"+sCont+"');";// SELECT LAST_INSERT_ID();";
//      sSQL = "INSERT INTO pw_persist_containers (ident) VALUES ('"+sCont+"'); SELECT LAST_INSERT_ID();";
//      SpeakString(sSQL);
      SQLExecDirect(sSQL);
      SQLExecDirect("SELECT LAST_INSERT_ID();");
      if (SQLFetch() == SQL_SUCCESS) {
        sContID = SQLGetData(1);
//        SpeakString(sContID);
      }
      else
        SpeakString("Chyba pri vytvareni kontejneru. Kontaktujte DM.");
        return "";
    }

    SetLocalString(oCont,"KU_PERSISTANCE_CONTAINER_ID",sContID);
    SetLocalObject(oCont,"KU_PERSISTANCE_PREV_OPENER",oPC);
    SetLocalInt(oCont,"KU_PERSISTANCE_INITIALIZED",1);
    return sContID;
  }

}

/* Description and long strings */
string Persist_DecodeDescription(string sDesc) {
   return sDesc;
}

string Persist_EncodeDescription(string sDesc) {
   return StrReplace(sDesc,"'","''");
}


/* Specialities */
void Persist_ParseSpecialitiesOnItem(object oItem, object oCont, string sSpec) {

  /* Still nothing important */
  SetLocalString(oItem,KU_PERS_SPEC_VARNAME,sSpec);
}

string Persist_GetSpecialitiesOnItem(object oItem) {

  /* Still nothing important */
  return GetLocalString(oItem,KU_PERS_SPEC_VARNAME);
}

/********************************
 * LocalVariables                *
 ********************************/

string Persist_GetLocalVariables(object oItem) {
  int cnt = GetLocalVariableCount(oItem);
  int i;
  struct LocalVariable lv;
  string str;

  for(i=0;i<cnt;i++) {
    lv = GetLocalVariableByPosition(oItem,i);
    if(GetStringLeft(lv.name,5) != "NWNX!" &&
                        lv.name != "DESCRIPTION" &&
                        lv.name != "KU_PERSISTANT_DB_ID") {
    switch(lv.type) {
      case 1: {
//        SpeakString("DEBUG: Reading variable"+lv.name+"="+IntToString(GetLocalInt(oItem,lv.name)));
        str = str+lv.name+PERSISTANCE_SECONDARY_DELIMITER+
                  IntToString(lv.type)+PERSISTANCE_SECONDARY_DELIMITER+
                  IntToString(GetLocalInt(oItem,lv.name))
                  +PROPERTIES_DELIMITER;
        break;
      }
      case 2: {
//        SpeakString("DEBUG: Reading variable"+lv.name+"="+FloatToString(GetLocalFloat(oItem,lv.name)));
        str = str+lv.name+PERSISTANCE_SECONDARY_DELIMITER+
                  IntToString(lv.type)+PERSISTANCE_SECONDARY_DELIMITER+
                  FloatToString(GetLocalFloat(oItem,lv.name))
                  +PROPERTIES_DELIMITER;
        break;
      }
      case 3: {
//        SpeakString("DEBUG: Reading variable"+lv.name+"="+GetLocalString(oItem,lv.name));
        string sTemp = StrReplace(GetLocalString(oItem,lv.name),"#","");
        sTemp = StrReplace(sTemp,"|","");
        sTemp = SQLEncodeSpecialChars(sTemp);
        if(GetStringLength(sTemp) > 0) {
          str = str+lv.name+PERSISTANCE_SECONDARY_DELIMITER+
                    IntToString(lv.type)+PERSISTANCE_SECONDARY_DELIMITER+
                    sTemp
                    +PROPERTIES_DELIMITER;
        }
        break;
      }
    }
    }
  }
  return str;
}

int Persist_SetLocalVariables(object oItem, string sIP) {
   int iNum = 0;
   int iStart = 0;
   int DLen = GetStringLength(PROPERTIES_DELIMITER);
   int iEnd = FindSubString(sIP,PROPERTIES_DELIMITER,iStart);
   while(iEnd > -1) {
     Persist_SetLocalVariable(oItem,GetSubString(sIP,iStart,iEnd - iStart));

     iStart = iEnd + DLen;
     iEnd = FindSubString(sIP,PROPERTIES_DELIMITER,iStart);
   }

   return 0;
}

void Persist_SetLocalVariable(object oItem, string sIP) {
    int iStart = 0;
    int iEnd;
    string name,var;
    int type;
    int iDLen = GetStringLength(PERSISTANCE_SECONDARY_DELIMITER);

//    SendMessageToPC(GetFirstPC(),sIP);

    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    name = GetSubString(sIP,iStart,iEnd - iStart);

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    type = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
//    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    var = GetSubString(sIP,iStart,GetStringLength(sIP) - iStart);

    switch(type) {
      case 1:
        SetLocalInt(oItem,name,StringToInt(var));
        break;
      case 2:
        SetLocalFloat(oItem,name,StringToFloat(var));
        break;
      case 3:
        SetLocalString(oItem,name,var);
        break;
      case 4:
//        SetLocalObject(oItem,name,var);
        break;
      case 5:
        SetLocalLocation(oItem,name,StringToLocation(var));
        break;
    }

  return;
}

/********************************
 * Container handling functions *
 ********************************/

void Persist_ClearContainer(object oCont) {

  /* In a first remove all items */
  object oItem = GetFirstItemInInventory(oCont);
  while(GetIsObjectValid(oItem)) {
    DestroyObject(oItem);
    oItem = GetNextItemInInventory(oCont);
  }

  int i = GetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT");

  while(i>0) {
    DeleteLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i));
    DeleteLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i));
    i--;
  }
  SetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT",0);


}

int Persist_OnContainerOpen(object oCont, object oPC) {

  if(GetLocalInt(oCont,"KU_PERS_FIRST_OPEN") != 1 && GetIsOpen(oCont) == FALSE) {
    SetLocalInt(oCont,"LOCKED",GetLocked(oCont));
    SetLocalInt(oCont,"LOCK_KEY_REQUIED",GetLockKeyRequired(oCont));
    SetLocalString(oCont,"LOCK_KEY_TAG",GetLockKeyTag(oCont));
    SetLocalInt(oCont,"KU_PERS_FIRST_OPEN",1);
  }

  if(GetLocalInt(oCont,"KU_PERSISTANT_BLOCKED")) {
    SpeakString("Kontejner se prave obnovuje. Vyckejte!");
    return 0;
  }

  int nType = GetLocalInt(oCont,"KU_PERSISTANCE_TYPE");
  object oPrevPC = GetLocalObject(oCont,"KU_PERSISTANCE_PREV_OPENER");
  object oPrevSafe = GetLocalObject(oPC,"KU_PERSISTANCE_PREV_SAFE");
  int bFilled = GetLocalInt(oCont,"KU_PERSISTANCE_FILLED");
  int bClear = TRUE;

  SetLocalObject(oPC,"KU_PERSISTANCE_PREV_SAFE",oCont);
  /* Everything is OK */
  if((nType < 2) && (bFilled) )
    return 0;

  /* Same PC and still filed */
  if( (oPC == oPrevPC) && (bFilled) && oPrevSafe == oCont)
    return 0;
  SetLockKeyRequired(oCont,TRUE);

//  SpeakString("LOCKED - "+IntToString(GetLocalInt(oCont,"LOCKED")));

  SetLocalObject(oCont,"KU_PERSISTANCE_OPENER",oPC);
  Persist_ClearContainer(oCont);

  DelayCommand(0.2,Persist_ReCreateItemsFromDB(oCont));

  SetLocalInt(oCont,"KU_PERSISTANCE_FILLED",TRUE);
  SetLocalInt(oCont,"KU_PERS_BLOCKED_FROM",0);

  return 0;
}

void Persist_UnblockContainer(object oCont) {

  SetLockKeyRequired(oCont,GetLocalInt(oCont,"LOCK_KEY_REQUIED"));
  SetLockKeyTag(oCont,GetLocalString(oCont,"LOCK_KEY_TAG"));
  SetLocked(oCont,GetLocalInt(oCont,"LOCKED"));
}

int Persist_OnContainerClose(object oCont) {

  if(GetLocalInt(oCont,"KU_PERSISTANT_BLOCKED")) {
    SpeakString("Kontejner se prave obnovuje.");
    SpeakString("Nove vlozene predmety nebyly ulozeny!");

    int iDelay = FloatToInt(PERSIST_ITEMS_STEP_DELAY * IntToFloat(2 * (PERSIST_MAX_ITEMS/PERSIST_ITEMS_LOAD_STEP)));
    int iAct = ku_GetTimeStamp();
    int iFrom = GetLocalInt(oCont,"KU_PERS_BLOCKED_FROM");
    /* Nastav, ze je trezor zablokovany */
    if(iFrom == 0) {
      iFrom = iAct;
      SetLocalInt(oCont,"KU_PERS_BLOCKED_FROM",iAct);
    }
    /* Pokud je zablokovany moc dlouho, odblokuj */
    if((iFrom + iDelay) < iAct ) {
       DeleteLocalInt(oCont,"KU_PERSISTANT_BLOCKED");
       DeleteLocalInt(oCont,"KU_PERSISTANCE_FILLED");
    }
    /* Cekej */
    else {
      return 0;
    }
  }
  SetLocalInt(oCont,"KU_PERS_BLOCKED_FROM",0);

  if(GetLocalInt(oCont,"KU_PERS_FIRST_OPEN") != 1 && GetIsOpen(oCont) == FALSE) {
    SetLocalInt(oCont,"LOCKED",GetLocked(oCont));
    SetLocalInt(oCont,"LOCK_KEY_REQUIED",GetLockKeyRequired(oCont));
    SetLocalString(oCont,"LOCK_KEY_TAG",GetLockKeyTag(oCont));
    SetLocalInt(oCont,"KU_PERS_FIRST_OPEN",1);
  }

  SetLockKeyTag(oCont,"notag");
  SetLockKeyRequired(oCont,TRUE);
  SetLocked(oCont,TRUE);

  DelayCommand(10.0,Persist_UnblockContainer(oCont));
  SendMessageToPC(GetLastClosedBy(),"Trezor zpracovava predmety. Za okamzik bude opet k dispozici.");

  if(GetItemCount(oCont) > PERSIST_MAX_ITEMS) {
    SpeakString("V kontejneru je prilis mnoho predmetu. Odeberte nektere!");
  }

  DelayCommand(3.0,Persist_SaveNewItemsToDB_void(oCont));

  return TRUE;
}


/***********************************************
 ***********************************************
 **          Persistent Shop                  **
 ***********************************************
 ***********************************************/

 object Persist_ShopGetChest(object oObj);
void Persist_ShopMoveCreatedItems(object oShop, object oChest, int bEmpty=0);


int Persist_OnShopOpen(object oCont, object oPC) {

  object oShop = oCont;
  object oChest = Persist_ShopGetChest(oShop);

  int nType = GetLocalInt(oShop,"KU_PERSISTANCE_TYPE");
//  object oPrevPC = GetLocalObject(oCont,"KU_PERSISTANCE_PREV_OPENER");
  int bFilled = GetLocalInt(oChest,"KU_PERSISTANCE_FILLED");
  int bClear = TRUE;

  /* Everything is OK */
  if((nType < 2) && (bFilled) )
    return 0;

  /* Same PC and still filed */
//  if( (oPC == oPrevPC) && (bFilled) )
//    return 0;
//  SetLockKeyRequired(oCont,TRUE);

//  SpeakString("LOCKED - "+IntToString(GetLocalInt(oCont,"LOCKED")));

  SetLocalObject(oChest,"KU_PERSISTANCE_OPENER",oPC);
  SetLocalInt(oChest,"KU_PERSIST_SHOP",1);

//  Persist_ClearContainer(oCont);

//  object oChest = Persist_ShopGetChest(oShop);
  SetLockLockable(oChest,TRUE);
  SetLocked(oChest,TRUE);
  SetLockKeyRequired(oChest,TRUE);
  SetLockKeyTag(oChest,"**");

  DelayCommand(0.2,Persist_ReCreateItemsFromDB(oChest));

  DelayCommand(0.2+(PERSIST_ITEMS_STEP_DELAY/2),Persist_ShopMoveCreatedItems(oShop,oChest));

  SetLocalInt(oChest,"KU_PERSISTANCE_FILLED",TRUE);
  SetLocalInt(oShop,"KU_PERSISTANCE_FILLED",TRUE);

  return 0;
}

/*int Persist_ShopSetGoldPieceValue(object oItem,int iPrice) {
  int iStack = GetItemStackSize(oItem);
  SetGoldPieceValue(oItem,iPrice);
  int iNewPrice = GetGoldPieceValue(oItem) / iStack;

  if(iNewPrice != iPrice) {
    SetGoldPieceValue(oItem,0);
    int iNullPrice = GetGoldPieceValue(oItem) / iStack;
    int iAdd = iPrice - iNullPrice;
    SetGoldPieceValue(oItem,iAdd);
  }
  return GetGoldPieceValue(oItem) / iStack;
}*/

void Persist_ShopMoveCreatedItems(object oShop, object oChest, int bEmpty=0) {

  int iEmpty = 1;
  object oItem  = GetFirstItemInInventory(oChest);
  object oNew;
  while(GetIsObjectValid(oItem)) {
    iEmpty = 0;
    oNew = CopyItem(oItem,oShop,TRUE);
    SetGoldPieceValue(oNew,GetLocalInt(oItem,"GOLDPIECEVALUE"));
    DestroyObject(oItem,0.3);
    oItem = GetNextItemInInventory(oChest);
  }

  if(iEmpty) {
    bEmpty++;
  }

  if(bEmpty < 5) {
    DelayCommand(PERSIST_ITEMS_STEP_DELAY,Persist_ShopMoveCreatedItems(oShop,oChest,bEmpty));
  }
  else {
    SetLocked(oChest,FALSE);
    SetLockLockable(oChest,FALSE);
  }

}

void Persist_ShopPayToCrafter(object oItem) {


//  int iPrice     = GetLocalInt(oItem,"GOLDPIECEVALUE");
  int iPrice     = GetLocalInt(oItem,KU_PERS_SHOP_ITEMPRICE);

  string  sPlayer = GetLocalString(oItem,"KU_PERS_SHOP_SELLER_P");
  string  sTag    = GetLocalString(oItem,"KU_PERS_SHOP_SELLER_T");
  string  sPrice  = IntToString(iPrice);
  WriteTimestampedLogEntry("PERSSHOP: ... koupil "+GetName(oItem)+" za "+sPrice+" -> ("+sPlayer+" "+sTag+").");
  string  sWhere  = "  WHERE player='" + sPlayer + "' AND tag='" + sTag + "' AND name='GOLD'";

  string sSQL = "SELECT val FROM pwdata "+sWhere+"";
  SQLExecDirect(sSQL);
    //WriteTimestampedLogEntry("SQL: "+sSQL);

  if (SQLFetch() == SQL_SUCCESS) {
       string sVal = SQLGetData(1);
       string sSQL = "UPDATE pwdata SET val = "+sVal+" + "+sPrice+ sWhere+ ";";
//       SendMessageToPC(GetFirstPC(),"DEBUG"+sSQL);
       SQLExecDirect(sSQL);

  }
  else
    {
        // row doesn't exist
        sSQL = "INSERT INTO pwdata (player,tag,name,val,expire) VALUES" +
               "('" + sPlayer + "','" + sTag + "','GOLD','" +
               sPrice + "',0)";
//        SendMessageToPC(GetFirstPC(),"DEBUG"+sSQL);
        SQLExecDirect(sSQL);
    }



//  string  sWhere  = "  WHERE player='" + sPlayer + "' AND tag='" + sTag + "' AND name='GOLD'";
/*
  string sSQL = "UPDATE pwdata SET val = (SELECT val FROM pwdata "+sWhere+") + "+sPrice+ sWhere+ ";";
  SendMessageToPC(GetFirstPC(),sSQL);
  SQLExecDirect(sSQL);
  */

}

int Persist_ShopDisturbedItem(object oItem, object oPC, object oFrom) {


  if(!GetLocalInt(oFrom,"KU_PERSIST_SHOP")) {
    return 0;
  }

  object oCont = oFrom;
  int id = -1;

  if(GetLocalInt(oItem,"ORIG_PRICE")) {
    SetGoldPieceValue(oItem,GetLocalInt(oItem,"ORIG_PRICE"));
  }

//  SendMessageToPC(oPC,"DEBUG: Removed "+GetName(oItem)+" from inventory "+GetName(oCont));

  if(GetIsObjectValid(oItem))
    id = GetLocalInt(oItem,"KU_PERSISTANT_DB_ID");

  if(id > 0) {
    int pos = GetLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
    DeleteLocalInt(oItem,"KU_PERSISTANT_DB_ID");
    DeleteLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
    DeleteLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(pos));
    SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(pos),-1);
    Persist_DeleteItemByIDFromDB(id);
//    SendMessageToPC(oPC,"DEBUG: Pay To crafter");
//    SpeakString("Deleted "+GetName(oItem));
    WriteTimestampedLogEntry("PERSSHOP: "+GetName(oPC)+"("+GetPCPlayerName(oPC)+") koupil "+GetName(oItem)+".");
    Persist_ShopPayToCrafter(oItem);
    DeleteLocalString(oItem,"KU_PERS_SHOP_SELLER_P");
    DeleteLocalString(oItem,"KU_PERS_SHOP_SELLER_T");
    DeleteLocalInt   (oItem,KU_PERS_SHOP_ITEMPRICE);
    return id;
  }
  else {
    int iCnt = GetLocalInt(oCont,"KU_PERSISTANT_DB_OBJ_COUNT");
    int i;
    /* Projit vsechny vygenerovane itemy */
    for(i=1;i<=iCnt;i++) {
      /* DB id */
      id = GetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i));
//      SpeakString("DEBUG: Check "+IntToString(i)+" id = "+IntToString(id));
      /* Pokud uz item nebyl odebran */
      if(id != -1) {
        oItem = GetLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i));
        /* Pokud uz tu item neni - prave zmizel */
        if( GetItemPossessor(oItem) != oCont) {
          DeleteLocalInt(oItem,"KU_PERSISTANT_DB_ID");
          DeleteLocalInt(oItem,"KU_PERSISTANT_CONT_POS");
          DeleteLocalObject(oCont,"KU_PERSISTANT_DB_OBJ_"+IntToString(i));
          SetLocalInt(oCont,"KU_PERSISTANT_DB_ID_"+IntToString(i),-1);
          Persist_DeleteItemByIDFromDB(id);
//          SpeakString("DEBUG: Deleted "+IntToString(id));
          return id;
        }
      }
    }
    return -1;
  }

}

int Persist_ShopPutItemToShop(object oItem, object oCrafter) {

  object oChest = Persist_ShopGetChest(OBJECT_SELF);
  object oShop  = Persist_ShopGetShop(OBJECT_SELF);

  string sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oCrafter));
  string sTag = SQLEncodeSpecialChars(GetName(oCrafter));

//  SpeakString("DEBUG: price - "+IntToString(GetLocalInt(OBJECT_SELF,KU_PERS_SHOP_ITEMPRICE)));
//  string sContId = GetLocalString(oShop,"KU_PERSISTANCE_CONTAINER_ID");
  string sContId = "";

  SetPlotFlag(oItem,0);
  SetStolenFlag(oItem,0);
//  AssignCommand(oCrafter,SpeakString("Copying item "+GetName(oItem)+" into "+GetName(oShop)));
  int iPrice = GetLocalInt(oItem,"GOLDPIECEVALUE");
  SetLocalString(oItem,"KU_PERS_SHOP_SELLER_P",sPlayer);
  SetLocalString(oItem,"KU_PERS_SHOP_SELLER_T",sTag);
//  SetLocalInt   (oItem,"KU_PERS_SHOP_PRICE",iPrice);
//  SpeakString("DEBUG: price2 - "+IntToString(GetLocalInt(OBJECT_SELF,KU_PERS_SHOP_ITEMPRICE)));
  int iID = Persist_SaveItemToDB(oItem,sContId);
  SetLocalInt(oItem,"ku_persshop_do_not_take",TRUE);
  DestroyObject(oItem,0.1);
  object oNewItem = Persist_CreateItemFromDBByID(iID,oChest);
  object oShopItem = CopyItem(oNewItem,oShop,TRUE);
//  SetGoldPieceValue(oShopItem,GetLocalInt(oNewItem,"GOLDPIECEVALUE"));
  SetGoldPieceValue(oShopItem,iPrice);

  WriteTimestampedLogEntry("PERSSHOP: "+GetName(oCrafter)+"("+GetPCPlayerName(oCrafter)+") dal do obchodu "+GetName(oItem)+" za "+IntToString(iPrice)+".");

  SetLocalInt(oNewItem,"ku_persshop_do_not_take",TRUE);
  DestroyObject(oNewItem,0.2);

//  object oNewItem = CopyItem(oItem,oShop,TRUE);
//  SetGoldPieceValue(oNewItem,GetLocalInt(oItem,"GOLDPIECEVALUE"));
//  DestroyObject(oItem);

//  SetLocalString(oNewItem,"KU_PERS_SHOP_SELLER_P",sPlayer);
//  SetLocalString(oNewItem,"KU_PERS_SHOP_SELLER_T",sPlayer);
//  SetGoldPieceValue(oItem,iPrice);
//  int iID = Persist_SaveItemToDB(oNewItem,sContId);


//  DestroyObject(oNewItem);
//  Persist_CreateItemFromDBByID(iID,oShop);

  return iID;
}

int Persist_ShopGetNumberofMyItems(object oCrafter) {

//  object oChest = Persist_ShopGetChest(OBJECT_SELF);
  object oShop  = Persist_ShopGetShop(OBJECT_SELF);

  string sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oCrafter));
//  string sTag = SQLEncodeSpecialChars(GetName(oCrafter));

  int iCnt = 0;
  object oItem = GetFirstItemInInventory(oShop);
  while(GetIsObjectValid(oItem)) {
    if(GetLocalString(oItem, "KU_PERS_SHOP_SELLER_P") == sPlayer)
      iCnt++;
    oItem = GetNextItemInInventory(oShop);
  }

  return iCnt;
}


object Persist_ShopGetShop(object oObj) {

  object oShop = GetLocalObject(oObj,"KU_PERS_SHOP");
  if(GetIsObjectValid(oShop)) {
    return oShop;
  }

  string ku_shop_tag = "ku_pers_store";
  int i = 1;
  oShop = GetNearestObject(OBJECT_TYPE_STORE,oObj,i);
  while(GetIsObjectValid(oShop)) {
    if(GetStringLeft(GetTag(oShop),13) == ku_shop_tag) {
      break;
    }
    i++;
    oShop = GetNearestObject(OBJECT_TYPE_STORE,oObj,i);
  }

  if(GetIsObjectValid(oShop)) {
    SetLocalObject(oObj,"KU_PERS_SHOP",oShop);
    return oShop;
  }

  GetObjectByTag(ku_shop_tag);
  if(GetIsObjectValid(oShop)) {
    SetLocalObject(oObj,"KU_PERS_SHOP",oShop);
    return oShop;
  }

  SpeakString("Chyba! Nenalezen persistentni obchod!",TALKVOLUME_SHOUT);
  return OBJECT_INVALID;
}

object Persist_ShopGetChest(object oObj) {

  object oShop = GetLocalObject(oObj,"KU_PERS_SHOPCHEST");
  if(GetIsObjectValid(oShop)) {
    return oShop;
  }

  string ku_shop_tag = "ku_pers_storechest";
  oShop = GetNearestObjectByTag(ku_shop_tag,oObj,1);

  if(GetIsObjectValid(oShop)) {
    SetLocalObject(oObj,"KU_PERS_SHOPCHEST",oShop);
    return oShop;
  }

  SpeakString("Chyba! Nenalezena truhla pro persistentni obchod!",TALKVOLUME_SHOUT);
  return OBJECT_INVALID;
}

int Persist_ShopGetHasIsItemToSold(object oSpeaker) {

  object oChest = Persist_ShopGetChest(oSpeaker);
  object oItem  = GetFirstItemInInventory(oChest);
  object oPrev  = GetLocalObject(oSpeaker,"actually_selling_item");
  while(  (   GetIsObjectValid(oPrev)
              && oPrev == oItem)
           || GetLocalInt(oItem,"ku_persshop_do_not_take") == TRUE
           || GetBaseItemType(oItem) == BASE_ITEM_GOLD
           || !GetIdentified(oItem)) {
    oItem = GetNextItemInInventory(oChest);
    if(!GetIsObjectValid(oItem)) {
      return FALSE;
    }
  }


  if(!GetIsObjectValid(oItem)) {
    return FALSE;
  }

  if(GetBaseItemType(oItem) == BASE_ITEM_GOLD) {
    return FALSE;
  }

  if(!GetIdentified(oItem)) {
    return FALSE;
  }

  SetCustomToken(6022,IntToString(Persist_GetItemGPValue(oItem)));

  SetLocalObject(oSpeaker,"actually_selling_item",oItem);
  SetCustomToken(6020,GetName(oItem));
  return TRUE;

}

int Persist_GetItemGPValue(object oItem) {

  int iPlot  = GetPlotFlag(oItem);
  SetPlotFlag(oItem,0);
  int iValue = GetGoldPieceValue(oItem);
  SetPlotFlag(oItem,iPlot);

  if(!GetLocalInt(oItem,"ORIG_PRICE")) {
    SetLocalInt(oItem,"ORIG_PRICE",iValue);
  }

  return iValue;
}

/***********************************************
 ***********************************************
 **          Persistent placeables            **
 ***********************************************
 ***********************************************/

string __colectPlcAttributes(object oPlc) {
 /* Placeable attributes */
 int iVar;
 string sVar;

 string sAttr = "";

   /* Plc Expiration */
   iVar = GetLocalInt(oPlc,"PLC_EXPIRATION");
   if(iVar > 0) {
     sAttr = sAttr+"PLC_EXPIRATION"+PERSISTANCE_SECONDARY_DELIMITER+
             "1"+PERSISTANCE_SECONDARY_DELIMITER+
             IntToString(iVar)
             +PROPERTIES_DELIMITER;
   }
   /* Save faction */
   if(GetObjectType(oPlc) == OBJECT_TYPE_CREATURE) {
     sAttr = sAttr+"FACTION"+PERSISTANCE_SECONDARY_DELIMITER+
             "99"+PERSISTANCE_SECONDARY_DELIMITER+
             GetNPCFaction(oPlc)
             +PROPERTIES_DELIMITER;
   }
   /* Useable flag */
   sAttr = sAttr+"USEABLE_FLAG"+PERSISTANCE_SECONDARY_DELIMITER+
           "99"+PERSISTANCE_SECONDARY_DELIMITER+
             IntToString(GetUseableFlag(oPlc))
             +PROPERTIES_DELIMITER;
   /* Plot flag */
   sAttr = sAttr+"PLOT_FLAG"+PERSISTANCE_SECONDARY_DELIMITER+
           "99"+PERSISTANCE_SECONDARY_DELIMITER+
             IntToString(GetPlotFlag(oPlc))
             +PROPERTIES_DELIMITER;
   /* PLC_ITEMS */
   sVar = GetLocalString(oPlc,"PLC_ITEMRESREF");
   if(GetStringLength(sVar) > 0) {
   sAttr = sAttr+"PLC_ITEMRESREF"+PERSISTANCE_SECONDARY_DELIMITER+
           "3"+PERSISTANCE_SECONDARY_DELIMITER+
             sVar
             +PROPERTIES_DELIMITER;
   }
   return sAttr;
}

int Persist_SavePlaceable(object oPlc,object oArea) {

 string sDynAppearance = "";
 string sSlots = "";
 // Save attributes specific for creatures
 if(GetObjectType(oPlc) == OBJECT_TYPE_CREATURE) {
   sDynAppearance = ku_GetCreatureAppearance(oPlc);
   sSlots = Persist_SaveItemsInCreatureSlots(oPlc);
   SetLocalString(oPlc,"KU_PERSIST_INVENTORYSLOTS",sSlots);
 }
 /* Placeable attributes */
 string sAttr = __colectPlcAttributes(oPlc);

 string sValues = "'"+GetResRef(oArea)+"',"+
                  "'"+GetTag(oArea)+"',"+
                  "'"+GetResRef(oPlc)+"',"+
                  "'"+GetTag(oPlc)+"',"+
                  "'"+NWNX_LocationToString(GetLocation(oPlc))+"',"+
                  "'"+IntToString(GetAppearanceType(oPlc))+"',"+
                  "'"+sAttr+"',"+
                  "'1',"+
                  "'"+IntToString(GetObjectType(oPlc))+"',"+
                  "'"+sDynAppearance+"',"+
                  "'"+sSlots+"',"+
                  "'"+SQLEncodeSpecialChars(GetName(oPlc))+"',"+
                  "'"+SQLEncodeSpecialChars(GetDescription(oPlc))+"'";

 string sSQL = "INSERT INTO loc_persist_plc (loc_resref, loc_tag ,plc_resref ,plc_tag ,plc_loc, plc_appear, plc_attr, plc_status, object_type, cr_appearance, cr_invslots, plc_name, description) VALUES ("+sValues+");";
// SpeakString(sSQL);
 SQLExecDirect(sSQL);
 SQLExecDirect("SELECT LAST_INSERT_ID();");
 if (SQLFetch() == SQL_SUCCESS) {
   string sRET = SQLGetData(1);
//   SpeakString(sRET);
   SetLocalInt(oPlc,"ku_plc_origin",2); /* Created from persistance */
   SetLocalInt(oPlc,"KU_PERSIST_PLC_DB_ID",StringToInt(sRET));
   return StringToInt(sRET);
 }
 else {
   SpeakString("Chyba pri ukladani placeablu "+GetName(oPlc)+"do databaze. Kontaktujte WB");
   return -1;
 }

}

void __placeableExpired(object oPlc) {
  if(!GetIsObjectValid(oPlc))
    return;

  SpeakString("*"+GetName(oPlc)+" se rozpadl*");
  Persist_DeleteObjectFromDB(oPlc);
  DestroyObject(oPlc);

}

void __recreateAttribute(object oItem, string sIP) {
    int iStart = 0;
    int iEnd;
    string name,var;
    int type;
    int iDLen = GetStringLength(PERSISTANCE_SECONDARY_DELIMITER);

//    SendMessageToPC(GetFirstPC(),sIP);

    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    name = GetSubString(sIP,iStart,iEnd - iStart);

    iStart = iEnd + iDLen;
    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    type = StringToInt(GetSubString(sIP,iStart,iEnd - iStart));

    iStart = iEnd + iDLen;
//    iEnd = FindSubString(sIP,PERSISTANCE_SECONDARY_DELIMITER,iStart);
    var = GetSubString(sIP,iStart,GetStringLength(sIP) - iStart);

    switch(type) {
      case VARIABLE_TYPE_INT:
        SetLocalInt(oItem,name,StringToInt(var));
        break;
      case VARIABLE_TYPE_FLOAT:
        SetLocalFloat(oItem,name,StringToFloat(var));
        break;
      case VARIABLE_TYPE_STRING:
        SetLocalString(oItem,name,var);
        break;
      case VARIABLE_TYPE_OBJECT:
//        SetLocalObject(oItem,name,var);
        break;
      case VARIABLE_TYPE_LOCATION:
        SetLocalLocation(oItem,name,StringToLocation(var));
        break;
      case 99:
        if(name == "USEABLE_FLAG")
          SetUseableFlag(oItem, StringToInt(var));
        if(name == "PLOT_FLAG")
          SetPlotFlag(oItem, StringToInt(var));
        if(name == "FACTION")
          SetNPCFaction(oItem, var);
        break;
    }

  if(name == "PLC_EXPIRATION") {
    float fDuration = IntToFloat(StringToInt(var) - ku_GetTimeStamp());
    if(fDuration < 1.0)
      fDuration = 1.0;

    if(fDuration < 43200.0) //less than restart
      DelayCommand(fDuration, __placeableExpired(oItem));
    return;
  }

  return;
}

void __recreateAttributesOnPLC(object oPlc, string sIP) {
   int iNum = 0;
   int iStart = 0;
   int DLen = GetStringLength(PROPERTIES_DELIMITER);
   int iEnd = FindSubString(sIP,PROPERTIES_DELIMITER,iStart);
   while(iEnd > -1) {
     __recreateAttribute(oPlc,GetSubString(sIP,iStart,iEnd - iStart));

     iStart = iEnd + DLen;
     iEnd = FindSubString(sIP,PROPERTIES_DELIMITER,iStart);
   }

   return;
}

void Persist_LoadAddedPlaceables(object oArea, int object_type = -1, int from = -1) {
  string sSQL;

  if(object_type < 0)
    sSQL = "SELECT plc_resref ,plc_tag ,plc_loc, plc_appear, plc_attr, plc_status, object_type, id, cr_appearance, cr_invslots, plc_name, description FROM loc_persist_plc WHERE loc_resref='"+GetResRef(oArea)+"' AND loc_tag='"+GetTag(oArea)+"' AND id >= '"+IntToString(from)+"' ;";
  else
    sSQL = "SELECT plc_resref ,plc_tag ,plc_loc, plc_appear, plc_attr, plc_status, object_type, id, cr_appearance, cr_invslots, plc_name, description FROM loc_persist_plc WHERE loc_resref='"+GetResRef(oArea)+"' AND loc_tag='"+GetTag(oArea)+"' AND id >= '"+IntToString(from)+"' AND object_type='"+IntToString(object_type)+"';";

  string   sResRef;
  string   sTag;
  location lLoc;
  string   sAppear;
  string   sAttr;
  int      iStatus;
  int      iObject_type;
  object   oPlc,oNPC;
  int i;
  string id,sAppearance,sSlots,sName,sDesc;
  float fDelay = 0.0;

  SQLExecDirect(sSQL);
//  AssignCommand(GetFirstPC(),SpeakString(sSQL));
  while (SQLFetch() == SQL_SUCCESS && i <= PERSIST_MAX_LOAD_PLC) {
    i++;
    sResRef = SQLGetData(1);
    sTag    = SQLGetData(2);
    lLoc    = StringToLocation(SQLGetData(3));
    sAppear = SQLGetData(4);
    sAttr   = SQLGetData(5);
    iStatus = StringToInt(SQLGetData(6));
    iObject_type = StringToInt(SQLGetData(7));
    id      = SQLGetData(8);
    sAppearance = SQLGetData(9);
    sSlots  = SQLGetData(10);
    sName   = SQLDecodeSpecialChars(SQLGetData(11));
    sDesc   = SQLDecodeSpecialChars(SQLGetData(12));

    if(iObject_type == 0) {
      iObject_type = OBJECT_TYPE_PLACEABLE;
    }
    switch(iStatus) {
      case 1:
        oPlc = CreateObject(iObject_type,sResRef,lLoc,FALSE,sTag);
        if(iObject_type == OBJECT_TYPE_CREATURE) {
          SetCreatureAppearanceType(oPlc,StringToInt(sAppear));
          if(GetStringLength(sAppearance) > 0) {
            ku_RestoreCreatureAppearance(oPlc,sAppearance);
            oNPC = oPlc;
            JumpToLimbo(oNPC);
            oPlc = CopyObject(oNPC,lLoc,OBJECT_INVALID,sTag);
            DestroyObject(oNPC);
          }
          if(GetStringLength(sSlots) > 0) {
            fDelay = fDelay + 0.22;
            DelayCommand(fDelay,Persist_RecreateItemsInCreatureSlots(oPlc,sSlots));
            SetLocalString(oPlc,"KU_PERSIST_INVENTORYSLOTS",sSlots);
          }
        }
        else if(iObject_type == OBJECT_TYPE_PLACEABLE) {
          SetPlaceableAppearance(oPlc,StringToInt(sAppear));
        }
        SetLocalInt(oPlc,"ku_plc_origin",2); /* Created from persistance */
        if(GetStringLength(sName) > 0) {
          SetName(oPlc,sName);
        }
        if(GetStringLength(sDesc) > 0) {
          SetDescription(oPlc,sDesc);
        }
        SetLocalInt(oPlc,"KU_PERSIST_PLC_DB_ID",StringToInt(id));
        break;
    }

    __recreateAttributesOnPLC(oPlc, sAttr);

  }

  if(i > PERSIST_MAX_LOAD_PLC) {
    DelayCommand(5.1,Persist_LoadAddedPlaceables(oArea,object_type,StringToInt(id)+1));
  }

//  return i;
}

int Persist_DeleteObjectFromDB(object oPlc) {
  int iPersID = GetLocalInt(oPlc,"KU_PERSIST_PLC_DB_ID");
  if(iPersID <= 0) {
    return -1;
  }

  string sSQL = "DELETE FROM loc_persist_plc WHERE  id="+IntToString(iPersID)+";";
  SQLExecDirect(sSQL);

  return 0;
}

int Persist_DeletePlaceablesInArea(object oArea) {

  string sSQL = "DELETE FROM loc_persist_plc WHERE loc_resref='"+GetResRef(oArea)+"' AND loc_tag='"+GetTag(oArea)+"' AND object_type = '64';";
  SQLExecDirect(sSQL);

  object oPlc = GetFirstObjectInArea(oArea);
  int iOrigin = 0;
  while(GetIsObjectValid(oPlc)) {
    if(GetObjectType(oPlc) == OBJECT_TYPE_CREATURE) {
      if(GetLocalInt(oPlc,"ku_plc_origin") == 2 ) {
        DeleteLocalInt(oPlc,"ku_plc_origin");
      }
    }
    oPlc = GetNextObjectInArea(oArea);
  }

  return 1;
}


void Persist_DestroyObjectsInArea(object oArea,int iOrig, int iType){
          object oPlc = GetFirstObjectInArea(oArea);
          int iOrigin = 0;
          while(GetIsObjectValid(oPlc)) {
            if(GetObjectType(oPlc) == iType) {
              iOrigin = GetLocalInt(oPlc,"ku_plc_origin");
              if(iOrigin == iOrig ) {
                DestroyObject(oPlc,0.5);
              }

            }
            oPlc = GetNextObjectInArea(oArea);
          }
}

int  Persist_SetSpawnInAreaDisabled(object oArea,int state) {

  string sResRef = GetResRef(oArea);
  string sTag = GetTag(oArea);
  string sSQL = "UPDATE location_property SET spawn_disable = '"+IntToString(state)+"' WHERE resref = '"+sResRef+"' AND tag = '"+sTag+"'; ";
  SQLExecDirect(sSQL);
  SetLocalInt(oArea,"KU_LOC_DISABLE_SPAWN",state);
  if(state) {
    FloatingTextStringOnCreature("Spawn disabled",OBJECT_SELF,FALSE);
  }
  else {
    FloatingTextStringOnCreature("Spawn enabled",OBJECT_SELF,FALSE);
  }
  return 1;
}

/***********************************************
 ***********************************************
 **          Persistent creatures             **
 ***********************************************
 ***********************************************/

 int Persist_DeleteNPCSInArea(object oArea, object oNPC = OBJECT_INVALID) {

  int iID = 0;
  if(GetIsObjectValid(oNPC)) {
    iID = GetLocalInt(oNPC,"KU_PERSIST_PLC_DB_ID");
  }
  string sSQL;
  if(iID > 0) {
    sSQL = "SELECT cr_invslots FROM loc_persist_plc WHERE id = '"+IntToString(iID)+"';";
  }
  else {
    sSQL = "SELECT cr_invslots FROM loc_persist_plc WHERE loc_resref='"+GetResRef(oArea)+"' AND loc_tag='"+GetTag(oArea)+"' AND object_type = '1';";
  }
  SQLExecDirect(sSQL);
  while (SQLFetch() == SQL_SUCCESS) {
    Persist_RemoveFromDBItemsInCreatureSlots(SQLGetData(1));
  }


  if(iID > 0) {
    sSQL = "DELETE FROM loc_persist_plc WHERE id = '"+IntToString(iID)+"';";
  }
  else {
    sSQL = "DELETE FROM loc_persist_plc WHERE loc_resref='"+GetResRef(oArea)+"' AND loc_tag='"+GetTag(oArea)+"' AND object_type = '1';";
  }
  SQLExecDirect(sSQL);


  if(iID > 0) {
    DeleteLocalInt(oNPC,"ku_plc_origin");
  }
  else {
    object oPlc = GetFirstObjectInArea(oArea);
    int iOrigin = 0;
    while(GetIsObjectValid(oPlc)) {
      if(GetObjectType(oPlc) == OBJECT_TYPE_CREATURE) {
        if(GetLocalInt(oPlc,"ku_plc_origin") == 2 ) {
          DeleteLocalInt(oPlc,"ku_plc_origin");
        }
      }
      oPlc = GetNextObjectInArea(oArea);
    }
  }

  return 1;
}

string Persist_SaveItemsInCreatureSlots(object oNPC, string sContID = "0") {

  string sItemIDs = "";
  int i,id;
  object oItem;


  if(GetObjectType(oNPC) != OBJECT_TYPE_CREATURE) {
    return sItemIDs;
  }

  for(i=0;i<=17;i++) {
    oItem = GetItemInSlot(i,oNPC);
    if(GetIsObjectValid(oItem)) {
//      SendMessageToPC(GetFirstPC(),"Saving item "+GetName(oItem)+" in slot:"+IntToString(i));
      id = Persist_SaveItemToDB(oItem,"0");
    }
    else {
      id = 0;
    }
    sItemIDs = sItemIDs+IntToString(id)+KU_BODYPART_DELIMITER;
  }

  return sItemIDs;
//  PROPERTIES_DELIMITER

}


void Persist_RecreateItemsInCreatureSlots(object oNPC, string sItemIDs) {
  int iID,i;
  string sID;
  object oItem;
  int iFrom;
  int iTo = -1;

  for(i=0;i<=17;i++) {
    iFrom = iTo + 1;
    iTo = FindSubString(sItemIDs,KU_BODYPART_DELIMITER,iFrom);
    sID = GetSubString(sItemIDs,iFrom,iTo - iFrom);
//    SendMessageToPC(GetFirstPC(),"Retrieving item with id '"+sID+"'");
    if(sID != "0") {
      oItem = Persist_CreateItemFromDBByID(StringToInt(sID),oNPC);
      SetDroppableFlag(oItem,0);
      AssignCommand(oNPC,ActionEquipItem(oItem,i));
//      SendMessageToPC(GetFirstPC(),"Recreated item "+GetName(oItem)+" in slot:"+IntToString(i));
    }
  }

}

void Persist_RemoveFromDBItemsInCreatureSlots(string sItemIDs) {

  if(GetStringLength(sItemIDs) <= 0) {
    return;
  }
  int iID,i;
  string sID;
  object oItem;
  int iFrom;
  int iTo = -1;

  for(i=0;i<=17;i++) {
    iFrom = iTo + 1;
    iTo = FindSubString(sItemIDs,KU_BODYPART_DELIMITER,iFrom);
    sID = GetSubString(sItemIDs,iFrom,iTo - iFrom);
//    SendMessageToPC(GetFirstPC(),"Removing item with id '"+sID+"' from DB");
    if(sID != "0") {
      Persist_DeleteItemByIDFromDB(StringToInt(sID));
    }
  }
}
