/* prikladanie dreva do ohna
 *
 *
 * rev. Kucik 05.01.2008 odstraneni potreby drivi
 *
 *
 */

#include "ja_ohnisko_inc"

void main()
{
    object oPlayer = GetPCSpeaker();
    //int iHori = GetLocalInt(OBJECT_SELF,"hori");
    int iCas = GetLocalInt(OBJECT_SELF,"cas");
    //int iMaxCas = GetLocalInt(OBJECT_SELF,"maxCas");

    //zistim ci ohen hori inac je zbytocne prikladat drevo
    //if (iHori==1)
    //{
        //najdem predmet drevo v inventari hraca

        /* My, dobrodruzi si umime drevo nasbirat v okoli
        object oItem = GetFirstItemInInventory(oPlayer);
        while (oItem!=OBJECT_INVALID)
        {
            if (JeDrevo(GetTag(oItem))) break;
            oItem = GetNextItemInInventory(oPlayer);
        }

        if (oItem!=OBJECT_INVALID)
        {
            //nasiel som drevo v inventari - nastavim cas horenia a znicim drevo
            DestroyObject(oItem);
        */
            // Aby to neslo nalozit na x hodin dopredu.
            int iNovycas=iCas + DOBA_HORENI;
            if(iNovycas > 150)
              iNovycas = 150;
            SetLocalInt(OBJECT_SELF,"cas",iNovycas);

            AssignCommand(oPlayer,SpeakString("*Prilozi do ohniste*",TALKVOLUME_TALK));
            AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));

            if(GetLocalInt(OBJECT_SELF,"underd")) {
              effect eLight = GetFirstEffect(OBJECT_SELF);
              while(GetIsEffectValid(eLight)) {
                if(GetEffectType(eLight)==EFFECT_TYPE_VISUALEFFECT)
                  RemoveEffect(OBJECT_SELF,eLight);
                eLight = GetNextEffect(OBJECT_SELF);
              }
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_15),OBJECT_SELF,IntToFloat(6*iNovycas));
            }

        /*
        } else
        {
            //nenasiel drevo v inventari - vypisem spravu
            FloatingTextStringOnCreature("*Nemas cim prilozit do ohniste*",oPlayer,0);
        }
        */
    //}
}
