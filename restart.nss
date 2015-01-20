//restarting header

#include "aps_include"
#include "ja_lib"
int checktime(int iState) ;

void __dumpModuleVariables();

void finish(){
    object oPC;
    location lLoc;

/*    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        SavePlayer(oPC);
        oPC = GetNextPC();
    }*/
    //ExportAllCharacters();
    SpeakString("Server bude restartovan za 2 minuty!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("SERVER RESTARTED");

    StoreTime();
}

void warning1(){
    SpeakString("Server bude restartovan za 30 minut!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("PLAYERS WARNED 1");
}

void warning2(){
    SpeakString("Server bude restartovan za 10 minut!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("PLAYERS WARNED 2");
}

void warning3(){
    SpeakString("Server bude restartovan za 5 minut!!",TALKVOLUME_SHOUT);
    WriteTimestampedLogEntry("PLAYERS WARNED 3");
}

void kick_players() {

    object oPC;
    location lLoc;
    int i = 0;

    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        DelayCommand(4.0*i,SavePlayer(oPC));
        DelayCommand(4.0*i + 2.0,BootPC(oPC));
        oPC = GetNextPC();
        i++;
    }

}


int checktime(int iState) {
  string sql = "SELECT HOUR(CURTIME()) MOD 12, MINUTE(CURTIME());";
  SQLExecDirect(sql);
  if (SQLFetch() == SQL_SUCCESS){
    int iHour = StringToInt(SQLGetData(1));
    int iMinute = StringToInt(SQLGetData(2));

    /* Every 12 hours in 1 oclock */
    if(iHour == 1) {
      if(iMinute >= 30 && iState < 1) //30 min
        return 1;
      if(iMinute >= 50 && iState < 2) //10 min
        return 2;
      if(iMinute >= 55 && iState < 3) //5 min
        return 3;
      if(iMinute >= 58 && iState < 4) //2 min
        return 4;
    }
  }

  return 0;

}

void restart(int iState = 0) {

   int ret = checktime(iState);

   switch(ret) {
     case 1: // 30 min
       warning1();
       break;
     case 2: // 10 min
       warning2();
       break;
     case 3: // 5 min
       warning3();
       __dumpModuleVariables();
       break;
     case 4: // 2 min
       kick_players();
       DelayCommand(30.0f, finish());
       break;
   }

   /* Remember actual state */
   if(ret > 0)
     iState = ret;

   /* Loop */
   DelayCommand(30.0f,restart(iState));
}


void __dumpModuleVariables() {
  object oItem = GetModule();

  WriteTimestampedLogEntry("************ Dump Module variables ************"); 
  int cnt = GetLocalVariableCount(oItem);
  int i;
  struct LocalVariable lv;
  string str;
  
  WriteTimestampedLogEntry("************ Total "+IntToString(cnt)+" variables************");
  for(i=0;i<cnt;i++) {
    lv = GetLocalVariableByPosition(oItem,i);
    WriteTimestampedLogEntry("* "+lv.name+" ("+IntToString(lv.type)+")");
  }

  WriteTimestampedLogEntry("************ Dump Module variables end *********"); 

}
