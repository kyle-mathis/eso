
--[[

	GLOBALES FUNCTIONS

]]--
FCMQT = FCMQT or {}

-- General Buffer made by Wykkyd : http://wiki.esoui.com/Event_%26_Update_Buffering
local BufferTable = {}
local function BufferReached(key, buffer)
if key == nil then return end
	if BufferTable[key] == nil then BufferTable[key] = {} end
	BufferTable[key].buffer = buffer or 3
	BufferTable[key].now = GetFrameTimeSeconds()
	if BufferTable[key].last == nil then BufferTable[key].last = BufferTable[key].now end
	BufferTable[key].diff = BufferTable[key].now - BufferTable[key].last
	BufferTable[key].eval = BufferTable[key].diff >= BufferTable[key].buffer
	if BufferTable[key].eval then BufferTable[key].last = BufferTable[key].now end
	return BufferTable[key].eval
end

-- Check menu witch are opened
function FCMQT.CheckMode()
	if FCMQT.main then
		local InteractiveMenuIsHidden = ZO_KeybindStripControl:IsHidden()
		local GameMenuIsHidden = ZO_GameMenu_InGame:IsHidden()
		local DialogueIsHidden = ZO_InteractWindow:IsHidden()
		local JournalIsHidden = ZO_QuestJournal:IsHidden()
		ZO_FocusedQuestTrackerPanel:SetHidden(true)
		if InteractiveMenuIsHidden == true and GameMenuIsHidden == true and DialogueIsHidden == true then
			FCMQT.main:SetHidden(false)
		elseif InteractiveMenuIsHidden == false or GameMenuIsHidden == true or DialogueIsHidden == false then
			FCMQT.main:SetHidden(true)
		end
		if JournalIsHidden == false then
			-- FCMQT.BoxQuestJournal()
		end
	end
end

function FCMQT.GetPreset()
	return FCMQT.SavedVars.Preset
end
function FCMQT.SetPreset(newPreset)
	FCMQT.SavedVars.Preset = newPreset
	local tmpPositionLock = FCMQT.GetPositionLockOption()
	if newPreset == "Default" then
		FCMQT.SavedVars.BgWidth = FCMQT.PresetDefaults.BgWidth
		FCMQT.SavedVars.BgAlpha = FCMQT.PresetDefaults.BgAlpha
		FCMQT.SavedVars.BgOption = FCMQT.PresetDefaults.BgOption
		FCMQT.SavedVars.BgColor = FCMQT.PresetDefaults.BgColor
		FCMQT.SavedVars.ShowJournalInfosOption = FCMQT.PresetDefaults.ShowJournalInfosOption
		FCMQT.SavedVars.ShowJournalInfosFont = FCMQT.PresetDefaults.ShowJournalInfosFont
		FCMQT.SavedVars.ShowJournalInfosSize = FCMQT.PresetDefaults.ShowJournalInfosSize
		FCMQT.SavedVars.ShowJournalInfosStyle = FCMQT.PresetDefaults.ShowJournalInfosStyle
		FCMQT.SavedVars.ShowJournalInfosColor = FCMQT.PresetDefaults.ShowJournalInfosColor
		FCMQT.SavedVars.TitleSize = FCMQT.PresetDefaults.TitleSize
		FCMQT.SavedVars.TitlePadding = FCMQT.PresetDefaults.TitlePadding
		FCMQT.SavedVars.TitleFont = FCMQT.PresetDefaults.TitleFont
		FCMQT.SavedVars.TitleStyle = FCMQT.PresetDefaults.TitleStyle
		FCMQT.SavedVars.TitleColor = FCMQT.PresetDefaults.TitleColor
		FCMQT.SavedVars.TextSize = FCMQT.PresetDefaults.TextSize
		FCMQT.SavedVars.TextPadding = FCMQT.PresetDefaults.TextPadding
		FCMQT.SavedVars.TextFont = FCMQT.PresetDefaults.TextFont
		FCMQT.SavedVars.TextStyle = FCMQT.PresetDefaults.TextStyle
		FCMQT.SavedVars.TextColor = FCMQT.PresetDefaults.TextColor
		FCMQT.SavedVars.TextCompleteColor = FCMQT.PresetDefaults.TextCompleteColor
		FCMQT.SavedVars.TextOptionalColor = FCMQT.PresetDefaults.TextOptionalColor
		FCMQT.SavedVars.TextOptionalCompleteColor = FCMQT.PresetDefaults.TextOptionalCompleteColor
		FCMQT.SavedVars.ClueColor = FCMQT.PresetDefaults.ClueColor
		FCMQT.SavedVars.SortOrder = FCMQT.PresetDefaults.SortOrder
		FCMQT.SavedVars.NbQuests = FCMQT.PresetDefaults.NbQuests
		FCMQT.SavedVars.AutoShare = FCMQT.PresetDefaults.AutoShare
		FCMQT.SavedVars.AutoAcceptSharedQuests = FCMQT.PresetDefaults.AutoAcceptSharedQuests
		FCMQT.SavedVars.AutoRefuseSharedQuests = FCMQT.PresetDefaults.AutoRefuseSharedQuests
		FCMQT.SavedVars.QuestIconOption = FCMQT.PresetDefaults.QuestIconOption
		FCMQT.SavedVars.QuestIcon = FCMQT.PresetDefaults.QuestIcon
		FCMQT.SavedVars.QuestIconSize = FCMQT.PresetDefaults.QuestIconSize
		FCMQT.SavedVars.QuestIconColor = FCMQT.PresetDefaults.QuestIconColor
		FCMQT.SavedVars.QuestsAreaOption = FCMQT.PresetDefaults.QuestsAreaOption
		FCMQT.SavedVars.QuestsAreaFont = FCMQT.PresetDefaults.QuestsAreaFont
		FCMQT.SavedVars.QuestsAreaStyle = FCMQT.PresetDefaults.QuestsAreaStyle
		FCMQT.SavedVars.QuestsAreaPadding = FCMQT.PresetDefaults.QuestsAreaPadding
		FCMQT.SavedVars.QuestsAreaSize = FCMQT.PresetDefaults.QuestsAreaSize
		FCMQT.SavedVars.QuestsAreaColor = FCMQT.PresetDefaults.QuestsAreaColor
		FCMQT.SavedVars.QuestsLevelOption = FCMQT.PresetDefaults.QuestsLevelOption
		FCMQT.SavedVars.QuestsZoneOption = FCMQT.PresetDefaults.QuestsZoneOption
		FCMQT.SavedVars.QuestsZoneGuildOption = FCMQT.PresetDefaults.QuestsZoneGuildOption
		FCMQT.SavedVars.QuestsZoneMainOption = FCMQT.PresetDefaults.QuestsZoneMainOption
		FCMQT.SavedVars.QuestsZoneCyrodiilOption = FCMQT.PresetDefaults.QuestsZoneCyrodiilOption
		FCMQT.SavedVars.QuestsOptionalOption = FCMQT.PresetDefaults.QuestsOptionalOption
		FCMQT.SavedVars.QuestsUntrackHiddenOption = FCMQT.PresetDefaults.QuestsUntrackHiddenOption
		FCMQT.SavedVars.QuestsNoFocusOption = FCMQT.PresetDefaults.QuestsNoFocusOption
		FCMQT.SavedVars.QuestsNoFocusTransparency = FCMQT.PresetDefaults.QuestsNoFocusTransparency
		FCMQT.SavedVars.TitleOption = FCMQT.PresetDefaults.TitleOption
		FCMQT.SavedVars.Title1Color = FCMQT.PresetDefaults.Title1Color
		FCMQT.SavedVars.Title2Color = FCMQT.PresetDefaults.Title2Color
		FCMQT.SavedVars.Title3Color = FCMQT.PresetDefaults.Title3Color
		FCMQT.SavedVars.Title4Color = FCMQT.PresetDefaults.Title4Color
		FCMQT.SavedVars.Title5Color = FCMQT.PresetDefaults.Title5Color
		FCMQT.SavedVars.Button1 = FCMQT.PresetDefaults.Button1
		FCMQT.SavedVars.Button2 = FCMQT.PresetDefaults.Button2
		FCMQT.SavedVars.Button3 = FCMQT.PresetDefaults.Button3
		FCMQT.SavedVars.Button4 = FCMQT.PresetDefaults.Button4
		FCMQT.SavedVars.Button5 = FCMQT.PresetDefaults.Button5
		
		--for i,v pairs(FCMQT.PresetDefaults)
			--d(v)
		--end
		
	elseif newPreset == "Preset1" then
		FCMQT.SavedVars.BgWidth = FCMQT.preset1.BgWidth
		FCMQT.SavedVars.BgAlpha = FCMQT.preset1.BgAlpha
		FCMQT.SavedVars.BgOption = FCMQT.preset1.BgOption
		FCMQT.SavedVars.BgColor = FCMQT.preset1.BgColor
		FCMQT.SavedVars.ShowJournalInfosOption = FCMQT.preset1.ShowJournalInfosOption
		FCMQT.SavedVars.ShowJournalInfosFont = FCMQT.preset1.ShowJournalInfosFont
		FCMQT.SavedVars.ShowJournalInfosSize = FCMQT.preset1.ShowJournalInfosSize
		FCMQT.SavedVars.ShowJournalInfosStyle = FCMQT.preset1.ShowJournalInfosStyle
		FCMQT.SavedVars.ShowJournalInfosColor = FCMQT.preset1.ShowJournalInfosColor
		FCMQT.SavedVars.TitleSize = FCMQT.preset1.TitleSize
		FCMQT.SavedVars.TitlePadding = FCMQT.preset1.TitlePadding
		FCMQT.SavedVars.TitleFont = FCMQT.preset1.TitleFont
		FCMQT.SavedVars.TitleStyle = FCMQT.preset1.TitleStyle
		FCMQT.SavedVars.TitleColor = FCMQT.preset1.TitleColor
		FCMQT.SavedVars.TextSize = FCMQT.preset1.TextSize
		FCMQT.SavedVars.TextPadding = FCMQT.preset1.TextPadding
		FCMQT.SavedVars.TextFont = FCMQT.preset1.TextFont
		FCMQT.SavedVars.TextStyle = FCMQT.preset1.TextStyle
		FCMQT.SavedVars.TextColor = FCMQT.preset1.TextColor
		FCMQT.SavedVars.TextCompleteColor = FCMQT.preset1.TextCompleteColor
		FCMQT.SavedVars.TextOptionalColor = FCMQT.preset1.TextOptionalColor
		FCMQT.SavedVars.TextOptionalCompleteColor = FCMQT.preset1.TextOptionalCompleteColor
		FCMQT.SavedVars.ClueColor = FCMQT.preset1.ClueColor
		FCMQT.SavedVars.SortOrder = FCMQT.preset1.SortOrder
		FCMQT.SavedVars.NbQuests = FCMQT.preset1.NbQuests
		FCMQT.SavedVars.AutoShare = FCMQT.preset1.AutoShare
		FCMQT.SavedVars.AutoAcceptSharedQuests = FCMQT.preset1.AutoAcceptSharedQuests
		FCMQT.SavedVars.AutoRefuseSharedQuests = FCMQT.preset1.AutoRefuseSharedQuests
		FCMQT.SavedVars.QuestIconOption = FCMQT.preset1.QuestIconOption
		FCMQT.SavedVars.QuestIcon = FCMQT.preset1.QuestIcon
		FCMQT.SavedVars.QuestIconSize = FCMQT.preset1.QuestIconSize
		FCMQT.SavedVars.QuestIconColor = FCMQT.preset1.QuestIconColor
		FCMQT.SavedVars.QuestsAreaOption = FCMQT.preset1.QuestsAreaOption
		FCMQT.SavedVars.QuestsAreaFont = FCMQT.preset1.QuestsAreaFont
		FCMQT.SavedVars.QuestsAreaStyle = FCMQT.preset1.QuestsAreaStyle
		FCMQT.SavedVars.QuestsAreaPadding = FCMQT.preset1.QuestsAreaPadding
		FCMQT.SavedVars.QuestsAreaSize = FCMQT.preset1.QuestsAreaSize
		FCMQT.SavedVars.QuestsAreaColor = FCMQT.preset1.QuestsAreaColor
		FCMQT.SavedVars.QuestsLevelOption = FCMQT.preset1.QuestsLevelOption
		FCMQT.SavedVars.QuestsZoneOption = FCMQT.preset1.QuestsZoneOption
		FCMQT.SavedVars.QuestsZoneGuildOption = FCMQT.preset1.QuestsZoneGuildOption
		FCMQT.SavedVars.QuestsZoneMainOption = FCMQT.preset1.QuestsZoneMainOption
		FCMQT.SavedVars.QuestsZoneCyrodiilOption = FCMQT.preset1.QuestsZoneCyrodiilOption
		FCMQT.SavedVars.QuestsOptionalOption = FCMQT.preset1.QuestsOptionalOption
		FCMQT.SavedVars.QuestsUntrackHiddenOption = FCMQT.preset1.QuestsUntrackHiddenOption
		FCMQT.SavedVars.QuestsNoFocusOption = FCMQT.preset1.QuestsNoFocusOption
		FCMQT.SavedVars.QuestsNoFocusTransparency = FCMQT.preset1.QuestsNoFocusTransparency
		FCMQT.SavedVars.TitleOption = FCMQT.preset1.TitleOption
		FCMQT.SavedVars.Title1Color = FCMQT.preset1.Title1Color
		FCMQT.SavedVars.Title2Color = FCMQT.preset1.Title2Color
		FCMQT.SavedVars.Title3Color = FCMQT.preset1.Title3Color
		FCMQT.SavedVars.Title4Color = FCMQT.preset1.Title4Color
		FCMQT.SavedVars.Title5Color = FCMQT.preset1.Title5Color
		FCMQT.SavedVars.Button1 = FCMQT.preset1.Button1
		FCMQT.SavedVars.Button2 = FCMQT.preset1.Button2
		FCMQT.SavedVars.Button3 = FCMQT.preset1.Button3
		FCMQT.SavedVars.Button4 = FCMQT.preset1.Button4
		FCMQT.SavedVars.Button5 = FCMQT.preset1.Button5
	else
		-- nothing
	end

	if newPreset ~= "Custom" then
		ReloadUI()
	end
end

function FCMQT.CheckFocusedQuest()
	-- Check Focused Quest (check if an ESO element modified the current focused quest)
	local RecordedFocusedQuest = GetTrackedIsAssisted(1,FCMQT.currenticon,0)
	if RecordedFocusedQuest == false then
		for j=1, MAX_JOURNAL_QUESTS do
			if IsValidQuestIndex(j) then
				local CurrentFocusedQuest = GetTrackedIsAssisted(1,j,0)
				if CurrentFocusedQuest == true then
					if j ~= FCMQT.currenticon then
						FCMQT.currenticon = j
						FCMQT.QuestsListUpdate(1)
					end
				end
			end
		end
	end
end

function FCMQT.SetFocusedQuest(qindex)
	-- Update the focused quest if quest is added or updated
	local check = 0
	if qindex ~= nil then
		for i=1,MAX_JOURNAL_QUESTS do
			local valQindex = GetTrackedIsAssisted(1,i,0)
			if valQindex == true then
				if i == qindex then
					check = 1
				else
					SetTrackedIsAssisted(1,false,i,0)
				end
				break;
			end
		end
		if check == 0 then
			SetTrackedIsAssisted(1,true,qindex,0)
			FCMQT.currenticon = qindex
			ZO_QuestTracker["tracker"]:InitialTrackingUpdate()
			ZO_WorldMap_UpdateMap()
		end
		-- Refresh Quests
		FCMQT.QuestsListUpdate(1)
	end
end

function FCMQT.CheckQuestsToHidden(qindex, qname, qtype, qzoneidx, valcheck)
	local QuestTracked = GetIsTracked(1,qindex,0)
	if FCMQT.SavedVars.QuestsUntrackHiddenOption == true then
		if((FCMQT.SavedVars.QuestsZoneGuildOption == false and qtype == 3) or (FCMQT.SavedVars.QuestsZoneMainOption == false and qtype == 2) or (FCMQT.SavedVars.QuestsZoneCyrodiilOption == false and qzoneidx == FCMQT.CyrodiilNumZoneIndex)) then
				-- Untrack Hidden Quests
				if QuestTracked == true then
					valcheck = 1
					SetTracked(1,false,qindex,0)
				end
		else
			if QuestTracked == false then
				valcheck = 1
				SetTracked(1,true,qindex,0)
			end			
		end
	else
		-- Track all others
		if QuestTracked == false then
			valcheck = 1
			SetTracked(1,true,qindex,0)
		end
	end
	return valcheck
end

function FCMQT.SwitchDisplayMode()
	FCMQT.SavedVars.QuestsZoneOption = not FCMQT.SavedVars.QuestsZoneOption
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.CheckRemoveQuestBox(qindex, qname)
	if not FCMQT.PlayerRemoveQuestBox then
		local WM = WINDOW_MANAGER
		local LMP = LibStub("LibMediaProvider-1.0")
		FCMQT.MainRemoveQuestBox = WM:CreateTopLevelWindow(nil)
		FCMQT.MainRemoveQuestBox:SetAnchor(CENTER,GuiRoot,CENTER,0,-100)
		FCMQT.MainRemoveQuestBox:SetDimensions(400,100)
		FCMQT.MainRemoveQuestBox:SetMovable(false)
		FCMQT.MainRemoveQuestBox:SetDrawLayer(2)
		
		FCMQT.PlayerRemoveQuestBox = WM:CreateControl(nil, FCMQT.MainRemoveQuestBox, CT_STATUSBAR)
		FCMQT.PlayerRemoveQuestBox:SetAnchorFill()
		FCMQT.PlayerRemoveQuestBox:SetDrawLayer(2)
		FCMQT.PlayerRemoveQuestBox:SetColor(0,0,0,0.4)
		
		FCMQT.PlayerRemoveLabelQuestBox = WM:CreateControl(nil, FCMQT.PlayerRemoveQuestBox, CT_LABEL)
		FCMQT.PlayerRemoveLabelQuestBox:SetAnchor(CENTER, FCMQT.MainRemoveQuestBox, CENTER, 0, -25)
		FCMQT.PlayerRemoveLabelQuestBox:SetDrawLayer(3)
		FCMQT.PlayerRemoveLabelQuestBox:SetFont(("%s|%s|%s"):format(LMP:Fetch('font', FCMQT.SavedVars.QuestsAreaFont), 18, FCMQT.SavedVars.QuestsAreaStyle))
		FCMQT.PlayerRemoveLabelQuestBox:SetColor(FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a)
		FCMQT.PlayerRemoveLabelQuestBox:SetText("Do you really want to remove this quest ?")
		
		FCMQT.PlayerRemoveLabelQuestBox2 = WM:CreateControl(nil, FCMQT.PlayerRemoveQuestBox, CT_LABEL)
		FCMQT.PlayerRemoveLabelQuestBox2:SetAnchor(CENTER, FCMQT.MainRemoveQuestBox, CENTER, 0, 10)
		FCMQT.PlayerRemoveLabelQuestBox2:SetDrawLayer(3)
		FCMQT.PlayerRemoveLabelQuestBox2:SetFont(("%s|%s|%s"):format(LMP:Fetch('font', FCMQT.SavedVars.QuestsAreaFont), 18, FCMQT.SavedVars.QuestsAreaStyle))
		FCMQT.PlayerRemoveLabelQuestBox2:SetColor(FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a)

		FCMQT.RemoveQuestBoxYes = WM:CreateControl(nil, FCMQT.PlayerRemoveQuestBox, CT_LABEL)
		FCMQT.RemoveQuestBoxYes:SetAnchor(TOPLEFT, FCMQT.MainRemoveQuestBox, BOTTOMLEFT, 10, 0)
		FCMQT.RemoveQuestBoxYes:SetDrawLayer(3)
		FCMQT.RemoveQuestBoxYes:SetFont(("%s|%s|%s"):format(LMP:Fetch('font', FCMQT.SavedVars.QuestsAreaFont), FCMQT.SavedVars.QuestsAreaSize, FCMQT.SavedVars.QuestsAreaStyle))
		FCMQT.RemoveQuestBoxYes:SetText("Yes")
		FCMQT.RemoveQuestBoxYes:SetColor(FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a)
		FCMQT.RemoveQuestBoxYes:SetMouseEnabled(true)
		FCMQT.RemoveQuestBoxYes:SetHandler("OnMouseEnter", function(self) self:SetColor(1,1,1,1)	end)
		FCMQT.RemoveQuestBoxYes:SetHandler("OnMouseExit", function(self) self:SetColor(FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a) end)
		
		FCMQT.RemoveQuestBoxNo = WM:CreateControl(nil, FCMQT.PlayerRemoveQuestBox, CT_LABEL)
		FCMQT.RemoveQuestBoxNo:SetAnchor(TOPRIGHT, FCMQT.MainRemoveQuestBox, BOTTOMRIGHT, -10, 0)
		FCMQT.RemoveQuestBoxNo:SetDrawLayer(3)
		FCMQT.RemoveQuestBoxNo:SetFont(("%s|%s|%s"):format(LMP:Fetch('font', FCMQT.SavedVars.QuestsAreaFont), FCMQT.SavedVars.QuestsAreaSize, FCMQT.SavedVars.QuestsAreaStyle))
		FCMQT.RemoveQuestBoxNo:SetText("No")
		FCMQT.RemoveQuestBoxNo:SetColor(FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a)
		FCMQT.RemoveQuestBoxNo:SetMouseEnabled(true)
		FCMQT.RemoveQuestBoxNo:SetHandler("OnMouseEnter", function(self) self:SetColor(1,1,1,1) end)
		FCMQT.RemoveQuestBoxNo:SetHandler("OnMouseExit", function(self) self:SetColor(FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a) end)
		FCMQT.RemoveQuestBoxNo:SetHandler("OnMouseDown", function(self) FCMQT.MainRemoveQuestBox:SetHidden(true) end)
	else
		FCMQT.MainRemoveQuestBox:SetHidden(false)
	end
	FCMQT.PlayerRemoveLabelQuestBox2:SetText(qname)
	FCMQT.RemoveQuestBoxYes:SetHandler("OnMouseDown", function()
			AbandonQuest(qindex)
			d(FCMQT.mylanguage.lang_console_abandon.." : "..qname)
			FCMQT.MainRemoveQuestBox:SetHidden(true)			
	end)
	
end

function FCMQT.ClearBoxs(clearid)
	local clearidx = clearid
	while FCMQT.textbox[clearidx] do
		FCMQT.textbox[clearidx]:SetText("")
		FCMQT.textbox[clearidx]:SetHandler("OnMouseDown", nil)
		FCMQT.textbox[clearidx]:SetMouseEnabled(false)
		FCMQT.icon[clearidx]:SetHidden(true)
		clearidx = clearidx + 1
	end
end

-- For KeyBinding
function FCMQT.ToggleHidden()
	FCMQT.bg:ToggleHidden()
end

-- For console
function FCMQT.CMD_DEBUG()
	if FCMQT.DEBUG == 0 then
		d("FCMQT Debug : On")
		FCMQT.DEBUG = 1
	else
		d("FCMQT Debug : Off")
		FCMQT.DEBUG = 0
	end
end

function FCMQT.CMD_DEBUGUI()
	if FCMQT.DEBUGUI == 0 then
		d("FCMQT DebugUI : On")
		FCMQT.DEBUGUI = 1
	else
		d("FCMQT DebugUI : Off")
		FCMQT.DEBUGUI = 0
	end
end

-- Background
-- Transparency
function FCMQT.GetBgAlpha()
	return FCMQT.SavedVars.BgAlpha
end
function FCMQT.SetBgAlpha(newAlpha)
	FCMQT.SavedVars.BgAlpha = newAlpha
	FCMQT.main:SetAlpha(newAlpha/100)
	FCMQT.SavedVars.Preset = "Custom"
end

-- Width
function FCMQT.GetBgWidth()
	return FCMQT.SavedVars.BgWidth
end
function FCMQT.SetBgWidth(newWidth)
	FCMQT.SavedVars.BgWidth = newWidth
	FCMQT.bg:SetDimensionConstraints(newWidth,-1,newWidth,-1)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

-- Position
function FCMQT.GetPositionLockOption()
	return FCMQT.SavedVars.PositionLockOption
end
function FCMQT.SetPositionLockOption(newOpt)
	FCMQT.SavedVars.PositionLockOption = newOpt
	if newOpt == true then
		FCMQT.main:SetMouseEnabled(false)
		FCMQT.main:SetMovable(false)
	else
		FCMQT.main:SetMouseEnabled(true)
		FCMQT.main:SetMovable(true)
	end
	FCMQT.QuestsListUpdate(1)
end

-- JournalInfos
function FCMQT.GetShowJournalInfosOption()
	return FCMQT.SavedVars.ShowJournalInfosOption
end
function FCMQT.SetShowJournalInfosOption(newOpt)
	FCMQT.SavedVars.ShowJournalInfosOption = newOpt
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetShowJournalInfosFont()
	return FCMQT.SavedVars.ShowJournalInfosFont
end
function FCMQT.SetShowJournalInfosFont(newFont)
	FCMQT.SavedVars.ShowJournalInfosFont = newFont
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetShowJournalInfosStyle()
	return FCMQT.SavedVars.ShowJournalInfosStyle
end
function FCMQT.SetShowJournalInfosStyle(newStyle)
	FCMQT.SavedVars.ShowJournalInfosStyle = newStyle
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetShowJournalInfosSize()
	return FCMQT.SavedVars.ShowJournalInfosSize
end
function FCMQT.SetShowJournalInfosSize(newSize)
	FCMQT.SavedVars.ShowJournalInfosSize = newSize
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetShowJournalInfosColor()
	return FCMQT.SavedVars.ShowJournalInfosColor.r, FCMQT.SavedVars.ShowJournalInfosColor.g, FCMQT.SavedVars.ShowJournalInfosColor.b, FCMQT.SavedVars.ShowJournalInfosColor.a
end
function FCMQT.SetShowJournalInfosColor(r,g,b,a)
	FCMQT.SavedVars.ShowJournalInfosColor.r = r
	FCMQT.SavedVars.ShowJournalInfosColor.g = g
	FCMQT.SavedVars.ShowJournalInfosColor.b = b
	FCMQT.SavedVars.ShowJournalInfosColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetLanguage()
	return FCMQT.SavedVars.Language
end

function FCMQT.SetLanguage(newLang)
	FCMQT.SavedVars.Language = newLang
	ReloadUI()
end

-- Color
function FCMQT.GetBgOption()
	return FCMQT.SavedVars.BgOption
end
function FCMQT.SetBgOption(newOpt)
	FCMQT.SavedVars.BgOption = newOpt
	if newOpt == true then
		FCMQT.bg:SetColor(FCMQT.SavedVars.BgColor.r,FCMQT.SavedVars.BgColor.g,FCMQT.SavedVars.BgColor.b,FCMQT.SavedVars.BgColor.a)
	--elseif FCMQT.SavedVars.BgGradientOption == true then
		-- FCMQT.bg:SetGradientColors(FCMQT.SavedVars.BgColor.r,FCMQT.SavedVars.BgColor.g,FCMQT.SavedVars.BgColor.b,FCMQT.SavedVars.BgColor.a,0,0,0,0)
	else
		FCMQT.bg:SetColor(0,0,0,0)
	end
	FCMQT.SavedVars.Preset = "Custom"
end

function FCMQT.GetBgColor()
	return FCMQT.SavedVars.BgColor.r, FCMQT.SavedVars.BgColor.g, FCMQT.SavedVars.BgColor.b, FCMQT.SavedVars.BgColor.a
end
function FCMQT.SetBgColor(r,g,b,a)
	FCMQT.SavedVars.BgColor.r = r
	FCMQT.SavedVars.BgColor.g = g
	FCMQT.SavedVars.BgColor.b = b
	FCMQT.SavedVars.BgColor.a = a
	FCMQT.bg:SetColor(r,g,b,a)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetDirectionBox()
	return FCMQT.SavedVars.DirectionBox
end
function FCMQT.SetDirectionBox(newDirection)
	FCMQT.SavedVars.DirectionBox = newDirection
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

-- Quests
function FCMQT.GetSortQuests()
	return FCMQT.SavedVars.SortOrder
end
function FCMQT.SetSortQuests(newOrder)
	FCMQT.SavedVars.SortOrder = newOrder
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetNbQuests() 
	return FCMQT.SavedVars.NbQuests
end
function FCMQT.SetNbQuests(newNbQuests)
	FCMQT.SavedVars.NbQuests = newNbQuests
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetAutoShareOption()
	return FCMQT.SavedVars.AutoShare
end
function FCMQT.SetAutoShareOption(newOpt)
	FCMQT.SavedVars.AutoShare = newOpt
end

function FCMQT.GetAutoAcceptSharedQuestsOption()
	return FCMQT.SavedVars.AutoAcceptSharedQuests
end
function FCMQT.SetAutoAcceptSharedQuestsOption(newOpt)
	FCMQT.SavedVars.AutoAcceptSharedQuests = newOpt
end

function FCMQT.GetAutoRefuseSharedQuestsOption()
	return FCMQT.SavedVars.AutoRefuseSharedQuests
end
function FCMQT.SetAutoRefuseSharedQuestsOption(newOpt)
	FCMQT.SavedVars.AutoRefuseSharedQuests = newOpt
end

--AcceptOfferedQuest()
--AcceptSharedQuest()
--DeclineSharedQuest()

function FCMQT.GetBufferRefreshTime()
	return FCMQT.SavedVars.BufferRefreshTime
end
function FCMQT.SetBufferRefreshTime(newTimer)
	FCMQT.SavedVars.BufferRefreshTime = newTimer
end

function FCMQT.GetQuestIconOption()
	return FCMQT.SavedVars.QuestIconOption
end
function FCMQT.SetQuestIconOption(newOpt)
	FCMQT.SavedVars.QuestIconOption = newOpt
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestIcon()
	return FCMQT.SavedVars.QuestIcon
end
function FCMQT.SetQuestIcon(newFont)
	FCMQT.SavedVars.QuestIcon = newFont
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestIconSize()
	return FCMQT.SavedVars.QuestIconSize
end
function FCMQT.SetQuestIconSize(newSize)
	FCMQT.SavedVars.QuestIconSize = newSize
	local marker = 1
	while FCMQT.icon[marker] do
		FCMQT.icon[marker]:SetDimensions(newSize, newSize)
		marker = marker + 1
	end
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestIconColor()
	return FCMQT.SavedVars.QuestIconColor.r, FCMQT.SavedVars.QuestIconColor.g, FCMQT.SavedVars.QuestIconColor.b, FCMQT.SavedVars.QuestIconColor.a
end
function FCMQT.SetQuestIconColor(r,g,b,a)
	FCMQT.SavedVars.QuestIconColor.r = r
	FCMQT.SavedVars.QuestIconColor.g = g
	FCMQT.SavedVars.QuestIconColor.b = b
	FCMQT.SavedVars.QuestIconColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsAreaOption()
	return FCMQT.SavedVars.QuestsAreaOption
end
function FCMQT.SetQuestsAreaOption(newOpt)
	FCMQT.SavedVars.QuestsAreaOption = newOpt
	FCMQT.SavedVars.QuestsFilter = {}
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsAreaFont()
	return FCMQT.SavedVars.QuestsAreaFont
end
function FCMQT.SetQuestsAreaFont(newFont)
	FCMQT.SavedVars.QuestsAreaFont = newFont
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsAreaStyle()
	return FCMQT.SavedVars.QuestsAreaStyle
end
function FCMQT.SetQuestsAreaStyle(newStyle)
	FCMQT.SavedVars.QuestsAreaStyle = newStyle
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsAreaSize()
	return FCMQT.SavedVars.QuestsAreaSize
end
function FCMQT.SetQuestsAreaSize(newSize)
	FCMQT.SavedVars.QuestsAreaSize = newSize
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsAreaPadding()
	return FCMQT.SavedVars.QuestsAreaPadding
end
function FCMQT.SetQuestsAreaPadding(newSize)
	FCMQT.SavedVars.QuestsAreaPadding = newSize
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsAreaColor()
	return FCMQT.SavedVars.QuestsAreaColor.r, FCMQT.SavedVars.QuestsAreaColor.g, FCMQT.SavedVars.QuestsAreaColor.b, FCMQT.SavedVars.QuestsAreaColor.a
end
function FCMQT.SetQuestsAreaColor(r,g,b,a)
	FCMQT.SavedVars.QuestsAreaColor.r = r
	FCMQT.SavedVars.QuestsAreaColor.g = g
	FCMQT.SavedVars.QuestsAreaColor.b = b
	FCMQT.SavedVars.QuestsAreaColor.a = a
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsLevelOption()
	return FCMQT.SavedVars.QuestsLevelOption
end
function FCMQT.SetQuestsLevelOption(newOpt)
	FCMQT.SavedVars.QuestsLevelOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsHideZoneOption()
	return FCMQT.SavedVars.QuestsHideZoneOption
end
function FCMQT.SetQuestsHideZoneOption(newOpt)
	FCMQT.SavedVars.QuestsHideZoneOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsZoneOption()
	return FCMQT.SavedVars.QuestsZoneOption
end
function FCMQT.SetQuestsZoneOption(newOpt)
	FCMQT.SavedVars.QuestsZoneOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsZoneGuildOption()
	return FCMQT.SavedVars.QuestsZoneGuildOption
end
function FCMQT.SetQuestsZoneGuildOption(newOpt)
	FCMQT.SavedVars.QuestsZoneGuildOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsZoneMainOption()
	return FCMQT.SavedVars.QuestsZoneMainOption
end
function FCMQT.SetQuestsZoneMainOption(newOpt)
	FCMQT.SavedVars.QuestsZoneMainOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsZoneCyrodiilOption()
	return FCMQT.SavedVars.QuestsZoneCyrodiilOption
end
function FCMQT.SetQuestsZoneCyrodiilOption(newOpt)
	FCMQT.SavedVars.QuestsZoneCyrodiilOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsOptionalOption()
	return FCMQT.SavedVars.QuestsOptionalOption
end
function FCMQT.SetQuestsOptionalOption(newOpt)
	FCMQT.SavedVars.QuestsOptionalOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsUntrackHiddenOption()
	return FCMQT.SavedVars.QuestsUntrackHiddenOption
end
function FCMQT.SetQuestsUntrackHiddenOption(newOpt)
	FCMQT.SavedVars.QuestsUntrackHiddenOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsNoFocusOption()
	return FCMQT.SavedVars.QuestsNoFocusOption
end
function FCMQT.SetQuestsNoFocusOption(newOpt)
	FCMQT.SavedVars.QuestsNoFocusOption = newOpt
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetQuestsNoFocusTransparency()
	return FCMQT.SavedVars.QuestsNoFocusTransparency
end
function FCMQT.SetQuestsNoFocusTransparency(newAlpha)
	FCMQT.SavedVars.QuestsNoFocusTransparency = newAlpha
	FCMQT.QuestsListUpdate(1)
end

-- Title Custom
function FCMQT.GetTitleFont()
	return FCMQT.SavedVars.TitleFont
end
function FCMQT.SetTitleFont(newFont)
	FCMQT.SavedVars.TitleFont = newFont
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitleStyle()
	return FCMQT.SavedVars.TitleStyle
end
function FCMQT.SetTitleStyle(newStyle)
	FCMQT.SavedVars.TitleStyle = newStyle
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitleSize()
	return FCMQT.SavedVars.TitleSize
end
function FCMQT.SetTitleSize(newSize)
	FCMQT.SavedVars.TitleSize = newSize
	FCMQT.SavedVars.Preset = "Custom"	
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitlePadding()
	return FCMQT.SavedVars.TitlePadding
end
function FCMQT.SetTitlePadding(newSize)
	FCMQT.SavedVars.TitlePadding = newSize
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

-- Default Title color
function FCMQT.GetTitleColor()
	return FCMQT.SavedVars.TitleColor.r, FCMQT.SavedVars.TitleColor.g, FCMQT.SavedVars.TitleColor.b, FCMQT.SavedVars.TitleColor.a
end
function FCMQT.SetTitleColor(r,g,b,a)
	FCMQT.SavedVars.TitleColor.r = r
	FCMQT.SavedVars.TitleColor.g = g
	FCMQT.SavedVars.TitleColor.b = b
	FCMQT.SavedVars.TitleColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

-- Custom color level
function FCMQT.GetTitleOption()
	return FCMQT.SavedVars.TitleOption
end
function FCMQT.SetTitleOption(newOpt)
	FCMQT.SavedVars.TitleOption = newOpt
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitle1Color()
	return FCMQT.SavedVars.Title1Color.r, FCMQT.SavedVars.Title1Color.g, FCMQT.SavedVars.Title1Color.b, FCMQT.SavedVars.Title1Color.a
end
function FCMQT.SetTitle1Color(r,g,b,a)
	FCMQT.SavedVars.Title1Color.r = r
	FCMQT.SavedVars.Title1Color.g = g
	FCMQT.SavedVars.Title1Color.b = b
	FCMQT.SavedVars.Title1Color.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitle2Color()
	return FCMQT.SavedVars.Title2Color.r, FCMQT.SavedVars.Title2Color.g, FCMQT.SavedVars.Title2Color.b, FCMQT.SavedVars.Title2Color.a
end
function FCMQT.SetTitle2Color(r,g,b,a)
	FCMQT.SavedVars.Title2Color.r = r
	FCMQT.SavedVars.Title2Color.g = g
	FCMQT.SavedVars.Title2Color.b = b
	FCMQT.SavedVars.Title2Color.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitle3Color()
	return FCMQT.SavedVars.Title3Color.r, FCMQT.SavedVars.Title3Color.g, FCMQT.SavedVars.Title3Color.b, FCMQT.SavedVars.Title3Color.a
end
function FCMQT.SetTitle3Color(r,g,b,a)
	FCMQT.SavedVars.Title3Color.r = r
	FCMQT.SavedVars.Title3Color.g = g
	FCMQT.SavedVars.Title3Color.b = b
	FCMQT.SavedVars.Title3Color.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitle4Color()
	return FCMQT.SavedVars.Title4Color.r, FCMQT.SavedVars.Title4Color.g, FCMQT.SavedVars.Title4Color.b, FCMQT.SavedVars.Title4Color.a
end
function FCMQT.SetTitle4Color(r,g,b,a)
	FCMQT.SavedVars.Title4Color.r = r
	FCMQT.SavedVars.Title4Color.g = g
	FCMQT.SavedVars.Title4Color.b = b
	FCMQT.SavedVars.Title4Color.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTitle5Color()
	return FCMQT.SavedVars.Title5Color.r, FCMQT.SavedVars.Title5Color.g, FCMQT.SavedVars.Title5Color.b, FCMQT.SavedVars.Title5Color.a
end
function FCMQT.SetTitle5Color(r,g,b,a)
	FCMQT.SavedVars.Title5Color.r = r
	FCMQT.SavedVars.Title5Color.g = g
	FCMQT.SavedVars.Title5Color.b = b
	FCMQT.SavedVars.Title5Color.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

-- Objectives Custom
function FCMQT.GetTextFont()
	return FCMQT.SavedVars.TextFont
end
function FCMQT.SetTextFont(newFont)
	FCMQT.SavedVars.TextFont = newFont
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextStyle()
	return FCMQT.SavedVars.TextStyle
end
function FCMQT.SetTextStyle(newStyle)
	FCMQT.SavedVars.TextStyle = newStyle
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextSize()
	return FCMQT.SavedVars.TextSize
end
function FCMQT.SetTextSize(newSize)
	FCMQT.SavedVars.TextSize = newSize
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextPadding()
	return FCMQT.SavedVars.TextPadding
end
function FCMQT.SetTextPadding(newSize)
	FCMQT.SavedVars.TextPadding = newSize
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextColor()
	return FCMQT.SavedVars.TextColor.r, FCMQT.SavedVars.TextColor.g, FCMQT.SavedVars.TextColor.b, FCMQT.SavedVars.TextColor.a
end
function FCMQT.SetTextColor(r,g,b,a)
	FCMQT.SavedVars.TextColor.r = r
	FCMQT.SavedVars.TextColor.g = g
	FCMQT.SavedVars.TextColor.b = b
	FCMQT.SavedVars.TextColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextCompleteColor()
	return 	FCMQT.SavedVars.TextCompleteColor.r, FCMQT.SavedVars.TextCompleteColor.g, FCMQT.SavedVars.TextCompleteColor.b, FCMQT.SavedVars.TextCompleteColor.a
end
function FCMQT.SetTextCompleteColor(r,g,b,a)
	FCMQT.SavedVars.TextCompleteColor.r = r
	FCMQT.SavedVars.TextCompleteColor.g = g
	FCMQT.SavedVars.TextCompleteColor.b = b
	FCMQT.SavedVars.TextCompleteColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextOptionalColor()
	return FCMQT.SavedVars.TextOptionalColor.r, FCMQT.SavedVars.TextOptionalColor.g, FCMQT.SavedVars.TextOptionalColor.b, FCMQT.SavedVars.TextOptionalColor.a
end
function FCMQT.SetTextOptionalColor(r,g,b,a)
	FCMQT.SavedVars.TextOptionalColor.r = r
	FCMQT.SavedVars.TextOptionalColor.g = g
	FCMQT.SavedVars.TextOptionalColor.b = b
	FCMQT.SavedVars.TextOptionalColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

function FCMQT.GetTextOptionalCompleteColor()
	return 	FCMQT.SavedVars.TextOptionalCompleteColor.r, FCMQT.SavedVars.TextOptionalCompleteColor.g, FCMQT.SavedVars.TextOptionalCompleteColor.b, FCMQT.SavedVars.TextOptionalCompleteColor.a
end
function FCMQT.SetTextOptionalCompleteColor(r,g,b,a)
	FCMQT.SavedVars.TextOptionalCompleteColor.r = r
	FCMQT.SavedVars.TextOptionalCompleteColor.g = g
	FCMQT.SavedVars.TextOptionalCompleteColor.b = b
	FCMQT.SavedVars.TextOptionalCompleteColor.a = a
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.QuestsListUpdate(1)
end

-- Mouse Controls
function FCMQT.GetButton1()
	return FCMQT.SavedVars.Button1
end
function FCMQT.SetButton1(NewVal)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.SavedVars.Button1 = NewVal
end

function FCMQT.GetButton2()
	return FCMQT.SavedVars.Button2
end
function FCMQT.SetButton2(NewVal)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.SavedVars.Button2 = NewVal
end

function FCMQT.GetButton3()
	return FCMQT.SavedVars.Button3
end
function FCMQT.SetButton3(NewVal)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.SavedVars.Button3 = NewVal
end

function FCMQT.GetButton4()
	return FCMQT.SavedVars.Button4
end
function FCMQT.SetButton4(NewVal)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.SavedVars.Button4 = NewVal
end

function FCMQT.GetButton5()
	return FCMQT.SavedVars.Button5
end
function FCMQT.SetButton5(NewVal)
	FCMQT.SavedVars.Preset = "Custom"
	FCMQT.SavedVars.Button5 = NewVal
end

function FCMQT.MouseTitleController(button, qzone)
	if button == 1 then
		if not FCMQT.filterzone then FCMQT.filterzone = {} end
		local tmpfilterzone = {}
		local tmp = 0
		if FCMQT.filterzone[1] then
			local i=1
			while FCMQT.filterzone[i] do
				if FCMQT.filterzone[i] == qzone then
					tmp = 1
				else
					table.insert(tmpfilterzone, FCMQT.filterzone[i])
				end
				i = i+1
			end
			if tmp ~= 1 then
				table.insert(tmpfilterzone, qzone)
			end
		else
			table.insert(tmpfilterzone, qzone)
		end
		FCMQT.filterzone = tmpfilterzone
		FCMQT.SavedVars.QuestsFilter = tmpfilterzone
		FCMQT.QuestsListUpdate(1)
	end
end

function FCMQT.MouseController(button, qindex, qname)
	local valaction = "None"
	if button == 1 then
		valaction = FCMQT.GetButton1()
	elseif button == 2 then
		valaction = FCMQT.GetButton2()
	elseif button == 3 then
		valaction = FCMQT.GetButton3()
	elseif button == 4 then
		valaction = FCMQT.GetButton4()
	elseif button == 5 then
		valaction = FCMQT.GetButton5()
	end
	if (valaction == "Change Assisted Quest") then
		FCMQT.SetFocusedQuest(qindex)
	elseif valaction == "Share a Quest" then
		if GetIsQuestSharable(qindex) then
			ShareQuest(qindex)
			d(FCMQT.mylanguage.lang_console_share.." : "..qname)
		else
			d(FCMQT.mylanguage.lang_console_noshare.." : "..qname)
		end
	elseif valaction == "Filter by Current Zone" then
		FCMQT.SwitchDisplayMode()
	elseif valaction == "Remove a Quest" then
		FCMQT.CheckRemoveQuestBox(qindex, qname)
	elseif valaction == "Show on Map" then
		ZO_WorldMap_ShowQuestOnMap(qindex)
	end	
end

-- Tests Only
function FCMQT.CheckEvent(eventCode)
	d(eventCode)
end