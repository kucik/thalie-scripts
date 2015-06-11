#include "ku_libtime"
//#include "no_dr_inc"
#include "no_dr_functions"
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
no_znicit(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x

SetLocalInt(OBJECT_SELF,"no_drevo",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_osekane",56);   //tak to nehaze, ze no_osekane == no_mnoridlo + premaze minulou hodnotu
SetLocalInt(OBJECT_SELF,"no_moridlo",57);

/////////////////////////
//no_menu:
//1 - sekani               tag:no_sekani
//2 - deska                tag:no_vyr_deska
//3 - lat                  tag:no_vyr_lat
//4 - rukojet            tag:no_vyr_nasada
//0 - zpet na start        tag:no_zpet
//
//////////////////////////

no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {  ///3.srpna - uz neni potreba struskotvornych prisad
            /// no_struska(no_Item,OBJECT_SELF);
            no_drevo(no_Item,OBJECT_SELF, FALSE);   //nugety maji samy svoje resrefy a tagy, musi to byt zvlast
            break;
          }
case 2:  {
            no_osekane(no_Item,OBJECT_SELF, FALSE);
            no_moridlo(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 3:   {
            no_osekane(no_Item,OBJECT_SELF,FALSE);
            no_moridlo(no_Item,OBJECT_SELF,FALSE);
            break;
           }
case 4:   {
            no_osekane(no_Item,OBJECT_SELF,FALSE);
            no_moridlo(no_Item,OBJECT_SELF,FALSE);
            break;
           }

            } /// konec switche
//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////


/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
if (GetResRef(no_Item) == "no_polot_dr") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;
        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }


                if (no_pocet_cyklu < 9) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_dr_delay,no_xp_dr(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_drevo",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_osekane",56);   //tak to nehaze, ze no_osekane == no_mnoridlo + premaze minulou hodnotu
            SetLocalInt(OBJECT_SELF,"no_moridlo",57);
            break;
             }///kdyz mame mene, nez 10cyklu

                            //////////predelavka 1.9.2014/////////
                if (no_pocet_cyklu == 9) {
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
//                Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

            SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_dr_delay,no_xp_dr(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_drevo",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_osekane",56);   //tak to nehaze, ze no_osekane == no_mnoridlo + premaze minulou hodnotu
            SetLocalInt(OBJECT_SELF,"no_moridlo",57);
            break;                  }///kdyz mame mame presne 9 cyklu




        if   (no_pocet_cyklu >= 10) {

                  ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
                ///doplnena perzistence 5.5.2014
               // if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
               // Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF));
               /// }


              SetLocalInt(no_Item,"no_pocet_cyklu",0);
                          SetLocalInt(OBJECT_SELF,"no_drevo",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_osekane",56);   //tak to nehaze, ze no_osekane == no_mnoridlo + premaze minulou hodnotu
            SetLocalInt(OBJECT_SELF,"no_moridlo",57);

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
              } //konec switche
               break;

                }//konec if hafo cyklu
                }    //konec if spravnej resref
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }    /// dokud valid

/////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////

//if ((GetLocalInt(OBJECT_SELF,"no_moridlo") == 57) &  (GetLocalInt(OBJECT_SELF,"no_osekane") < 56))
//no_vratveci(GetLocalInt(OBJECT_SELF,"no_osekane"),1,GetLocalInt(OBJECT_SELF,"no_osekane"));
//if ((GetLocalInt(OBJECT_SELF,"no_moridlo") < 57)    &  (GetLocalInt(OBJECT_SELF,"no_osekane")==56))
//DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_moridlo")));
/// kdyz treba nekdo zapomnel slinovaci prisady c peci, tka at je tam ma zpatky..

no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo") > 0   ) {
        FloatingTextStringOnCreature(" Snazis se osekat hrube drevo a davas mu tvar ",no_oPC,FALSE );
        no_switch = GetLocalInt(OBJECT_SELF,"no_drevo");
                    no_zamkni(no_oPC);
                    no_drevo(no_Item,OBJECT_SELF, TRUE);
// FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
        DelayCommand(no_dr_delay,no_xp_drevo(no_oPC,OBJECT_SELF,no_switch));   break;
        }  //konec kdyz mame drevo a chceme sekat.
          break;}
case 2:  {
        if ( GetLocalInt(OBJECT_SELF,"no_osekane") == GetLocalInt(OBJECT_SELF,"no_moridlo")   ) {
        FloatingTextStringOnCreature(" Snazis se osekat drevo do tvaru desky ",no_oPC,FALSE );
                    no_zamkni(no_oPC);
                    no_osekane(no_Item,OBJECT_SELF,TRUE);
                    no_moridlo(no_Item,OBJECT_SELF,TRUE);
        no_switch = GetLocalInt(OBJECT_SELF,"no_osekane");
// FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
        DelayCommand(no_dr_delay,no_xp_deska(no_oPC,OBJECT_SELF,no_switch));   break;
        }  //konec kdyz mame vse na desky

        if ( (GetLocalInt(OBJECT_SELF,"no_osekane") != GetLocalInt(OBJECT_SELF,"no_moridlo"))&( GetLocalInt(OBJECT_SELF,"no_osekane") != 56)) {
            FloatingTextStringOnCreature(" Pro desku je nutne umistit do spalku osekane drevo a shodne moridlo ",no_oPC,FALSE );
                }
          break;}  //konec case 2
case 3:   {        if ( GetLocalInt(OBJECT_SELF,"no_osekane") == GetLocalInt(OBJECT_SELF,"no_moridlo")   ) {
        FloatingTextStringOnCreature(" Snazis se osekat drevo do tvaru late ",no_oPC,FALSE );
                    no_zamkni(no_oPC);
                    no_osekane(no_Item,OBJECT_SELF,TRUE);
                    no_moridlo(no_Item,OBJECT_SELF,TRUE);
        no_switch = GetLocalInt(OBJECT_SELF,"no_osekane");
// FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
        DelayCommand(no_dr_delay,no_xp_lat(no_oPC,OBJECT_SELF,no_switch));   break;
        }  //konec kdyz mame vse na late

        if ( (GetLocalInt(OBJECT_SELF,"no_osekane") != GetLocalInt(OBJECT_SELF,"no_moridlo"))&( GetLocalInt(OBJECT_SELF,"no_osekane") != 56)) {
            FloatingTextStringOnCreature(" Pro lat je nutne umistit do spalku osekane drevo a shodne moridlo ",no_oPC,FALSE );
                }
          break;}  //konec case 3

case 4:   {        if ( GetLocalInt(OBJECT_SELF,"no_osekane") == GetLocalInt(OBJECT_SELF,"no_moridlo")   ) {
        FloatingTextStringOnCreature(" Snazis se osekat drevo do tvaru rukojeti ",no_oPC,FALSE );
                    no_zamkni(no_oPC);
                    no_osekane(no_Item,OBJECT_SELF,TRUE);
                    no_moridlo(no_Item,OBJECT_SELF,TRUE);
        no_switch = GetLocalInt(OBJECT_SELF,"no_osekane");
// FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
        DelayCommand(no_dr_delay,no_xp_nasa(no_oPC,OBJECT_SELF,no_switch));   break;
        }  //konec kdyz mame vse na nasady

        if ( (GetLocalInt(OBJECT_SELF,"no_osekane") != GetLocalInt(OBJECT_SELF,"no_moridlo"))&( GetLocalInt(OBJECT_SELF,"no_osekane") != 56)) {
            FloatingTextStringOnCreature(" Pro rukojet je nutne umistit do spalku osekane drevo a shodne moridlo ",no_oPC,FALSE );
                }
          break;}  //konec case 4

}   /// konec switche



}
