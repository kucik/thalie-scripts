#include "mys_dmlisten_lib"

void main()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetLocalObject(oDM, "dmfi_univ_target");

    if (RemoveListener(oTarget, oDM))
    {
        SendMessageToPC(oDM, GetName(oTarget) + ": ucho off.");
    }
    else
    {
        AddListener(oTarget, oDM);
        SendMessageToPC(oDM, GetName(oTarget) + ": ucho aktivní.");
    }
}
