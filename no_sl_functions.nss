#include "ku_libtime"
//#include "no_sl_inc"
#include "tc_xpsystem_inc"
#include "no_nastcraft_ini"
#include "tc_functions"

#include "ku_persist_inc"

int no_pocet;
string no_nazev;
int no_DC;


void no_legura(object no_pec, int no_mazani);
// nastavi promenou no_legu na objectu no_pec na hodnotu legury
void no_cistykov(object no_pec, int no_mazani);
// nastavi promenou no_cist na objectu no_pec na hodnotu cisteho kovu
// no_nale_pocet  : pocet rudy
void no_nuget(object no_pec, int no_mazani);
// nastavi promenou no_ruda na objectu no_pec na hodnotu nugetu kovu
void no_pridatuhli(object no_pec);
//pridame uhli a zdelsime tak cas horeni pece
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

string __getLegurTag(int iLegura) {
  switch(iLegura) {
    case 1 : return "no_legu_tin";
    case 2 : return "no_legu_copp";
    case 3 : return "no_legu_bron";
    case 4 : return "no_legu_iron";
    case 5 : return "no_legu_gold";
    case 6 : return "no_legu_plat";
    case 7 : return "no_legu_mith";
    case 8 : return "no_legu_adam";
    case 9 : return "no_legu_tita";
    case 10: return "no_legu_silv";
    case 11: return "no_legu_stin";
    case 12: return "no_legu_mete";
  }
  return "";
}

string __getNugetTag(int iNuget) {
  switch(iNuget) {
    case 1 : return "cnrNuggetTin";
    case 2 : return "cnrNuggetCopp";
    case 3 : return "cnrNuggetVerm";
    case 4 : return "cnrNuggetIron";
    case 5 : return "cnrNuggetGold";
    case 6 : return "cnrNuggetPlat";
    case 7 : return "cnrNuggetMith";
    case 8 : return "cnrNuggetAdam";
    case 9 : return "cnrNuggetTita";
    case 10: return "cnrNuggetSilv";
    case 11: return "tc_Nug_Stin";
    case 12: return "tc_Nug_Meteor";
  }
  return "";
}

string __getCistResRef(int iCist) {
  switch(iCist) {
    case 1 : return "no_cist_tin";
    case 2 : return "no_cist_copp";
    case 3 : return "no_cist_bron";
    case 4 : return "no_cist_iron";
    case 5 : return "no_cist_gold";
    case 6 : return "no_cist_plat";
    case 7 : return "no_cist_mith";
    case 8 : return "no_cist_adam";
    case 9 : return "no_cist_tita";
    case 10: return "no_cist_silv";
    case 11: return "no_cist_stin";
    case 12: return "no_cist_mete";
  }
  return "";
}

string __getSlitNeleg(int iSlit) {
  switch(iSlit) {
    case 1 : return "no_sl_tin";
    case 2 : return "no_sl_copp";
    case 3 : return "no_sl_bron";
    case 4 : return "no_sl_iron";
    case 5 : return "no_sl_gold";
    case 6 : return "no_sl_plat";
    case 7 : return "no_sl_mith";
    case 8 : return "no_sl_adam";
    case 9 : return "no_sl_tita";
    case 10: return "no_sl_silv";
    case 11: return "no_sl_stin";
    case 12: return "no_sl_mete";
  }
  return "";
}

string __getSlitLeg(int iSlit) {
  switch(iSlit) {
    case 1 : return "no_sl_n_tin";
    case 2 : return "no_sl_n_copp";
    case 3 : return "no_sl_n_bron";
    case 4 : return "no_sl_n_iron";
    case 5 : return "no_sl_n_gold";
    case 6 : return "no_sl_n_plat";
    case 7 : return "no_sl_n_mith";
    case 8 : return "no_sl_n_adam";
    case 9 : return "no_sl_n_tita";
    case 10: return "no_sl_n_silv";
    case 11: return "no_sl_n_stin";
    case 12: return "no_sl_n_mete";
  }
  return "";
}

int __getMakeDC(int no_druh) {
  switch(no_druh) {
        case 1: return no_obt_cist_tin;
        case 2: return no_obt_cist_copp;
        case 3: return no_obt_cist_bron;
        case 4: return no_obt_cist_iron;
        case 5: return no_obt_cist_gold;
        case 6: return no_obt_cist_plat;
        case 7: return no_obt_cist_mith;
        case 8: return no_obt_cist_adam;
        case 9: return no_obt_cist_tita;
        case 10: return no_obt_cist_silv;
        case 11: return no_obt_cist_stin;
        case 12: return no_obt_cist_mete;
        //nad 50= nalegovane
        case 51: return no_obt_nale_tin;
        case 52: return no_obt_nale_copp;
        case 53: return no_obt_nale_bron;
        case 54: return no_obt_nale_iron;
        case 55: return no_obt_nale_gold;
        case 56: return no_obt_nale_plat;
        case 57: return no_obt_nale_mith;
        case 58: return no_obt_nale_adam;
        case 59: return no_obt_nale_tita;
        case 60: return no_obt_nale_silv;
        case 61: return no_obt_nale_stin;
        case 62: return no_obt_nale_mete;
        //nad 100  slitiny
        case 101:return no_obt_slev_bron;
  }
  return 0;
}

int __getCenaMater(int iMater) {
  switch(iMater) {
    case  1: return no_cena_tin;
    case  2: return no_cena_copp;
    case  3: return no_cena_bron;
    case  4: return no_cena_iron;
    case  5: return no_cena_gold;
    case  6: return no_cena_plat;
    case  7: return no_cena_mith;
    case  8: return no_cena_adam;
    case  9: return no_cena_tita;
    case 10: return no_cena_silv;
    case 11: return no_cena_stin;
    case 12: return no_cena_mete;
  }
  return 0;
}

string __getPrutResRef(int iQual) {
  switch(iQual) {
    case  1: return "tc_prut1";
    case  2: return "tc_prut2";
    case  3: return "tc_prut3";
    case  4: return "tc_prut4";
    case  5: return "tc_prut11";
    case  6: return "tc_prut8";
    case  7: return "tc_prut7";
    case  8: return "tc_prut5";
    case  9: return "tc_prut10";
    case 10: return "tc_prut9";
    case 11: return "tc_prut12";
    case 12: return "tc_prut13";
  }
  return "";
}

string __getMaterialType(int iType) {
  // TODO add diacritics
  switch(iType) {
    case 0: return "Cisteny";
    case 1: return "Prut -";
  }
  return "chyba";
}

string __getMaterialName(int iQual) {
  switch(iQual) {
    case 1 : return "cin";
    case 2 : return "med";
    case 3 : return "vermajl";
    case 4 : return "zelezo";
    case 5 : return "zlato";
    case 6 : return "platina";
    case 7 : return "mithril";
    case 8 : return "adamantin";
    case 9 : return "titan";
    case 10: return "stribro";
    case 11: return "stinova ocel";
    case 12: return "meteoriticka ocel";
  }
  return "chyba";
}

int __getLegurByTag(string sTag) {
  int i;

  for(i = 1; i <= 12; i++) {
    if(sTag == __getLegurTag(i))
      return i;
  }
  return -1;
}

int __getNugetByTag(string sTag) {
  int i;

  for(i = 1; i <= 12; i++) {
    if(sTag == __getNugetTag(i))
      return i;
  }
  return -1;
}

int __getCistByResRef(string sTag) {
  int i;

  for(i = 1; i <= 12; i++) {
    if(sTag == __getCistResRef(i))
      return i;
  }
  return -1;
}

int __getSlitByTag(string sTag) {
  int i;

  for(i = 1; i <= 12; i++) {
    if(sTag == __getSlitNeleg(i))
      return i;
  }
  return -1;
}

int __getSlitLegByTag(string sTag) {
  int i;

  for(i = 1; i <= 12; i++) {
    if(sTag == __getSlitLeg(i))
      return i;
  }
  return -1;
}

void no_legura(object no_pec, int no_mazani) {      //legury
  object oItem = GetFirstItemInInventory(no_pec);

  while(GetIsObjectValid(oItem))  {
    string sTag = GetTag(oItem);
    if (GetStringLeft(sTag,7) == "no_legu" ) {
      int iLegura = __getLegurByTag(sTag);
      if(iLegura > 0) {
        SetLocalInt(no_pec,"no_legu",iLegura); 
        TC_SnizStack(oItem,no_mazani);
        break;
      }

    }//kdyz legura
  oItem = GetNextItemInInventory(OBJECT_SELF);
  }  //tak uz mame legury
}




void no_nuget(object no_pec, int no_mazani) {
  object oItem = GetFirstItemInInventory(no_pec);

  while(GetIsObjectValid(oItem))  {
    int iNuget = __getNugetByTag(GetTag(oItem));
    if(iNuget > 0) {
      SetLocalInt(no_pec,"no_ruda",iNuget);
      TC_SnizStack(oItem,no_mazani);
      break;
    }

    oItem = GetNextItemInInventory(no_pec);
  }
}


void no_cistykov(object no_pec, int no_mazani) {
///////////////////////////////////////////
//// vystup:  no_cist       cislo urci kov
//////        no_nale_pocet  ulozeno pocet daneho naleg.kovu
////////////////////////////////////////////


  object oItem = GetFirstItemInInventory(no_pec);
  int no_pocet = 0;

  while (GetIsObjectValid(oItem)) {

    if(GetTag(oItem) != "no_cist") {   //kdyz neni nalegovany kov, tak pokracujeme ve vybirani

      oItem = GetNextItemInInventory(no_pec);
      continue;
    }
    
    int iCist = __getCistByResRef(GetResRef(oItem));
    if(iCist > 0) {
      if ( no_pocet >= 1) {
        if (GetLocalInt(no_pec,"no_cist") == iCist)
          no_pocet++; //kdyz sou stejne pricte 1
      }
      else { 
        no_pocet = 1; //kdyz je no_pocet=0 zvysi se na jedna
        SetLocalInt(no_pec,"no_cist",iCist);
        TC_SnizStack(oItem,no_mazani);
        break;
      }
    }
    //    TC_SnizStack(oItem,no_mazani);
    oItem = GetNextItemInInventory(no_pec);
  }

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


float CnrNormalizeFacing(float fFacing)
{
  while (fFacing >= 360.0) fFacing -= 360.0;
  while (fFacing < 0.0) fFacing += 360.0;
  return fFacing;
}


////////////////pridavame uhli /////////////////////////////////////////////////////////////////
void no_pridatuhli(object no_pec) {
  no_oPC=GetLastDisturbed();
  object oItem = GetFirstItemInInventory(OBJECT_SELF);    //zjistime, zda je ve vyhni uhli
  while(GetIsObjectValid(oItem))  {
    if(GetTag(oItem) == "cnrLumpOfCoal")
      break;
    oItem = GetNextItemInInventory(OBJECT_SELF);
  }


  if (GetIsObjectValid(oItem)) {  //kdyz mame uhli

//////////////////////////////////////////////

  if (GetLocalInt(OBJECT_SELF,"no_sl_horipec") > ku_GetTimeStamp() ) {//bylo tam pred driv nez minutou dane uhli
    FloatingTextStringOnCreature("Pridavas dalsi uhli, presto pec nehori o moc hure, nez pred chvili.",no_oPC,FALSE);
    DestroyObject(GetNearestObjectByTag("plc_flamesmall",OBJECT_SELF));

  }
  else  { 
    FloatingTextStringOnCreature(" Uhli se krasne rozhorelo",no_oPC,FALSE );
  }
// budto horime od zacatku, nebo to znovu nastavi cas horeni od ted na 1minutu
////////////pridano od melvika/////////////



      int nCoalCount = GetLocalInt(OBJECT_SELF, "CnrCoalCount") + 1;
      SetLocalInt(OBJECT_SELF, "CnrCoalCount", nCoalCount);
      if (nCoalCount == 1) {
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
        if (oSound != OBJECT_INVALID) {
          SoundObjectPlay(oSound);
        }

        // the PC just put the first coal nugget into the forge
        DelayCommand(900.0, BurnUpTheCoal(oFire, oPlume1, oPlume2));
      }


    SetLocalInt(OBJECT_SELF,"no_sl_horipec",ku_GetTimeStamp(0,15));      // bude horet 5minut


    DestroyObject(oItem);   //znicime uhli
  }    //konec  kdyz mame uhli
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
void no_xp_sl (object no_oPC, object no_pec) {

  int no_druh=0;
  object oItem = GetFirstItemInInventory(no_pec);
  while (GetIsObjectValid(oItem)) {

    if (GetResRef(oItem) == "no_polot_sl") {
      string sTag = GetTag(oItem);
      int iSlit = __getSlitByTag(sTag);
      if(iSlit > 0) {
        no_druh = iSlit; 
        break; 
      }
      //nad 50= nalegovane
      iSlit = __getSlitLegByTag(sTag);
      if(iSlit > 0) {
        no_druh = 50 + iSlit; 
        break; 
      }
      
      //nad 100  slitiny
      /*if(GetTag(oItem) == "no_sl_s_bron")  {  
        no_druh=101; 
        break;
      }*/

    }//pokud resref = no_polot_ko      - pro zrychleni ifu...
    oItem = GetNextItemInInventory(no_pec);
  }    /// dokud valid

//////tak mame predmet, co sme chteli. ted pravdepodobnost, ze se neco povede:
  if (no_druh <= 0 )
    return; 

  // First try
  if  (GetLocalFloat(oItem,"no_suse_proc")==0.0) 
    SetLocalFloat(oItem,"no_suse_proc",10.0);


  int no_level = TC_getLevel(no_oPC,TC_MELTING);

  no_DC = __getMakeDC(no_druh) - (10*no_level );
  //obtiznost kovu -5*lvlu

  // pravdepodobnost uspechu =
  int no_chance = 100 - (no_DC*2);
  if (no_chance < 0) 
    no_chance = 0;

  //samotny hod
  int no_hod = 101 - d100();

  if (no_hod <= no_chance ) {

    float no_procenta = GetLocalFloat(oItem,"no_suse_proc");
    SendMessageToPC(no_oPC,"===================================");
    if (no_chance >= 100) {
      FloatingTextStringOnCreature("Zpracovani je pro tebe trivialni",no_oPC,FALSE );
      //no_procenta = no_procenta + 10 + d10(); // + 11-20 fixne za trivialni vec
      TC_setXPbyDifficulty(no_oPC,TC_MELTING,no_chance,TC_dej_vlastnost(TC_MELTING,no_oPC));
    }

    if ((no_chance > 0) && (no_chance<100)) { 
      TC_setXPbyDifficulty(no_oPC,TC_MELTING,no_chance,TC_dej_vlastnost(TC_MELTING,no_oPC));
    }
        //////////povedlo se takze se zlepsi % zhotoveni na polotovaru////////////
        ///////////nacteme procenta z minula kdyz je polotovar novej, mel by mit int=0 /////////////////
        //no_procenta = no_procenta + 10+ d20() + no_level ;  // = 12-45
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );
    no_procenta = no_procenta + (TC_getProgressByDifficulty(no_obtiznost_vyrobku) / 10.0);

    if  (GetIsDM(no_oPC)) 
      no_procenta = no_procenta + 50.0;

    if (no_procenta >= 100.0) {  //kdyz je vyrobek 100% tak samozrejmeje hotovej

      AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0, 5.0));

      DestroyObject(oItem); //znicim ho, protoze predam hotovej vyrobek
      DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
      string sResref = "";
      string sTag = "";
      float fCena;

      switch(no_druh / 50) {
        // cist
        case 0:
          sResref = __getCistResRef(no_druh);
          sTag = "no_cist";
          fCena = __getCenaMater(no_druh % 50) * no_sl_nasobitel2;
          break;
        // 50+ Prut
        case 1:
          sResref = __getPrutResRef(no_druh % 50);
          sTag = "";
          fCena = __getCenaMater(no_druh % 50) * no_sl_nasobitel;
          break;
        // Slitiny
        case 2:
           FloatingTextStringOnCreature("*** CHYBA! Kde se tu vzala slitina? ***" ,no_oPC,FALSE );
          break;
      }
      if(GetStringLength(sResref) > 0) {
        object oNew = CreateItemOnObject(sResref, no_oPC, 1, sTag);
        SetLocalInt(oNew, "tc_cena", FloatToInt(fCena));
        FloatingTextStringOnCreature("*** HOTOVO ***" ,no_oPC,FALSE );
      }
    }//konec kdzy uz mam nad 100%
    else  {  //kdyz neni 100% tak samozrejmeje neni hotovej

      if ( GetLocalInt(oItem,"no_pocet_cyklu") == 9 ) {
        TC_saveCraftXPpersistent(no_oPC,TC_MELTING);
      }

      string no_nazev_procenta;
      {
        int iPerc = FloatToInt(no_procenta * 10.0);
        no_nazev_procenta = IntToString(iPerc/10)+"."+IntToString(iPerc%10);
      }

      string no_tag_vyrobku = GetTag(oItem);
      int no_pocet_cyklu = GetLocalInt(oItem,"no_pocet_cyklu");
      DestroyObject(oItem);

      oItem = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
      SetLocalFloat(oItem,"no_suse_proc",no_procenta);
      SetLocalInt(oItem,"no_pocet_cyklu",no_pocet_cyklu);
      SetLocalString(oItem,"no_crafter",GetName(no_oPC));
      FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
      SetName(oItem,__getMaterialType(no_druh / 50)+" "+__getMaterialName(no_druh % 50)+" *" + no_nazev_procenta + "%*" );

      if (GetCurrentAction(no_oPC) == 65535 ) { 
        ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); }
      else  { 
        FloatingTextStringOnCreature("Prerusil jsi praci" ,no_oPC,FALSE );
        CopyItem(oItem,no_oPC,TRUE);
        DestroyObject(oItem);
      }

      

    }// kdyz neni 100%

      SendMessageToPC(no_oPC,"===================================");

  } /// konec, kdyz sme byli uspesni
  else {     ///////// bo se to nepovedlo, tak znicime polotovar////////////////
    float no_procenta = GetLocalFloat(oItem,"no_suse_proc");
    int no_obtiznost_vyrobku = no_DC+( 10*no_level );

    no_procenta = no_procenta - TC_getDestroyingByDifficulty(no_obtiznost_vyrobku) / 10.0;

    if (no_procenta <= 0.0 ) {
      DestroyObject(oItem);

      DeleteAllInContainer(OBJECT_SELF); //smazu vse z kontejneru
      FloatingTextStringOnCreature("Kov se ti vylil do uhli.",no_oPC,FALSE );
      ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),OBJECT_SELF);
      DelayCommand(1.0,AssignCommand(no_oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 2.0)));
    }
    else  if ((no_chance > 0) && (no_procenta>0.0)) 
      FloatingTextStringOnCreature("Cast se ti vylila do uhli",no_oPC,FALSE );

    if (no_chance == 0) { 
      FloatingTextStringOnCreature(" Se zpracovani by si mel radeji pockat ",no_oPC,FALSE );
      DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1,DAMAGE_TYPE_SONIC),no_oPC));
    }     //konec ifu


    if (no_procenta > 0.0 ) {
      string no_nazev_procenta;
      {
        int iPerc = FloatToInt(no_procenta * 10.0);
        no_nazev_procenta = IntToString(iPerc/10)+"."+IntToString(iPerc%10);
      }

      // process change
      string no_tag_vyrobku = GetTag(oItem);
      int no_pocet_cyklu = GetLocalInt(oItem,"no_pocet_cyklu");
      DestroyObject(oItem);

      oItem = CreateItemOnObject("no_polot_sl",OBJECT_SELF,1,no_tag_vyrobku);
      SetLocalFloat(oItem,"no_suse_proc",no_procenta);
      SetLocalInt(oItem,"no_pocet_cyklu",no_pocet_cyklu);
      FloatingTextStringOnCreature("***   " +no_nazev_procenta + "%   ***" ,no_oPC,FALSE );
      SetName(oItem,__getMaterialType(no_druh / 50)+" "+__getMaterialName(no_druh % 50)+" *" + no_nazev_procenta + "%*" );

      if (GetCurrentAction(no_oPC) == 65535 ) { 
        ExecuteScript("no_sl_clos_vyhen",OBJECT_SELF); 
      }
      else  { 
        FloatingTextStringOnCreature("Prerusil jsi praci" ,no_oPC,FALSE );
        CopyItem(oItem,no_oPC,TRUE);
        DestroyObject(oItem);
      }

    }// kdyz neni 100%

  }//konec else


}    ////knec no_xp_sl








void no_xp_cisteni(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{
  CreateItemOnObject("no_polot_sl",no_pec, 1, __getSlitNeleg(no_kov));
  no_xp_sl(no_oPC,no_pec);
 //obtiznost kovu -5*lvlu
} // konec no_xp_cisteni


void no_xp_pruty(object no_oPC, object no_pec, int no_kov)
// vyresi moznost uspechu a preda pripadny povedeny kov do pece
{       
   object oNew = CreateItemOnObject("no_polot_sl",no_pec,1,__getSlitLeg(no_kov));
   SetLocalFloat(oNew,"no_suse_proc",15.0);
   no_xp_sl(no_oPC,no_pec); 

} // konec no_xp_pruty
















