/* INC pro spanek/meditaci
 * jaara - 4.2.02
 */

const int SPANEK = 0;
const int MEDITACE = 1;
const int MODLITBA = 2;

int getMinutesAwake(object oPC, string prefix){
        int iLastMinute = GetLocalInt(oPC, prefix+"LastMinute");
        int iLastHour = GetLocalInt(oPC, prefix+"LastHour");
        int iLastDay = GetLocalInt(oPC, prefix+"LastDay");
        int iLastMonth = GetLocalInt(oPC, prefix+"LastMonth");
        int iLastYear = GetLocalInt(oPC, prefix+"LastYear");

        int iMinute = GetTimeMinute();
        int iHour = GetTimeHour();
        int iDay  = GetCalendarDay();
        int iMonth = GetCalendarMonth();
        int iYear = GetCalendarYear();

        if (iYear != iLastYear)
            iMonth += 12;
        if (iMonth != iLastMonth)
            iDay += 30;
        if (iDay != iLastDay)
            iHour += 24 * (iDay - iLastDay);
        iMinute += 10 * (iHour - iLastHour); //10 minut v hodine

        int iAwake = iMinute - iLastMinute;

        return iAwake;
}

void setMinutesAwake(object oPC, string prefix){
    SetLocalInt(oPC, prefix+"LastMinute", GetTimeMinute());
    SetLocalInt(oPC, prefix+"LastHour", GetTimeHour());
    SetLocalInt(oPC, prefix+"LastDay", GetCalendarDay());
    SetLocalInt(oPC, prefix+"LastMonth", GetCalendarMonth());
    SetLocalInt(oPC, prefix+"LastYear", GetCalendarYear());
}

int getRestStyle(object oPC){
    int restStyle = SPANEK;
//    int restStyle = MEDITACE;

    int class1 = GetClassByPosition( 1, oPC );
    int class2 = GetClassByPosition( 2, oPC );

    if( class1 == CLASS_TYPE_SORCERER ||
        class1 == CLASS_TYPE_WIZARD ||
        class1 == CLASS_TYPE_RANGER ||
        class1 == CLASS_TYPE_MONK ||
        class1 == CLASS_TYPE_BARD ||
        class1 == CLASS_TYPE_DRUID){

        restStyle = MEDITACE;
    }
    else if(class1 == CLASS_TYPE_CLERIC ||
            class1 == CLASS_TYPE_PALADIN ){

        restStyle = MODLITBA;
    }

    if(restStyle == SPANEK){
        if( class2 == CLASS_TYPE_SORCERER ||
            class2 == CLASS_TYPE_WIZARD ||
            class2 == CLASS_TYPE_RANGER ||
            class2 == CLASS_TYPE_MONK ||
            class2 == CLASS_TYPE_BARD ||
            class2 == CLASS_TYPE_DRUID){

            restStyle = MEDITACE;
        }
        else if(class2 == CLASS_TYPE_CLERIC ||
                class2 == CLASS_TYPE_PALADIN ){

            restStyle = MODLITBA;
        }
    }
    if(restStyle == SPANEK)
      return MEDITACE;
    else
      return restStyle;
}

