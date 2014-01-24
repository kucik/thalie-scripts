object oPCspeaker =GetPCSpeaker();
object oTarget = GetLocalObject(oPCspeaker, "dmfi_univ_target");
object oCheck = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPCspeaker);
int iItemproperty = GetLocalInt(oCheck,"Itemproperty");
int iDMSetNumber =GetLocalInt(oCheck,"DMSetNumber");
int iDMCraftnumber =GetLocalInt(oCheck,"DMCNumber");
int iDMCraftnumber2 =GetLocalInt(oCheck,"DMCNumber2");
string sDMSetNumber = IntToString(iDMSetNumber);
string sDMCraftnumber = IntToString(iDMCraftnumber);
string sDMCraftnumber2 = IntToString(iDMCraftnumber2);



void main()
{
string sProp;
string sDes;


switch (iItemproperty)
{
case -80:sProp = " Remove Value Increase ( CEP property )";
sDes = " DMI will be used for amount, from 1-50";break;

case -79:sProp = " Remove Value Decrease";
sDes = " DMI will be used for amount, from 1-50 ( CEP property )";break;

case -78:sProp = " Remove Weight Reduction";
sDes = " DMI will be used for the weight reduction percentage,  1 = 80% / 2 = 60% / 3 = 40% / 4 = 20% / 5 = 10%";break;

case -77:sProp = " Remove Weight Increase";
sDes = " DMI will be used for the weight increase, 0 = 5 lbs / 1 = 10 lbs / 2 = 15 lbs / 3 = 30 lbs / 4 = 50 lbs / 5 = 100 lbs";break;

case -76:sProp = " Remove Visual Effect";
sDes =" DMI will be used for the visual effect added, 0 = Acid / 1 = Cold / 2 = Electrical / 3 = Fire / 4 = Sonic "+
"/ 5 = Holy / 6 = Evil";break;

case -75:sProp = " Remove Vampiric Regeneration";
sDes =  " DMI will be used for the amount, from 1-20";break;


case -74:sProp = " Remove Unlimited Ammo";
sDes = " DMI will used, If you leave the parameter field blank it will be just a normal bolt, arrow, or bullet. "+
"1 = Basic / 2 = 1d6 fire / 3 = 1d6 cold / 4 = 1d6 lightning / 11 = +1 / 12 = +2 / 13 = +3 / 14 = +4 / 15 = +5";break;


case -73:sProp = " Remove Turn Resistance";
sDes = " DMI will be the amount of bonus to turn resistance, from 1-50";break;


case -72:sProp = " Remove TrueSeeing";
sDes = " No numbers needed, will add this property to the item.";break;

case -71:sProp = " Remove Trap";
sDes = " DMI Will be the trap strength. 0 = Minor / 1 = Average / 2 = Strong / 3 = Deadly. "+
"First Craft int. will be the type. 1 = Spike / 2 = Holy / 3 = Tangle / 4 = Blob of acid / 5 = Fire "+
"/ 6 = Electrical / 7 = Gas / 8 = Frost / 9 = Acid splash / 10 = Sonic / 11 = Negative";break;


case -70:sProp = " Remove Thieves Tools";
sDes = " DMI will be the amount of bonus to the thieves tools, from 1-12";break;

case -69:sProp = " Remove Spell Immunity Specific";
sDes = " DMI is used, Use the list below";break;

case -68:sProp = " Remove Spell Immunity School";
sDes = " DMI will be used for the school. 0 = Abjuration / 2 = Conjuration / 3 = Enchantment / 4 = Evocation "+
"/ 5 = Illusion / 6 = Necromancy / 7 = Transmutation";break;


case -67:sProp = " Remove Special Walk";
sDes = " DMI will be used for the special walk, if no number is used then zombie walk is used";break;

case -66:sProp = " Remove Skill Bonus";
sDes = " DMI will be the skill. "+
"ANIMAL EMPATHY   = 0 "+
"CONCENTRATION    = 1 "+
"DISABLE TRAP     = 2 "+
"DISCIPLINE       = 3 "+
"HEAL             = 4 "+
"HIDE             = 5 "+
"LISTEN           = 6 "+
"LORE             = 7 "+
"MOVE SILENTLY    = 8 "+
"OPEN LOCK        = 9 "+
"PARRY            = 10 "+
"PERFORM          = 11 "+
"PERSUADE         = 12 "+
"PICK POCKET      = 13 "+
"SEARCH           = 14 "+
"SET TRAP         = 15 "+
"SPELLCRAFT       = 16 "+
"SPOT             = 17 "+
"TAUNT            = 18 "+
"USE MAGIC DEVICE = 19 "+
"APPRAISE         = 20 "+
"TUMBLE           = 21 "+
"CRAFT TRAP       = 22 "+
"BLUFF            = 23 "+
"INTIMIDATE       = 24 "+
"CRAFT ARMOR      = 25 "+
"CRAFT WEAPON     = 26 "+
"RIDE             = 27 "+
"ALL SKILLS       = 255 "+
"First Craft Int. will be the amount, from 1-50";break;

case -65:sProp =  " Remove Regeneration";
sDes = " DMI will be the amount of Regeneration, from 1-20";break;


case -64:sProp = " Remove Reduced Saving Throw Vs Specific type";
sDes =  " DMI will be the type of Saving throw bonus type, 1 = Acid / 3 = Cold / 4 = Death / 5 = Disease "+
"/ 6 = Divine / 7 = Electrical / 8 = Fear / 9 = Fire / 11 = Mind Affecting / 12 = Negative / 13 = Poison "+
"/ 14 = Positive / 15 = Sonic. First craft int. will be the amount, from 1-20";break;


case -63:sProp =" Remove Reduced Saving Throw";
sDes = " DMI will be the type of Saving Throw. 1 = Fortitude / 2 = Will / 3 = Reflex "+
"First craft int. will be the amount, from 1-20";break;


case -62:sProp = " Remove Quality";
sDes =  " The quality property will only affect the cost of the item if you modify the cost in the iprp_qualcost.2da."+
"DMI will be used for the setting, 0 = Unknown / 1 = Destroyed / 2 = Ruined / 3 = Very Poor /  4 = Poor / 5 = Below Average "+
"/ 6 = Average / 7 = Above average / 8 = Good / 9 = Very Good / 10 = Excellent / 11 = Masterworked / 12 = GodLike / 13 = Raw / 14 = Cut / 15 = Polished";break;


case -61:sProp = " Remove On Monster Hit Properties";
sDes = " Refer to list below";break;

case -60:sProp = " Remove On Hit Properties";
sDes = " Refer to list below";break;

case -59:sProp = " Remove On Hit Cast Spell";
sDes =  " Creates an item property that (when applied to a weapon item) causes a spell to be cast"+
" when a successful strike is made, or (when applied to armor) is struck by an opponent."+
" DMI is used for the spell (refer to on hit spell list). First craft int. will be used for the level, from 1 - 40";break;


case -58:sProp = " Remove No Damage";
sDes = " No need for any numbers, this will mean the weapon will do no damage in combat.";break;


case -57:sProp =" Remove Monster Damage";
sDes = " DMI will be use to for the amount of monster damage used on the item (only monster items, claws, bites, gore, slam) "+
"1d2 = 1 "+
"1d3 = 2 "+
"1d4 = 3 "+
"2d4 = 4 "+
"3d4 = 5 "+
"4d4 = 6 "+
"5d4 = 7 "+
"1d6 = 8 "+
"2d6 = 9 "+
"3d6 = 10 "+
"4d6 = 11 "+
"5d6 = 12 "+
"6d6 = 13 "+
"7d6 = 14 "+
"8d6 = 15 "+
"9d6 = 16 "+
"10d6 = 17 "+
"1d8 = 18 "+
"2d8 = 19 "+
"3d8 = 20 "+
"4d8 = 21 "+
"5d8 = 22 "+
"6d8 = 23 "+
"7d8 = 24 "+
"8d8 = 25 "+
"9d8 = 26 "+
"10d8 = 27 "+
"1d10 = 28 "+
"2d10 = 29 "+
"3d10 = 30 "+
"4d10 = 31 "+
"5d10 = 32 "+
"6d10 = 33 "+
"7d10 = 34 "+
"8d10 = 35 "+
"9d10 = 36 "+
"10d10 = 37 "+
"1d12 = 38 "+
"2d12 = 39 "+
"3d12 = 40 "+
"4d12 = 41 "+
"5d12 = 42 "+
"6d12 = 43 "+
"7d12 = 44 "+
"8d12 = 45 "+
"9d12 = 46 "+
"10d12 = 47 "+
"1d20 = 48 "+
"2d20 = 49 "+
"3d20 = 50 "+
"4d20 = 51 "+
"5d20 = 52 "+
"6d20= 53 "+
"7d20= 54 "+
"8d20= 55 "+
"9d20= 56 "+
"10d20 = 57";break;

case -56:sProp = " Remove Max Range Strength Mod";
sDes = " DMI is used for the (mighty property on range weapon, STR. bonus allowed). From 1-20";break;


case -55:sProp = " Remove Material";
sDes =" Use DMI, Refer to material list below.";break;


case -54:sProp = " Remove Massive Critical";
sDes = " DMI is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;


case -53:sProp = " Remove Limit Use By Specific Alignment";
sDes =  " DMI will be the alignment(s) that can use the item. 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE ";break;


case -52:sProp = " Remove Limit Use By Race";
sDes = " Dmi will be used for the race(s) who are allowed to use this item. "+
"0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin";break;


case -51:sProp = " Remove Limit Use By Class";
sDes = " DMI will be the class(es) that can use the item. "+
"0 = Barbarian "+
"1 = Bard "+
"2 = Cleric "+
"3 = Druid "+
"4 = Fighter "+
"5 = Monk "+
"6 = Paladin "+
"7 = Ranger "+
"8 = Rogue "+
"9 = Sorcerer "+
"10 = Wizard "+
"11 = Aberration "+
"12 = Animal "+
"13 = Construct "+
"14 = Humanoid "+
"15 = Monstrous "+
"16 = Elemental "+
"17 = Fey "+
"18 = Dragon "+
"19 = Undead "+
"20 = Commoner "+
"21 = Beast "+
"22 = Giant "+
"23 = MagicBeast "+
"24 = Outsider "+
"25 = Shapechanger "+
"26 = Vermin "+
"27 = Shadowdancer "+
"28 = Harper "+
"29 = Arcane Archer "+
"30 = Assassin "+
"31 = Blackguard "+
"32 = Champion Torm "+
"33 = WeaponMaster "+
"34 = Pale Master "+
"35 = Shifter "+
"36 = Dwarven Defender "+
"37 = Dragon Disciple "+
"38 = Ooze "+
"41 = Purple Dragon Knight ";break;


case -50:sProp = " Remove Limit Use By Alignment Group";
sDes = " DMI will be the alignment group(s) that can use the item. 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil";break;

case -49:sProp = " Remove Light";
sDes = " DMI will be used for the brightness. 1 = Dim / 2 = Low / 3 = Normal / 4 = Bright. "+
"First craft int. will be used for the color.  0 = Blue / 1 = Yellow / 2 = Purple / 3 = Red "+
"/ 4 = Green / 5 = Orange / 6 = White";break;

case -48:sProp = " Remove Keen";
sDes = " No numbers needed, will add this property to the item."+
"This means a critical threat range of 19-20 on a weapon will be increased to 17-20 etc.";break;


case -47:sProp = " Remove Improved Evasion";
sDes = " No numbers needed, will add this property to the item.";break;


case -46:sProp = " Remove Immunity To Spell Level";
sDes = " DMI will be used for the the level of which that and below the user will be immune. "+
"From 1-9";


case -45:sProp = " Remove Immunity Misc.";
sDes =  " DMI will be used for the immunity, 0 = Backstab / 1 = Level Drain  /"+
" 2 = Mind spells / 3 = Poison / 4 = Disease / 5 = Fear / 6 = Knockdown / 7 = Paralysis"+
" / 8 = Critical Hits / 9 = Death Magic";break;


case -44:sProp = " Remove Holy Avenger";
sDes = " No numbers needed, will add this property to the item.";break;


case -43:sProp = " Remove Healers Kit";
sDes = " DMI used for the level of the healing kit, from 1-12";break;

case -42:sProp = " Remove Haste";
sDes = " No numbers needed, will add this property to the item.";break;

case -41:sProp = " Remove Free Action";
sDes = " No numbers needed, will add this property to the item.";break;


case -40:sProp = " Remove Extra Range Damage Type";
sDes =  " DMI will be used for the type. 0 = Bludgeoning / 1 = Piercing / 3 = Slashing."+
" Can only be used on ranged weapons";break;

case -39:sProp = " Remove Extra Melee Damage Type";
sDes =  "DMI will be used for the type. 0 = Bludgeoning / 1 = Piercing / 3 = Slashing."+
" Can only be used on Melee weapons";break;

case -38:sProp =" Remove Enhancement Penalty";
sDes = " DMI will be the amount, from 1-5 for the penalty";break;

case -37:sProp =" Remove Enhancement Bonus Vs Specific Alignment";
sDes = " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE "+
"First Craft Int. will be the amount, 1-20";break;


case -36:sProp = " Remove Enhancement Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin"+
" First Craft int. will be the amount from 1-20.";break;


case -35:sProp = " Remove Enhancement Bonus Vs Alignment group";
sDes = " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil "+
"First craft int. will be the amount, from 1-20";break;


case -34:sProp = " Remove Enhancement Bonus";
sDes = " DMI will be the amount, from 1-20";break;


case -33:sProp =" Remove Decrease Skill";
sDes =" DMI will be the skill. "+
"ANIMAL EMPATHY   = 0 "+
"CONCENTRATION    = 1 "+
"DISABLE TRAP     = 2 "+
"DISCIPLINE       = 3 "+
"HEAL             = 4 "+
"HIDE             = 5 "+
"LISTEN           = 6 "+
"LORE             = 7 "+
"MOVE SILENTLY    = 8 "+
"OPEN LOCK        = 9 "+
"PARRY            = 10 "+
"PERFORM          = 11 "+
"PERSUADE         = 12 "+
"PICK POCKET      = 13 "+
"SEARCH           = 14 "+
"SET TRAP         = 15 "+
"SPELLCRAFT       = 16 "+
"SPOT             = 17 "+
"TAUNT            = 18 "+
"USE MAGIC DEVICE = 19 "+
"APPRAISE         = 20 "+
"TUMBLE           = 21 "+
"CRAFT TRAP       = 22 "+
"BLUFF            = 23 "+
"INTIMIDATE       = 24 "+
"CRAFT ARMOR      = 25 "+
"CRAFT WEAPON     = 26 "+
"RIDE             = 27 "+
"ALL SKILLS       = 255 "+
"First Craft Int. will be the amount, from 1-10";break;


case -32:sProp =" Remove Decrease AC";
sDes =" DMI will be the armor type that is decreased. 0 = Dodge / 1 = Natural / 3 = Armor "+
"/ 4 = Deflection. First Craft int. will be the amount, from 1-5.";break;


case -31:sProp = " Remove Decrease Ability";
sDes = " DMI will be the Ability used 0 = STR / 1 =  DEX / "+
"2 = CON / 3 = INT / 4 = WIS / 5 = CHA / First Craft Int. will be the amount, from 1-10";break;


case -30:sProp = " Remove Darkvision";
sDes = " Darkvision will be added to the item, no numbers needed";break;

case -29:sProp = " Remove Damage Vulnerability";
sDes = " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft int. will be use for the %. 1 = 5% / 2 = 10% / 3 = 25% / 4 = 50% / 5 = 75% / 6 = 90% / 7 = 100%"; break;


case -28:sProp = " Remove Damage Resistance";
sDes = " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft Int. will the amount resisted each round. 1 = 5 / 2 = 10 / 3 = 15 / 4 = 20 / 5 = 25 "+
"/ 6 = 30 / 7 = 35 / 8 = 40 / 9 = 45 / 10 = 50";break;


case -27:sProp = " Remove Damage Reduction";
sDes =  " DMI will be the enhancment level, from 1-20. 0 = 1 / 1 = 2 / 2 = 3 etc.. "+
"First craft int. will be the amount of soak damage. 1 = 5 / 2 = 10 / 3 = 15 / 4 = 20 / 5 = 25 "+
"/ 6 = 30 / 7 = 35 / 8 = 40 / 9 = 45 / 10 = 50";break;


case -26:sProp = " Remove Damage Penalty";
sDes =  " DMI will be the amount, from 1-5 for the penalty";break;


case -25:sProp = " Remove Damage Immunity";
sDes = " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft int. will be use for the % of immunity. 1 = 5% / 2 = 10% / 3 = 25% / 4 = 50% / 5 = 75% / 6 = 90% / 7 = 100%"; break;


case -24:sProp = " Remove Damage Bonus Vs Specific Alignment";
sDes =  " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE "+
"First Craft Int. is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"Second Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;


case -23:sProp = " Remove Damage Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin "+
"First Craft Int. is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"Second Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;


case -22:sProp =  " Remove Damage Bonus Vs Alignment Group";
sDes =  " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil "+
"First Craft Int. is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"Second Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;


case -21:sProp = " Remove Damage Bonus";
sDes =  " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;


case -20:sProp = " Remove Container Reduced Weight";
sDes = " Used for containers to reduce the weight of the objects inside them. "+
"DMI is used to set the percentage that is reduced, 100% is weightless. 1 = 20% / 2 = 40% / 3 = 60% / 4 = 80% / 5 = 100%";break;


case -19:sProp = " Remove Cast Spell";
sDes = " Refer to the Cast spell list, use dmi is used for the spell and first craft int. for the number of uses "+
"SINGLE_USE = 1 / "+
"5 CHARGES PER USE = 2 / "+
"4 CHARGES PER USE = 3 / "+
"3 CHARGES PER USE = 4 / "+
"2 CHARGES PER USE = 5 / "+
"1 CHARGE PER_USE = 6 / "+
"0 CHARGES PER USE = 7 / "+
"1 USE PER DAY = 8 / "+
"2 USES PER DAY = 9 / "+
"3 USES PER DAY = 10 / "+
"4 USES PER DAY = 11 / "+
"5 USES PER DAY = 12 / "+
"UNLIMITED USE = 13";break;

case -18:sProp = " Remove Bonus Spell Resistance";
sDes =  " DMI will be the ammount 0 = +10 / 1 = +12 / 2 = +14 etc... from +10-32 in increments of 2.";break;


case -17:sProp = " Remove Bonus Saving Throw Vs Specific type";
sDes = " DMI will be the type of Saving throw bonus type, 1 = Acid / 3 = Cold / 4 = Death / 5 = Disease "+
"/ 6 = Divine / 7 = Electrical / 8 = Fear / 9 = Fire / 11 = Mind Affecting / 12 = Negative / 13 = Poison "+
"/ 14 = Positive / 15 = Sonic. First craft int. will be the amount, from 1-20";break;


case -16:sProp = " Remove Bonus Saving Throw";
sDes = " DMI will be the type of Saving Throw. 1 = Fortitude / 2 = Will / 3 = Reflex "+
"First craft int. will be the amount, from 1-20";break;


case -15:sProp =" Remove Bonus Level Spell";
sDes = " DMI will be the spell class / must be spell casting class. 1 = Bard / 2 = Cleric / 3 = Druid / 6 = Paladin / 7 = Ranger / 9 = Sorcerer / 10 = Wizard "+
" First craft int. will be the level, from 0-9";break;

case -14:sProp = " Remove Bonus Feat";
sDes = " DMI will be the feat given, refer to bonus feat list";break;


case -13:sProp = " Remove Attack Penalty";
sDes = " DMI will be the amount, from 1-5 for the penalty";break;


case -12:sProp = " Remove Attack Bonus Vs Specific Alignment";
sDes = " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE"+
" First Craft int. will be the amount from 1-20.";break;

case -11:sProp = " Remove Attack Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin"+
" First Craft int. will be the amount from 1-20.";break;

case -10:sProp =" Remove Attack Bonus Vs Alignment Group";
sDes = " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil"+
" First Craft int. will be the amount from 1-20.";break;


case -9:sProp = " Remove Attack Bonus";
sDes =  " DMI will be the amount, from 1-20";break;


case -8:sProp = " Remove Arcane Spell Failure";
sDes = " DMI will be the amount "+
"MINUS 50% = 0"+
" MINUS 45% = 1"+
" MINUS 40% = 2"+
" MINUS 35% = 3"+
" MINUS 30% = 4"+
" MINUS 25% = 5"+
" MINUS 20% = 6"+
" MINUS 15% = 7"+
" MINUS 10% = 8"+
" MINUS 5% = 9 "+
" PLUS 5% = 10"+
" PLUS 10% = 11"+
" PLUS 15% = 12"+
" PLUS 20% = 13"+
" PLUS 25% = 14"+
" PLUS 30% = 15"+
" PLUS 35% = 16"+
" PLUS 40% = 17"+
" PLUS 45% = 18"+
" PLUS 50% = 19";break;

case -7:sProp =" Remove Additional";
sDes =  " DMI will be used for the additional property. 0 = Unknown / 1 = Cursed";break;

case -6:sProp = " Remove AC Bonus Vs Specific Alignment";
sDes = " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE"+
" First Craft int. will be the amount from 1-20."+
" The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;


case -5:sProp = " Remove AC Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin"+
" First Craft int. will be the amount from 1-20."+
" The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;


case -4:sProp = " Remove AC Bonus Vs Damage Type";
sDes =" DMI will be the damage type 0 = Bludgeoning / 1 = Piercing / 2 = Slashing. First Craft int. will be the amount, from 1-20 "+
"The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case -3:sProp = " Remove AC Bonus Vs Alignment Group";
sDes = " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil"+
" First Craft int. will be the amount from 1-20."+
" The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;


case -2:sProp = " Remove AC Bonus";
sDes = " DMI will be the amount, from 1-20. "+
"The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case -1:sProp = " Remove Ability Bonus";
sDes = " DMI will be the Ability used 0 = STR / 1 =  DEX / "+
"2 = CON / 3 = INT / 4 = WIS / 5 = CHA / First Craft Int. will be the amount, from 1-12";break;

case 0:sProp = " Remove All item Properties";
sDes = " Will take all item properties off the target";break;

case 1:sProp = " Ability Bonus";
sDes = " DMI will be the Ability used 0 = STR / 1 =  DEX / "+
"2 = CON / 3 = INT / 4 = WIS / 5 = CHA / First Craft Int. will be the amount, from 1-12";break;

case 2:sProp = " AC Bonus";
sDes = " DMI will be the amount, from 1-20. "+
"The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case 3:sProp = " AC Bonus Vs Alignment Group";
sDes = " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil"+
" First Craft int. will be the amount from 1-20."+
" The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case 4:sProp = " AC Bonus Vs Damage Type";
sDes =" DMI will be the damage type 0 = Bludgeoning / 1 = Piercing / 2 = Slashing. First Craft int. will be the amount, from 1-20 "+
"The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case 5:sProp = " AC Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin"+
" First Craft int. will be the amount from 1-20."+
" The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case 6:sProp = " AC Bonus Vs Specific Alignment";
sDes = " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE"+
" First Craft int. will be the amount from 1-20."+
" The modifier type depends on the item it is being applied to."+
" Items that gain a Deflection bonus: Creature Skins, staves, rings, melee weapons, helmets, cloaks, belts, gloves, and ranged weapons that use ammunition."+
" Items that gain an Armor bonus: Armors and bracers. Items that gain a Natural Armor bonus: Amulets. Items that gain a Shield bonus: Shields. Items that gain a Dodge bonus: Boots.";break;

case 7:sProp =" Additional";
sDes =  " DMI will be used for the additional property. 0 = Unknown / 1 = Cursed";break;

case 8:sProp = " Arcane Spell Failure";
sDes = " DMI will be the amount "+
"MINUS 50% = 0"+
" MINUS 45% = 1"+
" MINUS 40% = 2"+
" MINUS 35% = 3"+
" MINUS 30% = 4"+
" MINUS 25% = 5"+
" MINUS 20% = 6"+
" MINUS 15% = 7"+
" MINUS 10% = 8"+
" MINUS 5% = 9 "+
" PLUS 5% = 10"+
" PLUS 10% = 11"+
" PLUS 15% = 12"+
" PLUS 20% = 13"+
" PLUS 25% = 14"+
" PLUS 30% = 15"+
" PLUS 35% = 16"+
" PLUS 40% = 17"+
" PLUS 45% = 18"+
" PLUS 50% = 19";break;

case 9:sProp = " Attack Bonus";
sDes =  " DMI will be the amount, from 1-20";break;

case 10:sProp =" Attack Bonus Vs Alignment Group";
sDes = " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil"+
" First Craft int. will be the amount from 1-20.";break;

case 11:sProp = " Attack Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin"+
" First Craft int. will be the amount from 1-20.";break;

case 12:sProp = " Attack Bonus Vs Specific Alignment";
sDes = " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE"+
" First Craft int. will be the amount from 1-20.";break;

case 13:sProp = " Attack Penalty";
sDes = " DMI will be the amount, from 1-5 for the penalty";break;

case 14:sProp = " Bonus Feat";
sDes = " DMI will be the feat given, refer to bonus feat list";break;

case 15:sProp =" Bonus Level Spell";
sDes = " DMI will be the spell class / must be spell casting class. 1 = Bard / 2 = Cleric / 3 = Druid / 6 = Paladin / 7 = Ranger / 9 = Sorcerer / 10 = Wizard "+
" First craft int. will be the level, from 0-9";break;

case 16:sProp = " Bonus Saving Throw";
sDes = " DMI will be the type of Saving Throw. 1 = Fortitude / 2 = Will / 3 = Reflex "+
"First craft int. will be the amount, from 1-20";break;

case 17:sProp = " Bonus Saving Throw Vs Specific type";
sDes = " DMI will be the type of Saving throw bonus type, 1 = Acid / 3 = Cold / 4 = Death / 5 = Disease "+
"/ 6 = Divine / 7 = Electrical / 8 = Fear / 9 = Fire / 11 = Mind Affecting / 12 = Negative / 13 = Poison "+
"/ 14 = Positive / 15 = Sonic. First craft int. will be the amount, from 1-20";break;

case 18:sProp = " Bonus Spell Resistance";
sDes =  " DMI will be the ammount 0 = +10 / 1 = +12 / 2 = +14 etc... from +10-32 in increments of 2.";break;

case 19:sProp = " Cast Spell";
sDes = " Refer to the Cast spell list, use dmi is used for the spell and first craft int. for the number of uses "+
"SINGLE_USE = 1 / "+
"5 CHARGES PER USE = 2 / "+
"4 CHARGES PER USE = 3 / "+
"3 CHARGES PER USE = 4 / "+
"2 CHARGES PER USE = 5 / "+
"1 CHARGE PER_USE = 6 / "+
"0 CHARGES PER USE = 7 / "+
"1 USE PER DAY = 8 / "+
"2 USES PER DAY = 9 / "+
"3 USES PER DAY = 10 / "+
"4 USES PER DAY = 11 / "+
"5 USES PER DAY = 12 / "+
"UNLIMITED USE = 13";break;

case 20:sProp = " Container Reduced Weight";
sDes = " Used for containers to reduce the weight of the objects inside them. "+
"DMI is used to set the percentage that is reduced, 100% is weightless. 1 = 20% / 2 = 40% / 3 = 60% / 4 = 80% / 5 = 100%";break;

case 21:sProp = " Damage Bonus";
sDes =  " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;

case 22:sProp =  " Damage Bonus Vs Alignment Group";
sDes =  " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil "+
"First Craft Int. is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"Second Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;

case 23:sProp = " Damage Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin "+
"First Craft Int. is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"Second Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;

case 24:sProp = " Damage Bonus Vs Specific Alignment";
sDes =  " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE "+
"First Craft Int. is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"Second Craft Int. is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;

case 25:sProp = " Damage Immunity";
sDes = " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft int. will be use for the % of immunity. 1 = 5% / 2 = 10% / 3 = 25% / 4 = 50% / 5 = 75% / 6 = 90% / 7 = 100%"; break;

case 26:sProp = " Damage Penalty";
sDes =  " DMI will be the amount, from 1-5 for the penalty";break;

case 27:sProp = " Damage Reduction";
sDes =  " DMI will be the enhancment level, from 1-20. 0 = 1 / 1 = 2 / 2 = 3 etc.. "+
"First craft int. will be the amount of soak damage. 1 = 5 / 2 = 10 / 3 = 15 / 4 = 20 / 5 = 25 "+
"/ 6 = 30 / 7 = 35 / 8 = 40 / 9 = 45 / 10 = 50";break;

case 28:sProp = " Damage Resistance";
sDes = " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft Int. will the amount resisted each round. 1 = 5 / 2 = 10 / 3 = 15 / 4 = 20 / 5 = 25 "+
"/ 6 = 30 / 7 = 35 / 8 = 40 / 9 = 45 / 10 = 50";break;

case 29:sProp = " Damage Vulnerability";
sDes = " DMI is use for the type of damage 0 = Bludgeoning / 1 = Piercing / 2 = Slashing / 5 = Magical / 6 = Acid / 7 = Cold "+
"/ 8 = Divine / 9 = Electrical / 10 = Fire / 11 = Negative / 12 = Positive / 13 = Sonic / "+
"First Craft int. will be use for the %. 1 = 5% / 2 = 10% / 3 = 25% / 4 = 50% / 5 = 75% / 6 = 90% / 7 = 100%"; break;

case 30:sProp = " Darkvision";
sDes = " Darkvision will be added to the item, no numbers needed";break;

case 31:sProp = " Decrease Ability";
sDes = " DMI will be the Ability used 0 = STR / 1 =  DEX / "+
"2 = CON / 3 = INT / 4 = WIS / 5 = CHA / First Craft Int. will be the amount, from 1-10";break;

case 32:sProp =" Decrease AC";
sDes =" DMI will be the armor type that is decreased. 0 = Dodge / 1 = Natural / 3 = Armor "+
"/ 4 = Deflection. First Craft int. will be the amount, from 1-5.";break;

case 33:sProp =" Decrease Skill";
sDes =" DMI will be the skill. "+
"ANIMAL EMPATHY   = 0 "+
"CONCENTRATION    = 1 "+
"DISABLE TRAP     = 2 "+
"DISCIPLINE       = 3 "+
"HEAL             = 4 "+
"HIDE             = 5 "+
"LISTEN           = 6 "+
"LORE             = 7 "+
"MOVE SILENTLY    = 8 "+
"OPEN LOCK        = 9 "+
"PARRY            = 10 "+
"PERFORM          = 11 "+
"PERSUADE         = 12 "+
"PICK POCKET      = 13 "+
"SEARCH           = 14 "+
"SET TRAP         = 15 "+
"SPELLCRAFT       = 16 "+
"SPOT             = 17 "+
"TAUNT            = 18 "+
"USE MAGIC DEVICE = 19 "+
"APPRAISE         = 20 "+
"TUMBLE           = 21 "+
"CRAFT TRAP       = 22 "+
"BLUFF            = 23 "+
"INTIMIDATE       = 24 "+
"CRAFT ARMOR      = 25 "+
"CRAFT WEAPON     = 26 "+
"RIDE             = 27 "+
"ALL SKILLS       = 255 "+
"First Craft Int. will be the amount, from 1-10";break;

case 34:sProp = " Enhancement Bonus";
sDes = " DMI will be the amount, from 1-20";break;

case 35:sProp = " Enhancement Bonus Vs Alignment group";
sDes = " DMI will be the alignment group 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil "+
"First craft int. will be the amount, from 1-20";break;

case 36:sProp = " Enhancement Bonus Vs Race";
sDes = " DMI will be the Race 0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin"+
" First Craft int. will be the amount from 1-20.";break;

case 37:sProp =" Enhancement Bonus Vs Specific Alignment";
sDes = " DMI will be the alignment 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE "+
"First Craft Int. will be the amount, 1-20";break;

case 38:sProp =" Enhancement Penalty";
sDes = " DMI will be the amount, from 1-5 for the penalty";break;

case 39:sProp = " Extra Melee Damage Type";
sDes =  " DMI will be used for the type. 0 = Bludgeoning / 1 = Piercing / 3 = Slashing."+
" Can only be used on Melee weapons";break;

case 40:sProp = " Extra Range Damage Type";
sDes =  " DMI will be used for the type. 0 = Bludgeoning / 1 = Piercing / 3 = Slashing."+
" Can only be used on ranged weapons";break;

case 41:sProp = " Free Action";
sDes = " No numbers needed, will add this property to the item.";break;


case 42:sProp = " Haste";
sDes = " No numbers needed, will add this property to the item.";break;

case 43:sProp = " Healers Kit";
sDes = " DMI used for the level of the healing kit, from 1-12";break;


case 44:sProp = " Holy Avenger";
sDes = " No numbers needed, will add this property to the item.";break;

case 45:sProp = " Immunity Misc.";
sDes =  " DMI will be used for the immunity, 0 = Backstab / 1 = Level Drain  /"+
" 2 = Mind spells / 3 = Poison / 4 = Disease / 5 = Fear / 6 = Knockdown / 7 = Paralysis"+
" / 8 = Critical Hits / 9 = Death Magic";break;


case 46:sProp = " Immunity To Spell Level";
sDes = " DMI will be used for the the level of which that and below the user will be immune. "+
"From 1-9";

case 47:sProp = " Improved Evasion";
sDes = " No numbers needed, will add this property to the item.";break;

case 48:sProp = " Keen";
sDes = " No numbers needed, will add this property to the item."+
"This means a critical threat range of 19-20 on a weapon will be increased to 17-20 etc.";break;

case 49:sProp = " Light";
sDes = " DMI will be used for the brightness. 1 = Dim / 2 = Low / 3 = Normal / 4 = Bright. "+
"First craft int. will be used for the color.  0 = Blue / 1 = Yellow / 2 = Purple / 3 = Red "+
"/ 4 = Green / 5 = Orange / 6 = White";break;

case 50:sProp = " Limit Use By Alignment Group";
sDes = " DMI will be the alignment group(s) that can use the item. 0 = ALL / 1 = Neutral / 2 = Lawful / 3 = Chaotic / 4 = Good / 5 = Evil";break;

case 51:sProp = " Limit Use By Class";
sDes = " DMI will be the class(es) that can use the item. "+
"0 = Barbarian "+
"1 = Bard "+
"2 = Cleric "+
"3 = Druid "+
"4 = Fighter "+
"5 = Monk "+
"6 = Paladin "+
"7 = Ranger "+
"8 = Rogue "+
"9 = Sorcerer "+
"10 = Wizard "+
"11 = Aberration "+
"12 = Animal "+
"13 = Construct "+
"14 = Humanoid "+
"15 = Monstrous "+
"16 = Elemental "+
"17 = Fey "+
"18 = Dragon "+
"19 = Undead "+
"20 = Commoner "+
"21 = Beast "+
"22 = Giant "+
"23 = MagicBeast "+
"24 = Outsider "+
"25 = Shapechanger "+
"26 = Vermin "+
"27 = Shadowdancer "+
"28 = Harper "+
"29 = Arcane Archer "+
"30 = Assassin "+
"31 = Blackguard "+
"32 = Champion Torm "+
"33 = WeaponMaster "+
"34 = Pale Master "+
"35 = Shifter "+
"36 = Dwarven Defender "+
"37 = Dragon Disciple "+
"38 = Ooze "+
"41 = Purple Dragon Knight ";break;

case 52:sProp = " Limit Use By Race";
sDes = " Dmi will be used for the race(s) who are allowed to use this item. "+
"0 = Dwarf / 1 = Elf / 2 = Gnome / 3 = Halfling / 4 = Half-Elf / 5 = Half-Orc / 6 = Human / 7 = Aberation / "+
"8 = Animal / 9 = Beast / 10 = Construct / 11 = Dragon / 12 = Goblinoid / 13 = Monstrous / 14 = Orc / 15 = Reptilian "+
"/ 16 = Elemental / 17 = Fey / 18 = Giant / 19 = Magical Beast / 20 = Outsider / 23 = Shape changer / 24 = Undead / 25 = Vermin";break;

case 53:sProp = " Limit Use By Specific Alignment";
sDes =  " DMI will be the alignment(s) that can use the item. 0 = LG / 1 = LN / 2 = LE / 3 = NG / 4 = TN / 5 = NE / 6 = CG / 7 = CN / 8 = CE ";break;

case 54:sProp = " Massive Critical";
sDes = " DMI is used for the amount of damage 1 = 1 / 2 = 2 / 3 = 3 / 4 = 4 / 5 = 5 / 6 = 1d4 "+
"/ 7 = 1d6 / 8 = 1d8 / 9 = 1d10 / 10 = 2d6 / 11 = 2d8 / 12 = 2d4 / 13 = 2d10 / 14 = 1d12 / 15 = 2d12 "+
"/ 16 = 6 / 17 = 7 / 18 = 8 / 19 = 9 / 20 = 10";break;

case 55:sProp = " Material";
sDes =" Use DMI, Refer to material list below.";break;

case 56:sProp = " Max Range Strength Mod";
sDes = " DMI is used for the (mighty property on range weapon, STR. bonus allowed). From 1-20";break;

case 57:sProp =" Monster Damage";
sDes = " DMI will be use to for the amount of monster damage used on the item (only monster items, claws, bites, gore, slam) "+
"1d2 = 1 "+
"1d3 = 2 "+
"1d4 = 3 "+
"2d4 = 4 "+
"3d4 = 5 "+
"4d4 = 6 "+
"5d4 = 7 "+
"1d6 = 8 "+
"2d6 = 9 "+
"3d6 = 10 "+
"4d6 = 11 "+
"5d6 = 12 "+
"6d6 = 13 "+
"7d6 = 14 "+
"8d6 = 15 "+
"9d6 = 16 "+
"10d6 = 17 "+
"1d8 = 18 "+
"2d8 = 19 "+
"3d8 = 20 "+
"4d8 = 21 "+
"5d8 = 22 "+
"6d8 = 23 "+
"7d8 = 24 "+
"8d8 = 25 "+
"9d8 = 26 "+
"10d8 = 27 "+
"1d10 = 28 "+
"2d10 = 29 "+
"3d10 = 30 "+
"4d10 = 31 "+
"5d10 = 32 "+
"6d10 = 33 "+
"7d10 = 34 "+
"8d10 = 35 "+
"9d10 = 36 "+
"10d10 = 37 "+
"1d12 = 38 "+
"2d12 = 39 "+
"3d12 = 40 "+
"4d12 = 41 "+
"5d12 = 42 "+
"6d12 = 43 "+
"7d12 = 44 "+
"8d12 = 45 "+
"9d12 = 46 "+
"10d12 = 47 "+
"1d20 = 48 "+
"2d20 = 49 "+
"3d20 = 50 "+
"4d20 = 51 "+
"5d20 = 52 "+
"6d20= 53 "+
"7d20= 54 "+
"8d20= 55 "+
"9d20= 56 "+
"10d20 = 57";break;

case 58:sProp = " No Damage";
sDes = " No need for any numbers, this will mean the weapon will do no damage in combat.";break;

case 59:sProp = " On Hit Cast Spell";
sDes =  " Creates an item property that (when applied to a weapon item) causes a spell to be cast"+
" when a successful strike is made, or (when applied to armor) is struck by an opponent."+
" DMI is used for the spell (refer to on hit spell list). First craft int. will be used for the level, from 1 - 40";break;

case 60:sProp = " On Hit Properties";
sDes = " Use the on hit property list below";break;

case 61:sProp = " On Monster Hit Properties";
sDes = " Use the on hit property, it has more options then this function";break;

case 62:sProp = " Quality";
sDes =  " The quality property will only affect the cost of the item if you modify the cost in the iprp_qualcost.2da."+
"DMI will be used for the setting, 0 = Unknown / 1 = Destroyed / 2 = Ruined / 3 = Very Poor /  4 = Poor / 5 = Below Average "+
"/ 6 = Average / 7 = Above average / 8 = Good / 9 = Very Good / 10 = Excellent / 11 = Masterworked / 12 = GodLike / 13 = Raw / 14 = Cut / 15 = Polished";break;


case 63:sProp =" Reduced Saving Throw";
sDes = " DMI will be the type of Saving Throw. 1 = Fortitude / 2 = Will / 3 = Reflex "+
"First craft int. will be the amount, from 1-20";break;

case 64:sProp = " Reduced Saving Throw Vs Specific type";
sDes =  " DMI will be the type of Saving throw bonus type, 1 = Acid / 3 = Cold / 4 = Death / 5 = Disease "+
"/ 6 = Divine / 7 = Electrical / 8 = Fear / 9 = Fire / 11 = Mind Affecting / 12 = Negative / 13 = Poison "+
"/ 14 = Positive / 15 = Sonic. First craft int. will be the amount, from 1-20";break;

case 65:sProp =  " Regeneration";
sDes = " DMI will be the amount of Regeneration, from 1-20";break;


case 66:sProp = " Skill Bonus";
sDes = " DMI will be the skill. "+
"ANIMAL EMPATHY   = 0 "+
"CONCENTRATION    = 1 "+
"DISABLE TRAP     = 2 "+
"DISCIPLINE       = 3 "+
"HEAL             = 4 "+
"HIDE             = 5 "+
"LISTEN           = 6 "+
"LORE             = 7 "+
"MOVE SILENTLY    = 8 "+
"OPEN LOCK        = 9 "+
"PARRY            = 10 "+
"PERFORM          = 11 "+
"PERSUADE         = 12 "+
"PICK POCKET      = 13 "+
"SEARCH           = 14 "+
"SET TRAP         = 15 "+
"SPELLCRAFT       = 16 "+
"SPOT             = 17 "+
"TAUNT            = 18 "+
"USE MAGIC DEVICE = 19 "+
"APPRAISE         = 20 "+
"TUMBLE           = 21 "+
"CRAFT TRAP       = 22 "+
"BLUFF            = 23 "+
"INTIMIDATE       = 24 "+
"CRAFT ARMOR      = 25 "+
"CRAFT WEAPON     = 26 "+
"RIDE             = 27 "+
"ALL SKILLS       = 255 "+
"First Craft Int. will be the amount, from 1-50";break;

case 67:sProp = " Special Walk";
sDes = " DMI will be used for the special walk, if no number is used then zombie walk is used";break;

case 68:sProp = " Spell Immunity School";
sDes = " DMI will be used for the school. 0 = Abjuration / 2 = Conjuration / 3 = Enchantment / 4 = Evocation "+
"/ 5 = Illusion / 6 = Necromancy / 7 = Transmutation";break;

case 69:sProp = " Spell Immunity Specific";
sDes = " DMI is used, Use the list below";break;

case 70:sProp = " Thieves Tools";
sDes = " DMI will be the amount of bonus to the thieves tools, from 1-12";break;

case 71:sProp = " Trap";
sDes = " DMI Will be the trap strength. 0 = Minor / 1 = Average / 2 = Strong / 3 = Deadly. "+
"First Craft int. will be the type. 1 = Spike / 2 = Holy / 3 = Tangle / 4 = Blob of acid / 5 = Fire "+
"/ 6 = Electrical / 7 = Gas / 8 = Frost / 9 = Acid splash / 10 = Sonic / 11 = Negative";break;

case 72:sProp = " TrueSeeing";
sDes = " No numbers needed, will add this property to the item.";break;

case 73:sProp = " Turn Resistance";
sDes = " DMI will be the amount of bonus to turn resistance, from 1-50";break;

case 74:sProp = " Unlimited Ammo";
sDes = " DMI will used, If you leave the parameter field blank it will be just a normal bolt, arrow, or bullet. "+
"1 = Basic / 2 = 1d6 fire / 3 = 1d6 cold / 4 = 1d6 lightning / 11 = +1 / 12 = +2 / 13 = +3 / 14 = +4 / 15 = +5";break;

case 75:sProp = " Vampiric Regeneration";
sDes =  " DMI will be used for the amount, from 1-20";break;

case 76:sProp = " Visual Effect";
sDes =" DMI will be used for the visual effect added, 0 = Acid / 1 = Cold / 2 = Electrical / 3 = Fire / 4 = Sonic "+
"/ 5 = Holy / 6 = Evil";break;

case 77:sProp = " Weight Increase";
sDes = " DMI will be used for the weight increase, 0 = 5 lbs / 1 = 10 lbs / 2 = 15 lbs / 3 = 30 lbs / 4 = 50 lbs / 5 = 100 lbs";break;

case 78:sProp = " Weight Reduction";
sDes = " DMI will be used for the weight reduction percentage,  1 = 80% / 2 = 60% / 3 = 40% / 4 = 20% / 5 = 10%";break;

case 79:sProp = " Value Decrease ( CEP property )";
sDes = " DMI will be used for amount, from 1-50";break;

case 80:sProp = " Value Increase ( CEP property )";
sDes = " DMI will be used for amount, from 1-50";break;

}
/*


*/


SetCustomToken(518,sDMSetNumber);
SetCustomToken(535,sProp);
SetCustomToken(536,sDMCraftnumber);
SetCustomToken(537,sDMCraftnumber2);
SetCustomToken(538,sDes);
}
