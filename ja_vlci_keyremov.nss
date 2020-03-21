#include "ja_lib"

void Destroy(object oObject){
    effect eEff = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEff, GetLocation(oObject));
    DestroyObject(oObject);
}

void CreateWrapper(string sTemplate, location lLoc){
    CreateObject(OBJECT_TYPE_CREATURE, sTemplate, lLoc);
}

void main()
{
    string key = GetLocalString(OBJECT_SELF, "JA_VLCI_KRYSTAL");
    object oPC = GetPCSpeaker();
    object oKey = GetItemPossessedBy(oPC, key);

    DestroyObject(oKey);
    SetLocalInt(OBJECT_SELF, "JA_CRYSTAL_ON", 1);
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

    object oVlk = GetNearestObjectByTag("JA_VLCI_VLK1");
    int trigger = GetLocalInt(oVlk, "JA_CRYSTALS");
    int n = StringToInt(GetStringRight(key, 1));

    trigger |= 1 << (n-1);

    if(trigger == 15){ //all crystals activated
        FXWand_Earthquake(oVlk);

        effect eEff = EffectVisualEffect(VFX_FNF_PWKILL);
        location lVlk = GetLocation(oVlk);
        DelayCommand(3.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEff, lVlk));
        DelayCommand(3.0f, FXWand_Earthquake(oVlk));

        DelayCommand(Random(20)/10.0f+3.5f, Destroy(GetNearestObjectByTag("JA_VLCI_BOUL1")));
        DelayCommand(Random(20)/10.0f+3.5f, Destroy(GetNearestObjectByTag("JA_VLCI_BOUL2")));
        DelayCommand(Random(20)/10.0f+3.5f, Destroy(GetNearestObjectByTag("JA_VLCI_BOUL3")));
        DelayCommand(Random(20)/10.0f+3.5f, Destroy(GetNearestObjectByTag("JA_VLCI_BOUL4")));
        DelayCommand(Random(20)/10.0f+3.5f, Destroy(GetNearestObjectByTag("JA_VLCI_BOUL5")));
        DelayCommand(Random(20)/10.0f+3.5f, Destroy(GetNearestObjectByTag("JA_VLCI_VLK1")));

        DelayCommand(5.6, CreateWrapper("ry_prast_vlkod", lVlk));
    }
    else{
        SetLocalInt(oVlk, "JA_CRYSTALS", trigger);
    }
}
