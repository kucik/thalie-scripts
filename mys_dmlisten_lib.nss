#include "npcact_h_colors"

// Send chat messaget to all listener objects of oSpeaker.
void SendChatToListeners(object oSpeaker, string sSpoken, int iVolume);

// Send chat message to specific listener object of oSpeaker.
void SendChatToListener(object oListener, object oSpeaker, string sSpoken, int iVolume);

// Assign oListener as listener object to oSpeaker.
void AddListener(object oSpeaker, object oListener);

// Remove oListener as listener object of oSpeaker.
// Returns index of removed listener object.
int RemoveListener(object oSpeaker, object oListener);

// Return TRUE if oSpeaker has set oListener as listener object.
int GetHasListener(object oSpeaker, object oListener);

// Return listener object of specific index; if not valid: reassign.
object GetListener(object oSpeaker, int iCounter);


int __GetListenersCount(object oSpeaker);

string __GetListenerId(string sSpeakerName, int iIndex);
void __SetListenerId(string sSpeakerName, int iIndex, string sValue);
void __RemoveListenerId(string sSpeakerName, int iIndex);

object __GetListenerObject(string sSpeakerName, int iIndex);
void __SetListenerObject(string sSpeakerName, int iIndex, object oListener);
void __RemoveListenerObject(string sSpeakerName, int iIndex);

void SendChatToListeners(object oSpeaker, string sSpoken, int iVolume)
{
    int iCounter;
    object oListener;
    string sName = GetName(oSpeaker);
    string sListenerId = __GetListenerId(sName, iCounter);    
    
    while (sListenerId != "")
    {
        oListener = GetListener(oSpeaker, iCounter);
        if (GetIsObjectValid(oListener))
            SendChatToListener(oListener, oSpeaker, sSpoken, iVolume);
        
        iCounter ++;
        sListenerId = __GetListenerId(sName, iCounter);
    }
}

void SendChatToListener(object oListener, object oSpeaker, string sSpoken, int iVolume)
{
    if (GetIsDM(oListener) || GetIsDMPossessed(oListener))
    {
        string sMessage = iVolume == TALKVOLUME_WHISPER
            ? ColorRGBString(GetName(oSpeaker)+":",2,2,6) + " " + ColorRGBString(sSpoken,2,2,2)
            : ColorRGBString(GetName(oSpeaker)+":",2,2,6) + " " + ColorRGBString(sSpoken,6,6,6);
        SendMessageToPC(oListener, sMessage);
    }
}

int GetHasListener(object oSpeaker, object oListener)
{
    int iCounter;
    string sName = GetName(oSpeaker);
    string sListenerName = GetName(oListener);
    string sListenerId = __GetListenerId(sName, iCounter);
    object oListenerObject = __GetListenerObject(sName, iCounter);
    
    while (sListenerId != "")
    {
        if (oListenerObject == oListener || sListenerId == sListenerName)
        {
            return TRUE;
        }
        iCounter ++;
        sListenerId = __GetListenerId(sName, iCounter);
        oListenerObject = __GetListenerObject(sName, iCounter);
    }
    return FALSE;
}

void AddListener(object oSpeaker, object oListener)
{
    int iCounter = __GetListenersCount(oSpeaker);
    
    __SetListenerId(GetName(oSpeaker), iCounter, GetName(oListener));
    __SetListenerObject(GetName(oSpeaker), iCounter, oListener);
}

int RemoveListener(object oSpeaker, object oListener)
{
    int iCounter, bRemoved;
    string sName = GetName(oSpeaker);
    string sListenerName = GetName(oListener);
    string sListenerId = __GetListenerId(sName, iCounter);
    object oListenerObject = __GetListenerObject(sName, iCounter);
    
    while (sListenerId != "")
    {
        if (!bRemoved && (oListenerObject == oListener || sListenerId == sListenerName))
        {
            bRemoved = TRUE;
        }
        
        if (bRemoved)
        {
            if (__GetListenerId(sName, iCounter + 1) != "")
            {
                __SetListenerId(sName, iCounter, __GetListenerId(sName, iCounter + 1));
                __SetListenerObject(sName, iCounter, __GetListenerObject(sName, iCounter + 1));
            }
            else
            {
                __RemoveListenerId(sName, iCounter);
                __RemoveListenerObject(sName, iCounter);
            }
        }
        iCounter ++;
        sListenerId = __GetListenerId(sName, iCounter);
        oListenerObject = __GetListenerObject(sName, iCounter);
    }
    return bRemoved;
}

object GetListener(object oSpeaker, int iCounter)
{
    object oListener = __GetListenerObject(GetName(oSpeaker), iCounter);
    
    if (GetIsObjectValid(oListener))
    {
         return oListener;
    }
    else
    {
        string sName = GetName(oSpeaker);
        string sListenerId = __GetListenerId(sName, iCounter);
        object oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
            if (GetName(oPC) == sListenerId)
            {
                __SetListenerObject(sName, iCounter, oPC);
                return oPC;
            }
            oPC = GetNextPC();
        }
    }
    return OBJECT_INVALID;
}

int __GetListenersCount(object oSpeaker)
{
    int iCounter;
    string sName = GetName(oSpeaker);
    string sListenerId = __GetListenerId(sName, iCounter);
    
    while (sListenerId != "")
    {
        iCounter ++;
        sListenerId = __GetListenerId(sName, iCounter);
    }
    return iCounter;
}

string __GetListenerId(string sSpeakerName, int iIndex)
{
    return GetLocalString(GetModule(), "LISTENER_ID_" + sSpeakerName + IntToString(iIndex));
}
void __SetListenerId(string sSpeakerName, int iIndex, string sValue)
{
    SetLocalString(GetModule(), "LISTENER_ID_" + sSpeakerName + IntToString(iIndex), sValue);
}
void __RemoveListenerId(string sSpeakerName, int iIndex)
{
    DeleteLocalString(GetModule(), "LISTENER_ID_" + sSpeakerName + IntToString(iIndex));
}

object __GetListenerObject(string sSpeakerName, int iIndex)
{
    return GetLocalObject(GetModule(), "LISTENER_" + sSpeakerName + IntToString(iIndex));
}
void __SetListenerObject(string sSpeakerName, int iIndex, object oListener)
{
    SetLocalObject(GetModule(), "LISTENER_" + sSpeakerName + IntToString(iIndex), oListener);
}
void __RemoveListenerObject(string sSpeakerName, int iIndex)
{
    DeleteLocalObject(GetModule(), "LISTENER_" + sSpeakerName + IntToString(iIndex));
}
