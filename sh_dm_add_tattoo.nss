object oPCspeaker = GetPCSpeaker();
string sDMstring = GetLocalString(oPCspeaker,"DMstring");
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");

//ADD tattoo to body parts with positives and removes with negative
//Add bone arm with 10,11,12 and removes with -10,-11,-12
void main()
{
int iBodypart;
int iNumber;
//tattoo part
if(iDMSetNumber ==1||iDMSetNumber ==-1)iBodypart = CREATURE_PART_TORSO;
if(iDMSetNumber ==2||iDMSetNumber ==-2)iBodypart = CREATURE_PART_RIGHT_BICEP;
if(iDMSetNumber ==3||iDMSetNumber ==-3)iBodypart = CREATURE_PART_RIGHT_FOREARM;
if(iDMSetNumber ==4||iDMSetNumber ==-4)iBodypart = CREATURE_PART_RIGHT_THIGH;
if(iDMSetNumber ==5||iDMSetNumber ==-5)iBodypart = CREATURE_PART_RIGHT_SHIN;
if(iDMSetNumber ==6||iDMSetNumber ==-6)iBodypart = CREATURE_PART_LEFT_BICEP;
if(iDMSetNumber ==7||iDMSetNumber ==-7)iBodypart = CREATURE_PART_LEFT_FOREARM;
if(iDMSetNumber ==8||iDMSetNumber ==-8)iBodypart = CREATURE_PART_LEFT_THIGH;
if(iDMSetNumber ==9||iDMSetNumber ==-9)iBodypart = CREATURE_PART_LEFT_SHIN;

//bone part
if(iDMSetNumber ==10||iDMSetNumber ==-10)iBodypart = CREATURE_PART_LEFT_BICEP;
if(iDMSetNumber ==11||iDMSetNumber ==-11)iBodypart = CREATURE_PART_LEFT_FOREARM;
if(iDMSetNumber ==12||iDMSetNumber ==-12)iBodypart = CREATURE_PART_LEFT_HAND;


//tattoo part
if(iDMSetNumber >=1 && iDMSetNumber < 10)iNumber=2;
if(iDMSetNumber <=-1 && iDMSetNumber > -10)iNumber=1;
//Bone part
if(iDMSetNumber >=10)iNumber=255;
if(iDMSetNumber <= -10)iNumber =1;
//string sNumber =IntToString(iNumber);
SetCreatureBodyPart(iBodypart,iNumber,oTarget);
//SendMessageToPC(oPCspeaker,sNumber);
}
