/* zapalenie ohna
 *
 * rev. Kucik 05.01.2008 uprava pro ohniste v podtemnu
 *
 *
 *
 */

#include "ja_ohnisko_inc"

void main()
{
    //zistim hraca ktory aktivoval dialog
    //a ci ma kresadlo v pravej ruke(zbran)
    object oPlayer = GetPCSpeaker();
    object oKresadlo = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPlayer);
    int iHori = GetLocalInt(OBJECT_SELF,"hori");
    int iCas = GetLocalInt(OBJECT_SELF,"cas");
    string sOhnTag = GetTag(OBJECT_SELF);
    if(GetLocalInt(OBJECT_SELF,"underd"))
      sOhnTag = "ka_pohen";
    //int iMaxCas = GetLocalInt(OBJECT_SELF,"maxCas");

    if (iHori==0)
    {
        // Hledani podpalovadla
        object oPodpal = GetFirstItemInInventory(oPlayer);
        string sPodpalTag;
        int remove = TRUE;
        while (oPodpal!=OBJECT_INVALID)
        {
          sPodpalTag = GetTag(oPodpal);
          if( ( ((sPodpalTag == "ka_podpal1") || (sPodpalTag == "sy_kresadlo")) &&  (sOhnTag == "sy_ohnisko") ) ||  // na povrchu
              ( (sPodpalTag == "ka_podpal2") &&  (sOhnTag == "ka_pohen"  ) ) )   // v podtemnu
            break;
          oPodpal = GetNextItemInInventory(oPlayer);
        }
        if(sPodpalTag == "sy_kresadlo") {
          remove = FALSE;
        }

//        if ((GetTag(oKresadlo) == "sy_kresadlo"))
        if(oPodpal!=OBJECT_INVALID)
        {
           /*
            if(iCas > 1){
                PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
                SetLocalInt(OBJECT_SELF,"hori",1);
                AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
                AssignCommand(oPlayer, SpeakString("*Zapali ohniste*"));
            }
            */
            //najdem drevo v inventari hraca a znicim ho
            /*
            object oItem = GetFirstItemInInventory(oPlayer);
            while (oItem!=OBJECT_INVALID)
            {
                if (JeDrevo(GetTag(oItem))) break;
                oItem = GetNextItemInInventory(oPlayer);
            }
            */

//            if (oItem!=OBJECT_INVALID)
            if (TRUE)
            {
                //nasiel som drevo v inventari - nastavim cas horenia a znicim drevo

                int iPodpStact = GetItemStackSize(oPodpal);
                if(remove) {
                  if(iPodpStact==1)
                    DestroyObject(oPodpal);
                  else
                    SetItemStackSize(oPodpal,iPodpStact-1);
                }
                //aktivuje ohnisko = zacne horiet
                if(sOhnTag == "ka_pohen") {
                  object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"ka_modohen",GetLocation(OBJECT_SELF));
                  ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_LIGHT_BLUE_15),oFlame);
                }
                else {
                  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_15),OBJECT_SELF,IntToFloat(6*(iCas+DOBA_HORENI)));
                }

                SetLocalInt(OBJECT_SELF,"hori",1);
                SetLocalInt(OBJECT_SELF,"cas",iCas+DOBA_HORENI);
                AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
                AssignCommand(oPlayer, SpeakString("*Zapali ohniste*"));
            } else
            {
                //nenasiel drevo v inventari - vypisem spravu
                FloatingTextStringOnCreature("Nemas cim prilozit do ohne.",oPlayer,0);
            }
        } else
        {
            FloatingTextStringOnCreature("Nemas u sebe nic, cim by se dal ohen rozdelat", oPlayer, FALSE);
        }
    }
    else {
        SpeakString("*ohen hori*");
    }
}
