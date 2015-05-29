////////////////////////////////////////
////////////
//////////// najde vsechny veci co maji promennou tc_cena a vsecny koupi.
///////////////////////////////////////

void main()
{
object no_oPC = GetPCSpeaker();
object no_Item = GetFirstItemInInventory(no_oPC);
int no_cena = 0;

string no_vykup1 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY");
string no_vykup2 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY_2");
string no_vykup3 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY_3");
string no_vykup4 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY_4");
string no_vykup5 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY_5");
string no_vykup6 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY_6");
string no_vykup7 = GetLocalString(OBJECT_SELF,"THINGS_TO_BUY_7");

while (GetIsObjectValid(no_Item))
        {
       ///if (GetLocalInt(no_Item,"tc_cena") > 0 ){
          string no_resref = GetStringLeft(GetResRef(no_Item),6);

      //takze je to vec co zhanime bo je z craftu
       if ((no_resref==no_vykup1) || (no_resref==no_vykup2)|| (no_resref==no_vykup3)|| (no_resref==no_vykup4) || (no_resref==no_vykup5) || (no_resref==no_vykup6) || (no_resref==no_vykup7)   )
       {
            int probehnuti = FALSE;
       if ((GetItemStackSize(no_Item)*GetLocalInt(no_Item,"tc_cena"))> 0 ){
                       no_cena = no_cena + GetItemStackSize(no_Item)*( GetLocalInt(no_Item,"tc_cena"));
                       probehnuti = TRUE;
                       DestroyObject(no_Item);
                                                   }

       if ((FloatToInt(GetItemStackSize(no_Item)*GetLocalFloat(no_Item,"tc_cena"))> 0 )&(probehnuti ==FALSE)){
                       no_cena = no_cena + FloatToInt(GetItemStackSize(no_Item)*( GetLocalFloat(no_Item,"tc_cena")));
                       DestroyObject(no_Item);
                       }


                }///kdyz je to to , co chceme
       no_Item = GetNextItemInInventory(no_oPC);
       } //kdyz je valid



if (no_cena > 0 )
    { GiveGoldToCreature(no_oPC,no_cena);
    SpeakString( "Za tohle bych ti dal " + IntToString(no_cena) + " zlatych." );}
else if  (no_cena == 0 )
    { SpeakString( "Nemas u sebe nic, co bych koupil" ); }
else  SendMessageToPC(no_oPC, "// debug info, vykupni cena je zaporna !! ");

}
