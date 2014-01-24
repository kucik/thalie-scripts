void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "sh_dm_main_conv", 2);
    DeleteLocalInt(oPC, "sh_dm_univ_int");
}
