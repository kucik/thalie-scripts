//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

#include "no_koze_q_inc"

string no_pomocna;

void main()
{
string no_nazev;
int no_pocet;

//  no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");   //nahrani promene do skriptu
  no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
  no_pomocna = IntToString(no_pocet);
  no_nazev = GetLocalString(OBJECT_SELF, "no_poptavka_name");
  string sPocet = IntToString(no_pocet);
  

/*
if (no_nazev == "no_boruvka") { no_nazev = "boruvek";   }    //musi se vepsta nazvy veci podle resref
if (no_nazev == "no_malina") { no_nazev = "malin";   }
*/

  if (no_pocet <= 0 ) 
    SpeakString(" Momentalne nic neshanim. ");   // kdyz nic nechce

  else {
    SpeakString(" Zrovna potrebuji dodavku materialu. Chybi mi tu "+no_nazev+". Kdyz mi tedy prineses "+sPocet+" kusu, tak ti za ne zaplatim o pulku vice, nez kterykoliv jiny obchodnik. " );
    SendMessageToPC(GetPCSpeaker(), "Debug: Poptavana kuze:"+GetLocalString(OBJECT_SELF,"no_nazevveci"));
  }
}
