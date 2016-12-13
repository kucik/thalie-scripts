#include "ku_libtime"
//#include "no_oc_inc"
#include "no_nastcraft_ini"
#include "tc_functions"
#include "tc_xpsystem_inc"
#include "ku_items_inc"
#include "x3_inc_string"

#include "ku_persist_inc"
/////////////////////////////////////
///  dela vsemozne sici vyrobky s tagama:
///
///  boty: no_tr_kr_01_02
/// 01-kuze  02 pouzite drevo, 02 pouzity kov
///
/////////////////////////////////

int no_pocet;
string no_nazev;
int no_DC;
int no_bonus_vylepseni;


void no_zjistiobsah(string no_tagveci);
//podle tagu veci zjisti kolik je sutru, jejich cislo a ulozi je na :
// zarizeni do int no_pouzite_drevo  no_kov_luku no_druh_vyrobku

void  no_udelejjmeno(object no_Item);
// podle no:zjistisutry udela celkocej nazec predmetu.

void no_cenavyrobku(object no_Item);
// nastavi cenu vyrobku

//void no_nazevsutru(int kamen1,int kamen2);
//udela na OBJECT_SELF no_nazevsutru  string s nazvem

void no_vynikajicikus(object no_Item);
// prida nahodne neco dobreho, kdyz bude vynikajici vyrobek !

// pridavame podle kovu procenta.
void no_udelej_vlastnosti(int no_kov_co_pridavam, int no_kov_pridame_procenta,int barva, object no_Item );

//zkusi nejak zmenit vzhled.
void no_udelej_vzhled(object no_Item);

void no_udelejocarovani(object no_Item);
//udela vyrobek + mu udeli vlastnosti podle pouzitych prisad

void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_kamen( object no_pec, int no_mazani);
// nastavi promenou no_drevo
void no_vyrobek (object no_Item, object no_pec, int no_mazani);
// nastavi promennou no_sperk

///////////////funkce pro ovladani zarizeni//////////////////////////////

void no_reopen(object no_oPC);
// preotevreni inventare prevzate z kovariny
void no_znicit(object no_oPC);
// znici tlacitka z inventare
void no_reknimat(object no_oPC);
// rekne kolik procent je jakeho materialu
void no_zamkni(object no_oPC);
// zamkne a pak odemkne + prehrava animacku

/////////////////////////////////////////////////////////////////////////////////////
/////////////   Funkce ne reseni xpu a lvlu craftu
/////////////
//////////////////////////////////////////////////////////////////////////////////////
void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item);
//pridava procenta k vyrobkum, bo se nam to tam moc pletlo, + to bylo 2krat


//pomaha pridavat % polotovaru, kdyztak predava hotovvej vyrobek, pridava xpy..
void no_xp_oc (object no_oPC, object no_pec);

//vyrobi polotovar se vsemi nutnymi tagy apod.
void no_xp_vyrobpolotovar(object no_oPC, object no_pec);



//////////////////////////////////////////////////////////////////////////////////////////
void no_pohybklikacu(object no_oPC, object no_pec);


int __GetIsLimitedByWeapon(int iMater);

/////////zacatek zavadeni funkci//////////////////////////////////////////////

void no_zjistiobsah(string no_tagveci)
//podle tagu veci zjisti kolik teho je, jejich cislo a ulozi je na :
// zarizeni do int no_kov_1  no_kov_2 no_kov_procenta no_druh_vyrobku no_druh_nasada
{
}////////konec no_zjisti_obsah

int __ocGetPercentsFromLevel(int no_level) {
  int no_menu_max_procent = ((no_level + 1) / 3) * 2 + 8;

  if(no_menu_max_procent > 20)
    no_menu_max_procent = 20;
  if(no_menu_max_procent < 10)
    no_menu_max_procent = 10;
  return no_menu_max_procent;

/*  if(no_level >= 17)
    return 20;
  if(no_level >= 14)
    return 18;
  if(no_level >= 11)
    return 16;
  if(no_level >= 8)
    return 14;
  if(no_level >= 5)
    return 12;
*/
  return 10;
}


int __ocGetMaxEnchantmentBaseItem(int iType){

  switch(iType) {
    case BASE_ITEM_GREATSWORD:
    case BASE_ITEM_HALBERD:
    case BASE_ITEM_TRIDENT:
    case BASE_ITEM_GREATAXE:
    case 318: // Maul
    case 320: // Mercuruial gretsword
      return 20;
    case BASE_ITEM_BASTARDSWORD:
    case BASE_ITEM_KATANA:
    case BASE_ITEM_SHORTSPEAR:
    case BASE_ITEM_SCYTHE:
    case BASE_ITEM_DWARVENWARAXE:
    case BASE_ITEM_HEAVYFLAIL:
    case 305:  // falchion
    case 321:  // Double scimitar
    case 317:  // Heavy mace
    case 301:  // heavy pick
      return 18;
    case BASE_ITEM_LONGSWORD:
    case BASE_ITEM_QUARTERSTAFF:
    case BASE_ITEM_DOUBLEAXE:
    case BASE_ITEM_TWOBLADEDSWORD:
    case BASE_ITEM_DIREMACE:
    case BASE_ITEM_BATTLEAXE:
    case BASE_ITEM_WARHAMMER:
    case BASE_ITEM_MORNINGSTAR:
    case 304:  // Nunchaku
    case 319:  // Mercurial longsword
    case 324:  // Maugdoublesword
    case 203:  // One handed spear
    case 300:  // Onehanded triden
    case BASE_ITEM_GLOVES:
      return 16;
    case BASE_ITEM_SHORTSWORD:
    case BASE_ITEM_RAPIER:
    case BASE_ITEM_SCIMITAR:
    case BASE_ITEM_KAMA:
    case BASE_ITEM_SICKLE:
    case BASE_ITEM_HANDAXE:
    case BASE_ITEM_LIGHTHAMMER:
    case BASE_ITEM_CLUB:
    case BASE_ITEM_LIGHTMACE:
    case 303:  // Sai
    case 308:  // Sap
    case 302:  // Light pick
      return 14;
    case BASE_ITEM_DAGGER:
    case BASE_ITEM_WHIP:
    case BASE_ITEM_KUKRI:
    case 310:  // Katar
      return 12;
    case BASE_ITEM_LIGHTFLAIL:
      return 10;
  }
  return 0;

}

int __ocGetMaxEnchantment(string sType) {
  int iType = TC_getBaseItemByShortcut(sType);
  if(iType < 0)
    return -1;

  return __ocGetMaxEnchantmentBaseItem(iType);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////udela jmeno celkoveho vyrobku at uz to je cokoliv///////////////////////////////
void  no_udelejjmeno(object no_Item)
{
//SetName(no_Item,"cerveny" + GetName(no_Item));

//kuciks work :
SetStolenFlag(no_Item,0);
SetPlotFlag(no_Item,0);
int no_iPrice= GetGoldPieceValue(no_Item);
int no_iLevel;
int iRow = 0;
while( StringToInt(Get2DAString("itemvalue","MAXSINGLEITEMVALUE",iRow)) < no_iPrice) {
no_iLevel++;
iRow ++;
}
// Level je vzdy radek + 1;
no_iLevel = no_iLevel+1;
if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"cena predmetu = " + IntToString(no_iPrice) );}

//string no_popisek = GetLocalString(no_Item,"no_popisek");
// + no_popisek


object no_Item2 = CopyItem(no_Item,no_oPC,TRUE);
//SetDescription(no_Item2,(no_popisek +" A Okouzlil " + GetName(no_oPC) + " ." + "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //"),TRUE);
//SetLocalString(no_Item2,"no_popisek",no_popisek + " A Okouzlil " + GetName(no_oPC) + " ." + "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
ku_SetItemDescription(no_Item2,ku_GetItemDescription(no_Item2) +" A Okouzlil " + GetName(no_oPC) + " ." + "                // ILR " + IntToString(no_iLevel)+ ".lvl , crft. v.:"+ no_verzecraftu+ " //");
SetLocalString(no_Item2, "no_verze_craftu",no_verzecraftu);
SetPlotFlag(no_Item2,1);
SetLocalInt(no_Item2,"no_OCAROVANO",TRUE);
SetLocalInt(no_Item2,"no_OCAROVAVAM",FALSE);
DestroyObject(no_Item);

//no_Item = no_Item2;
} //konec udelej jmeno



//////////////////// nastavi cenu vyrobku  /////////////////////////////////////////
void no_cenavyrobku(object no_Item)
{
if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"tc_cenaItem=" + IntToString(GetLocalInt(no_Item,"tc_cena")) );}
if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"tc_cena kamen=" + IntToString(GetLocalInt(no_Item,"no_cena_kamen")) );}
//SetLocalInt(no_Item,"no_cena_kamen",GetLocalInt(OBJECT_SELF,"tc_cena"));
SetLocalInt(no_Item,"tc_cena",FloatToInt (1.01*GetLocalInt(no_Item,"tc_cena") +1.03* GetLocalInt(no_Item,"no_cena_kamen")) );
}


void no_vynikajicikus(object no_Item)
{
int no_random = d100() - TC_getLevel(no_oPC,TC_ocarovavac);
if (no_random < (TC_dej_vlastnost(TC_ocarovavac,no_oPC)/4+1) ) {
////sance vroby vyjimecneho kusu stoupa s lvlem craftera
if  (GetIsDM(no_oPC)== TRUE) no_random = no_random -50;//DM maji vetsi sanci vyjimecneho kusu
FloatingTextStringOnCreature("Podarilo se ti vyrobit vyjimecny kus !", no_oPC,TRUE);

no_random = Random(30)+1;

switch (no_random)  {
case 1: {
         itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,1+d2());
        AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_COLD),no_Item);
        SetName(no_Item,GetName(no_Item) + "  'Mrazivec'");
        SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

case 2: {
        itemproperty no_ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,1+d2());
        AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),no_Item);
        SetName(no_Item,GetName(no_Item) + "  'Ohnivak'");
        SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 3: {
                    itemproperty no_ip = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Orkomlat'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                    break;}
case 4: {
            itemproperty no_ip = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_COLD),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Draci zub'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 1000);
                   break;}
case 5: {
            itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2);
                   AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                   SetName(no_Item,GetName(no_Item) + "  'Prst bohu'");
                   SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 130);
                   break;}
case 6: {
                    itemproperty no_ip = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6);
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Skretomlat'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                    break;}
case 7: {
            itemproperty no_ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2);
        AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_COLD),no_Item);
        SetName(no_Item,GetName(no_Item) + "  'Mrazilka'");
        SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 500);
                  break;}
case 8: {
            itemproperty no_ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_2);
        AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_ACID),no_Item);
        SetName(no_Item,GetName(no_Item) + "  'Kyselac�'");
        SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 500);
                   break;}
case  9: { itemproperty no_ip =ItemPropertySkillBonus(SKILL_LORE,3+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Vedator'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 10:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_PARRY,1+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Branic'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case  11:  {
        itemproperty no_ip =ItemPropertySkillBonus(SKILL_DISABLE_TRAP,1+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Odpastovac'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 12:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_FEY,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Prach vily'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 13:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Havetak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 14:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Vlastenec'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 15:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GNOME,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Gnomi pomsta'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 16:  {
                 itemproperty no_ip = ItemPropertyACBonusVsSAlign(IP_CONST_ALIGNMENTGROUP_GOOD,1+d2());
                  AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Svinak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 17:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_HOLY),no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zlej prst'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 18:  {
                 itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HALFORC,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'pulorci zub'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 19:  {
                  itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Reptilak'");
                  SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 20:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Vlokodav'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 21:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Cizinco-zabijak'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 22:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba nemrtvaku'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 23:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMAN,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Zhouba lidi'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 24:  {
                itemproperty no_ip =ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2);
                 AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                  SetName(no_Item,GetName(no_Item) + "  'Obrozhouba'");
                 SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

case 25:  {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_LISTEN,3+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Dobrej sluch'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 26:  {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_SEARCH,3+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Hledacek'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 27:  {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_SPOT,3+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Pozorovatel'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 28:  {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_SPELLCRAFT,3+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Odpuzovac magie'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}
case 29:  {
            itemproperty no_ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2);
        AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVisualEffect(ITEM_VISUAL_FIRE),no_Item);
        SetName(no_Item,GetName(no_Item) + "  'Hořící'");
        SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 500);
                   break;}

case 30:  {
            itemproperty no_ip =ItemPropertySkillBonus(SKILL_CONCENTRATION,3+d2());
                    AddItemProperty(DURATION_TYPE_PERMANENT,no_ip,no_Item);
                    SetName(no_Item,GetName(no_Item) + "  'Koncentrator'");
                    SetLocalInt(no_Item,"tc_cena",GetLocalInt(no_Item,"tc_cena")+ 100);
                   break;}

         }//konec switche


       }//konec if vyjimecna vec se podari

}//konec veci navic

// pridavame podle kovu procenta.
void no_udelej_vlastnosti(int no_kov_co_pridavam, int no_kov_pridame_procenta,int barva, object no_Item ) {

//
//V knihovnì x3_inc_string je funkce
//string StringToRGBString(string sString, string sRGB);
//pro pøebarvení textu. Parametr sRGB jsou 3 èíslice RGB 0-7, napø:
//red == "700"
//green == "070"
//blue == "007"
//white == "777"
//black == "000"
//Ale má tam 512 kombinací, take vcelku velká paleta barev.
//Já to pouívám vcelku poøád, ty standardní barvy jsou fakt vyblité a v logu jdou patnì vidìt.

// string LIME = StringToRGBString(LIME,"117");
 string GREEN = StringToRGBString(GREEN,"070");
 string LIME = StringToRGBString(LIME,"117");
 string BLUE = StringToRGBString(BLUE,"007");
 string PALEBLUE = StringToRGBString(PALEBLUE,"006");
 string VIOLET = StringToRGBString(VIOLET,"505");
 string PURPLE = StringToRGBString(PURPLE,"303");
 string SANDY = StringToRGBString(SANDY,"300");
 string DARKRED = StringToRGBString(DARKRED,"700");
 string PINK = StringToRGBString(PINK,"330");
 string LIGHTPINK = StringToRGBString(LIGHTPINK,"220");
 string GREY = StringToRGBString(GREY,"000");

// string GREEN = "<c0Z0>";
// string LIME = "<c0YY> ";
// string BLUE = "<czz0>";
// string PALEBLUE = "<cdd0>";
// string VIOLET = "<cdN>";
// string PURPLE = "<c0Gd>";
// string SANDY = "<c0dG>";
// string DARKRED = "<cy00>";
// string PINK = "<cOdd> ";
// string LIGHTPINK = "<cOdd> ";
// string GREY = "<c00D> ";

switch   (no_kov_co_pridavam){
                  //kyselina
        case 1:  {  switch (no_kov_pridame_procenta) {
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 40: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 60: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 80: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                    break;  }
                        case 100: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        case 120: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_1d10),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                    break;  }
                        case 200: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                    break;  }

                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //elektrika
        case 2:  {  switch (no_kov_pridame_procenta) {
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 40: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 60: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 80: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                    break;  }
                        case 100: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        case 120: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d10),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                    break;  }
                        case 200: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                    break;  }
                        if (barva == TRUE) SetName(no_Item,BLUE + GetName(no_Item));
                        } //konec vnitrniho switche
               break;     }
               // oheň
        case 3:  {  switch (no_kov_pridame_procenta) {
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 40: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 60: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 80: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                    break;  }
                        case 100: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        case 120: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d10),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                    break;  }
                        case 200: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,DARKRED + GetName(no_Item));
               break;     }
               //chlad
        case 4:  {  switch (no_kov_pridame_procenta) {
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 40: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 60: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 80: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                    break;  }
                        case 100: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        case 120: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d10),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                    break;  }
                        case 200: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PALEBLUE + GetName(no_Item));
                break;    }
                //zvuk
        case 5:  {  switch (no_kov_pridame_procenta) {
                        case 20: { FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 40: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 60: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 80: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_2),no_Item);
                                    break;  }
                        case 100: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                    break;  }
                        case 120: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_3),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d8),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d10),no_Item);
                                    break;  }
                        case 200: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d12),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,LIME + GetName(no_Item));
               break;     }
               //ostrost
        case 6:  {  switch (no_kov_pridame_procenta) {
                        case 20: { FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 40: { FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 60: { FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 80: { FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 100: { FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;   }
                        case 120: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),no_Item);
                                    break;  }
                        case 200: {AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,VIOLET + GetName(no_Item));
               break;     }
               //zmrazení 3 kola
        case 7:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 40: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 60: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break; }
                        case 80: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 100: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                  break;  }
                        case 120: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 200: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,SANDY + GetName(no_Item));
               break;     }
               //hluchota
        case 8:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 40: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 60: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break; }
                        case 80: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                  break;  }
                        case 100: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 120: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 200: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,SANDY + GetName(no_Item));
               break;     }
               //omámení
         case 9:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 40: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 60: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break; }
                        case 80: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 100: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 120: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 200: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,SANDY + GetName(no_Item));
               break;     }
               //ticho
        case 10:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 40: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 60: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break; }
                        case 80: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 100: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 120: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 200: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,SANDY + GetName(no_Item));
               break;     }
               //vystrašení
        case 11:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 40: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 60: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break; }
                        case 80: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 100: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 120: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        case 200: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS),no_Item);
                                    break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,SANDY + GetName(no_Item));
               break;     }
               //bonus proti nemrtvým
        case 12:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                     //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,2),no_Item);
                                   break;  }
                   case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti obrům
        case 13:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                     //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_GIANT,2),no_Item);
                                   break;  }
                   case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti drakům
        case 14:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    // AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,2),no_Item);
                                   break;  }
                   case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti orkům
        case 15:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,2),no_Item);
                                   break;  }
                   case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti ještěřenům
        case 16:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,2),no_Item);
                                   break;  }
                     case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti zvěři
        case 17:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,2),no_Item);
                                   break;  }
                     case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti havěť
        case 18:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,2),no_Item);
                                   break;  }
                     case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti skřetoid
        case 19:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,2),no_Item);
                                   break;  }
                     case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti odchylka
        case 20:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,2),no_Item);
                                   break;  }
                        case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //bonus proti měnavec
        case 21:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,2),no_Item);
                                   break;  }
                        case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 60: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,5),no_Item);
                                   break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,6),no_Item);
                                   break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                 //    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,7),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PURPLE + GetName(no_Item));
               break;     }
               //poprava nemrtvý
        case 22:  {  switch (no_kov_pridame_procenta) {  //IP_CONST_RACIALTYPE_UNDEAD
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_UNDEAD),no_Item);
                                        break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_UNDEAD),no_Item);
                                        break;  }
                        case 140: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_UNDEAD),no_Item);
                                      break;  }
                        case 160: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_UNDEAD),no_Item);
                                       break;  }
                        case 180: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_UNDEAD),no_Item);
                                      break;  }
                        case 200:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_RACIALTYPE_UNDEAD),no_Item);
                                     break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava obři
        case 23:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 120:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_GIANT),no_Item);
                                        break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_GIANT),no_Item);
                                      break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_GIANT),no_Item);
                                        break;  }
                        case 180: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_GIANT),no_Item);
                                      break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_GIANT),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava draci
        case 24:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 120:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_DRAGON),no_Item);
                                        break;  }
                        case 140: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_DRAGON),no_Item);
                                      break;  }
                        case 160: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_DRAGON),no_Item);
                                       break;  }
                        case 180: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_DRAGON),no_Item);
                                      break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_DRAGON),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava ork
        case 25:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 120:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_HUMANOID_ORC),no_Item);
                                        break;  }
                        case 140: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_HUMANOID_ORC),no_Item);
                                      break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_HUMANOID_ORC),no_Item);
                                       break;  }
                        case 180: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_HUMANOID_ORC),no_Item);
                                      break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_HUMANOID_ORC),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava ještěřan
        case 26:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN),no_Item);
                                        break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN),no_Item);
                                        break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN),no_Item);
                                      break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN),no_Item);
                                       break;  }
                        case 180: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN),no_Item);
                                      break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //konec mithril
        case 27:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_ANIMAL),no_Item);
                                        break;  }
                        case 120:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_ANIMAL),no_Item);
                                        break;  }
                        case 140: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_ANIMAL),no_Item);
                                      break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_ANIMAL),no_Item);
                                       break;  }
                        case 180: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_ANIMAL),no_Item);
                                      break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_RACIALTYPE_ANIMAL),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }//poprava havět
        case 28:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_VERMIN),no_Item);
                                        break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_VERMIN),no_Item);
                                        break;  }
                        case 140: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_VERMIN),no_Item);
                                      break;  }
                        case 160: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_VERMIN),no_Item);
                                       break;  }
                        case 180: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_VERMIN),no_Item);
                                      break;  }
                        case 200:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_RACIALTYPE_VERMIN),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava skřetoid
        case 29:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 120:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID),no_Item);
                                        break;  }
                        case 140: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID),no_Item);
                                      break;  }
                        case 160: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID),no_Item);
                                       break;  }
                        case 180: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID),no_Item);
                                      break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava odchylka
        case 30:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_ABERRATION),no_Item);
                                        break;  }
                        case 120:{    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_ABERRATION),no_Item);
                                        break;  }
                        case 140: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_ABERRATION),no_Item);
                                        break;  }
                        case 160: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_ABERRATION),no_Item);
                                        break;  }
                        case 180: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_ABERRATION),no_Item);
                                        break;  }
                        case 200:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_RACIALTYPE_ABERRATION),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //poprava měňavec
        case 31:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 80: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 100: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_RACIALTYPE_SHAPECHANGER),no_Item);
                                        break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_RACIALTYPE_SHAPECHANGER),no_Item);
                                        break;  }
                        case 140: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_RACIALTYPE_SHAPECHANGER),no_Item);
                                        break;  }
                        case 160: {     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_RACIALTYPE_SHAPECHANGER),no_Item);
                                       break;  }
                        case 180: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_RACIALTYPE_SHAPECHANGER),no_Item);
                                       break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_SLAYRACE,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_RACIALTYPE_SHAPECHANGER),no_Item);
                                      break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREY + GetName(no_Item));
               break;     }
               //proti zlý
        case 32:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,2),no_Item);
                                   break;  }
                        case 60: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 160: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        case 200:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,LIME+ GetName(no_Item));
               break;     }
               //proti dobrý
        case 33:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                     //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,2),no_Item);
                                   break;  }
                        case 60: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 160: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        case 200:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_GOOD,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,DARKRED+ GetName(no_Item));
               break;     }
               //proti zákonný
        case 34:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 60: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 160: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        case 200:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,VIOLET + GetName(no_Item));
               break;     }
               //proti zmatený
        case 35:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 60: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 80: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,3),no_Item);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                   break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,4),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 160: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                  //   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,5),no_Item);
                                   break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        case 200:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC,IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                   //  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyEnhancementBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,6),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,VIOLET + GetName(no_Item));
               break;     }
               //upíří obnovení
        case 36:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 40: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 60: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 80: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                   break;  }
                        case 100: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(1),no_Item);
                                     break;  }
                        case 120:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(2),no_Item);
                                      break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(3),no_Item);
                                     break;  }
                        case 160: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(4),no_Item);
                                     break;  }
                        case 180: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(5),no_Item);
                                      break;  }
                        case 200:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyVampiricRegeneration(6),no_Item);
                                     break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,DARKRED + GetName(no_Item));
               break;     }
               //cizinci
        case 37:  {  switch (no_kov_pridame_procenta) {
                        case 20: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1),no_Item);
                                    break;  }
                        case 40: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2),no_Item);
                                     break;  }
                        case 60: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d4),no_Item);
                                    break;  }
                        case 80: {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_3),no_Item);
                                     break;  }
                        case 100: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6),no_Item);
                                     break;  }
                        case 120:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4),no_Item);
                                    break;  }
                        case 140: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d6),no_Item);
                                      break;  }
                        case 160:  {  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d8),no_Item);
                                    break;  }
                        case 180: { AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d10),no_Item);
                                     break;  }
                        case 200:{  AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d12),no_Item);
                                     break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,DARKRED + GetName(no_Item));
               break;     }
               //zraňující
        case 38:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                  break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_14),no_Item);
                                  break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_14),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_16),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_18),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_20),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_22),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING,IP_CONST_ONHIT_SAVEDC_24),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,PINK + GetName(no_Item));
               break;     }
               //rozptyl kouzel
        case 39:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {          FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_14),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_16),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_18),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_20),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_22),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL,IP_CONST_ONHIT_SAVEDC_24),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,VIOLET + GetName(no_Item));
               break;     }
               //otrava síla
        case 40:  {  switch (no_kov_pridame_procenta) {
                           case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_STRDAMAGE),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                        if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //otrava inteligence
        case 41:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_INTDAMAGE),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //otrava moudrost
        case 42:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_WISDAMAGE),no_Item);
                                   break;  }
                } //konec vnitrniho switche
                 if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //otrava charisma
        case 43:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_CHADAMAGE),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //otrava obratnost
        case 44:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_DEXDAMAGE),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //otrava odolnost
        case 45:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_POISON_1D2_CONDAMAGE),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,GREEN + GetName(no_Item));
               break;     }
               //vysátí
        case 46:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {  FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 100: {FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 120:{FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                    break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN,IP_CONST_ONHIT_SAVEDC_14),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN,IP_CONST_ONHIT_SAVEDC_16),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN,IP_CONST_ONHIT_SAVEDC_18),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN,IP_CONST_ONHIT_SAVEDC_20),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,PALEBLUE + GetName(no_Item));
               break;     }
               //otrava
        case 47:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ABILITY_STR),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ABILITY_STR),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ABILITY_STR),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ABILITY_STR),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ABILITY_STR),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ABILITY_STR),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ABILITY_STR),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,LIGHTPINK + GetName(no_Item));
               break;     }
               //otrava
        case 48:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ABILITY_INT),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ABILITY_INT),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ABILITY_INT),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ABILITY_INT),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ABILITY_INT),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ABILITY_INT),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ABILITY_INT),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,LIGHTPINK + GetName(no_Item));
               break;     }
               //otrava
        case 49:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ABILITY_WIS),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ABILITY_WIS),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ABILITY_WIS),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ABILITY_WIS),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ABILITY_WIS),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ABILITY_WIS),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ABILITY_WIS),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,LIGHTPINK + GetName(no_Item));
               break;     }
               //otrava
        case 50:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ABILITY_CHA),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ABILITY_CHA),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ABILITY_CHA),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ABILITY_CHA),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ABILITY_CHA),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ABILITY_CHA),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ABILITY_CHA),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,LIGHTPINK + GetName(no_Item));
               break;     }
               //otrava
        case 51:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ABILITY_DEX),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ABILITY_DEX),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ABILITY_DEX),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ABILITY_DEX),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ABILITY_DEX),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ABILITY_DEX),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ABILITY_DEX),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,LIGHTPINK + GetName(no_Item));
               break;     }
               //otrava
        case 52:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 40: {    FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                        break;  }
                        case 60: {      FloatingTextStringOnCreature("Tato vlastnost se nestihla projevit, asi bude nutne pouzit vice % ",no_oPC,FALSE);
                                       break;  }
                        case 80: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_14,IP_CONST_ABILITY_CON),no_Item);
                                   break;  }
                        case 100: {        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_16,IP_CONST_ABILITY_CON),no_Item);
                                   break;  }
                        case 120:{     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_18,IP_CONST_ABILITY_CON),no_Item);
                                  break;  }
                        case 140: {      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_20,IP_CONST_ABILITY_CON),no_Item);
                                  break;  }
                        case 160: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_22,IP_CONST_ABILITY_CON),no_Item);
                                  break;  }
                        case 180: {       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_24,IP_CONST_ABILITY_CON),no_Item);
                                  break;  }
                        case 200:{       AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN,IP_CONST_ONHIT_SAVEDC_26,IP_CONST_ABILITY_CON),no_Item);
                                   break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,LIGHTPINK + GetName(no_Item));
               break;     }
               //snížení hmotnosti
        case 53:  {  switch (no_kov_pridame_procenta) {
                        case 20: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT),no_Item);
                                   //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT);
                                        break;  }
                        case 40: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT),no_Item);
                                    // ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT);
                                       break;  }
                        case 60: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT),no_Item);
                                    //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_40_PERCENT);
                                       break;  }
                        case 80: {       //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_60_PERCENT);
                                         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_20_PERCENT),no_Item);
                                       break;  }
                        case 100: {     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                                     //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);
                                       break;  }
                        case 120:{AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                                      //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);
                                       break;  }
                        case 140: {   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                        //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);
                                       break;  }
                        case 160: {
                        AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                        //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);
                                        break;  }
                        case 180: {    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                        //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);
                                       break;  }
                        case 200:{   AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_10_PERCENT),no_Item);
                        //ItemPropertyWeightReduction(IP_CONST_REDUCEDWEIGHT_80_PERCENT);
                                       break;  }
                        } //konec vnitrniho switche
                         if (barva == TRUE) SetName(no_Item,PINK + GetName(no_Item));
               break;     }


}// switch no_kov_pridame_procenta

} //konec pridavani vlastnosti

void no_udelej_vzhled(object no_Item)
{
}


void no_udelejocarovani(object no_Item)
{
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"Vyrabim ocarovani" );
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"Vyrabim ocarovani-no_kamen   " + IntToString(GetLocalInt(no_Item,"no_kamen")) + "  " + IntToString(GetLocalInt(no_Item,"no_hl_mat")));
  if ( NO_oc_DEBUG == TRUE )  SendMessageToPC(no_oPC,"Vyrabim ocarovani-no_kamen2   " + IntToString(GetLocalInt(no_Item,"no_kamen2")) +"  " + IntToString(GetLocalInt(no_Item,"no_ve_mat")));


//SetLocalInt(no_Item,"no_ve_mat",GetLocalInt(OBJECT_SELF,"no_ve_mat"));
//SetLocalInt(no_Item,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_hl_mat"));
// pridavame podle kovu procenta.                                                    ///TRUE = barva
  int iMat1 = GetLocalInt(no_Item,"no_hl_mat");
  int iMat2 = GetLocalInt(no_Item,"no_ve_mat");
  int iPower1 = GetLocalInt(no_Item,"no_kamen");
  int iPower2 = GetLocalInt(no_Item,"no_kamen2");
  int iMaxPower = __ocGetMaxEnchantmentBaseItem(GetBaseItemType(no_Item))*10;

  if ( NO_oc_DEBUG ) {
    SendMessageToPC(no_oPC,"DEBUG: Item "+GetName(no_Item)+" kamen1:("+IntToString(iMat1)+":"+IntToString(iPower1)+") Maxpower: "+IntToString(iMaxPower));
    SendMessageToPC(no_oPC,"DEBUG: Item "+GetName(no_Item)+" kamen2:("+IntToString(iMat2)+":"+IntToString(iPower2)+") Maxpower: "+IntToString(iMaxPower));
  }

  /* Safety */
  if(__GetIsLimitedByWeapon(iMat1))
    if(iPower1 > iMaxPower)
      iPower1 = iMaxPower;

  if(__GetIsLimitedByWeapon(iMat2))
    if(iPower1 + iPower2 > iMaxPower)
      iPower2 = iMaxPower - iPower1;

  if ( NO_oc_DEBUG ) {
    SendMessageToPC(no_oPC,"DEBUG: Item "+GetName(no_Item)+" kamen1:("+IntToString(iMat1)+":"+IntToString(iPower1)+") Maxpower: "+IntToString(iMaxPower));
    SendMessageToPC(no_oPC,"DEBUG: Item "+GetName(no_Item)+" kamen2:("+IntToString(iMat2)+":"+IntToString(iPower2)+") Maxpower: "+IntToString(iMaxPower));
  }

  no_udelej_vlastnosti(iMat1, iPower1, TRUE, no_Item);
  no_udelej_vlastnosti(iMat2, iPower2, FALSE, no_Item);

//kdyz neni druhy jako prvni material, tak udelame maxprocenta-hl.mat.procenta vlastnosti.

  no_vynikajicikus(no_Item);
  no_cenavyrobku(no_Item);

  //udelje jmeno musi byt posledni kvuli BUGu s set description
  no_udelejjmeno(no_Item);
}



/////////zacatek zavadeni funkci//////////////////////////////////////////////
void no_snizstack(object no_Item, int no_mazani)
{
int no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
  if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                           if (no_mazani == TRUE) DestroyObject(no_Item);

                    }
    else   {  if (no_mazani == TRUE) { //DestroyObject(no_Item);
              //FloatingTextStringOnCreature(" Tolikati prisad nebylo zapotrebi ",no_oPC,FALSE );
              SetItemStackSize(no_Item,no_stacksize-1);
              } }
}


//////////////////////////////////////////////////////////////////////
//////////zacatek zjistovani co je vevnitr////////////////////////////
/////////////////////////////////////////////////////////////////////




void no_kamen( object no_pec, int no_mazani) {
///////////////////////////////////////////
//// vystup:  no_forma
//////
////////////////////////////////////////////
  object no_Item2 = GetFirstItemInInventory(no_pec);
  while(GetIsObjectValid(no_Item2))  {

    if ( (GetStringLeft(GetTag(no_Item2),11) == "no_oc_kame_") &&
         (StringToInt(GetStringRight(GetTag(no_Item2),3)) > 0)   ) {
      int no_co_mame_za_kamen = StringToInt(GetStringRight(GetTag(no_Item2),3));
      if ( NO_oc_DEBUG == TRUE )
        SendMessageToPC(no_oPC,"kamen pred upravou" + IntToString( no_co_mame_za_kamen) );
      no_co_mame_za_kamen = no_co_mame_za_kamen/20;
      no_co_mame_za_kamen = no_co_mame_za_kamen*20;
      if ( NO_oc_DEBUG == TRUE )
        SendMessageToPC(no_oPC,"kamen po uprave" + IntToString( no_co_mame_za_kamen) );

      SetLocalInt(OBJECT_SELF,"no_kamen",no_co_mame_za_kamen);
      no_snizstack(no_Item2,no_mazani);
      SetLocalInt(OBJECT_SELF,"no_cena_kamen",GetLocalInt(no_Item2,"tc_cena"));
      //SetLocalInt(no_Item,"no_cena_kamen",GetLocalInt(OBJECT_SELF,"tc_cena"));
      if (no_mazani == TRUE) {

          int no_level = TC_getLevel(no_oPC,TC_ocarovavac);  // TC kovar = 33
          int no_menu_max_procent = __ocGetPercentsFromLevel(no_level);


        if (__GetIsLimitedByWeapon(GetLocalInt(OBJECT_SELF,"no_hl_mat")) ||
            __GetIsLimitedByWeapon(GetLocalInt(OBJECT_SELF,"no_ve_mat"))) {

          int iMaxPerc = __ocGetMaxEnchantment(GetLocalString(OBJECT_SELF,"no_druh_vyrobku"));
          if(no_menu_max_procent > iMaxPerc) {
            no_menu_max_procent = iMaxPerc;
            FloatingTextStringOnCreature("Do teto zbrane neni mozne vlozit tolik ocarovani ! Bude pouzito prvnich "+IntToString(iMaxPerc)+"0%" ,no_oPC,FALSE );
          }

        }// pokud mame na zbrani vybrany element

  ///kamen je vetsi, nez maximum co umim, takze zkrouhnu kamen na maximum
        if ( (no_menu_max_procent*10) < no_co_mame_za_kamen) {
          no_co_mame_za_kamen = no_menu_max_procent*10; //krouhavam kamen na maximum co umim
          int no_hl_proc =  GetLocalInt(OBJECT_SELF,"no_hl_proc")*10;

          if (no_hl_proc> no_co_mame_za_kamen)
            no_hl_proc = no_co_mame_za_kamen;
            //tedy kdyz jsou nastavene vysoke procenta, ale mame je zkrouhnute zbrani trebas.
          int no_co_mame_za_kamen2 = 0;
          if ( NO_oc_DEBUG == TRUE )
            SendMessageToPC(no_oPC,"(no_menu_max_procent*10) < no_co_mame_za_kamen)" );

          no_co_mame_za_kamen2 = no_co_mame_za_kamen - no_hl_proc;
          no_co_mame_za_kamen = no_hl_proc;
          if(no_hl_proc == 200)
            no_co_mame_za_kamen2 = no_co_mame_za_kamen-180; //TODO Why is that?

          if (no_co_mame_za_kamen2>0) {
            if (no_mazani == TRUE) {
              FloatingTextStringOnCreature("Tenhle kamen je silny, bude pouzit jako: " +IntToString(no_co_mame_za_kamen)+"%"+GetLocalString(OBJECT_SELF,"no_menu_nazev_kovu")+" "+IntToString(no_co_mame_za_kamen2)+"% "+ GetLocalString(OBJECT_SELF,"no_menu_nazev_kovu2") ,no_oPC, FALSE);
            }
          }

          if (no_co_mame_za_kamen2==0)  {
            if (no_mazani == TRUE) {
              FloatingTextStringOnCreature("Tenhle kamen je silny, bude pouzit jako: " +IntToString(no_co_mame_za_kamen)+"%"+GetLocalString(OBJECT_SELF,"no_menu_nazev_kovu") ,no_oPC, FALSE);
            }
          }

          SetLocalInt(OBJECT_SELF,"no_kamen",no_co_mame_za_kamen);
          SetLocalInt(OBJECT_SELF,"no_kamen2",no_co_mame_za_kamen2);
        }//kdyz duse mensi, nez max procent

  // kamen je maly, nedosahnu na maximum, takze musim snizit % co to umi.
        else if ( (no_menu_max_procent*10) > no_co_mame_za_kamen) {
          int no_hl_proc =  GetLocalInt(OBJECT_SELF,"no_hl_proc")*10;
          //kamen je maly, ze dosahne stezi jen na hlavni material.
          if ( no_co_mame_za_kamen<=(no_hl_proc) ) {
            if ( NO_oc_DEBUG == TRUE ) {
              SendMessageToPC(no_oPC,"( no_co_mame_za_kamen<=(no_hl_proc) ) " );
            }
            no_co_mame_za_kamen = (no_co_mame_za_kamen / 20) * 20; //Floor to 20 steps
            if(no_co_mame_za_kamen > 200)
              no_co_mame_za_kamen = 200;

            if (no_mazani == TRUE) {
              FloatingTextStringOnCreature("Tenhle kamen je slabsi, bude pouzit jen jako: " + IntToString(no_co_mame_za_kamen) + "%" + GetLocalString(OBJECT_SELF,"no_menu_nazev_kovu"),no_oPC, FALSE);
            }

            SetLocalInt(OBJECT_SELF,"no_kamen",no_co_mame_za_kamen);
            SetLocalInt(OBJECT_SELF,"no_kamen2",0);
          }
          //kamen je maly,ale dosahne i na hlavni, i na vedeljsi material
          else if ( no_co_mame_za_kamen >(no_hl_proc) ) {
            int no_co_mame_za_kamen2;
            if ( NO_oc_DEBUG == TRUE )
              SendMessageToPC(no_oPC,"no_co_mame_za_kamen >(no_hl_proc)" );

              no_co_mame_za_kamen2 = no_co_mame_za_kamen - no_hl_proc;
              no_co_mame_za_kamen = no_hl_proc;

            if (no_mazani == TRUE) {
              FloatingTextStringOnCreature("Tenhle kamen je slabsi, bude pouzit jen jako: " +IntToString(no_co_mame_za_kamen)+"%"+GetLocalString(OBJECT_SELF,"no_menu_nazev_kovu")+" "+IntToString(no_co_mame_za_kamen2)+"% "+ GetLocalString(OBJECT_SELF,"no_menu_nazev_kovu2") ,no_oPC, FALSE);
            }
            SetLocalInt(OBJECT_SELF,"no_kamen",no_co_mame_za_kamen);
            SetLocalInt(OBJECT_SELF,"no_kamen2",no_co_mame_za_kamen2);

          }

        }//kdyz duse mensi, nez max procent


      }// if (no_mazani == TRUE)

      break;
    }
    no_Item2 = GetNextItemInInventory(no_pec);
  }
}


int __getIsItemAllowedForEnchantment(object oItem) {
  string sTag = GetTag(oItem);

  // Not stones?
  if(GetStringRight(sTag,2) == "00")
    return FALSE;
  // Not already enchanted items
  if(GetLocalInt(oItem,"no_OCAROVANO") )
    return FALSE;
  // Weapons
  if((GetStringLeft(sTag,6) == "no_zb_") &&
     (GetStringLeft(GetResRef(oItem),10) != "no_zb_pris"))
    return TRUE;
  // Gloves
  if((GetStringLeft(sTag,6) == "no_pl_") ||
     (GetStringLeft(sTag,6) == "no_si_") ) {
    if(GetBaseItemType(oItem) == BASE_ITEM_GLOVES)
      return TRUE;
  }
  return FALSE;
}


void no_vyrobek (object no_Item, object no_pec, int no_mazani)
// nastavi promennou no_vyrobek  na int cislo vyrobku, string tag veci.
{
  no_Item = GetFirstItemInInventory(no_pec);
  while(GetIsObjectValid(no_Item))  {
    string sTag = GetTag(no_Item);

    if(__getIsItemAllowedForEnchantment(no_Item)) {

/////////////mame dokoncenou zbran
      SetLocalString(OBJECT_SELF,"no_vyrobek",GetTag(no_Item));  // ulozime tag veci!!
      SetLocalObject(OBJECT_SELF,"no_vyrobek",no_Item);

      //druh vyrobku, podle toho my urcime, kolik % se tam vejde.
      string no_druh_vyrobku = GetStringLeft(GetTag(no_Item),8);
      // budem do nej ukaladat co to ma za tip
      no_druh_vyrobku = GetStringRight(no_druh_vyrobku,2);
      SetLocalString(OBJECT_SELF,"no_druh_vyrobku",no_druh_vyrobku);


      // no_snizstack(no_Item,no_mazani);                          //znicime prisadu
      break;
    }

/*  //Rukavice ne
    if ((GetStringRight(GetTag(no_Item),5) != "00_00")&(GetStringLeft(GetTag(no_Item),8) == "no_si_r2")&(GetLocalInt(no_Item,"no_OCAROVANO") == FALSE))
     {////////////////////bojove rukavice sou taky koser (.
      SetLocalString(OBJECT_SELF,"no_vyrobek",GetTag(no_Item));  // ulozime tag veci!!
      SetLocalObject(OBJECT_SELF,"no_vyrobek",no_Item);
    // no_snizstack(no_Item,no_mazani);                          //znicime prisadu
      break;
    }
*/
  no_Item = GetNextItemInInventory(no_pec);
  }//tak uz mame sperk

}




////////z kovariny prevzate preotevreni pece s upravami  ////////////////////////////////////////
void no_reopen(object no_oPC)
{
AssignCommand(no_oPC,DelayCommand(0.2,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE)));
//   AssignCommand(oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(oSelf),oPC,1),PLACEABLE_ACTION_USE)));
}


////////Znici tlacitka z inventare ///////////////////////
void no_znicit(object no_oPC)
{
no_Item = GetFirstItemInInventory(no_oPC);

 while (GetIsObjectValid(no_Item)) {

 if  (GetStringLeft(GetResRef(no_Item),10) != "prepinac00")
 {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 001 - 003
 }
 DestroyObject(no_Item);
 no_Item = GetNextItemInInventory(no_oPC);
}

//no_Item = GetFirstItemInInventory(no_oPC);
// while (GetIsObjectValid(no_Item)) {
//
// if(GetResRef(no_Item) != "prepinac003") {
// no_Item = GetNextItemInInventory(no_oPC);
// continue;     //znicim vsechny prepinace 003
// }
// DestroyObject(no_Item);
// no_Item = GetNextItemInInventory(no_oPC);
//}
}

void no_reknimat(object no_oPC)
// rekne kolik procent je jakeho materialu
{
int no_level = TC_getLevel(no_oPC,TC_ocarovavac);  // TC kovar = 33
string no_menu_nazev_kovu;
string no_menu_nazev_kovu2;
string no_menu_nazev_procenta;
string no_menu_nazev_procenta2;
int no_menu_max_procent = 10;

//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl
         if (no_level >16) {
         no_menu_max_procent = 20;  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_max_procent = 18;  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_max_procent = 16;  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_max_procent = 14;  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_max_procent = 12;  }
         else if ((no_level <5)) {
         no_menu_max_procent = 10;  }


//if (GetLocalInt(OBJECT_SELF,"no_hl_proc")  < no_menu_max_procent/2 )
//{
//jinak nepozna, ze ktereho stacku ma odecist pruty
//int no_menu_hlavni_material = GetLocalInt(OBJECT_SELF,"no_hl_mat");
//SetLocalInt(OBJECT_SELF,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_ve_mat"));
//SetLocalInt(OBJECT_SELF,"no_hl_proc",(no_menu_max_procent - GetLocalInt(OBJECT_SELF,"no_hl_proc"))  );
//SetLocalInt(OBJECT_SELF,"no_ve_mat",no_menu_hlavni_material);
//if (NO_oc_DEBUG == TRUE) { SendMessageToPC(no_oPC,"Reknutim co to je za material prehazujem" );   }
//}

switch (GetLocalInt(OBJECT_SELF,"no_hl_mat")) {
case 0: {no_menu_nazev_kovu = "kyselina";
         SetLocalInt(OBJECT_SELF,"no_hl_mat",1); break;}
case 1: {no_menu_nazev_kovu = "kyselina";    break;}
case 2: {no_menu_nazev_kovu = "elektrina";   break;}
case 3: {no_menu_nazev_kovu = "ohen";   break;}
case 4: {no_menu_nazev_kovu = "chlad";   break;}
case 5: {no_menu_nazev_kovu = "zvuk";   break;}
case 6: {no_menu_nazev_kovu = "ostrost";   break;}
case 7: {no_menu_nazev_kovu = "drzeni";   break;}
case 8: {no_menu_nazev_kovu = "hluchota";   break;}
case 9: {no_menu_nazev_kovu = "omameni";   break;}
case 10: {no_menu_nazev_kovu = "ticho";   break;}
case 11: {no_menu_nazev_kovu = "strach";   break;}
case 12: {no_menu_nazev_kovu = "zhouba nemrtvych";   break;}
case 13: {no_menu_nazev_kovu = "zhouba obru";   break;}
case 14: {no_menu_nazev_kovu = "zhouba draku";   break;}
case 15: {no_menu_nazev_kovu = "zhouba orku";   break;}
case 16: {no_menu_nazev_kovu = "zhouba jesteru";   break;}
case 17: {no_menu_nazev_kovu = "zhouba zvirat";   break;}
case 18: {no_menu_nazev_kovu = "zhouba hmyzu";   break;}
case 19: {no_menu_nazev_kovu = "zhouba skretu";   break;}
case 20: {no_menu_nazev_kovu = "zhouba odchylek";   break;}
case 21: {no_menu_nazev_kovu = "zhouba menavcu";   break;}
case 22: {no_menu_nazev_kovu = "poprava nemrtvych";   break;}
case 23: {no_menu_nazev_kovu = "poprava obru";   break;}
case 24: {no_menu_nazev_kovu = "poprava draku";   break;}
case 25: {no_menu_nazev_kovu = "poprava orku";   break;}
case 26: {no_menu_nazev_kovu = "poprava jesteru";   break;}
case 27: {no_menu_nazev_kovu = "poprava zvirat";   break;}
case 28: {no_menu_nazev_kovu = "poprava hmyzu";   break;}
case 29: {no_menu_nazev_kovu = "poprava skretu";   break;}
case 30: {no_menu_nazev_kovu = "poprava odchylek";   break;}
case 31: {no_menu_nazev_kovu = "poprava menavcu";   break;}
case 32: {no_menu_nazev_kovu = "svaty";   break;}
case 33: {no_menu_nazev_kovu = "bezbozny";   break;}
case 34: {no_menu_nazev_kovu = "chaoticky";   break;}
case 35: {no_menu_nazev_kovu = "zakonny";   break;}
case 36: {no_menu_nazev_kovu = "upiri";   break;}
case 37: {no_menu_nazev_kovu = "vlastenec";   break;}
case 38: {no_menu_nazev_kovu = "zranujici";   break;}
case 39: {no_menu_nazev_kovu = "rusici";   break;}
case 40: {no_menu_nazev_kovu = "jed orku";   break;}
case 41: {no_menu_nazev_kovu = "jed magu";   break;}
case 42: {no_menu_nazev_kovu = "jed knezu";   break;}
case 43: {no_menu_nazev_kovu = "jed assimaru";   break;}
case 44: {no_menu_nazev_kovu = "jed elfu";   break;}
case 45: {no_menu_nazev_kovu = "jed gnomu";   break;}
case 46: {no_menu_nazev_kovu = "osalbujici";   break;}
case 47: {no_menu_nazev_kovu = "prokleti orku";   break;}
case 48: {no_menu_nazev_kovu = "prokleti magu";   break;}
case 49: {no_menu_nazev_kovu = "prokleti knezu";   break;}
case 50: {no_menu_nazev_kovu = "prokleti assimaru";   break;}
case 51: {no_menu_nazev_kovu = "prokleti elfu";   break;}
case 52: {no_menu_nazev_kovu = "prokleti gnomu";   break;}
case 53: {no_menu_nazev_kovu = "odlehceny";   break;}
}

switch (GetLocalInt(OBJECT_SELF,"no_ve_mat")) {
case 0: {no_menu_nazev_kovu2 = "kyselina";
         SetLocalInt(OBJECT_SELF,"no_hl_mat",1); break;}
case 1: {no_menu_nazev_kovu2 = "kyselina";    break;}
case 2: {no_menu_nazev_kovu2 = "elektrina";   break;}
case 3: {no_menu_nazev_kovu2 = "ohen";   break;}
case 4: {no_menu_nazev_kovu2 = "chlad";   break;}
case 5: {no_menu_nazev_kovu2 = "zvuk";   break;}
case 6: {no_menu_nazev_kovu2 = "ostrost";   break;}
case 7: {no_menu_nazev_kovu2 = "drzeni";   break;}
case 8: {no_menu_nazev_kovu2 = "hluchota";   break;}
case 9: {no_menu_nazev_kovu2 = "omameni";   break;}
case 10: {no_menu_nazev_kovu2 = "ticho";   break;}
case 11: {no_menu_nazev_kovu2 = "strach";   break;}
case 12: {no_menu_nazev_kovu2 = "zhouba nemrtvych";   break;}
case 13: {no_menu_nazev_kovu2 = "zhouba obru";   break;}
case 14: {no_menu_nazev_kovu2 = "zhouba draku";   break;}
case 15: {no_menu_nazev_kovu2 = "zhouba orku";   break;}
case 16: {no_menu_nazev_kovu2 = "zhouba jesteru";   break;}
case 17: {no_menu_nazev_kovu2 = "zhouba zvirat";   break;}
case 18: {no_menu_nazev_kovu2 = "zhouba hmyzu";   break;}
case 19: {no_menu_nazev_kovu2 = "zhouba skretu";   break;}
case 20: {no_menu_nazev_kovu2 = "zhouba odchylek";   break;}
case 21: {no_menu_nazev_kovu2 = "zhouba menavcu";   break;}
case 22: {no_menu_nazev_kovu2 = "poprava nemrtvych";   break;}
case 23: {no_menu_nazev_kovu2 = "poprava obru";   break;}
case 24: {no_menu_nazev_kovu2 = "poprava draku";   break;}
case 25: {no_menu_nazev_kovu2 = "poprava orku";   break;}
case 26: {no_menu_nazev_kovu2 = "poprava jesteru";   break;}
case 27: {no_menu_nazev_kovu2 = "poprava zvirat";   break;}
case 28: {no_menu_nazev_kovu2 = "poprava hmyzu";   break;}
case 29: {no_menu_nazev_kovu2 = "poprava skretu";   break;}
case 30: {no_menu_nazev_kovu2 = "poprava odchylek";   break;}
case 31: {no_menu_nazev_kovu2 = "poprava menavcu";   break;}
case 32: {no_menu_nazev_kovu2 = "svaty";   break;}
case 33: {no_menu_nazev_kovu2 = "bezbozny";   break;}
case 34: {no_menu_nazev_kovu2 = "chaoticky";   break;}
case 35: {no_menu_nazev_kovu2 = "zakonny";   break;}
case 36: {no_menu_nazev_kovu2 = "upiri";   break;}
case 37: {no_menu_nazev_kovu2 = "vlastenec";   break;}
case 38: {no_menu_nazev_kovu2 = "zranujici";   break;}
case 39: {no_menu_nazev_kovu2 = "rusici";   break;}
case 40: {no_menu_nazev_kovu2 = "jed orku";   break;}
case 41: {no_menu_nazev_kovu2 = "jed magu";   break;}
case 42: {no_menu_nazev_kovu2 = "jed knezu";   break;}
case 43: {no_menu_nazev_kovu2 = "jed assimaru";   break;}
case 44: {no_menu_nazev_kovu2 = "jed elfu";   break;}
case 45: {no_menu_nazev_kovu2 = "jed gnomu";   break;}
case 46: {no_menu_nazev_kovu2 = "osalbujici";   break;}
case 47: {no_menu_nazev_kovu2 = "prokleti orku";   break;}
case 48: {no_menu_nazev_kovu2 = "prokleti magu";   break;}
case 49: {no_menu_nazev_kovu2 = "prokleti knezu";   break;}
case 50: {no_menu_nazev_kovu2 = "prokleti assimaru";   break;}
case 51: {no_menu_nazev_kovu2 = "prokleti elfu";   break;}
case 52: {no_menu_nazev_kovu2 = "prokleti gnomu";   break;}
case 53: {no_menu_nazev_kovu2 = "odlehceny";   break;}
}
//100- prirad 200%         tag:no_men_20    // 17lvl
//99 - prirad 180%         tag:no_men_18    // 14lvl
//98 - prirad 160%         tag:no_men_16    // 11lvl
//97 - prirad 140%         tag:no_men_14    // 8lvl
//96 - prirad 120%         tag:no_men_12    // 5lvl

switch (GetLocalInt(OBJECT_SELF,"no_hl_proc")) {
case 0: {// int no_level = TC_getLevel(no_oPC,TC_kovar);  // TC kovar = 33
         if (no_level >16) {
         no_menu_nazev_procenta = "200";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",20);  }
         else if ((no_level <17)&(no_level>13 )) {
         no_menu_nazev_procenta = "180";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",18);  }
         else if ((no_level <14)&(no_level>10 )) {
         no_menu_nazev_procenta = "160";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",16);  }
         else if ((no_level <11)&(no_level>7 )) {
         no_menu_nazev_procenta = "140";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",14);  }
         else if ((no_level <8)&(no_level>4 )) {
         no_menu_nazev_procenta = "120";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",12);  }
         else if ((no_level <5)) {
         no_menu_nazev_procenta = "100";
         SetLocalInt(OBJECT_SELF,"no_hl_proc",10);  }
         break;}
case 20: {no_menu_nazev_procenta = "200";    break;}
case 18: {no_menu_nazev_procenta = "180";    break;}
case 16: {no_menu_nazev_procenta = "160";    break;}
case 14: {no_menu_nazev_procenta = "140";    break;}
case 12: {no_menu_nazev_procenta = "120";    break;}
case 10: {no_menu_nazev_procenta = "100";    break;}
case 8: {no_menu_nazev_procenta = "80";   break;}
case 6: {no_menu_nazev_procenta = "60";   break;}
case 4: {no_menu_nazev_procenta = "40";   break;}
case 2: {no_menu_nazev_procenta = "20";   break;}
}


if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta=" + no_menu_nazev_procenta );}

no_menu_nazev_procenta2 =IntToString( 10*no_menu_max_procent - StringToInt(no_menu_nazev_procenta));

if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"no_menu_nazev_procenta2=" + no_menu_nazev_procenta2 );}

if ((no_menu_nazev_kovu!=no_menu_nazev_kovu2)&(StringToInt(no_menu_nazev_procenta)!=10*no_menu_max_procent))  {

FloatingTextStringOnCreature("Zvolene ocarovani je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu + " a " + no_menu_nazev_procenta2 + "%" + no_menu_nazev_kovu2,no_oPC,FALSE );
SetLocalString(OBJECT_SELF,"no_menu_nazev_kovu",no_menu_nazev_kovu);
SetLocalString(OBJECT_SELF,"no_menu_nazev_kovu2",no_menu_nazev_kovu2);
}
if  ((no_menu_nazev_kovu==no_menu_nazev_kovu2) || (StringToInt(no_menu_nazev_procenta)==10*no_menu_max_procent)) {
no_menu_nazev_procenta = IntToString(10*no_menu_max_procent);
FloatingTextStringOnCreature("Zvolene ocarovani je: "+no_menu_nazev_procenta + "% " +no_menu_nazev_kovu ,no_oPC,FALSE );
if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"(no_menu_nazev_procenta2== 0");}
SetLocalString(OBJECT_SELF,"no_menu_nazev_kovu",no_menu_nazev_kovu);
SetLocalString(OBJECT_SELF,"",no_menu_nazev_kovu2);
}



}


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);
PlaySound("al_mg_crystalic1");
DelayCommand(6.0,PlaySound("al_mg_crystalic1"));
  location locAnvil = GetLocation(OBJECT_SELF);
  vector vEffectPos = GetPositionFromLocation(locAnvil);
  vEffectPos.z += 1.0;
  location locEffect = Location( GetAreaFromLocation(locAnvil), vEffectPos,GetFacingFromLocation(locAnvil) );

  DelayCommand(1.0, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PARALYZE_HOLD), locEffect));
 // DelayCommand(1.7, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_HIT_SONIC,FALSE), locEffect));
  DelayCommand(2.4, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PARALYZE_HOLD), locEffect));
//  DelayCommand(3.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SOUND_BURST,FALSE),locEffect));
  DelayCommand(3.8, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN), locEffect));
//  DelayCommand(4.6,ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SOUND_BURST), locEffect));
  DelayCommand(5.9, ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), locEffect));

AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.5, no_oc_delay));

    AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_oc_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_oc_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));

// PlaySound("al_mg_crystalic1");
}


void no_vytvorprocenta( object no_oPC, float no_procenta, object no_Item)
//////////////prida procenta nehotovym vrobkum/////////////////////////////////
{string no_tag_vyrobku = GetTag(no_Item);
 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");

        if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_ocarovavac);}
//DestroyObject(no_Item);
//no_Item = CreateItemOnObject("no_polot_zb",OBJECT_SELF,1,no_tag_vyrobku);
        string no_nazev_procenta;
        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}


                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
SetLocalInt(no_Item,"no_OCAROVAVAM",TRUE);
FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
//no_udelejjmeno(no_Item);
                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_oc_close_tr",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si vyrobu" ,no_oPC,FALSE );
                         //CopyItem(no_Item,no_oPC,TRUE);
                         //DestroyObject(no_Item);
                         }

}


///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.

int __GetIsLimitedByWeapon(int iMater) {
  switch (iMater) {
    // Elementy
    case  1:
    case  2:
    case  3:
    case  4:
    case  5:
    // DamageBonusVsRace
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    case 21:
    // ItemPropertyDamageBonusVsAlign
    case 32:
    case 33:
    case 34:
    case 35:
    // ItemPropertyDamageBonusVsRace IP_CONST_RACIALTYPE_OUTSIDER
    case 37: return TRUE;
  }
  return FALSE;
}

/* This seems to be DC to create item with such propery. Not a DC of itemproperty
 * effect */
int __GetDcByMaterial(int iMater) {
  switch (iMater) {
    // Elementy
    case  1:
    case  2:
    case  3:
    case  4:
    case  5: return 9;
    // Keen
    case  6: return 10;
    // Onhit
    case  7:
    case  8:
    case  9:
    case 10:
    case 11: return 8;
    // DamageBonusVsRace
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    case 21: return 7;
    // IP_CONST_ONHIT_SLAYRACE
    case 22:
    case 23:
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 31: return 10;
    // ItemPropertyDamageBonusVsAlign
    case 32:
    case 33:
    case 34:
    case 35: return 8;
    // ItemPropertyVampiricRegeneration
    case 36: return 9;
    // ItemPropertyDamageBonusVsRace IP_CONST_RACIALTYPE_OUTSIDER
    case 37: return 10;
    // IP_CONST_ONHIT_WOUNDING
    case 38: return 8;
    // IP_CONST_ONHIT_LESSERDISPEL
    case 39: return 10;
    // IP_CONST_ONHIT_ITEMPOISON
    case 40:
    case 41:
    case 42:
    case 43:
    case 44:
    case 45: return 7;
    // IP_CONST_ONHIT_LEVELDRAIN
    case 46:
    // IP_CONST_ONHIT_ABILITYDRAIN
    case 47:
    case 48:
    case 49:
    case 50:
    case 51:
    case 52: return 10;
    // IP_CONST_REDUCEDWEIGHT_10_PERCENT
    case 53: return 7;
  }
  return 0;
}

void no_xp_oc (object no_oPC, object no_pec)
{
  int no_druh=0;
  int no_DC=1000;// radsi velke, kdyby nahodou se neprepsalo
  int no_level = TC_getLevel(no_oPC,TC_ocarovavac);  // TC kovar = 33
  if  (GetIsDM(no_oPC)== TRUE)
    no_level=no_level+20;

//        SetLocalInt(OBJECT_SELF,"no_kamen",no_co_mame_za_kamen);
//        SetLocalInt(OBJECT_SELF,"no_kamen2",no_co_mame_za_kamen2);
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_Item =  " + GetName(no_Item));
  int no_vedlejsi_mat = GetLocalInt(no_Item,"no_ve_mat");
  int no_hlavni_mat = GetLocalInt(no_Item,"no_hl_mat");
  int no_procenta_hlmat = GetLocalInt(no_Item,"no_hl_proc");
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_vedlejsi_mat= " + IntToString(no_vedlejsi_mat));
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_hlavni_mat= " + IntToString(no_hlavni_mat));
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_procenta_hlmat= " + IntToString(no_procenta_hlmat));
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_kamen= " + IntToString((GetLocalInt(no_Item,"no_kamen"))));
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_kamen2= " + IntToString((GetLocalInt(no_Item,"no_kamen2"))));
////////ulozene pocty procent danych materialu.  1  pro hlavni, 2 pro vedlejsi..
       // SetLocalInt(OBJECT_SELF,"no_kamen",no_co_mame_za_kamen);
       // SetLocalInt(OBJECT_SELF,"no_kamen2",no_co_mame_za_kamen2);

  // Hlavni material
  no_DC = __GetDcByMaterial(no_hlavni_mat) * (GetLocalInt(no_Item,"no_kamen")/10);

  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_DC hlmat= " + IntToString(no_DC));

  // Vedlejsi material
  no_DC = __GetDcByMaterial(no_vedlejsi_mat) * (GetLocalInt(no_Item,"no_kamen2")/10) + no_DC - 10*no_level;


  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_DC vedl mat= " + IntToString(no_DC+ 10*no_level));
  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC,"no_DC - no_lvl= " + IntToString(no_DC));



  // pravdepodobnost uspechu =
  int no_chance = 100 - (no_DC*2) ;
  if (no_chance < 0)
    no_chance = 0;

  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
  //samotny hod
  int no_hod = 101-d100();

////6brezen/////
  if (GetLocalFloat(no_Item,"no_suse_proc")==0.0)
    SetLocalFloat(no_Item,"no_suse_proc",10.0);


  if ( NO_oc_DEBUG == TRUE )
    SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));


  if (no_hod <= no_chance ) {
    if ( NO_oc_DEBUG == TRUE )
      SendMessageToPC(no_oPC," no:item do procent =  :" + GetName(no_Item));


    float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");

    SendMessageToPC(no_oPC,"===================================");

    if (no_chance >= 100) {
      FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
      TC_setXPbyDifficulty(no_oPC,TC_ocarovavac,no_chance,TC_dej_vlastnost(TC_ocarovavac,no_oPC));
    }

    if ((no_chance > 0) && (no_chance<100)) {
      TC_setXPbyDifficulty(no_oPC,TC_ocarovavac,no_chance,TC_dej_vlastnost(TC_ocarovavac,no_oPC));
    }
    //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
    ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////

    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

            if (no_obtiznost_vyrobku >=190) {
            no_procenta = no_procenta + 0.1 ;}
            else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
            no_procenta = no_procenta + 0.2 ;}
            else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
            no_procenta = no_procenta + Random(2)/10.0 ;}
           else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta + Random(3)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta + Random(10)/10.0 +0.1;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta + Random(10)/10.0 +0.2;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta + Random(10)/10.0 +0.3;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta + Random(10)/10.0 +0.4;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta + Random(10)/10.0 +0.6;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta + Random(10)/10.0 +0.8;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta + Random(10)/10.0 +1.0;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta + Random(10)/10.0 +1.3;}
            else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta + Random(10)/10.0 +1.5;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta + Random(10)/10.0 +1.7;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta + Random(10)/10.0+ 2.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta + Random(10)/10.0 +2.5;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta + Random(10)/10.0 +3.0;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta + Random(10)/10.0 + 3.5;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta+ Random(10)/10.0 +4.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta + Random(10)/10.0 +5.0;}

    if (NO_oc_DEBUG == TRUE)
      no_procenta = no_procenta +30.0;
    if  (GetIsDM(no_oPC)== TRUE)
      no_procenta = no_procenta + 50.0;

    if (no_procenta >= 100.0) {  //kdyz je vyrobek 100% tak samozrejmeje hotovej
      AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));
      //DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek

      // if (GetLocalString(OBJECT_SELF,"no_druh_vyrobku") == "kr") {
      FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );

      no_udelejocarovani(no_Item);
      DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
/// }////////////////// konec dodelavky zbrane ///////////////////////////////



    }//konec kdzy uz mam nad 100%

    if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej
      no_vytvorprocenta(no_oPC,no_procenta,no_Item);
    }// kdyz neni 100%
      SendMessageToPC(no_oPC,"===================================");

  } /// konec, kdyz sme byli uspesni

  else if (no_hod > no_chance )  {     ///////// bo se to nepovedlo, tak znicime polotovar////////////////

    float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

          if (no_obtiznost_vyrobku >=190) {
          no_procenta = no_procenta - 0.2 ;}
          else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
          no_procenta = no_procenta - 0.3 ;}
          else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
          no_procenta = no_procenta - Random(4)/10.0 ;}
         else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
          no_procenta = no_procenta - Random(6)/10.0 ;} //0.1-0.6%
          else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
          no_procenta = no_procenta - Random(10)/10.0 -0.3;}
          else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
          no_procenta = no_procenta - Random(10)/10.0 -0.4;}
          else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
          no_procenta = no_procenta - Random(10)/10.0 -0.5;}
          else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
          no_procenta = no_procenta - Random(10)/10.0 -0.6;}
          else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
          no_procenta = no_procenta - Random(10)/10.0 -0.9;}
          else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
          no_procenta = no_procenta - Random(10)/10.0 -1.2;}
          else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
          no_procenta = no_procenta - Random(10)/10.0 -1.5;}
         else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
          no_procenta = no_procenta - Random(10)/10.0 -1.8;}
          else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
          no_procenta = no_procenta - Random(10)/10.0 -1.9;}
          else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
          no_procenta = no_procenta - Random(10)/10.0 -2.0;}
          else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
          no_procenta = no_procenta - Random(10)/10.0- 3.0;}
          else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
          no_procenta = no_procenta - Random(10)/10.0 -3.2;}
          else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
          no_procenta = no_procenta - Random(10)/10.0 -4.5;}
          else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
          no_procenta = no_procenta - Random(10)/10.0 - 5;}
          else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
          no_procenta = no_procenta- Random(10)/10.0 -6.0;}
          else if (no_obtiznost_vyrobku <10) {
          no_procenta = no_procenta - Random(10)/10.0 -8.0;}



    if (no_procenta <= 0.0 ){
      DestroyObject(no_Item);
      DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

      FloatingTextStringOnCreature("Vyrobek se rozpadl",no_oPC,FALSE );
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
      DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
    }
    else  if ((no_chance > 0)&(no_procenta>0.0)) {
      FloatingTextStringOnCreature("Vyrobek se brani prijeti duse",no_oPC,FALSE );
    }

    if (no_chance == 0) {
      FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
    }     //konec ifu
    if (no_procenta > 0.0 ) {
      no_vytvorprocenta(no_oPC,no_procenta,no_Item);
    }



  }//konec else no_hod >no_chance


}    ////konec no_xp_zb





//////////////////////////////////////////////////////////////////////////////////////////
void no_xp_vyrobpolotovar(object no_oPC, object no_pec)
// vytvori polotovar
{

if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"pred mrskou");}
no_kamen(OBJECT_SELF,TRUE);
if (NO_oc_DEBUG == TRUE) {SendMessageToPC(no_oPC,"za mrskou");}
SetLocalInt(no_Item,"no_OCAROVAVAM",TRUE);
SetLocalInt(no_Item,"no_ve_mat",GetLocalInt(OBJECT_SELF,"no_ve_mat"));
SetLocalInt(no_Item,"no_hl_mat",GetLocalInt(OBJECT_SELF,"no_hl_mat"));
SetLocalInt(no_Item,"no_hl_proc",GetLocalInt(OBJECT_SELF,"no_hl_proc"));
SetLocalInt(no_Item,"no_kamen",GetLocalInt(OBJECT_SELF,"no_kamen"));
SetLocalInt(no_Item,"no_kamen2",GetLocalInt(OBJECT_SELF,"no_kamen2"));
SetLocalInt(no_Item,"no_cena_kamen",GetLocalInt(OBJECT_SELF,"no_cena_kamen"));

no_zamkni(no_oPC);
DelayCommand(no_oc_delay,no_xp_oc(no_oPC,OBJECT_SELF));

} // konec vyrob polotovar


//////////////////////////////////////////////////////////////////////////////////////////









