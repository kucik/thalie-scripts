#include "subraces"
void main()
{
    object oPC = GetPCSpeaker();
    if (Subraces_GetIsCharacterFromUnderdark(GetPCSpeaker()))  //podtemno
    {
        OpenStore(GetObjectByTag("sh_podtemno"),oPC);
    }
    else
    {
        OpenStore(GetObjectByTag("sh_povrch"),oPC);
    }
}
