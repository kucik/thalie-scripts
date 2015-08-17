int sh_GetMunitionPackByType(string sTyp)
{
     if (sTyp == "bow")return 250;
     if (sTyp == "cro")return 250;
     return 1;
}



int sh_GetDamageByString(string sDamage)
{
   if (sDamage == "1")
   {
        return IP_CONST_DAMAGEBONUS_1;
   }
   if (sDamage == "2")
   {
        return IP_CONST_DAMAGEBONUS_2;
   }
   if (sDamage == "3")
   {
        return IP_CONST_DAMAGEBONUS_3;
   }
   if (sDamage == "4")
   {
        return IP_CONST_DAMAGEBONUS_4;
   }
   if (sDamage == "5")
   {
        return IP_CONST_DAMAGEBONUS_5;
   }
   if (sDamage == "6")
   {
        return IP_CONST_DAMAGEBONUS_6;
   }
   if (sDamage == "7")
   {
        return IP_CONST_DAMAGEBONUS_7;
   }
   if (sDamage == "8")
   {
        return IP_CONST_DAMAGEBONUS_8;
   }
   if (sDamage == "9")
   {
        return IP_CONST_DAMAGEBONUS_9;
   }
   if (sDamage == "10")
   {
        return IP_CONST_DAMAGEBONUS_10;
   }

   if (sDamage == "1d10")
   {
        return IP_CONST_DAMAGEBONUS_1d10;
   }
   if (sDamage == "1d12")
   {
        return IP_CONST_DAMAGEBONUS_1d12;
   }
   if (sDamage == "1d4")
   {
        return IP_CONST_DAMAGEBONUS_1d4;
   }
   if (sDamage == "1d6")
   {
        return IP_CONST_DAMAGEBONUS_1d6;
   }
   if (sDamage == "1d8")
   {
        return IP_CONST_DAMAGEBONUS_1d8;
   }
   if (sDamage == "2d10")
   {
        return IP_CONST_DAMAGEBONUS_2d10;
   }
   if (sDamage == "2d12")
   {
        return IP_CONST_DAMAGEBONUS_2d12;
   }
   if (sDamage == "2d4")
   {
        return IP_CONST_DAMAGEBONUS_2d4;
   }
   if (sDamage == "2d6")
   {
        return IP_CONST_DAMAGEBONUS_2d6;
   }
   if (sDamage == "2d8")
   {
        return IP_CONST_DAMAGEBONUS_2d8;
   }
   return 0;
}
/*SAVE DC*/
int sh_GetOnhitSaveDCByString(string sSaveDC)
{
   if (sSaveDC == "14")
   {
        return IP_CONST_ONHIT_SAVEDC_14;
   }
   if (sSaveDC == "16")
   {
        return IP_CONST_ONHIT_SAVEDC_16;
   }
   if (sSaveDC == "18")
   {
        return IP_CONST_ONHIT_SAVEDC_18;
   }
   if (sSaveDC == "20")
   {
        return IP_CONST_ONHIT_SAVEDC_20;
   }
   if (sSaveDC == "22")
   {
        return IP_CONST_ONHIT_SAVEDC_22;
   }
   if (sSaveDC == "24")
   {
        return IP_CONST_ONHIT_SAVEDC_24;
   }
   if (sSaveDC == "26")
   {
        return IP_CONST_ONHIT_SAVEDC_26;
   }
   return IP_CONST_ONHIT_SAVEDC_14;

}



itemproperty sh_GetMunitionItemProperty(string sParam1,string sParam2)
{
    itemproperty ip;
    int iBonus;
    if (sParam1 == "dmgp")
    {
        iBonus = StringToInt(sParam2);
        ip = ItemPropertyDamagePenalty(iBonus);
        return ip;
    }
    if (sParam1 == "dmgb")
    {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PHYSICAL,iBonus);
        return ip;
    }
   if (sParam1 == "fire")
   {
        iBonus = sh_GetDamageByString(sParam2);

        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,iBonus);
        return ip;
   }
   if (sParam1 == "cold")
   {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,iBonus);
        return ip;
   }
   if (sParam1 == "acid")
   {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ACID,iBonus);
        return ip;
   }
   if (sParam1 == "magic")
   {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,iBonus);
        return ip;
   }
  if (sParam1 == "elec")
  {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,iBonus);
        return ip;
  }
   if (sParam1 == "divund")
  {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_DIVINE,iBonus);
        return ip;
  }
   if (sParam1 == "stun")
  {
        iBonus = sh_GetOnhitSaveDCByString(sParam2);
        ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN,iBonus,IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS);
        return ip;
  }
  if (sParam1 == "dmgbpi")
  {
        iBonus = sh_GetDamageByString(sParam2);
        ip = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,iBonus);
        return ip;
  }
  ip = ItemPropertyNoDamage();
  return ip;

}


string sh_GetBaseMunitionItemTag(string sTyp, string sParam1)
{
  if (sParam1 == "dmgp")
  {
        if (sTyp == "bow")return "jy_sip_zledmg";
        if (sTyp == "cro")return "jy_sipka_zledmg";
  }
   if (sParam1 == "def")
  {
        if (sTyp == "bow")return "jy_sip_obyc";
        if (sTyp == "cro")return "jy_sipka_obyc";
  }
   if (sParam1 == "dmgb")
  {
        if (sTyp == "bow")return "jy_sip_dmg";
        if (sTyp == "cro")return "jy_sipka_dmg";
  }
   if (sParam1 == "fire")
  {
        if (sTyp == "bow")return "jy_sip_ohen";
        if (sTyp == "cro")return "jy_sipka_ohen";
  }
   if (sParam1 == "cold")
  {
        if (sTyp == "bow")return "jy_sip_chlad";
        if (sTyp == "cro")return "jy_sipka_chlad";
  }
   if (sParam1 == "acid")
  {
        if (sTyp == "bow")return "jy_sip_kys";
        if (sTyp == "cro")return "jy_sipka_kys";
  }
   if (sParam1 == "magic")
  {
        if (sTyp == "bow")return "jy_sip_magia";
        if (sTyp == "cro")return "jy_sipka_magia";
  }
   if (sParam1 == "elec")
  {
        if (sTyp == "bow")return "jy_sip_elek";
        if (sTyp == "cro")return "jy_sipka_elek";
  }
   if (sParam1 == "divund")
  {
        if (sTyp == "bow")return "jy_sip_undead";
        if (sTyp == "cro")return "jy_sipka_undead";
  }
   if (sParam1 == "stun")
  {
        if (sTyp == "bow")return "jy_sip_omrac";
        if (sTyp == "cro")return "jy_sipka_omrac";
  }
  if (sParam1 == "dmgbpi")
  {
        if (sTyp == "bow")return "jy_sip_bodne";
        if (sTyp == "cro")return "jy_sipka_bodne";
  }
  return "";
}



/*
Jmeno toulce
Toulec - <NAZEV_SIPU>
Tag toulce:
toulec_<typstreliva>_<param1>_<param2>
typ streliva:
- bow - sip
- cro - kus
param1:
- fire
- cold
- acid
- elec
- magic
- dmgp - damage penalty(-dmg)
- dmgb - damage bonus standart
- dmgbpi - damage bonus piercing
- divund - divine vs undead
- def_0 - bez bonusu
- stun - omraceni
param2
- cislo nebo d-hodnota
*/
void sh_GetMunitionFromTag(object oToulec,object oPC,object oTarget)
{
    //tag
    string sToulec = GetTag(oToulec);
    string sT =  GetSubString(sToulec,0,6);
    if (sT == "toulec")
    {
        int iPomocna;
        string sPomocna1 = GetSubString(sToulec,7,GetStringLength(sToulec)-6);
        iPomocna =FindSubString(sPomocna1,"_");
        string sTyp = GetSubString(sPomocna1,0,iPomocna);
        string sPomocna2 = GetSubString(sPomocna1,iPomocna+1,GetStringLength(sPomocna1)-iPomocna);
        iPomocna =FindSubString(sPomocna2,"_");
        string sParam1 = GetSubString(sPomocna2,0,iPomocna);
        string sParam2 = GetSubString(sPomocna2,iPomocna+1,GetStringLength(sPomocna2)-iPomocna);
        // jmeno
        string sToulecName = GetName(oToulec);
        string sMuniceName = GetSubString(sToulecName,8,GetStringLength(sToulecName)-8);

        //debug

        /*SendMessageToPC(oPC,"Toulec  je " + sToulecName);
          SendMessageToPC(oPC,"Munice  je " + sMuniceName);
        SendMessageToPC(oPC,"pomocna1  je " + sPomocna1);
        SendMessageToPC(oPC,"Typ je " + sTyp);
        SendMessageToPC(oPC,"sPomocna2 je " + sPomocna2);
        SendMessageToPC(oPC,"P1 je " + sParam1);
        SendMessageToPC(oPC,"P2 je " + sParam2+"tady konec"); */



        /* Init toulce*/
        if(!GetLocalInt(oToulec,"sh_used"))
        {
           //SendMessageToPC(oPC,"INIT");
            SetLocalInt(oToulec,"sh_used",TRUE);
            SetLocalInt(oToulec,"sh_contain",5000);
            SetLocalString(oToulec,"name",sMuniceName);
            SetStolenFlag(oToulec,TRUE);
            AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_UNIQUE_POWER,IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE),oToulec);
        }
        // pokud se jedna o vybirani sipu
        if(sPomocna1 == GetTag(oTarget) && GetName(GetItemPossessor(oToulec))==GetName(oPC))
        {
                int iObsah = GetLocalInt(oToulec,"sh_contain") + GetItemStackSize(oTarget);
                SetLocalInt(oToulec,"sh_contain",iObsah);
                DestroyObject(oTarget,0.0);
                SetDescription(oToulec,"Zbyva "+IntToString(iObsah)+" munice");
        }
        else
        {
            // promenne
            object oItem;
            string sTemplate =sh_GetBaseMunitionItemTag(sTyp, sParam1);
            //TEST 1
            //SendMessageToPC(oPC,"sTemplate je " + sTemplate);
            itemproperty  ip;
            int iPack = sh_GetMunitionPackByType(sTyp);

            int iObsah = GetLocalInt(oToulec,"sh_contain");
            if(iObsah < iPack)
            {
                iPack = iObsah;
            }

            //vytvoreni objektu
            oItem = CreateItemOnObject(sTemplate,oPC,iPack,sPomocna1);
            SetStolenFlag(oItem,TRUE);
            //pokud se nejedna o obycejny sip - prida item property
            if (sParam1 != "def")
            {
                //TEST 2
                //SendMessageToPC(oPC,"Vytvoreno");
                ip = sh_GetMunitionItemProperty(sParam1,sParam2);
               if (GetIsItemPropertyValid(ip))
               {
                    //SendMessageToPC(oPC,"valid");
                    DelayCommand(0.5,AddItemProperty(DURATION_TYPE_PERMANENT,ip,oItem));
               }

            }
            SetPlotFlag(oItem,1);
            SetStolenFlag(oItem,1);
            //nastaveni jmena  pro sip
            SetName(oItem,sMuniceName);


            //vypocet a ulozeni noveho obsahu
            iObsah = iObsah - iPack;
            SetLocalInt(oToulec,"sh_contain",iObsah);
            if(iObsah <= 0)
            {
                 DestroyObject(oToulec,3.0);
            }


            SetDescription(oToulec,"Zbyva "+IntToString(iObsah)+" munice");
        }

    }
}

