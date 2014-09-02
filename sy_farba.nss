#include "nwnx_events"

void main()
{

  string text = GetSelectedNodeText();
  string resref = "";

//Pentagramy
     if( text == "Cerny Pentagram" ) resref = "sy_kresba01";
else if( text == "Cerveny Pentagram" ) resref = "sy_kresba02";
//Kruhy
else if( text == "Jednota" ) resref = "sy_kresba03";
else if( text == "Sila" ) resref = "sy_kresba04";
else if( text == "Zivot" ) resref = "sy_kresba05";
else if( text == "Smrt" ) resref = "sy_kresba06";
else if( text == "Znovuzrodenie" ) resref = "sy_kresba07";
else if( text == "Vojna" ) resref = "sy_kresba08";
else if( text == "Mier" ) resref = "sy_kresba09";
else if( text == "Zlo" ) resref = "sy_kresba10";
else if( text == "Dobro" ) resref = "sy_kresba11";
//Stopy";
else if( text == "ludske stopy" ) resref = "sy_kresba12";
else if( text == "ludske stopy male" ) resref = "sy_kresba13";
else if( text == "krvave stopy" ) resref = "sy_kresba14";
else if( text == "stopy od topanok" ) resref = "sy_kresba15";
//Krv";
else if( text == "stopa" ) resref = "sy_kresba16";
else if( text == "kaluz cerstva" ) resref = "sy_kresba17";
else if( text == "kaluz zaschnuta" ) resref = "sy_kresba18";
else if( text == "stopa po tahani obete" ) resref = "sy_kresba19";
else if( text == "skvrny" ) resref = "sy_kresba20";


    //cierny pentagram
    object oPlc = CreateObject(OBJECT_TYPE_PLACEABLE,resref,GetLocation(GetPCSpeaker()),FALSE,"");
    SetUseableFlag(oPlc, FALSE);
//    SendMessageToPC(GetPCSpeaker(),"Creating "+resref+" said '"+text+"'");
    return;
    object oItem = GetItemActivated();
    if( GetItemStackSize(oItem) == 1)
      DestroyObject(GetItemActivated(),0.0f);
    else
       SetItemStackSize(oItem, GetItemStackSize(oItem) - 1);
}
