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
       location l = GetLocation(oMagPole);
       float otoceni = GetFacingFromLocation(l);
       float noveOtoceni = GetRightDirection(otoceni);
       location lNova = Location(GetAreaFromLocation(l),GetPositionFromLocation(l),noveOtoceni);
       AssignCommand(oMagPole,ActionMoveToLocation(lNova));
       DelayCommand(10.0,VratVrataZpet(oMagPole));
}
