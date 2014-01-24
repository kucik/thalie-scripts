object oPCspeaker = GetPCSpeaker();
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
int iAppearance =GetAppearanceType(oTarget);
string sModel =Get2DAString("appearance","MODELTYPE",iAppearance);
string sModelL =GetStringLeft(sModel,1);
int iRace =GetRacialType(oTarget);
int iGender =GetGender(oTarget);
int iSize =GetCreatureSize(oTarget);
int icategory = GetLocalInt(oTarget,"category");
int iOriginalTail = GetLocalInt(oTarget,"OriginTail");
int iCustomScale = GetLocalInt(oTarget,"CustomScale");


//Trog works best with elf-male  (custom 11)
//Need to find a good invisible for the new gem golems

void CustomScale(object oTarget)
{



if(iAppearance <= 6 || iOriginalTail ==-1)
{
SendMessageToPC(oPCspeaker,"This is a parts based creature and cannot be scaled or does not have a valid tail");
return;
}

if(iCustomScale==1)
{
//SendMessageToPC(oPCspeaker,"C DEBUG1");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 569);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 570);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 571);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 572);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 573);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 574);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 575);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 576);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 577);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,578);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,579);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 580);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 581);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 582);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 583);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 584);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 585);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 586);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 587);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 588);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==2)
{
//SendMessageToPC(oPCspeaker,"C DEBUG2");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 829);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 830);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 831);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 832);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 833);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 834);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 835);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 836);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 837);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget, 838);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget, 839);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 840);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 841);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 842);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 843);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 844);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 845);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 846);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 847);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 848);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==3)
{
//SendMessageToPC(oPCspeaker,"C DEBUG3");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 849);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 850);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 851);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 852);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 853);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 854);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 855);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 856);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 857);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget, 858);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget, 859);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 860);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 861);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 862);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 863);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 864);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 865);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 866);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 867);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 868);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==4)
{
//SendMessageToPC(oPCspeaker,"C DEBUG4");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 589);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 590);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 591);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 592);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 593);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 594);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 595);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 596);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 597);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,598);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,599);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 600);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 601);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 602);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 603);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 604);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 605);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 606);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 607);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 608);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==5)
{
//SendMessageToPC(oPCspeaker,"C DEBUG5");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 609);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 610);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 611);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 612);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 613);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 614);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 615);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 616);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 617);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,618);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,619);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 620);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 621);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 622);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 623);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 624);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 625);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 626);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 627);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 628);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==6)
{
//SendMessageToPC(oPCspeaker,"C DEBUG6");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 629);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 630);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 631);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 632);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 633);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 634);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 635);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 636);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 637);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,638);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,639);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 640);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 641);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 642);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 643);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 644);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 645);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 646);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 647);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 648);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==7)
{
//SendMessageToPC(oPCspeaker,"C DEBUG7");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 649);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 650);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 651);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 652);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 653);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 654);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 655);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 656);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 657);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,658);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,659);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 660);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 661);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 662);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 663);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 664);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 665);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 666);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 667);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 668);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==8)
{
//SendMessageToPC(oPCspeaker,"C DEBUG8");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 669);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 670);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 671);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 672);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 673);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 674);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 675);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 676);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 677);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,678);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,679);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 680);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 681);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 682);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 683);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 684);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 685);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 686);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 687);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 688);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==9)
{
//SendMessageToPC(oPCspeaker,"C DEBUG9");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 689);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 690);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 691);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 692);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 693);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 694);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 695);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 696);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 697);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,698);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,699);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 700);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 701);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 702);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 703);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 704);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 705);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 706);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 707);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 708);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}
///////////////////////////////////////////////////////////////

if(iCustomScale==10)
{
//SendMessageToPC(oPCspeaker,"C DEBUG10");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 709);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 710);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 711);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 712);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 713);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 714);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 715);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 716);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 717);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,718);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,719);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 720);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 721);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 722);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 723);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 724);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 725);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 726);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 727);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 728);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==11)
{
//SendMessageToPC(oPCspeaker,"C DEBUG11");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 729);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 730);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 731);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 732);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 733);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 734);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 735);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 736);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 737);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,738);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,739);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 740);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 741);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 742);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 743);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 744);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 745);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 746);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 747);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 748);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==12)
{
//SendMessageToPC(oPCspeaker,"C DEBUG12");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 749);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 750);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 751);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 752);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 753);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 754);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 755);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 756);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 757);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,758);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,759);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 760);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 761);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 762);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 763);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 764);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 765);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 766);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 767);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 768);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==13)
{
//SendMessageToPC(oPCspeaker,"C DEBUG13");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 769);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 770);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 771);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 772);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 773);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 774);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 775);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 776);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 777);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,778);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,779);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 780);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 781);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 782);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 783);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 784);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 785);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 786);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 787);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 788);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==14)
{
//SendMessageToPC(oPCspeaker,"C DEBUG14");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 789);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 790);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 791);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 792);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 793);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 794);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 795);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 796);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 797);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,798);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,799);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 800);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 801);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 802);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 803);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 804);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 805);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 806);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 807);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 808);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iCustomScale==15)
{
//SendMessageToPC(oPCspeaker,"C DEBUG15");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 809);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 810);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 811);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 812);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 813);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 814);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 815);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 816);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 817);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,818);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,819);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 820);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 821);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 822);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 823);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 824);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 825);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 826);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 827);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 828);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}
}


void ScaleCreature(object oTarget)
{
if(iAppearance <= 6|| iOriginalTail ==-1)
{
SendMessageToPC(oPCspeaker,"This is a parts based creature and cannot be scaled or does not have a valid tail");
return;
}

if(iRace == RACIAL_TYPE_DRAGON || icategory== 1)
{
SetLocalInt(oTarget,"category",1);
//SendMessageToPC(oPCspeaker,"DEBUG1");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 569);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 570);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 571);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 572);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 573);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 574);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 575);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 576);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 577);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,578);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,579);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 580);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 581);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 582);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 583);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 584);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 585);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 586);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 587);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 588);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(sModelL == "S" && iRace != RACIAL_TYPE_DRAGON || icategory == 2)
{
SetLocalInt(oTarget,"category",2);
//SendMessageToPC(oPCspeaker,"DEBUG2");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 829);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 830);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 831);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 832);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 833);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 834);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 835);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 836);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 837);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget, 838);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget, 839);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 840);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 841);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 842);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 843);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 844);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 845);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 846);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 847);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 848);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(sModelL == "L"|| icategory == 3)
{
SetLocalInt(oTarget,"category",3);
//SendMessageToPC(oPCspeaker,"DEBUG3");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 849);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 850);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 851);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 852);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 853);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 854);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 855);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 856);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 857);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget, 858);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget, 859);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 860);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 861);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 862);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 863);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 864);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 865);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 866);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 867);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 868);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_DWARF && iGender == GENDER_FEMALE|| icategory == 4)
{
SetLocalInt(oTarget,"category",4);
//SendMessageToPC(oPCspeaker,"DEBUG4");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 589);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 590);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 591);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 592);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 593);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 594);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 595);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 596);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 597);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,598);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,599);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 600);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 601);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 602);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 603);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 604);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 605);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 606);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 607);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 608);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_ELF && iGender == GENDER_FEMALE || icategory == 5)
{
SetLocalInt(oTarget,"category",5);
//SendMessageToPC(oPCspeaker,"DEBUG5");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 609);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 610);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 611);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 612);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 613);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 614);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 615);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 616);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 617);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,618);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,619);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 620);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 621);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 622);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 623);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 624);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 625);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 626);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 627);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 628);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_GNOME && iGender == GENDER_FEMALE || icategory == 6)
{
SetLocalInt(oTarget,"category",6);
//SendMessageToPC(oPCspeaker,"DEBUG6");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 629);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 630);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 631);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 632);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 633);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 634);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 635);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 636);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 637);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,638);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,639);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 640);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 641);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 642);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 643);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 644);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 645);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 646);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 647);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 648);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_HALFLING && iGender == GENDER_FEMALE|| icategory == 7)
{
SetLocalInt(oTarget,"category",7);
//SendMessageToPC(oPCspeaker,"DEBUG7");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 649);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 650);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 651);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 652);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 653);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 654);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 655);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 656);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 657);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,658);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,659);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 660);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 661);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 662);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 663);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 664);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 665);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 666);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 667);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 668);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_HALFORC && iGender == GENDER_FEMALE|| icategory == 8)
{
SetLocalInt(oTarget,"category",8);
//SendMessageToPC(oPCspeaker,"DEBUG8");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 669);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 670);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 671);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 672);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 673);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 674);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 675);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 676);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 677);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,678);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,679);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 680);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 681);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 682);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 683);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 684);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 685);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 686);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 687);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 688);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_HUMAN && iGender == GENDER_FEMALE|| icategory == 9)
{
SetLocalInt(oTarget,"category",9);
//SendMessageToPC(oPCspeaker,"DEBUG9");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 689);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 690);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 691);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 692);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 693);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 694);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 695);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 696);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 697);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,698);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,699);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 700);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 701);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 702);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 703);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 704);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 705);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 706);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 707);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 708);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}
///////////////////////////////////////////////////////////////

if(iRace == RACIAL_TYPE_DWARF && iGender == GENDER_MALE || icategory == 10)
{
SetLocalInt(oTarget,"category",10);
//SendMessageToPC(oPCspeaker,"DEBUG10");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 709);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 710);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 711);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 712);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 713);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 714);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 715);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 716);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 717);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,718);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,719);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 720);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 721);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 722);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 723);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 724);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 725);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 726);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 727);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 728);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_ELF && iGender == GENDER_MALE|| icategory == 11)
{
SetLocalInt(oTarget,"category",11);
//SendMessageToPC(oPCspeaker,"DEBUG11");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 729);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 730);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 731);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 732);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 733);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 734);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 735);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 736);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 737);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,738);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,739);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 740);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 741);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 742);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 743);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 744);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 745);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 746);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 747);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 748);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_GNOME && iGender == GENDER_MALE|| icategory == 12)
{
SetLocalInt(oTarget,"category",12);
//SendMessageToPC(oPCspeaker,"DEBUG12");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 749);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 750);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 751);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 752);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 753);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 754);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 755);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 756);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 757);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,758);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,759);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 760);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 761);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 762);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 763);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 764);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 765);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 766);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 767);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 768);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_HALFLING && iGender == GENDER_MALE|| icategory == 13||sModelL == "F" && iSize ==CREATURE_SIZE_SMALL && iGender == GENDER_MALE && iRace == RACIAL_TYPE_HUMANOID_GOBLINOID||sModelL == "F" && iSize ==CREATURE_SIZE_SMALL && iGender == GENDER_MALE && iRace == RACIAL_TYPE_HUMANOID_REPTILIAN)
{
SetLocalInt(oTarget,"category",13);
//SendMessageToPC(oPCspeaker,"DEBUG13");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 769);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 770);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 771);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 772);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 773);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 774);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 775);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 776);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 777);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,778);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,779);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 780);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 781);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 782);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 783);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 784);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 785);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 786);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 787);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 788);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_HALFORC && iGender == GENDER_MALE|| icategory == 14||sModelL == "F" && iSize ==CREATURE_SIZE_MEDIUM && iGender == GENDER_MALE && iRace == RACIAL_TYPE_HUMANOID_GOBLINOID||sModelL == "F" && iSize ==CREATURE_SIZE_MEDIUM && iGender == GENDER_MALE && iRace == RACIAL_TYPE_HUMANOID_ORC||sModelL == "F" && iSize ==CREATURE_SIZE_MEDIUM && iGender == GENDER_MALE && iRace == RACIAL_TYPE_HUMANOID_REPTILIAN)
{
SetLocalInt(oTarget,"category",14);
//SendMessageToPC(oPCspeaker,"DEBUG14");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 789);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 790);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 791);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 792);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 793);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 794);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 795);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 796);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 797);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,798);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,799);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 800);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 801);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 802);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 803);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 804);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 805);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 806);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 807);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 808);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}

if(iRace == RACIAL_TYPE_HUMAN && iGender == GENDER_MALE || icategory == 15 ||sModelL == "F" && iSize ==CREATURE_SIZE_MEDIUM && iRace == RACIAL_TYPE_UNDEAD)
{
SetLocalInt(oTarget,"category",15);
//SendMessageToPC(oPCspeaker,"DEBUG15");
switch(iDMSetNumber)
    {
case 1:SetCreatureAppearanceType(oTarget, 809);SetCreatureTailType(iOriginalTail,oTarget);break;
case 2:SetCreatureAppearanceType(oTarget, 810);SetCreatureTailType(iOriginalTail,oTarget);break;
case 3:SetCreatureAppearanceType(oTarget, 811);SetCreatureTailType(iOriginalTail,oTarget);break;
case 4:SetCreatureAppearanceType(oTarget, 812);SetCreatureTailType(iOriginalTail,oTarget);break;
case 5:SetCreatureAppearanceType(oTarget, 813);SetCreatureTailType(iOriginalTail,oTarget);break;
case 6:SetCreatureAppearanceType(oTarget, 814);SetCreatureTailType(iOriginalTail,oTarget);break;
case 7:SetCreatureAppearanceType(oTarget, 815);SetCreatureTailType(iOriginalTail,oTarget);break;
case 8:SetCreatureAppearanceType(oTarget, 816);SetCreatureTailType(iOriginalTail,oTarget);break;
case 9:SetCreatureAppearanceType(oTarget, 817);SetCreatureTailType(iOriginalTail,oTarget);break;
case 10:SetCreatureAppearanceType(oTarget,818);SetCreatureTailType(iOriginalTail,oTarget);break;
case 11:SetCreatureAppearanceType(oTarget,819);SetCreatureTailType(iOriginalTail,oTarget);break;
case 12:SetCreatureAppearanceType(oTarget, 820);SetCreatureTailType(iOriginalTail,oTarget);break;
case 13:SetCreatureAppearanceType(oTarget, 821);SetCreatureTailType(iOriginalTail,oTarget);break;
case 14:SetCreatureAppearanceType(oTarget, 822);SetCreatureTailType(iOriginalTail,oTarget);break;
case 15:SetCreatureAppearanceType(oTarget, 823);SetCreatureTailType(iOriginalTail,oTarget);break;
case 16:SetCreatureAppearanceType(oTarget, 824);SetCreatureTailType(iOriginalTail,oTarget);break;
case 17:SetCreatureAppearanceType(oTarget, 825);SetCreatureTailType(iOriginalTail,oTarget);break;
case 18:SetCreatureAppearanceType(oTarget, 826);SetCreatureTailType(iOriginalTail,oTarget);break;
case 19:SetCreatureAppearanceType(oTarget, 827);SetCreatureTailType(iOriginalTail,oTarget);break;
case 20:SetCreatureAppearanceType(oTarget, 828);SetCreatureTailType(iOriginalTail,oTarget);break;
}
}
}


void main()
{
if(iCustomScale > 0)
{
CustomScale(oTarget);
DelayCommand(1.0,AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,1.0)));
DelayCommand(1.0,AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,1.0,1.0)));
return;
}
ScaleCreature(oTarget);
DelayCommand(1.0,AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,1.0,1.0)));
DelayCommand(1.0,AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,1.0,1.0)));
}
