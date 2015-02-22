TerribleObjectiveDB = {}

Enabled = true

-- Prints a lovley message.
local function print(message)
	DEFAULT_CHAT_FRAME:AddMessage("TerribleObjective: " .. tostring(message))
end

function TerribleObjectiveFrame_OnEvent(self, event, ...)
	if Enabled then
		if event == "PLAYER_REGEN_ENABLED" and ObjectiveTrackerFrame.collapsed then
			ObjectiveTracker_Expand()
		elseif event == "PLAYER_REGEN_DISABLED" and not ObjectiveTrackerFrame.collapsed then
			ObjectiveTracker_Collapse()
		end
	end
end

function TerribleObjective_Commands(Message, Editbox)
	if Message then Message=strlower(Message); end
	if Message == "help" then
		print("Commands you can use:")
		print("auto - Hides the frame whilst in combat then it will show up when you leave combat")
		print("off - It's just static open")
		print("show - Shows the frame")
		print("hide - hides the frame")
		print("scale - Sets the scale of the frame to a default value of 0.85. You can change this value inside TerribleObjective.lua on line 40")
	elseif Message == "auto" then
		ObjectiveTrackerFrame:Show()
		Enabled = true
		print("Now hiding the frame whilst in combat.")
	elseif Message == "off" then
		if ObjectiveTrackerFrame.collapsed then ObjectiveTracker_Expand(); end
		Enabled = false
		print("Now its static open.")
	elseif Message == "show" then
		ObjectiveTrackerFrame:Show()
	elseif Message == "hide" then
		Enabled = false
		ObjectiveTrackerFrame:Hide()
	elseif Message == "scale" then
		ObjectiveTrackerFrame:SetScale(0.85)
	end
end

local TerribleObjectiveFrame = CreateFrame("Frame")
TerribleObjectiveFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
TerribleObjectiveFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
TerribleObjectiveFrame:RegisterEvent("ADDON_LOADED")
TerribleObjectiveFrame:SetScript("OnEvent", TerribleObjectiveFrame_OnEvent)

SlashCmdList["TerribleObjective"]=TerribleObjective_Commands
SLASH_TerribleObjective1, SLASH_TerribleObjective2="/tob", "/toe"
TerribleObjective_Commands("help")