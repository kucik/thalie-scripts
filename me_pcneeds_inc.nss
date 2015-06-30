#include "me_pcneeds_inc_a"

const float MAX_FOOD = 1200.0;
const float MAX_WATER = 1200.0;
const float MAX_ALCOHOL = 1000.0;
const string VARNAME_FOOD = "FoodRating";
const string VARNAME_WATER = "WaterRating";
const string VARNAME_ALCOHOL = "AlcoholRating";

//float GetPCNeed(string sVarName, object oPC);

void PC_NeedsHB(object oPC);
void PC_NeedsOnRest(object oPC);

// pro itemy s neupravenym tagem
string PC_ConsumeItValues(object oPC,float fEnergyV,float fWaterV,float fAlcoholV);
// pro itemy s upravenym tagem
string PC_ConsumeIt(object oPC, object oItem);
void PC_DestroyIt( object oItem);
string HB_drain_needs(object oPC);
string CheckWater( object oPC);
string CheckEnergy( object oPC);
string CheckAlcohol( object oPC);

void effAlcohol1( object oPC);
void effAlcohol2( object oPC);
void effAlcohol3( object oPC);

void PC_NeedsNegativeEff(object oPC, string sNeed, int iEffLVL);


//------------- IMPLEMENTATION



void PC_NeedsHB(object oPC)
{
    float fWaterR = GetLocalFloat(oPC, VARNAME_WATER);
    float fAlcoholR = GetLocalFloat(oPC, VARNAME_ALCOHOL);
    float fFoodR = GetLocalFloat(oPC, VARNAME_FOOD);

    int iConPC = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);


    float fWater = fWaterR + (IntToFloat(iConPC)/100.0) - 2.6;
    float fVolume  = fAlcoholR + (IntToFloat(iConPC)/100.0) - 8.0;
    float fEnergy = fFoodR + (IntToFloat(iConPC)/100.0) - 1.8;

    // pridani konzumace do zasobniku
    SetLocalFloat(oPC, VARNAME_WATER,  fWater);
    SetLocalFloat(oPC, VARNAME_FOOD, fEnergy);
    SetLocalFloat(oPC, VARNAME_ALCOHOL,  fVolume);

    //cheknuti stavu zasobniku a provedeni prislusnych odpovidajicich akci

    string sResultWater = CheckWater(oPC);
    string sResultEnergy = CheckEnergy(oPC);
    string sREsultVolume = CheckAlcohol(oPC);

    SendMessageToPC(oPC,sResultWater);
    SendMessageToPC(oPC,sResultEnergy);
    SendMessageToPC(oPC,sREsultVolume);

}
void PC_NeedsOnRest(object oPC)
{
//    float fWaterR = GetLocalFloat(oPC, VARNAME_WATER);
    float fAlcoholR = GetLocalFloat(oPC, VARNAME_ALCOHOL);
  //  float fFoodR = GetLocalFloat(oPC, VARNAME_FOOD);

    int iConPC = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);

//    float fEnergy = (20.0 / 100.0) * fFoodR - IntToFloat(iConPC);
//    float fWater  = (IntToFloat(GetLocalInt(oItem,"WATER"))  / 100.0) * fWaterR - IntToFloat(iConPC);
    float fVolume = (40.0 / 100.0) * fAlcoholR + IntToFloat(iConPC);

    // pridani konzumace do zasobniku
    //SetLocalFloat(oPC, VARNAME_WATER, fWaterR + fWater);
    //SetLocalFloat(oPC, VARNAME_FOOD, fFoodR + fEnergy);
    SetLocalFloat(oPC, VARNAME_ALCOHOL, fAlcoholR - fVolume);

    //cheknuti stavu zasobniku a provedeni prislusnych odpovidajicich akci


    string sREsultVolume = CheckAlcohol(oPC);
    SendMessageToPC(oPC,sREsultVolume);
}


string PC_ConsumeItValues(object oPC,float fEnergyV,float fWaterV,float fAlcoholV)
{
    float fWaterR = GetLocalFloat(oPC, VARNAME_WATER);
    float fAlcoholR = GetLocalFloat(oPC, VARNAME_ALCOHOL);
    float fFoodR = GetLocalFloat(oPC, VARNAME_FOOD);

    int iConPC = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);




    float fEnergy = (2.0* fEnergyV * 0.01 * MAX_FOOD) - IntToFloat(iConPC);
    float fWater  = (2.0* fWaterV * 0.01 * MAX_WATER) - IntToFloat(iConPC);
    float fVolume = (2.0* fAlcoholV * 0.01 * MAX_ALCOHOL) - IntToFloat(iConPC);

    // pridani konzumace do zasobniku
    if(fEnergy >= 0.0){
        SetLocalFloat(oPC, VARNAME_FOOD, fFoodR + fEnergy);

        string sResultEnergy = CheckEnergy(oPC);
        SendMessageToPC(oPC,sResultEnergy);
    }
    if(fWater >= 0.0){
        SetLocalFloat(oPC, VARNAME_WATER, fWaterR + fWater);
        string sResultWater = CheckWater(oPC);
        SendMessageToPC(oPC,sResultWater);
    }
    if(fVolume >= 0.0){
        SetLocalFloat(oPC, VARNAME_ALCOHOL, fAlcoholR + fVolume);
        string sREsultVolume = CheckAlcohol(oPC);
        SendMessageToPC(oPC,sREsultVolume);
    }

    return "";
}

string PC_ConsumeIt(object oPC, object oItem)
{
    float fWaterR = GetLocalFloat(oPC, VARNAME_WATER);
    float fAlcoholR = GetLocalFloat(oPC, VARNAME_ALCOHOL);
    float fFoodR = GetLocalFloat(oPC, VARNAME_FOOD);

    int iConPC = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    float fConPCBon = IntToFloat( (iConPC/2) - 5 );

    string sName = GetTag(oItem);

         //pow(1.2,IntToFloat(-GetAbilityModifier(ABILITY_CONSTITUTION, oPC)
    float fEnergy = (2.0* StringToFloat(GetStringLeft(GetStringRight(sName,4),2)) * 0.01 * MAX_FOOD) - IntToFloat(iConPC);
    float fWater  = (2.0* StringToFloat(GetStringLeft(GetStringRight(sName,6),2)) * 0.01 * MAX_WATER) - IntToFloat(iConPC);
    float fVolume = (0.5* StringToFloat(GetStringRight(sName,2)) * 0.01 * MAX_ALCOHOL)* pow(1.2,- fConPCBon);  //kucik redukce alkoholu

    // pridani konzumace do zasobniku
    if(fEnergy >= 0.0){
        SetLocalFloat(oPC, VARNAME_FOOD, fFoodR + fEnergy);

        string sResultEnergy = CheckEnergy(oPC);
        SendMessageToPC(oPC,sResultEnergy);
    }
    if(fWater >= 0.0){
        SetLocalFloat(oPC, VARNAME_WATER, fWaterR + fWater);
        string sResultWater = CheckWater(oPC);
        SendMessageToPC(oPC,sResultWater);
    }
    if(fVolume >= 0.0){
        SetLocalFloat(oPC, VARNAME_ALCOHOL, fAlcoholR + fVolume);
        string sREsultVolume = CheckAlcohol(oPC);
        SendMessageToPC(oPC,sREsultVolume);
    }
    SetPlotFlag(oItem, FALSE);

    int iCharPC = GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
    if (GetStringLeft(GetTag(oItem),5)=="water"){
        if (iCharPC < 10) AssignCommand(oPC, ActionSpeakString("*Chlasta " + GetName(oItem, TRUE) + "*"));
        else  AssignCommand(oPC, ActionSpeakString("*Pije " + GetName(oItem, TRUE) + "*"));
    }
    if (GetStringLeft(GetTag(oItem),4)=="food"){
        if (iCharPC < 10) AssignCommand(oPC, ActionSpeakString("*Zere " + GetName(oItem, TRUE) + "*"));
        else  AssignCommand(oPC, ActionSpeakString("*Ji " + GetName(oItem, TRUE) + "*"));
    }
    if (GetStringLeft(GetResRef(oItem),3)=="cnr") PC_DestroyIt(oItem); // niceni cnr potravin

    return "";
}

void PC_DestroyIt( object oItem)
{
    int iStack = GetNumStackedItems( oItem);
    //SpeakString("pocet ve stacku>" + IntToString(iStack));
    if (iStack == 1){
        DestroyObject(oItem);//SetItemStackSize( oItem, iStack - 1);
    }
   /* else
    {
        DestroyObject(oItem);
    }     */
}

string CheckWater( object oPC)
{
    float fRating = GetLocalFloat(oPC,VARNAME_WATER );
    if(fRating > MAX_WATER) SetLocalFloat(oPC,VARNAME_WATER,MAX_WATER);
    if(fRating < 0.0) SetLocalFloat(oPC,VARNAME_WATER,0.0);
    int iNeedLVL = GetLocalInt(oPC, VARNAME_WATER + "needlvl");

    if ( (fRating > (MAX_WATER * 0.45)) &&  (fRating <= (MAX_WATER * 0.5)) )
        {
                SetLocalInt(oPC,VARNAME_WATER + "needlvl",1);
                PC_NeedsNegativeEff( oPC, VARNAME_WATER, 3);
            return  "<c XX>Co tak neco dobreho k piti?</c>";
        }
    if ( (fRating > (MAX_WATER * 0.4)) &&  (fRating <= (MAX_WATER * 0.45)) )
        {
                SetLocalInt(oPC,VARNAME_WATER + "needlvl",2);
                PC_NeedsNegativeEff( oPC, VARNAME_WATER, 2);
                return  "<c XX>Neco k piti by se siklo.</c>";
        }
    if ( (fRating > (MAX_WATER * 0.3)) &&  (fRating <= (MAX_WATER * 0.4)) )
        {
                SetLocalInt(oPC,VARNAME_WATER + "needlvl",2);
                PC_NeedsNegativeEff( oPC, VARNAME_WATER, 2);
                return  "<c XX>Zacinas mit zizen.</c>";
        }
    if ( (fRating > (MAX_WATER * 0.2)) &&  (fRating <= (MAX_WATER * 0.3)) )
        {
                SetLocalInt(oPC,VARNAME_WATER + "needlvl",2);
                PC_NeedsNegativeEff( oPC, VARNAME_WATER, 2);
                return  "<c XX>Mas zizen.</c>";
        }
    if( (fRating >= (MAX_WATER * 0.0)) &&  (fRating <= (MAX_WATER * 0.1)) )
        {
            // tady postih prislusny 1 - nejhorsi
            if (iNeedLVL != 3){
                SetLocalInt(oPC,VARNAME_WATER + "needlvl",3);
                PC_NeedsNegativeEff( oPC, VARNAME_WATER, 1);
            }
            return  "<c XX>Mas nesnesitelnou zizen.</c>";
        }

    return  "";
;}

string CheckEnergy( object oPC)
{
    float fRating = GetLocalFloat(oPC,VARNAME_FOOD );
    if(fRating > MAX_FOOD) SetLocalFloat(oPC,VARNAME_FOOD,MAX_FOOD);
    if(fRating < 0.0) SetLocalFloat(oPC,VARNAME_FOOD,0.0);
    int iNeedLVL = GetLocalInt(oPC, VARNAME_FOOD + "needlvl");

    if ( (fRating > (MAX_FOOD * 0.4)) &&  (fRating <= (MAX_FOOD * 0.5)) )
        {
            SetLocalInt(oPC,VARNAME_FOOD + "needlvl",1);
            return  "<c X >Neco k zakousnuti by se hodilo.</c>";
        }
    if ( (fRating > (MAX_FOOD * 0.3    )) &&  (fRating <= (MAX_FOOD * 0.4)) )
        {
            SetLocalInt(oPC,VARNAME_FOOD + "needlvl",2);
            return  "<c X >Zacinas mit hlad.</c>";
        }
    if ( (fRating > (MAX_FOOD * 0.2)) &&  (fRating <= (MAX_FOOD * 0.3)) )
        {
            SetLocalInt(oPC,VARNAME_FOOD + "needlvl",2);
            return  "<c X >Hlad, hlad, hlad...</c>";
        }
    if ( (fRating > (MAX_FOOD * 0.1)) &&  (fRating <= (MAX_FOOD * 0.2)) )
        {
            SetLocalInt(oPC,VARNAME_FOOD + "needlvl",2);
            return  "<c X >Hlady silhas.</c>";
        }

    if( (fRating >= (MAX_FOOD * 0.0)) &&  (fRating <= (MAX_FOOD * 0.1)) )
        {
            // tady postih prislusny 1 - nejhorsi
            if (iNeedLVL != 3){
                SetLocalInt(oPC,VARNAME_FOOD + "needlvl",3);
                PC_NeedsNegativeEff( oPC, VARNAME_FOOD, 1);
            }
            return  "<c X >Mas nesnesitelny hlad a tve telo slabne.</c>";
        }

    return  "";
;}


string CheckAlcohol( object oPC)
{
    float fRating = GetLocalFloat(oPC,VARNAME_ALCOHOL );
    if(fRating > MAX_ALCOHOL) SetLocalFloat(oPC,VARNAME_ALCOHOL,MAX_ALCOHOL);
    if(fRating < 0.0) SetLocalFloat(oPC,VARNAME_ALCOHOL,0.0);
    if ( (fRating > (MAX_ALCOHOL * 0.2)) &&  (fRating <= (MAX_ALCOHOL * 0.4)) )
        {
//            if (Random(1000) < FloatToInt( GetLocalFloat(oPC, VARNAME_ALCOHOL))) effAlcohol1( oPC);
            return  "<cX  >Mas velmi dobrou naladu.</c>";
        }
    else if ( (fRating > (MAX_ALCOHOL * 0.4)) &&  (fRating <= (MAX_ALCOHOL * 0.55)) )
        {
//            if (Random(1000) < FloatToInt( GetLocalFloat(oPC, VARNAME_ALCOHOL))) effAlcohol2( oPC);
            return  "<cX  >Alkohol se projevuje.</c>";
        }
    else if ( (fRating > (MAX_ALCOHOL * 0.55)) &&  (fRating <= (MAX_ALCOHOL * 0.7)) )
        {
//            if (Random(1000) < FloatToInt( GetLocalFloat(oPC, VARNAME_ALCOHOL))) effAlcohol2( oPC);
            return  "<cX  >Nadvlada nad telem je ta tam.</c>";
        }
    else if( (fRating >= (MAX_ALCOHOL * 0.7)) &&  (fRating <= (MAX_ALCOHOL * 0.9)) )
        {
//            if (Random(1000) < FloatToInt( GetLocalFloat(oPC, VARNAME_ALCOHOL))) effAlcohol3( oPC);
            return  "<cX  >Jsi jak sliva.</c>";
        }
    else if( (fRating >= (MAX_ALCOHOL * 0.9)) &&  (fRating <= (MAX_ALCOHOL * 1.1)) )
        {
//            if (Random(1000) < FloatToInt( GetLocalFloat(oPC, VARNAME_ALCOHOL))) effAlcohol3( oPC);
            return  "<cX  >Ses na mol.</c>";
        }
    return  "";
;}

void PC_NeedsNegativeEff(object oPC, string sNeed, int iEffLVL)
{
    if (sNeed == VARNAME_FOOD)
    {
        effect  eLVL1 = ExtraordinaryEffect(EffectSlow());
        effect  eLVL2 = ExtraordinaryEffect(EffectCurse(4, 4, 4, 4, 4, 4));
        effect  eLVL3 = ExtraordinaryEffect(EffectCurse(2, 2, 2, 2, 2, 2));
        switch(iEffLVL){
            case 1:
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL1, oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL3, oPC);
                break;
            case 2:
                //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL2, oPC);
                break;
            case 3:
                //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL3, oPC);
                break;
        }
    }
    else if (sNeed == VARNAME_FOOD)
    {
        effect  eLVL1 = ExtraordinaryEffect(EffectSlow());
        effect  eLVL2 = ExtraordinaryEffect(EffectCurse(4, 4, 4, 4, 4, 4));
        effect  eLVL3 = ExtraordinaryEffect(EffectCurse(2, 2, 2, 2, 2, 2));
        switch(iEffLVL){
            case 1:
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL1, oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL3, oPC);
                break;
            case 2:
                //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL2, oPC);
                break;
            case 3:
                //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLVL3, oPC);
                break;
          }
    }

}



void effAlcohol1( object oPC)
{
            switch(Random(4)){
                case 0:
                    DrunkenFoolOne( oPC);
                    break;
                case 1:
                    DrunkenFoolTwo( oPC);
                    break;
                case 2:
                    DrunkenFoolThree( oPC);
                    break;
                case 3:
                    DrunkenFoolSix( oPC);
                    break;
             }
}
void effAlcohol2( object oPC)
{
            switch(Random(9)){
                case 0:
                    DrunkenFoolOne( oPC);
                    break;
                case 1:
                    DrunkenFoolTwo( oPC);
                    break;
                case 2:
                    DrunkenFoolThree( oPC);
                    break;
                case 3:
                    DrunkenFoolSix( oPC);
                    break;
                case 4:
                    DrunkenFoolFour( oPC);
                    break;
                case 5:
                    DrunkenFoolFive( oPC);
                    break;
                case 6:
                    DrunkenFoolSeven( oPC);
                    break;
                case 7:
                    DrunkenFoolTen( oPC);
                    break;
                case 8:
                    DrunkenFoolSeven( oPC);
                    break;
             }
}
void effAlcohol3( object oPC)
{
        switch(Random(7)){
            case 0:
                DrunkenFoolTwo( oPC);
                break;
            case 1:
                DrunkenFoolThree( oPC);
                break;
            case 2:
                DrunkenFoolFour( oPC);
                break;
            case 3:
                DrunkenFoolFive( oPC);
                break;
            case 4:
                DrunkenFoolSeven( oPC);
                break;
            case 5:
                DrunkenFoolTen( oPC);
                break;
            case 6:
                DrunkenFoolSeven( oPC);
                break;
         }
}


