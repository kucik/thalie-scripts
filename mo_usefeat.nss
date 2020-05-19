/* mo_usefeat script
 * Library used to use feat through chat command

 * Created: 12. 02. 2020
 * Created by: Mourisson1
*/

// Functions declaration
void mo_useFeat(object oPC, string param);

void mo_useFeat(object oPC, string param){
    object oTarget = GetAttackTarget(oPC);
    if (GetIsObjectValid(oTarget) == FALSE) return;
    if (param == "srazeni" || param == "knockdown"){
        if(GetHasFeat(FEAT_IMPROVED_KNOCKDOWN, oPC))
            AssignCommand(oPC, ActionUseFeat(FEAT_IMPROVED_KNOCKDOWN, oTarget));
        else
            AssignCommand(oPC, ActionUseFeat(FEAT_KNOCKDOWN, oTarget));
    } else if (param == "odzbrojeni" || param == "disarm"){
        AssignCommand(oPC, ActionUseFeat(FEAT_DISARM, oTarget));
    } else if (param == "fist" || param == "pest") {
        AssignCommand(oPC, ActionUseFeat(FEAT_STUNNING_FIST, oTarget));
    } else if (param == "kidamage" || param == "kizraneni") {
        AssignCommand(oPC, ActionUseFeat(FEAT_KI_DAMAGE, oTarget));
    }
}
