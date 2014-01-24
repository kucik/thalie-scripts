#include "ja_bank_inc"

void main()
{
    SetLocalInt(OBJECT_SELF, "COMMAND", bank_CommandGet);
    SetLocalObject(OBJECT_SELF, "CUSTOMER", GetPCSpeaker());
}

