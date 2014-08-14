//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
string no_pomocna;
int price;
int momentalni_price;
int no_pocet;
int no_stacksize;

void main()
{

int NO_DEBUG=FALSE;

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

//while (GetIsObjectValid(no_Item)) {
no_Item = GetFirstItemInInventory(no_oPC);

              while (GetIsObjectValid(no_Item)) {

                    if (no_pocet==0)
                    break;

                    if(GetResRef(no_Item) != no_nazev) {
                    no_Item = GetNextItemInInventory(no_oPC);
                    continue;
                    }

                cnt++;

                no_pocet = no_pocet-1;

                momentalni_price = GetLocalInt(no_Item,"TROFEJ");
if (NO_DEBUG==TRUE) SendMessageToPC(no_oPC,"momentalni_price =  : " + IntToString (momentalni_price));
                if (momentalni_price == 0)
                { momentalni_price = 5;  //nastavi vykupni cenu
                 }
if (NO_DEBUG==TRUE) SendMessageToPC(no_oPC,"price =  : " + IntToString (price) + "+" + IntToString (momentalni_price) );

                price = price + momentalni_price;
if (NO_DEBUG==TRUE)   SendMessageToPC(no_oPC,"po souctu  =  : " + IntToString (price));

                no_Item = GetNextItemInInventory(no_oPC);

                }  //while valid


//    } //if mame kuzi

    // no_pocet = (cnt*price*2);



    //cena desekrat vetsi

float price2 = price * 1.5;

no_nazev = IntToString( FloatToInt(price2));

  SpeakString( " Hm, no dal bych ti za tech " + IntToString(cnt) + " kuzi  " + no_nazev );
  }


}

