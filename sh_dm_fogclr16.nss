object oPCspeaker = GetPCSpeaker();
object oArea =GetArea(oPCspeaker);
object oCheck2 = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck2,"DMSetNumber");
//Using preset so you do not have to deal with large numbers if you do not want too.
/*
You could easily add any more presets you want. :)
0  BLACK           = 0;
1  RED             = 16711680;
2  RED_DARK        = 6684672;
3  GREEN           = 65280;
4  GREEN_DARK      = 23112;
5  BLUE            = 255;
6  BLUE_DARK       = 102;
7  YELLOW          = 16776960;
8  YELLOW_DARK     = 11184640;
9  CYAN            = 65535;
10 MAGENTA         = 16711935;
11 ORANGE          = 16750848;
12 ORANGE_DARK     = 13395456;
13 BROWN           = 10053120;
14 BROWN_DARK      = 6697728;
15 GREY            = 10066329;
16 WHITE           = 16777215;
*/

void main()
{
int iPreset;
if(iDMSetNumber==0)iPreset = 0;
if(iDMSetNumber==1)iPreset = 16711680;
if(iDMSetNumber==2)iPreset = 6684672;
if(iDMSetNumber==3)iPreset = 65280;
if(iDMSetNumber==4)iPreset = 23112;
if(iDMSetNumber==5)iPreset = 255;
if(iDMSetNumber==6)iPreset = 102;
if(iDMSetNumber==7)iPreset = 16776960;
if(iDMSetNumber==8)iPreset = 11184640;
if(iDMSetNumber==9)iPreset = 65535;
if(iDMSetNumber==10)iPreset = 16711935;
if(iDMSetNumber==11)iPreset = 16750848;
if(iDMSetNumber==12)iPreset = 13395456;
if(iDMSetNumber==13)iPreset = 10053120;
if(iDMSetNumber==14)iPreset = 6697728;
if(iDMSetNumber==15)iPreset = 10066329;
if(iDMSetNumber==16)iPreset = 16777215;


SetFogColor(FOG_TYPE_ALL,iPreset,oArea);
}
