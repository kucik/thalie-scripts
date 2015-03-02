#include "ku_libtime"
//#include "no_ke_inc"
#include "no_nastcraft_ini"
#include "no_ke_functions"

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


if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() )  { //zacne jen kdyz je pec tepla

SetLocalInt(OBJECT_SELF,"no_slin",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_suro",0);   // suroviny jsou 1-pisek, 2-jil
SetLocalInt(OBJECT_SELF,"no_cist",55);   // cista - zda je jil, ci pisek vycistenej v peci.
SetLocalInt(OBJECT_SELF,"no_jil_pocet",0);
/////////////////////////
//no_menu:
//1 - cistit                 tag:no_cistit
//2 - vyrobit sklo           tag:no_sklo
//3 - vyrobit formu          tag:no_forma
//0 - zpet na start          tag:no_zpet
//
//////////////////////////



no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {  ///3.srpna - uz neni potreba struskotvornych prisad
            /// no_struska(no_Item,OBJECT_SELF);
            no_suro(no_Item,OBJECT_SELF,FALSE);   //nugety maji samy svoje resrefy a tagy, musi to byt zvlast
            break;
          }
case 2:  {  no_slin(no_Item,OBJECT_SELF, FALSE);
            no_cist(no_Item,OBJECT_SELF, FALSE);

            break;

          }
case 3:   { no_slin(no_Item,OBJECT_SELF,FALSE);
            no_cist(no_Item,OBJECT_SELF,FALSE);

            break;
           }

            } /// konec switche
//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////


/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
    if (GetResRef(no_Item) == "no_polot_ke") {
            int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }

                if (no_pocet_cyklu < 9) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_ke_delay,no_xp_ke(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_slin",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_suro",0);   // suroviny jsou 1-pisek, 2-jil
            SetLocalInt(OBJECT_SELF,"no_cist",55);   // cista - zda je jil, ci pisek vycistenej v peci.
            SetLocalInt(OBJECT_SELF,"no_jil_pocet",0);
            break;                  }///kdyz mame mene, nez 10cyklu

                //////////predelavka 1.9.2014/////////
                if (no_pocet_cyklu == 9) {
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
                //Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

            SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_ke_delay,no_xp_ke(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_slin",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_suro",0);   // suroviny jsou 1-pisek, 2-jil
            SetLocalInt(OBJECT_SELF,"no_cist",55);   // cista - zda je jil, ci pisek vycistenej v peci.
            SetLocalInt(OBJECT_SELF,"no_jil_pocet",0);
            break;                  }///kdyz mame mame presne 9 cyklu


        if   (no_pocet_cyklu >= 10) {

                  ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
                ///doplnena perzistence 5.5.2014
                //if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
                //Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF));
                //}



              SetLocalInt(no_Item,"no_pocet_cyklu",0);

                          SetLocalInt(OBJECT_SELF,"no_slin",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_suro",0);   // suroviny jsou 1-pisek, 2-jil
            SetLocalInt(OBJECT_SELF,"no_cist",55);   // cista - zda je jil, ci pisek vycistenej v peci.
            SetLocalInt(OBJECT_SELF,"no_jil_pocet",0);

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

//if (GetLocalInt(OBJECT_SELF,"no_slin") == 0)
//no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
//if (GetLocalInt(OBJECT_SELF,"no_jil_pocet") == 0)
//DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));
/// kdyz treba nekdo zapomnel slinovaci prisady c peci, tka at je tam ma zpatky..


if ( NO_KE_DEBUG == TRUE) SendMessageToPC(no_oPC,"Budeme vyhodnocovat s hodnotou:" + IntToString(GetLocalInt(OBJECT_SELF,"no_jil_pocet")));

switch(no_menu) {
case 1:  {

        if ( GetLocalInt(OBJECT_SELF,"no_suro") > 0   ) {
        FloatingTextStringOnCreature(" V peci se zacina cistit surovina",no_oPC,FALSE );
        no_zamkni(no_oPC);
        no_suro(no_Item,OBJECT_SELF,TRUE);
        no_switch = GetLocalInt(OBJECT_SELF,"no_suro");
// FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );

        DelayCommand(no_ke_delay,no_xp_cisteni(no_oPC,OBJECT_SELF,no_switch));    break;

        }  //konec kdyz mame struskotvorne prisady a kov
          }
case 2:  {       //2 - vyrobit sklo

         if (( GetLocalInt(OBJECT_SELF,"no_cist") == 1) & (GetLocalInt(OBJECT_SELF,"no_slin") > 0) )
         {
         FloatingTextStringOnCreature(" V peci se pisek rozpousti ve sklo",no_oPC,FALSE );
         no_zamkni(no_oPC);
         no_switch = GetLocalInt(OBJECT_SELF,"no_slin");
         // FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
         switch(no_switch) {
         case 2:  {  if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_lahev )  {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_sklo(no_oPC,OBJECT_SELF,2));  }
                         else  {FloatingTextStringOnCreature(" V peci je malo pisku na vyrobu lahve",no_oPC,FALSE );
                               //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin")); }
                               // DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));
                          }
                         break;   }

         case 4:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_ampule )  {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_sklo(no_oPC,OBJECT_SELF,4));               }
                        else { FloatingTextStringOnCreature(" V peci je malo pisku na vyrobu ampule",no_oPC,FALSE );
                               //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));               }
                               //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));
                            }
                         break;     }
                  } //konec vnitrniho switche
        }  //konec kdyz mame citej pisek i slinovaci prisady

            ///kdyz tam nekdo omylem da jen neco z toho..
          }
case 3:   {      //3 - vyrobit formy

         if (( GetLocalInt(OBJECT_SELF,"no_cist") == 2) & (GetLocalInt(OBJECT_SELF,"no_slin") > 0) )
         {
         FloatingTextStringOnCreature(" V peci se zacina vypalovat jil",no_oPC,FALSE );
         no_zamkni(no_oPC);
         no_switch = GetLocalInt(OBJECT_SELF,"no_slin");
         // FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
         switch(no_switch) {
         case 1:  {  if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_mala )  {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_jil(no_oPC,OBJECT_SELF,1));
                         break;}
                         else  { FloatingTextStringOnCreature(" V peci je malo pisku na vyrobu male formy",no_oPC,FALSE );
                                 //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
                                 //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));    }
                         }break;   }
/// case 2 = sklo !!
         case 3:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_tenk )  {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_jil(no_oPC,OBJECT_SELF,3));
                         }
                        else  {FloatingTextStringOnCreature(" V peci je malo jilu na vyrobu tenke formy",no_oPC,FALSE );
                              //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
                              //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));    }
                        } break;  }

/// case = sklo !!
         case 5:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_stre )  {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_jil(no_oPC,OBJECT_SELF,5));
                         }
                        else { FloatingTextStringOnCreature(" V peci je malo jilu na vyrobu stredni formy",no_oPC,FALSE );
                              //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
                              //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));         }
                         } break;  }
         case 6:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_velk )    {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_jil(no_oPC,OBJECT_SELF,6));
                         }
                        else  { FloatingTextStringOnCreature(" V peci je malo jilu na vyrobu velke formy",no_oPC,FALSE );
                              //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
                              //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));     }
                         } break;}
         case 7:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_zahn )     {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_jil(no_oPC,OBJECT_SELF,7));
                         }
                        else  { FloatingTextStringOnCreature(" V peci je malo jilu na vyrobu zahnute formy",no_oPC,FALSE );
                              //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
                              //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));         }
                        } break;   }
         case 8:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_jil_pocet") >= no_pocetskla_kuli )     {
                            no_slin(no_Item,OBJECT_SELF, TRUE);
                            no_cist(no_Item,OBJECT_SELF, TRUE);

                         DelayCommand(no_ke_delay,no_xp_jil(no_oPC,OBJECT_SELF,8));
                         }
                        else  { FloatingTextStringOnCreature(" V peci je malo jilu na vyrobu kulicek do praku",no_oPC,FALSE );
                              //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_jil_pocet"),GetLocalInt(OBJECT_SELF,"no_slin"));
                              //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_slin")));         }
                        } break;   }

                  } //konec vnitrniho switche
        }  //konec kdyz mame legury a cisty kov

          } //konec case kdyz mame formy

}   /// konec switche




}//kdyz je pec tepla
else  FloatingTextStringOnCreature(" Pec uhasina, chtelo by to vice uhli ",no_oPC,FALSE );

}
