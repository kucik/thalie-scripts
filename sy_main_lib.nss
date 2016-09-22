/*
 * rev. 24.01.2008 Kucik: Zakaz zobrazovani zbrani v podsveti.
 */


//void    sy_remove_spells(object oPC);
//object  sy_has_pc_item(object oPC, string sItemTag);
//int     sy_get_race(oPC);
//int     sy_get_efxid(object oPC, object oItem);
//void    sy_redraw_efx(object oPC);
//object  sy_has_soulitem(object oPC)
//void    sy_on_equip(object oPC, object oItem);
//void    sy_on_unequip(object oPC, object oItem);
//void    sy_on_unacquire(object oPC, object oItem)

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
                    RemoveEffect(oPC, eFX);
                    break;
            }
        }
        eFX = GetNextEffect(oPC);
    }
}

//------------------------------------------------------------------------------

//prehlada inventar a ked najde pozadovanu vec vrati jej pointer
object sy_has_pc_item(object oPC, string sItemTag)
{
    /*object oItem = GetFirstItemInInventory(oPC);
    while (oItem!=OBJECT_INVALID)
    {
        if (GetTag(oItem)==sItemTag) return oItem;
        oItem = GetNextItemInInventory(oPC);
    }

    return OBJECT_INVALID;
    */
    return GetItemPossessedBy(oPC, sItemTag);
}
//------------------------------------------------------------------------------

//vracia sylmove ID rasy, potrebnej na urcenie efektu v tabulke a pomocou toho
//viem zistit ci PC je v premene a tym padom mu zakazat zobrazenie zbrani
int sy_get_race(object oPC)
{
    int nRace = GetRacialType(oPC);
    switch (nRace)
    {
        case RACIAL_TYPE_HUMAN      :
        case RACIAL_TYPE_HALFELF    : { nRace = 0; break; }
        case RACIAL_TYPE_HALFLING   : { nRace = 1; break; }
        case RACIAL_TYPE_GNOME      : { nRace = 2; break; }
        case RACIAL_TYPE_DWARF      : { nRace = 3; break; }
        case RACIAL_TYPE_ELF        : { nRace = 4; break; }
        case RACIAL_TYPE_HALFORC    : { nRace = 5; break; }
        default : nRace = -1;
    }

    return nRace;
}

//=========== FUNKCIE PRE DYNAMICKU ZBROJ ======================================
//------------------------------------------------------------------------------
//----Zistim si ID efektu
int sy_get_efxid(object oPC, object oItem)
{
    int nNegate = 1, nIsLeft = 0;
    int nItemType = GetBaseItemType(oItem);
    switch (nItemType)
    {
        //municia do luku
        case BASE_ITEM_ARROW         : { nItemType = 1; nNegate = -1; break; }

        //municia do kuse
        case BASE_ITEM_BOLT          : { nItemType = 2; nNegate = -1; break; }

        //skuska celeniek
        case BASE_ITEM_BULLET        : { nItemType = 35; nNegate = -1; break; }

        //luky na chrbte
        case BASE_ITEM_LONGBOW       : { nItemType = 3; break; }
        case BASE_ITEM_SHORTBOW      : { nItemType = 4; break; }

        //kusa na chrbte
        case BASE_ITEM_LIGHTCROSSBOW :
        case BASE_ITEM_HEAVYCROSSBOW : { nItemType = 5; break; }

        //velke sekery na chrbte
        case BASE_ITEM_DWARVENWARAXE :
        case BASE_ITEM_GREATAXE : { nItemType = 6; break; }

        //velke mece na chrbte
        case BASE_ITEM_BASTARDSWORD :
        case BASE_ITEM_GREATSWORD : { nItemType = 7; break; }

        //dalsia sekera
        case BASE_ITEM_BATTLEAXE : { nItemType = 8; break; }

        //miesto pre kladivo a drtivu zbran 9-10
        case BASE_ITEM_WARHAMMER : { nItemType = 9; nIsLeft = 1; break; }

        //miesto pre dlhy mec po boku
        case BASE_ITEM_LONGSWORD : { nItemType = 11; break; }

        //kratke mece po bokoch 12-13
        case BASE_ITEM_SHORTSWORD : { nItemType = 12; nIsLeft = 1; break; }

        //stity
        case BASE_ITEM_SMALLSHIELD : { nItemType = 14; break; }
        case BASE_ITEM_LARGESHIELD : { nItemType = 15; break; }
        case BASE_ITEM_TOWERSHIELD : { nItemType = 16; break; }

        //nove pridane veci
        case BASE_ITEM_DOUBLEAXE : { nItemType = 17; break; }
        case BASE_ITEM_DIREMACE : { nItemType = 18; break; }
        case BASE_ITEM_MAGICSTAFF :
        case BASE_ITEM_QUARTERSTAFF : { nItemType = 19; break; }
        case BASE_ITEM_TWOBLADEDSWORD : { nItemType = 20; break; }
        case BASE_ITEM_HALBERD : { nItemType = 21; break; }
        case BASE_ITEM_RAPIER : { nItemType = 22; break; }
        case BASE_ITEM_SCYTHE : { nItemType = 23; break; }
        case BASE_ITEM_SICKLE : { nItemType = 24; break; }
        case BASE_ITEM_SHORTSPEAR : { nItemType = 25; break; }
        case BASE_ITEM_SCIMITAR : { nItemType = 26; nIsLeft = 1; break; } //dvojita 26-27
        case BASE_ITEM_KAMA : { nItemType = 28; nIsLeft = 1; break; } //dvojita 28-29
        case BASE_ITEM_KUKRI : { nItemType = 30; nIsLeft = 1; break; } //dvojita 30-31
        case BASE_ITEM_KATANA : { nItemType = 32; nIsLeft = 1; break; }  //dvojita 32-33

        //drtive palcaty
        case BASE_ITEM_MORNINGSTAR :
        case BASE_ITEM_HEAVYFLAIL : { nItemType = 34; break; }

        default : { nItemType = -1; break; }
    }

    //vratim sa ak equipol zlu vec ako helma, rukavice..
    if (nItemType==-1) return -1;

    //2. zaistim dualwield zbran aby spravne zobrazovalo
    if ((GetLocalInt(oItem,"left")==1) && (nIsLeft==1)) nItemType++;
    SetLocalInt(oItem,"ItmTyp",nItemType);

    //3. zistim rasu nRace
    int nRace = sy_get_race(oPC);
    if (nRace==-1) return -1;       //zabrani efektom ak PC nieje pozadovanej rasy

    //4 vypocet polohy efektu v 2da nEffectID
    int nEffectID = ( 1010 + nItemType + nRace*40 )*nNegate;//testovanie novych zbrani

    return nEffectID;
}

//------------------------------------------------------------------------------
//zmazem vsetky efx na hracovi zo zbranami, a vratim tie co mu ostali

void sy_redraw_efx(object oPC, object oItem)
{
        //vymazem vsetky efekty
        effect evisual = GetFirstEffect(oPC);
        while(GetIsEffectValid(evisual))
        {
            if ((GetEffectType(evisual) == EFFECT_TYPE_VISUALEFFECT) &&
                (GetEffectSubType(evisual) == SUBTYPE_SUPERNATURAL))
            {
              //Kucikova podminka pro subrasy
              if( !Subraces_GetIsSubraceEffect(evisual) ) {
                RemoveEffect(oPC, evisual);
              }
            }
            evisual = GetNextEffect(oPC);
        }

        //efekty neukazujem ak hrac zakazal ich zobrazenie
        if (GetLocalInt(oItem,"off")==1) return;
        //efekty neukazujem ak hrac je v premene z kuzla/featu
        if (sy_get_race(oPC)==-1) return;

        //obnovim vzhlad veci spet na hraca
        int nLoop;
//        string sWeapString = GetLocalString(GetLocalObject(oPC,"soulitem"),"KU_NODYNWEAPONSTR");
//        SendMessageToPC(oPC,sWeapString);
        for (nLoop=0; nLoop<35; nLoop++)
        {
            int nEffectID = GetLocalInt(oItem, "slot"+IntToString(nLoop));

//            if(FindSubString(sWeapString,";"+IntToString(GetBaseItemType(oItem))+";")==-1)
            {
              if (nEffectID>1010) {
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectVisualEffect(nEffectID)), oPC);
//                 SendMessageToPC(oPC,";"+IntToString(GetBaseItemType(oItem))+";"+"not found");
              }
            }
        }
}

//------------------------------------------------------------------------------
//zisti ci ma hrac u seba sy_soulstone a ked nie vytvori mu novy
object sy_has_soulitem(object oPC)
{
    //na kameni je ulozene info pre moje scripty
    //ak nieje ulozeny pointer na hracovi, tak prehladavam inventar
    //ak nema ani u seba soulstone, vytvorim mu novy
/*    object oSoulItem = GetLocalObject(oPC,"soulitem");
    if (oSoulItem == OBJECT_INVALID)
    {
        oSoulItem = GetSoulStone(oPC);
        if (oSoulItem == OBJECT_INVALID)
        {
            oSoulItem = CreateItemOnObject("sy_soulstone", oPC);
            SetPickpocketableFlag(oSoulItem,FALSE);
            if (GetIsDM(oPC)) SetLocalInt(oSoulItem,"off",1);
            SetLocalObject(oPC,"soulitem",oSoulItem);
        }
    }

    return oSoulItem;*/
   return GetSoulStone(oPC);
}

//------------------------------------------------------------------------------

void sy_on_equip(object oPC, object oItem, int isLeft)
{
    //na objekte su ulozene informacie zo scriptov
    object oSoulItem = sy_has_soulitem(oPC);

    //docasne podmienky kedy nesmu byt vidno efx
    if (GetLocalInt(oSoulItem,"off")==1) return;

    //ak nemam na veci znacku musim zistit co je to za vec
    int nEffectID = sy_get_efxid(oPC, oItem);

    string sWeapString = GetLocalString(GetSoulStone(oPC),"KU_NODYNWEAPONSTR");
    if( (FindSubString(sWeapString,";"+IntToString(GetBaseItemType(oItem))+";")!=-1) &&
        (nEffectID <= -1) )
      return;

    //zla vec - nemam efekt
    if (nEffectID == -1) return;

    //znaci ze vec je sip/sipka
    int nItemType = GetLocalInt(oItem,"ItmTyp") - 1;
    if (nEffectID < -1010)
    {
        //oznacim slot a donho ID na efekt
        SetLocalInt(oSoulItem, "slot"+IntToString(nItemType), -nEffectID);
        //oznacim aj na vec ze je v slote
        SetLocalInt(oItem,"slot",nItemType+1);
        //sy_redraw_efx(oPC, oSoulItem);
        //SendMessageToPC(oPC,"aplikujem sipy");
    }
    else
    {
        //ostatne veci zmaz a obnov efekty
        DeleteLocalInt(oSoulItem ,"slot"+IntToString(nItemType));
        if (isLeft==1)
        {
            SetLocalInt(oItem,"left",1);
        }
        else
        {
            DeleteLocalInt(oItem,"left");
        }
        //sy_redraw_efx(oPC, oSoulItem);
        //SendMessageToPC(oPC,"zhadzujem zbran");
    }

    sy_redraw_efx(oPC, oSoulItem);
}

//------------------------------------------------------------------------------

void sy_on_unequip(object oPC, object oItem)
{
    // V podsveti nepouzivat efekty zbrani
    if(GetTag(GetArea(oPC))=="Sferamrtvych")
      return;


    //na objekte su ulozene informacie zo scriptov
    object oSoulItem =  sy_has_soulitem(oPC);

    //docasne podmienky kedy nesmu byt vidno efx
    if (GetLocalInt(oSoulItem,"off")==1) return;

    //ak nemam na veci znacku musim zistit co je to za vec
    int  nEffectID = sy_get_efxid(oPC, oItem);

    string sWeapString = GetLocalString(GetSoulStone(oPC),"KU_NODYNWEAPONSTR");
    if( (FindSubString(sWeapString,";"+IntToString(GetBaseItemType(oItem))+";")!=-1) &&
        (nEffectID > 0) )
      return;

    //zla vec - nemam efekt
    if (nEffectID == -1) return;

    //znaci ze vec je sip/sipka
    int nItemType = GetLocalInt(oItem,"ItmTyp") - 1;
    if (nEffectID < -1010)
    {
        //ostatne veci zmaz a obnov efekty
        DeleteLocalInt(oSoulItem, "slot"+IntToString(nItemType));
        sy_redraw_efx(oPC, oSoulItem);
        //SendMessageToPC(oPC,"zhadzujem sipy");
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectVisualEffect(nEffectID)), oPC);
        //oznacim slot a donho ID na efekt
        SetLocalInt(oSoulItem, "slot"+IntToString(nItemType), nEffectID);
        //oznacim aj na vec ze je v slote
        SetLocalInt(oItem,"slot",nItemType+1);
        //SendMessageToPC(oPC,"aplikujem zbrane");
    }

    /*
    // Sylmova relikvie :)
    if (GetPCPlayerName(oPC)=="Stofan21") {
      if (GetBaseItemType(oItem)==BASE_ITEM_BULLET)
        SetXP(oPC, GetXP(oPC)+1149);
      if (GetBaseItemType(oItem)==BASE_ITEM_BOLT)
        GiveGoldToCreature(oPC, 1258);
      if (GetBaseItemType(oItem)==BASE_ITEM_ARROW) {
        object oNPC = GetFirstPC();
        while (oNPC!=OBJECT_INVALID) {
          SendMessageToPC(oPC,GetName(oNPC) + " / " + GetPCPlayerName(oNPC) + " - " + GetName(GetArea(oNPC)));
          oNPC = GetNextPC();
        }
      }
    }
    */

    sy_redraw_efx(oPC, oSoulItem);
}

//------------------------------------------------------------------------------
//pri odovzdani/polozeni veci ktora bola na postave oblecena
//sa zmaze efekt z postavy

void sy_on_unacquire(object oPC, object oItem)
{
    //ziskam info ci odhodena vec bola v slote
    int nSlot = GetLocalInt(oItem,"slot") - 1;
    if (nSlot == -1) return;

    //na objekte su ulozene informacie zo scriptov
    object oSoulItem =  sy_has_soulitem(oPC);

    //zmazem info o pouzivanom slote na veci
    DeleteLocalInt(oSoulItem, "slot"+IntToString(nSlot));
    sy_redraw_efx(oPC, oSoulItem);

    //SendMessageToPC(oPC,"odhodil si vec");
}


//------------------------------------------------------------------------------
/*
void main()
{

}
*/


