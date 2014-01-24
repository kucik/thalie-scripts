// awards the disarming creature/PC 1000 XP for successfully
// disarming a trap when this script it placed in the trap's
// OnDisarm event
void main()
{
     object oPC = GetLastDisarmed();
     if (GetIsPC(oPC))
     {
          int iXP = GetTrapDisarmDC(OBJECT_SELF) - GetSkillRank(SKILL_DISABLE_TRAP,oPC) + d10();
          if(iXP > 0)
            SetXP(oPC,GetXP(oPC) + iXP);
     }
}
