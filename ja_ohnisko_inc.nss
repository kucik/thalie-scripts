//zisti ci objekt je drevo
int JeDrevo(string sDrevoTyp)
{
    if (sDrevoTyp=="cnrBranchMah") return 1;    //je to mahagon?
    if (sDrevoTyp=="cnrBranchOak") return 1;    //je to orech?
    if (sDrevoTyp=="cnrBranchHic") return 1;    //je to dub?
    return 0;   //nieje to drevo
}

const int DOBA_HORENI = 50; //5 minut

