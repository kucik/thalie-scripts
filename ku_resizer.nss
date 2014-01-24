/**
 * ku_resizer.nss
 *
 * Library for creatures resizing
 */

#include "nwnx_funcs"

const int RESIZER_INVISCR_S = 838;
const int RESIZER_INVISCR_L = 858;


// Check if NPC can be resized
// 0 - cannot
// >0 = tailmodel
int Resizer_CheckCanResize(object oNPC);

// Resize creature
// -9 = 10%
// 0 = 100%
// 10 = 200%
int Resizer_ResizeCreature(object oNPC, int iSize);

int Resizer_CheckCanResize(object oNPC) {
  if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oNPC))) {
    return FALSE;
  }

  if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oNPC))) {
    return FALSE;
  }

  int iTail = 0;
  int app = GetAppearanceType(oNPC);

//  SendMessageToPC(GetFirstPC(),"app = "+IntToString(app));

  if(app >= (RESIZER_INVISCR_S - 9) &&
     app <= (RESIZER_INVISCR_L + 10)) {
//    SendMessageToPC(GetFirstPC(),"tail "+IntToString(GetCreatureTailType(oNPC)));
    return GetCreatureTailType(oNPC);
  }

//  SendMessageToPC(GetFirstPC(),"tail is = "+IntToString(StringToInt(Get2DAString("apptotail", "TAIL", app))));
  return StringToInt(Get2DAString("apptotail", "TAIL", app));
}

int Resizer_GetInvisAppearance(object oNPC) {

  switch(GetCreatureSize(oNPC)) {
    case CREATURE_SIZE_HUGE:
    case CREATURE_SIZE_LARGE:
    case CREATURE_SIZE_MEDIUM:
      return RESIZER_INVISCR_L;
    case CREATURE_SIZE_SMALL:
    case CREATURE_SIZE_TINY:
      return RESIZER_INVISCR_S;
  }
  return 0;
}

int Resizer_ResizeCreature(object oNPC, int iSize) {
  int iTail = Resizer_CheckCanResize(oNPC);
  if(iTail < 1)
    return FALSE;

  if(iSize > 10)
    iSize = 10;

  if(iSize < -9)
    iSize = -9;

  int iCRSize = GetCreatureSize(oNPC);

//  SendMessageToPC(GetFirstPC(),"Settinf app = "+IntToString(Resizer_GetInvisAppearance(oNPC))+" tail "+IntToString(iTail));
  SetCreatureAppearanceType(oNPC, Resizer_GetInvisAppearance(oNPC) + iSize);
  SetCreatureTailType(iTail, oNPC);
  SetCreatureSize(oNPC,iCRSize);
  return TRUE;
}

