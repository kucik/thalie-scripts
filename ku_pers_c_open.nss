#include "ku_persist_inc"

void main()
{
  Persist_OnContainerOpen(OBJECT_SELF,GetLastOpenedBy());
}
