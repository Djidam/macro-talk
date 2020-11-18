--[[ Shared functions used by multiple modules ]]
local L = MacroTalk_Locals
local print = CogsUtils:GetPrint("MacroTalk: ")

function MacroTalk_InBattleground()
	for i = 1, GetMaxBattlefieldID() do
		local status = GetBattlefieldStatus(i)
		if status == "active" then
			return true
		end
	end
	return false
end

function MacroTalk_DoCommand(text)
	local command = text:match("^(/%S+)")
	
	if command and IsSecureCmd(command) then
		print(L["You cannot use %s with /opt or /rnd."]:format(command))
		return
	end
	local origText = ChatFrame1EditBox:GetText()
	ChatFrame1EditBox:SetText(text)
	ChatEdit_SendText(ChatFrame1EditBox)
	ChatFrame1EditBox:SetText(origText)
end
