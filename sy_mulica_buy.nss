/*
  vytvori henchmana mulicu pre hraca ak ma potrebne peniaze
  u seba, mulica by nemala utocit a ak ano jej AB by malo
  byt minusove nech nerobi velky dmg, inac by to hraci
  mohli zneuzivat
*/

void main()
{
    //zistim ci uz ma mulicu(henchmana) je povoleny len 1
    object oPC       = GetPCSpeaker();
    object oHenchmen = GetLocalObject(oPC, "ja_mula");

    //toto plati pre zviera typu Mula
    if (GetIsObjectValid(oHenchmen)) {
        SpeakString("Muzes mit jenom jedno zvire.");
        return;
    }
    //toto plati pre domace zviera
    if (GetHenchman(oPC)!=OBJECT_INVALID) {
        SpeakString("Muzes mit jenom jedno zvire.");
        return;
    }

    //vezmem GP od hraca ak ma, inac nepredam mulicu
    int iGold = GetGold(oPC);
    if (iGold<100) {
        SpeakString("Nemate dost penez.");
        return;
    }

    TakeGoldFromCreature(100,oPC,TRUE);

    //zaplatil tak vytvorim mulicu
    location lPoz   = GetLocation(oPC);
    string   sAppr  = GetLocalString(OBJECT_SELF,"sy_predava");
    object   oMula  = CreateObject(OBJECT_TYPE_CREATURE,sAppr,lPoz, FALSE, sAppr);
    string   sMeno  = GetName(oPC,TRUE);
    SetName(oMula,GetName(oMula,TRUE) + " ("+sMeno+")");
    SetLocalString(oMula,"sy_majitel",sMeno);
    //AssignCommand(oMula,SetAssociateListenPatterns());//toto asi netreba hmm
    SetLocalObject(oPC, "ja_mula", oMula);
    AddHenchman(oPC,oMula);
}
