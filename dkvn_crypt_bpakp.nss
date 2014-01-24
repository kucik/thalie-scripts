#include "x0_i0_position"
void VratVrataZpet(object vrata)
{
       location l = GetLocation(vrata);
       float otoceni = GetFacingFromLocation(l);
       float noveOtoceni = GetLeftDirection(otoceni);
       location lNova = Location(GetAreaFromLocation(l),GetPositionFromLocation(l),noveOtoceni);
       AssignCommand(vrata,ActionMoveToLocation(lNova));

}


void main()
{
    string sMagPole = "dkvn_MagPole_mid";
    object oMagPole = GetObjectByTag(sMagPole);
    object paka = OBJECT_SELF;
    int data = GetLocalInt(paka,"data");

    SetLocalInt(oMagPole,"data"+IntToString(data),
    GetLocalInt(oMagPole,"data"+IntToString(data))+1
    );
    if (GetLocalInt(oMagPole,"data1") > 0 &&  GetLocalInt(oMagPole,"data2") > 0)
    {
       location l = GetLocation(oMagPole);
       float otoceni = GetFacingFromLocation(l);
       float noveOtoceni = GetRightDirection(otoceni);
       location lNova = Location(GetAreaFromLocation(l),GetPositionFromLocation(l),noveOtoceni);
       AssignCommand(oMagPole,ActionMoveToLocation(lNova));
       DelayCommand(120.0,VratVrataZpet(oMagPole));
    }


    DelayCommand(10.0,SetLocalInt(oMagPole,"data"+IntToString(data),GetLocalInt(oMagPole,"data"+IntToString(data))-1));



}
