// * Looks for the nearest store and opens it
#include "nw_i0_plot"

void main()
{


    /*Do I remember shop? */
    object oStore = GetLocalObject(OBJECT_SELF,"_KU_MYSHOPSPECIAL");

    /* Find shop */
    if(!GetIsObjectValid(oStore)) {
      string sTag = GetLocalString(OBJECT_SELF,"KU_SHOPSPECIAL");
      if(GetStringLength(sTag) > 0) {
        oStore = GetObjectByTag(sTag);
      }
      if(!GetIsObjectValid(oStore)) {
        oStore = GetNearestObject(OBJECT_TYPE_STORE);
        int i=1;
        /* Nikdy neotvirat obchod s timto tagem */
        while(GetTag(oStore)=="ku_shop_warehouse") {
          i++;
          oStore = GetNearestObject(OBJECT_TYPE_STORE,OBJECT_SELF,i);
        }
      }
    }
    SetLocalObject(OBJECT_SELF,"_KU_MYSHOPSPECIAL",oStore);

    if (GetIsObjectValid(oStore) == TRUE)
    {
          gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
        PlayVoiceChat(VOICE_CHAT_CUSS);
}


