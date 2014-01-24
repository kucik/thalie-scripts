/*
  script vlozit do eventu OnEnter pre trigger
  sluzi na ziskanie informacie ze hrac je u vody a moze si
  ju nabrat do cutory
*/

void main()
{
    //zistit kto aktivoval event
    object oPlayer = GetEnteringObject();

    //zistim aky typ vody obsahuje triger
    //0-zem, 1-pitna voda, 2-slana voda, 3-otravena voda
    int iTypVody = GetLocalInt(OBJECT_SELF,"TypVody");

    //na hraca nastavi flag ze stoji vo vode = typ vody
    SetLocalInt(oPlayer,"TypVody",iTypVody);
    SendMessageToPC(oPlayer,"<cDa >Stojis blizko pitneho zdroja</c>");
}
