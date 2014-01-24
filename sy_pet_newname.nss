void main()
{
    if (GetListenPatternNumber() == 1001)
    {
        object oPC = GetLocalObject(OBJECT_SELF, "sy_listener");
        if (GetLastSpeaker() == oPC)
        {
            string sHeard;// = GetLocalString(OBJECT_SELF, "notes_heard");
            int nCount = GetMatchedSubstringsCount();
            int k = 0;
            while (k < nCount)
            {
                sHeard = sHeard + GetMatchedSubstring(k);
                k++;
            }
            //sHeard = sHeard + " ";
            //SetLocalString(OBJECT_SELF, "notes_heard",sHeard);
            DeleteLocalObject(OBJECT_SELF,"sy_listener");
            SetListening(OBJECT_SELF, FALSE);
            SendMessageToPC(oPC,sHeard);
            object oItem = GetItemPossessedBy(oPC,"sy_itm_pet");
            if (oItem!=OBJECT_INVALID) {
                SetLocalString(oItem,"sy_zviera_meno",sHeard);
                SetName(OBJECT_SELF,sHeard);
            }
        }
    }
}
