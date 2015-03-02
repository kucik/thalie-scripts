#include "ku_libtime"
//#include "no_ko_inc"
#include "no_nastcraft_ini"
#include "no_ko_functions"

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
no_znicit(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x

SetLocalInt(OBJECT_SELF,"no_kuze",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_suseni",56);   //tak to nehaze, ze no_seseni=no_louh
SetLocalInt(OBJECT_SELF,"no_louh",57);

/////////////////////////
//no_menu:
//1 - suseni                tag:no_suseni
//2 - louhovani kozek       tag:no_louhovani
//3 - louhovani kuzi        tag: no_kozky
//0 - zpet na start         tag:no_zpet
//
//////////////////////////

no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {
            no_kuze(OBJECT_SELF, FALSE);
            break;
          }
case 2:  {
            no_suseni(no_Item,OBJECT_SELF,FALSE);
            no_Item = GetFirstItemInInventory(OBJECT_SELF);
            no_louh(OBJECT_SELF,FALSE);
            break;
          }
case 3:  {
            no_suseni(no_Item,OBJECT_SELF,FALSE);
            no_Item = GetFirstItemInInventory(OBJECT_SELF);
            no_louh(OBJECT_SELF,FALSE);
            break;
          }

            } /// konec switche





//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////

int TC_VLASTNOST  = GetAbilityScore(GetLastDisturbed(), ABILITY_WISDOM,TRUE);
/////////je to v .ini ale nemohlo to v ini najit last distrurbed..




/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
if (GetResRef(no_Item) == "no_polot_ko") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }

                if (no_pocet_cyklu < 9) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_ko_delay,no_xp_kuze(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_kuze",0);
            SetLocalInt(OBJECT_SELF,"no_louh",57);
            SetLocalInt(OBJECT_SELF,"no_suseni",56);
            break;  }///kdyz mame mene, nez 10cyklu

                            //////////predelavka 1.9.2014/////////
                if (no_pocet_cyklu == 9) {
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
//                Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

            SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_ko_delay,no_xp_kuze(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_kuze",0);
            SetLocalInt(OBJECT_SELF,"no_louh",57);
            SetLocalInt(OBJECT_SELF,"no_suseni",56);
            break;                  }///kdyz mame mame presne 9 cyklu



        if   (no_pocet_cyklu >= 10) {

                                ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
                ///doplnena perzistence 5.5.2014
               // if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
               // Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF));
               // }


              SetLocalInt(no_Item,"no_pocet_cyklu",0);
                          SetLocalInt(OBJECT_SELF,"no_kuze",0);
            SetLocalInt(OBJECT_SELF,"no_louh",57);
            SetLocalInt(OBJECT_SELF,"no_suseni",56);

              AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 5.0));
              no_pocet_cyklu = d6();/// jen at nedavame zbytecne dalsi promennou..
              switch (no_pocet_cyklu) {
              case 1: {FloatingTextStringOnCreature(" To je ale namaha ! ",no_oPC,FALSE );
                        break; }
              case 2: {FloatingTextStringOnCreature(" Snad se z toho neupracuju ! ",no_oPC,FALSE );
                        break;}
              case 3: {FloatingTextStringOnCreature(" Jeste chvilku a uz to bude ! ",no_oPC,FALSE );
                        break;}
              case 4:{FloatingTextStringOnCreature(" Snad se tomu nic nestane ! ",no_oPC,FALSE );
                        break; }
              case 5: {FloatingTextStringOnCreature(" Uz jen kousek ! ",no_oPC,FALSE );
                        break;  }
              case 6: {FloatingTextStringOnCreature(" Uz aby to bylo ! ",no_oPC,FALSE );
                        break;  }
              }
               break;

                }
     }//if resref = oplotovar
     no_Item = GetNextItemInInventory(OBJECT_SELF);
  }    /// dokud valid
/////////////////////////////////////////////////////////////////////////////



 /////////////////////////////////////////////////////////////////////////////
//if ((GetLocalInt(OBJECT_SELF,"no_louh") == 57)  &  (GetLocalInt(OBJECT_SELF,"no_suseni") < 56))
//DelayCommand(1.0,no_vratveci(GetLocalInt(OBJECT_SELF,"no_suseni"),1,GetLocalInt(OBJECT_SELF,"no_suseni")));
//if ((GetLocalInt(OBJECT_SELF,"no_louh") < 57) &  (GetLocalInt(OBJECT_SELF,"no_suseni") == 56))
//DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_louh")));
/// kdyz treba nekdo zapomnel slinovaci prisady c peci, tka at je tam ma zpatky..


no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {
        if ( GetLocalInt(OBJECT_SELF,"no_kuze") > 0   ) {
        FloatingTextStringOnCreature(" Snazis se ususit vycinenou kuzi ",no_oPC,FALSE );
        no_switch = GetLocalInt(OBJECT_SELF,"no_kuze");
        no_zamkni(no_oPC);
                    no_kuze(OBJECT_SELF, TRUE);
        DelayCommand(no_ko_delay,no_xp_kuze_ini(no_oPC,OBJECT_SELF,no_switch));
        }
         break;  } //konec case 1
case 2:  {
        if ( GetLocalInt(OBJECT_SELF,"no_suseni") == GetLocalInt(OBJECT_SELF,"no_louh")   ) {
        FloatingTextStringOnCreature(" Snazis se nalouhovat kuzi ",no_oPC,FALSE );
        no_switch = GetLocalInt(OBJECT_SELF,"no_suseni");
        no_zamkni(no_oPC);
                    no_suseni(no_Item,OBJECT_SELF,TRUE);
            no_Item = GetFirstItemInInventory(OBJECT_SELF);
            no_louh(OBJECT_SELF,TRUE);
        DelayCommand(no_ko_delay,no_xp_louh_ini(no_oPC,OBJECT_SELF,no_switch));
        }

        if (( GetLocalInt(OBJECT_SELF,"no_suseni") != GetLocalInt(OBJECT_SELF,"no_louh"))&( GetLocalInt(OBJECT_SELF,"no_louh") != 57)) {
             FloatingTextStringOnCreature("Pro vyrobu kuzi musi byt v susaku ususena kuze a spravny louh ",no_oPC,FALSE );
                }


         break; }  //konec case 2

case 3:  {   /// delani kozek/////////////////////////////////////
        if ( GetLocalInt(OBJECT_SELF,"no_suseni") == GetLocalInt(OBJECT_SELF,"no_louh")   ) {
        FloatingTextStringOnCreature(" Snazis se nalouhovat kozku ",no_oPC,FALSE );
        no_switch = GetLocalInt(OBJECT_SELF,"no_suseni");
        no_zamkni(no_oPC);
            no_suseni(no_Item,OBJECT_SELF,TRUE);
            no_Item = GetFirstItemInInventory(OBJECT_SELF);
            no_louh(OBJECT_SELF,TRUE);
            // odecte pouzite veci ze zarizeni
        DelayCommand(no_ko_delay,no_xp_kozk_ini(no_oPC,OBJECT_SELF,no_switch));
        }

        if (( GetLocalInt(OBJECT_SELF,"no_suseni") != GetLocalInt(OBJECT_SELF,"no_louh"))&( GetLocalInt(OBJECT_SELF,"no_suseni") != 56)) {
             FloatingTextStringOnCreature("Pro vyrobu kozek musi byt v susaku ususena kuze a spravny louh ",no_oPC,FALSE );
                }
         break;  }  //konec case 3
}   /// konec switche



}
