/*
  vrati mulicu spet predavacovi, zato mu on da 20GP
  neda sa vratit ak ma mulica nejake veci v batohu
*/

void main()
{
    object oPC   = GetPCSpeaker();
    object oMula = GetLocalObject(oPC, "ja_mula");
    string sAppr = GetLocalString(OBJECT_SELF,"sy_predava");

    if (GetIsObjectValid(oMula)) {// && GetTag(oMula) == sAppr) {

        if (GetTag(oMula)!=sAppr) {
            SpeakString("Tohle neni moje zvire!");
            return;
        }

        if (LineOfSightObject(OBJECT_SELF,oMula)==FALSE) {
            SpeakString("Kde mas to zvire? Nevidim ho.");
            return;
        }

        object oItem = GetFirstItemInInventory(oMula);
        if (GetIsObjectValid(oItem)) {
            SpeakString("Tve zvire ma jeste veci v batohu.");
            return;
        }

        DeleteLocalObject(oPC, "ja_mula");
        GiveGoldToCreature(oPC,20);
        DestroyObject(oMula);
    }
    else SpeakString("Nemas zadne zvire u sebe!");
}
