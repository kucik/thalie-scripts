/*
    script vlozit do eventu OnExit pre trigger
    sluzi na ziskanie informacie ze hrac uz nestoji u vodneho zdroja
    a nemoze si nabrat kvapalinu do cutory
*/

void main()
{
    //na hracovi nastavim flag ze uz nestoji vo vode
    object oPlayer = GetExitingObject();
    SetLocalInt(oPlayer,"TypVody",0);
    DeleteLocalInt(oPlayer,"TypVody");
    SendMessageToPC(oPlayer,"<cDa >Opustas miesto s pitnym zdrojom</c>");
}
