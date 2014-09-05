/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_bash_onused
//
//  Desc:  When a player uses a placeable, begin bashing it.
//
//  Author: David Bobeck 03Feb03
//
/////////////////////////////////////////////////////////

/*
v cnr_gemdep_ou a

*/


#include "cnr_persist_inc"
#include "NW_I0_GENERIC"
#include "ku_libtime"

void CheckAction(object oPC, object oSelf);
void CreateAnObject(string sResource, object oPC);
void ReplaceSelf(object oSelf, string sAppearance);
void CreateNew(location lSelf, string sResSelf);
void CreatePlaceable(string sObject, location lPlace, float fDuration);

void RemoveEffects(object oPC);
void CallEnemyCreatures(object oPC);

void main()
{


  string sSelf=GetTag(OBJECT_SELF);

  // rozdil zda jde o drevarinu
  if (GetStringLeft(sSelf,7) != "cnrTree")
  {

  object oSelf=OBJECT_SELF;
  object oPC=GetLastUsedBy();
  string sTool = "ZEP_HEAVYPICK";
  string sToolOptional = "ZEP_LIGHTPICK";


////////////nomis odstraneni effektu invis a hide..///////////////////////
//AssignCommand(oPC, SetCommandable(FALSE));
//DelayCommand(1.0,AssignCommand(oPC, SetCommandable(TRUE)));
//SetActionMode(oPC,ACTION_MODE_STEALTH,0);
  RemoveEffects(oPC);
  CallEnemyCreatures(oPC);
//////////////////////////////////////////////////////////////



  if (GetLocalInt(oPC,"iAmDigging")!= 0) return;
  if (GetLocalInt(oSelf,"iAmSetToDie")==0)SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(5.0,SetLocalInt(oPC,"iAmDigging",0));

  //nomis
  int no_nahoda = 0;
  string sSelf=GetTag(oSelf);
  string sResource = "";
  string sSuccessString = "";
  string sFailString = "";
  string sOldSkill = "";
  string sOldSkill2 = "";
  string sAppearance;
  //int iMiningSkill=GetTokenPair(oPC,14,3);
  int iMiningSkill = CnrGetPersistentInt(oPC,"iMiningSkill");
  int iDigChance=iMiningSkill;
  int iSuccess=0;
  int iToolBreak=GetLocalInt(oPC,"iToolWillBreak");
  int iRandom = 0;
  int iMaxDig = GetLocalInt(oSelf,"iMaxDig");
  if (iMaxDig==0)
   {
    //iMaxDig=d4(2);  = puvodni hodnota kolik vlastne se natezi dane suroviny.
    //iMaxDig=d4(2);
        if (sSelf == "cnrDepositCoal") iMaxDig=6+d10(2);
        if (sSelf == "cnrRockTin")  iMaxDig=6+d10(1);
        if (sSelf == "cnrRockCopp") iMaxDig=6+d10(1);
        if (sSelf == "cnrRockVerm") iMaxDig=6+d10(1);
        if (sSelf == "cnrRockIron") iMaxDig=3+d10(1);
        if (sSelf == "cnrRockGold") iMaxDig=3+d10(1);
        if (sSelf == "cnrRockPlat") iMaxDig=3+d8(1);
        if (sSelf == "cnrRockMith") iMaxDig=2+d8(1);
        if (sSelf == "cnrRockAdam") iMaxDig=2+d6(1);
        if (sSelf == "cnrRockTita") iMaxDig=1+d6(1);
        if (sSelf == "cnrRockSilv") iMaxDig=1+d4(1);
        if (sSelf == "cnrRockStin") iMaxDig=0+d4(1);
        if (sSelf == "cnrRockMete") iMaxDig=0;


    SetLocalInt(oSelf,"iMaxDig",iMaxDig);
   }
  object oTool=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  if ((GetTag(oTool) != sTool)&&(GetTag(oTool) != sToolOptional))
    oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if ((GetTag(oTool) != sTool)&&(GetTag(oTool) != sToolOptional))
     {
        SendMessageToPC(oPC,"K tezbe potrebujes krumpac.");
        return;
     }

  if (iDigChance < 350)
   {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350) iDigChance = 350;
    if (iMiningSkill>iDigChance)iDigChance=iMiningSkill;
   }

   sFailString = "Chvilku jsi kopal(a), ale napodarilo se Ti vykopak zadnou rudu.";

   // zvuky kopani
   AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("cb_ht_metblston1")));
   AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("cb_ht_metblston2")));

  // rozdil zda jde o drevarinu
  if (GetStringLeft(sSelf,7) == "cnrTree")
   {
       // zvuky kopani
       AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("it_materialhard")));
       AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("it_materialhard")));
   } else
   {
       // zvuky kopani
       AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("cb_ht_metblston1")));
       AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("cb_ht_metblston2")));
   }


///////////////////////////////////////////////////////////////////////////////////////////////////////
//////////
//////////         NOMIS 21.SRPEN doplneni
//////////////////////////////////////////////////////////////////////////////////////////////////////
 // if (sSelf == "cnrTreeOak") //skala
//  {
//    sAppearance="temp_placeable";
//    sResource = "cnrBranchOak";
//   }
//  if (sSelf == "cnrTreeMahogany") //skala
//   {
//    sAppearance="temp_placeable";
//    sResource = "cnrBranchMah";
//   }
//  if (sSelf == "cnrTreeHickory") //skala
//   {
//    sAppearance="temp_placeable";
//    sResource = "cnrBranchHic";
//   }
///////////////////////////////////////////////////////////


// 29_4_2014 doplneni o hlusinu :
// no_hlusina  vec, co neumi nic.
int no_hlusina = 0;
no_nahoda = d100();
        //if (sSelf == "cnrDepositCoal") iMaxDig=6+d10(2);
        //if (sSelf == "cnrRockTin")  iMaxDig=6+d10(1);
        //if (sSelf == "cnrRockCopp") iMaxDig=6+d10(1);
        if ((sSelf == "cnrRockIron") & (no_nahoda <= 10))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockGold") & (no_nahoda <= 15))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockPlat") & (no_nahoda <= 20))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockMith") & (no_nahoda <= 25))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockAdam") & (no_nahoda <= 25))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockTita") & (no_nahoda <= 30))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockSilv") & (no_nahoda <= 30))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockStin") & (no_nahoda <= 35))  no_hlusina = 1 ;
        if ((sSelf == "cnrRockMete") & (no_nahoda <= 40))  no_hlusina = 1 ;
       //ted kaminky : cnrGemDeposit00X
        if ((sSelf == "cnrGemDeposit001") & (no_nahoda <= 10))  no_hlusina = 1 ;  //nefrit
        if ((sSelf == "cnrGemDeposit002") & (no_nahoda <= 15))  no_hlusina = 1 ;  //malachit
        if ((sSelf == "cnrGemDeposit007") & (no_nahoda <= 20))  no_hlusina = 1 ;  //ohn achat
        if ((sSelf == "cnrGemDeposit014") & (no_nahoda <= 20))  no_hlusina = 1 ;  //aventurin
        if ((sSelf == "cnrGemDeposit004") & (no_nahoda <= 25))  no_hlusina = 1 ;  //fenelop
        if ((sSelf == "cnrGemDeposit003") & (no_nahoda <= 25))  no_hlusina = 1 ;  //ametyst
        if ((sSelf == "cnrGemDeposit015") & (no_nahoda <= 25))  no_hlusina = 1 ;  //zivec
        if ((sSelf == "cnrGemDeposit011") & (no_nahoda <= 30))  no_hlusina = 1 ;  //granat
        if ((sSelf == "cnrGemDeposit013") & (no_nahoda <= 30))  no_hlusina = 1 ;  //alexandrit
        if ((sSelf == "cnrGemDeposit010") & (no_nahoda <= 30))  no_hlusina = 1 ;  //topaz
        if ((sSelf == "cnrGemDeposit008") & (no_nahoda <= 40))  no_hlusina = 1 ;  //safir   -podtemno
        if ((sSelf == "cnrGemDeposit009") & (no_nahoda <= 40))  no_hlusina = 1 ;  // ohn opal-podtemno
        if ((sSelf == "cnrGemDeposit005") & (no_nahoda <= 40))  no_hlusina = 1 ;  // diamant -podtemno
        if ((sSelf == "cnrGemDeposit006") & (no_nahoda <= 40))  no_hlusina = 1 ;  // rubin-podtemno
        if ((sSelf == "cnrGemDeposit012") & (no_nahoda <= 40))  no_hlusina = 1 ;  //smaragd -podtemno



if (no_hlusina == 1) {
    sAppearance="temp_placeable";
    sResource = "no_hlusina";
    sSuccessString = "Podarilo se ti vytkutat jen hlusinu";
    }//dostaneme jen hlusinu

  if ((sSelf == "cnrRockTin")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
    no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetTin";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy cinu";
                }
                else   { sResource = "cnrNuggetCopp";
                sSuccessString = "No tohle, vytezil jsi nuget medi!";
                }

   }
  if ((sSelf == "cnrRockAdam")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
        no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetAdam";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy adamantinu";
                }
                else   { sResource = "cnrNuggetTita";
                sSuccessString = "No tohle, vytezil jsi nuget titanu!";
                }
    //sResource = "cnrNuggetAdam";
    //sSuccessString = "Podarilo se ti vytkutat pekny kus rudy adamantinu";
   }
  if ((sSelf == "cnrRockGold")&(no_hlusina<1)) //skala
   {
   sAppearance="temp_placeable";
        no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetGold";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zlata";
                }
                else   { sResource = "cnrNuggetPlat";
                sSuccessString = "No tohle, vytezil jsi nuget platiny!";
                }
    //sResource = "cnrNuggetGold";
    //sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zlata";
   }
  if ((sSelf == "cnrRockMith")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
             no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetMith";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy mithrilu";
                }
                else   { sResource = "cnrNuggetAdam";
                sSuccessString = "No tohle, vytezil jsi nuget adamantinu!";
                }

   // sResource = "cnrNuggetMith";
  // sSuccessString = "Podarilo se ti vytkutat pekny kus rudy mithrilu";
   }
  if ((sSelf == "cnrRockPlat")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
             no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetPlat";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy platiny";
                }
                else   { sResource = "cnrNuggetMith";
                sSuccessString = "No tohle, vytezil jsi nuget mithrilu!";
                }
//    sResource = "cnrNuggetPlat";
//    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy platiny";
   }
  if ((sSelf == "cnrRockSilv")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                 no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetSilv";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy stribra";
                }
                else   { sResource = "cnrNuggetStin";
                sSuccessString = "No tohle, vytezil jsi nuget stinove oceli!";
                }
    //sResource = "cnrNuggetSilv";
   // sSuccessString = "Podarilo se ti vytkutat pekny kus rudy stribra";
   }
  if ((sSelf == "cnrRockTita")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                     no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetTita";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy titanu";
                }
                else   { sResource = "cnrNuggetSilv";
                sSuccessString = "No tohle, vytezil jsi nuget stribra!";
                }
   // sResource = "cnrNuggetTita";
   // sSuccessString = "Podarilo se ti vytkutat pekny kus rudy titanu";
   }
  if ((sSelf == "cnrRockIron")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetIron";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
                }
                else   { sResource = "cnrNuggetGold";
                sSuccessString = "No tohle, vytezil jsi nuget zlata!";
                }
    //sResource = "cnrNuggetIron";
    //sSuccessString = "Podarilo se ti vytkutat pekny kus rudy zeleza";
   }
  if ((sSelf == "cnrRockCopp")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetCopp";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy medi";
                }
                else   { sResource = "cnrNuggetIron";
                sSuccessString = "No tohle, vytezil jsi nuget zeleza!";
                }
                //pridano 16.6.2014
  if ((sSelf == "cnrRockVerm")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/200) ){ sResource = "cnrNuggetVerm";
                sSuccessString = "Podarilo se ti vytkutat pekny kus rudy Vermajlu";
                }
                else   { sResource = "cnrNuggetIron";
                sSuccessString = "No tohle, vytezil jsi nuget zeleza!";
                }
        }



//    sResource = "cnrNuggetCopp";
//    sSuccessString = "Podarilo se ti vytkutat pekny kus rudy medi";
   }

//  if (GetStringLeft(sSelf,13) == "cnrGemDeposit") //skala
//   {
//    sAppearance="temp_placeable";
//    sResource = "cnrGemMineral" + GetStringRight(sSelf,3);
//    sSuccessString = "Podarilo se ti vytkutat pekny kus nerostu";
//   }

///taak a ted vyresit gemdepozity:
int no_provedeni = 0;
  if ((sSelf == "cnrGemDeposit001")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral002";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral007";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral014";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral001";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }
  if ((sSelf == "cnrGemDeposit002")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral007";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral014";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral004";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral002";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit007")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral014";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral004";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral003";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral007";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit014")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral004";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral003";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral015";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral014";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit004")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral003";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral015";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral011";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral004";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit003")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral015";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral011";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral013";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral003";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit015")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral011";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral013";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral010";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral015";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }


  if ((sSelf == "cnrGemDeposit011")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral013";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral010";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral008";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral011";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }
  if ((sSelf == "cnrGemDeposit013")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral010";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral008";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral009";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral013";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }
  if ((sSelf == "cnrGemDeposit010")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral008";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral009";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral005";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral010";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }
  if ((sSelf == "cnrGemDeposit008")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral009";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral005";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral006";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral008";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }
  if ((sSelf == "cnrGemDeposit009")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral005";
                sSuccessString = "No tohle, co to tam bylo schovane!";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral006";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
//                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral012";
//                sSuccessString = "No teda to je kosusek!";
//                no_provedeni= 1;
//                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral009";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }
  if ((sSelf == "cnrGemDeposit005")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
//                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral014";
//                sSuccessString = "No tohle, co to tam bylo schovane!";
//                no_provedeni= 1;
//                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral006";
                sSuccessString = "Teda, kdo by to byl cekal";
                no_provedeni= 1;
                }
                if ((no_nahoda < (iMiningSkill/200) )& (no_provedeni == 0)){ sResource = "cnrGemMineral012";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral005";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit006")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
//                if (no_nahoda < (iMiningSkill/50) ){ sResource = "cnrGemMineral014";
//                sSuccessString = "No tohle, co to tam bylo schovane!";
//                no_provedeni= 1;
//                }
//                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral007";
//                sSuccessString = "Teda, kdo by to byl cekal";
//                no_provedeni= 1;
//                }
                if ((no_nahoda < (iMiningSkill/100) )& (no_provedeni == 0)){ sResource = "cnrGemMineral012";
                sSuccessString = "No teda to je kosusek!";
                no_provedeni= 1;
                }
                if (no_provedeni ==0)   { sResource = "cnrGemMineral006";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                }
   }

  if ((sSelf == "cnrGemDeposit012")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                sResource = "cnrGemMineral012";
                sSuccessString = "Podarilo se ti vykutat pekny kus nerostu";
                //if ((no_nahoda > (iMiningSkill/10) )& (no_provedeni == 0)){ sResource = "cnrGemMineral006";
               // sSuccessString = "Teda, kdo by to byl cekal";
               // no_provedeni= 1;
                //}
            //    if ((no_nahoda > (iMiningSkill/20) )& (no_provedeni == 0)){ sResource = "cnrGemMineral006";
            //    sSuccessString = "No teda to je kosusek!";
            //    no_provedeni= 1;
            //    }
            //    if (no_provedeni ==0)   { sResource = "cnrGemMineral012";
            //    sSuccessString = "No tohle, co to tam bylo schovane!";
            //    }
   }



///////////////////////////////////////////////////////////////////////////////////////////////////////
//////////
//////////         NOMIS 21.SRPEN  2005? doplneni
//////////////////////////////////////////////////////////////////////////////////////////////////////

  if (sSelf == "cnrDepositCoal") //skala
   {
    sAppearance="temp_placeable";
    sResource = "cnrLumpOfCoal";
    sSuccessString = "Podarilo se ti vytkutat pekny kus uhli";
   }

  if ((sSelf == "cnrRockStin")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
        no_nahoda = d100();
                if (no_nahoda > (iMiningSkill/20) ){ sResource = "tc_nug_stin";
                sSuccessString = "Podarilo se ti vytkutat pekny kus stinove oceli";
                }
                else   { sResource = "tc_nug_mete";
                sSuccessString = "No tohle, kde se tam vzal kus meteoritu !";
                }
   }





   if (sSelf == "cnrRockMete") //skala
   {
    sAppearance="temp_placeable";
    sResource = "tc_nug_mete";
    sSuccessString = "Podarilo se ti vytkutat pekny kus meteoriticke oceli";
   }




////////////////////////nomis konec doplneni///////////////////////////////////
  iRandom = Random(1000);

  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,1.0,5.0));

  if (iRandom <= iDigChance)
    {
     DelayCommand(5.0,FloatingTextStringOnCreature(sSuccessString,oPC,FALSE));
     iMaxDig--;
     SetLocalInt(oSelf,"iMaxDig",iMaxDig);
     if (iMaxDig==1)
      {
       SetLocalInt(oSelf,"iAmSetToDie",99);
       SetLocalInt(oPC,"iAmDigging",0);
       DelayCommand(3.0,FloatingTextStringOnCreature("Zdroj je pryc!",oPC,FALSE));
       DelayCommand(6.5,ReplaceSelf(oSelf,sAppearance));
      }
     iSuccess = 1;
     DelayCommand(6.0,CreateAnObject(sResource,oPC));
     if (iMaxDig>1) DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     if (Random(1000)> iMiningSkill)
      {
       if (d10(1)+1>= iMiningSkill/1000)
        {
         if (GetLocalInt(oPC,"iSkillGain")==0)
          {
           if (iMaxDig>1)SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
           iMiningSkill++;
           sOldSkill2 = IntToString(iMiningSkill);
           sOldSkill = "."+GetStringRight(sOldSkill2,1);
           if (iMiningSkill > 9)
             {
              sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
             }
            else
             {
              sOldSkill = "0"+sOldSkill;
             }
           if (iMiningSkill <= 1000)
            {
             //DelayCommand(5.5,SetTokenPair(oPC,14,3,iMiningSkill));
             DelayCommand(6.0,CnrSetPersistentInt(oPC,"iMiningSkill",iMiningSkill));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepsila!"));
             DelayCommand(6.0,SendMessageToPC(oPC,"Soucasna dovednost hornictvi je : "+sOldSkill+"%"));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             //if (GetLocalInt(GetModule(),"_UOACraft_XP")!=0)

DelayCommand(6.0,GiveXPToCreature(oPC,GetLocalInt(GetModule(),"_UOACraft_XP")));
            }
          }
        }
      }
    }
   else
    {
     switch (d8(1))
      {
       case 1:{sFailString="Tvuj pokrok jde pomalu...";break;}
       case 2:{sFailString="Radsi bych se na to mel vykaslat...";break;}
       case 3:{sFailString="Paze zacinaji byt unaveny...";break;}
       case 4:{sFailString="Asi to nikdy nenajdu..";break;}
       case 5:{sFailString="Mel jsem radsi zustat doma";break;}
       default:{break;}
      }
     DelayCommand(5.0,FloatingTextStringOnCreature(sFailString,oPC,FALSE));
     DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     return;
    }

  if (iSuccess == 1)
   {
    iToolBreak++;
//zmena 1.9.2014
//    if (iToolBreak > 20)
  if (iToolBreak > 60)
     {
      DelayCommand(6.0,FloatingTextStringOnCreature("Zlomil se ti nastroj..",oPC,FALSE));
      DestroyObject(oTool,6.0);
      iToolBreak = 0;
     }
   }

  SetLocalInt(oPC,"iToolWillBreak",iToolBreak);

 //
 } else {
   object oSelf=OBJECT_SELF;
  object oPC=GetLastUsedBy();
  string sTool = "cnrWoodCutterAxe";
  string sToolOptional = "cnrWoodCutterAxe";

  if (GetLocalInt(oPC,"iAmDigging")!= 0) return;
  if (GetLocalInt(oSelf,"iAmSetToDie")==0)SetLocalInt(oPC,"iAmDigging",99);
  DelayCommand(5.0,SetLocalInt(oPC,"iAmDigging",0));

////////////nomis odstraneni effektu invis a hide..///////////////////////
//effect no_effect=GetFirstEffect(oPC);
//while (GetIsEffectValid(no_effect))
//   {
//   if (GetEffectType(no_effect)==EFFECT_TYPE_INVISIBILITY) RemoveEffect(oPC,no_effect);
//   if (GetEffectType(no_effect)==EFFECT_TYPE_IMPROVEDINVISIBILITY) RemoveEffect(oPC,no_effect);
//   if (GetEffectType(no_effect)==EFFECT_TYPE_SANCTUARY) RemoveEffect(oPC,no_effect);
//   no_effect=GetNextEffect(oPC);
//   }
//////////////////////////////////////////////////////////////


  string sResource = "";
  string sSuccessString = "";
  string sFailString = "";
  string sOldSkill = "";
  string sOldSkill2 = "";
  string sAppearance;
  //int iWoodCutSkill=GetTokenPair(oPC,14,3);
  int iWoodCutSkill = CnrGetPersistentInt(oPC,"iWoodCutSkill");
  int iDigChance=iWoodCutSkill;
  int iSuccess=0;
  int iToolBreak=GetLocalInt(oPC,"iToolWillBreak");
  int iRandom = 0;
  int iMaxDig = GetLocalInt(oSelf,"iMaxDig");
  if (iMaxDig==0)
   {
        if (sSelf == "cnrTreeOak") iMaxDig=6+d10(2);
        if (sSelf == "cnrTreeMahogany")  iMaxDig=6+d10(1);
        if (sSelf == "cnrTreeHickory") iMaxDig=4+d10(1);
        if (sSelf == "cnrTreeVrba") iMaxDig=3+d8(1);
        if (sSelf == "cnrTreeTis") iMaxDig=2+d6(1);
        if (sSelf == "cnrTreeJil") iMaxDig=1+d4(1);
        if (sSelf == "cnrTreeZel") iMaxDig=0+d4(1);
        if (sSelf == "cnrTreePra") iMaxDig=0;

    // 5.5.2014 NOmis maxdiging je zavisly na surovine.
    //iMaxDig=d4(2);
    SetLocalInt(oSelf,"iMaxDig",iMaxDig);
   }
  object oTool=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  if ((GetTag(oTool) != sTool)||(GetTag(oTool) != sToolOptional))
    oTool = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if ((GetTag(oTool) != sTool)||(GetTag(oTool) != sToolOptional))
     {
        SendMessageToPC(oPC,"K tezbe potrebujes sekeru.");
        return;
     }

  if (iDigChance < 350)
   {
    iDigChance = GetAbilityScore(oPC,ABILITY_STRENGTH)*5;
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_CONSTITUTION)*3);
    iDigChance = iDigChance + (GetAbilityScore(oPC,ABILITY_DEXTERITY)*2);
    iDigChance = iDigChance*3;
    if (iDigChance >350) iDigChance = 350;
    if (iWoodCutSkill>iDigChance)iDigChance=iWoodCutSkill;
   }

   sFailString = "Chvilku jsi sek(a), ale napodarilo se Ti zadny pouzitelny kus dreva.";
   sSuccessString = "Odsekl(a) jsi poradny kus dreva";
   // zvuky kopani
   AssignCommand(OBJECT_SELF,DelayCommand(2.5,PlaySound("it_materialhard")));
   AssignCommand(OBJECT_SELF,DelayCommand(5.0,PlaySound("it_materialhard")));


// 29_4_2014 doplneni o hlusinu :
// no_hlusina  vec, co neumi nic.
int no_hlusina = 0;
int no_nahoda = d100();

        if ((sSelf == "cnrTreeOak") & (no_nahoda <= 15))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreeMahogany") & (no_nahoda <= 20))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreeHickory") & (no_nahoda <= 25))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreeVrba") & (no_nahoda <= 25))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreeTis") & (no_nahoda <= 30))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreeJil") & (no_nahoda <= 30))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreeZel") & (no_nahoda <= 35))  no_hlusina = 1 ;
        if ((sSelf == "cnrTreePra") & (no_nahoda <= 40))  no_hlusina = 1 ;

if (no_hlusina == 1) {
    sAppearance="temp_placeable";
    sResource = "no_vetve";
    sSuccessString = "Podarilo se ti osekat jen par vetvi";
    }//dostaneme jen hlusinu



  if ((sSelf == "cnrTreeOak")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "cnrBranchOak";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "cnrBranchMah";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }

  if ((sSelf == "cnrTreeMahogany")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "cnrBranchMah";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "cnrBranchHic";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }
  if ((sSelf == "cnrTreeHickory")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "cnrBranchHic";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "tc_drev_vrb";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }

  if ((sSelf == "cnrTreeVrba")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "tc_drev_vrb";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "tc_drev_tis";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }
  if ((sSelf == "cnrTreeTis")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "tc_drev_tis";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "tc_drev_jil";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }

  if ((sSelf == "cnrTreeJil")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "tc_drev_jil";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "cnrTreeZel";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }

  if ((sSelf == "cnrTreeZel")&(no_hlusina<1)) //skala
   {
    sAppearance="temp_placeable";
                         no_nahoda = d100();
                if (no_nahoda > (iWoodCutSkill/20) ) { sResource = "tc_drev_zel";
                sSuccessString = "Podarilo se ti useknout pekny kus klady";
                }
                else   { sResource = "tc_drev_pra";
                sSuccessString = "No tohle, kdo by to byl cekal !";
                }
   }

  if (sSelf == "cnrTreePra") // drevo prastareho dubu
   {
    sAppearance="temp_placeable";
    sResource = "tc_drev_pra";
}  ///nomis konec dodelavani

  iRandom = Random(1000);

  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,1.0,5.0));

  if (iRandom <= iDigChance)
    {
     DelayCommand(5.0,FloatingTextStringOnCreature(sSuccessString,oPC,FALSE));
     iMaxDig--;
     SetLocalInt(oSelf,"iMaxDig",iMaxDig);
     if (iMaxDig==1)
      {
       SetLocalInt(oSelf,"iAmSetToDie",99);
       SetLocalInt(oPC,"iAmDigging",0);
       DelayCommand(3.0,FloatingTextStringOnCreature("Zdroj je pryc!",oPC,FALSE));
       DelayCommand(6.5,ReplaceSelf(oSelf,sAppearance));
      }
     iSuccess = 1;
     DelayCommand(6.0,CreateAnObject(sResource,oPC));
     if (iMaxDig>1) DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     if (Random(1000)> iWoodCutSkill)
      {
       if (d10(1)+1>= iWoodCutSkill/1000)
        {
         if (GetLocalInt(oPC,"iSkillGain")==0)
          {
           if (iMaxDig>1)SetLocalInt(oPC,"iSkillGain",99);
           DelayCommand(10.0,SetLocalInt(oPC,"iSkillGain",0));
           iWoodCutSkill++;
           sOldSkill2 = IntToString(iWoodCutSkill);
           sOldSkill = "."+GetStringRight(sOldSkill2,1);
           if (iWoodCutSkill > 9)
             {
              sOldSkill = GetStringLeft(sOldSkill2,GetStringLength(sOldSkill2)-1)+sOldSkill;
             }
            else
             {
              sOldSkill = "0"+sOldSkill;
             }
           if (iWoodCutSkill <= 1000)
            {
             DelayCommand(6.0,CnrSetPersistentInt(oPC,"iWoodCutSkill",iWoodCutSkill));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
             DelayCommand(6.0,SendMessageToPC(oPC,"Tvoje dovednost se zlepsila!"));
             DelayCommand(6.0,SendMessageToPC(oPC,"Soucasna dovednost drevorubectvi je : "+

sOldSkill+"%"));
             DelayCommand(6.0,SendMessageToPC(oPC,"=================================="));
            }
          }
        }
      }
    }
   else
    {
     switch (d8(1))
      {
       case 1:{sFailString="Ten strom tu musel sta tisice let...";break;}
       case 2:{sFailString="Tak na tom si asi zlomim sekeru...";break;}
       case 3:{sFailString="radsi bych si mel dat pivo, nez to dosekam...";break;}
       case 4:{sFailString="Tak to je nejvetsi strom co sem videl..";break;}
       case 5:{sFailString="Mel bych toho nechat, nez na me tu nachytaji druidi !";break;}
       default:{break;}
      }
     DelayCommand(5.0,FloatingTextStringOnCreature(sFailString,oPC,FALSE));
     DelayCommand(5.5,AssignCommand(oPC,CheckAction(oPC,oSelf)));
     return;
    }

  if (iSuccess == 1)
   {
    iToolBreak++;
    //zmena 1.9.2014
//    if (iToolBreak > 20)
  if (iToolBreak > 60)
     {
      DelayCommand(6.0,FloatingTextStringOnCreature("Sakra, zlomila se mi sekera..",oPC,FALSE));
      DestroyObject(oTool,6.0);
      iToolBreak = 0;
     }
   }

  SetLocalInt(oPC,"iToolWillBreak",iToolBreak);
 }
}

void CheckAction(object oPC, object oSelf)
 {
  int iCurrentAction = GetCurrentAction(oPC);
  if (iCurrentAction == ACTION_MOVETOPOINT) return;
  if (iCurrentAction == ACTION_ATTACKOBJECT) return;
  if (iCurrentAction == ACTION_CASTSPELL) return;
  if (iCurrentAction == ACTION_REST) return;
  if (iCurrentAction == ACTION_PICKUPITEM) return;
  if (iCurrentAction == ACTION_SIT) return;
  if (GetDistanceBetween(oPC,oSelf) >2.5) return;

  AssignCommand(oPC,ActionInteractObject(oSelf));

 }

void CreateAnObject(string sResource, object oPC)
 {
  CreateItemOnObject(sResource,oPC,1);
  return;
 }

void ReplaceSelf(object oSelf, string sAppearance)
 {
  object oTemp;
  location lSelf;
  string sResSelf;
  sResSelf=GetResRef(oSelf);
  lSelf=GetLocation(oSelf);
  oTemp = CreateObject(OBJECT_TYPE_PLACEABLE,sAppearance,lSelf,FALSE);
  DestroyObject(oSelf,1.0);

//zmena 1.9.2014

//  AssignCommand(oTemp,DelayCommand(1200.0,CreateNew(lSelf,sResSelf)));
//  DestroyObject(oTemp,1230.0);
  AssignCommand(oTemp,DelayCommand(1000.0,CreateNew(lSelf,sResSelf)));
  DestroyObject(oTemp,1030.0);

  return;
 }

void CreateNew(location lSelf, string sResSelf)
 {
  CreateObject(OBJECT_TYPE_PLACEABLE,sResSelf,lSelf,FALSE);
  return;
 }

void CreatePlaceable(string sObject, location lPlace, float fDuration)
{
  object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE,sObject,lPlace,FALSE);
  if (fDuration != 0.0)
    DestroyObject(oPlaceable,fDuration);
}



// zakomentovano melvik 20,8.2008


/*
void main()
{
  object oUser = GetLastUsedBy();
  object oTarget = OBJECT_SELF;
  AssignCommand(oUser, DoPlaceableObjectAction(oTarget, PLACEABLE_ACTION_BASH));
}
*/



// zakomentovano melvik 20,8.2008


/*
void main()
{
  object oUser = GetLastUsedBy();
  object oTarget = OBJECT_SELF;
  AssignCommand(oUser, DoPlaceableObjectAction(oTarget, PLACEABLE_ACTION_BASH));
}
*/



void RemoveEffects(object oPC) {

////////////nomis odstraneni effektu invis a hide..///////////////////////
//AssignCommand(oPC, SetCommandable(FALSE));
//DelayCommand(1.0,AssignCommand(oPC, SetCommandable(TRUE)));
//SetActionMode(oPC,ACTION_MODE_STEALTH,0);
  effect no_effect=GetFirstEffect(oPC);
  while (GetIsEffectValid(no_effect)) {
    switch(GetEffectType(no_effect)) {
      case EFFECT_TYPE_SANCTUARY:
      case EFFECT_TYPE_INVISIBILITY:
      case EFFECT_TYPE_IMPROVEDINVISIBILITY:
      case EFFECT_TYPE_ETHEREAL:
        RemoveEffect(oPC,no_effect);
        break;
    }

    switch(GetEffectSpellId(no_effect)) {
      case SPELL_SANCTUARY:
      case SPELL_ETHEREALNESS:
      case SPELL_INVISIBILITY:
      case SPELL_IMPROVED_INVISIBILITY:
      case SPELL_INVISIBILITY_SPHERE:
        RemoveEffect(oPC,no_effect);
        break;
    }

    no_effect=GetNextEffect(oPC);
  }

  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,50),oPC,RoundsToSeconds(5));
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,50),oPC,RoundsToSeconds(5));

}
//////////////////////////////////////////////////////////////

void CallEnemyCreatures(object oPC) {
  //zavolani potvor na misto tezeni////////////////

  /* Call only once a time */
  if(GetLocalInt(OBJECT_SELF,"NPC_CALL_TIMEOUT") > ku_GetTimeStamp()) {
    return;
  }
  SetLocalInt(OBJECT_SELF,"NPC_CALL_TIMEOUT",ku_GetTimeStamp(60));

  location no_lokace = GetLocation(oPC);
  int i=1;

  object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC,OBJECT_SELF,i);
  while(GetIsObjectValid(oNPC) && i < 10) {
    if ( !GetIsFighting(oNPC) && GetReputation(oNPC, oPC) <=10 )  {
      AssignCommand(oNPC,ActionMoveToObject(oPC,TRUE) );
    }
    i++;
    oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC,OBJECT_SELF,i);
  }

}

