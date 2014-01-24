/**
 * Switch-Based Secret Doors Suite, v1.21
 * Written by Samuel Ferguson, April 2007
 *
 * This script suite is built around Bioware's nw_02_dtwalldoor.
 *
 * Switch-Based Secret Doors allows you to easily place secret doors that are
 * opened remotely by switches, which can be either hidden (requiring search
 * checks to find) or in plain sight.  Switch-Based Secret Doors cannot be
 * found simply by searching a section of wall.  Rather, the secret that must
 * be found is hidden on some other object - a torch sconce, a statue, a piece
 * of furniture, or any other placeable - which may not even be useable or
 * selectable until the player finds the secret.
 *
 * Switch-Based Secret Doors also supports multiple types of secret doors
 * (one-way, two-way, linked, timed, or any combination, plus special socketed
 * switches), special flavor text for individual switches, cross-area switching,
 * and no-hassle henchman searching.
 *
 * FEATURES
 * ==========
 *
 * - Uses standard Bioware secret door detection algorithms in a new way.
 *   Instead of searching for the door, players must search for the mechanism
 *   that controls it - which can be anywhere in the area or even anywhere
 *   in the module, not just in front of the door.
 * - Open secret doors remotely with any placeable object.  Use the object
 *   a second time to close (and hide!) the door.
 * - Hide door switches inside ordinary placeables - EVEN unuseable objects,
 *   which look exactly like static background objects until the secret is
 *   found.  Make your players work for their secrets and think about where
 *   the trigger might be hidden, instead of just homing in on the obvious
 *   useable statue in the corner.
 * - Are your switches too deviously hidden?  SBSD allows your players' henchmen
 *   to search for them, automatically, with no special AI positioning required.
 * - Precision searching: Need to limit your players' line of sight when
 *   searching?  Use a precision searching trigger to define exactly where
 *   a player has to be in order to find the switch.  Use precision searching
 *   to hide switches in narrow cul-de-sacs, behind counters and furniture,
 *   inside closets, and more, without players being able to find the switch
 *   through walls and other obstacles.
 * - Two-way secret doors: One switch can open and close two secret doors
 *   simultaneously, without the annoyance of having two different doors that
 *   must be searched for and found seperately.
 * - One-way secret doors: Doors that slam shut after you walk through them.
 *   These doors have animated entrances and exits - instead of suddenly
 *   appearing in front of a blank wall, you'll see the door shut behind you
 *   and disappear.
 * - Link multiple switches to the same secret door.  Two or more levers,
 *   secret switches, or hidden buttons all operate in sync to open and
 *   close the same door.
 * - Timed secret doors that automatically close and disappear after the
 *   specified period of time has elapsed.
 * - Socketed mechanisms that only open when the correct object is inserted.
 * - Optional and configurable percentile modifiers to search skill and detection
 *   range for passive search mode.
 * - No extra fuss for traps - place them directly on the mechanism.
 * - Completely configurable flavor text.  Each individual switch, even among
 *   linked switches, can send a unique message to the player when he or she
 *   finds the secret or activates it - without requiring any extra scripts.
 *   Default flavor text is automatically displayed if no special text is set.
 * - Multiple henchmen and their associates are all brought through the
 *   door with the player.
 * - Supports multiple door graphics, with easy extensibility for custom doors.
 * - For persistent worlds, rehide your switches after a certain amount of time,
 *   or when the area is empty of players.
 * - Non-invasive: NO overwriting of Bioware standard resources.
 * - Includes demonstration module.
 *
 *
 * REQUIREMENTS
 * ==============
 *
 * SBSD was developed on SoU+HotU 1.68, and may or may not work on other
 * versions of Neverwinter Nights.
 *
 *
 * STANDARD DISCLAIMER
 * ===================
 *
 * The author accepts no responsibility for any damages that may be caused
 * by this software.  Use Switch-Based Secret Doors at your own discretion.
 *
 *
 * HOW TO INSTALL SWITCH-BASED SECRET DOORS
 * ==========================================
 * These instructions assume basic familiarity with Windows and Aurora.
 *
 * 1) Extract the .mod file to your NWN modules directory, and the .erf file
 *    to your erf directory.
 * 2) Import the .erf file into your module.
 * 3) That's it.  This document will explain the various functions, variables
 *    and placeables that you can use to create a variety of different secret
 *    doors.
 *
 *
 * TUTORIAL
 * ==========
 *
 * Here's a quick rundown on what you can do with SBSD, and how to do it.
 * If you haven't tried the demonstration module yet, you should do so to get
 * a feel for what SBSD is about.
 *
 * OVERVIEW OF SCRIPTS
 * ---------------------
 * All scripts are prefixed by sbsd_.
 *
 * 1) usedoor is the routine called when you enter a secret door.  You don't
 *    need to touch these to use the default doors in SBSD, but if you create
 *    a new type of secret door, put this in its OnUsed field.
 *
 * 2) useswitch is the OnUsed script for switches - the objects you need to
 *    click on to open secret doors.
 *
 * 3) socket is the OnDisturbed script for socketed switches.  They open or
 *    close secret doors when the correct item is added to or removed from
 *    the object's inventory.
 *
 * 4) checksearch is an OnHeartbeat script that should be placed on the
 *    switch object.  It is adapted from nw_o2_dtwalldoor and checks the
 *    search skill of anyone in range every heartbeat.  If a player has a
 *    henchman with a better search skill, the henchman's skill will be
 *    checked instead regardless of where the henchman is located.
 *
 * 5) zoneenter and zoneexit track whether a player is standing in a precision
 *    searching zone.  Switches that are linked to precision zones will not
 *    check search skills of any player not standing in the zone.
 *
 * 6) include is the main include file.  All functions, switch variables, and
 *    global configuration variables are defined in this file.  The comments
 *    in sbsd_include give detailed descriptions of all the variables you
 *    can manipulate in SBSD.  It is recommended that you look over sbsd_include
 *    after reading this document to more thoroughly understand SBSD's
 *    capabilities.
 *
 * 7) 1way_, 2way_, and trapdoor_ scripts are no longer used as of SBSD 1.2
 *    and are included for compatibility reasons only.
 *
 * GLOBAL BEHAVIOR
 * -----------------
 * There are several constants at the top of sbsd_include that affect the
 * behavior of all switches in the module.  Usage instructions can be found
 * in sbsd_include.
 *
 * BASIC SWITCHES
 * ----------------
 * To set up a basic door switch...
 *
 * 1) Drop a placeable such as a statue or lever.  Make sure it's marked as
 *    plot and useable.  Set a unique tag; we'll call it <tag>.
 * 2) Set an INT variable on the placeable called sbsd_isUseable and set it
 *    to 1.  This is important; your switch won't respond otherwise.
 * 3) Set the OnUsed script to sbsd_useswitch.
 * 4) Drop waypoints to mark where the doors should spawn.  You can find
 *    templates for these waypoints in the custom waypoint palette.  The
 *    waypoint designating the door spawn locations are tagged SWP_<tag>
 *    and SWP2_<tag>; place one on either side of the wall, and make sure
 *    that the arrows face into the wall, or the door will open the wrong way.
 *    You should place both SWP waypoints even if you're creating a one-way
 *    door, so that the player can see it close behind them.
 * 5) Drop destination waypoints.  The door at SWP_<tag> will drop the
 *    user at DST_<tag>.  The door at SWP2_<tag> leads to DST2_<tag>. For
 *    one-way doors, don't place a DST2 waypoint.
 * 6) You now have a basic switch.  It isn't hidden or locked, and using
 *    it will toggle the secret door open or closed.
 *
 * HIDDEN SWITCHES
 * -----------------
 * Hidden switches cannot be activated until the player passes a search
 * check within a certain radius of the placeable.  To create a hidden
 * switch, create a basic switch but make the following changes:
 *
 * 1) DO NOT set sbsd_isUseable to 1.  The scripts will do this when
 *    the player finds the switch.
 * 2) Set OnHeartbeat to sbsd_checksearch.
 * 3) Set Reflex Save to the radius at which the switch should be
 *    detectable.  I believe it's in meters, but 5 is a good value if
 *    you're unsure; it's about half the length of one tile.  If you
 *    leave this at zero, no one will find your switch!
 * 4) Set Will Save to the DC of the search check.
 *
 * SECRET SWITCHES
 * -----------------
 * Secret switches are hidden switches that are located on NON-USEABLE
 * objects.  Create a hidden switch, but DO NOT mark the placeable as
 * useable OR static in the item properties.  When the switch is discovered,
 * the object becomes selectable.  This is a good way to trick players
 * into dismissing a secret door switch as just part of the background,
 * and thus not bothering to search that area.
 *
 * SOCKETED SWITCHES
 * -------------------
 * Socketed switches do not activate when used.  Instead, a special item
 * must be placed in its inventory in order to open the door it controls.
 * Create a basic, hidden or secret switch, but...
 *
 * 1) Leave OnUsed blank.
 * 2) Place sbsd_socket in OnDisturbed.
 * 3) Set INT variable sbsd_isLocked to 1.
 * 4) Go to object properties and set the object as Locked and requiring
 *    a specific key to open.  For the key tag, put in the tag of the
 *    object that you want to activate the switch.
 * 5) Ensure that Useable and Has Inventory are checked.
 *
 * Note that although socketed switches will technically work when timed
 * or linked, this should be avoided, as you may later find the socketed
 * switch opening the door when it should be closing, and vice versa.
 *
 * SETTING A TIMER
 * -----------------
 * To make a secret door automatically close after a certain period of
 * time, simply create a basic, hidden or secret switch and set its INT
 * variable sbsd_timer to the number of seconds the door should stay
 * open.  Remember that timed doors into dead-end rooms can permanently
 * trap the player.
 *
 * LINKED SWITCHES
 * -----------------
 * You can set multiple switches to control the same door.  For example,
 * a noble's bedroom may have a secret door leading into an underground
 * escape tunnel that he can open from one side and close again from the
 * other side.  Any number of switches may be linked to a single door.
 * To link switches, simply create multiple switches with the same tag,
 * but only create one set of waypoints for them.  Now, set the INT
 * variable sbsd_linkedSwitch to 1 on ALL switches that you want to
 * link.  If you don't do this, you will get strange results.  The
 * switches may be any combination of basic, hidden or secret switches.
 *
 * PRECISION SWITCHING
 * ---------------------
 * Normal searches are conducted in a radius that extends through any
 * walls or obstacles.  If you want to restrict a switch to detection
 * within an exact area - for example, only if the player is standing
 * behind the counter, not in front of it - use the Precision Search
 * Trigger from the custom triggers palette.  Tag it SBPS_<tag>, and
 * set the INT variable sbsd_usesTriggerToSearch to 1 on your switch
 * placeable.  Now the switch will only check for detection when an
 * eligible player is standing inside the trigger boundaries.  If you
 * don't have the trigger blueprint, just draw a trigger and place
 * sbsd_zoneenter in OnEnter and sbsd_zoneexit in OnExit.  Don't forget
 * the proper tag.  Precision switching can be used with any switch
 * that uses sbsd_checksearch.
 *
 * CROSS-AREA SWITCHES
 * ---------------------
 * For performance reasons and to prevent strange behavior when duplicate
 * switch tags exist in the module, switches by default only search for
 * waypoints in their own area when activated.  However, you can set up a
 * switch that can open or close doors anywhere in the module.  There are
 * two ways to do this:
 *
 * 1) You can open sbsd_include and set the SBSD_GLOBAL_SWITCHES_VAR to 1,
 *    which will enable cross-area behavior on every switch in the module.
 *    This is not recommended in most cases.
 * 2) You can set sbsd_crossArea to 1 on the switch to force that specific
 *    switch to search across areas when activated.  This is the preferred
 *    method of handling cross-area switches.
 *
 * Any type of switch can be a cross-area switch, including timed switches.
 * It's even possible to have, say, a switch in Area 1 that opens a door in
 * Area 2 that leads to Area 3.  All you have to do after enabling cross-area
 * switching is to place the switch and corresponding waypoints as normal.
 *
 * MANUALLY PROGRAMMING DESTINATIONS
 * -----------------------------------
 * If for some reason you want to place an object yourself that will be used
 * as a door to an SBSD destination waypoint, simply place sbsd_useSwitch in
 * the object's OnUsed field, and set a string variable called Destination
 * on the object to the tag of the waypoint you want the object to connect to.
 *
 * FLAVOR TEXT
 * -------------
 * You can add special flavor text to any switch to override the default
 * messages that are displayed when a player finds or activates a switch.
 * Simply set one or more of the following string variables on your
 * placeable:
 *
 * sbsd_foundString: The string to display when the switch is discovered.
 * sbsd_openString: Displayed when the corresponding door is opened.
 * sbsd_closeString: Displayed when the corresponding door is closed.
 * sbsd_slamString: Displayed when a timed or one-way door closes itself.
 *
 * HENCHMEN SEARCHING
 * --------------------
 * Whenever a player is within search range of a switch and has henchmen
 * that have higher search skills than the player, the henchman's search
 * skill will be used in place of the player's.  The player does not need
 * to position the henchman within search range to gain this benefit.
 * If the henchman finds anything, his or her name will be displayed
 * instead of the standard "Hey!".
 *
 * Henchmen are considered to be in the same search mode as their master.
 * This includes the benefits of the Keen Senses feat.  Henchman searching
 * can be disabled in sbsd_include.
 *
 * CHANGING THE DOOR MODEL
 * -------------------------
 * You can change the type of door that a switch spawns by setting the string
 * sbsd_doorResref to the resref of the door you want.  Make sure the resref
 * refers to a useable placeable with sbsd_usedoor in the OnUse field.
 * Some placeables may look or sound strange when opened or closed; you
 * can set sbsd_noAnim to 1 to disable opening and closing sound and animation.
 *
 * Several types of secret doors are preconfigured with SBSD.  You can find
 * their resrefs in sbsd_include.
 *
 * REHIDING SWITCHES
 * -------------------
 * Authors of persistent worlds may find it useful to rehide their switches.
 * This can be done on a timer on individual switches using the
 * sbsd_rehideTimer variable, or globally with several configuration settings
 * in sbsd_include.
 *
 * RESOURCES
 * ===========
 * There are several premade resources included in SBSD that you can take
 * advantage of.  Make use of them to save yourself some time; usage
 * instructions can be found in the comments field of each object.
 *
 * PLACEABLES
 * ------------
 * There are five preconfigured secret doors under Secret Objects.
 *
 * The switches used in the demonstration module are available for reference
 * under Special -> Custom 1.
 *
 * TRIGGERS
 * ----------
 * The precision search trigger is available under Generic Trigger.
 *
 * WAYPOINTS
 * -----------
 * The two source and two destination waypoints are available under Waypoints.
 *
 * USING AND MODIFYING SBSD
 * ==========================
 * You may expand, tweak or modify Switch-Based Secret Doors as much as you
 * like for your own purposes.  If there's something you've added that you
 * think the core release ought to have, please contact me via the NWVault
 * entry before you go posting anything to the vault.  I will gladly credit
 * anyone who contributes to SBSD, but I would prefer to keep such contri-
 * butions within a single official release in most cases.  This is more
 * convenient for everyone involved.
 *
 * If you use Switch-Based Secret Doors in your own module, with or without
 * modification, I only ask that you credit me in your module's readme file
 * as you would with any other community content.
 *
 *
 * KNOWN BUGS AND WORKAROUNDS
 * ============================
 * None at this time.
 *
 *
 * REVISION HISTORY
 * ==================
 *
 * January 11, 2008
 * (v1.21)
 *
 * - Fixed an issue with one-way doors from v1.0 or 1.1 not closing properly.
 * - Added information to the readme about manually configuring destinations
 *   for pre-placed "doors."
 *
 * January 10, 2008
 * (v1.2)
 *
 * NEW FEATURES (See documentation for usage instructions)
 * - Secret doors can now be controlled across areas.  This means that a single
 *   switch can open doors in other areas, or doors that connect two different
 *   areas.  For performance reasons and to prevent unexpected results with
 *   accidentally duplicated tags, this behavior is disabled by default.  It
 *   can be enabled by setting a variable on the switch, or globally by changing
 *   a constant in the main include.  Otherwise, secret doors will only spawn
 *   in the same area as the switch.  Note, however, that if the door is in the
 *   current area but the destination waypoint is in a different area, the door
 *   will still teleport the player to that waypoint.
 * - Switches now have an optional variable that defines the resref of the
 *   door (or other object) that they spawn.  This means that you can program
 *   a switch to spawn any clickable placeable you like simply by setting
 *   a variable on the switch.  No more modifying scripts every time you
 *   introduce a new type of secret portal.
 * - The scripts that control switch activation and door usage have been
 *   compressed into one generic script each.  All non-socketed switches now
 *   use sbsd_useswitch, and all secret doors, one-way or two-way, now use
 *   sbsd_usedoor.  Socketed switches use sbsd_socket as their OnDisturbed
 *   script.  The door model and one-way / two-way behavior is now handled
 *   via switch variables.  The old scripts are still available and functional
 *   for backwards compatibility.
 * - There is now an optional variable that will rehide or deactivate a switch
 *   a certain number of seconds after it is discovered.  Be aware that very
 *   low timer values (short enough for players to wander in and out of the
 *   detection zone) may cause strange timing behavior.
 * - For switches that are rehidden when the area is empty or after X seconds
 *   have elapsed, there is an optional variable that will close and hide
 *   any secret doors linked to that switch.  This variable is disabled by
 *   default.  Previously, the doors were always closed unless the mechanism
 *   was a socketed switch.  Please note that this variable has no effect
 *   on socketed switches, which can be rehidden but which will only close
 *   their corresponding doors if the key is removed.
 * - Switches that attempt to rehide themselves when a player is within the
 *   switch's detection range will abort and try again at a builder-configured
 *   interval.
 * - Added a new room to the demo module to explain cross-area switching.
 * - Enhanced henchman searching can now be disabled in the main include.
 * - Added wooden and stone trap doors and a magic portal to the premade secret
 *   door selection.
 *
 * BUG FIXES
 * - The proximity-based reset for persistent worlds will now reset clickable
 *   but inactive mechanisms to their original clickable state, rather than
 *   making them unclickable secret switches.
 *
 * May 6, 2007
 * (v1.1)
 *
 * - Players will now suffer penalties to their search skill and detection
 *   radius if they are not in Active Search Mode (aka Detect Mode).  By
 *   default, passive search mode reduces search skill by 50% and detection
 *   range by 33%.  These values can be customized by individual builders.
 *   Henchmen are always considered to be in the same mode as their master.
 * - There is now an option for persistent worlds that will reset all hidden
 *   switches if there are no players in the area.  The option is a constant
 *   found at the top of sbsd_include.
 * - Finding a hidden switch will now trigger the appropriate voice clip.
 * - Minor improvements to the demo module.
 *
 * April 13, 2007
 * (v1.0)
 *
 * - Initial release.
 **/
