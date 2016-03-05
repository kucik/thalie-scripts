void main()
{
    if(GetLocalInt( OBJECT_SELF, "JA_CHRAM2_ACTIV"))
        return;

    if(!GetLocalInt( OBJECT_SELF, "JA_CHRAM2_AGE")){
        int iAge = Random(1000)+200;
        int iFirst = Random(iAge-100)+50;

        SetLocalInt( OBJECT_SELF, "JA_CHRAM2_AGE", iAge );
        SetLocalInt( OBJECT_SELF, "JA_CHRAM2_FIRST", iFirst );

        SetListenPattern( OBJECT_SELF, "*n", 1);
        SetListenPattern( OBJECT_SELF, "** *n **", 2);
        SetListenPattern( OBJECT_SELF, "** *n", 3);
        SetListenPattern( OBJECT_SELF, "*n **", 4);

        SetListening( OBJECT_SELF, TRUE );
    }

    int iAge = GetLocalInt( OBJECT_SELF, "JA_CHRAM2_AGE");
    int iMatch = GetListenPatternNumber();
    int iSaid = 0;

    if( iMatch == 1 || iMatch == 4 ){
        iSaid = StringToInt(GetMatchedSubstring(0));
    }
    else if( iMatch == 2  || iMatch == 3){
        iSaid = StringToInt(GetMatchedSubstring(2));
    }

    if( iSaid == iAge ){
        effect eStart = EffectVisualEffect( VFX_IMP_GOOD_HELP );

        ApplyEffectAtLocation( DURATION_TYPE_INSTANT, eStart, GetLocation(OBJECT_SELF) );
        PlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );

        SetLocalInt( OBJECT_SELF, "JA_CHRAM2_ACTIV", 1 );
    }
}
