//::///////////////////////////////////////////////
//:: FileName no_post_nema
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created On: 26.6.2008 16:42:08
//:://////////////////////////////////////////////

object no_Item;
object no_oPC;
int no_cena;
int StartingConditional()
{

  object oPC = GetPCSpeaker();

  if(!GetLocalInt(OBJECT_SELF,"sq_balik_waiting"))
    return FALSE;

  int iPrice = GetLocalInt(OBJECT_SELF,"sq_balik_price");
  iPrice = iPrice / 10;
  if  (GetGold(oPC) < no_cena) 
    return  FALSE;


  return TRUE;
}
