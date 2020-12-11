--[[ Text substitutions ]]
local L = MacroTalk_Locals

local subsBase = {
	["%%[Nn]"] = function() return UnitName("player") end,
	["%%[Zz]"] = GetRealZoneText,
	["%%[Ss][Zz]"] = function() 
		local subZ
		if GetSubZoneText() ~= "" then
			subZ = GetSubZoneText()
		else
			subZ = GetRealZoneText()
		end
		return subZ
	end,
	
	["%%[Ll][Oo][Cc]"] = function()
		local mapID = C_Map.GetBestMapForUnit("player")
		if mapID == nil then
			return;
		end
		local position = C_Map.GetPlayerMapPosition(mapID,"player")
		if not position then
			return;
		end
		local x, y = position:GetXY() 
		return ("%0.1f, %0.1f"):format(x*100, y*100)
	end,
	
	["%%[Ww][Pp]"] = function()
		local mapID = C_Map.GetBestMapForUnit("player")
		if mapID == nil then
			return;
		end
		local position = C_Map.GetPlayerMapPosition(mapID,"player")
		if not position then
			return;
		end
		if C_Map.GetUserWaypointHyperlink() == nil then
			C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID,position:GetXY()))
			return C_Map.GetUserWaypointHyperlink(), C_Map.ClearUserWaypoint()
		else
			return ""
		end
	end,
	
	["%%[Pp][Ii][Nn]"] = function()
		local mapID = C_Map.GetBestMapForUnit("player")
		if mapID == nil then
			return;
		end
		local position = C_Map.GetPlayerMapPosition(mapID,"player")
		if not position then
			return;
		end
		if C_Map.GetUserWaypointHyperlink() == nil then
			return ""
		else
			return C_Map.GetUserWaypointHyperlink()
		end
	end,
	
	--[[
	You can add straight text substitutions
	to this table. See the example below. Remove the -- from the front to use
	it. Note also that it's case sensitive unless you write both upper- and
	lower-case letters inside brackets like the substitutions above.]]
	
	--["%%tsinfo"] = "TeamSpeak info: Server: host.domain.com, Password: 12345",
}

local sexes = {
	L["<no %s>"]:format(L["gender"]),
	MALE:lower(),
	FEMALE:lower()
}

local unitInfoUnits = {
	[""] = "player",
	["[Tt]"] = "target",
	["[Ff]"] = "focus",
	["[Mm]"] = "mouseover",
	["[Pp]"] = "pet",
	["[Tt][Tt]"] = "targettarget",
}

local unitInfoSuffixes = {
	[""] = UnitName,
	
	["[Ll]"] = function(unit)
		local level = UnitLevel(unit)
		return level > 0 and level or level < 0 and "??"
	end,
	
	["[Cc]"] = UnitClass,
	
	["[Gg]"] = function(unit)
		return sexes[UnitSex(unit)]
	end,
	
	["[Gg][Bb]"] = function(unit)
		local sex = UnitSex(unit)
		return sex > 1 and sexes[UnitSex(unit)] or ""
	end,
	
	["[Rr]"] = function(unit)
		local race
		if UnitIsPlayer(unit) then
			race = UnitRace(unit)
		else
			race = UnitCreatureType(unit)
		end
		return race or L["<no %s>"]:format(RACE:lower())
	end,
	
	["[Rr][Bb]"] = function(unit)
		local race
		if UnitIsPlayer(unit) then
			race = UnitRace(unit)
		else
			race = UnitCreatureType(unit)
		end
		return race or ""
	end,
	
	["[Gg][Uu]"] = function(unit)
		local guild
		guild = GetGuildInfo(unit)
		return guild or "<no guild>"
	end,
	
	["[Gg][Uu][Bb]"] = function(unit)
		local guild
		guild = GetGuildInfo(unit)
		return guild or ""
	end,
	
	["[Rr][Mm]"] = function(unit)
		local nam, realm
		name, realm = UnitName(unit)
		return realm or GetRealmName()
	end,
		
	
	["[Hh]"] = function(unit)
		return UnitHealth(unit).."/"..UnitHealthMax(unit)
	end,
	
	["[Hh][Pp]"] = function(unit)
		return ("%.0f%%%%"):format(UnitHealth(unit)/UnitHealthMax(unit)*100)
	end,
	
	["[Pp][Ww]"] = function(unit)
		local pwType, pwTypeTxt = UnitPowerType(unit)
		local max = UnitPowerMax(unit,pwType)
		if max > 0 then
			return UnitPower(unit,pwType).."/"..max
		else
			return L["<no %s>"]:format(pwTypeTxt:lower())
		end
	end,
	
	["[Pp][Ww][Bb]"] = function(unit)
		local max = UnitPowerMax(unit)
		if max > 0 then
			return UnitPower(unit).."/"..max
		else
			return ""
		end
	end,
	
	["[Pp][Ww][Pp]"] = function(unit)
		local pwType, pwTypeTxt = UnitPowerType(unit)
		local max = UnitPowerMax(unit,0)
		if max > 0 then
			return ("%.0f%%%%"):format(max > 0 and UnitPower(unit,pwType)/max*100 or 0)
		else
			return L["<no %s>"]:format(pwTypeTxt:lower())
		end
	end,
	
	["[Pp][Ww][Pp][Bb]"] = function(unit)
		local max = UnitPowerMax(unit,0)
		if max > 0 then
			return ("%.0f%%%%"):format(max > 0 and UnitPower(unit)/max*100 or 0)
		else
			return ""
		end
	end,
	
	["[Pp][Ww][Tt]"] = function(unit)
		local pwType, pwTypeTxt = UnitPowerType(unit)
		if pwType == nil then
			return L["<no power type"]
		else
			return pwTypeTxt:lower()
		end
	end,
	
	["[Pp][Ww][Tt][Bb]"] = function(unit)
		local pwType, pwTypeTxt = UnitPowerType(unit)
		if pwType == nil then
			return ""
		else
			return pwTypeTxt:lower()
		end
	end,
	
	["[Ii][Cc]"] = function(unit)
		local index = GetRaidTargetIndex(unit)
		return index and "{"..(_G["RAID_TARGET_"..index]):lower().."}" or 
			L["<no %s>"]:format(EMBLEM_SYMBOL:lower())
	end,
	
	["[Ii][Cc][Bb]"] = function(unit)
		local index = GetRaidTargetIndex(unit)
		return index and "{"..(_G["RAID_TARGET_"..index]):lower().."}" or ""
	end,
	
	["[Gg][Nn]"] = function(unit)
		local raidN = UnitInRaid(unit) 
		if raidN == nil then
			if unit == "player" then
				return "<not in raid>"
			else
				name, realm = UnitName(unit)
				if realm == nil then
					return "< "..name.." is not in your raid>"
				else
					return "< "..name.."-"..realm.." is not in your raid>"
				end
			end
		else
			local name, rank, subgroup = GetRaidRosterInfo(raidN)
			return subgroup
		end
	end,
	
	["[Gg][Nn][Bb]"] = function(unit)
		local raidN = UnitInRaid(unit) 
		if raidN == nil then
			return ""
		else
			local name, rank, subgroup = GetRaidRosterInfo(raidN)
			return subgroup
		end
	end,
}

for initial, unit in pairs(unitInfoUnits) do
	local noUnit = L["<no %s>"]:format(unit)
	for suffix, func in pairs(unitInfoSuffixes) do
		if initial ~= "" or suffix ~= "" then
			local code = "%%"..initial..suffix
			if subsBase[code] then
				error(L["MacroTalk: Conflicting substitutions: "..code])
			end
			subsBase[code] = function()
				return UnitExists(unit) and func(unit) or noUnit
			end
		end
	end
end

local substitutions = {}
local i = 1
for k, v in pairs(subsBase) do
	substitutions[i] = { code = k, func = v }
	i = i + 1
end

sort(substitutions, function(subs1, subs2)
	return subs2.code:len() < subs1.code:len()
end)

local OrigSendChatMessage = SendChatMessage
function SendChatMessage(text, ...)
	for _, substitution in ipairs(substitutions) do
		local func = substitution.func
		text = text:gsub(substitution.code,
			type(func) == "function" and func() or func)
	end
	return OrigSendChatMessage(text, ...)
end
