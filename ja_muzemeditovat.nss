#include "ja_inc_meditace"

int StartingConditional()
{
    int style = getRestStyle(GetPCSpeaker());

    if(style == MEDITACE) SetCustomToken( 7050, "Meditovat." );
    else if(style == MODLITBA) SetCustomToken( 7050, "Modlit se." );

    return style;
}
