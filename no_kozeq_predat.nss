//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
int no_pocet;
int price;
int momentalni_price;
int no_stacksize;
void main()
{
no_oPC = GetPCSpeaker();


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




int cnt=0;
price == 0;

if (GetIsObjectValid(no_Item)) {


no_Item = GetFirstItemInInventory(no_oPC);
while (GetIsObjectValid(no_Item)) {

 if (no_pocet==0)
 break;

 if(GetResRef(no_Item) != no_nazev) {
 no_Item = GetNextItemInInventory(no_oPC);
 continue;
 }

 no_pocet = no_pocet-1; //snizi se promena
 cnt++;
 momentalni_price = GetLocalInt(no_Item,"TROFEJ");
 if (momentalni_price == 0)  {momentalni_price = 5;  }  //nastavi vykupni cenu
 DestroyObject(no_Item);
 price = price + momentalni_price;


 no_Item = GetNextItemInInventory(no_oPC);
}


    //cena o pulku vyssi

SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);



float price2 = price * 1.5;
no_nazev = IntToString( FloatToInt(price2));

SpeakString( "Tady mas za tech  " + IntToString(cnt) + " kuzi  " + no_nazev + " zlatek");

    GiveGoldToCreature(no_oPC, StringToInt(no_nazev)); //vykoupi 1,5 draze, nez normalne
    }  // cela procedura na vykup
    }

