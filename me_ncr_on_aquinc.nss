void CreateAnItemTest(object oItem, object oTarget);

void CopyAnObject(object oItem, object oPCOwner);

void doWithAquiredItem(object oItem,object oPC,object oLast,object oMod )
{

  string sItemResRef = GetResRef(oItem);
  string sItemTag = GetTag(oItem);
  string sTempVar = "";

  //Begin code for fixing stackables in containers issue
  object oTemp;
  //SendMessageToPC(oPC,"*** OnAcquire : Item Tag Acquired: ***"+sItemTag+"***");
  //SendMessageToPC(oPC,"*** OnAcquire : Item ResRef      : ***"+sItemResRef+"***");

  //if (oItem==OBJECT_INVALID)
   //{
   // SendMessageToPC(oPC,"*** OnAcquire : INVALID OBJECT");
  // }

  if (GetIsPC(oPC)==FALSE) return; //This line may interfere with other systems.. if so then comment this out
  if (GetTag(oPC)=="_UOA_TREAS_CHEST") return; //Treasure Chest got it, not a PC
  if (GetIsObjectValid(oItem)==TRUE)
    {
     if (GetStringRight(sItemTag,6)=="_Store")
      {
       //SendMessageToPC(oPC,"*** OnAcquire : This is a store object.. returning object to container..");
       oLast = GetLocalObject(oPC,"oLastOpened");
       //SendMessageToPC(oPC,"*** OnAcquire : This is a store object.. returning object to container..");
       DelayCommand(1.0,CreateAnItemTest(oItem,oLast));
       DelayCommand(1.1,DestroyObject(oItem,2.0));
      }
    }
   else
    {
     //SendMessageToPC(oPC,"*** OnAcquire : Object is now Invalid");
    }
  //End code for fixing stackables in containers issue

  object oReturnTo = GetLocalObject(oItem,"ND_OWNER");

  if(GetIsObjectValid(oReturnTo))
   {
    // Its a nodrop item
    if(oPC == oReturnTo)DeleteLocalObject(oItem,"ND_OWNER");
    else
     {
      location loc = GetLocation(oReturnTo);
      object oNew = CopyObject(oItem,loc,oReturnTo);
      object oTest = GetLocalObject(oNew,"ND_OWNER");
      if(!GetIsObjectValid(oNew))
       {
        PrintString("NODROP ALERT: Player "+GetName(oReturnTo)+ " ("+
          GetPCPublicCDKey(oReturnTo) + ") has given " + GetResRef(oItem) +
          "to player " +GetName(oPC)+ " (" + GetPCPublicCDKey(oPC));
        SendMessageToAllDMs("CHEAT: " +GetName(oReturnTo)+ " has given " + GetName(oItem) +
          " (" + GetResRef(oItem)+ ") to player " + GetName(oPC));
       }
      else
       {
        DestroyObject(oItem);
        SendMessageToPC(oPC,"You cannot trade plot items");
        SendMessageToPC(oReturnTo,"You cannot trade plot items");
       }
     }
    return;
   }

}

void CopyAnObject(object oItem, object oPCOwner)
 {
  CopyObject(oItem,GetLocation(oPCOwner),oPCOwner,GetTag(oItem));
  string sMessage = "++++++++ "+GetTag(oItem)+ "is being copied to "+GetName(oPCOwner);
  SendMessageToPC(oPCOwner,sMessage);
  return;
 }

void CreateAnItemTest(object oItem, object oTarget)
 {
  if (oTarget==OBJECT_INVALID)
   {
    SendMessageToPC(GetFirstPC(),"Error in 'stackable' return function");
    return;
   }
  if (GetIsObjectValid(oItem)==FALSE) return;
  if (GetLocalInt(oItem,"iAmValid")==0)
   {
    DeleteLocalInt(oItem,"iAmValid");
    CopyObject(oItem,GetLocation(oTarget),oTarget,GetTag(oItem));
   }
  return;
 }



