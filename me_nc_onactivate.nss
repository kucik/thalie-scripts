 #include "me_pcneeds_inc"
#include "x2_inc_switches"

void main()
{

   object oItem = GetItemActivated();
   object oActivator = GetItemActivator();
   location lTarget = GetItemActivatedTargetLocation();
   object oTarget = GetItemActivatedTarget();
   string oCreatureTag = "";
   int oMaxGoldValue = 0;
   string oNewItemTag = "";
   string sTag = GetTag(oItem);
        // tag based scripting
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

    // jidlo , piti
    if (GetStringLeft(sTag,5) == "water" || GetStringLeft(sTag,4) == "food")
    {
       SpeakString(sTag);
       PC_ConsumeIt(oActivator,  oItem);
       return ;

    }

    // ukladaci runa
    if (GetTag(oItem) == "me_fishingpole")
    {
        ExecuteScript("me_nc_cfishfresh", oActivator);
        return;
    }
    // ukladaci runa
    if (GetTag(oItem) == "me_saverune")
    {
        ExecuteScript("me_saveplayer", oActivator);
        return;
    }
    if (GetTag(oItem) == "cnrSkinningKnife")
    {
        if (GetLocalInt(oItem, "ME_MASO") == 1)
        {
            SetLocalInt(oItem, "ME_MASO", 0);
            AssignCommand(oActivator,DelayCommand(1.0,SendMessageToPC(oActivator,"Neziskavat ze zvirat maso.")));
            SetName(oItem, GetName(oItem, TRUE) + "  *neziskavat maso*");
            //GetName(object oObject, int bOriginalName=FALSE)
        }
        else
        {
            SetLocalInt(oItem, "ME_MASO", 1);
            AssignCommand(oActivator,DelayCommand(1.0,SendMessageToPC(oActivator,"Ziskavat ze zvirat maso.")));
            SetName(oItem, GetName(oItem, TRUE));
        }
    }

  /* if(GetStringLeft(GetTag(oItem),4)=="SEED")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     if (GetTag(oItem) == "SEED_CORN")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_WHEAT")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_RICE")ExecuteScript("_plant_seed2",oActivator);
     if (GetTag(oItem) == "SEED_OATS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BARLEY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SORGHUM")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BAMBOO")ExecuteScript("_plant_seed2",oActivator);
     if (GetTag(oItem) == "SEED_SPEARMINT")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_PEPPERMINTY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GARLIC")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_ONION")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BLUEBERRY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BLACKBERRY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_RASPBERRY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_CRANBERRY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GRAPE1")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GRAPE2")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GRAPE3")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GOOSEBERRY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_JUNIPERBERRY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_MARIGOLD")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SNAPDRAGON")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_NASTURTIUM")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BLACKIRIS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_YELLOWIRIS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BLUEIRIS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_REDIRIS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_WHITEIRIS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_COTTON")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BLACKTULIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_YELLOWTULIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BLUETULIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_REDTULIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_WHITETULIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GINGER")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_MANDRAKE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SASSAFRASS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_TARRAGON")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SAGE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_LAVENDER")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_PERIWINKLE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_MISTLETOE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_ORIENTALPOPPY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_LARKSPUR")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_MAYAPPLE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_CHIVES")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_RADISH")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_LETTUCE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_TURNIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_PUMPKIN")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_WATERMELON")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SQUASH")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_ZUCCHINI")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_CARROT")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_POTATO")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SWEETPOTATO")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_PEANUTS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_INDIANCORN")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_POPCORN")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_CATNIP")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_GREENBEANS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_PEAS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BEETS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_OREGANO")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_BASIL")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_PARSLEY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_ARTICHOKE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_CELERY")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_OKRA")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_TOMATO")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_HOPS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_CABBAGE")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SWEETPEAS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_HOPS")ExecuteScript("_plant_seed",oActivator);
     if (GetTag(oItem) == "SEED_SUGARCANE")ExecuteScript("_plant_seed2",oActivator);








    }

   if (GetTag(oItem)=="FOOD_EAROFCORN")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="FLOWER_COTTON")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="ITEM_PUMPKIN")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="ITEM_WATERMELON")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="ITEM_SQUASH")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="ITEM_ZUCCHINI")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="ITEM_INDIANCORN")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }
   if (GetTag(oItem)=="ITEM_EAROFPOPCORN")
    {
     SetLocalString(oActivator,"sItemActivated",GetTag(oItem));
     ExecuteScript("_seed_seed",oActivator);
    }


   if (GetTag(oItem)=="ITEM_ORCHARDBLADE")
    {
     if (GetLocalInt(oActivator,"iTreeGatherMode") == 99)
       {
        SetLocalInt(oActivator,"iTreeGatherMode",0);
        FloatingTextStringOnCreature("Blade set to lumberjack mode..",oActivator,FALSE);
       }
      else
       {
        SetLocalInt(oActivator,"iTreeGatherMode",99);
        FloatingTextStringOnCreature("Blade set to orchard mode..",oActivator,FALSE);
       }
    }
   */


   if (GetTag(oItem)=="ITEM_HONEYCOMB")
    {
     if (GetLocalInt(oActivator,"iUseHoneyComb") == 0)
       {
        ExecuteScript("me_nc_uhoneycomb",oActivator);
        SetPlotFlag(oItem, 0);
        DestroyObject(oItem);
       }
      else
       {
        CreateItemOnObject("honeycomb",oActivator,1);
       }
    }

   /*
   if (GetStringLeft(GetTag(oItem),5)=="ACID_")
    {
     //Assign acid damage here
    }

   if (GetTag(oItem)=="NoDrop_SkillLogBook")
    {
     if (oTarget==OBJECT_INVALID)
       {
        ExecuteScript("_use_skillbook",oActivator);
       }
      else
       {
        //This section is for checking PC's, items, or craft station repairs.
        if (GetIsPC(oTarget)==TRUE)
          {
           if (oActivator==oTarget)
             {
              ExecuteScript("_use_skillbook",oActivator);
             }
            else
             {
              SetLocalObject(oActivator,"oTarget",oTarget);
              ExecuteScript("_use_skillbook2",oActivator);
             }
           //this section is to report on a PC's skills
          }
         else
          {
           SetLocalObject(oTarget,"oActivator",oActivator);
           ExecuteScript("_uoa_fix_station",oTarget);
           //This section is for repairing a broken craft station
          }
       }
     return;
    }

   if (GetTag(oItem)=="ITEM_FilletKnife")
    {
     //string sTemp5 = GetTag(oTarget);
     //SendMessageToPC(oActivator,sTemp5);
     if (GetIsObjectValid(oTarget)==TRUE)
       {
        SetLocalObject(oTarget,"oPC",oActivator);  //place a hook on the items o we know where the product goes
        ExecuteScript("_use_filletknife",oTarget);
       }
      else
       {
        SendMessageToPC(oActivator,"You cannot fillet that!");
       }
    }

   if (GetTag(oItem)=="ITEM_TINDERBOX")
    {
     ExecuteScript("_use_tinderbox",oActivator);
     return;
    }

   if (GetTag(oItem)=="papr_blank_silk")
    {
     ExecuteScript("_craft_map",oActivator);
     return;
    }
   if (GetTag(oItem)=="_UOA_PLAYER_MAP")
    {
     SetLocalObject(oActivator,"oMapUsed",oItem);
     ExecuteScript("_use_map",oActivator);
     return;
    }
   if (GetStringLeft(GetTag(oItem),21)=="_UOA_TMAP_UNDECODED_0")
    {
     SetLocalObject(oActivator,"oMapUsed",oItem);
     ExecuteScript("_use_map2",oActivator);
     return;
    }
   if (GetStringLeft(GetTag(oItem),10)=="_UOA_TMAP_")
    {
     SetLocalObject(oActivator,"oMapUsed",oItem);
     ExecuteScript("_use_map3",oActivator);
     return;
    }
    if (GetTag(oItem)=="Tool_ITEM_Excavation")
    {
     SetLocalObject(oActivator,"oMapUsed",oTarget);
     ExecuteScript("_use_map4",oActivator);
     return;
    }
   if (GetTag(oItem)=="_UOA_EMPTY_COMMODITY")
    {
     if (GetItemPossessor(oTarget)!=oActivator)
      {
       SendMessageToPC(oActivator,"You do not own this item!");
       return;
      }
     SetLocalObject(oActivator,"oActivateTarget",oTarget);
     ExecuteScript("_use_commodity",oActivator);
     return;
    }
   if (GetTag(oItem)=="_UOA_FULL_COMMODITY")
    {
     SetLocalObject(oActivator,"oDeed",oItem);
     AssignCommand(oActivator,ActionStartConversation(oActivator,"_uoa_com_deed",TRUE,FALSE));
     return;
    }

   if (GetStringLeft(GetTag(oItem),10)=="drink_cup_")
    {
     SetLocalString(oActivator,"sDrink",GetTag(oItem));
     ExecuteScript("_uoa_alcohol",oActivator);
     return;
    }

   if (GetStringLeft(GetTag(oItem),13)=="item_fullkeg_")
    {
     string sTemp = "drink_cup_"+GetStringRight(GetResRef(oItem),3);
     string sMessage = "You pour a ";
     object oTemp2 = CreateItemOnObject(sTemp,oActivator,1);
     sMessage=sMessage+GetName(oTemp2)+" from the "+GetName(oItem)+".";
     FloatingTextStringOnCreature(sMessage,oActivator,FALSE);
     return;
    }  */

}

