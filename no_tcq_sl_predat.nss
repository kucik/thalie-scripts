//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
int no_pocet;
int no_stacksize;
void main()
{
no_oPC = GetPCSpeaker();
int NO_DEBUG = FALSE;

no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");//nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


no_Item = GetFirstItemInInventory(no_oPC);  //pro kazde zavolani skriptu zacne od zacatku
                                            // DULEZITE!!! jinak se provede skript jednou a pamatuje si hodnotu itemu
                                            // nafurt i kdyz item nenajde..

while(GetIsObjectValid(no_Item))  {
  if(GetResRef(no_Item) == no_nazev)
    break;
  no_Item = GetNextItemInInventory(no_oPC);
  }
//takze projede vsechno a skonci bud pokud najde vec co je nastavena na postave, nebo pokud prohleda vsechno
if (!GetIsObjectValid(no_Item)) {
  SpeakString( " Zadne takove veci co bych potreboval u sebe nemas " );
  return;
}



int no_stacksize=1;
int no_penize = 0;
int cnt=0;
int price = 0;


no_Item = GetFirstItemInInventory(no_oPC);
while (GetIsObjectValid(no_Item)) {

 if(GetResRef(no_Item) != no_nazev) {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;
    }


if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"price = "+ IntToString(price));
if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"mame nas predmet");

 price = GetLocalInt(no_Item,"tc_cena");
 if(price == 0)  { price = 5; }
if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"price = "+ IntToString(price));

           no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
                    if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                            no_pocet = no_pocet-1;          // to snizuju
                            SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);
                            //GiveGoldToCreature(no_oPC, 30);        //tady je pocet zlata kolik se da za posledni
                            DestroyObject(no_Item);
                            cnt=cnt+1;
                    if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"stack size 1");
                    no_Item = GetNextItemInInventory(no_oPC);
                    continue;
                    }


                    if (no_stacksize > 1) {
                    SendMessageToPC(no_oPC,"stack size:" + IntToString(no_stacksize));
                            if (no_pocet>=no_stacksize)  {
                                            cnt=cnt + no_stacksize;
                                            SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet-no_stacksize);
                                            no_pocet=no_pocet-no_stacksize;
                                            DestroyObject(no_Item);
                                            if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"cnt = "+ IntToString(cnt));
                                            if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"nicim celej stack");
                                            no_Item = GetNextItemInInventory(no_oPC);
                                            continue;
                                            }
                            else if (no_pocet<no_stacksize) {
                                            cnt=cnt + no_pocet;
                                             SetLocalInt(OBJECT_SELF,"no_pocetveci",0);
                                             SetItemStackSize(no_Item,no_stacksize-no_pocet);

                                             if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"cnt = "+ IntToString(cnt));
                                             if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"itemstack =  "+ IntToString(no_stacksize-no_pocet));
                                             no_pocet = 0;
                                             break;
                                            }
                              //snizi stack o 1
                    }
if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"pocet:" + IntToString(no_pocet));
GetNextItemInInventory(no_oPC);

if (no_pocet==0) break;


}  //kdyz je objekt valid
if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"cnt = "+ IntToString(cnt));
if (NO_DEBUG == TRUE) SendMessageToPC(no_oPC,"price = "+ IntToString(price));

if (cnt>0) {
    SpeakString( " Dekuji za vyrobky.Tady mate tech "+ IntToString(FloatToInt(cnt*price*3.0))+"zlatych. Urcite prijdte nekdy zase, treba zase budu neco shanet. " );
    GiveGoldToCreature(no_oPC, FloatToInt(cnt*price*3.0)); //vykoupi 3x draze, nez normalne
    }  // cela procedura na vykup

    }

