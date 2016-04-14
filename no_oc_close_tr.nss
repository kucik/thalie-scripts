#include "ku_libtime"
//#include "no_oc_inc"
#include "no_oc_func"
#include "no_nastcraft_ini"
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
  while (GetIsEffectValid(no_effect)) {
    if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
    if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
    if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
    no_effect=GetNextEffect(no_oPC);
  }

/////////////////////////////////////////////////////////////////

  SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",0);


//no_oPC=GetLastClosedBy();
//no_znicit(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x

   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
  SetLocalInt(OBJECT_SELF,"no_kamen",0);
  SetLocalInt(OBJECT_SELF,"no_kamen2",0);
  SetLocalString(OBJECT_SELF,"no_vyrobek","");
  SetLocalObject(OBJECT_SELF,"no_vyrobek",OBJECT_SELF);
  SetLocalInt (OBJECT_SELF,"no_cena_kamen",0);
  no_Item = GetFirstItemInInventory(OBJECT_SELF);
  no_menu = GetLocalInt(OBJECT_SELF,"no_menu");

//zjisti kovy do no_pouzitykov1 a no_pouzitykov2

  no_vyrobek(no_Item,OBJECT_SELF,FALSE);

//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////tak a protoze stejnej skript na vecech, tak to musime rozlisit: ////////
  int no_provedeni_polotovaru;

  no_provedeni_polotovaru = FALSE;

  if (NO_oc_DEBUG == TRUE) {
    SendMessageToPC(no_oPC,"no_kamen: " + IntToString(GetLocalInt(OBJECT_SELF,"no_kamen")));
    SendMessageToPC(no_oPC,"vyrobek : " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));    }

/////////////polotovar//////////////////////////////////////////////////////
  if (GetLocalString(OBJECT_SELF,"no_vyrobek")!="") {
    no_Item = GetFirstItemInInventory(OBJECT_SELF);
  while(GetIsObjectValid(no_Item))  {
    if ( (GetStringLeft(GetTag(no_Item),3) == "no_") && 
         (GetLocalInt(no_Item,"no_OCAROVAVAM") == TRUE) ) {
      if ( NO_oc_DEBUG == TRUE )
        SendMessageToPC(no_oPC,"no_polotovar tag=" + GetTag(no_Item) );
      if ( NO_oc_DEBUG == TRUE )
        SendMessageToPC(no_oPC,"no_polotovar jmeno=" + GetName(no_Item) );

      int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
      no_pocet_cyklu = no_pocet_cyklu+1;

      if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) && 
          (GetLocalString(no_Item,"no_crafter")!="") ) {
         no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
      }
      if (no_pocet_cyklu < 9) {
        SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);

        no_zamkni(no_oPC);
        SetLocalInt(OBJECT_SELF,"no_kamen",0);
        SetLocalInt(OBJECT_SELF,"no_kamen2",0);
        SetLocalString(OBJECT_SELF,"no_vyrobek","");
        DelayCommand(no_oc_delay,no_xp_oc(no_oPC,OBJECT_SELF));
        //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna

        no_provedeni_polotovaru = TRUE;
        break;                
      }///kdyz mame mene, nez 10cyklu

                     //////////predelavka 1.9.2014/////////
      if (no_pocet_cyklu == 9) {
        DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
//      Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

        SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
        no_zamkni(no_oPC);
        SetLocalInt(OBJECT_SELF,"no_kamen",0);
        SetLocalInt(OBJECT_SELF,"no_kamen2",0);
        SetLocalString(OBJECT_SELF,"no_vyrobek","");
        DelayCommand(no_oc_delay,no_xp_oc(no_oPC,OBJECT_SELF));
        //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna

        no_provedeni_polotovaru = TRUE;
        break;
      }///kdyz mame mame presne 9 cyklu


      if   (no_pocet_cyklu >= 10) {
        SetLocalInt(no_Item,"no_pocet_cyklu",0);

        SetLocalInt(OBJECT_SELF,"no_kamen",0);
        SetLocalInt(OBJECT_SELF,"no_kamen2",0);
        SetLocalString(OBJECT_SELF,"no_vyrobek","");

  ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////

        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 5.0));
        no_pocet_cyklu = d6();/// jen at nedavame zbytecne dalsi promennou..
        switch (no_pocet_cyklu) {
          case 1: FloatingTextStringOnCreature(" To je ale namaha ! ",no_oPC,FALSE );
                  break; 
          case 2: FloatingTextStringOnCreature(" Snad se z toho neupracuju ! ",no_oPC,FALSE );
                  break;
          case 3: FloatingTextStringOnCreature(" Jeste chvilku a uz to bude ! ",no_oPC,FALSE );
                  break;
          case 4:FloatingTextStringOnCreature(" Snad se ta duse z te trubice nedostane ! ",no_oPC,FALSE );
                  break; 
          case 5: FloatingTextStringOnCreature(" Uf, to je ale tezka prace ! ",no_oPC,FALSE );
                  break;
          case 6: FloatingTextStringOnCreature(" Uz aby to bylo ! ",no_oPC,FALSE );
                  break;
        }
        break;

      }
    }//if resref = oplotovar
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }//dokud valid


 }    /// kdyz bude polotovar ve vyrobe, tak zabranime aby se udelal novej z kuze.

/////////////////////////////////////////////////////////////////////////////

  if (no_provedeni_polotovaru == FALSE)
    no_kamen(OBJECT_SELF,FALSE);

  if (NO_oc_DEBUG == TRUE) {
    SendMessageToPC(no_oPC,"no_kamen: " + IntToString(GetLocalInt(OBJECT_SELF,"no_kamen")));
    SendMessageToPC(no_oPC,"vyrobek : " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));    }


/////////////////////////////////////////////////////////////////////////////

// vyroba prvniho polotovaru
  if ( ( no_menu == 1 ) & (GetLocalString(OBJECT_SELF,"no_vyrobek")!="") && 
       (GetLocalInt(OBJECT_SELF,"no_kamen")!=0) ) {
    no_Item = GetLocalObject(OBJECT_SELF,"no_vyrobek");
    no_xp_vyrobpolotovar(no_oPC,OBJECT_SELF);
  }
}
