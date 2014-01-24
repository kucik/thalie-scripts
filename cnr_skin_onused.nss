/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_skin_onused
//
//  Desc:  The OnUsed handler for skinnable corpses.
//
//  Author: David Bobeck 18Feb03
//
/////////////////////////////////////////////////////////
//#include "cnr_config_inc"
//#include "cnr_language_inc"

void main()
{
  string sCorpseType = GetLocalString(OBJECT_SELF, "CnrCorpseType");
  location locCorpse = GetLocation(OBJECT_SELF);

  // prevent rapid-clicks from getting multiple skins!
  if (sCorpseType == "") return;

  object oUser = GetLastUsedBy();
  if (!GetIsPC(oUser)) return;

  // Player must have a skinning knife equipped
  int bHasKnife = FALSE;
  object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oUser);
  if (GetIsObjectValid(oItem))
  {
    if (GetTag(oItem) == "cnrSkinningKnife")
    {
      bHasKnife = TRUE;
    }
  }

  if (bHasKnife == FALSE)
  {
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser);
    if (GetIsObjectValid(oItem))
    {
      if (GetTag(oItem) == "cnrSkinningKnife")
      {
        bHasKnife = TRUE;
      }
    }
  }

  if (bHasKnife == FALSE)
  {
    FloatingTextStringOnCreature("Musis mit v ruce stahovaci nuz.", oUser, FALSE);
    return;
  }

  DeleteLocalString(OBJECT_SELF, "CnrCorpseType");

  // sCorpseType will have a format of cnraXXXX where XXXX is the animal name
  // or nw_XXXX or zep_XXXX

  string sAnimalName;
  string sPrefix = GetStringLowerCase(GetStringLeft(sCorpseType, 3));

  if( sPrefix == "nw_" )
    sAnimalName = GetStringRight(sCorpseType, GetStringLength(sCorpseType)-3); //edited by Jaara
  else
    sAnimalName = GetStringRight(sCorpseType, GetStringLength(sCorpseType)-4); //edited by Jaara

  sAnimalName = GetStringLowerCase(sAnimalName);

  if(sAnimalName == "direbadg")
    sAnimalName = "badger";
  else if(sAnimalName == "bearbrwn")
    sAnimalName = "brnbear";
  else if(sAnimalName == "beardire")
    sAnimalName = "db";
  else if(sAnimalName == "bearblck")
    sAnimalName = "blkbear";
  else if(sAnimalName == "diretiger")
    sAnimalName = "tiger";
  else if(sAnimalName == "bearkodiak")
    sAnimalName = "grizbear";


  string sSkinTag = "cnrSkin" + sAnimalName;

  int bCreateMeat = TRUE;
  if (sAnimalName == "Rat") bCreateMeat = FALSE;
  if (sAnimalName == "Bat") bCreateMeat = FALSE;
  if (sAnimalName == "Badger") bCreateMeat = FALSE;

  if (sSkinTag != "TAG_UNKNOWN")
  {
    object oSkin = CreateObject(OBJECT_TYPE_ITEM, sSkinTag, locCorpse);
    if (!GetIsObjectValid(oSkin))
        oSkin = CreateObject(OBJECT_TYPE_ITEM, "kuze", locCorpse);

    AssignCommand(oUser, ActionPickUpItem(oSkin));
    FloatingTextStringOnCreature("Ziskal jsi kuzi.", oUser, FALSE);

    if (bCreateMeat)
    {
      object oMeat;
      oMeat = CreateObject(OBJECT_TYPE_ITEM, "it_mmidmisc006", locCorpse);

      AssignCommand(oUser, ActionPickUpItem(oMeat));
      FloatingTextStringOnCreature("Ziskal jsi nejake maso.", oUser, FALSE);
    }

    object oBones = GetLocalObject(OBJECT_SELF, "CnrCorpseBones");
    if (GetIsObjectValid(oBones))
    {
      DeleteLocalObject(OBJECT_SELF, "CnrCorpseBones");
      DestroyObject(oBones);
    }
    DestroyObject(OBJECT_SELF);
  }
}


