#include "ja_bank_inc"

void main()
{
    SetLocalInt(OBJECT_SELF, "COMMAND", bank_CommandPut);
    SetLocalObject(OBJECT_SELF, "CUSTOMER", GetPCSpeaker());
}
