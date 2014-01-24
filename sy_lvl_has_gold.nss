//podmienka ktora v dialogu umozni moznost zaplatit za trenink trenerovi ak hrac
//ma peniaze. ak nema peniaze, alebo nesplna moznost treningu riadok v dialogu
//sa nezobrazi

int StartingConditional()
{
    int nLvlCost = GetLocalInt(GetPCSpeaker(),"sy_gp_cost");
    if (nLvlCost==0) return 0;
    return 1;
}
