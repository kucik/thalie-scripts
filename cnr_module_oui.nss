/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_module_oui
//
//  Desc:  This script must be run by the module's
//         OnUnaquireItem event handler.
//
//  Author: David Bobeck 22Feb03
//
/////////////////////////////////////////////////////////
#include "nwnx_funcs"
void main()
{
  object oLoser = GetModuleItemLostBy();
  object oItem = GetModuleItemLost();

  // Ochrana cen - kvuli obchodum
  int iGold = GetLocalInt(oItem,"GOLDPIECEVALUE");
  if(iGold > 0 && iGold != GetGoldPieceValue(oItem))
    SetGoldPieceValue(oItem,iGold);

//  ExecuteScript("cnr_cowchic_oui", oLoser);
  ExecuteScript("sy_m_onunacquire", oLoser);
}

