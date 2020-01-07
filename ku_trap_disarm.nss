// awards the disarming creature/PC 1000 XP for successfully
// disarming a trap when this script it placed in the trap's
// OnDisarm event
void main()
{
     object oPC = GetLastDisarmed();
     if (GetIsPC(oPC))
     {
          int iDC = GetTrapDisarmDC(OBJECT_SELF);
          int iSkill = GetSkillRank(SKILL_DISABLE_TRAP,oPC);
          /* No XP if PC should not be able to disarm trap - spell disarmed */
          if(iSkill == 0 || (iDC > iSkill + 20))
            return;
          int iXP = iDC - iSkill + d10();
          WriteTimestampedLogEntry("TRAP disarm: "+GetName(oPC)+" disarmed trap DC "+IntToString(iDC) + "with skill"+IntToString(iSkill)+". Got "+IntToString(iXP)+"XP");
          if(iXP > 0)
            SetXP(oPC,GetXP(oPC) + iXP);
     }
}
