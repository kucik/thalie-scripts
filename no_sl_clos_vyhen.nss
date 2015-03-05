#include "ku_libtime"
//#include "no_sl_inc"
#include "no_nastcraft_ini"
#include "no_sl_functions"

#include "ku_persist_inc"


//object no_Item;
object no_oPC;
int no_switch;
int no_menu;

void main()
{
  no_oPC=GetLastDisturbed();
///////////nomis nema rad neviditelne craftery (. //////////////
  effect no_effect=GetFirstEffect(no_oPC);
  while (GetIsEffectValid(no_effect)) {
    switch(GetEffectType(no_effect)) {
      case EFFECT_TYPE_INVISIBILITY:
      case EFFECT_TYPE_IMPROVEDINVISIBILITY:
      case EFFECT_TYPE_SANCTUARY:
        RemoveEffect(no_oPC,no_effect);
    }
    no_effect=GetNextEffect(no_oPC);
  }

/////////////////////////////////////////////////////////////////


  SetLocalInt(OBJECT_SELF,"no_MULTIKLIK",0);
//no_oPC=GetLastClosedBy();
TC_DestroyButtons(OBJECT_SELF); //znicime vsechny prepinace at tam pak pri otevreni nejsou 2x


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



    no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
    switch(no_menu) {
      case 1:  ///3.srpna - uz neni potreba struskotvornych prisad
            /// no_struska(no_Item,OBJECT_SELF);
        no_nuget(OBJECT_SELF, FALSE);   //nugety maji samy svoje resrefy a tagy, musi to byt zvlast
        break;
      case 2:  {
        no_legura(OBJECT_SELF,FALSE);
        no_cistykov(OBJECT_SELF,FALSE);
        break;
      }
    } /// konec switche
//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////





/////////////polotovar//////////////////////////////////////////////////////
    object no_Item = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(no_Item)) {
      if (GetResRef(no_Item) == "no_polot_sl") {
        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }

        if (no_pocet_cyklu == 9) {
           DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
           // No this is not a good idea for persistance.
           //Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.
        }
        
        SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
        SetLocalInt(OBJECT_SELF,"no_ruda",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
        SetLocalInt(OBJECT_SELF,"no_stru",56);   //tak to nehaze, ze no_ruda == no_stru + premaze minulou hodnotu
        SetLocalInt(OBJECT_SELF,"no_legu",57);
        SetLocalInt(OBJECT_SELF,"no_cist",58);
        SetLocalInt(OBJECT_SELF,"no_nale",59);
        SetLocalInt(OBJECT_SELF,"no_nale_pocet",0);
       
        if(no_pocet_cyklu <= 9) {
            no_zamkni(no_oPC);
            DelayCommand(no_sl_delay,no_xp_sl(no_oPC,OBJECT_SELF));
            break;
        }

        if   (no_pocet_cyklu >= 10) {

                               ////////////kdyz se prida neco do zarizeni/////////////////////////////////////////
                ///doplnena perzistence 5.5.2014
               // if (GetInventoryDisturbType()== INVENTORY_DISTURB_TYPE_ADDED) {
               // Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF));
               // }



          SetLocalInt(no_Item,"no_pocet_cyklu",0);

          AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0, 5.0));
          switch (d6()) {
            case 1: FloatingTextStringOnCreature(" To je ale namaha ! ",no_oPC,FALSE );
               break; 
            case 2: FloatingTextStringOnCreature(" Snad se z toho neupracuju ! ",no_oPC,FALSE );
               break;
            case 3: FloatingTextStringOnCreature(" Jeste chvilku a uz to bude ! ",no_oPC,FALSE );
               break;
            case 4: FloatingTextStringOnCreature(" Snad se tomu nic nestane ! ",no_oPC,FALSE );
               break; 
            case 5: FloatingTextStringOnCreature(" Uz jen kousek ! ",no_oPC,FALSE );
               break;
            case 6: FloatingTextStringOnCreature(" Uz aby to bylo ! ",no_oPC,FALSE );
               break; 
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
      case 1: 
        if ( GetLocalInt(OBJECT_SELF,"no_ruda") > 0   ) {
          FloatingTextStringOnCreature(" V peci se tavi ruda a necistoty vyplouvaji na povrch",no_oPC,FALSE );
          no_switch = GetLocalInt(OBJECT_SELF,"no_ruda");
          no_zamkni(no_oPC); //zamkne a prehraje animacku..
          no_nuget(OBJECT_SELF, TRUE);
          DelayCommand(no_sl_delay,no_xp_cisteni(no_oPC,OBJECT_SELF,no_switch));
          break;
        }  //konec kdyz mame struskotvorne prisady a kov
        break; 
      case 2:  {

        if ( GetLocalInt(OBJECT_SELF,"no_legu") == GetLocalInt(OBJECT_SELF,"no_cist")   ) {
          FloatingTextStringOnCreature(" V peci se cista ruda nasycuje legurama",no_oPC,FALSE );
            ////////////////////////////////
            ////Predat hraci pruty kovu
            ////////////////////////////////
          no_zamkni(no_oPC); //zamkne a prehraje animacku..

          no_switch = GetLocalInt(OBJECT_SELF,"no_legu");
          if  (GetLocalInt(OBJECT_SELF,"no_nale_pocet") >= no_pocetnaprut ) {
            no_legura(OBJECT_SELF,TRUE);
            no_cistykov(OBJECT_SELF,TRUE);
            DelayCommand(no_sl_delay,no_xp_pruty(no_oPC,OBJECT_SELF,no_switch));
          }
          else { 
            FloatingTextStringOnCreature(" V peci je malo nalegovaneho kovu pro vytvoreni prutu",no_oPC,FALSE );
          }


        }  //konec kdyz mame legury a cisty kov


        if ((GetLocalInt(OBJECT_SELF,"no_legu") != GetLocalInt(OBJECT_SELF,"no_cist"))&( GetLocalInt(OBJECT_SELF,"no_cist") != 58)) {
          FloatingTextStringOnCreature("Do pece je nutno umistit vycisteny kov a patricne legury",no_oPC,FALSE );
        }
        break;
      }
    }   /// konec switche




  }//kdyz je pec tepla
  else  {
    FloatingTextStringOnCreature(" Pec uhasina, chtelo by to vice uhli ",no_oPC,FALSE );
    DestroyObject(GetNearestObjectByTag("plc_flamesmall",OBJECT_SELF));
  }
}
