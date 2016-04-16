//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
string no_pomocna;
int no_pocet;
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
if (GetIsObjectValid(no_Item)) {


           int price = GetLocalInt(no_Item,"HOSTINSKY");
           //if(price == 0)
            // price = 15;
                no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku

                if (no_pocet>no_stacksize)   no_pocet=no_stacksize;
                if (no_pocet<no_stacksize)   no_pocet= no_pocet;
                                                 //snizi se promena na obchodnikovy
    price=price*3*no_pocet; //cena desekrat vetsi
    no_nazev = IntToString(price);
    no_pomocna = IntToString(no_pocet);

  SpeakString( " Hm, dal bych ti za tolik " + no_pomocna + " ryb  " + no_nazev );
    }


}

