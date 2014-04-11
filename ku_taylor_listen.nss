#include "ku_libtime"
#include "ku_taylor_inc"

const string TAY_TORSO = "hrudnik";
const string TAY_NECK = "krk";

void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    int iPart = GetLocalInt(OBJECT_SELF,"KU_PART");

    if (nMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
//        BeginConversation();
        ActionStartConversation(oShouter,"",TRUE,FALSE);
    }
    else
    if(nMatch == 777 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
    {

//      if (oShouter == GetLocalObject(OBJECT_SELF, "CUSTOMER")) {
      {
        string sSaid = GetMatchedSubstring(0);
        int iNum = StringToInt(sSaid);
        int nRestColors = 0;
//        object oStand = GetLocalObject(OBJECT_SELF,"KU_STAND");
//        object oCloth = GetItemInSlot(INVENTORY_SLOT_CHEST,oShouter);
//        object oCloth = GetLocalObject(oDyer,"CUSTOMER",oPC);
        object oDyer = OBJECT_SELF;
        object oCloth = GetLocalObject(oDyer,"ITEM");
//        SetLocalObject(oDyer,"ITEM_BACKUP",oCloth);
//        SpeakString("Listening...");


        if(FindSubString(sSaid,IntToString(iNum))!=-1) {

          if(GetLocalObject(OBJECT_SELF,"CUSTOMER") != oShouter) {
            return;
          }

          if(GetLocalInt(OBJECT_SELF,"TAYLOR_MODE")) {
//            SpeakString("Taylor");
            int iPrev = GetItemAppearance(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart);
            if(ku_TaylorCheckModel(oShouter,oCloth,iPart,iNum,iPrev) == FALSE) {
              SpeakString("Tento vzhled neni pouzitelny");
              return;
            }
            object oNCloth = CopyItemAndModify(oCloth,ITEM_APPR_TYPE_ARMOR_MODEL,iPart,iNum,TRUE);
            AssignCommand(oShouter,ActionEquipItem(oNCloth,INVENTORY_SLOT_CHEST));
            DestroyObject(oCloth);
            SetLocalObject(oDyer,"ITEM",oNCloth);
            SetCustomToken(6001,"Puvodni model "+IntToString(iPrev)+". Aktualni model "+IntToString(iNum));
          }
          else {
//            SpeakString("Dyer");
            int iSlot = GetLocalInt(oDyer,"DYE_INV_SLOT");
            int iType = GetLocalInt(OBJECT_SELF, "KU_PART") > 255 ? GetLocalInt(OBJECT_SELF, "KU_TYPE") : ITEM_APPR_TYPE_ARMOR_COLOR;
            // cloak models only 1-32
            if (GetLocalInt(OBJECT_SELF, "KU_PART") > 255 && (!iNum || iNum > 32))
            {
                SpeakString("Vzhled není.");
                return;
            }
            object oNCloth = CopyItemAndModify(oCloth,iType,iPart,iNum,TRUE);
            AssignCommand(oShouter,ActionEquipItem(oNCloth,iSlot));
            DestroyObject(oCloth);
            SetLocalObject(oDyer,"ITEM",oNCloth);
          }

          //cena
          int iDiscount;
          int iPrice = 0;
          object oPC = oShouter;
          object oDyer = OBJECT_SELF;

//          oCloth = oNCloth;
//          SetLocalInt(OBJECT_SELF,"KU_MODEL_"+IntToString(iPart),iNum);
        }
/*        else {
          if(FindSubString(sSaid,TAY_TORSO)!=-1) {
            SpeakString("Takze hrudnik"+IntToString(ITEM_APPR_ARMOR_MODEL_TORSO));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_TORSO);
            return;
          }
          if(FindSubString(sSaid,TAY_NECK)!=-1) {
            SpeakString("Takze krk"+IntToString(ITEM_APPR_ARMOR_MODEL_NECK));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_NECK);
            return;
          }
          if(FindSubString(sSaid,"pas")!=-1) {
            SpeakString("Takze pas "+IntToString(ITEM_APPR_ARMOR_MODEL_BELT));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_BELT);
            return;
          }
          if(FindSubString(sSaid,"levy biceps")!=-1) {
            SpeakString("Takze levy biceps "+IntToString(ITEM_APPR_ARMOR_MODEL_LBICEP));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LBICEP);
            return;
          }
          if(FindSubString(sSaid,"pravy biceps")!=-1) {
            SpeakString("Takze pravy biceps "+IntToString(ITEM_APPR_ARMOR_MODEL_RBICEP));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RBICEP);
            return;
          }
          if(FindSubString(sSaid,"leve chodidlo")!=-1) {
            SpeakString("Takze leve chodidlo "+IntToString(ITEM_APPR_ARMOR_MODEL_LFOOT));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LFOOT);
            return;
          }
          if(FindSubString(sSaid,"prave chodidlo")!=-1) {
            SpeakString("Takze prave chodidlo "+IntToString(ITEM_APPR_ARMOR_MODEL_RFOOT));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RFOOT);
            return;
          }
          if(FindSubString(sSaid,"leve predlokti")!=-1) {
            SpeakString("Takze leve predlokti"+IntToString(ITEM_APPR_ARMOR_MODEL_LFOREARM));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LFOREARM);
            return;
          }
          if(FindSubString(sSaid,"prave predlokti")!=-1) {
            SpeakString("Takze prave predlokti"+IntToString(ITEM_APPR_ARMOR_MODEL_RFOREARM));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RFOREARM);
            return;
          }
          if(FindSubString(sSaid,"leva ruka")!=-1) {
            SpeakString("Takze leva ruka "+IntToString(ITEM_APPR_ARMOR_MODEL_LHAND));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LHAND);
            return;
          }
          if(FindSubString(sSaid,"prava ruka")!=-1) {
            SpeakString("Takze leva ruka "+IntToString(ITEM_APPR_ARMOR_MODEL_RHAND));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RHAND);
            return;
          }
          if(FindSubString(sSaid,"lshin")!=-1) {
            SpeakString("Takze leva shin "+IntToString(ITEM_APPR_ARMOR_MODEL_LSHIN));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LSHIN);
            return;
          }
          if(FindSubString(sSaid,"rshin")!=-1) {
            SpeakString("Takze prave shin "+IntToString(ITEM_APPR_ARMOR_MODEL_RSHIN));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RSHIN);
            return;
          }
          if(FindSubString(sSaid,"leve rameno")!=-1) {
            SpeakString("Takze leve rameno "+IntToString(ITEM_APPR_ARMOR_MODEL_LSHOULDER));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LSHOULDER);
            return;
          }
          if(FindSubString(sSaid,"prave rameno")!=-1) {
            SpeakString("Takze prave rameno "+IntToString(ITEM_APPR_ARMOR_MODEL_RSHOULDER));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RSHOULDER);
            return;
          }
          if(FindSubString(sSaid,"lthigh")!=-1) {
            SpeakString("Takze lthigh "+IntToString(ITEM_APPR_ARMOR_MODEL_LTHIGH));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_LTHIGH);
            return;
          }
          if(FindSubString(sSaid,"rthigh")!=-1) {
            SpeakString("Takze rthigh "+IntToString(ITEM_APPR_ARMOR_MODEL_RTHIGH));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_RTHIGH);
            return;
          }
          if(FindSubString(sSaid,"pelvis")!=-1) {
            SpeakString("Takze pelvis "+IntToString(ITEM_APPR_ARMOR_MODEL_PELVIS));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_PELVIS);
            return;
          }
          if(FindSubString(sSaid,"robe")!=-1) {
            SpeakString("Takze robe "+IntToString(ITEM_APPR_ARMOR_MODEL_ROBE));
            SetLocalInt(OBJECT_SELF,"KU_PART",ITEM_APPR_ARMOR_MODEL_ROBE);
            return;
          }

        }
*/
      }
    }

}
