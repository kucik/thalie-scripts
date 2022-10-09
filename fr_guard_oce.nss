// OnCombatRoundEnd skript: fr_guard_oce
//
// NPC se po boji vrati na svou puvodni pozici (kdyz prezije), ktera je tvorena
// waypointem s tagem NW_BRANEC01
//
// Vytvoreno Frynem 30.9. 2022

void main()
{
// nastaveni mista kam se ma NPC vracet
object oDest = GetObjectByTag("NW_BRANEC01");

// prikaz pro navraceni NPC na jeho pozici (TRUE pro beh, FALSE pro chuzi)
ActionMoveToObject(oDest,TRUE);

// nahrani defaultniho skriptu
ExecuteScript("nw_c2_default3",OBJECT_SELF);
}
