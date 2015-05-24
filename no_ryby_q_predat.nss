//skript pro odkooupeni veci

object no_Item;
object no_oPC;
string no_nazev;
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

               while (no_pocet > 0 )  {
                  no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
                    if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                            no_pocet = no_pocet-1;          // to snizujes dvakrat po sobe
                            SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);
                            //GiveGoldToCreature(no_oPC, 30);        //tady je pocet zlata kolik se da za posledni
                            DestroyObject(no_Item);
                            cnt++;
                            break;
                    }
                    else {
                      SetItemStackSize(no_Item,no_stacksize-1);      //snizi stack o 1
                    }
                no_pocet = no_pocet-1;                                   //snizi se promena na obchodnikovy
                SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);

           }
           }      //konec vyhazovani do kose

           int price = GetLocalInt(no_Item,"HOSTINSKY");
           if(price == 0)
             price = 5;
           while (no_pocet > 0 )  {
                  no_stacksize = GetItemStackSize(no_Item);      //zjisti kolik je toho ve stacku
                    if (no_stacksize == 1)  {                     // kdyz je posledni znici objekt
                            no_pocet = no_pocet-1;          // to snizujes dvakrat po sobe
                            SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);
                            //GiveGoldToCreature(no_oPC, 30);        //tady je pocet zlata kolik se da za posledni
                            DestroyObject(no_Item);
                            cnt++;
                            break;
                    }
                    else {
                      SetItemStackSize(no_Item,no_stacksize-1);      //snizi stack o 1
                    }

                cnt++;
                no_pocet = no_pocet-1;                                   //snizi se promena na obchodnikovy
                SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);
                if (no_pocet==0) break;

           }

    GiveGoldToCreature(no_oPC, cnt*price*10); //vykoupi desetkrat draz, nez normalne
    }  // cela procedura na vykup




