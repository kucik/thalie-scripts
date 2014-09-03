//////////////////////////
// ku_sp_checkhp
//
// Spawn boss checkers Check boss HP
////////////////////////


#include "lock_inc"

void __performCheck(int iHP, string sSpawn, object oBoss, int iOneshot);

void __performCheck(int iHP, string sSpawn, object oBoss, int iOneshot) {
  if(!GetIsObjectValid(oBoss))
    return;

  if( GetCurrentHitPoints(oBoss) < iHP) {
    __processSpawnByTag(OBJECT_SELF, sSpawn);
    if(iOneshot)
     return;
  }

  DelayCommand(1.0, __performCheck(iHP, sSpawn, oBoss, iOneshot));
}

void main() {
  int iHP = GetLocalInt(OBJECT_SELF, "MIN_HP");
  string sSpawn = GetLocalString(OBJECT_SELF, "SPAWN");
  int iOneshot = GetLocalInt(OBJECT_SELF, "ONESHOT");
  object oBoss = GetLocalObject(OBJECT_SELF, "__LOCK_BOSS");

  DelayCommand(3.0, __performCheck(iHP, sSpawn, oBoss, iOneshot));

}
