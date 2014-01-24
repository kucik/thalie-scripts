void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "sh_dm_main_conv", 3);
    DeleteLocalInt(oPC, "sh_dm_univ_int");
}
