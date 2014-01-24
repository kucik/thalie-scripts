/* #######################################################
 * # Kucik Time library
 * # release: 25.12.2007
 * #######################################################
 */

 int MinsPerHour = 10 ; //Pocet minut za hodinu
 int KU_NULLYEAR = 1495; //Nastavit rok whipu

// Return actual hour in floating point number
// contains minutes and miliseconds, so time 7:30 returns as 7.5
float GetFTimeHour();

//
// Vytvoreni casoveho razitka
int ku_GetTimeStamp(int sec=0, int min=0, int hour=0, int day=0, int month=0, int year=0);

 /*
 * ku_RoundInMinute = pocitadlou roundu v minute
 *
 * K Volani v Module Heartbeat. Jen Jednou!!!
 */
void SetRoundInMinute()
{
 object oMod = GetModule();
 int iMinute = GetTimeMinute();
 if(GetLocalInt(oMod,"ku_PrevMinute") == iMinute)
   SetLocalInt(oMod,"ku_RoundInMinute",GetLocalInt(oMod,"ku_RoundInMinute") + 1);
 else {
  SetLocalInt(oMod,"ku_PrevMinute",iMinute);
  SetLocalInt(oMod,"ku_RoundInMinute",1);
 }


}

/*
 * ku_RoundInHour = pocitadlo roundu v akt. hodine
 *
 * K Volani v Module Heartbeat - Za SetRoundInMinute(); Jen jednou!!!
 */
void SetRoundInHour()
{
 object oMod = GetModule();
 int iRound = GetLocalInt(oMod,"ku_RoundInMinute");
 int iMinute = GetTimeMinute();
 if((iRound == 1 ) && (iMinute == 0))
   SetLocalInt(oMod,"ku_RoundInHour",1);
 else
   SetLocalInt(oMod,"ku_RoundInHour",GetLocalInt(oMod,"ku_RoundInHour") + 1);

}

int GetRoundInHour()
{
 return(GetLocalInt(GetModule(),"ku_RoundInHour"));
}

int GetRoundInMinute()
{
 return(GetLocalInt(GetModule(),"ku_RoundInMinute"));
}

/*
 * Vytvoreni casoveho razitka
 */
int ku_GetTimeStamp(int sec=0, int min=0, int hour=0, int day=0, int month=0, int year=0 )
{
 int ActSec = GetTimeSecond() + sec;
 int ActMin = GetTimeMinute() + min;
 int ActHour = GetTimeHour() + hour;
 int ActDay = GetCalendarDay() + day - 1;       //to by me zajimalo, kterej tupec vymyslel, ze budem pocitat dny od 1 a ne od 0
 int ActMonth = GetCalendarMonth() + month - 1; //... a mesice k tomu
 int ActYear = GetCalendarYear() + year - KU_NULLYEAR; //roky si odecitam sam
 int TimeStamp = 0;

 TimeStamp = ActYear * 12 + ActMonth;
 TimeStamp = TimeStamp * 28 + ActDay;
 TimeStamp = TimeStamp * 24 + ActHour;
 TimeStamp = TimeStamp * 10 + ActMin;  // !!! NEZAPOMINAT, ZE MISTNI HODINA MA JEN 10 MINUT !!!
 TimeStamp = TimeStamp * 60 + ActSec;

 return TimeStamp;
}

string ku_GetDateFromTimeStamp(int stamp = 0) {

  int dt = 0;
  if(stamp != 0)
    dt = ku_GetTimeStamp() - stamp;
  string sDate,sTime;

  stamp = stamp/10; // minuty
  sTime = IntToString(GetTimeMinute() + dt % 60);
  stamp = stamp/60; // hodiny
  sTime = IntToString(GetTimeHour() + dt % 24)+":"+sTime;

  stamp = stamp/24; // dny
  sDate = IntToString(GetCalendarDay() + dt % 28);
  stamp = stamp/28; // mesice
  sDate = sDate+". "+IntToString(GetCalendarMonth() + dt % 12);
  stamp = stamp/12; // roky
  sDate = sDate+". "+IntToString(GetCalendarYear() + dt);

  return sDate+" "+sTime;
}

string ku_GetStringTimeBetween(int stamp1, int stamp2, int precision = 0)
{
 int dt = stamp1 - stamp2,iTime;
 string sTime;
 if(dt == 0)
   return "Prave ted";

 if(dt < 0)
   dt = 0 - dt;

 if(precision == 0) {
   iTime = (dt % 10) * 6;
   if(iTime == 1)
     sTime = IntToString(iTime)+" vterina";
   else if(iTime <=4 )
     sTime = IntToString(iTime)+" vteriny";
   else
     sTime = IntToString(iTime)+" vterin";
 }

 dt = dt/10; // minuty
 if(dt == 0)
   return sTime;

 if(precision < 2) {
   iTime = (dt % 60);
   if(iTime == 1)
     sTime = IntToString(iTime)+" minuta "+sTime;
   else if(iTime <=4 )
     sTime = IntToString(iTime)+" minuty "+sTime;
   else
     sTime = IntToString(iTime)+" minut "+sTime;
 }
 dt = dt/60; // hodiny
 if(dt == 0)
   return sTime;

 if(precision < 3) {
   iTime = (dt % 24);
   if(iTime == 1)
     sTime = IntToString(iTime)+" hodina "+sTime;
   else if(iTime <=4 )
     sTime = IntToString(iTime)+" hodiny "+sTime;
   else
     sTime = IntToString(iTime)+" hodin "+sTime;
 }

 dt = dt/24; // dny
 if(dt == 0)
   return sTime;

 if(precision < 4) {
   iTime = (dt % 28);
   if(iTime == 1)
     sTime = IntToString(iTime)+" den "+sTime;
   else if(iTime <=4 )
     sTime = IntToString(iTime)+" dny "+sTime;
   else
     sTime = IntToString(iTime)+" dni "+sTime;
 }

 dt = dt/28; // mesice
 if(dt == 0)
   return sTime;

 if(precision < 5) {
   iTime = (dt % 12);
   if(iTime == 1)
     sTime = IntToString(iTime)+" mesic "+sTime;
   else if(iTime <=4 )
     sTime = IntToString(iTime)+" mesice "+sTime;
   else
     sTime = IntToString(iTime)+" mesicu "+sTime;
 }
 dt = dt/12; // roky
 if(dt == 0)
   return sTime;

 if(precision < 6) {
   iTime = dt;
   if(iTime == 1)
     sTime = IntToString(iTime)+" rok "+sTime;
   else if(iTime <=4 )
     sTime = IntToString(iTime)+" roky "+sTime;
   else
     sTime = IntToString(iTime)+" let "+sTime;
 }

 return sTime;

}

float GetFTimeHour() {
  float fHour = IntToFloat(GetTimeHour());
  fHour = fHour + IntToFloat(GetTimeMinute())/10;
  fHour = fHour + IntToFloat(GetTimeSecond())/600;
  return fHour;
}

