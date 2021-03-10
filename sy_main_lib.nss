/*
 * rev. 24.01.2008 Kucik: Zakaz zobrazovani zbrani v podsveti.
 */


//void    sy_remove_spells(object oPC);

#include "subraces"
//#include "sh_classes_inc_e"

//===== FUNKCIE ================================================================
//zmaze len niekolko kuziel ktore maju vizualny efekt
//ktore hraci chceli "nemat" na sebe
void sy_remove_spells(object oPC)
{
    effect eFX = GetFirstEffect(oPC);
    while (GetIsEffectValid(eFX))
    {
        if (GetEffectSubType(eFX)==SUBTYPE_MAGICAL)
        {
            int nSpell = GetEffectSpellId(eFX);
            switch (nSpell)
            {
                case SPELL_BARKSKIN:
                case SPELL_STONESKIN:
                case SPELL_GREATER_STONESKIN:
                case SPELL_PREMONITION:
                case SPELL_RESIST_ELEMENTS:
                case SPELL_ENDURE_ELEMENTS:
                case SPELL_PROTECTION_FROM_ELEMENTS:
                case SPELL_ENERGY_BUFFER:
                case SPELL_ELEMENTAL_SHIELD:
                case SPELL_MESTILS_ACID_SHEATH:
                case SPELL_CLARITY:
                case SPELL_LESSER_MIND_BLANK:
                case SPELL_MIND_BLANK:
                case SPELL_GHOSTLY_VISAGE:
                case SPELL_ETHEREAL_VISAGE:
                case SPELL_SEE_INVISIBILITY:
                case SPELL_DARKVISION:
                case SPELL_TRUE_SEEING:
                case SPELL_INVISIBILITY:
                case SPELL_INVISIBILITY_SPHERE:
                case SPELL_IMPROVED_INVISIBILITY:
                case SPELL_DEATH_ARMOR:
                case SPELL_SHADOW_SHIELD:
                case SPELL_SPELL_MANTLE:
                case SPELL_SPELL_RESISTANCE:
                case SPELL_SANCTUARY:
                case SPELL_FREEDOM_OF_MOVEMENT:
                case 909: //FEAT_SUBRACE_GENASI_ZEMNI_KAMENKA
                case 141: //SPELL_PROTECTION_FROM_SPELS:
                case 554: //iounsky kamen
                case 555: //iounsky kamen
                case 556: //iounsky kamen
                case 557: //iounsky kamen
                case 558: //iounsky kamen
                case 559: //iounsky kamen
                case 560: //iounsky kamen
                case 136: //protection from alligment
                case 138: //protection from alligment
                case 139: //protection from alligment
                case 140: //protection from alligment
                case 417: //Shield
                case 967: //EPIC_SPELL_DAY_OF_PROTECTION
                    RemoveEffect(oPC, eFX);
                    break;
            }
        }
        eFX = GetNextEffect(oPC);
    }
}


