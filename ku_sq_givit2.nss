/**
 * ku_sq_givit<n>
 *
 * Script hráči předá předmět podle proměnné SQ_GIVEITEM<N>. Jako první hledá podle 
 * zadaného tagu v inventáři NPC. Pokud nenajde, zkusí vytvořit přemět podle resrefu 
 * z palety.
 *
 * Proměnné:
 * SQ_GIVEITEM2> <string> - Tag itemu v inventáři nebo resref v paletě.
 */

void __giveItem(string sItem) {
  object oPC = GetPCSpeaker();
  object oItem =  GetItemPossessedBy(OBJECT_SELF, sItem);
  if(GetIsObjectValid(oItem)) {
    CopyItem(oItem, oPC, TRUE);
    return;
  }

  CreateItemOnObject(sItem, oPC, 1);
}

void main() {
  string sItem = GetLocalString(OBJECT_SELF,"SQ_GIVEITEM2");
  __giveItem(sItem);
}
