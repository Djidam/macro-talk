--[[ /macrotalk or /mtk ]]
SLASH_MACROTALK1,SLASH_MACROTALK2 = '/macrotalk','/mtk';
SlashCmdList["MACROTALK"] = function(text)
	if (text == 'help') then
		print("MacroTalk : use one of these after /macrotalk or /mtk :")
		print(" - tellunit")
		print(" - group")
		print(" - option")
		print(" - rndcmd")
		print(" - conditional")
		print(" - random")
		print(" - clear waypoint")
		print(" - subs")
		print(" - subs straight")
		print(" - subs unit")
		print(" - subs suffix")
	elseif (text == 'tellunit') then
		print("MacroTalk - TellUnit : ")
		print(" - (/tu, /whisperunit, /wu) {unit} {message}")
		print("   Sends a whisper to the specified unit.")
		print("   Check https://wowwiki.fandom.com/wiki/UnitId for a list of UnitId.")
	elseif (text == 'group') then
		print("MacroTalk - Group : ")
		print(" - (/group, /gr) {message}")
		print(" - Picks /instance if you're in BG, LFR or LFG.")
		print("   Picks /raid if you're in a raid (not LFR).")
		print("   Picks /party if you're in a party (not LFG).")
	elseif (text == 'option') then
		print("MacroTalk - Option : ")
		print(" - /opt [options] {slash command}; [options] {slash command}; ...")
		print(" - Picks from multiple slash commands given the options.")
		print("   You can only use slash commands that don't trigger secure functions.")
		print("   Chat commands, emotes, scripts, etc. are OK. /cast, /use, etc. are off limits.")
		print("   Note: the sub-commands cannot use macro options since the semicolons would cause ambiguity.")
		print(" - Example : /opt [button:2] /bye; /wave")
	elseif (text == 'rndcmd') then
		print("MacroTalk - Random command : ")
		print(" - /rndcmd [options] {command 1}\{command 2}; [options] {command 3}\{command 4}..")
		print(" - Picks a random slash command out of the group chosen based on the given options.")
		print("   Each group is a list of slash commands separated by the backslash (\) character (this is in contrast to commas used for the built-in random commands--commas are just too common in chat messages).")
		print("   Note: like the /opt command, the sub-commands cannot use macro options and you can't use any secure commands.")
		print(" - Example : rndcmd [swimming] /y Help! I'm Drowning! \ /s The water's great!; /s Time for a swim... \ /dance")
	elseif (text == 'conditional') then
		print("MacroTalk - Conditional chat commands : ")
		print(" - All chat commands (/say, /tell, /guild, etc.) can now accept macro options.")
		print("   To use this functionality, simply start the command with /opt.")
		print("   Note: [target=] has no effect on the output of the chat commands; it only affects the other conditionals in the clause.")
		print(" - Examples :")
		print("   /optsay [swimming] gurgle; [mounted] The cavalry has arrived!")
		print("   /cast [target=focus] Polymorph /optgroup [target=focus, exists] Sheeping %f")
	elseif (text == 'random') then
		print("MacroTalk - Random chat commands : ")
		print(" - Similar to the macro options, you can now add /rnd to the beginning of any chat command to pick a random saying.")
		print("   The /rnd___ commands also take options to pick a different list of sayings.")
		print("   The lists themselves are separated by the backslash symbol (\).")
		print(" - Examples : ")
		print("   /rndyell ZOMG! \ WTF?! \ You there! Check out that noise!")
		print("   /rndsay [outdoors] Ahhh, the Great Outdoors! \ What a lovely day!; I wish I could go outside right now \ Must... Leave... Building...")
	elseif (text == "clear waypoint") then
		print(" MacroTalk - Clear WayPoint :")
		print(" # MacroTalk added a command to allow you to clear your WayPoint easilly.")
		print(" # Use /clearwaypoint or /cwp to do the trick.")
	elseif (text == 'subs') then
		print("MacroTalk - Text substitutions : ")
		print(" - MacroTalk offers a variety of substitutions in addition to %t of the default UI.")
		print("   Substitutions are prioritized by the length of the code; longer codes are processed first.")
		print("   This means that %tl will be processed before %t.")
		print("   The codes are case-insensitive so %Tl is equivalent to %tL.")
		print(" - Straight substitutions : ")
		print("  ° %n, %z, %sz, %loc")
		print("  ° Use '/mtk subs straight' for more info")
		print(" - Unit information : ")
		print("  ° %t, %f, %m, %p, %tt")
		print("  ° Use '/mtk subs unit' for more info")
		print(" - You can suffix those with one of the following to return other pieces of data about the unit : ")
		print("  ° l, c, g, r, gu, rm, h, hp, pw, pwp, ic, gn")
		print("  ° Use '/mtk subs suffix' for more info")		
	elseif (text == 'subs straight') then
		print("MacroTalk - Substitutions - Straight  : ")
		print(" # %n - Your name")
		print(" # %z - Your current zone")
		print(" # %sz - Your current sub-zone (or zone if no sub-zone)")
		print(" # %loc - Your map coordinates")
		print(" # %wp - Link a pin to your current location and then remove it")
		print(" # %pin - Link a pin you've manually added to the map")
	elseif (text == 'subs unit') then
		print("MacroTalk - Substitutions - Unit information : ")
		print(" # %t - Name of your target (built in, but listed for consistency)")
		print(" # %f - Name of your focus")
		print(" # %m - Name of mouseover unit")
		print(" # %p - Name of your pet")
		print(" # %tt - Name of your target's target")
	elseif (text == 'subs suffix') then
		print(" MacroTalk - Substitutions - Suffixes : ")
		print(" # l - Level")
		print(" # c - Class")
		print(" # g - Gender")
		print(" # gb - Gender (blank if no gender)")
		print(" # r - Race")
		print(" # rb - Race (blank if no race)")
		print(" # gu - Guild")
		print(" # gub - Guild (blank if no guild)")
		print(" # rm - Realm (works with other realms, in a dungeon for instance)")
		print(" # h - Health (XX/XX)")
		print(" # hp - Health percentage (XX%)")
		print(" # pw - Power - Depending on the unit power, can be mana, focus, energy and so on")
		print(" # pwb - Power (blank if no power)")
		print(" # pwp - Power percentage")
		print(" # pwpb - Power percentage (blank if no mana)")
		print(" # ic - Raid icon")
		print(" # icb - Raid icon (blank if no icon)")
		print(" # gn - Raid group number - Only if target is in the same raid as you, or you are in a raid")
		print(" # gnb - Raid group number (blank if no raid group)")
	else
		print("Macrotalk usage : (use help for more commands)")
		print(" - TellUnit : (/tu, /whisperunit, /wu) {unit} {message}")
		print(" - Group : /group (/gr) {message}")
		print(" - Option : /opt [options] {slash command}; [options] {slash command}; ... ")
		print(" - Random command : /rndcmd [options] {command 1}\{command 2}; [options] {command 3}\{command 4}...")
		print(" - Conditional chat commands like /optsay : (/opt + chat command) [options] {text}; [options] {text}; ...")
		print(" - Random chat commands like /rndyell : (/rnd + chat command) [options] {text}; [options] {text}; ...")
		print(" - Clearing a waypoint/pin : /clearwaypoint or /cwp")
		print(" - Substitutions : ")
		print("  ° Straight : %n, %z, %sz, %loc, %wp, %pin")
		print("  ° Unit : %t, %f, %m, %p, %tt")
		print("  ° Suffixes : l, c, g, r, gu, rm, h, hp, pw, pwp, ic, gn")
	end	
end


--[[ /clearwaypoint or /cwp ]]
SLASH_CLEAR_WAYPOINT1,SLASH_CLEAR_WAYPOINT2 = '/clearwaypoint','/cwp';
SlashCmdList["CLEAR_WAYPOINT"] = function()
	if C_Map.GetUserWaypoint() ~= nil then
		C_Map.ClearUserWaypoint()
		print("waypoint cleared")
	end
end



--[[ /group ]]
local L = MacroTalk_Locals
local print = CogsUtils:GetPrint("MacroTalk: ")

SLASH_GROUP_CHAT1 = L["/group"]
SLASH_GROUP_CHAT2 = L["/gr"]
SlashCmdList["GROUP_CHAT"] = function(text)
	local channel = 
		IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or
		IsInRaid() and "RAID" or
		IsInGroup() and "PARTY"
	if channel then
		SendChatMessage(text, channel, DEFAULT_CHAT_FRAME.editBox.language)
	else
		print(ERR_NOT_IN_GROUP)
	end
end




--[[ /tellunit ]]
SLASH_TELL_UNIT1 = L["/tellunit"]
SLASH_TELL_UNIT2 = L["/whisperunit"]
SLASH_TELL_UNIT3 = L["/tu"]
SLASH_TELL_UNIT4 = L["/wu"]
SlashCmdList["TELL_UNIT"] = function(text)
	local unit, message = strsplit(" ", text, 2)
	local name, realm = UnitName(unit:trim())
	if realm then
		name = name.."-"..realm
	end
	
	if name then
		SendChatMessage(message, "WHISPER", nil, name)
	end
end




--[[ /opt ]]
SLASH_OPTION_SLASH1 = L["/opt"]
SlashCmdList["OPTION_SLASH"] = function(message)
	message = SecureCmdOptionParse(message)
	if message then
		MacroTalk_DoCommand(message)
	end
end




--[[ /rnd ]]
SLASH_RANDOM_SLASH1 = L["/rndcmd"]
SlashCmdList["RANDOM_SLASH"] = function(message)
	message = SecureCmdOptionParse(message)
	if message then
		MacroTalk_DoCommand(GetRandomArgument(strsplit("\\", message)):trim())
	end
end
