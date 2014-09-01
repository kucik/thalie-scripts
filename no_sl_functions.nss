#include "ku_libtime"
//#include "no_sl_inc"
#include "tc_xpsystem_inc"
#include "no_nastcraft_ini"

#include "ku_persist_inc"

int no_pocet;
string no_nazev;
int no_DC;


void no_snizstack(object no_Item, int no_mazani);
////snizi pocet ve stacku. Kdyz je posledni, tak ho znici

void no_legura(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_legu na objectu no_pec na hodnotu legury
void no_cistykov(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_cist na objectu no_pec na hodnotu cisteho kovu
// no_nale_pocet  : pocet rudy
void no_slitina(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_cist >100 kdyz je v peci vice kovu a maji spolu tvorit slitiny
void no_nuget(object no_Item, object no_pec, int no_mazani);
// nastavi promenou no_ruda na objectu no_pec na hodnotu nugetu kovu
void no_pridatuhli(object no_Item, object no_pec);
//pridame uhli a zdelsime tak cas horeni pece
void no_reopen(object no_oPC);
// preotevreni inventare prevzate z kovariny
void no_znicit(object no_oPC);
// znici tlacitka z inventare
void no_zamkni(object no_oPC);
// zamkne a pak odemkne + prehrava animacku

/////////////////////////////////////////////////////////////////////////////////////
/////////////   Funkce ne reseni xpu a lvlu craftu
/////////////
//////////////////////////////////////////////////////////////////////////////////////
void no_xp_sl(object no_oPC, object no_pec);
///zpracuje polotovar a preda xpy.
void no_xp_cisteni(object no_oPC, object no_pec, int no_kov);
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
void no_xp_legovani(object no_oPC, object no_pec, int no_kov);
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
void no_xp_pruty(object no_oPC, object no_pec, int no_kov);





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


void no_legura(object no_Item, object no_pec, int no_mazani)
{      //legury
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

if (GetStringLeft(GetTag(no_Item),7) == "no_legu" ) {
           if(GetTag(no_Item) == "no_legu_tin")           //do promene no_stru ulozime nazev prisady
    { SetLocalInt(no_pec,"no_legu",1);
    no_snizstack(no_Item,no_mazani);                          //znicime prisadu
    break;      }
           if(GetTag(no_Item) == "no_legu_copp")
    { SetLocalInt(OBJECT_SELF,"no_legu",2);
    no_snizstack(no_Item,no_mazani);
    break;      }
           if(GetTag(no_Item) == "no_legu_bron")
    { SetLocalInt(OBJECT_SELF,"no_legu",3);
  no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_iron")
    { SetLocalInt(OBJECT_SELF,"no_legu",4);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_gold")
    { SetLocalInt(OBJECT_SELF,"no_legu",5);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_plat")
    { SetLocalInt(OBJECT_SELF,"no_legu",6);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_mith")
    { SetLocalInt(OBJECT_SELF,"no_legu",7);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_adam")
    { SetLocalInt(OBJECT_SELF,"no_legu",8);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_tita")
    { SetLocalInt(OBJECT_SELF,"no_legu",9);
    no_snizstack(no_Item,no_mazani);
    break;      }
               if(GetTag(no_Item) == "no_legu_silv")
    { SetLocalInt(OBJECT_SELF,"no_legu",10);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetTag(no_Item) == "no_legu_stin")
    { SetLocalInt(OBJECT_SELF,"no_legu",11);
    no_snizstack(no_Item,no_mazani);
    break;      }
                   if(GetTag(no_Item) == "no_legu_mete")
    { SetLocalInt(OBJECT_SELF,"no_legu",12);
    no_snizstack(no_Item,no_mazani);
    break;      }

}//kdyz legura

  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }  //tak uz mame legury
}




void no_slitina(object no_Item, object no_pec, int no_mazani)   {
no_Item=GetFirstItemInInventory(no_pec);
//SendMessageToPC(no_oPC,"zaciname no_slitina s parametrem no_mazani: "+ IntToString(no_mazani) );
SetLocalInt(no_pec,"no_cist",0);
while(GetIsObjectValid(no_Item))  {


//SendMessageToPC(no_oPC,"object je valid + mazani=: "+ IntToString(no_mazani) );
   ////////kdyz mame cin ///////////////////
         if(GetResRef(no_Item) == "no_cist_tin")
         {     // SendMessageToPC(no_oPC,"mame cinovej nuget + mazani=: "+ IntToString(no_mazani) );
                if ( (GetLocalInt(no_pec,"no_cist") == 2 )& (GetLocalInt(no_pec,"no_cist") != 101)    )
                                                           {SetLocalInt(no_pec,"no_cist",101);
                                                          no_snizstack(no_Item,no_mazani);
                                                          break;}
                           //slitina tin+copp je bronz a ulozime tuto slitinu do 101
                if (GetLocalInt(no_pec,"no_cist")!= 2 )  { SetLocalInt(no_pec,"no_cist",1);
                                                           no_snizstack(no_Item,no_mazani); }
         }

    ////////kdyz mame copper///////////////
        if(GetResRef(no_Item) == "no_cist_copp")
        {       //SendMessageToPC(no_oPC,"mame copper nuget + mazani=: "+ IntToString(no_mazani) );
                if ((GetLocalInt(no_pec,"no_cist") == 1 )  & (GetLocalInt(no_pec,"no:cist") != 101)    )
                                                            {SetLocalInt(no_pec,"no_cist",101);
                                                          no_snizstack(no_Item,no_mazani);
                                                          break;}
                        //slitina tin+copp je bronz a ulozime tuto slitinu do 101.
                if (GetLocalInt(no_pec,"no_cist") != 1 ) {SetLocalInt(no_pec,"no_cist",2);
                                                          no_snizstack(no_Item,no_mazani);   }
        }

  no_Item = GetNextItemInInventory(no_pec);
  }
}



void no_nuget(object no_Item, object no_pec, int no_mazani)
{
no_Item = GetFirstItemInInventory(no_pec);
while(GetIsObjectValid(no_Item))  {

    if(GetTag(no_Item) == "cnrNuggetTin")           // do promene no_ruda ulozime nazev rudy
    { SetLocalInt(no_pec,"no_ruda",1);
        no_snizstack(no_Item,no_mazani);                      // znicime rudu
    break;      }
    if(GetTag(no_Item) == "cnrNuggetCopp")
    { SetLocalInt(no_pec,"no_ruda",2);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetVerm")
    { SetLocalInt(no_pec,"no_ruda",3);
        DestroyObject(no_Item);


//3= bronz
    break;      }
      if(GetTag(no_Item) == "cnrNuggetIron")
    {
        SetLocalInt(no_pec,"no_ruda",4);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetGold")
    { SetLocalInt(no_pec,"no_ruda",5);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetPlat")
    { SetLocalInt(no_pec,"no_ruda",6);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetMith")
    { SetLocalInt(no_pec,"no_ruda",7);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetAdam")
    { SetLocalInt(no_pec,"no_ruda",8);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetTita")
    { SetLocalInt(no_pec,"no_ruda",9);
        no_snizstack(no_Item,no_mazani);
    break;      }
      if(GetTag(no_Item) == "cnrNuggetSilv")
    { SetLocalInt(no_pec,"no_ruda",10);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetResRef(no_Item) == "tc_nug_stin")
    { SetLocalInt(no_pec,"no_ruda",11);
        no_snizstack(no_Item,no_mazani);
    break;      }
          if(GetResRef(no_Item) == "tc_nug_meteor")
    { SetLocalInt(no_pec,"no_ruda",12);
        no_snizstack(no_Item,no_mazani);
    break;      }

  no_Item = GetNextItemInInventory(no_pec);
  }
}


void no_cistykov(object no_Item, object no_pec, int no_mazani)
///////////////////////////////////////////
//// vystup:  no_cist       cislo urci kov
//////        no_nale_pocet  ulozeno pocet daneho naleg.kovu
////////////////////////////////////////////
 {


no_Item = GetFirstItemInInventory(no_pec);
int no_pocet = 0;

while (GetIsObjectValid(no_Item)) {

 if(GetTag(no_Item) != "no_cist") {   //kdyz neni nalegovany kov, tak pokracujeme ve vybirani

 no_Item = GetNextItemInInventory(no_pec);
 continue;
         }

 if (GetResRef(no_Item) == "no_cist_tin" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 1)
                  no_pocet ++; //kdyz sou stejne pricte 1
                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se na jedna
                   SetLocalInt(no_pec,"no_cist",1);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }                          }
 if (GetResRef(no_Item) == "no_cist_copp" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 2)
                  no_pocet++; //kdyz sou stejne pricte 1
                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",2);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }                          }
 if (GetResRef(no_Item) == "no_cist_bron" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 3)
                  no_pocet++; //kdyz sou stejne pricte 1

                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",3);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_iron" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 4)
                  no_pocet ++; //kdyz sou stejne pricte 1

                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",4);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_gold" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 5)
                  no_pocet ++; //kdyz sou stejne pricte 1

                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",5);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_plat" ) {
            if ( no_pocet>= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 6)
                  no_pocet ++; //kdyz sou stejne pricte 1

                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",6);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_mith" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 7)
                  no_pocet ++; //kdyz sou stejne pricte 1

                                }
            else { no_pocet =1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",7);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_adam" ) {
            if ( no_pocet>= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 8)
                  no_pocet ++; //kdyz sou stejne pricte 1
                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",8);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_tita" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 9)
                  no_pocet ++; //kdyz sou stejne pricte 1

                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",9);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_silv" ) {
            if ( no_pocet>= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 10)
                  no_pocet++; //kdyz sou stejne pricte 1
                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",10);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_stin" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 11)
                  no_pocet ++; //kdyz sou stejne pricte 1
                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",11);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}
 if (GetResRef(no_Item) == "no_cist_mete" ) {
            if ( no_pocet >= 1) {
                  if (GetLocalInt(no_pec,"no_cist") == 12)
                  no_pocet ++; //kdyz sou stejne pricte 1
                                }
            else { no_pocet = 1; //kdyz je no_pocet=0 zvysi se o jedna
                   SetLocalInt(no_pec,"no_cist",12);
                   no_snizstack(no_Item,no_mazani);
                   break;
                 }}


     //    no_snizstack(no_Item,no_mazani);
         no_Item = GetNextItemInInventory(no_pec);



    } //if je valid no_Item

SetLocalInt(no_pec,"no_nale_pocet",no_pocet);
}


void BurnUpTheCoal(object oFire, object oPlume1, object oPlume2)
{
  int nCoalCount = GetLocalInt(OBJECT_SELF, "CnrCoalCount") - 1;
  SetLocalInt(OBJECT_SELF, "CnrCoalCount", nCoalCount);
  if (nCoalCount > 0)
  {
    DelayCommand(300.0, BurnUpTheCoal(oFire, oPlume1, oPlume2));
  }
  else
  {
    // the coal is gone, so put out the fire
    DestroyObject(oFire);
    DestroyObject(oPlume1);
    DestroyObject(oPlume2);

    object oSound = GetNearestObjectByTag("cnrForgeFire");
    if (oSound != OBJECT_INVALID)
    {
      SoundObjectStop(oSound);
    }

  }
}

void tc_armplayanimation(object oPC, int iCraftType);


float CnrNormalizeFacing(float fFacing)
{
  while (fFacing >= 360.0) fFacing -= 360.0;
  while (fFacing < 0.0) fFacing += 360.0;
  return fFacing;
}


////////////////pridavame uhli /////////////////////////////////////////////////////////////////
void no_pridatuhli(object no_Item, object no_pec)
   {
no_oPC=GetLastDisturbed();
no_Item = GetFirstItemInInventory(OBJECT_SELF);    //zjistime, zda je ve vyhni uhli
while(GetIsObjectValid(no_Item))  {
  if(GetTag(no_Item) == "cnrLumpOfCoal")
    break;
  no_Item = GetNextItemInInventory(OBJECT_SELF);
  }


if (GetIsObjectValid(no_Item)) {  //kdyz mame uhli

//////////////////////////////////////////////

if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() ) {//bylo tam pred driv nez minutou dane uhli
FloatingTextStringOnCreature("Pridavas dalsi uhli, presto pec nehori o moc hure, nez pred chvili.",no_oPC,FALSE);
DestroyObject(GetNearestObjectByTag("plc_flamesmall",OBJECT_SELF));

}
else  { FloatingTextStringOnCreature(" Uhli se krasne rozhorelo",no_oPC,FALSE );   }
// budto horime od zacatku, nebo to znovu nastavi cas horeni od ted na 1minutu
////////////pridano od melvika/////////////



      int nCoalCount = GetLocalInt(OBJECT_SELF, "CnrCoalCount") + 1;
      SetLocalInt(OBJECT_SELF, "CnrCoalCount", nCoalCount);
      if (nCoalCount == 1)
      {
        // Create and position the fire
        location locForge = GetLocation(OBJECT_SELF);
        float fForgeFacing = GetFacingFromLocation(locForge);
        fForgeFacing = CnrNormalizeFacing(fForgeFacing);

        // Note: the Forge's arrow points the opposite direction of fForgeFacing.
        float fFireFacing = fForgeFacing + 180.0;
        fFireFacing = CnrNormalizeFacing(fFireFacing);

        // find a position and facing fDistance meters towards the back of the object.
        float fDistance = 0.4f;
        float fDistanceY = sin(fFireFacing) * fDistance;
        float fDistanceX = cos(fFireFacing) * fDistance;
        vector vFire = GetPosition(OBJECT_SELF);
        vFire.x = vFire.x - fDistanceX;
        vFire.y = vFire.y - fDistanceY;
        vFire.z = vFire.z + 0.2f;

        location locFire = Location(GetArea(OBJECT_SELF), vFire, fFireFacing);
        object oFire = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_flamesmall", locFire, FALSE);
        object oPlume1 = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", locFire, FALSE);
        object oLight1 = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_lightshft006", locFire, FALSE);
        DelayCommand(900.0, DestroyObject(oLight1));

        // Note: the Forge's arrow points the opposite direction of fForgeFacing.
        float fPlumeFacing = fForgeFacing + 135.0;
        fPlumeFacing = CnrNormalizeFacing(fPlumeFacing);

        // find a position and facing fDistance meters towards the back of the object.
        fDistance = 0.75f;
        fDistanceY = sin(fPlumeFacing) * fDistance;
        fDistanceX = cos(fPlumeFacing) * fDistance;
        vector vPlume = GetPosition(OBJECT_SELF);
        vPlume.x = vPlume.x - fDistanceX;
        vPlume.y = vPlume.y - fDistanceY;
        vPlume.z = vPlume.z + 3.2f;

        location locPlume = Location(GetArea(OBJECT_SELF), vPlume, 0.0);
        object oPlume2 = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", locPlume, FALSE);

        object oSound = GetNearestObjectByTag("cnrForgeFire");
        if (oSound != OBJECT_INVALID)
        {
          SoundObjectPlay(oSound);
        }

        // the PC just put the first coal nugget into the forge
        DelayCommand(900.0, BurnUpTheCoal(oFire, oPlume1, oPlume2));
      }


SetLocalInt(OBJECT_SELF,"no_sl_horipec",ku_GetTimeStamp(0,15));      // bude horet 5minut


DestroyObject(no_Item);   //znicime uhli


}    //konec  kdyz mame uhli
}



////////z kovariny prevzate preotevreni pece s upravami  ////////////////////////////////////////
void no_reopen(object no_oPC)
{
AssignCommand(no_oPC,DoPlaceableObjectAction(OBJECT_SELF,PLACEABLE_ACTION_USE));
//   AssignCommand(oPC,DelayCommand(1.0,DoPlaceableObjectAction(GetNearestObjectByTag(GetTag(oSelf),oPC,1),PLACEABLE_ACTION_USE)));

}


////////Znici tlacitka z inventare ///////////////////////
void no_znicit(object no_oPC)
{
no_Item = GetFirstItemInInventory(no_oPC);

 while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != "prepinac001") {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 001
 }
 DestroyObject(no_Item);


 no_Item = GetNextItemInInventory(no_oPC);
}

no_Item = GetFirstItemInInventory(no_oPC);
 while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != "prepinac003") {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;     //znicim vsechny prepinace 003
 }
 DestroyObject(no_Item);


 no_Item = GetNextItemInInventory(no_oPC);
}

}


void no_zamkni(object no_oPC)
// zamkne a pak odemkne + prehrava animacku
{
ActionLockObject(OBJECT_SELF);
AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, no_sl_delay));
AssignCommand(no_oPC, SetCommandable(FALSE));
DelayCommand(no_sl_delay,ActionUnlockObject(OBJECT_SELF));
DelayCommand(no_sl_delay-1.0,AssignCommand(no_oPC, SetCommandable(TRUE)));
PlaySound("al_cv_firesmldr1");
}

///////////////////////////////Predelavam polotovar///////////////////////////////////////////////////////
/////////zjisti pravdepodobnost, prideli xpy, prida %hotovosti vyrobku a kdz bude nad 100% udela jej hotovym.
void no_xp_sl (object no_oPC, object no_pec)
{

int no_druh=0;
no_Item = GetFirstItemInInventory(no_pec);
while (GetIsObjectValid(no_Item)) {

if (GetResRef(no_Item) == "no_polot_sl") {
    if(GetTag(no_Item) == "no_sl_tin")  {  no_druh=1; break;      }
    if(GetTag(no_Item) == "no_sl_copp")  {   no_druh=2; break;      }
    if(GetTag(no_Item) == "no_sl_bron")  {  no_druh=3; break;      }
    if(GetTag(no_Item) == "no_sl_iron")  {  no_druh=4; break;      }
    if(GetTag(no_Item) == "no_sl_gold")  {  no_druh=5; break;      }
    if(GetTag(no_Item) == "no_sl_plat")  {  no_druh=6; break;      }
    if(GetTag(no_Item) == "no_sl_mith")  {  no_druh=7; break;      }
    if(GetTag(no_Item) == "no_sl_adam")  {  no_druh=8; break;      }
    if(GetTag(no_Item) == "no_sl_tita")  {  no_druh=9; break;      }
    if(GetTag(no_Item) == "no_sl_silv")  {  no_druh=10; break;      }
    if(GetTag(no_Item) == "no_sl_stin")  {  no_druh=11; break;      }
    if(GetTag(no_Item) == "no_sl_mete")  {  no_druh=12; break;      }
    //nad 50= nalegovane
    if(GetTag(no_Item) == "no_sl_n_tin")  {  no_druh=51; break;      }
    if(GetTag(no_Item) == "no_sl_n_copp")  {  no_druh=52; break;      }
    if(GetTag(no_Item) == "no_sl_n_bron")  {  no_druh=53; break;      }
    if(GetTag(no_Item) == "no_sl_n_iron")  {  no_druh=54; break;      }
    if(GetTag(no_Item) == "no_sl_n_gold")  {  no_druh=55; break;      }
    if(GetTag(no_Item) == "no_sl_n_plat")  {  no_druh=56; break;      }
    if(GetTag(no_Item) == "no_sl_n_mith")  {  no_druh=57; break;      }
    if(GetTag(no_Item) == "no_sl_n_adam")  {  no_druh=58; break;      }
    if(GetTag(no_Item) == "no_sl_n_tita")  {  no_druh=59; break;      }
    if(GetTag(no_Item) == "no_sl_n_silv")  {  no_druh=60; break;      }
    if(GetTag(no_Item) == "no_sl_n_stin")  {  no_druh=61; break;      }
    if(GetTag(no_Item) == "no_sl_n_mete")  {  no_druh=62; break;      }
    //nad 100  slitiny
    if(GetTag(no_Item) == "no_sl_s_bron")  {  no_druh=101; break;      }


    }//pokud resref = no_polot_ko      - pro zrychleni ifu...
  no_Item = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
if (no_druh>0 ) {

////6brezen/////
if  (GetLocalFloat(no_Item,"no_suse_proc")==0.0) SetLocalFloat(no_Item,"no_suse_proc",10.0);

int no_level = TC_getLevel(no_oPC,TC_MELTING);
switch(no_druh) {
        case 1:   no_DC =  no_obt_cist_tin -(10*no_level );    break;
        case 2:   no_DC =  no_obt_cist_copp -( 10*no_level );    break;
        case 3:   no_DC =  no_obt_cist_bron -( 10*no_level );    break;
        case 4:   no_DC =  no_obt_cist_iron -( 10*no_level );    break;
        case 5:   no_DC =  no_obt_cist_gold -( 10*no_level );    break;
        case 6:   no_DC =  no_obt_cist_plat -( 10*no_level );    break;
        case 7:   no_DC =  no_obt_cist_mith -( 10*no_level );    break;
        case 8:   no_DC =  no_obt_cist_adam -( 10*no_level );    break;
        case 9:   no_DC =  no_obt_cist_tita -( 10*no_level );    break;
        case 10:   no_DC =  no_obt_cist_silv -( 10*no_level );    break;
        case 11:   no_DC =  no_obt_cist_stin -( 10*no_level );    break;
        case 12:   no_DC =  no_obt_cist_mete -( 10*no_level );    break;
            //nad 50= namorene
        case 51:   no_DC =  no_obt_nale_tin -( 10*no_level );    break;
        case 52:   no_DC =  no_obt_nale_copp -( 10*no_level );    break;
        case 53:   no_DC =  no_obt_nale_bron -( 10*no_level );    break;
        case 54:   no_DC =  no_obt_nale_iron -( 10*no_level );    break;
        case 55:   no_DC =  no_obt_nale_gold -( 10*no_level );    break;
        case 56:   no_DC =  no_obt_nale_plat -( 10*no_level );    break;
        case 57:   no_DC =  no_obt_nale_mith -( 10*no_level );    break;
        case 58:   no_DC =  no_obt_nale_adam -( 10*no_level );    break;
        case 59:   no_DC =  no_obt_nale_tita -( 10*no_level );    break;
        case 60:   no_DC =  no_obt_nale_silv -( 10*no_level );    break;
        case 61:   no_DC =  no_obt_nale_stin -( 10*no_level );    break;
        case 62:   no_DC =  no_obt_nale_mete -( 10*no_level );    break;
        //nad 100  slitiny
        case 101:  no_DC =  no_obt_slev_bron -( 10*no_level );    break;
                } //konec vnitrniho  switche
 //obtiznost kovu -5*lvlu

// pravdepodobnost uspechu =
int no_chance = 100 - (no_DC*2) ;
if (no_chance < 0) no_chance = 0;
//SendMessageToPC(no_oPC," Sance uspechu :" + IntToString(no_chance));
//samotny hod
int no_hod = 101-d100();
//SendMessageToPC(no_oPC," Hodils :" + IntToString(no_hod));

if (no_hod <= no_chance ) {

         float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");
        SendMessageToPC(no_oPC,"===================================");
        if (no_chance >= 100) {FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
                         //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
                         TC_setXPbyDifficulty(no_oPC,TC_MELTING,no_chance,TC_dej_vlastnost(TC_MELTING,no_oPC));
                         }

        if ((no_chance > 0)&(no_chance<100)) { TC_setXPbyDifficulty(no_oPC,TC_MELTING,no_chance,TC_dej_vlastnost(TC_MELTING,no_oPC));
                            }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
        //no_procenta = no_procenta + 10+ d20() + no_level ;  // = 12-45
             int no_obtiznost_vyrobku = no_DC+( 10*no_level );

            if (no_obtiznost_vyrobku >=190) {
            no_procenta = no_procenta + 0.1 ;}
            else if ((no_obtiznost_vyrobku <190)&(no_obtiznost_vyrobku>=180)) {
            no_procenta = no_procenta + 0.2 ;}
            else if ((no_obtiznost_vyrobku <180)&(no_obtiznost_vyrobku>=170)) {
            no_procenta = no_procenta + Random(4)/10.0 ;}
           else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta + Random(6)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.1;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.2;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.3;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta + Random(20)/10.0 +0.5;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.0;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta + Random(20)/10.0 +1.5;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.0;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta + Random(20)/10.0 +2.5;}
            else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta + Random(20)/10.0 +3.0;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta + Random(20)/10.0 +3.5;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta + Random(20)/10.0+ 4.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta + Random(20)/10.0 +4.5;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta + Random(20)/10.0 +5.0;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta + Random(20)/10.0 + 5.5;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta+ Random(20)/10.0 +6.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta + Random(20)/10.0 +10.0;}

                        if  (GetIsDM(no_oPC)== TRUE) no_procenta = no_procenta + 50.0;

        if (no_procenta >= 100.0) {  //kdyz je vyrobek 100% tak samozrejmeje hotovej

        AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));

        DestroyObject(no_Item); //znicim ho, protoze predam hotovej vyrobek
                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru

        switch(no_druh) {
        case 1:   {SetLocalInt(CreateItemOnObject("no_cist_tin",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_tin*no_sl_nasobitel2));
                    FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 2:   {SetLocalInt(CreateItemOnObject("no_cist_copp",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_copp*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 3:  { SetLocalInt(CreateItemOnObject("no_cist_bron",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_bron*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 4:  { SetLocalInt(CreateItemOnObject("no_cist_iron",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_iron*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 5:   {SetLocalInt(CreateItemOnObject("no_cist_gold",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_gold*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 6:   {SetLocalInt(CreateItemOnObject("no_cist_plat",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_plat*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 7:   {SetLocalInt(CreateItemOnObject("no_cist_mith",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_mith*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 8:   {SetLocalInt(CreateItemOnObject("no_cist_adam",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_adam*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 9:   {SetLocalInt(CreateItemOnObject("no_cist_tita",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_tita*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 10:  {SetLocalInt(CreateItemOnObject("no_cist_silv",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_silv*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 11:  {SetLocalInt(CreateItemOnObject("no_cist_stin",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_stin*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 12:  {SetLocalInt(CreateItemOnObject("no_cist_mete",no_oPC,1,"no_cist"),"tc_cena",FloatToInt(no_cena_mete*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
///////////////////nad 50= namorene////////////////////////////////////////////////////////
        case 51:   {SetLocalInt(CreateItemOnObject("tc_prut1",no_oPC,1),"tc_cena",FloatToInt(no_cena_tin*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 52:   {SetLocalInt(CreateItemOnObject("tc_prut2",no_oPC,1),"tc_cena",FloatToInt(no_cena_copp*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 53:  { SetLocalInt(CreateItemOnObject("tc_prut3",no_oPC,1),"tc_cena",FloatToInt(no_cena_bron*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 54:  { SetLocalInt(CreateItemOnObject("tc_prut4",no_oPC,1),"tc_cena",FloatToInt(no_cena_iron*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 55:   {SetLocalInt(CreateItemOnObject("tc_prut11",no_oPC,1),"tc_cena",FloatToInt(no_cena_gold*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 56:   {SetLocalInt(CreateItemOnObject("tc_prut8",no_oPC,1),"tc_cena",FloatToInt(no_cena_plat*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 57:  { SetLocalInt(CreateItemOnObject("tc_prut7",no_oPC,1),"tc_cena",FloatToInt(no_cena_mith*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 58:  { SetLocalInt(CreateItemOnObject("tc_prut5",no_oPC,1),"tc_cena",FloatToInt(no_cena_adam*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 59:  { SetLocalInt(CreateItemOnObject("tc_prut10",no_oPC,1),"tc_cena",FloatToInt(no_cena_tita*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 60: { SetLocalInt(CreateItemOnObject("tc_prut9",no_oPC,1),"tc_cena",FloatToInt(no_cena_silv*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 61: {  SetLocalInt(CreateItemOnObject("tc_prut12",no_oPC,1),"tc_cena",FloatToInt(no_cena_stin*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        case 62:  { SetLocalInt(CreateItemOnObject("tc_prut13",no_oPC,1),"tc_cena",FloatToInt(no_cena_mete*no_sl_nasobitel));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
//////////////////////////nad 100 slitiny//////////////////////////////////
        case 101: { SetLocalInt(CreateItemOnObject("no_cist_bron",no_oPC,1),"tc_cena",FloatToInt(no_cena_bron*no_sl_nasobitel2));
          FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
                  break;   }
        }  ///konec case
                }//konec kdzy uz mam nad 100%

        if (no_procenta < 100.0) {  //kdyz neni 100% tak samozrejmeje neni hotovej

         if ( GetLocalInt(no_Item,"no_pocet_cyklu") == 9 ) {TC_saveCraftXPpersistent(no_oPC,TC_MELTING);}

        string no_nazev_procenta = FloatToString(no_procenta);

        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

        switch(no_druh) {
        case 1:  {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny cin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena med *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena bronz *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistene zelezo *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistene zlato*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena platina*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny mithril *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny adamantin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 9: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny titan *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 10: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistene stribro *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 11: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena stinova ocel *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 12: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena meteoriticka ocel *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
////////////////nad50= louhovane kuze////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut cinu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut medi *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut vermajlu *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut zeleza *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut zlata *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut platiny *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 57: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut mithrilu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 58: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut adamantinu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 59: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut titanu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 60: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut stribra *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 61:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut stinove oceli *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 62: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta+ "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut meteoriticke oceli *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
                 ///////////slitiny////////////////////////////////////
        case 101: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 SetLocalString(no_Item,"no_crafter",GetName(no_oPC));
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena bronz *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
                 }//konec case zvetsovani %
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
            no_procenta = no_procenta - Random(6)/10.0 ;}
            else if ((no_obtiznost_vyrobku <170)&(no_obtiznost_vyrobku>=160)) {
            no_procenta = no_procenta - Random(8)/10.0 ;} //0.1-0.6%
            else if ((no_obtiznost_vyrobku <160)&(no_obtiznost_vyrobku>=150)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.3;}
            else if ((no_obtiznost_vyrobku <150)&(no_obtiznost_vyrobku>=140)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.4;}
            else if ((no_obtiznost_vyrobku<140)&(no_obtiznost_vyrobku>=130)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.5;}
            else if ((no_obtiznost_vyrobku <130)&(no_obtiznost_vyrobku>=120)) {
            no_procenta = no_procenta - Random(20)/10.0 -0.9;}
            else if ((no_obtiznost_vyrobku <120)&(no_obtiznost_vyrobku>=110)) {
            no_procenta = no_procenta - Random(20)/10.0 -1.5;}
            else if ((no_obtiznost_vyrobku <110)&(no_obtiznost_vyrobku>=100)) {
            no_procenta = no_procenta - Random(20)/10.0 -2.0;}
            else if ((no_obtiznost_vyrobku <100)&(no_obtiznost_vyrobku>=90)) {
            no_procenta = no_procenta - Random(20)/10.0 -3.1;}
           else if ((no_obtiznost_vyrobku <90)&(no_obtiznost_vyrobku>=80)) {
            no_procenta = no_procenta - Random(20)/10.0 -3.5;}
           else if ((no_obtiznost_vyrobku <80)&(no_obtiznost_vyrobku>=70)) {
            no_procenta = no_procenta - Random(20)/10.0 -4.5;}
            else if ((no_obtiznost_vyrobku <70)&(no_obtiznost_vyrobku>=60)) {
            no_procenta = no_procenta - Random(20)/10.0 -4.8;}
            else if ((no_obtiznost_vyrobku <60)&(no_obtiznost_vyrobku>=50)) {
            no_procenta = no_procenta - Random(20)/10.0- 6.0;}
            else if ((no_obtiznost_vyrobku <50)&(no_obtiznost_vyrobku>=40)) {
            no_procenta = no_procenta - Random(20)/10.0 -6.6;}
            else if ((no_obtiznost_vyrobku <40)&(no_obtiznost_vyrobku>=30)) {
            no_procenta = no_procenta- Random(20)/10.0 -7.5;}
            else if ((no_obtiznost_vyrobku <30)&(no_obtiznost_vyrobku>=20)) {
            no_procenta = no_procenta - Random(20)/10.0 - 7.8;}
            else if ((no_obtiznost_vyrobku <20)&(no_obtiznost_vyrobku>=10)) {
            no_procenta = no_procenta- Random(20)/10.0 -9.0;}
            else if (no_obtiznost_vyrobku <10) {
            no_procenta = no_procenta - Random(20)/10.0 -15.0;}


         if (no_procenta <= 0.0 ){
         DestroyObject(no_Item);

                DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
         FloatingTextStringOnCreature("Kov se ti vylil do uhli.",no_oPC,FALSE );
         ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
         DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
                               }
        else  if ((no_chance > 0)&(no_procenta>0.0)) FloatingTextStringOnCreature("Cast se ti vylila do uhli",no_oPC,FALSE );

        if (no_chance == 0){ FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
                      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
                          }     //konec ifu


if (no_procenta > 0.0 ) {

        string no_nazev_procenta = FloatToString(no_procenta);

        if (no_procenta >= 10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                                  no_nazev_procenta = GetStringRight(no_nazev_procenta,4);}
        if (no_procenta <10.0) {no_nazev_procenta = GetStringLeft(FloatToString(no_procenta),10);
                               no_nazev_procenta = GetStringRight(no_nazev_procenta,3);}

        switch(no_druh) {
        case 1:  {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny cin *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 2: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena med *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 3: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena bronz *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 4: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistene zelezo *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 5: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistene zlato*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 6: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena platina*" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 7: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny mithril *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 8: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny adamantin *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 9: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cisteny titan *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 10: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistene stribro *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 11: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena stinova ocel *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 12: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena meteoriticka ocel *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
////////////////nad50= louhovane kuze////////////////////////////////
        case 51: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut cinu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 52: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut medi *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 53: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut bronzi *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 54: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut zeleza *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 55: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut zlata *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 56: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut platiny *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 57: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut mithrilu *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 58: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut adamantinu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 59: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut titanu *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 60: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut stribra *" + no_nazev_procenta+ "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 61:{string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut stinove oceli *" + no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
        case 62: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);

                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Prut meteoriticke oceli *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si legovani" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
                 ///////////slitiny////////////////////////////////////
        case 101: {string no_tag_vyrobku = GetTag(no_Item);
                 int no_pocet_cyklu = GetLocalInt(no_Item,"no_pocet_cyklu");
                 DestroyObject(no_Item);


                 no_Item = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
                 SetLocalFloat(no_Item,"no_suse_proc",no_procenta);
                 SetLocalInt(no_Item,"no_pocet_cyklu",no_pocet_cyklu);
                 FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
                 SetName(no_Item,"Cistena bronz *" +no_nazev_procenta + "%*" );

                 if (GetCurrentAction(no_oPC) == 65535 ) { ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
                 else  { FloatingTextStringOnCreature("Prerusil si cisteni" ,no_oPC,FALSE );
                         CopyItem(no_Item,no_oPC,TRUE);
                         DestroyObject(no_Item);
                         }
                 break; }
                 }//konec case zvetsovani %
          }// kdyz neni 100%

         }//konec else

         }// konec kdyz jsme davali polotovar..

}    ////knec no_xp_sl








void no_xp_cisteni(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{
int no_level = TC_getLevel(no_oPC,TC_MELTING);
switch(no_kov) {
        case 1:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_tin");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 2:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_copp");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 3:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_bron");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 4:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_iron");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 5:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_gold");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 6:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_plat");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 7:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_mith");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 8:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_adam");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 9:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_tita");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 10:  {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_silv");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 11:  {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_stin");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 12:  {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_mete");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
                } //konec vnitrniho  switche
 //obtiznost kovu -5*lvlu
} // konec no_xp_cisteni



void no_xp_slevani(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{
int no_level = TC_getLevel(no_oPC,TC_MELTING);
switch(no_kov) {

        case 101:   {CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_s_bron");
                   no_xp_sl(no_oPC,no_pec);
                   break; }
                } //konec vnitrniho  switche
} // konec no_xp_slevani

//   float no_procenta = GetLocalFloat(no_Item,"no_suse_proc");

void no_xp_pruty(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{       switch(no_kov)   {
        case 1:   {//pred 16.6.2014
                    //CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_tin");
                   //po 16.6.2014 :
                   SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_tin"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 2:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_copp"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 3:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_bron"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 4:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_iron"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 5:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_gold"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 6:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_plat"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 7:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_mith"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 8:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_adam"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 9:   {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_tita"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 10:  {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_silv"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 11:  {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_stin"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
        case 12:  {SetLocalFloat(CreateItemOnObject("no_polot_sl",no_pec,1,"no_sl_n_mete"),"no_suse_proc",15.0);
                   no_xp_sl(no_oPC,no_pec);
                   break; }
                } //konec vnitrniho  switche

} // konec no_xp_pruty
















