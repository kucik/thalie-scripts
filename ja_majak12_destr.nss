void main()
{
    int iTime = GetLocalInt( OBJECT_SELF, "JA_MAJAK12_DEST" );

    if( iTime % 10 == 0 ){
        PlayAnimation( ANIMATION_PLACEABLE_ACTIVATE );
        DelayCommand( 3.0f, ActionCastSpellAtObject(SPELL_FIRE_STORM, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE) );
        DelayCommand( 8.0f, AssignCommand( OBJECT_SELF, PlayAnimation( ANIMATION_PLACEABLE_DEACTIVATE ) ) );
   }

    SetLocalInt( OBJECT_SELF, "JA_MAJAK12_DEST", iTime+1 );
}
