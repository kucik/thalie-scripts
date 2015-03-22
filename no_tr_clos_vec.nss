#include "ku_libtime"
//#include "no_tr_inc_vec"
#include "no_nastcraft_ini"
#include "no_tr_func_vec"

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

SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
SetLocalInt(OBJECT_SELF,"no_drevo",0);
SetLocalInt(OBJECT_SELF,"no_tetiva",0);
SetLocalInt(OBJECT_SELF,"no_peri",0);
SetLocalInt(OBJECT_SELF,"no_nyty",0);
SetLocalInt(OBJECT_SELF,"no_vyrobek",0);
SetLocalString(OBJECT_SELF,"no_vyrobek","");


/////////////////////////
//no_menu:
//1 - Vyroba kratkych luku       tag: no_vyr_krluk
//2 - Vyroba slouhych luku       tag: no_vyr_dlluk
//3 - Vyroba malych kusi         tag: no_vyr_mlkus
//4 - Vyroba velkych kusi        tag: no_vyr_vlkus
//5 - Vyroba sipu                tag: no_vyr_sip
//6 - Vyroba sipek               tag: no_vyr_sipka
//7 - Vyroba stitu               tag: no_vyr_stit
//0 - Zpet na start              tag:no_zpet
//
//////////////////////////

no_Item = GetFirstItemInInventory(OBJECT_SELF);
no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
case 1:  {   //false = nesmazeme zadnou vec.
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_tetiva(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 2:  {
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_tetiva(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 3:  {
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_tetiva(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 4:  {
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_tetiva(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 5:  {        //sipy
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_peri(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 6:  {        //sipky
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_peri(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 7:  {        //male stity   ///////23 brezen 2009/////////////
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_nyty(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 8:  {        //velke stity
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_nyty(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }
case 9:  {        //pavezy
            no_pouzitykov(no_Item,OBJECT_SELF,FALSE);
            no_drevo(no_Item,OBJECT_SELF,FALSE);
            no_nyty(no_Item,OBJECT_SELF,FALSE);
            no_vyrobek(no_Item,OBJECT_SELF,FALSE);
            break;
          }


            } /// konec switche

//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////  V teto chvili jsme zjistili co je v peci. takze se jen vytvari pravdepodobnosti dane veci a pripadne vyrobky
/////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////tak a protoze stejnej skript na vecech, tak to musime rozlisit: ////////
//////// no_tr_koza: koza   no_tr_skopek : skopek/////////////////////////////////////////



/////////////polotovar//////////////////////////////////////////////////////
no_Item = GetFirstItemInInventory(OBJECT_SELF);
while (GetIsObjectValid(no_Item)) {
if (GetResRef(no_Item) == "no_polot_tr") {

        int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
        no_pocet_cyklu = no_pocet_cyklu+1;

        if (( GetLocalString(no_Item,"no_crafter")!= GetName(no_oPC) ) & (GetLocalString(no_Item,"no_crafter")!="") )
        {no_pocet_cyklu = no_pocet_cyklu +10;
         FloatingTextStringOnCreature("Nemuzes pokracovat v praci jineho  remeslnika ! ",no_oPC,FALSE );
        }

                if (no_pocet_cyklu < 9) {
                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_tr_delay,no_xp_tr(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_drevo",0);
            SetLocalInt(OBJECT_SELF,"no_tetiva",0);
            SetLocalInt(OBJECT_SELF,"no_vyrobek",0);
            SetLocalInt(OBJECT_SELF,"no_peri",0);
            SetLocalInt(OBJECT_SELF,"no_nyty",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            break; }///kdyz mame mene, nez 10cyklu

                //////////predelavka 1.9.2014/////////
                if (no_pocet_cyklu == 9) {
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
//                Persist_SaveItemToDB(no_Item, Persist_InitContainer(OBJECT_SELF)); //ulozim tam novou vec.

                SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
            no_zamkni(no_oPC);
            DelayCommand(no_tr_delay,no_xp_tr(no_oPC,OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_drevo",0);
            SetLocalInt(OBJECT_SELF,"no_tetiva",0);
            SetLocalInt(OBJECT_SELF,"no_vyrobek",0);
            SetLocalInt(OBJECT_SELF,"no_peri",0);
            SetLocalInt(OBJECT_SELF,"no_nyty",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");
            break; }///kdyz mame mene, nez 10cyklu


        if   (no_pocet_cyklu >= 10) {
              SetLocalInt(no_Item,"no_pocet_cyklu",0);

                          SetLocalInt(OBJECT_SELF,"no_pouzitykov",0);   //jenom nastavime jednu promenou na zacatek jinak, at kdyz je prazdna
            SetLocalInt(OBJECT_SELF,"no_drevo",0);
            SetLocalInt(OBJECT_SELF,"no_tetiva",0);
            SetLocalInt(OBJECT_SELF,"no_vyrobek",0);
            SetLocalInt(OBJECT_SELF,"no_peri",0);
            SetLocalInt(OBJECT_SELF,"no_nyty",0);
            SetLocalString(OBJECT_SELF,"no_vyrobek","");




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




no_menu = GetLocalInt(OBJECT_SELF,"no_menu");
switch(no_menu) {
/////////////////1-vyroba bot//////////////////////////////////////
case 1:  {

        if ((GetLocalInt(OBJECT_SELF,"no_drevo") >0))
        // vyrobime luk bez dmg.
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit kratky luk",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_krluk(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo")));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_tetiva") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar krluku, ale mame vse pro pridani tetivy, tak ji tam prdnem
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit kratky luk",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }

          }
case 2: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// vyrobime polotovar boty
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit dlouhy luk",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_dlluk(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo")));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_tetiva") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit dlouhy luk",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }

          }
case 3: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// vyrobime polotovar boty
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit malou kusi",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_mlkus(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo")));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_tetiva") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit malou kusi",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }

          }
case 4: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// vyrobime polotovar boty
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit velkou kusi",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_vlkus(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo")));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_tetiva") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit velkou kusi",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }

          }
case 5: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)//sipy
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit sipy",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_sipy(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo")));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_peri") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit sipy",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }
        else if ((GetLocalInt(OBJECT_SELF,"no_pouzitykov") ==0)&(GetLocalInt(OBJECT_SELF,"no_peri") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {FloatingTextStringOnCreature(" Chtelo by to prut kovu",no_oPC,FALSE );;
        break;

          }   }
case 6: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// sipky
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit sipky",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_sipky(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo")));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_peri") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit sipky",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }
        else if ((GetLocalInt(OBJECT_SELF,"no_pouzitykov") ==0)&(GetLocalInt(OBJECT_SELF,"no_peri") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {FloatingTextStringOnCreature(" Chtelo by to prut kovu",no_oPC,FALSE );;
        break;
          }
        }
/////////////23 brezen 09- vsechny stity //////////////////
case 7: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// stity
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit maly stit",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_stit(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo"),1));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_nyty") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit maly stit",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }
        else if ((GetLocalInt(OBJECT_SELF,"no_pouzitykov") ==0)&(GetLocalInt(OBJECT_SELF,"no_nyty") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {FloatingTextStringOnCreature(" Chtelo by to prut kovu",no_oPC,FALSE );;
        break;
          }
        }

case 8: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// stity
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit velky stit",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_stit(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo"),2));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_nyty") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit velky stit",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }
        else if ((GetLocalInt(OBJECT_SELF,"no_pouzitykov") ==0)&(GetLocalInt(OBJECT_SELF,"no_nyty") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {FloatingTextStringOnCreature(" Chtelo by to prut kovu",no_oPC,FALSE );;
        break;
          }
        }
case 9: {
        if ( GetLocalInt(OBJECT_SELF,"no_drevo")>0)// stity
        {
        FloatingTextStringOnCreature(" Snazis se vyrobit pavezu",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_stit(no_oPC,OBJECT_SELF,GetLocalInt(OBJECT_SELF,"no_drevo"),3));
        break;
        }
        else if((GetLocalInt(OBJECT_SELF,"no_pouzitykov") >0)&(GetLocalInt(OBJECT_SELF,"no_nyty") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {
        FloatingTextStringOnCreature(" Snazis se dokoncit pavezu",no_oPC,FALSE );
        no_zamkni(no_oPC);
        DelayCommand(no_tr_delay,no_xp_pridej_tetivu(no_oPC,OBJECT_SELF));
        break;
        }
        else if ((GetLocalInt(OBJECT_SELF,"no_pouzitykov") ==0)&(GetLocalInt(OBJECT_SELF,"no_nyty") >0)&(GetLocalString(OBJECT_SELF,"no_vyrobek")!="") )
        /// kdyz nevyrobime polotovar boty, ale mame vse pro pridani kamene, tak ho pridame..
        {FloatingTextStringOnCreature(" Chtelo by to prut kovu",no_oPC,FALSE );;
        break;
          }
        }


}   /// konec switche


}

