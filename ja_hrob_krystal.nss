void main()
{
    object oWP = GetWaypointByTag("JA_HROB_TEL");

    if(GetLocalInt(OBJECT_SELF, "JA_ACTIV"))
        return;

    int iForce = GetLocalInt(oWP, "JA_FORCE");
    int iActiv = GetLocalInt(oWP, "JA_ACTIV");

    if(GetLocalInt(OBJECT_SELF, "JA_TRIED") == iActiv)
        return;

    if( Random(4-iActiv) == 0 || iForce == 3-iActiv ){
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF, "JA_ACTIV", 1);
        SetLocalInt(oWP, "JA_FORCE", 0);

        iActiv++;

        SetLocalInt(oWP, "JA_ACTIV", iActiv);

        if(iActiv == 4){
            CreateObject(OBJECT_TYPE_PLACEABLE, "ja_hrob_tel", GetLocation(oWP));
        }
        else{
            SetLocalInt(oWP, "JA_ACTIV", iActiv);
        }
    }
    else{
        SetLocalInt(oWP, "JA_FORCE", iForce+1);
        SetLocalInt(OBJECT_SELF, "JA_TRIED", iActiv);
    }

    SetLocalInt(oWP, "JA_HROB_FIRST", 1);
}
