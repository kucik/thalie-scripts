#include "x2_inc_toollib"
/*Pokud je nDay 1 zmeni cas na den, pokud 0 tak na noc.*/
void dmwand_SwapDayNight(int nDay)
{
   int nCurrentHour;
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour = ((nDay == 1)?7:19);

   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
}

/*Prida nHours hodin.*/
void dmwand_AdvanceTime(int nHours)
{
   int nCurrentHour = GetTimeHour();
   int nCurrentMinute = GetTimeMinute();
   int nCurrentSecond = GetTimeSecond();
   int nCurrentMilli = GetTimeMillisecond();

   nCurrentHour += nHours;
   SetTime(nCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);
}

int GetAreaXAxis(object oArea)
{

    location locTile;
    int iX = 0;
    int iY = 0;
    vector vTile = Vector(0.0, 0.0, 0.0);

    for (iX = 0; iX < 32; ++iX)
    {
        vTile.x = IntToFloat(iX);
        locTile = Location(oArea, vTile, 0.0);
        int iRes = GetTileMainLight1Color(locTile);
        if (iRes > 32 || iRes < 0)
            return(iX);
    }

    return 32;
}

int GetAreaYAxis(object oArea)
{
    location locTile;
    int iX = 0;
    int iY = 0;
    vector  vTile = Vector(0.0, 0.0, 0.0);

    for (iY = 0; iY < 32; ++iY)
    {
        vTile.y = IntToFloat(iY);
        locTile = Location(oArea, vTile, 0.0);
        int iRes = GetTileMainLight1Color(locTile);
        if (iRes > 32 || iRes < 0)
            return(iY);
    }

    return 32;
}

void TilesetMagic(object oUser, int nEffect, int nType)
{
int iXAxis = GetAreaXAxis(GetArea(oUser));
int iYAxis = GetAreaYAxis(GetArea(oUser));
int nBase = GetLocalInt(GetModule(), "dmfi_tileset");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oUser);
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
float fDMSetNumber=IntToFloat(iDMSetNumber);
float fAdjust =  ((fDMSetNumber / 10));
string sType =FloatToString(fAdjust);

// nType definitions:
// 0 fill
// 1 flood
// 2 groundcover

// nBase definitions:
// 0 default
// 1 Sewer and City - raise the fill effect to -0.1


float ZEffectAdjust = 0.0;
float ZTypeAdjust = 0.1; //default is groundcover
float ZTileAdjust = 0.0;
float ZFinalAxis;


if (nEffect == X2_TL_GROUNDTILE_ICE &&  nType != 2)
    ZEffectAdjust = -1.0;  // lower the effect based on trial and error

if (nEffect == X2_TL_GROUNDTILE_SEWER_WATER &&  nType != 2)
    ZEffectAdjust = 0.8;




//now sep based on nType
if (nType == 0)  //fill
    ZTypeAdjust=-2.0;
//else if (nType ==1)
//    ZTypeAdjust = 2.0;
if(fAdjust<1.00)
{
fAdjust = 1.00;
}


ZFinalAxis = ZEffectAdjust + ZTypeAdjust + ZTileAdjust+fAdjust;
if (nEffect == X2_TL_GROUNDTILE_SEWER_WATER &&  nType == 1)
    ZFinalAxis = ZFinalAxis+0.2;
//special case for filling of water and sewer regions
if ((nBase==1) && (nType==0))
    ZFinalAxis = -0.1;

 if (nType == 2)
  ZFinalAxis= 0.01;




// SendMessageToPC(oUser,sType);
/*if(nType == 0)
{
//int iTileC = GetLocalInt(oCheck, "TileC");
//int iTileR = GetLocalInt(oCheck, "TileR");


object oPCspeaker =GetPCSpeaker();
location Ltarget = GetLocalLocation(oPCspeaker, "dmfi_univ_location");
vector vLocation= GetPositionFromLocation(Ltarget);
int iYloc = FloatToInt(vLocation.y) / 10;
string sYloc =IntToString(iYloc);
int iXloc = FloatToInt(vLocation.x) / 10;
string sXloc =IntToString(iXloc);
iXAxis=iYloc;
iYAxis=iXloc;
SendMessageToPC(oPCspeaker,sYloc+" "+sXloc);
TLResetAreaGroundTiles(GetArea(oUser), iXAxis, iYAxis);
TLChangeAreaGroundTiles(GetArea(oUser), nEffect , iXAxis, iYAxis, ZFinalAxis);
}
*/

TLResetAreaGroundTiles(GetArea(oUser), iXAxis, iYAxis);
TLChangeAreaGroundTiles(GetArea(oUser), nEffect , iXAxis, iYAxis, ZFinalAxis);
}

void FnFEffect(object oUser, int VFX, location lEffect, float fDelay)
{
if (fDelay>2.0) FloatingTextStringOnCreature("Delay effect created", oUser, FALSE);
DelayCommand( fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX),lEffect));
}

//An FX Wand function
void FXWand_Earthquake_extend(object oDM)
{
   // Earthquake Effect by Jhenne, 06/29/02
   // declare variables used for targetting and commands.
   location lDMLoc = GetLocation ( oDM);

   // tell the DM object to shake the screen
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lDMLoc));
   AssignCommand ( oDM, DelayCommand( 2.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 3.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_SHAKE), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 4.5, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   AssignCommand ( oDM, DelayCommand( 5.8, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SCREEN_BUMP), lDMLoc)));
   // tell the DM object to play an earthquake sound
   AssignCommand ( oDM, PlaySound ("as_cv_boomdist1"));
   AssignCommand ( oDM, DelayCommand ( 2.0, PlaySound ("as_wt_thunderds3")));
   AssignCommand ( oDM, DelayCommand ( 4.0, PlaySound ("as_cv_boomdist1")));
   // create a dust plume at the DM and clicking location
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
   {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lDustLoc = Location(oTargetArea, vNewVector, 0.0);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lDustLoc, FALSE);
      DelayCommand ( 4.0, DestroyObject ( oDust));
   }
}

//An FX Wand function
void FXWand_Lightning(object oDM, location lDMLoc)
{
   // Lightning Strike by Jhenne. 06/29/02
   // tell the DM object to create a Lightning visual effect at targetted location
   AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_M), lDMLoc));
   // tell the DM object to play a thunderclap
   AssignCommand ( oDM, PlaySound ("as_wt_thundercl3"));
   // create a scorch mark where the lightning hit
   object oScorch = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_weathmark", lDMLoc, FALSE);
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 5; nCount++)
   {
      nXPos = Random(10) - 5;
      nYPos = Random(10) - 5;

      vector vNewVector = GetPositionFromLocation(lDMLoc);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lNewLoc = Location(oTargetArea, vNewVector, 0.0);
      AssignCommand( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_LIGHTNING_S), lNewLoc));
   }
   DelayCommand ( 20.0, DestroyObject ( oScorch));
}

//An FX Wand function
void FXWand_Firestorm(object oDM)
{

   // FireStorm Effect
       location lDMLoc = GetLocation (oDM);


   // tell the DM object to rain fire and destruction
   AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_METEOR_SWARM), lDMLoc));
   AssignCommand ( oDM, DelayCommand (1.0, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_FNF_SCREEN_SHAKE), lDMLoc)));

   // create some fires
   object oTargetArea = GetArea(oDM);
   int nXPos, nYPos, nCount;
   for(nCount = 0; nCount < 15; nCount++)
  {
      nXPos = Random(30) - 15;
      nYPos = Random(30) - 15;

      vector vNewVector = GetPosition(oDM);
      vNewVector.x += nXPos;
      vNewVector.y += nYPos;

      location lFireLoc = Location(oTargetArea, vNewVector, 0.0);
      object oFire = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_flamelarge", lFireLoc, FALSE);
      object oDust = CreateObject ( OBJECT_TYPE_PLACEABLE, "plc_dustplume", lFireLoc, FALSE);
      DelayCommand ( 10.0, DestroyObject ( oFire));
      DelayCommand ( 14.0, DestroyObject ( oDust));
   }

}

void TurnOnMusic(object oArea,int iSet)
{
    MusicBackgroundStop(oArea);
    MusicBackgroundChangeDay(oArea, iSet);
    MusicBackgroundChangeNight(oArea, iSet);
    MusicBackgroundPlay(oArea);
}

void RotateMe(object oTarget, int Amount, object oUser)
{
            location lLocation = GetLocation (oTarget);
            if (GetObjectType(oTarget) != OBJECT_TYPE_PLACEABLE)
                {
                oTarget = GetNearestObject(OBJECT_TYPE_PLACEABLE, oUser);
                FloatingTextStringOnCreature("Target was not a placable, used placeable closest to your avitar", oUser);
                }
            if (Amount == -2)
                {
                AssignCommand(oTarget, SetFacing(90.0));
                return;
                }
            if (Amount == -1)
                {
                AssignCommand(oTarget, SetFacing(0.0));
                return;
                }
            if (GetIsObjectValid(oTarget))
             //   SendMessageToPC(oUser,"debug");
                AssignCommand(oTarget, SetFacing(GetFacing(oTarget)+Amount));
}
void TakeStuff(int Level, object oTarget, object oUser)
   {
   object oItem = GetFirstItemInInventory(oTarget);
   while(GetIsObjectValid(oItem))
   {
      DestroyObject(oItem);
      oItem = GetNextItemInInventory(oTarget);
   }

    if (Level == 1)
        {
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_ARROWS,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_BELT,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOLTS,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_BOOTS,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_BULLETS,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_CLOAK,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_HEAD,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_NECK,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget));
         DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oTarget));
        }
FloatingTextStringOnCreature("DM Intervention:  Inventory Destroyed by DM", oTarget);
}

void IdenStuff(object oTarget)
{
   object oItem = GetFirstItemInInventory(oTarget);
   while(GetIsObjectValid(oItem))
   {
      if (GetIdentified(oItem)==FALSE)
            SetIdentified(oItem, TRUE);

      oItem = GetNextItemInInventory(oTarget);
   }
}

int DMFI_GetNetWorth(object oTarget)
{
int n;
object oItem = GetFirstItemInInventory(oTarget);
   while(GetIsObjectValid(oItem))
   {
      n= n + GetGoldPieceValue(oItem);
      oItem = GetNextItemInInventory(oTarget);
   }


         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_ARROWS, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_BELT, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_BOOTS, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_BULLETS, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CLOAK, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_HEAD, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_NECK, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget));
         n = n + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oTarget));
return n;
}

void DMFI_untoad(object oTarget, object oUser)
{
if (GetLocalInt(oTarget, "toaded")==1)
    {
    effect eMyEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eMyEffect))
             {
             if(GetEffectType(eMyEffect) == EFFECT_TYPE_POLYMORPH ||
                GetEffectType(eMyEffect) == EFFECT_TYPE_PARALYZE)
                                 RemoveEffect(oTarget, eMyEffect);

             eMyEffect = GetNextEffect(oTarget);
             }
     }
else
               {
               FloatingTextStringOnCreature("Dude, he is no toad!", oUser);
               }
}

void DMFI_toad(object oTarget, object oUser)
{
              effect ePenguin = EffectPolymorph(POLYMORPH_TYPE_PENGUIN);
              effect eParalyze = EffectParalyze();
              SendMessageToPC(oUser, "Penguin?  Don't you mean toad?");
              AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenguin, oTarget));
              AssignCommand(oTarget, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oTarget));
              SetLocalInt(oTarget, "toaded", 1);
}
