#include "ku_libtime"
//#include "no_sl_inc"
#include "no_nastcraft_ini"
#include "no_sl_functions"

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


SetLocalInt(OBJECT_SELF,"no_ruda",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_stru",56);   //tak to nehaze, ze no_ruda == no_stru + premaze minulou hodnotu
SetLocalInt(OBJECT_SELF,"no_legu",57);
SetLocalInt(OBJECT_SELF,"no_cist",58);
SetLocalInt(OBJECT_SELF,"no_nale",59);
SetLocalInt(OBJECT_SELF,"no_nale_pocet",0);
/////////////////////////
//no_menu:
//1 - cistit                 tag:no_cistit
//2 - legovat                tag:no_legovat
//3 - slevat slitiny         tag:no_slevat
//0 - zpet na start          tag:no_zpet
//
//////////////////////////




no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {  ///3.srpna - uz neni potreba struskotvornych prisad
            /// no_struska(no_Item,OBJECT_SELF);
            no_nuget(no_Item,OBJECT_SELF, FALSE);   //nugety maji samy svoje resrefy a tagy, musi to byt zvlast
            break;
          }
case 2:  {
            no_legura(no_Item,OBJECT_SELF,FALSE);
            no_cistykov(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 3:   {
           no_slitina(no_Item,OBJECT_SELF,FALSE);
           break;
           }

            } /// konec switche
//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////





int TC_sl_VLASTNOST  = GetAbilityScore(GetLastDisturbed(), ABILITY_CONSTITUTION,TRUE);
/////////je to v .ini ale nemohlo to v ini najit last distrurbed..




/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
if (GetResRef(no_Item) == "no_polot_sl") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }

                if (no_pocet_cyklu < 10) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_sl_delay,no_xp_sl(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_ruda",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_stru",56);   //tak to nehaze, ze no_ruda == no_stru + premaze minulou hodnotu
            SetLocalInt(OBJECT_SELF,"no_legu",57);
            SetLocalInt(OBJECT_SELF,"no_cist",58);
            SetLocalInt(OBJECT_SELF,"no_nale",59);
            SetLocalInt(OBJECT_SELF,"no_nale_pocet",0);
            break;   }///kdyz mame mene, nez 10cyklu

        if   (no_pocet_cyklu >= 10) {

                               ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
                ///doplnena perzistence 5.5.2014
                if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
                Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF));
                }



              SetLocalInt(no_Item,"no_pocet_cyklu",0);

            SetLocalInt(OBJECT_SELF,"no_ruda",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_stru",56);   //tak to nehaze, ze no_ruda == no_stru + premaze minulou hodnotu
            SetLocalInt(OBJECT_SELF,"no_legu",57);
            SetLocalInt(OBJECT_SELF,"no_cist",58);
            SetLocalInt(OBJECT_SELF,"no_nale",59);
            SetLocalInt(OBJECT_SELF,"no_nale_pocet",0);

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
//if (GetLocalInt(OBJECT_SELF,"no_legu") == 57)
//no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
//if (GetLocalInt(OBJECT_SELF,"no_nale_pocet") == 0)
//DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));
/// kdyz treba nekdo zapomnel slinovaci prisady c peci, tka at je tam ma zpatky..

//// kdyz nejsou ciste kovy,  vrati veci..

switch(no_menu) {
case 1:  {
        if ( GetLocalInt(OBJECT_SELF,"no_ruda") > 0   ) {
        FloatingTextStringOnCreature(" V peci se tavi ruda a necistoty vyplouvaji na povrch",no_oPC,FALSE );
        no_switch = GetLocalInt(OBJECT_SELF,"no_ruda");
        no_zamkni(no_oPC); //zamkne a prehraje animacku..
        no_nuget(no_Item,OBJECT_SELF, TRUE);
        DelayCommand(no_sl_delay,no_xp_cisteni(no_oPC,OBJECT_SELF,no_switch));
        break;
        }  //konec kdyz mame struskotvorne prisady a kov
         break; }
case 2:  {

        if ( GetLocalInt(OBJECT_SELF,"no_legu") == GetLocalInt(OBJECT_SELF,"no_cist")   ) {
        FloatingTextStringOnCreature(" V peci se cista ruda nasycuje legurama",no_oPC,FALSE );
            ////////////////////////////////
            ////Predat hraci pruty kovu
            ////////////////////////////////
         no_zamkni(no_oPC); //zamkne a prehraje animacku..

         no_switch = GetLocalInt(OBJECT_SELF,"no_legu");
         // FloatingTextStringOnCreature(" no_switch = " + IntToString(no_switch) ,no_oPC,FALSE );
         switch(no_switch) {
         case 1:  {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_tin ) {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,1));         }
                         else { FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               // no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               // DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu"))); }
                         }
                         break;   }
         case 2:   {
                        if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_copp ) {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,2)); }
                        else  {FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));       }
                         }
                         break;     }
         case 3:   {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_bron )  {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,3));}
                        else  {FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));     }

                         }
                         break;     }
         case 4:   {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_iron ) {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,4));  }
                         else  {FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));   }
                         }
                         break;     }
         case 5:   { if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_gold )   {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,5));}
                       else {FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                              //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                              //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));     }
                         }
                         break;     }
         case 6:   {if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_plat )   {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,6));  }
                         else  {FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));     }
                         }
                         break;     }
         case 7:   {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_mith ) {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,7)); }
                        else { FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                             //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                             // DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));      }
                        }
                        break;     }
         case 8:   {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_adam )   {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,8)); }
                        else { FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               // no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               // DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));    }
                        }
                        break;     }
         case 9:   {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_tita )   {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,9));}
                         else { FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                               // no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                               // DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu"))); }
                         }
                         break;     }
         case 10:  {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_silv )  {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,10));}
                         else  {FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                        //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                         //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));   }
                         }
                         break;     }
         case 11:  {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_stin )  {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                        DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,11));      }
                         else { FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                        //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                        //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));             }
                         }
                         break;     }
          case 12:  {  if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut_mete )  {
                          no_legura(no_Item,OBJECT_SELF,TRUE);
                          no_cistykov(no_Item,OBJECT_SELF,TRUE);
                         DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,12));   }
                         else  { FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
                         //no_vratveci(GetLocalInt(OBJECT_SELF,"no_cist"),GetLocalInt(OBJECT_SELF,"no_nale_pocet"),GetLocalInt(OBJECT_SELF,"no_cist"));
                         //DelayCommand(1.0,no_vratslin(GetLocalInt(OBJECT_SELF,"no_legu")));  }
                         }
                         break;     }
           break;     } //konec vnitrniho switche
        }  //konec kdyz mame legury a cisty kov


         if ((GetLocalInt(OBJECT_SELF,"no_legu") != GetLocalInt(OBJECT_SELF,"no_cist"))&( GetLocalInt(OBJECT_SELF,"no_cist") != 58)) {
              FloatingTextStringOnCreature("Do pece je nutno umistit vycisteny kov a patricne legury",no_oPC,FALSE );
                    }
          break;}
case 3:   {
            if ( GetLocalInt(OBJECT_SELF,"no_cist") > 100   )  {
            // jedna se o slitinu
            FloatingTextStringOnCreature(" V peci se zacinaji mysit kovy ",no_oPC,FALSE );
            no_slitina(no_Item,OBJECT_SELF,TRUE);
            no_zamkni(no_oPC); //zamkne a prehraje animacku..
            no_switch = GetLocalInt(OBJECT_SELF,"no_cist");
            switch(no_switch) {
            case 101:   { DelayCommand(no_sl_delay,no_xp_slevani(no_oPC,OBJECT_SELF,101)); break;  }
                } //konec vnitrniho switche
           } //konec if na zacatku

           if (( GetLocalInt(OBJECT_SELF,"no_cist") < 100 )&( GetLocalInt(OBJECT_SELF,"no_cist") != 58))  {
           FloatingTextStringOnCreature("Z danych ingredienci se neda vytvorit slitina",no_oPC,FALSE );    }
           break; }  //konec case 3
}   /// konec switche




}//kdyz je pec tepla
else  {FloatingTextStringOnCreature(" Pec uhasina, chtelo by to vice uhli ",no_oPC,FALSE );
       DestroyObject(GetNearestObjectByTag("plc_flamesmall",OBJECT_SELF));
      }
}
