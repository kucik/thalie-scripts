void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "sh_dm_univ_int", 10*GetLocalInt(oPC, "sh_dm_univ_int") + 8);
    ExecuteScript("sh_dm_execute", oPC);
}
