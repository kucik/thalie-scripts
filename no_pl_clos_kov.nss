#include "ku_libtime"
//#include "no_pl_inc"
#include "no_nastcraft_ini"
#include "no_pl_func"
#include "ku_persist_inc"


object no_Item;
object no_oPC;
int no_switch;
int no_menu;


void main()
{
no_oPC=GetLastDisturbed();
///////////nomis nema rad neviditelne craftery (. //////////////
effect no_effect=GetFirstEffect(no_oPC);
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
   no_effect=GetNextEffect(no_oPC);
   }

/////////////////////////////////////////////////////////////////

SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",0);



     if (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,no_oPC)) != "ITEM_ARMORHAMMER_NORMAL")
     {
        FloatingTextStringOnCreature("Je treba mit v ruce kovarske kladivo",no_oPC,FALSE);
     }
else {


//no_oPC=GetLastClosedBy();
//no_znicit(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x

SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
SetLocalInt(OBJECT_SELF,"no_prisada",0);
SetLocalInt(OBJECT_SELF,"no_kuze",0);
SetLocalString(OBJECT_SELF,"no_vyrobek","");



no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");

//zjisti kovy do no_pouzitykov1 a no_pouzitykov2
no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
no_prisada(no_Item,OBJECT_SELF,FALSE);
no_vyrobek(no_Item,OBJECT_SELF,FALSE);
no_kuze(no_Item,OBJECT_SELF,FALSE);


//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////tak a protoze stejnej skript na vecech, tak to musime rozlisit: ////////
//////// no_tr_koza: koza   no_tr_skopek : skopek/////////////////////////////////////////



/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
if (GetResRef(no_Item) == "no_polot_pl") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

                if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }
                if (no_pocet_cyklu < 9) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_pl_delay,no_xp_pl(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            SetLocalInt(OBJECT_SELF,"no_kuze",0);
            break;            /// kdyz bude polotovar ve vyrobe, tak zabranime aby se udelal novej z kuze.
                }///kdyz mame mene, nez 10cyklu

                //////////predelavka 1.9.2014/////////
                if (no_pocet_cyklu == 9) {
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
//                Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_pl_delay,no_xp_pl(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            SetLocalInt(OBJECT_SELF,"no_kuze",0);
            break;            /// kdyz bude polotovar ve vyrobe, tak zabranime aby se udelal novej z kuze.
                }///kdyz mame mene, nez 10cyklu


        if   (no_pocet_cyklu >= 10) {
              SetLocalInt(no_Item,"no_pocet_cyklu",0);

            SetLocalInt(OBJECT_SELF,"no_pouzitykov1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitykov2",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            SetLocalInt(OBJECT_SELF,"no_kuze",0);


                  ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
                ///doplnena perzistence 5.5.2014
                //if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
                //Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF));
                //}

              AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 5.0));
              no_pocet_cyklu = d6();/// jen at nedavame zbytecne dalsi promennou..
              switch (no_pocet_cyklu) {
              case 1: {FloatingTextStringOnCreature(" To je ale namaha ! ",no_oPC,FALSE );
                        break; }
              case 2: {FloatingTextStringOnCreature(" Ty plechy jsou snad z meteoru ! ",no_oPC,FALSE );
                        break;}
              case 3: {FloatingTextStringOnCreature(" No, u aby to bylo ! ",no_oPC,FALSE );
                        break;}
              case 4:{FloatingTextStringOnCreature(" Snad se tomu nic nestane ! ",no_oPC,FALSE );
                        break; }
              case 5: {FloatingTextStringOnCreature(" Uz jen kousek ! ",no_oPC,FALSE );
                        break;  }
              case 6: {FloatingTextStringOnCreature(" To je ale vopruz prace ! ",no_oPC,FALSE );
                        break;  }
              }
               break;

                }
     }//if resref = oplotovar
 no_Item = GetNextItemInInventory(OBJECT_SELF);
  }    /// dokud valid
/////////////////////////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////////////////////////

// vyroba prvniho polotovaru
if (( no_menu > 0  &  no_menu < 9 ) & (GetLocalString(OBJECT_SELF,"no_vyrobek")=="")& (GetLocalInt(OBJECT_SELF,"no_pouzitykov1")!=0))
{
no_xp_vyrobpolotovar(no_oPC,OBJECT_SELF);

if (NO_pl_DEBUG == TRUE) {
SendMessageToPC(no_oPC,"kov 1: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitykov1")) + "___kov2: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitykov2")));
SendMessageToPC(no_oPC,"prisady : " + IntToString(GetLocalInt(OBJECT_SELF,"no_prisada")));
SendMessageToPC(no_oPC,"kuze : " + IntToString(GetLocalInt(OBJECT_SELF,"no_kuze")));
SendMessageToPC(no_oPC,"vyrobek : " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));    }

}

if (GetLocalString(OBJECT_SELF,"no_vyrobek")!="")
{
no_zjistiobsah(GetLocalString(OBJECT_SELF,"no_vyrobek"));

if (GetLocalInt(OBJECT_SELF,"no_druh_kuze") == 0) {   // pokud by nebylo s prisadama delam mecu jak cip..
no_xp_pridej_kuzi(no_oPC,OBJECT_SELF); }

if (GetLocalInt(OBJECT_SELF,"no_druh_kuze") > 0) {   // pokud by nebylo s prisadama delam mecu jak cip..
FloatingTextStringOnCreature(" Tento vyrobek je jiz hotov ! ",no_oPC,FALSE );
}
}

}// kdyz mame kovarske kladivo
}
