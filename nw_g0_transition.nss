////////////////////////////////////////////////////////////
// OnClick/OnAreaTransitionClick
// NW_G0_Transition.nss
// Copyright (c) 2001 Bioware Corp. - Modified by Moon
////////////////////////////////////////////////////////////
// Created By: Sydney Tang
// Created On: 2001-10-26
// Description: This is the default script that is called
//              if no OnClick script is specified for an
//              Area Transition Trigger or
//              if no OnAreaTransitionClick script is
//              specified for a Door that has a LinkedTo
//              Destination Type other than None.
//              Modification: Ports Associates with PC.
////////////////////////////////////////////////////////////
void main()
{
  object oPC = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);

  SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
      // Jump the PC
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToObject(oTarget));

    // Not a PC, so has no associates
    if (!GetIsPC(oPC))
        return;

    // Get all the possible associates of this PC
//  object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    object oDomin = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oFamil = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    object oAnimalComp = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);

    // Jump any associates
    //Henchmen commented out
/*  if (GetIsObjectValid(oHench)) {
        AssignCommand(oHench, ClearAllActions());
        AssignCommand(oHench, JumpToObject(oTarget));
    }    */
    if (GetIsObjectValid(oDomin)) {
        AssignCommand(oDomin, ClearAllActions());
        AssignCommand(oDomin, JumpToObject(oTarget));
    }
    if (GetIsObjectValid(oFamil)) {
        AssignCommand(oFamil, ClearAllActions());
        AssignCommand(oFamil, JumpToObject(oTarget));
    }
    if (GetIsObjectValid(oSummon)) {
        AssignCommand(oSummon, ClearAllActions());
        AssignCommand(oSummon, JumpToObject(oTarget));
    }
    if (GetIsObjectValid(oAnimalComp)) {
        AssignCommand(oAnimalComp, ClearAllActions());
        AssignCommand(oAnimalComp, JumpToObject(oTarget));
    }

}
