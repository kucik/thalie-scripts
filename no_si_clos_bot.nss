#include "ku_libtime"
#include "no_si_func_bot"
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
while (GetIsEffectValid(no_effect))
   {
   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(no_oPC,no_effect);
   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(no_oPC,no_effect);
   no_effect=GetNextEffect(no_oPC);
   }

/////////////////////////////////////////////////////////////////

SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",0);




//no_oPC=GetLastClosedBy();
//no_znicit(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x

SetLocalInt(OBJECT_SELF,"no_pouzitysutr1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_pouzitysutr2",0);
//SetLocalInt(OBJECT_SELF,"no_forma",0);
SetLocalInt(OBJECT_SELF,"no_prisada",0);
SetLocalInt(OBJECT_SELF,"no_pouzitakuze",0);
SetLocalString(OBJECT_SELF,"no_vyrobek","");



no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");

//zjisti kovy do no_pouzitykov1 a no_pouzitykov2
no_pouzitykamen(no_Item,OBJECT_SELF,FALSE);
no_prisada(no_Item,OBJECT_SELF,FALSE);
no_vyrobek(no_Item,OBJECT_SELF,FALSE);
no_pouzitakuze(no_Item,OBJECT_SELF,FALSE);


/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
    if (GetResRef(no_Item) == "no_polot_si") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }
                if (no_pocet_cyklu < 9) {


                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_si_delay,no_xp_si(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitysutr1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitysutr2",0);
            SetLocalInt(OBJECT_SELF,"no_forma",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalInt(OBJECT_SELF,"no_pouzitakuze",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");

                break;           /// kdyz bude polotovar ve vyrobe, tak zabranime aby se udelal novej z kuze.
                }///kdyz mame mene, nez 10cyklu


                //////////predelavka 1.9.2014/////////
                if (no_pocet_cyklu == 9) {
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
//                Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_si_delay,no_xp_si(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitysutr1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_pouzitysutr2",0);
            SetLocalInt(OBJECT_SELF,"no_forma",0);
            SetLocalInt(OBJECT_SELF,"no_prisada",0);
            SetLocalInt(OBJECT_SELF,"no_pouzitakuze",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");

                break;           /// kdyz bude polotovar ve vyrobe, tak zabranime aby se udelal novej z kuze.
                }///kdyz mame mene, nez 10cyklu

        if   (no_pocet_cyklu >= 10) {
                SetLocalInt(OBJECT_SELF,"no_pouzitysutr1",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
                SetLocalInt(OBJECT_SELF,"no_pouzitysutr2",0);
                SetLocalInt(OBJECT_SELF,"no_forma",0);
                SetLocalInt(OBJECT_SELF,"no_prisada",0);
                SetLocalInt(OBJECT_SELF,"no_pouzitakuze",0);
                SetLocalString(OBJECT_SELF,"no_vyrobek","");
              SetLocalInt(no_Item,"no_pocet_cyklu",0);




              AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 5.0));
              no_pocet_cyklu = d6();/// jen at nedavame zbytecne dalsi promennou..
              switch (no_pocet_cyklu) {
              case 1: {FloatingTextStringOnCreature(" To je ale namaha ! ",no_oPC,FALSE );
                        break; }
              case 2: {FloatingTextStringOnCreature(" Snad se z toho neupracuju ! ",no_oPC,FALSE );
                        break;}
              case 3: {FloatingTextStringOnCreature(" Jeste chvilku a uz to bude ! ",no_oPC,FALSE );
                        break;}
              case 4:{FloatingTextStringOnCreature(" Jen aby to neprasklo ! ",no_oPC,FALSE );
                        break; }
              case 5: {FloatingTextStringOnCreature(" Uz jen kousek ! ",no_oPC,FALSE );
                        break;  }
              case 6: {FloatingTextStringOnCreature(" Safra prace! ",no_oPC,FALSE );
                        break;  }
              }
               break;

                }
     }//if resref = oplotovar
  no_Item = GetNextItemInInventory(OBJECT_SELF);
}    /// dokud valid
/////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////
if (no_si_debug == TRUE) {
SendMessageToPC(no_oPC,"menu : " + IntToString(GetLocalInt(OBJECT_SELF,"no_menu")));
SendMessageToPC(no_oPC,"vyrobek : " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));
}


// vyroba prvniho polotovaru
if (( no_menu > 0  &  no_menu < 13 ) & (GetLocalString(OBJECT_SELF,"no_vyrobek")=="")& (GetLocalInt(OBJECT_SELF,"no_pouzitakuze")!=0))
{
no_xp_vyrobpolotovar(no_oPC,OBJECT_SELF);

if (no_si_debug == TRUE) {
SendMessageToPC(no_oPC,"sutr v zarizeni 1: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitysutr1")) + "sutr v zarizeni 2:  " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitysutr2")));
//SendMessageToPC(no_oPC,"forma : " + IntToString(GetLocalInt(OBJECT_SELF,"no_forma")));
SendMessageToPC(no_oPC,"prisady : " + IntToString(GetLocalInt(OBJECT_SELF,"no_prisada")));
SendMessageToPC(no_oPC,"nasada : " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitakuze")));
SendMessageToPC(no_oPC,"vyrobek : " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));    }

}

if (GetLocalString(OBJECT_SELF,"no_vyrobek")!="")
{
no_zjistiobsah(GetLocalString(OBJECT_SELF,"no_vyrobek"));

if (no_si_debug == TRUE) {
SendMessageToPC(no_oPC,"no_vyrobek  neni roven 0: " );
SendMessageToPC(no_oPC,"vyrobek = " + (GetLocalString(OBJECT_SELF,"no_vyrobek")));
SendMessageToPC(no_oPC,"sutry ve vyrobku: no_sutr_1: " + IntToString(GetLocalInt(OBJECT_SELF,"no_sutr_1")) + "  no_sutr_2: " + IntToString(GetLocalInt(OBJECT_SELF,"no_sutr_2")));
SendMessageToPC(no_oPC,"no_kovsperku : " + IntToString(GetLocalInt(OBJECT_SELF,"no_kovsperku")));
SendMessageToPC(no_oPC,"prisady : " + IntToString(GetLocalInt(OBJECT_SELF,"no_prisada")));
SendMessageToPC(no_oPC,"nasavena procenta na zarizeni: " + IntToString(GetLocalInt(OBJECT_SELF,"no_hl_proc")));
SendMessageToPC(no_oPC,"sutr v zarizeni 1: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitysutr1")));
SendMessageToPC(no_oPC,"sutr v zarizeni 2: " + IntToString(GetLocalInt(OBJECT_SELF,"no_pouzitysutr2")));
SendMessageToPC(no_oPC,"nastaveny 1 sutr: " + IntToString(GetLocalInt(OBJECT_SELF,"no_hl_mat")));
SendMessageToPC(no_oPC,"nastaveny 2 sutr: " + IntToString(GetLocalInt(OBJECT_SELF,"no_ve_mat")));


    }



if ((GetLocalInt(OBJECT_SELF,"no_sutr_1") == 0) &  (GetLocalInt(OBJECT_SELF,"no_pouzitysutr1") > 0)&  (GetLocalInt(OBJECT_SELF,"no_pouzitysutr2") > 0))  {   // pokud by nebylo s prisadama delam mecu jak cip..
no_xp_pridej_kameny(no_oPC,OBJECT_SELF); }
if  ((GetLocalInt(OBJECT_SELF,"no_sutr_1") == 0) & (GetLocalInt(OBJECT_SELF,"no_sutr_2") == 0) ) {
SendMessageToPC(no_oPC,"bude potreba pridat spravne kameny dle nastaveni");
}
if (GetLocalInt(OBJECT_SELF,"no_sutr_1") > 0) {   // pokud by nebylo s prisadama delam mecu jak cip..
FloatingTextStringOnCreature(" Tento vyrobek je jiz hotov ! ",no_oPC,FALSE );
}
}

}
