void main() {
 object oPC = GetLastOpenedBy();
 if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER) {
   oPC = GetEnteringObject();
 }
 object oDoors = OBJECT_SELF;

 /* zjistim dialog */
 string sConv = GetLocalString(oDoors,"ONOPEN_DIALOG");
 if(GetStringLength(sConv) == 0) {
 sConv = "ph_dvere_dialog";
 }

 /* Nastavim tokeny */
 string sTok = GetLocalString(oDoors,"DOORWAY_1_NAME");
 if(GetStringLength(sTok) == 0) {
 sTok = "";
 }
 SetCustomToken(8001,sTok);
 sTok = GetLocalString(oDoors,"DOORWAY_2_NAME");
 if(GetStringLength(sTok) == 0) {
 sTok = "";
 }
 SetCustomToken(8002,sTok);

 /* Spustim dialog*/
 ActionStartConversation(oPC, "ph_dvere_dialog");

 /* a spustim standartni zavirak */
 ExecuteScript("ja_door_onopen", OBJECT_SELF);

}
