function CS.STYLE()
    local self = {}
	local item = {43532,46122,46121,43549,46117,44975,46119,46116,46120,43533,46097,46118,43557,43534}
	local styles = {
		[2] = {1,1025,16425}, -- Breton
		[3] = {1,1025,16427}, -- Redguard
		[4] = {1,1025,16426}, -- Orc
		[5] = {1,1025,27245}, -- Dunmer
		[6] = {1,1025,27244}, -- Nord
		[7] = {1,1025,27246}, -- Argonian
		[8] = {1,1025,16424}, -- Altmer
		[9] = {1,1025,16428}, -- Bosmer
		[10] = {1,1025,44698}, -- Khajiit
		[20] = {1,1025,51345}, -- Primal
		[16] = {1,1025,51638}, -- Ancient Elves
		[18] = {1,1025,51565}, -- Barbaric
		[21] = {1,1025,51688}, -- Daedric
		[35] = {1,1025,54868}, -- Imperial
		[15] = {2,1144,57573}, -- Dwarven
		[30] = {2,1181,57835}, -- Xivkyn
		[29] = {2,1319,64670}, -- Glass
		[27] = {2,1348,64716}, -- Mercenary
		[23] = {2,1341,69528}, -- Ancient Orc
		[25] = {2,1414,71721}, -- EP
		[26] = {2,1415,71689}, -- AD
		[24] = {2,1416,71705}, -- DC
		[14] = {2,1412,71567}, -- Malacath
		[22] = {2,1411,71551}, -- Trinimac
		[31] = {1,1418,71765}, -- Soulshriven
		[34] = {2,1318,57591}, -- Akaviri
		[48] = {2,1417,71523}, -- Thieves Guild
	}
	function self.IsRegular(style)
		if not styles[style] then return false end
		if styles[style][1] == 1 then return true end
		return false
	end

	local function IsSimpleStyle(style)
		if not styles[style] then return false end
		if styles[style][1] == 1 then return true end
		return false
	end

	function self.IsStyleKnown(style,chapter)
		if not styles[style] then return false end
		if IsSimpleStyle(style) then
			return IsSmithingStyleKnown(style)
		else
			local _, known = GetAchievementCriterion(styles[style][2],chapter)
			if known == 1 then return true end
		end
		return false
	end
	function self.GetChapterId(style,chapter)
		if not styles[style] then styles[style] = {1,1028,63026} end
		if IsSimpleStyle(style) then return styles[style][3]
		else return styles[style][3] + (chapter - 1) end
	end
	
	function self.GetIconAndLink(style,chapter)
		if not styles[style] then styles[style] = {1,1028,63026} end
		local link, icon = GetSmithingStyleItemInfo(style)
		local _, _, _, _, rawStyle = GetSmithingStyleItemInfo(style)
		link = ('|H1:item:%u:370:50:0:0:0:0:0:0:0:0:0:0:0:0:%u:0:0:0:10000:0|h|h'):format(item[chapter],rawStyle)
		icon = GetItemLinkInfo(link)
		if IsSimpleStyle(style) then link = ('|H1:item:%u:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(styles[style][3])
		else link = ('|H1:item:%u:6:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(styles[style][3] + (chapter - 1)) end
		return icon, link
	end
	
	function self.GetHeadline(style)
		if not styles[style] then styles[style] = {1,1028,63026} end
		local link, name, aName, popup
		local _, icon, _, _, rawStyle = GetSmithingStyleItemInfo(style)
		link = GetSmithingStyleItemLink(style)
		name = zo_strformat('<<C:1>>',GetString('SI_ITEMSTYLE', rawStyle))
		aLink = GetAchievementLink(styles[style][2],LINK_STYLE_BRACKETS)
		aName = GetAchievementInfo(styles[style][2])
		local _,_,_,_,progress,ts = ZO_LinkHandler_ParseLink(aLink)
		popup = {styles[style][2],progress,ts}
		return icon, link, name, aName, aLink, popup
	end

	return self
end