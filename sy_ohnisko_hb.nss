/* ohnisko event on heartbeat */

void main()
{

    //ClearAllActions();

    //na pociatku zmazem efekt "svetielko" z ohniska
    int iSpawn = GetLocalInt(OBJECT_SELF,"spawn");
    if (iSpawn==0)
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(OBJECT_SELF,"spawn",1);
        return;
    }

    int iHori = GetLocalInt(OBJECT_SELF,"hori");
    if( !iHori ) return;

    int iCas = GetLocalInt(OBJECT_SELF,"cas");
    if (iCas==0) return;

    if (iCas==1)
    {
        if(GetLocalInt(OBJECT_SELF,"underd")) {
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
          //ohen zhasne
          ExecuteScript("sy_ohnisko_off",OBJECT_SELF);
          SpeakString("*Chsss.. Ohniste vyhaslo*",TALKVOLUME_TALK);
          PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
          SetLocalInt(OBJECT_SELF, "hori", 0);

          effect eLight = GetFirstEffect(OBJECT_SELF);
          while(GetIsEffectValid(eLight)) {
            if(GetEffectType(eLight)==EFFECT_TYPE_VISUALEFFECT)
              RemoveEffect(OBJECT_SELF,eLight);
            eLight = GetNextEffect(OBJECT_SELF);
          }

        }
    }

    if (iCas==10)  //1 minuta
    {
        //vyhasina
        SpeakString("*Ohen ztraci na sile*",TALKVOLUME_TALK);
    }

    //testovacie ucely - vypis premennej cas
    //ActionSpeakString("Hori, cas="+IntToString(iCas));

    iCas--;
    SetLocalInt(OBJECT_SELF,"cas",iCas);
}
