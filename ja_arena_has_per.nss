#include "ja_variables"

int StartingConditional()
{
    return (GetLocalString(OBJECT_SELF, "TICKET_NAME") == GetLocalString( GetPCSpeaker(), v_ArenaPermission ));
}
