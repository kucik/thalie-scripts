/* vyhasnutie ohna
 *
 *
 * rev. Kucik 05.01.2008 Uprava pro pouziti i na ohnisti v podtemnu
 *
 */


void main()
{
    int iHori = GetLocalInt(OBJECT_SELF,"hori");
    if (iHori==1)
    {
        string sOhnTag = GetTag(OBJECT_SELF);
        if(GetLocalInt(OBJECT_SELF,"underd"))
           sOhnTag = "ka_pohen";

        SetLocalInt(OBJECT_SELF,"hori",0);
        //SetLocalInt(OBJECT_SELF,"cas",1);

        object oPlayer = GetPCSpeaker();
        AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 1.5));
        AssignCommand(oPlayer, SpeakString("*Uhasi ohniste*"));

        if(sOhnTag == "ka_pohen") {
          location lPCLoc = GetLocation(OBJECT_SELF);
          object oOhniste = GetFirstObjectInShape(SHAPE_SPHERE,1.0,lPCLoc,FALSE,OBJECT_TYPE_PLACEABLE);
          while (GetIsObjectValid(oOhniste) ) {
            if(GetTag(oOhniste) == "ka_modohen") {
              DestroyObject(oOhniste,1.0);
            }
            oOhniste = GetNextObjectInShape(SHAPE_SPHERE,1.0,lPCLoc,FALSE,OBJECT_TYPE_PLACEABLE);
          }
        }
        else {
          DelayCommand(1.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
          effect eLight = GetFirstEffect(OBJECT_SELF);
          while(GetIsEffectValid(eLight)) {
            if(GetEffectType(eLight)==EFFECT_TYPE_VISUALEFFECT)
              RemoveEffect(OBJECT_SELF,eLight);
            eLight = GetNextEffect(OBJECT_SELF);
          }
        }
    }
}

