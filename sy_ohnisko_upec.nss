/* upecie maso */

void main()
{
    object oPlayer = GetPCSpeaker();

    //ak nehori neda sa piect
    int iHori = GetLocalInt(OBJECT_SELF,"hori");
    if (iHori==0) {
        FloatingTextStringOnCreature("*Nehori ohen*",oPlayer,0);
        return;
    }

    //najdem prve surove maso
    object oItem = GetFirstItemInInventory(oPlayer);
    while (oItem!=OBJECT_INVALID)
    {
        //tu dat rozhodnutie podla TAGU alebo premennych
        //premenna moze urcovat priamo na co sa surova vec
        //premeni po upeceni
        //int iItemType = GetLocalInt(oItem,"ItemType");
        //if (iItemType==6) break; //je to surove jedlo na pecenie
        if ((GetTag(oItem)=="Masokraba") ||
            (GetTag(oItem)=="cnrAnimalMeat")||
            (GetStringLeft(GetTag(oItem),7)=="ry_maso") ||
            (GetStringLeft(GetTag(oItem),7)=="ry_ryba") ||
            (GetTag(oItem)=="ry_rak") ||
            (GetResRef(oItem)=="ry_vykstirga")
            )
          break;
        oItem = GetNextItemInInventory(oPlayer);
    }

    //ak sa naslo upecie sa, ak nieje vypise sa sprava
    if (oItem!=OBJECT_INVALID)
    {
        PlaySound("al_na_firelarge1");
        //string sVyzor = GetLocalString(oItem,"Vyzor");
        int iCena = 5 + GetLocalInt(oItem, "TROFEJ"); //navyseni cenny masa o 5zl - urceni nove
        string sName = GetName(oItem) + " *opecene*";
        int iStack = GetItemStackSize(oItem);
        string sAnimal = GetLocalString(oItem,"ANIMAL_NAME");
        if(iStack > 1)
          SetItemStackSize(oItem,iStack - 1);
        else
          DestroyObject(oItem);

        int iNutrition = 15 + Random(10);
        oItem = CreateItemOnObject("sy_maso_pecene",oPlayer,1,"food00"+IntToString(iNutrition)+"00");
        if(GetStringLength(sAnimal) > 0) {
          sName = GetName(oItem)+" - "+sAnimal;
          SetName(oItem,sName);
        }
        SetLocalInt(oItem, "HOSTINSKY", iCena); //navyseni cenny masa o 5zl - nastaveni vykupu u hostinskeho
        AssignCommand(oPlayer,SpeakString("*Opeka nad ohnem*",TALKVOLUME_TALK));
        AssignCommand(oPlayer, ActionPlayAnimation (ANIMATION_FIREFORGET_STEAL, 1.0, 3.0));
    } else
    {
        FloatingTextStringOnCreature("*Nemas zadne surove jidlo u sebe*",oPlayer,0);
    }
}
