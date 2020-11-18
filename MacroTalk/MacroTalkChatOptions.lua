--[[ Option chat commands ]]
local L = MacroTalk_Locals

local function CreateCmdListEntry(category, command, num)
	if not num then
		num = command
		command = _G[category..1]
	end
	
	for i = 1, num do
		local subcommand = (_G[category..i] or command):sub(2)
		_G["SLASH_OPTION_"..category..i] = L["/opt"]..subcommand
		_G["SLASH_RANDOM_"..category..i] = L["/rnd"]..subcommand
	end
	
	SlashCmdList["OPTION_"..category] = function(message)
		message = SecureCmdOptionParse(message)
		if message then
			MacroTalk_DoCommand(command.." "..message)
		end
	end
	
	SlashCmdList["RANDOM_"..category] = function(message)
		message = SecureCmdOptionParse(message)
		if message then
			local args = {strsplit("\\", message)}
			MacroTalk_DoCommand(command.." "..args[random(#args)]:trim())
		end
	end
end

local baseCommands = {
	["SLASH_INSTANCE_CHAT"] = 4,
	["SLASH_CHANNEL"] = 4,
	["SLASH_EMOTE"] = 8,
	["SLASH_GUILD"] = 8,
	["SLASH_OFFICER"] = 4,
	["SLASH_PARTY"] = 4,
	["SLASH_RAID"] = 6,
	["SLASH_RAID_WARNING"] = 2,
	["SLASH_REPLY"] = 4,
	["SLASH_SAY"] = 4,
	["SLASH_WHISPER"] = 10,
	["SLASH_YELL"] = 8,
	["SLASH_GROUP_CHAT"] = 2,
	["SLASH_TELL_UNIT"] = 4,
}

for k, v in pairs(baseCommands) do
	CreateCmdListEntry(k, v)
end

for i = 1, 10 do
	CreateCmdListEntry("CHANNEL"..i.."_", "/"..i, 1)
end
