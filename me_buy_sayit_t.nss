#include"tc_constants"
void main()
{

    object oTable = GetNearestObjectByTag("me_selltable");

    string sBuing = GetLocalString(OBJECT_SELF, "THINGS_TO_BUY");
    if (sBuing == ""){
        SpeakString("Nic takoveho nekupuju...");
        return;   // kdyz nema nastaveny vykup
    }

    int iPriceSum = 0;
    int iPrice = 0;
    int iStack = 0;
    object oPC = GetPCSpeaker();
    object oItem;

    oItem = GetFirstItemInInventory(oTable);

    while (oItem != OBJECT_INVALID)
    {
        iPrice = GetLocalInt(oItem, sBuing);
        if ((iPrice != 0)||(GetStringLeft(GetTag(oItem), 5) == "tc_al"))
        {
            iStack =  GetNumStackedItems(oItem);
            // alchymie
            if((GetStringLeft(GetTag(oItem), 5) == "tc_al"))
                {
                string sTempProp = "";
                object oModule = GetModule();

                int index =0;
                int iSum = 0;
                int i;
                for(i=0;i < (GetStringLength(GetTag(oItem))-10)/3; i++) {
                    sTempProp = GetSubString(GetTag(oItem),10+3*i,3);
                    if(GetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + sTempProp) != 0) iSum = iSum + GetLocalInt(oModule, ALCH_PROPERTY_STR_PREFIX + sTempProp) ;
                }

                if(iSum <= 5){
                    iSum = 10;
                }else if(iSum <= 10){
                    iSum = 35;
                }else if(iSum <= 20){
                    iSum = 90;
                }else if(iSum <= 30){
                    iSum = 170;
                }else if(iSum <= 40){
                    iSum = 330;
                }else if(iSum <= 50){
                    iSum = 540;
                }else if(iSum <= 60){
                    iSum = 740;
                }else if(iSum <= 70){
                    iSum = 1050;
                }else if(iSum <= 80){
                    iSum = 1650;
                }else if(iSum <= 90){
                    iSum = 2050;
                }else if(iSum <= 99){
                    iSum = 4050;
                }
                iPrice = FloatToInt(IntToFloat(iSum) * 1.2); // o 20 procent

            }
            iPriceSum += (iPrice * iStack);
        }
        oItem = GetNextItemInInventory(oTable);
    }
    if (iPriceSum == 0){
        SpeakString("Hmmm, nevidim na stolku nic co by me zajimalo.");
    }else{
        SpeakString("Za to co vidim ti dam... No... " + IntToString(iPriceSum) + " zlatek.");
    }
    return;
}
