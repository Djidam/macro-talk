MacroTalk - v2.3.2
By Cogwheel, taken over by Djidam

Disabling Modules

If you would prefer only to have certain functionality from MacroTalk (for instance, if you have another addon that provides similar functionality), you can disable various modules by renaming or deleting the corresponding .lua files. You can safely remove MacroTalkChatOptions, MacroTalkCommands, and MacroTalkSubstitutions which correspond to Conditional/Random chat commands, Slash commands, and Text substitutions, respectively.

Slash commands

tellunit (/tu, /whisperunit, /wu) <unit> <message>
Sends a whisper to the specified unit. See http://www.wowwiki.com/API_TYPE_UnitId for a list of units

Example :

/cast Innervate
/tellunit target Incoming innervate

/group (/gr) <message>

Picks battleground, raid, or party chat depending on which type of group you are in.

/opt [options] <slash command>; [options] <slash command>; ... 

Picks from multiple slash commands given the options. You can only use slash commands that don't trigger secure functions. Chat commands, emotes, scripts, etc. are OK. /cast, /use, etc. are off limits.
Note: the sub-commands cannot use macro options since the semicolons would cause ambiguity.

Example :

/opt [button:2] /bye; /wave 

/rndcmd [options] <command 1>\<command 2>; [options] <command 3>\<command 4>... 

Picks a random slash command out of the group chosen based on the given options. Each group is a list of slash commands separated by the backslash (\) character (this is in contrast to commas used for the built-in random commands--commas are just too common in chat messages).
Note: like the /opt command, the sub-commands cannot use macro options and you can't use any secure commands.

Example :

rndcmd [swimming] /y Help! I'm Drowning! \ /s The water's great!;
/s Time for a swim... \ /dance

Conditional chat commands

All chat commands (/say, /tell, /guild, etc.) can now accept macro options. To use this functionality, simply start the command with /opt. 
Note: [target=] has no effect on the output of the chat commands; it only affects the other conditionals in the clause.

Example :

/optsay [swimming] gurgle; [mounted] The cavalry has arrived!

Example :

/cast [target=focus] Polymorph
/optgroup [target=focus, exists] Sheeping %f[/i]


Random chat commands

Similar to the macro options, you can now add /rnd to the beginning of any chat command to pick a random saying. The /rnd___ commands also take options to pick a different list of sayings. The lists themselves are separated by the backslash symbol (\).

Example : 

/rndyell ZOMG! \ WTF?! \ You there! Check out that noise!

Example :

/rndsay [outdoors] Ahhh, the Great Outdoors! \ What a lovely day!;
I wish I could go outside right now \ Must... Leave... Building...[/i]


Text substitutions

MacroTalk offers a variety of substitutions in addition to %t of the default UI. Substitutions are prioritized by the length of the code; longer codes are processed first. This means that %tl will be processed before %t. The codes are case-insensitive so %Tl is equivalent to %tL.

Straight substitutions:

%n - Your name
%z - Your current zone
%sz - Your current sub-zone
%loc - Your map coordinates
%wp - Create a waypoint with your map coordinates and show the link

 Unit information:

%t - Name of your target (built in, but listed for consistency)
%f - Name of your focus
%m - Name of mouseover unit
%p - Name of your pet
%tt - Name of your target's target

You can suffix those with one of the following to return other pieces of data about the unit:

l - Level
c - Class
g - Gender
gb - Gender (blank if no gender)
r - Race
rb - Race (blank if no race)
gu - Guild
gub - Guild (blank if no guild)
rm - Realm
h - Health (XX/XX) - Acts like hp for players not in your party/raid/bg
hp - Health percentage (XX%)
pw - Power - Depending on the unit power, can be mana, focus, energy and so on
pwb - Power (blank if no power)
pwp - Power percentage
pwpb - Power percentage (blank if no mana)
ic - Raid icon
icb - Raid icon (blank if no icon)
gn - Raid group number - Only if target is in the same raid as you, or you are in a raid
gnb - Raid group number (blank if no raid group)

Example :

/p Sheeping %f (level %fl %fg %fr %fc)
/cast [target=focus] Polymorph

Sample result: Sheeping Cogwheel (level 64 male Gnome Warrior)

You can also use the suffixes without a unit code to return information about yourself.

Example :

/s I'm a level %l, %g, %r %c.

Sample result: I'm a level 68, male, gnome warrior.


Changes:

v2.4.1b
- TOC updated
- %wp only shares an existing pin now

v2.4
- TOC updated
- Fixed /rnd command (thanks to NukeninRB)
- Added straight substition %wp to link your position in a waypoint in chat (thanks to Elvenbane)
- Added /macrotalk and /mtk commands, with suffix help for list of commands

v2.4
- TOC updated
- Fixed /rnd command (thanks to NukeninRB)
- Added straight substition %wp to link your position in a waypoint in chat (thanks to Elvenbane)
- Added /macrotalk and /mtk commands, with suffix help for list of commands

v2.3.8
- TOC updated

v2.3.7
- Added suffixe "gn" and "gnb" for raid group number

v2.3.6
- TOC updated

v2.3.5
- TOC updated

v2.3.4
- Fixed nil for arenas

v2.3.3
- TOC updated

v2.3.2
- Fixed chat in instances

v2.3.1
- %loc should now work as intended

v2.3.0
- Beta version for Battle for Azeroth
- Removed %ma, %mab, %mp and %mpb because the functions UnitMana and UnitManaMax no longer exist.
- Added %pw, %pwb, %pwp, %pwpb toe replace %ma etc. Will display the power, and depending on the unit, it will be mana, energy, focus, rage, lunar and so on.
- The player coordinates are broken due to changes to the map UI. Untill bli² release a doc, the functionnality is disabled.

v2.2.4
- TOC updated

v2.2.3
- Some minor code improvements

v2.2.2
- TOC updated

v2.2.1
- Quick fix in MacroTalkSubstitutions about coordinates to repair SendChatMessages

v2.2.0
- Fixed a bug with /gr in a party

v2.1.6
- TOC updated

v2.1.5
- TOC updated

v2.1.4
- TOC updated

v2.1.3
- %loc now print coordinates with one decimal

v2.1.2
- TOC updated

v2.1.1
- TOC updated

v2.1
- With 5.2 patch, I figured MacroTalk should be 2.1, since a lot of changes happend before, and this version would be a basic one now.
- TOC updated

v2.0.8
- Changes with new chan Instance
- Fixed BATTLEGROUNDS issues
- Fixed /group issues

v2.0.7
- TOC updated
- substitutions with h (for health) will always give you currentHP/maxHP. use hp for health percentage.

v2.0.6
- Function GetNumGroupMember replace with IsInRaid, to make sure you're really in a party or a raid.

v2.0.5
- Function GetNumPartyMember and GetNumRaidMember replaced with new GetNumGroupMember.

v2.0.4
- TOC updated

v2.0.3
- Fixed an issue with the subzone substitution. Now if you are in a zone with no subzones, %sz will show you the name of the zone instead of nothing.
v2.0.2
- Fixed an issue I did not see (thanks Boccanegra) with /opt or /rnd commands and a secure command like /equipset.
- Constant MAX_BATTLEFIELD_QUEUES replaced by the function GetMaxBattlefieldID() 

v2.0.1
- Corrected 3 changes done with versions posted on wowinterface and not in wowcurse (1.72 max in wow curse and 1.8.1 max in wowinterface) 
See below for the changes.

v2.0
- Works now with 4.2
- Added realm and guild commands

v1.8.1
- Fixed a stray global in MacroTalk.lua

v1.8
- The ic and icb suffixes now insert the appropriate codes to send texture links
instead of just the name of the icons.

v1.7.2
- Fixed a bug where a hyphen (-) was incorrectly appended to the /tellunit
target in certain situations

v1.7.2
- %gb correctly eliminates the "no gender" message
- % without a code no longer substitutes as the player's name

v1.7.1
- Fixed suffixes to work without a unit
- Fixed error when using /gr outside of a group

v1.7
- /rnd___ commands should actually work now
- Changed /rnd to /rndcmd because of a conflict with the built-in /rnd command
- Added architecture for straight text substitutions (no interface yet--see
MacroTalkSubstitutions.lua for more information)

v1.6
- Added raid icon and "blank" suffixes

v1.5.1
- Fixed a bug that was preventing all SendChatMessage calls

v1.5
- The race suffix will use UnitRace for players and UnitCreatureType for NPCs
- Added %tt, %loc
- Added health and mana suffixes

v1.4
- /opt & /rnd will now print an error message if you attempt to use a secure
command
- Added %n, %z, %sz
- Added ability to use suffixes alone to get info about the player
- Changed unit prefixes to suffixes - INCOMPATIBLE WITH PREVIOUS VERSION
- Substitutions are no longer case-sensitive
- Restructured substitutions and localizations to be more generic

v1.3
- Added /rnd and /rnd___ commands
- Fixed a bug where the /opt prefix was only being applied to the first command
of a given type (e.g. only /opts would work but not /optsay)

v1.2
- Added generic /opt command

v1.1
- Improved localizability of substitutions

v1.0
- Name substitutions have been simplified a bit to match the functionality of %t
- Added pet unit substitution
- Added info type prefixes: level, class, gender, race

v0.9
- Added /opt___ commands
- Fixed a bug where %m behaved like %f
- No longer uses Satellite
- Added localization lua for future localization

v0.5
- Initial release
