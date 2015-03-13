//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
int no_pocet;
int no_stacksize;

int __takeFromStack(object oItem, int iNeed) {
  if(iNeed <= 0)
    return 0;

  int iStack = GetItemStackSize(no_Item);
  
  if(iStack > iNeed) {
    SetItemStackSize(oItem, iStack - iNeed);
    return iNeed;
  }
  else {
    DestroyObject(oItem, 0.1);
    return iStack;
  }
}

void main()
{
no_oPC = GetPCSpeaker();
int NO_DEBUG = FALSE;

no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");//nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


int no_stacksize=1;
int no_penize = 0;
int cnt=0;
int price = 0;

  no_Item = GetFirstItemInInventory(no_oPC);
  while (GetIsObjectValid(no_Item)) {
    if (no_pocet <= 0)
      break;

    if(GetResRef(no_Item) != no_nazev) {
      no_Item = GetNextItemInInventory(no_oPC);
      continue;
    }

    price = GetLocalInt(no_Item,"tc_cena");
    if(price == 0)  
      price = 5;
  
    int iTake = __takeFromStack(no_Item, no_pocet);
    cnt = cnt + iTake;
    no_pocet = no_pocet - iTake;

    no_Item = GetNextItemInInventory(no_oPC);
  }

  if (cnt == 0) {
    SpeakString( " Zadne takove veci co bych potreboval u sebe nemas " );
    return;
  }

  SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);


  if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"cnt = "+ IntToString(cnt));
  if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"price = "+ IntToString(price));

  if (cnt>0) {
    SpeakString( " Dekuji za vyrobky.Tady mate tech "+ IntToString(FloatToInt(cnt*price*3.0))+"zlatych. Urcite prijdte nekdy zase, treba zase budu neco shanet. " );
    GiveGoldToCreature(no_oPC, FloatToInt(cnt*price*3.0)); //vykoupi 3x draze, nez normalne
  }  // cela procedura na vykup

}

