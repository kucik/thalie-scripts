//**///////////////////////////////////////////
//** Ku uni dlg starter
//**///////////////////////////////////////////

#include "ku_dlg_inc"

void main()
{
  object oPC = OBJECT_SELF;
  int iDlg = GetLocalInt(OBJECT_SELF,KU_DLG+"dialog");
//  SetCustomToken(6300,"Uni Dialog");
    ku_dlg_init(iDlg,oPC);

    SetLocalInt(oPC,KU_DLG+"dialog",iDlg);
    SetLocalInt(oPC,KU_DLG+"state",0);
    SetLocalInt(oPC,KU_DLG+"_allow_0",1);
    SetLocalInt(oPC,KU_DLG+"_allow_1",1);
    AssignCommand(oPC,ActionStartConversation(OBJECT_SELF,"ku_uni_dlg",TRUE,FALSE));
}
