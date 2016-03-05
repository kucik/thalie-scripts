void main()
{
    effect ePetrify = EffectPetrify();

    ApplyEffectToObject( DURATION_TYPE_PERMANENT, ePetrify, OBJECT_SELF );
    SetPlotFlag( OBJECT_SELF, TRUE );
}
