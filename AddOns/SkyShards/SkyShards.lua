-------------------------------------------------------------------------------
-- SkyShards v2.2.2
-------------------------------------------------------------------------------
--
-- Copyright (c) 2014, 2015 Ales Machat (Garkin)
--
-- Permission is hereby granted, free of charge, to any person
-- obtaining a copy of this software and associated documentation
-- files (the "Software"), to deal in the Software without
-- restriction, including without limitation the rights to use,
-- copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following
-- conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.
--
-------------------------------------------------------------------------------
--
-- DISCLAIMER:
--
-- This Add-on is not created by, affiliated with or sponsored by ZeniMax
-- Media Inc. or its affiliates. The Elder Scrolls® and related logos are
-- registered trademarks or trademarks of ZeniMax Media Inc. in the United
-- States and/or other countries. All rights reserved.
--
-- You can read the full terms at:
-- https://account.elderscrollsonline.com/add-on-terms
--
-------------------------------------------------------------------------------

--Libraries--------------------------------------------------------------------
local LAM = LibStub("LibAddonMenu-2.0")
local LMP = LibStub("LibMapPins-1.0")

--Local constants -------------------------------------------------------------
local ADDON_VERSION = "2.2.2"
local PINS_UNKNOWN = "SkySMapPin_unknown"
local PINS_COLLECTED = "SkySMapPin_collected"
local PINS_COMPASS = "SkySCompassPin_unknown"
local INFORMATION_TOOLTIP

--Local variables -------------------------------------------------------------
local updatePins = {}
local updating = false
local savedVariables
local defaults = {			-- default settings for saved variables
	compassMaxDistance = 0.05,
	pinTexture = {
		type = 1,
		size = 38,
		level = 40,
	},
	filters = {
		[PINS_COMPASS] = true,
		[PINS_UNKNOWN] = true,
		[PINS_COLLECTED] = false,
	},
}

-- Local functions ------------------------------------------------------------
local function MyPrint(...)
	CHAT_SYSTEM:AddMessage(...)
end

-- Pins -----------------------------------------------------------------------
local pinTexturesList = {
	[1] = "Default icons (Garkin)",
	[2] = "Alternative icons (Garkin)",
	[3] = "Esohead's icons (Mitsarugi)",
	[4] = "Glowing icons (Rushmik)",
	[5] = "Realistic icons (Heidra)",
}

local pinTextures = {
	unknown = {
		[1] = "SkyShards/Icons/Skyshard-unknown.dds",
		[2] = "SkyShards/Icons/Skyshard-unknown-alternative.dds",
		[3] = "SkyShards/Icons/Skyshard-unknown-Esohead.dds",
		[4] = "SkyShards/Icons/Skyshard-unknown-Rushmik.dds",
		[5] = "SkyShards/Icons/Skyshard-unknown-Heidra.dds",
	},
	collected = {
		[1] = "SkyShards/Icons/Skyshard-collected.dds",
		[2] = "SkyShards/Icons/Skyshard-collected-alternative.dds",
		[3] = "SkyShards/Icons/Skyshard-collected-Esohead.dds",
		[4] = "SkyShards/Icons/Skyshard-collected-Rushmik.dds",
		[5] = "SkyShards/Icons/Skyshard-collected-Heidra.dds",
	},
}

--tooltip creator
local pinTooltipCreator = {}
pinTooltipCreator.tooltip = 1 --TOOLTIP_MODE.INFORMATION
pinTooltipCreator.creator = function(pin)

	local _, pinTag = pin:GetPinTypeAndTag()
	local name = GetAchievementInfo(pinTag[3])
	local description, numCompleted = GetAchievementCriterion(pinTag[3], pinTag[4])
	local info = {}

	if pinTag[5] ~= nil then
		table.insert(info, "[" .. GetString("SKYS_MOREINFO", pinTag[5]) .. "]")
	end
	if numCompleted == 1 then
		table.insert(info, "[" .. GetString(SKYS_KNOWN) .. "]")
	end

	if IsInGamepadPreferredMode() then
		INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, zo_strformat("<<1>>", name), INFORMATION_TOOLTIP.tooltip:GetStyle("mapTitle"))
		INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, icon, zo_strformat("(<<1>>) <<2>>", pinTag[4], description), {fontSize = 27, fontColorField = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3})
		if info[1] then
			INFORMATION_TOOLTIP:LayoutIconStringLine(INFORMATION_TOOLTIP.tooltip, nil, table.concat(info, " / "), INFORMATION_TOOLTIP.tooltip:GetStyle("worldMapTooltip"))
		end
	else
		INFORMATION_TOOLTIP:AddLine(zo_strformat("<<1>>", name), "ZoFontGameOutline", ZO_SELECTED_TEXT:UnpackRGB())
		ZO_Tooltip_AddDivider(INFORMATION_TOOLTIP)
		INFORMATION_TOOLTIP:AddLine(zo_strformat("(<<1>>) <<2>>", pinTag[4], description), "", ZO_HIGHLIGHT_TEXT:UnpackRGB())
		if info[1] then
			INFORMATION_TOOLTIP:AddLine(table.concat(info, " / "), "", ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB())
		end
	end

end

local function CompassCallback()
	if GetMapType() <= MAPTYPE_ZONE and savedVariables.filters[PINS_COMPASS] then
		local zone, subzone = LMP:GetZoneAndSubzone()
		local skyshards = SkyShards_GetLocalData(zone, subzone)
		if skyshards then
			for _, pinData in ipairs(skyshards) do
				local _, numCompleted = GetAchievementCriterion(pinData[3], pinData[4])
				if numCompleted == 0 then
					COMPASS_PINS.pinManager:CreatePin(PINS_COMPASS, pinData, pinData[1], pinData[2])
				end
			end
		end
	end
end

local function MapCallback_unknown()
	if GetMapType() <= MAPTYPE_ZONE and LMP:IsEnabled(PINS_UNKNOWN) then
		local zone, subzone = LMP:GetZoneAndSubzone()
		local skyshards = SkyShards_GetLocalData(zone, subzone)
		if skyshards then
			for _, pinData in ipairs(skyshards) do
				local _, numCompleted = GetAchievementCriterion(pinData[3], pinData[4])
				if numCompleted == 0 and LMP:IsEnabled(PINS_UNKNOWN) then
					LMP:CreatePin(PINS_UNKNOWN, pinData, pinData[1], pinData[2])
				end
			end
		end
	end
end

local function MapCallback_collected()
	if GetMapType() <= MAPTYPE_ZONE and LMP:IsEnabled(PINS_UNKNOWN) then
		local zone, subzone = LMP:GetZoneAndSubzone()
		local skyshards = SkyShards_GetLocalData(zone, subzone)
		if skyshards then
			for _, pinData in ipairs(skyshards) do
				local _, numCompleted = GetAchievementCriterion(pinData[3], pinData[4])
				if numCompleted == 1 and LMP:IsEnabled(PINS_COLLECTED) then
					LMP:CreatePin(PINS_COLLECTED, pinData, pinData[1], pinData[2])
				end
			end
		end
	end
end

local function CreatePins()
	local zone, subzone = LMP:GetZoneAndSubzone()
	local skyshards = SkyShards_GetLocalData(zone, subzone)

	if skyshards ~= nil then
		for _, pinData in ipairs(skyshards) do
			local _, numCompleted = GetAchievementCriterion(pinData[3], pinData[4])
			if numCompleted == 1 and updatePins[PINS_COLLECTED] and LMP:IsEnabled(PINS_COLLECTED) then
				LMP:CreatePin(PINS_COLLECTED, pinData, pinData[1], pinData[2])
			elseif numCompleted == 0 then
				if updatePins[PINS_UNKNOWN] and LMP:IsEnabled(PINS_UNKNOWN) then
					LMP:CreatePin(PINS_UNKNOWN, pinData, pinData[1], pinData[2])
				end
				if updatePins[PINS_COMPASS] and savedVariables.filters[PINS_COMPASS] then
					COMPASS_PINS.pinManager:CreatePin(PINS_COMPASS, pinData, pinData[1], pinData[2])
				end
			end
		end
	end

	updatePins = {}
	updating = false
end

local function QueueCreatePins(pinType)
	updatePins[pinType] = true

	if not updating then
		updating = true
		if IsPlayerActivated() then
			if LMP.AUI.IsMinimapEnabled() then -- "Cleaner code" is in Destinations addon, but even if adding all checks this addon does the result is same. Duplicates are created with AUI
				zo_callLater(CreatePins, 50) -- Didn't find anything proper than this. If other MiniMap addons are loaded, It will fail and create duplicates
			else
				CreatePins() -- Normal way. AUI will fire its refresh after this code has run so it will create duplicates if left "as is".
			end
		else
			EVENT_MANAGER:RegisterForEvent("SkyShards_PinUpdate", EVENT_PLAYER_ACTIVATED,
				function(event)
					EVENT_MANAGER:UnregisterForEvent("SkyShards_PinUpdate", event)
					CreatePins()
				end)
		end
	end
end

local function MapCallback_unknown()
	if not LMP:IsEnabled(PINS_UNKNOWN) or (GetMapType() > MAPTYPE_ZONE) then return end
	QueueCreatePins(PINS_UNKNOWN)
end

local function MapCallback_collected()
	if not LMP:IsEnabled(PINS_COLLECTED) or (GetMapType() > MAPTYPE_ZONE) then return end
	QueueCreatePins(PINS_COLLECTED)
end

local function CompassCallback()
	if not savedVariables.filters[PINS_COMPASS] or (GetMapType() > MAPTYPE_ZONE) then return end
	QueueCreatePins(PINS_COMPASS)
end


-- .AUI.IsMinimapEnabled()

-- Slash commands -------------------------------------------------------------
local function ShowMyPosition()

	if SetMapToPlayerLocation() == SET_MAP_RESULT_MAP_CHANGED then
		CALLBACK_MANAGER:FireCallbacks("OnWorldMapChanged")
	end

	local x, y = GetMapPlayerPosition("player")

	local locX = ("%05.02f"):format(zo_round(x*10000)/100)
	local locY = ("%05.02f"):format(zo_round(y*10000)/100)

	MyPrint(zo_strformat("<<1>>: <<2>>\195\151<<3>> (<<4>>)", GetMapName(), locX, locY, LMP:GetZoneAndSubzone(true)))
	
end
SLASH_COMMANDS["/mypos"] = ShowMyPosition
SLASH_COMMANDS["/myposition"] = ShowMyPosition
SLASH_COMMANDS["/myloc"] = ShowMyPosition
SLASH_COMMANDS["/mylocation"] = ShowMyPosition

-- Gamepad Switch -------------------------------------------------------------
local function OnGamepadPreferredModeChanged()
	if IsInGamepadPreferredMode() then
		INFORMATION_TOOLTIP = ZO_MapLocationTooltip_Gamepad
	else
		INFORMATION_TOOLTIP = InformationTooltip
	end
end

-- Settings menu --------------------------------------------------------------
local function CreateSettingsMenu()
	local panelData = {
		type = "panel",
		name = GetString(SKYS_TITLE),
		displayName = "|cFFFFB0" .. GetString(SKYS_TITLE) .. "|r",
		author = "Garkin",
		version = ADDON_VERSION,
		slashCommand = "/skyshards",
		registerForRefresh = true,
		registerForDefaults = true,
	}
	LAM:RegisterAddonPanel("SkyShards", panelData)

	local CreateIcons, unknownIcon, collectedIcon
	CreateIcons = function(panel)
		if panel == SkyShards then
			unknownIcon = WINDOW_MANAGER:CreateControl(nil, panel.controlsToRefresh[1], CT_TEXTURE)
			unknownIcon:SetAnchor(RIGHT, panel.controlsToRefresh[1].combobox, LEFT, -10, 0)
			unknownIcon:SetTexture(pinTextures.unknown[savedVariables.pinTexture.type])
			unknownIcon:SetDimensions(savedVariables.pinTexture.size, savedVariables.pinTexture.size)
			collectedIcon = WINDOW_MANAGER:CreateControl(nil, panel.controlsToRefresh[1], CT_TEXTURE)
			collectedIcon:SetAnchor(RIGHT, unknownIcon, LEFT, -5, 0)
			collectedIcon:SetTexture(pinTextures.collected[savedVariables.pinTexture.type])
			collectedIcon:SetDimensions(savedVariables.pinTexture.size, savedVariables.pinTexture.size)
			CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", CreateIcons)
		end
	end
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", CreateIcons)

	local optionsTable = {
		{
			type = "dropdown",
			name = GetString(SKYS_PIN_TEXTURE),
			tooltip = GetString(SKYS_PIN_TEXTURE_DESC),
			choices = pinTexturesList,
			getFunc = function() return pinTexturesList[savedVariables.pinTexture.type] end,
			setFunc = function(selected)
					for index, name in ipairs(pinTexturesList) do
						if name == selected then
							savedVariables.pinTexture.type = index
							LMP:SetLayoutKey(PINS_UNKNOWN, "texture", pinTextures.unknown[index])
							LMP:SetLayoutKey(PINS_COLLECTED, "texture", pinTextures.collected[index])
							unknownIcon:SetTexture(pinTextures.unknown[index])
							collectedIcon:SetTexture(pinTextures.collected[index])
							LMP:RefreshPins(PINS_UNKNOWN)
							LMP:RefreshPins(PINS_COLLECTED)
							COMPASS_PINS.pinLayouts[PINS_COMPASS].texture = pinTextures.unknown[index]
							COMPASS_PINS:RefreshPins(PINS_COMPASS)
							break
						end
					end
				end,
			disabled = function() return not (savedVariables.filters[PINS_UNKNOWN] or savedVariables.filters[PINS_COLLECTED]) end,
			default = pinTexturesList[defaults.pinTexture.type],
		},
		{
			type = "slider",
			name = GetString(SKYS_PIN_SIZE),
			tooltip = GetString(SKYS_PIN_SIZE_DESC),
			min = 20,
			max = 70,
			getFunc = function() return savedVariables.pinTexture.size end,
			setFunc = function(size)
					savedVariables.pinTexture.size = size
					unknownIcon:SetDimensions(size, size)
					collectedIcon:SetDimensions(size, size)
					LMP:SetLayoutKey(PINS_UNKNOWN, "size", size)
					LMP:SetLayoutKey(PINS_COLLECTED, "size", size)
					LMP:RefreshPins(PINS_UNKNOWN)
					LMP:RefreshPins(PINS_COLLECTED)
				end,
			disabled = function() return not (savedVariables.filters[PINS_UNKNOWN] or savedVariables.filters[PINS_COLLECTED]) end,
			default = defaults.pinTexture.size
		},
		{
			type = "slider",
			name = GetString(SKYS_PIN_LAYER),
			tooltip = GetString(SKYS_PIN_LAYER_DESC),
			min = 10,
			max = 200,
			step = 5,
			getFunc = function() return savedVariables.pinTexture.level end,
			setFunc = function(level)
					savedVariables.pinTexture.level = level
					LMP:SetLayoutKey(PINS_UNKNOWN, "level", level)
					LMP:SetLayoutKey(PINS_COLLECTED, "level", level)
					LMP:RefreshPins(PINS_UNKNOWN)
					LMP:RefreshPins(PINS_COLLECTED)
				end,
			disabled = function() return not (savedVariables.filters[PINS_UNKNOWN] or savedVariables.filters[PINS_COLLECTED]) end,
			default = defaults.pinTexture.level,
		},
		{
			type = "checkbox",
			name = GetString(SKYS_UNKNOWN),
			tooltip = GetString(SKYS_UNKNOWN_DESC),
			getFunc = function() return savedVariables.filters[PINS_UNKNOWN] end,
			setFunc = function(state)
					savedVariables.filters[PINS_UNKNOWN] = state
					LMP:SetEnabled(PINS_UNKNOWN, state)
				end,
			default = defaults.filters[PINS_UNKNOWN],
		},
		{
			type = "checkbox",
			name = GetString(SKYS_COLLECTED),
			tooltip = GetString(SKYS_COLLECTED_DESC),
			getFunc = function() return savedVariables.filters[PINS_COLLECTED] end,
			setFunc = function(state)
					savedVariables.filters[PINS_COLLECTED] = state
					LMP:SetEnabled(PINS_COLLECTED, state)
				end,
			default = defaults.filters[PINS_COLLECTED]
		},
		{
			type = "checkbox",
			name = GetString(SKYS_COMPASS_UNKNOWN),
			tooltip = GetString(SKYS_COMPASS_UNKNOWN_DESC),
			getFunc = function() return savedVariables.filters[PINS_COMPASS] end,
			setFunc = function(state)
					savedVariables.filters[PINS_COMPASS] = state
					COMPASS_PINS:RefreshPins(PINS_COMPASS)
				end,
			default = defaults.filters[PINS_COMPASS],
		},
		{
			type = "slider",
			name = GetString(SKYS_COMPASS_DIST),
			tooltip = GetString(SKYS_COMPASS_DIST_DESC),
			min = 1,
			max = 100,
			getFunc = function() return savedVariables.compassMaxDistance * 1000 end,
			setFunc = function(maxDistance)
					savedVariables.compassMaxDistance = maxDistance / 1000
					COMPASS_PINS.pinLayouts[PINS_COMPASS].maxDistance = maxDistance / 1000
					COMPASS_PINS:RefreshPins(PINS_COMPASS)
				end,
			width = "full",
			disabled = function() return not savedVariables.filters[PINS_COMPASS] end,
			default = defaults.compassMaxDistance * 1000,
		},
	}
	LAM:RegisterOptionControls("SkyShards", optionsTable)
end

-- Event handlers -------------------------------------------------------------
local function OnAchievementUpdate(eventCode, achievementId)
	local ids = SkyShards_GetAchievementIDs()

	if ids[achievementId] then
		LMP:RefreshPins(PINS_UNKNOWN)
		LMP:RefreshPins(PINS_COLLECTED)
		COMPASS_PINS:RefreshPins(PINS_COMPASS)
	end
end

local function OnLoad(_, name)

	if name == "SkyShards" then
		EVENT_MANAGER:UnregisterForEvent("SkyShards", EVENT_ADD_ON_LOADED)

		savedVariables = ZO_SavedVars:New("SkyS_SavedVariables", 4, nil, defaults)

		--get pin layout from saved variables
		local pinTextureType = savedVariables.pinTexture.type
		local pinTextureLevel = savedVariables.pinTexture.level
		local pinTextureSize = savedVariables.pinTexture.size
		local compassMaxDistance = savedVariables.compassMaxDistance

		local pinLayout_unknown = { level = pinTextureLevel, texture = pinTextures.unknown[pinTextureType], size = pinTextureSize }
		local pinLayout_collected = { level = pinTextureLevel, texture = pinTextures.collected[pinTextureType], size = pinTextureSize }
		local pinLayout_compassunknown = {
			maxDistance = compassMaxDistance,
			texture = pinTextures.unknown[pinTextureType],
			sizeCallback = function(pin, angle, normalizedAngle, normalizedDistance)
				if zo_abs(normalizedAngle) > 0.25 then
					pin:SetDimensions(54 - 24 * zo_abs(normalizedAngle), 54 - 24 * zo_abs(normalizedAngle))
				else
					pin:SetDimensions(48, 48)
				end
			end
		}

		--initialize map pins
		LMP:AddPinType(PINS_UNKNOWN, MapCallback_unknown, nil, pinLayout_unknown, pinTooltipCreator)
		LMP:AddPinType(PINS_COLLECTED, MapCallback_collected, nil, pinLayout_collected, pinTooltipCreator)

		--add filter check boxex
		LMP:AddPinFilter(PINS_UNKNOWN, GetString(SKYS_FILTER_UNKNOWN), nil, savedVariables.filters)
		LMP:AddPinFilter(PINS_COLLECTED, GetString(SKYS_FILTER_COLLECTED), nil, savedVariables.filters)

		--add handler for the left click
		local clickHandler = {
			[1] = {
				name = GetString(SKYS_SET_WAYPOINT),
				show = function(pin) return true end,
				duplicates = function(pin1, pin2) return (pin1.m_PinTag[3] == pin2.m_PinTag[3] and pin1.m_PinTag[4] == pin2.m_PinTag[4]) end,
				callback = function(pin) PingMap(MAP_PIN_TYPE_PLAYER_WAYPOINT, MAP_TYPE_LOCATION_CENTERED, pin.normalizedX, pin.normalizedY) end,
			},
		}
		LMP:SetClickHandlers(PINS_UNKNOWN, clickHandler)
		LMP:SetClickHandlers(PINS_COLLECTED, clickHandler)

		--initialize compass pins
		COMPASS_PINS:AddCustomPin(PINS_COMPASS, CompassCallback, pinLayout_compassunknown)
		COMPASS_PINS:RefreshPins(PINS_COMPASS)

		-- addon menu
		CreateSettingsMenu()
		
		-- Set wich tooltip must be used
		OnGamepadPreferredModeChanged()
		
		--events
		EVENT_MANAGER:RegisterForEvent("SkyShards",  EVENT_ACHIEVEMENT_UPDATED, OnAchievementUpdate)
		EVENT_MANAGER:RegisterForEvent("SkyShards", EVENT_GAMEPAD_PREFERRED_MODE_CHANGED, OnGamepadPreferredModeChanged)
	end
	
end

EVENT_MANAGER:RegisterForEvent("SkyShards", EVENT_ADD_ON_LOADED, OnLoad)