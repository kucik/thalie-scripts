/*
    triger sa aktivuje ak nanho hrac slapne a vypise sa sprava
*/

void main()
{
    int     iID = GetLocalInt(OBJECT_SELF,"sy_id");
    string  sTX = GetLocalString(OBJECT_SELF,"sy_str");
    object  oPC = GetEnteringObject();

    switch (iID)
    {
     case 1: //privatna sprava konkretnemu hracovi co ako prvy slapne na triger
     {
        SendMessageToPC(oPC,sTX);
        break;
     }
     case 2: //verejna sprava ktoru povie NPC ked slapnem na triger
     {
        string sNPC = GetLocalString(OBJECT_SELF,"sy_npc");
        object oNPC = GetNearestObjectByTag(sNPC,oPC,1);
        if (oNPC!=OBJECT_INVALID) AssignCommand(oNPC,SpeakString(sTX,TALKVOLUME_TALK));
        break;
     }
    }
}
