//var "KU_HIRE_LESSORID"                 - identifikace najemce
//var "KU_HIRE_ROOMS_PRICE"              - cena vsech pokoju
//var "KU_HIRE_ROOM<cislo pokoje>_PRICE" - cena konkretniho pokoje. Ma vyssi prioritu, nez cena vsech pokoju.
//var "KU_HIRE_ROOMS_LENGTH"             - Delka pronajmu pokoju
//var "KU_HIRE_ROOM<cislo pokoje>_PRICE" - Delka pronajmu vsech pokoju
//var "KU_HIRE_ROOM<cislo domu>_KEYNAME" - Nazev napsany na klici
//var "KU_HIRE_BASE_KEYNAME"             - Zaklad nazvu klice, ke kteremu se prida cislo pokoje/domu/bytu

//tag klice: "ku_hire_<cislo najemce>_<cislo pokoje/domu/bytu>"



#include "ku_libtime"
#include "aps_include"

const int HIRE_TIME = 30;
const int HIRE_PRICE = 20;
const string HIRE_KEY_TAG = "ku_hire_key";


// Hire initialization for each lessor
int ku_HireInitLessor(object oLessor);

//Clean expired Hires from database
void ku_HireCleanExpiredHires();

// For conditionals - Check if room is empty for this PC
// PC is there for future functionality, if we want to extend hire time
int ku_HireIsEmptyRoom(int iRoomID, object oPC);

// Hire this room.
int ku_HireHireRoom(int iRoomID, object oPC);

// Get Price of this room
int ku_HireGetPrice(int iRoomID);

// Get Standart Hire time for this room
int ku_HireGetHireLength(int iRoomID);

// Generate key for this room
object ku_HireGenereteKey(int iRoomID, object oPC);

// Check if key is expired and have to be deleted
int ku_HireGetIsKeyExpired(object oKey);

int ku_HireInitLessor(object oLessor) {
  ku_HireCleanExpiredHires();

  if(GetLocalInt(oLessor,"KU_HIRE_INITIALIZED")) {
    return TRUE;
  }

  int iLessorId = GetLocalInt(oLessor,"KU_HIRE_LESSORID");
  if(!iLessorId) {
    SpeakString("Chyba! Spatne nastaveny pronajem pokoju!");
    return FALSE;
  }

  string sLessorId = IntToString(iLessorId);
  int iTime = ku_GetTimeStamp();
  string sTime = IntToString(iTime);

  //Read rooms status from DB
  string sSQL = "SELECT room_id, hire_from, hire_expire FROM room_hire WHERE lessor_id='"+sLessorId+"' AND hire_expire > "+sTime+" ;";
//  SpeakString(sSQL);
  string sRoomID;
  int iDateFrom, iDateExpire;
  SQLExecDirect(sSQL);
  while(SQLFetch() == SQL_SUCCESS) {
    sRoomID = SQLGetData(1);
    iDateFrom = StringToInt(SQLGetData(2));
    iDateExpire = StringToInt(SQLGetData(3));
    SetLocalInt(oLessor,"KU_HIRE_ROOM"+sRoomID+"_EXPIRE",iDateExpire);
    SetLocalInt(oLessor,"KU_HIRE_ROOM"+sRoomID+"_HIRED_FROM",iDateFrom);
  }

  SetLocalInt(oLessor,"KU_HIRE_INITIALIZED",TRUE);
  return TRUE;
}

void ku_HireCleanExpiredHires() {

  string sTime = IntToString(ku_GetTimeStamp());
  string sSQL = "DELETE FROM room_hire WHERE hire_expire < "+sTime+" ;";
  SQLExecDirect(sSQL);
}


int ku_HireIsEmptyRoom(int iRoomID, object oPC) {
  object oLessor = OBJECT_SELF;
  if(!ku_HireInitLessor(oLessor))
    return FALSE;

  if(GetLocalInt(oLessor,"KU_HIRE_ROOM"+IntToString(iRoomID)+"_ALWAYSEMPTY") > 0)
    return TRUE;

  int iExpire = GetLocalInt(oLessor,"KU_HIRE_ROOM"+IntToString(iRoomID)+"_EXPIRE");
  if(iExpire) {
    if(iExpire > ku_GetTimeStamp()) {
      return FALSE;
    }
  }

  return TRUE;
}

int ku_HireHireRoom(int iRoomID, object oPC) {
  object oLessor = OBJECT_SELF;
  string sRoomID = IntToString(iRoomID);
  if(!ku_HireIsEmptyRoom(iRoomID,oPC)) {
    SpeakString("Toto ma jiz pronajato nekdo jiny.");
    return FALSE;
  }

  int iPrice = ku_HireGetPrice(iRoomID);
  if(GetGold(oPC) < iPrice) {
    SpeakString("Nemas dost zlata na pronajem pokoje.");
    return FALSE;
  }


  /* Take gold */
  TakeGoldFromCreature(iPrice,oPC,TRUE);

  /* Create key */
  object oKey = ku_HireGenereteKey(iRoomID,oPC);
  int iTime = ku_GetTimeStamp();
  int iExpires = iTime + ku_HireGetHireLength(iRoomID);

  /* Set Key expiration */
  SetLocalInt(oKey,"KU_HIRE_EXPIRATION",iExpires);
  DelayCommand(IntToFloat(ku_HireGetHireLength(iRoomID)),DestroyObject(oKey));

  /* Save info into DB */
  string sLessorId = IntToString(GetLocalInt(oLessor,"KU_HIRE_LESSORID"));
  string sValues = "'"+SQLEncodeSpecialChars(GetPCPlayerName(oPC))+"',"+
                   "'"+SQLEncodeSpecialChars(GetName(oPC))+"',"+
                   "'"+sLessorId+"',"+
                   "'"+sRoomID+"',"+
                   "'"+IntToString(iTime)+"',"+
                   "'"+IntToString(iExpires)+"',"+
                   "'"+GetTag(oKey)+"'";

  string sSQL = "INSERT INTO room_hire (player, name, lessor_id, room_id, hire_from, hire_expire, key_tag) VALUES ("+sValues+");";
//  SpeakString(sSQL);
  SQLExecDirect(sSQL);
  SetLocalInt(oLessor,"KU_HIRE_ROOM"+sRoomID+"_EXPIRE",iExpires);
  SetLocalInt(oLessor,"KU_HIRE_ROOM"+sRoomID+"_HIRED_FROM",iTime);

  return TRUE;
}

int ku_HireGetPrice(int iRoomID) {
  object oLessor = OBJECT_SELF;
  string sRoomID = IntToString(iRoomID);
  int iPrice = GetLocalInt(oLessor,"KU_HIRE_ROOM"+sRoomID+"_PRICE");
  if(!iPrice) {
    iPrice = GetLocalInt(oLessor,"KU_HIRE_ROOMS_PRICE");
  }
  if(!iPrice) {
    iPrice = HIRE_PRICE;
  }
  return iPrice;

}

int ku_HireGetHireLength(int iRoomID) {
  object oLessor = OBJECT_SELF;
  string sRoomID = IntToString(iRoomID);
  int iLength = GetLocalInt(oLessor,"KU_HIRE_ROOM"+sRoomID+"_LENGTH");
  if(!iLength) {
    iLength = GetLocalInt(oLessor,"KU_HIRE_ROOMS_LENGTH");
  }
  if(!iLength) {
    iLength = HIRE_TIME;
  }
  return iLength;

}


object ku_HireGenereteKey(int iRoomID, object oPC) {
  object oLessor = OBJECT_SELF;
  string sRoomID = IntToString(iRoomID);
  object oOrigKey = OBJECT_INVALID;

  /* If lessor have his own key */
  oOrigKey = GetLocalObject(oLessor,"KU_HIRE_KEY");
  if(!GetIsObjectValid(oOrigKey)) {
    oOrigKey = GetItemPossessedBy(oLessor,HIRE_KEY_TAG);
    if(GetIsObjectValid(oOrigKey)) {
      SetLocalObject(oLessor,"KU_HIRE_KEY",oOrigKey);
    }
  }

  string sLessorId = IntToString(GetLocalInt(oLessor,"KU_HIRE_LESSORID"));
  string sTag = "ku_hire_"+sLessorId+"_"+sRoomID;
  object oKey = OBJECT_INVALID;
  /* Copy key from inventory */
  if(GetIsObjectValid(oOrigKey)) {
    oKey = CopyObject(oOrigKey,GetLocation(oPC),oPC,sTag);
  }
  /* Generate key from palete */
  else {
    oKey = CreateItemOnObject(HIRE_KEY_TAG,oPC,1,sTag);
  }

  /* Get key name */
  string sName = GetLocalString(oLessor,"KU_HIRE_ROOM"+sRoomID+"_KEYNAME");
  if(GetStringLength(sName) > 0) {
    SetName(oKey,sName);
    return oKey;
  }

  sName = GetLocalString(oLessor,"KU_HIRE_BASE_KEYNAME");
  if(GetStringLength(sName) == 0) {
    sName = GetName(oKey);
  }
  sName = sName+sRoomID;
  SetName(oKey,sName);
  SetLocalObject(oLessor,"KU_HIRED_KEY_"+IntToString(iRoomID),oKey);
  return oKey;

}

int ku_HireGetIsKeyExpired(object oKey) {
  if(GetBaseItemType(oKey) != BASE_ITEM_KEY) {
    return FALSE;
  }

  if(GetStringLeft(GetTag(oKey),8) != "ku_hire_")
    return FALSE;

  if(ku_GetTimeStamp() > GetLocalInt(oKey,"KU_HIRE_EXPIRATION")) {
    return TRUE;
  }
  return FALSE;
}
