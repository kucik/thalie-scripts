#include "aps_include"
#include "raiseinc"

void main()
{

        if(!GetLocalInt(OBJECT_SELF,"SUBDUAL")) {
          return;
        }

        object oPC = GetFirstPC();
        string sPlayerName = GetLocalString(OBJECT_SELF, "PLAYER");
        string sPCName = GetLocalString(OBJECT_SELF, "PC");
        while(oPC != OBJECT_INVALID){
            if(GetPCPlayerName(oPC) == sPlayerName && GetName(oPC) == sPCName){

                // Pokud si hrac nepreje byt oziven, bDisRes = TRUE
                int bDisRes = GetLocalInt(oPC,"KU_ZAKAZ_OZIVENI");
                if(!bDisRes) {

                  Raise(oPC);

                  effect eDmg = EffectDamage(GetMaxHitPoints(oPC)-1);
                  DelayCommand(0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC));

                  //edit Sylm : po oziveni zmazem priznak smrti isDead = 0
                  object oSoulItem = GetSoulStone(oPC);
                  DeleteLocalInt(oSoulItem,"isDead");
                  //end Sylm

                  AssignCommand(oPC, ClearAllActions());
                  location lRaise = GetLocation(OBJECT_SELF);
                  AssignCommand(oPC, JumpToLocation(lRaise));

//                  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), lRaise);
                  SetLocalLocation(oPC, "LOCATION", lRaise);
                  SetPersistentLocation(oPC, "LOCATION", lRaise);

                  DestroyObject(OBJECT_SELF, 1.0f);

                  return;
                }
              SendMessageToPC(oPC,"Nepodarilo se vzkrisit.");
            }
            oPC = GetNextPC();
        }
        SpeakString("//Hrac "+sPCName+" s postavou "+sPlayerName+" neni ve hre!");

}
