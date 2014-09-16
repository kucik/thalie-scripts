void main() {
    object oPC = GetClickingObject();
    if(GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) {
      oPC = GetLastUsedBy();
    }
    object oTarget = GetLocalObject(OBJECT_SELF, "FUNCSEXT_TRANSITION_TARGET");

//    SpeakString("Executed trgclk. char:"+GetName(oPC)+" target:"+GetTag(oTarget));

    if(GetIsObjectValid(oTarget)) {
//        SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
        AssignCommand(oPC, JumpToObject(oTarget));
    }
}

