/*
 * Release kucik 05.01.2008
 */

#include "ja_ohnisko_inc"

void main()
{
  string sOhnTag = GetTag(OBJECT_SELF);
  int iCas = GetLocalInt(OBJECT_SELF,"cas");
  if(GetLocalInt(OBJECT_SELF,"underd"))
    sOhnTag = "ka_pohen";
  int bFire = FALSE;
  int bUndrFire = FALSE;
  int bSurfFire = FALSE;
  int bZhas = FALSE;
  int iSpell = GetLastSpell();

  switch (iSpell) {
    // v Podtemnu
    case SPELL_ACID_FOG: bUndrFire = TRUE; break;
    case SPELL_ACID_SPLASH: bUndrFire = TRUE; break;
    case SPELL_GRENADE_ACID: bUndrFire = TRUE; break;
    case SPELL_MELFS_ACID_ARROW: bUndrFire = TRUE; break;
    case SPELL_MESTILS_ACID_BREATH: bUndrFire = TRUE; break;
    case SPELL_DARKFIRE: bUndrFire = TRUE; break;
    // na Povrchu
    case SPELL_BURNING_HANDS: bSurfFire = TRUE; break;
    case SPELL_CONTINUAL_FLAME: bSurfFire = TRUE; break;
    case SPELL_DELAYED_BLAST_FIREBALL: bSurfFire = TRUE; break;
    case SPELL_FIRE_STORM: bSurfFire = TRUE; break;
    case SPELL_FIREBALL: bSurfFire = TRUE; break;
    case SPELL_FIREBRAND: bSurfFire = TRUE; break;
    case SPELL_FLAME_ARROW: bSurfFire = TRUE; break;
    case SPELL_FLAME_LASH: bSurfFire = TRUE; break;
    case SPELL_FLAME_STRIKE: bSurfFire = TRUE; break;
    case SPELL_FLAME_WEAPON: bSurfFire = TRUE; break;
    case SPELL_FLARE: bSurfFire = TRUE; break;
    case SPELL_GRENADE_FIRE: bSurfFire = TRUE; break;
    case SPELL_INFERNO: bSurfFire = TRUE; break;
    // Zhasnuti
    case SPELL_CONE_OF_COLD: bZhas = TRUE; break;
    case SPELL_GUST_OF_WIND: bZhas = TRUE; break;
    case SPELL_ICE_DAGGER: bZhas = TRUE; break;
    case SPELL_ICE_STORM: bZhas = TRUE; break;
    case SPELL_RAY_OF_FROST: bZhas = TRUE; break;
    case SPELL_IMPLOSION: bZhas = TRUE; break;
    case SPELL_BIGBYS_CRUSHING_HAND: bZhas = TRUE; break;
    default:
      break;
  }
  if( ( (bUndrFire) && (sOhnTag == "ka_pohen") ) ||
      ( (bSurfFire) && (sOhnTag == "sy_ohnisko") ) ) {
                //aktivuje ohnisko = zacne horiet


                if(sOhnTag == "ka_pohen") {
                  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_ACID_S),OBJECT_SELF);
                  object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"ka_modohen",GetLocation(OBJECT_SELF));
                  ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_LIGHT_BLUE_15),oFlame);
                }
                else {
                  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FLAME_S),OBJECT_SELF);
                  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_15),OBJECT_SELF,IntToFloat(iCas+DOBA_HORENI));
                }
                SetLocalInt(OBJECT_SELF,"hori",1);
                SetLocalInt(OBJECT_SELF,"cas",iCas+DOBA_HORENI);
//                AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
//                AssignCommand(oPlayer, SpeakString("*Zapali ohniste*"));

  }
  else if(bZhas) {
    int iHori = GetLocalInt(OBJECT_SELF,"hori");
    if (iHori==1)
    {
        SetLocalInt(OBJECT_SELF,"hori",0);

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
        else
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
