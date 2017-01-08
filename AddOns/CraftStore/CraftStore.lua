CS.name = 'CraftStore'
CS.version = '3.40'
CS.account = nil
CS.character = nil
CS.init = false
local lang = GetCVar('language.2')
if lang ~= 'de' and lang ~= 'fr' and lang ~= 'en' then lang = 'en' end
local L = CS[lang] or CS.en
local _,_,MAXTRAITS = GetSmithingResearchLineInfo(1,1)
local QUALITY = {[0]={0.65,0.65,0.65,1},[1]={1,1,1,1},[2]={0.17,0.77,0.05,1},[3]={0.22,0.57,1,1},[4]={0.62,0.18,0.96,1},[5]={0.80,0.66,0.10,1}}
local QUALITYHEX = {[0]='B3B3B3',[1]='FFFFFF',[2]='2DC50E',[3]='3A92FF',[4]='A02EF7',[5]='EECA2A'}
local EM, WM, SM, ZOSF, DONE, CSLOOT, INSPIRATION = EVENT_MANAGER, WINDOW_MANAGER, SCENE_MANAGER, zo_strformat, false, nil, ''
local HEALTH, MAGICKA, STAMINA = GetString(SI_ATTRIBUTES1), GetString(SI_ATTRIBUTES2), GetString(SI_ATTRIBUTES3)
local CURRENT_PLAYER, SELECTED_PLAYER = ZOSF('<<C:1>>',GetUnitName('player')), ZOSF('<<C:1>>',GetUnitName('player'))
local QUEST, ITEMMARK, TIMER, SELF, EXTERN, MODE, MAXCRAFT = {}, {}, {}, false, false, 0, 50
local COOK = {
	category = {
		HEALTH, MAGICKA, STAMINA, HEALTH..' + '..MAGICKA, HEALTH..' + '..STAMINA, MAGICKA..' + '..STAMINA, HEALTH..' + '..MAGICKA..' + '..STAMINA,
		HEALTH, MAGICKA, STAMINA, HEALTH..' + '..MAGICKA, HEALTH..' + '..STAMINA, MAGICKA..' + '..STAMINA, HEALTH..' + '..MAGICKA..' + '..STAMINA,
		GetString(SI_ITEMFILTERTYPE5), GetString(SI_ITEMFILTERTYPE5), ''
	},
	craftLevel = 0,
	qualityLevel = 0,
	job = {amount = 0, list = nil, id = nil},
	recipe = {},
	ingredient = {},
	recipelist = {
	45535,45539,45540,45541,45542,45543,45544,45545,45546,45547,45548,45549,45551,45552,45553,45554,45555,45556,45557,45559,45560,45561,45562,45563,
	45564,45565,45567,45568,45569,45570,45571,45572,45573,45574,45575,45576,45577,45579,45580,45581,45582,45583,45584,45587,45588,45589,45590,45591,
	45592,45594,45595,45596,45597,45598,45599,45600,45601,45602,45603,45604,45607,45608,45609,45610,45611,45612,45614,45615,45616,45617,45618,45619,
	45620,45621,45622,45623,45624,45625,45626,45627,45628,45629,45630,45631,45632,45633,45634,45636,45637,45638,45639,45640,45641,45642,45643,45644,
	45645,45646,45647,45648,45649,45650,45651,45652,45653,45654,45655,45656,45657,45658,45659,45660,45661,45662,45663,45664,45665,45666,45667,45668,
	45670,45671,45672,45673,45674,45675,45676,45677,45678,45679,45680,45681,45682,45683,45684,45685,45686,45687,45688,45689,45690,45691,45692,45693,
	45694,45695,45696,45697,45698,45699,45700,45701,45702,45703,45704,45705,45706,45707,45708,45709,45710,45711,45712,45713,45714,45715,45716,45717,
	45718,45719,45791,45887,45888,45889,45890,45891,45892,45893,45894,45895,45896,45897,45898,45899,45900,45901,45902,45903,45904,45905,45906,45907,
	45908,45909,45910,45911,45912,45913,45914,45915,45916,45917,45918,45919,45920,45921,45922,45923,45924,45925,45926,45927,45928,45929,45930,45931,
	45932,45933,45934,45935,45936,45937,45938,45939,45940,45941,45942,45943,45944,45945,45946,45947,45948,45949,45950,45951,45952,45953,45954,45955,
	45956,45957,45958,45959,45960,45961,45962,45963,45964,45965,45966,45967,45968,45969,45970,45971,45972,45973,45974,45975,45976,45977,45978,45979,
	45980,45981,45982,45983,45984,45985,45986,45987,45988,45989,45990,45991,45992,45993,45994,45995,45996,45997,45998,45999,46000,46001,46002,46003,
	46004,46005,46006,46007,46008,46009,46010,46011,46012,46013,46014,46015,46016,46017,46018,46019,46020,46021,46022,46023,46024,46025,46026,46027,
	46028,46029,46030,46031,46032,46033,46034,46035,46036,46037,46038,46039,46040,46041,46042,46043,46044,46045,46046,46047,46048,46049,46050,46051,
	46052,46053,46054,46055,46056,46079,46081,46082,54241,54242,54243,54369,54370,54371,56943,56944,56945,56946,56947,56948,56949,56950,56951,56952,
	56953,56954,56955,56956,56957,56958,56959,56961,56962,56963,56964,56965,56966,56967,56968,56969,56970,56971,56972,56973,56974,56975,56976,56977,
	56978,56979,56980,56981,56982,56983,56984,56985,56986,56987,56988,56989,56990,56991,56992,56993,56994,56995,56996,56997,56998,56999,57000,57001,
	57002,57003,57004,57005,57006,57007,57008,57009,57010,57011,57012,57013,57014,57015,57016,57017,57018,57019,57020,57021,57022,57023,57024,57025,
	57026,57027,57028,57029,57030,57031,57032,57033,57034,57035,57036,57037,57038,57039,57040,57041,57042,57043,57044,57045,57046,57047,57048,57049,
	57050,57051,57052,57053,57054,57055,57056,57057,57058,57059,57060,57061,57062,57063,57064,57065,57066,57067,57068,57069,57070,57071,57072,57073,
	57074,57075,57076,57077,57078,57079,64223,68189,68190,68191,68192,68193,68194,68195,68196,68197,68198,68199,68200,68201,68202,68203,68204,68205,
	68206,68207,68208,68209,68210,68211,68212,68213,68214,68215,68216,68217,68218,68219,68220,68221,68222,68223,68224,68225,68226,68227,68228,68229,
	68230,68231,68232,71060,71061,71062,71063},
	ingredientlist = {
	34349,34348,34347,34346,34345,34335,34334,34333,34330,34329,34324,34323,34321,34311,34309,34308,34307,34305,33774,33773,33772,33771,33768,33758,
	33756,33755,33754,33753,33752,29030,28666,28639,28636,28610,28609,28604,28603,27100,27064,27063,27059,27058,27057,27052,27049,27048,27043,27035,
	26954,26802}
}
local RUNE = {
	level = {'1 - 10','5 - 15','10 - 20','15 - 25','20 - 30','25 - 35','30 - 40','35 - 45','40 - 50','V1 - V3','V3 - V5','V5 - V7','V7 - V9','V10 - V14','V15','V16'},
	skillLevel = {1,1,2,2,3,3,4,4,5,5,6,7,8,9,10,10},
	aspectSkill = 1,
	potencySkill = 1,
	rune = {
		[ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = {45831,45832,45833,45834,45835,45836,45837,45838,45839,45840,45841,45842,45843,45846,45847,45848,45849,68342},
		[ITEMTYPE_ENCHANTING_RUNE_POTENCY] = { {45855,45856,45857,45806,45807,45808,45809,45810,45811,45812,45813,45814,45815,45816,64509,68341}, {45817,45818,45819,45820,45821,45822,45823,45824,45825,45826,45827,45828,45829,45830,64508,68340} },
		[ITEMTYPE_ENCHANTING_RUNE_ASPECT] = {45850,45851,45852,45853,45854},
	},
	glyph = {
		[ITEMTYPE_GLYPH_ARMOR] = {
			{26580,45831,1,1}, -- health, oko
			{26582,45832,1,2}, -- magicka, makko
			{26588,45833,1,3}, -- stamina, deni
			{68343,68342,1,4}, -- prismatic defense, hakeijo 
		},
		[ITEMTYPE_GLYPH_WEAPON] = {
			{68344,68342,2,1}, -- prismatic onslaught, hakeijo 
			{54484,45843,1,2}, -- weapon damage, okori
			{26845,45842,2,3}, -- crushing, deteri
			{43573,45831,2,4}, -- absorb health, oko
			{45868,45832,2,5}, -- absorb magicka, makko
			{45867,45833,2,6}, -- absorb stamina, deni
			{45869,45834,2,7}, -- decrease health, okoma
			{5365,45839,1,8}, -- frost weapon, dekeipa
			{26848,45838,1,9}, -- flame weapon, rakeipa
			{26844,45840,1,10}, -- shock weapon, meip
			{26587,45837,1,11}, -- poison weapon, kuoko
			{26841,45841,1,12}, -- foul weapon, haoko
			{5366,45842,1,13}, -- hardening, deteri
			{26591,45843,2,14}, -- weakening, okori
		},
		[ITEMTYPE_GLYPH_JEWELRY] = {
			{26581,45834,1,1}, -- health recovery, okoma
			{26583,45835,1,2}, -- magicka recovery, makkoma
			{26589,45836,1,3}, -- stamina recovery, denima
			{45870,45835,2,4}, -- reduce spell cost, makkoma
			{45871,45836,2,5}, -- reduce feat cost, denima
			{45883,45847,1,6}, -- increase physical harm, taderi
			{45884,45848,1,7}, -- increase magical harm, makderi
			{45885,45847,2,8}, -- decrease physical harm, taderi
			{45886,45848,2,9}, -- decrease spell harm, makderi
			{5364,45839,2,10}, -- frost resist, dekeipa
			{26849,45838,2,11}, -- flame resist, rakeipa
			{43570,45840,2,12}, -- shock resist, meip
			{26586,45837,2,13}, -- poison resist, kuoko
			{26847,45841,2,14}, -- disease resist, haoko
			{45872,45849,1,15}, -- bashing, kaderi
			{45873,45849,2,16}, -- shielding, kaderi
			{45874,45846,1,17}, -- potion boost, oru
			{45875,45846,2,18}, -- potion speed, oru
		},
	},
	job = { amount = 0, slot = {0,0,0}},
	refine = { glyphs = {nil}, crafted = false }
}
local FLASK = {
	reagent = {},
	noBad = false,
	solvent = {883,1187,4570,23265,23266,23267,23268,64500,64501},
	reagentTrait = {
		{30165,2,14,12,23},
		{30158,9,3,18,13},
		{30155,6,8,1,22},
		{30152,18,2,9,4},
		{30162,7,5,16,11},
		{30148,4,10,1,23},
		{30149,16,2,7,6},
		{30161,3,9,2,24},
		{30160,17,1,10,3},
		{30154,10,4,17,12},
		{30157,5,7,2,21},
		{30151,2,4,6,20},
		{30164,1,3,5,19},
		{30159,11,22,24,19},
		{30163,15,1,8,5},
		{30153,13,21,23,19},
		{30156,8,6,15,12},
		{30166,1,13,11,20}
	},
	solventSelection = 1,
	traitSelection = {1},
	traitIcon = {
		'restorehealth','ravagehealth',
		'restoremagicka','ravagemagicka',
		'restorestamina','ravagestamina',
		'increaseweaponpower','lowerweaponpower',
		'increasespellpower','lowerspellpower',
		'weaponcrit','lowerweaponcrit',
		'spellcrit','lowerspellcrit',
		'increasearmor','lowerarmor',
		'increasespellresist','lowerspellresist',
		'unstoppable','stun',
		'speed','reducespeed',
		'invisible','detection',
	}
}
local crafticon = {
	[2] = 'esoui/art/icons/ability_tradecraft_008.dds',
	[1] = 'esoui/art/icons/ability_smith_007.dds',
	[6] = 'esoui/art/icons/ability_tradecraft_009.dds',
	[5] = 'esoui/art/icons/ability_provisioner_002.dds',
	[4] = 'esoui/art/icons/ability_alchemy_006.dds',
	[3] = 'esoui/art/icons/ability_enchanter_001b.dds'
}
local flags = {
	'esoui/art/guild/guildbanner_icon_aldmeri.dds',
	'esoui/art/guild/guildbanner_icon_ebonheart.dds',
	'esoui/art/guild/guildbanner_icon_daggerfall.dds',
}
local classes = {
	'esoui/art/icons/class/class_dragonknight.dds',
	'esoui/art/icons/class/class_sorcerer.dds',
	'esoui/art/icons/class/class_nightblade.dds',
	'esoui/art/icons/class/class_warden.dds',
	'esoui/art/icons/class/class_battlemage.dds',
	'esoui/art/icons/class/class_templar.dds'
}
local sets = {
{traits=2,nodes={7,175,77},item=49575,zone={2,15,11}},		-- Aschengriff
{traits=2,nodes={1,177,71},item=43805,zone={2,15,11}},		-- Todeswind
{traits=2,nodes={216,121,65},item=47279,zone={2,15,11}},	-- Stille der Nacht
{traits=3,nodes={15,169,205},item=43808,zone={4,7,10}},		-- Zwielicht
{traits=3,nodes={23,164,32},item=48042,zone={4,7,10}},		-- Verführung
{traits=3,nodes={19,165,24},item=43979,zone={4,7,10}},		-- Torugs Pakt
{traits=3,nodes={237,237,237},item=69942,zone={27,27,27}},	-- Prüfungen
{traits=4,nodes={9,154,51},item=51105,zone={3,16,9}},		-- Histrinde
{traits=4,nodes={82,151,78},item=47663,zone={3,16,9}},	 	-- Weißplanke
{traits=4,nodes={13,148,48},item=43849,zone={3,16,9}},		-- Magnus
{traits=5,nodes={58,101,93},item=48425,zone={5,8,13}},		-- Kuss des Vampirs
{traits=5,nodes={137,103,89},item=52243,zone={5,8,13}},		-- Lied der Lamien
{traits=5,nodes={155,105,95},item=52624,zone={5,8,13}},		-- Alessias Bollwerk
{traits=5,nodes={199,201,203},item=60280,zone={26,26,26}},	-- Adelssieg
{traits=5,nodes={257,257,257},item=71806,zone={28,28,28}},	-- Tavas Gunst
{traits=6,nodes={35,144,111},item=51486,zone={6,17,12}},	-- Weidenpfad
{traits=6,nodes={39,161,113},item=51864,zone={6,17,12}},	-- Hundings Zorn
{traits=6,nodes={34,156,118},item=49195,zone={6,17,12}},	-- Mutter der Nacht
{traits=6,nodes={241,241,241},item=69592,zone={27,27,27}},	-- Julianos
{traits=7,nodes={199,201,203},item=60630,zone={26,26,26}},	-- Umverteilung
{traits=7,nodes={257,257,257},item=72156,zone={28,28,28}},	-- Schlauer Alchemist
{traits=8,nodes={135,135,135},item=43968,zone={23,23,23}},	-- Erinnerung
{traits=8,nodes={133,133,133},item=43972,zone={23,23,23}},	-- Schemenauge
{traits=8,nodes={-1,-1,-1},item=44053,zone={6,17,12}},		-- Augen von Mara
{traits=8,nodes={-1,-1,-1},item=54149,zone={6,17,12}},		-- Shalidor's Fluch
{traits=8,nodes={-2,-2,-2},item=53772,zone={6,17,12}},		-- Karegnas Hoffnung
{traits=8,nodes={-2,-2,-2},item=53006,zone={6,17,12}},		-- Ogrumms Schuppen
{traits=8,nodes={217,217,217},item=54963,zone={25,25,25}},	-- Arena
{traits=9,nodes={234,234,234},item=58174,zone={25,25,25}},	-- Doppelstern
{traits=9,nodes={199,201,203},item=60980,zone={26,26,26}},	-- Rüstungsmeister
{traits=9,nodes={237,237,237},item=70642,zone={27,27,27}},	-- Morkuldin
{traits=9,nodes={255,255,255},item=72506,zone={28,28,28}},	-- Ewige Jagd
}

local function SplitLink(link,nr)
	local split = {SplitString(':', link)}
	if split[nr] then return tonumber(split[nr]) else return false end
end
local function ToChat(message)
	local chat = CHAT_SYSTEM.textEntry:GetText()
	StartChatInput(chat..message)
end
function CS.LoadCharacter(control,button)
	local char = control.data.charactername
	if button == 2 then
		if CS.account.mainchar == char then CS.account.mainchar = false else CS.account.mainchar = char end
		CS.DrawCharacters()
	elseif button == 3 and char ~= CURRENT_PLAYER then
		SELECTED_PLAYER = CURRENT_PLAYER
		if CS.account.mainchar == char then CS.account.mainchar = false end
		CS.account.player[char] = nil
		CS.account.crafting.research[char] = nil
		CS.account.crafting.studies[char] = nil
		CS.account.crafting.skill[char] = nil
		CS.account.style.tracking[char] = nil
		CS.account.style.knowledge[char] = nil
		CS.account.cook.tracking[char] = nil
		CS.account.cook.knowledge[char] = nil
		CS.character[char] = nil
		for nr,_ in pairs(CS.GetCharacters()) do WM:GetControlByName('CS_CharacterFrame'..nr):SetHidden(true) end
		CS.DrawCharacters()
		CS_CharacterPanelBoxScrollChild:SetHeight(#CS.GetCharacters() * 204 - 5)
	else
		SELECTED_PLAYER = char
		CS.UpdateScreen()
		CS_PanelButtonCharacters:SetText(char)
		CS_CharacterPanel:SetHidden(true)
		for id,value in pairs(CS.account.cook.knowledge[char]) do
			for x,recipe in pairs(COOK.recipe) do
				if recipe.id == id then COOK.recipe[x].known = value; break end
			end
		end
	end
end
function CS.DrawCharacters()
	local control, mainchar
	local swatch = {[false] = '|t16:16:esoui/art/buttons/checkbox_unchecked.dds|t', [true] = '|t16:16:esoui/art/buttons/checkbox_checked.dds|t'}
	local tex = {[true] = '|t18:18:CraftStore/star.dds|t ', [false] = ''}
	local function GetResearch(char,nr)
		local row, now, control = 1, GetTimeStamp()
		for craft,craftData in pairs(CS.account.crafting.research[char]) do
			for line,lineData in pairs(craftData) do
				for trait,traitData in pairs(lineData) do
					if traitData ~= true and traitData ~= false then
						if traitData > 0 then
							local name, icon = GetSmithingResearchLineInfo(craft,line)
							local tid = GetSmithingResearchLineTraitInfo(craft,line,trait)
							local _,_,ticon = GetSmithingTraitItemInfo(tid + 1)
							control = WM:GetControlByName('CS_Character'..nr..'Research'..craft..'Slot'..row)
							control:SetText('|t22:22:'..icon..'|t  |t22:22:'..ticon..'|t')
							control.data = {info = ZOSF('<<C:1>> - <<C:2>>',name,GetString('SI_ITEMTRAITTYPE',tid))}
							WM:GetControlByName('CS_Character'..nr..'Research'..craft..'Slot'..row..'Time'):SetText(CS.GetTime(traitData - now))
							row = row + 1
						end
					end
				end
			end
			local maxsim = CS.account.crafting.skill[char][craft].maxsim or 1
			local level = string.format('%02d',CS.account.crafting.skill[char][craft].level) or 1
			local rank = string.format('%02d',CS.account.crafting.skill[char][craft].rank) or 1
			local simcolor, current = '|cFFFFFF', row - 1
			if maxsim > 1 then if current == maxsim then simcolor = '|c00FF00' else simcolor = '|cFF0000' end end
			WM:GetControlByName('CS_Character'..nr..'Skill'..craft):SetText('|t24:24:'..crafticon[craft]..'|t  '..level..' ('..rank..')|r    |c808080'..GetString(SI_BULLET)..'|r   '..simcolor..current..' / '..maxsim..'|r')
			row = 1
		end
	end
	for x = 1,8 do control = WM:GetControlByName('CS_CharacterFrame'..x); if control then control:SetHidden(true) end end
	for nr, char in pairs(CS.GetCharacters()) do
		local player = CS.account.player[char]
		if CS.account.mainchar == char then mainchar = true else mainchar = false end
		WM:GetControlByName('CS_CharacterFrame'..nr):SetHidden(false)
		control = WM:GetControlByName('CS_Character'..nr..'Name')
		control:SetText(tex[mainchar]..char..' ('..player.level..') |t25:25:'..flags[player.faction]..'|t|t30:30:'..classes[player.class]..'|t')
		control.data = { charactername = char, info = L.TT[10] }
		control = WM:GetControlByName('CS_Character'..nr..'Info')
		control:SetText(player.mount.space..'  '..player.mount.stamina..' '..player.mount.speed..'  '..'|t22:22:esoui/art/miscellaneous/timer_32.dds|t '..CS.GetTime(player.mount.time - GetTimeStamp()))
		control.data = { info = L.TT[20] }
		for x, icon in pairs(crafticon) do
			local name = GetSkillLineInfo(GetCraftingSkillLineIndices(x))
			local level = string.format('%02d',CS.account.crafting.skill[char][x].level) or 1
			local rank = string.format('%02d',CS.account.crafting.skill[char][x].rank) or 1
			control = WM:GetControlByName('CS_Character'..nr..'Skill'..x)
			control:SetText('|t24:24:'..icon..'|t  '..level..' ('..rank..')')
			control.data = { info = ZOSF('<<C:1>>',name)..' - '..L.rank..' ('..L.level..')' }
		end
		GetResearch(char,nr)
		WM:GetControlByName('CS_Character'..nr..'Recipe'):SetText(swatch[CS.account.cook.tracking[char]]..' |t22:22:esoui/art/icons/quest_scroll_001.dds|t')
		WM:GetControlByName('CS_Character'..nr..'Style'):SetText(swatch[CS.account.style.tracking[char]]..' |t22:22:esoui/art/icons/quest_book_001.dds|t')
	end
end
function CS.DrawTraitColumn(craft,line)
	local name, icon = GetSmithingResearchLineInfo(craft,line)
	local craftname = GetSkillLineInfo(GetCraftingSkillLineIndices(craft))
	local p = WM:GetControlByName('CS_PanelCraft'..craft..'Line'..line)
	local c = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'Header',p,CT_BUTTON)
	c:SetAnchor(3,p,3,-1,0)
	c:SetDimensions(27,27)
	c:SetClickSound('Click')
	c:EnableMouseButton(2,true)
	c:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,true,self,'bc') end)
	c:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false,true) end)
	c:SetHandler('OnMouseDown',function(self,button)
		local value = not CS.account.crafting.studies[SELECTED_PLAYER][craft][line]
		if button == 2 then
			for col = 1, WM:GetControlByName('CS_PanelCraft'..craft):GetNumChildren() do
				CS.account.crafting.studies[SELECTED_PLAYER][craft][col] = value
				CS.UpdateStudyLine(WM:GetControlByName('CS_PanelCraft'..craft):GetChild(col),value)
			end
		else
			CS.account.crafting.studies[SELECTED_PLAYER][craft][line] = value
			CS.UpdateStudyLine(p,value)
		end
	end)
	c.data = {info = ZOSF(L.TT[1],name,crafticon[craft],craftname)}
	local t = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'HeaderTexture',c,CT_TEXTURE)
	t:SetAnchor(128,c,128,0,0)
	t:SetDimensions(26,26)
	t:SetTexture(icon)
	for trait = 1, MAXTRAITS do
		local b = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'Trait'..trait..'Bg',p,CT_BACKDROP)
		b:SetAnchor(3,p,3,-1,2 + trait * 26)
		b:SetDimensions(27,25)
		b:SetCenterColor(0.06,0.06,0.06,1)
		b:SetEdgeTexture('',1,1,1,1)
		b:SetEdgeColor(1,1,1,0.12)
		c = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'Trait'..trait,b,CT_BUTTON)
		c:SetAnchor(128,b,128,0,0)
		c:SetDimensions(25,25)
		c:SetClickSound('Click')
		c:EnableMouseButton(2,true)
		c:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true) end)
		c:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
		c:SetHandler('OnMouseDown',function(self,button)
			if button == 1 and self.data.research and SELECTED_PLAYER == CURRENT_PLAYER and (self.data.research[4] == CURRENT_PLAYER or self.data.research[4] == L.bank) then
				local uid = CS.account.crafting.stored[self.data.research[1]][self.data.research[2]][self.data.research[3]].id or false
				if uid then
					local bag,slot = CS.ScanUidBag(uid)
					d(bag,slot)
					if CanItemBeSmithingTraitResearched(bag,slot,self.data.research[1],self.data.research[2],self.data.research[3]) then ResearchSmithingTrait(bag,slot) else d(L.noSlot) end
				end
			elseif button == 2 then
				local tnr = GetSmithingResearchLineTraitInfo(craft,line,trait)
				ToChat(ZOSF(L.itemsearch,name,GetString('SI_ITEMTRAITTYPE',tnr)))
			end
		end)
		local t = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'Trait'..trait..'Texture',c,CT_TEXTURE)
		t:SetAnchor(128,c,128,0,0)
		t:SetDimensions(25,25)
	end
	local b = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'CountBg',p,CT_BACKDROP)
	b:SetAnchor(3,p,3,-1,262)
	b:SetDimensions(27,25)
	b:SetCenterColor(0.06,0.06,0.06,1)
	b:SetEdgeTexture('',1,1,1,1)
	b:SetEdgeColor(1,1,1,0.12)
	local c = WM:CreateControl('CS_PanelCraft'..craft..'Line'..line..'Count',b,CT_BUTTON)
	c:SetAnchor(128,b,128,0,0)
	c:SetDimensions(25,25)
	c:SetHorizontalAlignment(1)
	c:SetVerticalAlignment(1)
	c:SetFont('CSFont')
	c:SetNormalFontColor(0.9,0.87,0.68,1)
end
function CS.TravelToNode(control,node)
	if control.data then if control.data.travel then FastTravelToNode(sets[control.data.set].nodes[node]) end end
end
function CS.ScanBag(scanid)
	local bag = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BACKPACK,BAG_BANK)
	for _, data in pairs(bag) do
		local id = SplitLink(GetItemLink(data.bagId,data.slotIndex),3)
		if id == scanid then return data.bagId, data.slotIndex end
	end
end
function CS.ScanUidBag(id)
	if not id then return false end
	local bag = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BACKPACK,BAG_BANK)
	for _, data in pairs(bag) do if id == Id64ToString(data.uniqueId) then return data.bagId, data.slotIndex end end
	return false
end
function CS.UpdateBag()
	local bag = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BACKPACK,BAG_BANK)
	for _, data in pairs(bag) do
		local link, stack = GetItemLink(data.bagId,data.slotIndex), {0,0}
		if not CS.account.storage[link] then CS.account.storage[link] = {} end
		stack[data.bagId] = stack[data.bagId] + data.stackCount
		CS.account.storage[link][L.bank] = stack[2]
		CS.account.storage[link][CURRENT_PLAYER] = stack[1]
	end
end
function CS.ClearStorage()
	for x, slot in pairs(CS.account.storage) do
		local count = 0
		for y, item in pairs(slot) do
			if item < 1 then CS.account.storage[x][y] = nil
			else count = count + 1 end
		end
		if count == 0 then CS.account.storage[x] = nil end
	end
end
function CS.ScrollText()
	local function DrawControl(control)
		local container = CS_QuestFrame:CreateControl('CS_Inspiration'..control:GetNextControlId(),CT_CONTROL)
		local c = container:CreateControl('$(parent)Loot',CT_LABEL)
		c:SetFont('CSInsp')
		c:SetColor(1,1,1,1)
		c:SetAnchor(1,container,1,0,0)
		container.c = c
		return container
	end
	local function ClearControl(c)
		c:SetHidden(true)
		c:ClearAnchors()
	end
	CSLOOT = ZO_ObjectPool:New(DrawControl,ClearControl)
end
function CS.Slide(c,x1,y1,x2,y2,duration)
    local a=ANIMATION_MANAGER:CreateTimeline()
    local s=a:InsertAnimation(ANIMATION_TRANSLATE,c)
    local fi=a:InsertAnimation(ANIMATION_ALPHA,c)
    local fo=a:InsertAnimation(ANIMATION_ALPHA,c,duration-500)
    fi:SetAlphaValues(0,1)
    fi:SetDuration(10)
    s:SetStartOffsetX(x1)
    s:SetStartOffsetY(y1)
    s:SetEndOffsetX(x2)
    s:SetEndOffsetY(y2)
    s:SetDuration(duration)
    fo:SetAlphaValues(1,0)
    fo:SetDuration(500)
	a:PlayFromStart()
end
function CS.Queue()
	if CS.init then
		if CS.account.option[12] then
			for x,project in pairs(TIMER) do
				if(GetDiffBetweenTimeStamps(project.time,GetTimeStamp())) <= 0 then
					PlaySound('Smithing_Finish_Research')
					CS_Alarm:AddMessage(project.info,1,0.66,0.2,1)
					CS_Alarm:AddMessage('|t10:10:x.dds|t',0,0,0,1)
					table.remove(TIMER,x)
					CS.account.announce[project.id] = GetTimeStamp()
				end
			end
		end
		if ZO_Provisioner_IsSceneShowing() and CS.account.option[7] then ZO_ProvisionerTopLevelTooltip:SetHidden(true) end
		if INSPIRATION ~= '' then
			local c,x = CSLOOT:AcquireObject()
			c:SetHidden(false)
			c:SetAnchor(128,CS_QuestFrame,128,0,0)
			c:GetChild(1):SetText(INSPIRATION)
			CS.Slide(c,0,20,0,(GuiRoot:GetHeight()/2)-180,3500)
			zo_callLater(function() CSLOOT:ReleaseObject(x) end,3510)
			INSPIRATION = ''
		end
	end
end

function CS.UpdateScreen()
	local function SetPoint(x)
		local left,num,right=string.match(x,'^([^%d]*%d)(%d*)(,-)$')
		return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
	end
	for craft, _ in pairs(CS.account.crafting.research[SELECTED_PLAYER]) do
		for line = 1, GetNumSmithingResearchLines(craft) do
			for trait = 1, MAXTRAITS do
				CS.UpdatePanelIcon(craft,line,trait)
			end
		end
	end
	CS.UpdateAllStudies()
	CS.UpdateResearchWindows()
	CS.UpdateStyleKnowledge()
	local fmax,fused = GetFenceSellTransactionInfo()
	CS_PanelFenceGoldText:SetText("|cC5C29E"..fused.."/"..fmax.." |r  "..SetPoint(GetCurrentMoney() - CS.character.income[2]).." |t14:14:esoui/art/currency/currency_gold.dds|t")
end
function CS.UpdatePanelIcon(craft,line,trait)
	if not craft or not line or not trait then return end
	local traitname = GetString('SI_ITEMTRAITTYPE',GetSmithingResearchLineTraitInfo(craft,line,trait))
	local control = WM:GetControlByName('CS_PanelCraft'..craft..'Line'..line..'Trait'..trait..'Texture')
	local known = CS.account.crafting.research[SELECTED_PLAYER][craft][line][trait] or false
	local store = CS.account.crafting.stored[craft][line][trait] or { link = false, owner = false }
	local now, tip = GetTimeStamp(), ''
	local function CountTraits()
		local count = 0
		for _, trait in pairs(CS.account.crafting.research[SELECTED_PLAYER][craft][line]) do
			if trait == true then count = count + 1 end
		end
		return count
	end
	for _, char in pairs(CS.GetCharacters()) do
		local val = CS.account.crafting.research[char][craft][line][trait] or false
		if val == true then
			tip = tip..'\n|t20:20:esoui/art/buttons/accept_up.dds|t |c00FF00'..char..'|r'
		elseif val == false then
			tip = tip..'\n|t20:20:esoui/art/buttons/decline_up.dds|t |cFF1010'..char..'|r'
		elseif val and val > 0 then
			if char == CURRENT_PLAYER then
				local _,remain = GetSmithingResearchLineTraitTimes(craft,line,trait)
				tip = tip..'\n|t23:23:esoui/art/miscellaneous/timer_32.dds|t |c66FFCC'..char..' ('..CS.GetTime(remain)..')|r'
			else
				tip = tip..'\n|t23:23:esoui/art/miscellaneous/timer_32.dds|t |c66FFCC'..char..' ('..CS.GetTime(GetDiffBetweenTimeStamps(val,now))..')|r'
			end
		end
	end
	control:GetParent().data = { info = '|cFFFFFF'..traitname..'|r'..tip..'\n'..L.TT[6] }
	if known == false then
		control:SetColor(1,0,0,1)
		control:SetTexture('esoui/art/buttons/decline_up.dds')
		if store.link and store.owner then
			local isSet = GetItemLinkSetInfo(store.link)
			local mark = true
			if not CS.account.option[14] and isSet then mark = false end
			if mark then 
				tip = '\n|t20:20:esoui/art/buttons/pointsplus_up.dds|t |cE8DFAF'..store.owner..'|r'..tip
				control:SetColor(1,1,1,1)
				control:SetTexture('esoui/art/buttons/pointsplus_up.dds')
				control:GetParent().data = { link = store.link, addline = {tip}, research = {craft,line,trait,store.owner} }
			end
		end
	elseif known == true then
		control:SetColor(0,1,0,1)
		control:SetTexture('esoui/art/buttons/accept_up.dds')
	else
		control:SetColor(0.4,1,0.8,1)
		control:SetTexture('esoui/art/miscellaneous/timer_32.dds')
	end
	WM:GetControlByName('CS_PanelCraft'..craft..'Line'..line..'Count'):SetText(CountTraits())
end
function CS.UpdateStudyLine(control,condition)
	if condition then
		control:GetNamedChild('HeaderTexture'):SetColor(1,1,1,1)
		for x = 1, control:GetNumChildren() - 1 do
			local subcontrol = control:GetChild(x)
			subcontrol:SetCenterColor(0.06,0.06,0.06,1)
			subcontrol:SetEdgeColor(1,1,1,0.12)
		end
	else 
		control:GetNamedChild('HeaderTexture'):SetColor(1,0,0,1)
		for x = 1, control:GetNumChildren() - 1 do
			local subcontrol = control:GetChild(x)
			subcontrol:SetCenterColor(0.15,0,0,1)
			subcontrol:SetEdgeColor(1,0,0,0.5)
		end
	end
end
function CS.UpdateAllStudies()
	for craft, craftData in pairs(CS.account.crafting.studies[SELECTED_PLAYER]) do
		for line, lineData in pairs(craftData) do
			CS.UpdateStudyLine(WM:GetControlByName('CS_PanelCraft'..craft..'Line'..line),lineData)
		end
	end
end
function CS.UpdatePlayer()
	local function GetBonus(bonus,craft)
		local skillType, skillId = GetCraftingSkillLineIndices(craft)
		local _, rank = GetSkillLineInfo(skillType,skillId)
		return {level = GetNonCombatBonus(bonus) or 1, rank = rank, maxsim = GetMaxSimultaneousSmithingResearch(craft) or 1}
	end
	CS.account.crafting.skill[CURRENT_PLAYER] = {
		GetBonus(NON_COMBAT_BONUS_BLACKSMITHING_LEVEL,1),
		GetBonus(NON_COMBAT_BONUS_CLOTHIER_LEVEL,2),
		GetBonus(NON_COMBAT_BONUS_ENCHANTING_LEVEL,3),
		GetBonus(NON_COMBAT_BONUS_ALCHEMY_LEVEL,4),
		GetBonus(NON_COMBAT_BONUS_PROVISIONING_LEVEL,5),
		GetBonus(NON_COMBAT_BONUS_WOODWORKING_LEVEL,6)
	}
	local ride = {GetRidingStats()}
	local ridetime = GetTimeUntilCanBeTrained()/1000 or 0
	if ridetime > 1 then ridetime = ridetime + GetTimeStamp() end
	local vrank = GetUnitVeteranRank('player')
	if vrank > 0 then vrank = vrank - 1 end
	CS.account.player[CURRENT_PLAYER] = {
		race = ZOSF('<<C:1>>',GetUnitRace('player')),
		class = GetUnitClassId('player'),
		level = GetUnitLevel('player') + vrank,
		faction = GetUnitAlliance('player'),
		mount = {
			space = '|t20:20:esoui/art/mounts/ridingskill_capacity.dds|t '..ride[1]..'/'..ride[2],
			stamina = '|t20:20:esoui/art/mounts/ridingskill_stamina.dds|t '..ride[3]..'/'..ride[4],
			speed = '|t20:20:esoui/art/mounts/ridingskill_speed.dds|t '..ride[5]..'/'..ride[6],
			time = ridetime
		}
	}
end
function CS.UpdateStyleKnowledge()
	local known, control
	for id = 1,GetNumSmithingStyleItems() do
		local _, _, _, _, style = GetSmithingStyleItemInfo(id)
		if style ~= ITEMSTYLE_UNIVERSAL and style ~= ITEMSTYLE_NONE then
			for chapter = 1,14 do
				CS.account.style.knowledge[CURRENT_PLAYER][cs_style.GetChapterId(id,chapter)] = cs_style.IsStyleKnown(id,chapter)
				known = CS.account.style.knowledge[SELECTED_PLAYER][cs_style.GetChapterId(id,chapter)]
				control = WM:GetControlByName('CS_StylePanelScrollChild'..id..'Button'..chapter..'Texture')
				if known then control:SetColor(1,1,1,1) else control:SetColor(1,0,0,1) end
			end
		end
	end
end
function CS.UpdateRecipeKnowledge()
	COOK.recipe = {}
	for _,id in pairs(COOK.recipelist) do
		local link,stat = ('|H1:item:%u:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(id), 0
		local name = GetItemLinkName(link)
		local known = IsItemLinkRecipeKnown(link)
		CS.account.cook.knowledge[SELECTED_PLAYER][id] = known
		local reslink = GetItemLinkRecipeResultItemLink(link,LINK_STYLE_DEFAULT)
		local quality,itype = GetItemLinkQuality(reslink), GetItemLinkItemType(reslink)
		local _,_,text = GetItemLinkOnUseAbilityInfo(reslink)
		local level = GetItemLinkRequiredLevel(reslink) + GetItemLinkRequiredVeteranRank(reslink)
		if level == 51 then level = 50 end
		local function statcheck(stat) if string.find(text,stat) then return true else return false end end
		local function namecheck(stat) if string.find(name,stat) then return true else return false end end
		local fm,fs,fh,ozo = statcheck(MAGICKA), statcheck(STAMINA), statcheck(HEALTH), namecheck('Orzorg')
		if fm and fh and fs then stat = 7
		elseif fs and fh then stat = 5
		elseif fm and fh then stat = 4
		elseif fm and fs then stat = 6
		elseif fm then stat = 2
		elseif fh then stat = 1
		elseif fs then stat = 3
		else stat = 8 end
		if itype == ITEMTYPE_DRINK then stat = stat + 7 end
		if ozo then stat = 15 end
		table.insert(COOK.recipe,{name = ZOSF('<<C:1>>',GetItemLinkName(reslink)), stat = stat, quality = quality, level = level, link = link, result = reslink, known = known, id = id})
	end
	local function tsort(a,b) return a.level > b.level end
	table.sort(COOK.recipe,tsort)
	CS.UpdateIngredientTracking()
end
function CS.UpdateIngredientTracking()
	for recid,_ in pairs(CS.account.cook.ingredients)do
		local reslink,_ = ('|H1:item:%u:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(recid), false
		for num = 1, GetItemLinkRecipeNumIngredients(reslink) do
			local name = GetItemLinkRecipeIngredientInfo(reslink,num)
			for _,ingid in pairs(COOK.ingredientlist) do
				if GetItemLinkName('|H1:item:'..ingid..':0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h') == name then COOK.ingredient[ingid] = true; break end
			end
		end
	end
end
function CS.UpdateResearchWindows()
	local known, unknown, row, now, control = 0, 0, 1, GetTimeStamp()
	local pip = '|r|c808080  '..GetString(SI_BULLET)..'|r  '
	for craft,craftData in pairs(CS.account.crafting.research[SELECTED_PLAYER]) do
		for x = 1,3 do
			control = WM:GetControlByName('CS_PanelResearch'..craft..'WindowLine'..x)
			control:SetText(nil)
			control.data = nil
			control:GetNamedChild('Time'):SetText(nil)
		end
		for line,lineData in pairs(craftData) do
			for trait,traitData in pairs(lineData) do
				if traitData then known = known + 1 else unknown = unknown + 1 end
				if traitData ~= true and traitData ~= false then
					if traitData > 0 then
						control = WM:GetControlByName('CS_PanelResearch'..craft..'WindowLine'..row)
						local name, icon = GetSmithingResearchLineInfo(craft,line)
						local tid = GetSmithingResearchLineTraitInfo(craft,line,trait)
						control:SetText(' |t28:28:'..icon..'|t  '..GetString('SI_ITEMTRAITTYPE',tid))
						control.data = {info = ZOSF('<<C:1>>',name)}
						if SELECTED_PLAYER == CURRENT_PLAYER then
							local _,remain = GetSmithingResearchLineTraitTimes(craft,line,trait)
							control:GetNamedChild('Time'):SetText(CS.GetTime(remain))
						else
							control:GetNamedChild('Time'):SetText(CS.GetTime(GetDiffBetweenTimeStamps(traitData,now)))
						end
						row = row + 1
					end
				end
			end
		end
		local maxsim = (CS.account.crafting.skill[SELECTED_PLAYER][craft].maxsim or 1)
		local level = (CS.account.crafting.skill[SELECTED_PLAYER][craft].level or 1)
		local rank = (CS.account.crafting.skill[SELECTED_PLAYER][craft].rank or 1)
		local simcolor, current = '|cFFFFFF', row - 1
		if maxsim > 1 then if current == maxsim then simcolor = '|c00FF00' else simcolor = '|cFF0000' end end
		control = WM:GetControlByName('CS_PanelResearch'..craft..'Header')
		control:GetNamedChild('Data'):SetText('|c00FF00'..known..pip..'|cFF0000'..unknown..pip..'|c808080'..L.level..': '..level..' ('..rank..')|r')
		control:GetNamedChild('Slot'):SetText(simcolor..current..' / '..maxsim..'|r')
		row = 1; known = 0; unknown = 0
	end
end
function CS.UpdateAccountVars()
	local crafts = {CRAFTING_TYPE_BLACKSMITHING,CRAFTING_TYPE_CLOTHIER,CRAFTING_TYPE_WOODWORKING}
	for _,craft in pairs(crafts) do
		for line = 1, GetNumSmithingResearchLines(craft) do
			for trait = 1, MAXTRAITS do
				local _,_,known = GetSmithingResearchLineTraitInfo(craft,line,trait)
				if known == false then
					local _,remaining = GetSmithingResearchLineTraitTimes(craft,line,trait)
					if remaining and remaining > 0 then CS.account.crafting.research[CURRENT_PLAYER][craft][line][trait] = remaining + GetTimeStamp()
					else CS.account.crafting.research[CURRENT_PLAYER][craft][line][trait] = false end
				else CS.account.crafting.research[CURRENT_PLAYER][craft][line][trait] = true end
				CS.UpdatePanelIcon(craft,line,trait)
			end
		end
	end
	CS.account.style.knowledge[CURRENT_PLAYER] = {}
	CS.account.cook.knowledge[CURRENT_PLAYER] = {}
	if not CS.account.style.tracking[CURRENT_PLAYER] then CS.account.style.tracking[CURRENT_PLAYER] = false end
	if not CS.account.cook.tracking[CURRENT_PLAYER] then CS.account.cook.tracking[CURRENT_PLAYER] = false end
end
function CS.UpdateQuest(qId)
	for _, quest in pairs(QUEST) do
		if quest.id == qId then
			local out = quest.name
			quest.work = {}
			for cId = 1, GetJournalQuestNumConditions(qId,1) do
				local text,current,maximum = GetJournalQuestConditionInfo(qId,1,cId)
				if text and text ~= '' then
					if current == maximum then text = '|c00FF00'..text..'|r' end
					quest.work[cId] = text
					out = out..'\n'..text
				end
			end
			CS_QuestText:SetText(out)
			return
		end
	end
end
function CS.UpdateInventory()
	local inv = {
		ZO_PlayerInventoryBackpack,ZO_PlayerBankBackpack,ZO_GuildBankBackpack,
		ZO_SmithingTopLevelDeconstructionPanelInventoryBackpack,
		ZO_SmithingTopLevelImprovementPanelInventoryBackpack
	}
	for x = 1,#inv do
		local puffer = inv[x].dataTypes[1].setupCallback
		inv[x].dataTypes[1].setupCallback = function(control,slot)
			puffer(control,slot)
			CS.SetItemMark(control,1)
		end
	end
    local puffer1 = ZO_LootAlphaContainerList.dataTypes[1].setupCallback
    ZO_LootAlphaContainerList.dataTypes[1].setupCallback = function(control,slot)
		puffer1(control,slot)
		CS.SetItemMark(control,2)
	end
end
function CS.UpdateGuildStore()
    local puffer = TRADING_HOUSE.m_searchResultsList.dataTypes[1].setupCallback
    TRADING_HOUSE.m_searchResultsList.dataTypes[1].setupCallback = function(control,slot)
		puffer(control,slot)
		CS.SetItemMark(control,3)
	end
end
function CS.UpdateStored(action,data)
	local link, owner = data.lnk, CURRENT_PLAYER
	local craft,line,trait = CS.GetTrait(link)
	local function CompareItem(craft,line,trait,q1,l1,v1)
		if not CS.account.crafting.stored[craft][line][trait].link then return true else
			local q2 = GetItemLinkQuality(CS.account.crafting.stored[craft][line][trait].link)
			local l2 = GetItemLinkRequiredLevel(CS.account.crafting.stored[craft][line][trait].link)
			local v2 = GetItemLinkRequiredVeteranRank(CS.account.crafting.stored[craft][line][trait].link)
			if q1 < q2 then return true end if l1 < l2 then return true end if v1 < v2 then return true end return false
		end
	end
	if craft and line and trait then
		if action == 'added' then
			if data.bagId == BAG_BANK then owner = L.bank end
			if data.bagId == BAG_GUILDBANK then owner = L.guildbank end
			if CompareItem(craft,line,trait,GetItemLinkQuality(link),GetItemLinkRequiredLevel(link),GetItemLinkRequiredVeteranRank(link)) then
				CS.account.crafting.stored[craft][line][trait] = { link = link, owner = owner, id = data.uid }
			end
		end
		if action == 'removed' and CS.account.crafting.stored[craft][line][trait].id == data.uid then
			CS.account.crafting.stored[craft][line][trait] = {}
		end
		CS.UpdatePanelIcon(craft,line,trait)
	end
end

function CS.RecipeMark(control,button)
	local mark
	if button == 2 then ToChat(control.data.link)
	else
		local tracked = CS.account.cook.ingredients[control.data.id] or false
		if tracked then
			mark = ''
			CS.account.cook.ingredients[control.data.id] = nil
		else
			mark = '|t22:22:esoui/art/inventory/newitem_icon.dds|t '
			CS.account.cook.ingredients[control.data.id] = true
		end
		control:SetText(mark..'('..COOK.recipe[control.data.rec].level..') '..COOK.recipe[control.data.rec].name)
		zo_callLater(CS.UpdateIngredientTracking,500)
	end
end
function CS.RecipeShow(id,inc,known)
	local color, mark, control
	if CS.account.cook.ingredients[COOK.recipe[id].id] then mark = '|t22:22:esoui/art/inventory/newitem_icon.dds|t ' else mark = '' end
	if COOK.recipe[id].known then color = QUALITY[COOK.recipe[id].quality]; known = known + 1; else color = {1,0,0,1} end
	control = WM:GetControlByName('CS_RecipePanelScrollChildButton'..inc)
	control:SetNormalFontColor(color[1],color[2],color[3],color[4])
	control:SetText(mark..'('..COOK.recipe[id].level..') '..COOK.recipe[id].name)
	control:SetHidden(false)
	control.data = {link = COOK.recipe[id].link, rec = id, id = COOK.recipe[id].id, buttons = {L.TT[7],L.TT[6]}}
	return inc + 1, known
end
function CS.RecipeShowCategory(list)
	if list > 15 then list = 1 end
	local inc, known = 1, 0
	for x = 1,50 do WM:GetControlByName('CS_RecipePanelScrollChildButton'..x):SetHidden(true) end
	for id, recipe in pairs(COOK.recipe) do
		if recipe.stat == list then inc,known = CS.RecipeShow(id,inc,known) end
	end
	CS_RecipePanelScrollChild:SetHeight(inc * 22 - 13)
	CS_RecipeHeadline:SetText(ZOSF('<<C:1>>',GetRecipeListInfo(list)))
	-- CS_RecipeInfo:SetText(COOK.category[list]..' ('..known..'/'..(inc - 1)..')')
	CS_RecipeInfo:SetText('('..known..' / '..(inc - 1)..')')
	CS.character.recipe = list
end
function CS.RecipeSearch()
	local search, inc, known = CS_RecipeSearch:GetText(), 1, 0
	if search ~= '' then
		for x = 1,50 do
			local control = WM:GetControlByName('CS_RecipePanelScrollChildButton'..x)
			control:SetHidden(true)
			control.data = nil
		end
		for id, food in pairs(COOK.recipe) do
			if string.find(string.lower(food.name),string.lower(search)) then inc,known = CS.RecipeShow(id,inc,known) end
		end
		CS_RecipePanelScrollChild:SetHeight(inc * 22 - 13)
		CS_RecipeHeadline:SetText(L.searchfor)
		CS_RecipeInfo:SetText(search..' ('..(inc - 1)..')')
	end
end
function CS.RecipeLearned(list,id)
	local link = GetRecipeResultItemLink(list,id,LINK_STYLE_DEFAULT)
	if link then for id, recipe in pairs(COOK.recipe) do
		if recipe.result == link then
			COOK.recipe[id].known = true
			CS.account.cook.knowledge[CURRENT_PLAYER][COOK.recipe[id].id] = true
			break
		end
	end end
end

function CS.CookStart(control,button)
	if not control then return end
	if button == 3 then
		local idx = control.data.list..'_'..control.data.id
		if CS.character.favorites[5][idx] then CS.character.favorites[5][idx] = nil
		else CS.character.favorites[5][idx] = {control.data.list, control.data.id} end
		CS.CookShowRecipe(control,control.data.list,control.data.id,0)
		return
	end
	if control.data.craftable then
		if GetNumBagFreeSlots(BAG_BACKPACK) > 0 then
			local amount = (tonumber(CS_CookAmount:GetText()) or 1)
			if button == 2 then amount = control.data.crafting[2] end
			if amount > MAXCRAFT then amount = MAXCRAFT end
			CS_CookAmount:SetText(amount)
			if amount > 1 then COOK.job = {amount = amount - 1, list = control.data.list, id = control.data.id, sound = control.data.sound} end
			CraftProvisionerItem(control.data.list, control.data.id)
			PlaySound(control.data.sound)
		else d(L.nobagspace) end
	end
end
function CS.CookShowRecipe(control,list,id,inc,sound)
	local known, name, numIngredients, pLev, qLev = GetRecipeInfo(list,id)
	local mark = ''
	if known then
		local fault, maxval, ing = false, 999999, {}
		local link = GetRecipeResultItemLink(list,id,LINK_STYLE_DEFAULT)
		local level = GetItemLinkRequiredLevel(link) + GetItemLinkRequiredVeteranRank(link)
		if level == 51 then level = 50 end
		for num = 1, numIngredients do
			local count, color = GetCurrentRecipeIngredientCount(list,id,num)
			if count == 0 then color = 'FF0000'; fault = true else color = '00FF00' end
			if count < maxval then maxval = count end
			table.insert(ing,ZOSF('<<C:1>> |c<<2>>(<<3>>)|r',GetRecipeIngredientItemLink(list,id,num,LINK_STYLE_DEFAULT),color,count))
		end
		if CS.character.favorites[5][list..'_'..id] then mark = '|t16:16:CraftStore/star.dds|t ' else mark = '' end
		control:SetText(ZOSF(mark..'(<<1>>) <<C:2>> |c666666(<<3>>)|r',level,name,maxval))
		if fault or pLev > COOK.craftLevel or qLev > COOK.qualityLevel then
			control:SetNormalFontColor(1,0,0,1)
			fault = true
		else
			local color = GetItemLinkQuality(link)
			control:SetNormalFontColor(QUALITY[color][1],QUALITY[color][2],QUALITY[color][3],1)
		end
		control.data = {id = id, list = list, link = link, sound = sound, crafting = {CS_CookAmount,maxval}, addline = {table.concat(ing,'\n')}, craftable = not fault}
		control:SetHidden(false)
		return inc + 1
	end
	return inc
end
function CS.CookShowCategory(list)
	if not list then return end
	local inc, control, name, num = 1
	for x = 1,50 do CS_CookFoodSectionScrollChild:GetNamedChild('Button'..x):SetHidden(true) end
	if list == 17 then
		name = L.TT[11]
		for _,val in pairs(CS.character.favorites[5]) do
			control = CS_CookFoodSectionScrollChild:GetNamedChild('Button'..inc)
			inc = CS.CookShowRecipe(control,val[1],val[2],inc)
		end
	else 
		local _,num,_,_,_,_,sound = GetRecipeListInfo(list)
		for id = num, 1, -1 do
			control = CS_CookFoodSectionScrollChild:GetNamedChild('Button'..inc)
			inc = CS.CookShowRecipe(control,list,id,inc,sound)
		end
	end
	CS_CookFoodSectionScrollChild:SetHeight(inc * 24 - 15)
	CS_CookHeadline:SetText(ZOSF('<<C:1>>',name))
	CS_CookInfo:SetText(COOK.category[list])
	CS.character.recipe = list
end
function CS.CookSearchRecipe()
	local search, inc, control = CS_CookSearch:GetText(), 1
	if search ~= '' then
		for x = 1,50 do CS_CookFoodSectionScrollChild:GetNamedChild('Button'..x):SetHidden(true) end
		for list = 1, GetNumRecipeLists() do
			local _,num = GetRecipeListInfo(list)
			for id = num, 1, -1 do
				local known, name = GetRecipeInfo(list,id)
				if string.find(string.lower(name),string.lower(search)) and known then
					control = CS_CookFoodSectionScrollChild:GetNamedChild('Button'..inc)
					inc = CS.CookShowRecipe(control,list,id,inc)
				end
			end
		end
		CS_CookFoodSectionScrollChild:SetHeight(inc * 23 - 10)
		CS_CookHeadline:SetText(L.searchfor)
		CS_CookInfo:SetText(search)
	end
end

function CS.RuneCreate(control,button)
	if not control then return end
	if EXTERN and button == 2 then ToChat(control.data.link); return end
	if button == 3 then
		local id, idx = control.data.glyph, control.data.glyph..'_'..control.data.quality..'_'..control.data.level
		if CS.character.favorites[3][idx] then CS.character.favorites[3][idx] = nil
		else CS.character.favorites[3][idx] = { id, control.data.level, control.data.quality, control.data.essence, control.data.potencyType } end
		CS.RuneShow(control.data.nr ,id, control.data.quality, control.data.level, control.data.essence, control.data.potencyType)
		return
	end
	if control.data.craftable and not EXTERN then
		if GetNumBagFreeSlots(BAG_BACKPACK) > 0 then
			local amount = (tonumber(CS_RuneAmount:GetText()) or 1)
			if button == 2 then amount = control.data.crafting[2] end
			if amount > MAXCRAFT then amount = MAXCRAFT end
			CS_RuneAmount:SetText(amount)
			if amount > 1 then RUNE.job = {amount = amount - 1, id = {control.data.potency,control.data.essence,control.data.aspect}} end
			local bagP, slotP = CS.ScanBag(control.data.potency)
			local bagE, slotE = CS.ScanBag(control.data.essence)
			local bagA, slotA = CS.ScanBag(control.data.aspect)
			CraftEnchantingItem(bagP,slotP,bagE,slotE,bagA,slotA)
			if CS.account.option[13] then
				local soundP, lengthP = GetRunestoneSoundInfo(bagP,slotP)
				local soundE, lengthE = GetRunestoneSoundInfo(bagE,slotE)
				local soundA, _ = GetRunestoneSoundInfo(bagA,slotA)
				PlaySound(soundP)
				zo_callLater(function() PlaySound(soundE) end, lengthP)
				zo_callLater(function() PlaySound(soundA) end, lengthE + lengthP)
			else
				PlaySound('Enchanting_Create_Tooltip_Glow')
			end
		else d(L.nobagspace) end
	end
end
function CS.RuneGetGylphs()
	local bag = SHARED_INVENTORY:GenerateFullSlotData(nil,BAG_BANK,BAG_BACKPACK)
	local glyphs = {}
	for _, data in pairs(bag) do
		local item = data.itemType
		local link = GetItemLink(data.bagId, data.slotIndex)
		local icon = GetItemLinkInfo(link)
		if item == ITEMTYPE_GLYPH_ARMOR or item == ITEMTYPE_GLYPH_WEAPON or item == ITEMTYPE_GLYPH_JEWELRY then
			table.insert(glyphs,{ name = ZOSF('<<C:1>>',data.name), icon = icon, link = link, quality = data.quality, bag = data.bagId, slot = data.slotIndex, crafted = IsItemLinkCrafted(link) })
		end
	end
	return glyphs
end
function CS.RuneGetLink(id,quality,rank)
	local color = {19,19,19,19,19,19,19,19,19,115,117,119,121,271,307,365,[0] = 0}
	local adder = {1,1,1,1,1,1,1,1,1,10,10,10,10,1,1,1,[0] = 0}
	local level = {5,10,15,20,25,30,35,40,45,50,50,50,50,50,50,50,[0] = 0}
	return ('|H1:item:%u:%u:%u:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(id,(color[rank] + quality * adder[rank]),level[rank])
end
function CS.RuneSetValue(key,value,ptype)
	if key == 1 then CS.character.enchant = value
	elseif key == 2 then CS.character.aspect = value; CS_RuneLevelButton:SetNormalFontColor(QUALITY[value][1],QUALITY[value][2],QUALITY[value][3],1)
	elseif key == 3 then CS.character.potency = value; if ptype then CS.character.potencytype = ptype end
	elseif key == 4 then CS.character.essence = value
	elseif key == 5 then CS.character.runemode = 'search'
	elseif key == 6 then CS.character.runemode = 'craft'
	elseif key == 7 then CS.character.runemode = 'refine'
	elseif key == 9 then CS.character.runemode = 'selection'
	elseif key == 10 then CS.character.runemode = 'favorites'
	end
end
function CS.RuneShow(nr,id,quality,level,essence,potencytype)
	local bank, bag, mark, control, color, maxval, fault, addline, countcol, col
	control = WM:GetControlByName('CS_RuneGlyphSectionScrollChildButton'..nr)
	local link = CS.RuneGetLink(id,quality,level)
	local icon = GetItemLinkInfo(link)
	local basename = ZOSF('<<C:1>>',GetItemLinkName(('|H1:item:%u:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(id)))
	local potencyId, essenceId, aspectId = RUNE.rune[51][potencytype][level], essence, RUNE.rune[52][quality]
	local potencyLink, essenceLink,aspectLink = CS.RuneGetLink(potencyId,1,1), CS.RuneGetLink(essenceId,1,1), CS.RuneGetLink(aspectId,quality,1)
	local potencySkill, aspectSkill = RUNE.skillLevel[level], quality - 1
	bag, bank = GetItemLinkStacks(potencyLink)
	local potencyCount = bag + bank
	bag, bank = GetItemLinkStacks(essenceLink)
	local essenceCount = bag + bank
	bag, bank = GetItemLinkStacks(aspectLink)
	local aspectCount = bag + bank
	maxval = math.min(potencyCount, essenceCount, aspectCount)
	if maxval == 0 or (aspectSkill > RUNE.aspectSkill or potencySkill > RUNE.potencySkill) then color = {1,0,0}; fault = true else color = QUALITY[quality]; fault = false end
	if CS.character.favorites[3][id..'_'..quality..'_'..level] then mark = '|t16:16:CraftStore/star.dds|t ' else mark = '' end
	control:SetText(mark..'|t24:24:'..icon..'|t '..basename..' |c666666('..maxval..')|r')
	control:SetNormalFontColor(color[1],color[2],color[3],1)
	if potencyCount == 0 or potencySkill > RUNE.potencySkill then col = 'FF0000' else col = 'FFFFFF' end
	if potencyCount == 0 then countcol = 'FF0000' else countcol = '00FF00' end
	addline = '|t22:22:'..GetItemLinkInfo(potencyLink)..'|t |c'..col..ZOSF('<<C:1>>',GetItemLinkName(potencyLink))..' |c'..countcol..'('..potencyCount..')|r'
	if essenceCount == 0 then col = 'FF0000' else col = 'FFFFFF' end
	if essenceCount == 0 then countcol = 'FF0000' else countcol = '00FF00' end
	addline = addline..'|r  |t22:22:'..GetItemLinkInfo(essenceLink)..'|t |c'..col..ZOSF('<<C:1>>',GetItemLinkName(essenceLink))..' |c'..countcol..'('..essenceCount..')|r'
	if aspectCount == 0 or aspectSkill > RUNE.aspectSkill then col = 'FF0000' else col = QUALITYHEX[quality] end
	if aspectCount == 0 then countcol = 'FF0000' else countcol = '00FF00' end
	addline = addline..'|r  |t22:22:'..GetItemLinkInfo(aspectLink)..'|t |c'..col..ZOSF('<<C:1>>',GetItemLinkName(aspectLink))..' |c'..countcol..'('..aspectCount..')|r'
	control:SetHidden(false)
	control.data = {
		nr = nr, link = link, addline = {addline}, crafting = {CS_RuneAmount,maxval}, craftable = not fault, 
		quality = quality, level = level, glyph = id, potency = potencyId, essence = essenceId, aspect = aspectId, potencyType = potencytype
	}
end
function CS.RuneShowCategory()
	local count = 1
	CS_RuneInfo:SetText(GetString(SI_CRAFTING_PERFORM_FREE_CRAFT))
	local function tsort(a,b) return a[4] < b[4] end
	table.sort(RUNE.glyph[CS.character.enchant],tsort)
	for _,glyph in pairs(RUNE.glyph[CS.character.enchant]) do
		CS.RuneShow(count,glyph[1],CS.character.aspect,CS.character.potency,glyph[2],glyph[3])
		count = count + 1
	end
	CS_RuneGlyphSectionScrollChild:SetHeight(#RUNE.glyph[CS.character.enchant] * 30 + 20)
end
function CS.RuneRefine(control)
	if GetNumBagFreeSlots(BAG_BACKPACK) >= 3 then
		ExtractEnchantingItem(control.data.bag, control.data.slot)
		PlaySound('Enchanting_Extract_Start_Anim')
	else d(L.nobagspace) end
end
function CS.RefineAll(_,button)
	RUNE.refine = {glyphs = CS.RuneGetGylphs(), crafted = (button == 2)}
	if RUNE.refine.glyphs[1].crafted and not RUNE.refine.crafted then table.remove(RUNE.refine.glyphs,1) end
	if RUNE.refine.glyphs[1] then
		if GetNumBagFreeSlots(BAG_BACKPACK) >= 3 then
			ExtractEnchantingItem(RUNE.refine.glyphs[1].bag, RUNE.refine.glyphs[1].slot)
			PlaySound('Enchanting_Extract_Start_Anim')
			table.remove(RUNE.refine.glyphs,1)
		else d(L.nobagspace) end
	end
end
function CS.RuneShowMode()
	GlyphDivider:SetHidden(true)
	CS_RuneGlyphSectionScrollChildRefine:SetHidden(true)
	CS_RuneGlyphSectionScrollChildSelection:SetHidden(true)
	CS_RuneRefineAllButton:SetHidden(true)
	for x = 1,25 do WM:GetControlByName('CS_RuneGlyphSectionScrollChildButton'..x):SetHidden(true) end
	if CS.character.runemode == 'craft' then CS.RuneShowCategory()
	elseif CS.character.runemode == 'search' then CS.RuneSearch()
	elseif CS.character.runemode == 'refine' then CS.RuneShowRefine()
	elseif CS.character.runemode == 'selection' then CS.RuneShowSelection()
	elseif CS.character.runemode == 'favorites' then CS.RuneShowFavorites() end
end
function CS.RuneShowRefine()
	CS_RuneInfo:SetText(GetString(SI_CRAFTING_PERFORM_EXTRACTION))
	CS_RuneGlyphSectionScrollChildRefine:SetHidden(false)
	CS_RuneRefineAllButton:SetHidden(false)
	for x = 1, CS_RuneGlyphSectionScrollChildRefine:GetNumChildren() do
		CS_RuneGlyphSectionScrollChildRefine:GetChild(x):SetHidden(true)
		CS_RuneGlyphSectionScrollChildRefine:GetChild(x):ClearAnchors()
	end
	local count, crafted = 0
	for x, glyph in pairs(CS.RuneGetGylphs()) do
		local c = WM:GetControlByName('CS_GlyphControl'..x)
		if not c then
			c = WM:CreateControl('CS_GlyphControl'..x,CS_RuneGlyphSectionScrollChildRefine,CT_BUTTON)
			c:SetAnchor(TOPLEFT,CS_RuneGlyphSectionScrollChild,TOPLEFT,8,5 + (x - 1) * 30)
			c:SetDimensions(508,30)
			c:SetFont('ZoFontGame')
			c:SetClickSound('Click')
			c:SetMouseOverFontColor(1,0.66,0.2,1)
			c:SetHorizontalAlignment(0)
			c:SetVerticalAlignment(1)
			c:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Rune,'tl') end)
			c:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
			c:SetHandler('OnClicked',function(self) CS.RuneRefine(self) end)
		end
		if glyph.crafted then crafted = '|t22:22:CraftStore/hand.dds|t ' else crafted = '' end
		c:SetHidden(false)
		c:SetText(crafted..'|t24:24:'..glyph.icon..'|t '..glyph.name)
		c:SetNormalFontColor(QUALITY[glyph.quality][1],QUALITY[glyph.quality][2],QUALITY[glyph.quality][3],1)
		c.data = { link = glyph.link, bag = glyph.bag, slot = glyph.slot, buttons = {L.TT[8]} }
		count = count + 1
	end
	CS_RuneGlyphSectionScrollChild:SetHeight(count * 30 + 20)
end
function CS.RuneShowSelection()
	local color, count = 'FFFFFF', 0
	local function RuneSelected()
		local essence = SplitLink(CS.RuneGetLink(RUNE.rune[ITEMTYPE_ENCHANTING_RUNE_ESSENCE][CS.character.essence],1,1),3)
		for _, enchant in pairs(RUNE.glyph) do
			for _, glyph in pairs(enchant) do
				if glyph[2] == essence and glyph[3] == CS.character.potencytype then
					CS.RuneShow(1,glyph[1],CS.character.aspect,CS.character.potency,essence,glyph[3])
					return
				end
			end
		end
	end
	for x,rune in pairs(RUNE.rune[ITEMTYPE_ENCHANTING_RUNE_POTENCY][1]) do
		local link = CS.RuneGetLink(rune,1,1)
		local known = GetItemLinkEnchantingRuneName(link)
		local bag, bank = GetItemLinkStacks(link)
		count = bag + bank
		color = QUALITY[GetItemLinkQuality(link)]
		if count == 0 then color = {0.4,0.4,0.4} end
		if not known then color = {1,0,0} end
		local btn = WM:GetControlByName('CS_RuneGlyphSectionScrollChild1Selector'..x)
		if not btn then
			btn = WM:CreateControl('CS_RuneGlyphSectionScrollChild1Selector'..x,CS_RuneGlyphSectionScrollChildSelection,CT_BUTTON)
			btn:SetAnchor(3,nil,3,8,50 + (x-1) * 30)
			btn:SetDimensions(160,30)
			btn:SetFont('ZoFontGame')
			btn:EnableMouseButton(2,true)
			btn:SetClickSound('Click')
			btn:SetNormalFontColor(color[1],color[2],color[3],1)
			btn:SetMouseOverFontColor(1,0.66,0.2,1)
			btn:SetHorizontalAlignment(0)
			btn:SetVerticalAlignment(1)
			btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Rune,'tl') end)
			btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
			btn:SetHandler('OnMouseDown',function(self,button)
				if button == 1 then
					CS.RuneSetValue(3,x,1)
					CS_RuneLevelButton:SetText(L.level..': '..RUNE.level[x])
					CS_RuneHighlight1:SetAnchor(2,WM:GetControlByName('CS_RuneGlyphSectionScrollChild1Selector'..x),2,-14,0)
					RuneSelected()
				elseif button == 2 then ToChat(link) end
			end)
		end
		btn:SetText('|t24:24:'..GetItemLinkInfo(link)..'|t '..ZOSF('<<C:1>>',GetItemLinkName(link))..' |c666666('..count..')')
		btn.data = { link = link, addline = {'|cFFAA33CraftStoreRune:|r '..L.level..' '..RUNE.level[x]} }
	end
	for x,rune in pairs(RUNE.rune[ITEMTYPE_ENCHANTING_RUNE_POTENCY][2]) do
		local link = CS.RuneGetLink(rune,1,1)
		local known = GetItemLinkEnchantingRuneName(link)
		local bag, bank = GetItemLinkStacks(link)
		count = bag + bank
		color = QUALITY[GetItemLinkQuality(link)]
		if count == 0 then color = {0.4,0.4,0.4} end
		if not known then color = {1,0,0} end
		local btn = WM:GetControlByName('CS_RuneGlyphSectionScrollChild2Selector'..x)
		if not btn then
			btn = WM:CreateControl('CS_RuneGlyphSectionScrollChild2Selector'..x,CS_RuneGlyphSectionScrollChildSelection,CT_BUTTON)
			btn:SetAnchor(3,nil,3,170,50 + (x-1) * 30)
			btn:SetDimensions(160,30)
			btn:SetFont('ZoFontGame')
			btn:EnableMouseButton(2,true)
			btn:SetClickSound('Click')
			btn:SetNormalFontColor(color[1],color[2],color[3],1)
			btn:SetMouseOverFontColor(1,0.66,0.2,1)
			btn:SetHorizontalAlignment(0)
			btn:SetVerticalAlignment(1)
			btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Rune,'tl') end)
			btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
			btn:SetHandler('OnMouseDown',function(self,button)
				if button == 1 then
					CS.RuneSetValue(3,x,2)
					CS_RuneLevelButton:SetText(L.level..': '..RUNE.level[x])
					CS_RuneHighlight1:SetAnchor(2,WM:GetControlByName('CS_RuneGlyphSectionScrollChild2Selector'..x),2,-14,0)
					RuneSelected()
				elseif button == 2 then ToChat(link) end
			end)
		end
		btn:SetText('|t24:24:'..GetItemLinkInfo(link)..'|t '..ZOSF('<<C:1>>',GetItemLinkName(link))..' |c666666('..count..')')
		btn.data = { link = link, addline = {'|cFFAA33CraftStoreRune:|r '..L.level..' '..RUNE.level[x]} }
	end
	for x,rune in pairs(RUNE.rune[ITEMTYPE_ENCHANTING_RUNE_ESSENCE]) do
		local link = CS.RuneGetLink(rune,1,1)
		local known = GetItemLinkEnchantingRuneName(link)
		local bag, bank = GetItemLinkStacks(link)
		count = bag + bank
		color = QUALITY[GetItemLinkQuality(link)]
		if count == 0 then color = {0.4,0.4,0.4} end
		if not known then color = {1,0,0} end
		local btn = WM:GetControlByName('CS_RuneGlyphSectionScrollChild3Selector'..x)
		if not btn then
			btn = WM:CreateControl('CS_RuneGlyphSectionScrollChild3Selector'..x,CS_RuneGlyphSectionScrollChildSelection,CT_BUTTON)
			btn:SetAnchor(3,nil,3,332,50 + (x-1) * 30)
			btn:SetDimensions(160,30)
			btn:SetFont('ZoFontGame')
			btn:EnableMouseButton(2,true)
			btn:SetClickSound('Click')
			btn:SetNormalFontColor(color[1],color[2],color[3],1)
			btn:SetMouseOverFontColor(1,0.66,0.2,1)
			btn:SetHorizontalAlignment(0)
			btn:SetVerticalAlignment(1)
			btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Rune,'tl') end)
			btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
			btn:SetHandler('OnMouseDown',function(self,button)
				if button == 1 then
					CS_RuneHighlight2:SetAnchor(2,WM:GetControlByName('CS_RuneGlyphSectionScrollChild3Selector'..x),2,-14,0)
					CS.RuneSetValue(4,x)
					RuneSelected()
				elseif button == 2 then ToChat(link) end
			end)
		end
		btn:SetText('|t24:24:'..GetItemLinkInfo(link)..'|t '..ZOSF('<<C:1>>',GetItemLinkName(link))..' |c666666('..count..')')
		btn.data = { link = link }
	end
	local dot = WM:GetControlByName('CS_RuneHighlight1')
	if not dot then
		dot = WM:CreateControl('CS_RuneHighlight1',CS_RuneGlyphSectionScrollChildSelection,CT_TEXTURE)
		dot:SetAnchor(2,WM:GetControlByName('CS_RuneGlyphSectionScrollChild'..CS.character.potencytype..'Selector'..CS.character.potency),2,-14,0)
		dot:SetDimensions(48,48)
		dot:SetColor(1,1,1,1)
		dot:SetTexture('esoui/art/quickslots/quickslot_highlight_blob.dds')
	end
	dot = WM:GetControlByName('CS_RuneHighlight2')
	if not dot then
		dot = WM:CreateControl('CS_RuneHighlight2',CS_RuneGlyphSectionScrollChildSelection,CT_TEXTURE)
		dot:SetAnchor(2,WM:GetControlByName('CS_RuneGlyphSectionScrollChild3Selector'..CS.character.essence),2,-14,0)
		dot:SetDimensions(48,48)
		dot:SetColor(1,1,1,1)
		dot:SetTexture('esoui/art/quickslots/quickslot_highlight_blob.dds')
	end
	GlyphDivider:SetHidden(false)
	CS_RuneGlyphSectionScrollChildSelection:SetHidden(false)
	CS_RuneInfo:SetText(GetString(SI_CRAFTING_PERFORM_FREE_CRAFT))
	RuneSelected()
end
function CS.RuneSearch()
	local search, count = CS_RuneSearch:GetText(), 1
	if search ~= '' then
		for _,enchant in pairs(RUNE.glyph) do
			for _,glyph in pairs(enchant) do
				local basename = ZOSF('<<C:1>>',GetItemLinkName(('|H1:item:%u:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h'):format(glyph[1])))
				if string.find(string.lower(basename),string.lower(search)) then
					CS.RuneShow(count,glyph[1],CS.character.aspect,CS.character.potency,glyph[2],glyph[3])
					count = count + 1
				end
			end
		end
		CS_RuneGlyphSectionScrollChild:SetHeight(count * 24 + 20)
		CS_RuneInfo:SetText(L.searchfor..' '..search)
	end
end
function CS.RuneShowFavorites()
	local count = 1
	for _,glyph in pairs(CS.character.favorites[3]) do CS.RuneShow(count,glyph[1],glyph[3],glyph[2],glyph[4],glyph[5]); count = count + 1 end
	CS_RuneGlyphSectionScrollChild:SetHeight(#CS.character.favorites[3] * 24 + 20)
	CS_RuneInfo:SetText(L.TT[11])
end
function CS.RuneView(mode)
	local function Close()
		CS_Rune:SetHidden(true)
		CS_RuneCreateButton:SetHidden(false)
		CS_RuneRefineButton:SetHidden(false)
		CS_RuneHeader:SetWidth(440)
		CS_RuneSearch:SetWidth(150)
		CS_RuneSearchBG:SetWidth(160)
		CS_RuneInfo:SetHidden(false)
		CS_RuneAmount:SetHidden(false)
		CS_RuneAmountLabel:SetHidden(false)
		EXTERN = false
	end
	if ZO_EnchantingTopLevel:IsHidden() then
		if mode == 1 and CS_Rune:IsHidden() then
			CS_RuneCreateButton:SetHidden(true)
			CS_RuneRefineButton:SetHidden(true)
			CS_RuneHeader:SetWidth(522)
			CS_RuneSearch:SetWidth(290)
			CS_RuneSearchBG:SetWidth(300)
			CS_RuneInfo:SetHidden(true)
			CS_RuneAmount:SetHidden(true)
			CS_RuneAmountLabel:SetHidden(true)
			EXTERN = true
			CS.character.runemode = 'craft'
			CS.RuneInitalize()
		else Close() end
	end
end
function CS.RuneInitalize()
	RUNE.aspectSkill = GetNonCombatBonus(NON_COMBAT_BONUS_ENCHANTING_RARITY_LEVEL)
	RUNE.potencySkill = GetNonCombatBonus(NON_COMBAT_BONUS_ENCHANTING_LEVEL)
	CS_RuneLevelButton:SetNormalFontColor(QUALITY[CS.character.aspect][1],QUALITY[CS.character.aspect][2],QUALITY[CS.character.aspect][3],1)
	CS.RuneShowMode()
	CS_RuneAmount:SetText('')
	CS_RuneSearch:SetText(GetString(SI_GAMEPAD_HELP_SEARCH)..'...')
	CS_Rune:SetHidden(false)
end

function CS.SetTimer(control,hour)
	local seconds = hour * 3600
	if CS.account.timer[hour] > 0 then
		control:SetText(hour..':00h')
		CS.account.timer[hour] = 0
	else 
		control:SetText(CS.GetTime(seconds - 1))
		CS.account.timer[hour] = seconds + GetTimeStamp()
	end
	CS.GetTimer()
end
function CS.SetItemMark(control,linksource)
	if not control then return end
	local function GetMark(control)
		local name = control:GetName()
		if not ITEMMARK[name] then ITEMMARK[name] = WM:CreateControl(name..'CSMark',control,CT_TEXTURE) end
		ITEMMARK[name]:SetDrawLayer(3)
		ITEMMARK[name]:SetDimensions(30,30)
		ITEMMARK[name]:SetHidden(true)
		ITEMMARK[name]:ClearAnchors()
		return ITEMMARK[name]
	end
	local function Show(mark,icon,color)
		if color == false then color = {1,0,1}
		elseif color == true then color = {1,0,0} end		
		mark:SetColor(color[1],color[2],color[3],0.8)
		mark:SetHidden(false)
		if (control:GetWidth() - control:GetHeight()) > 5 then mark:SetAnchor(LEFT,control:GetNamedChild('Bg'),LEFT,0,0)
		else mark:SetAnchor(TOPLEFT,control:GetNamedChild('Bg'),TOPLEFT,-4,-4) end
		mark:SetTexture(icon)
	end
    local slot, link = control.dataEntry.data or nil, nil
	local uid = Id64ToString(GetItemUniqueId(slot.bagId,slot.slotIndex)) or nil
	if linksource == 3 then link = GetTradingHouseSearchResultItemLink(slot.slotIndex); uid = nil
	elseif linksource == 2 then link = GetLootItemLink(slot.lootId); uid = nil
	elseif linksource == 1 then link = GetItemLink(slot.bagId,slot.slotIndex) end
	if not slot or not link then return end
	local mark = GetMark(control)
	if CS.account.option[11] then
		local trait = GetItemTrait(slot.bagId,slot.slotIndex)
		if trait == ITEM_TRAIT_TYPE_ARMOR_INTRICATE or trait == ITEM_TRAIT_TYPE_WEAPON_INTRICATE then
			Show(mark,'esoui/art/icons/servicemappins/servicepin_smithy.dds',{0,1,1}); return
		elseif trait == ITEM_TRAIT_TYPE_ARMOR_ORNATE or trait == ITEM_TRAIT_TYPE_WEAPON_ORNATE or trait == ITEM_TRAIT_TYPE_JEWELRY_ORNATE then
			Show(mark,'esoui/art/guild/guild_tradinghouseaccess.dds',{1,1,0}); return
		end 
	end
	if CS.account.option[10] then
		local item = (slot.itemType or GetItemLinkItemType(link))
		if item == ITEMTYPE_INGREDIENT then
			local ingid = SplitLink(link,3)
			if ingid then if COOK.ingredient[ingid] then Show(mark,'esoui/art/inventory/newitem_icon.dds',{0,1,0}); return end end
		end
		if item == ITEMTYPE_RACIAL_STYLE_MOTIF then
			if CS.IsStyleNeeded(link) ~= '' then Show(mark,'esoui/art/inventory/newitem_icon.dds',SELF); return end
		end
		if item == ITEMTYPE_RECIPE then
			if CS.IsRecipeNeeded(link) ~= '' then Show(mark,'esoui/art/inventory/newitem_icon.dds',SELF); return end
		end
		local craft,line,trait = CS.GetTrait(link)
		if craft and line and trait then
			if CS.IsItemNeeded(craft,line,trait,uid,link) ~= '' then
				Show(mark,'esoui/art/inventory/newitem_icon.dds',SELF)
				return
			end
		end
	end
end
function CS.SetAllStyles()
	if MODE == 1 then CS_Style:SetHidden(true); MODE = 0; return end
	CS_StylePanelScrollChildStyles:SetHidden(false)
	CS_StylePanelScrollChildSets:SetHidden(true)
	CS_StyleHeader:SetText('CraftStoreStyles')
	CS.ControlShow(CS_Style)
	MODE = 1
end
function CS.CloseStyle()
	CS_Style:SetHidden(true)
	ACHIEVEMENTS.popup:Hide()
	MODE = 0
end
function CS.HideStyles(init)
	local val, tex, h = {[true]='checked',[false]='unchecked'}, '|t16:16:esoui/art/buttons/checkbox_<<1>>.dds|t |t2:2:x.dds|t ', {[true]=0,[false]=90}
	if not init then CS.character.hidestyles = not CS.character.hidestyles end
	CS_StyleHideButton:SetText(ZOSF(tex,val[CS.character.hidestyles])..L.hideStyles)
	for id = 1,GetNumSmithingStyleItems() do
		local _, _, _, _, style = GetSmithingStyleItemInfo(id)
		if style ~= ITEMSTYLE_UNIVERSAL and style ~= ITEMSTYLE_NONE then
			if cs_style.IsRegular(id) then
				local c = WM:GetControlByName('CS_StyleRow'..id)
				c:SetHidden(CS.character.hidestyles)
				c:SetHeight(h[CS.character.hidestyles])
			end
		end
	end
end

function CS.GetQuest()
	local function GetQuestCraft(qName)
		local craftString={
			[CRAFTING_TYPE_BLACKSMITHING]={'blacksmith','schmied','forge','forgeron'},
			[CRAFTING_TYPE_CLOTHIER]={'cloth','schneider','tailleur'},
			[CRAFTING_TYPE_ENCHANTING]={'enchant','verzauber','enchantement','enchanteur'},
			[CRAFTING_TYPE_ALCHEMY]={'alchemist','alchemie','alchimie','alchimiste'},
			[CRAFTING_TYPE_PROVISIONING]={'provision','versorg','cuisine','cuisinier'},
			[CRAFTING_TYPE_WOODWORKING]={'woodwork','schreiner','travail du bois'}
		}
		for x, craft in pairs(craftString) do
			for _,s in pairs(craft) do if string.find(string.lower(qName),s)then return x end end
		end
		return false
	end
	QUEST = {}
	for qId = 1, MAX_JOURNAL_QUESTS do
		if IsValidQuestIndex(qId) then
			if GetJournalQuestType(qId) == QUEST_TYPE_CRAFTING then
				local qName,_,activeText,_,_,completed = GetJournalQuestInfo(qId)
				local craft = GetQuestCraft(qName)
				if craft and not completed then
					QUEST[craft] = {id = qId, name = ZOSF('|cFFFFFF<<C:1>>|r',qName), work = {}}
					for cId = 1, GetJournalQuestNumConditions(qId,1) do
						local text,current,maximum,_,complete = GetJournalQuestConditionInfo(qId,1,cId)
						if text and text ~= ''and not complete then
							if current == maximum then text = '|c00FF00'..text..'|r' end
							QUEST[craft].work[cId] = text
						end
					end
				elseif craft then QUEST[craft] = {id = qId, name = '|cFFFFFF'..qName..'|r', work = {[1] = activeText}} end
			end
		end
	end
end
function CS.GetTime(seconds)
	if seconds and seconds > 0 then
		seconds = tostring(ZO_FormatTime(seconds,TIME_FORMAT_STYLE_COLONS,TIME_FORMAT_PRECISION_SECONDS))
		local ts,endtime,y={},'',0
		for x in string.gmatch(seconds,'%d+') do ts[y] = x; y = y + 1; end
		if y == 4 then
			if tonumber(ts[1]) < 10 then ts[1] = '0'..ts[1] end
			endtime = ts[0]..'d '..ts[1]..':'..ts[2]..'h'
		end
		if y == 3 then
			if tonumber(ts[0]) < 10 then ts[0] = '0'..ts[0] end
			endtime = ts[0]..':'..ts[1]..'h'
		end
		if y == 2 then endtime = ts[0]..'min' end
		return endtime
	else return '|cFF4020'..L.finished..'|r' end
end
function CS.GetTimer()
	CS.UpdatePlayer()
	TIMER = {}
	for _,x in pairs(CS.account.announce) do if x + 3600 > GetTimeStamp() then x = nil end end
	if CS.account.timer[12] > 0 then table.insert(TIMER,{info = L.finish12, time = CS.account.timer[12]}) end
	if CS.account.timer[24] > 0 then table.insert(TIMER,{info = L.finish24, time = CS.account.timer[24]}) end
	local crafts = {CRAFTING_TYPE_BLACKSMITHING,CRAFTING_TYPE_CLOTHIER,CRAFTING_TYPE_WOODWORKING}
	for _, char in pairs(CS.GetCharacters()) do
		if CS.account.player[char].mount.time > 1 then table.insert(TIMER,{info = ZOSF(L.finishMount, char), id = char..'mount', time = CS.account.player[char].mount.time}) end
		for _,craft in pairs(crafts) do
			for line = 1, GetNumSmithingResearchLines(craft) do
				for trait = 1, MAXTRAITS do
					local ts = CS.account.crafting.research[char][craft][line][trait] or false
					if ts ~= true and ts ~= false then
					if ts and ts > 1 then
						table.insert(TIMER,{id = char..craft..line..trait, info = ZOSF(L.finishResearch,char,GetString('SI_ITEMTRAITTYPE',GetSmithingResearchLineTraitInfo(craft,line,trait)),GetSmithingResearchLineInfo(craft,line)), time = CS.account.crafting.research[char][craft][line][trait]})
					end end
				end
			end
		end
	end
end
function CS.GetCharacters()
	local function TableSort(t)
		local orderedIndex = {}
		for key in pairs(t) do table.insert(orderedIndex,key) end
		table.sort(orderedIndex)
		return orderedIndex
	end
	return TableSort(CS.account.player)
end
function CS.GetTrait(link)
	if not link then return false end
	local trait,eq,craft=GetItemLinkTraitInfo(link),GetItemLinkEquipType(link)
	if not CS.IsValidEquip(eq)or not CS.IsValidTrait(trait)then return false end
	local at,wt,line=GetItemLinkArmorType(link),GetItemLinkWeaponType(link),nil
	if trait==25 then trait=19 end -- Nirnhoned Weapon replacement
	if trait==26 then trait=9 end -- Nirnhoned Armor replacement
	if wt==WEAPONTYPE_AXE then craft=1;line=1;
	elseif wt==WEAPONTYPE_HAMMER then craft=1;line=2;
	elseif wt==WEAPONTYPE_SWORD then craft=1;line=3
	elseif wt==WEAPONTYPE_TWO_HANDED_AXE then craft=1;line=4;
	elseif wt==WEAPONTYPE_TWO_HANDED_HAMMER then craft=1;line=5;
	elseif wt==WEAPONTYPE_TWO_HANDED_SWORD then craft=1;line=6;
	elseif wt==WEAPONTYPE_DAGGER then craft=1;line=7;
	elseif wt==WEAPONTYPE_BOW then craft=6;line=1;
	elseif wt==WEAPONTYPE_FIRE_STAFF then craft=6;line=2;
	elseif wt==WEAPONTYPE_FROST_STAFF then craft=6;line=3;
	elseif wt==WEAPONTYPE_LIGHTNING_STAFF then craft=6;line=4;
	elseif wt==WEAPONTYPE_HEALING_STAFF then craft=6;line=5;
	elseif wt==WEAPONTYPE_SHIELD then craft=6;line=6;trait=trait-10;
	elseif eq==EQUIP_TYPE_CHEST then line=1
	elseif eq==EQUIP_TYPE_FEET then line=2
	elseif eq==EQUIP_TYPE_HAND then line=3
	elseif eq==EQUIP_TYPE_HEAD then line=4
	elseif eq==EQUIP_TYPE_LEGS then line=5
	elseif eq==EQUIP_TYPE_SHOULDERS then line=6
	elseif eq==EQUIP_TYPE_WAIST then line=7
	end
	if at==ARMORTYPE_HEAVY then craft=1;line=line+7;trait=trait-10;end
	if at==ARMORTYPE_MEDIUM then craft=2;line=line+7;trait=trait-10; end
	if at==ARMORTYPE_LIGHT then craft=2;trait=trait-10; end
	if craft and line and trait then return craft,line,trait
	else return false end
end
function CS.IsValidEquip(equip)
	if equip==EQUIP_TYPE_CHEST
	or equip==EQUIP_TYPE_FEET
	or equip==EQUIP_TYPE_HAND
	or equip==EQUIP_TYPE_HEAD
	or equip==EQUIP_TYPE_LEGS
	or equip==EQUIP_TYPE_MAIN_HAND
	or equip==EQUIP_TYPE_OFF_HAND
	or equip==EQUIP_TYPE_ONE_HAND
	or equip==EQUIP_TYPE_TWO_HAND
	or equip==EQUIP_TYPE_SHOULDERS
	or equip==EQUIP_TYPE_WAIST
	then return true else return false end
end
function CS.IsValidTrait(trait)
	if trait~=ITEM_TRAIT_TYPE_NONE
	and trait~=ITEM_TRAIT_TYPE_ARMOR_INTRICATE
	and trait~=ITEM_TRAIT_TYPE_ARMOR_ORNATE
	and trait~=ITEM_TRAIT_TYPE_WEAPON_INTRICATE
	and trait~=ITEM_TRAIT_TYPE_WEAPON_ORNATE
	then return true else return false end
end
function CS.IsItemNeeded(craft,line,trait,id,link)
	if not craft or not line or not trait then return end
	local isSet = GetItemLinkSetInfo(link)
	local mark, need, storedId = true, '', CS.account.crafting.stored[craft][line][trait].id or 0
	if not CS.account.option[14] and isSet then mark = false end
	SELF = false
	if mark and (storedId == id or (not id and storedId == 0)) then
		for _, char in pairs(CS.GetCharacters()) do
			if CS.account.crafting.studies[char][craft][line] and not CS.account.crafting.research[char][craft][line][trait] then
				if char == CURRENT_PLAYER then SELF = true end
				need = need..'\n|t20:20:esoui/art/buttons/decline_up.dds|t |cFF1010'..char..'|r'
			end
		end
	end
	return need
end
function CS.IsStyleNeeded(link)
	SELF = false
	local need, id = '', SplitLink(link,3)
	if id then
		for _, char in pairs(CS.GetCharacters()) do
			if CS.account.style.tracking[char] and not CS.account.style.knowledge[char][id] then
				if char == CURRENT_PLAYER then SELF = true end
				need = need..'\n|t20:20:esoui/art/buttons/decline_up.dds|t |cFF1010'..char..'|r'
			end
		end
	end
	return need
end
function CS.IsRecipeNeeded(link)
	SELF = false
	local id, need = SplitLink(link,3), ''
	if id then
		for char,data in pairs(CS.account.cook.knowledge) do
			if not data[id] and CS.account.cook.tracking[char] then
				if char == CURRENT_PLAYER then SELF = true end
				need = need..'\n|t20:20:esoui/art/buttons/decline_up.dds|t |cFF1010'..char..'|r'
			end
		end
	end
	return need
end
function CS.IsBait(link)
	if not link then return '' end
	local id = SplitLink(link,3)
	local bait = { [42877] = 1,[42871] = 2,[42873] = 2,[42872] = 3,[42874] = 3,[42870] = 4,[42876] = 4,[42875] = 5,[42869] = 5 }
	if id then return '\n'..L.TT[21][bait[id]] end
	return ''
end
function CS.IsPotency(link)
	if not link then return '' end
	if CS.account.option[8] then
		local id = SplitLink(link,3)
		for _,add in pairs(RUNE.rune[ITEMTYPE_ENCHANTING_RUNE_POTENCY]) do
			for level,rune in pairs(add) do
				if rune == id then return L.level..' '..RUNE.level[level] end
			end
		end
		return ''
	end
end
function IsItemStoredForCraftStore(id)
	for x,craft in pairs(CS.account.crafting.stored)do
		for y,line in pairs(craft)do
			for z,trait in pairs(line)do
				if trait.id == id then
					for char,data in pairs(CS.account.crafting.research)do
						if CS.account.crafting.studies[char][x][y] and not data[x][y][z] then return true end
					end
				end
			end
		end
	end
	return false
end

function CS.OptionSetSelect(control,button)
	if button == 2 then
		ToChat(control.data.link)
	else
		for x = 1,3 do
			local zone = {GetMapInfo(control.data.zone[x])}
			local node = {GetFastTravelNodeInfo(control.data.node[x])}
			local nr, travel, zonename, nodename = control.data.nr, true, ZOSF('<<C:1>>',zone[1]), L.unknown
			if sets[nr].nodes[x] == -1 then nodename = L.TT[17]
			elseif sets[nr].nodes[x] == -2 then nodename = L.TT[18] end
			local cost = ' (|cFFFF00'..GetRecallCost()..'|r|t1:0:x.dds|t |t14:14:esoui/art/currency/currency_gold.dds|t)'
			if node[1] then nodename = ZOSF('<<C:1>>',node[2]) else travel = false; cost = '' end 
			WM:GetControlByName('CS_PanelButtonWayshrine'..x).data = { set = nr, travel = travel, info = nodename..'\n'..zonename..cost }
		end
		CS_PanelButtonCraftedSets.data = { link = control.data.link }
		CS_PanelButtonCraftedSets:SetText(control.data.name)
		CS_SetPanel:SetHidden(true)
	end
end
function CS.OptionSelect(control,condition,text)
	if not control then return end
	if condition then condition = false else condition = true end
	local tex = 'esoui/art/buttons/checkbox_unchecked.dds'
	if condition then tex = 'esoui/art/buttons/checkbox_checked.dds' end
	control:SetText('|t16:16:'..tex..'|t '..text)
	return condition
end
function CS.OptionSet()
	CS_ButtonFrame:SetHidden(not CS.account.option[1])
	CS_ButtonFrameButtonBG:SetMovable(not CS.account.option[2])
	CS_ButtonFrameButtonBG:SetMouseEnabled(not CS.account.option[2])
	CS_Quest:SetMovable(not CS.account.option[2])
	CS_Quest:SetMouseEnabled(not CS.account.option[2])
end
function CS.PanelInitialize()
	local crafts = {CRAFTING_TYPE_BLACKSMITHING,CRAFTING_TYPE_CLOTHIER,CRAFTING_TYPE_WOODWORKING}
	CS.account.crafting.research[CURRENT_PLAYER] = {}
	if not CS.account.crafting.studies[CURRENT_PLAYER] then CS.account.crafting.studies[CURRENT_PLAYER] = {} end
	for _,craft in pairs(crafts) do
		CS.account.crafting.research[CURRENT_PLAYER][craft] = {}
		if not CS.account.crafting.studies[CURRENT_PLAYER][craft] then CS.account.crafting.studies[CURRENT_PLAYER][craft] = {} end
		if not CS.account.crafting.stored[craft] then CS.account.crafting.stored[craft] = {} end
		for line = 1, GetNumSmithingResearchLines(craft) do
			CS.DrawTraitColumn(craft,line)
			CS.account.crafting.research[CURRENT_PLAYER][craft][line] = {}
			if not CS.account.crafting.studies[CURRENT_PLAYER][craft][line] then CS.account.crafting.studies[CURRENT_PLAYER][craft][line] = false end
			if not CS.account.crafting.stored[craft][line] then CS.account.crafting.stored[craft][line] = {} end
			for trait = 1, MAXTRAITS do
				if not CS.account.crafting.stored[craft][line][trait] then CS.account.crafting.stored[craft][line][trait] = {} end
			end
		end
	end
	for nr, text in pairs(L.option) do
		local btn = CreateControl('CS_OptionPanelOption'..nr,CS_OptionPanel,CT_BUTTON)
		local tex = '|t16:16:esoui/art/buttons/checkbox_unchecked.dds|t'
		if CS.account.option[nr] then tex = '|t16:16:esoui/art/buttons/checkbox_checked.dds|t' end
		btn:SetAnchor(TOPLEFT,CS_OptionPanel,TOPLEFT,12,10 + (nr - 1) * 26)
		btn:SetDimensions(375,26)
		btn:SetFont('CSFont')
		btn:SetNormalFontColor(0.9,0.87,0.68,1)
		btn:SetMouseOverFontColor(1,0.66,0.2,1)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetClickSound('Click')
		btn:SetText(tex..' '..text)
		btn:SetHandler('OnClicked',function(self)
			CS.account.option[nr] = CS.OptionSelect(self,CS.account.option[nr],L.option[nr])
			CS.OptionSet()
			if nr == 14 then
				for craft, storeCraft in pairs(CS.account.crafting.stored) do
					for line, storeLine in pairs(storeCraft) do
						for trait,_ in pairs(storeLine) do CS.UpdatePanelIcon(craft,line,trait) end
					end
				end
			end
		end)
	end
	for x,set in pairs(sets) do
		local btn = WM:CreateControl('CS_SetPanelScrollChildButton'..x,CS_SetPanelScrollChild,CT_BUTTON)
		btn:SetAnchor(3,nil,3,8,5 + (x-1) * 22)
		btn:SetDimensions(280,22)
		btn:SetFont('CSFont')
		btn:SetClickSound('Click')
		btn:EnableMouseButton(2,true)
		btn:SetNormalFontColor(0.9,0.87,0.68,1)
		btn:SetMouseOverFontColor(1,0.66,0.2,1)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_SetPanel,'tl') end)
		btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnMouseDown',function(self,button) CS.OptionSetSelect(self,button) end)
		local link = '|H1:item:'..set.item..':370:50:0:370:50:0:0:0:0:0:0:0:0:0:28:0:0:0:10000:0|h|h'
		local _,setName = GetItemLinkSetInfo(link,false)
		setName = ZOSF('[<<1>>] <<C:2>>',set.traits,setName)
		btn:SetText(setName)
		btn.data = { link = link, nr = x, zone = set.zone, node = set.nodes, name = setName, buttons = {L.TT[5],L.TT[6]} }
	end

	local pre, icons = 0, {8,5,9,12,7,3,2,1,14,10,6,13,4,11}
	for id = 1,GetNumSmithingStyleItems() do
		local _, _, _, _, style = GetSmithingStyleItemInfo(id)
		if style ~= ITEMSTYLE_UNIVERSAL and style ~= ITEMSTYLE_NONE then
			local c = WM:GetControlByName('CS_StyleRow'..pre)
			local p = WM:CreateControl('CS_StyleRow'..id,CS_StylePanelScrollChildStyles,CT_CONTROL)
			if c then p:SetAnchor(3,c,6,0,0) else p:SetAnchor(3,nil,3,0,3) end
			p:SetDimensions(750,90)
			local bg = WM:CreateControl('CS_StylePanelScrollChildBgLine'..id,p,CT_BACKDROP)
			bg:SetAnchor(3,p,3,0,0)
			bg:SetDimensions(750,37)
			bg:SetCenterColor(0,0,0,0.2)
			bg:SetEdgeColor(1,1,1,0)

			local icon, link, name, aName, aLink, popup = cs_style.GetHeadline(id)
			local btn = WM:CreateControl('CS_StylePanelScrollChildMaterial'..id,p,CT_BUTTON)
			btn:SetAnchor(2,bg,2,10,0)
			btn:SetDimensions(30,30)
			btn:SetNormalTexture(icon)
			btn:EnableMouseButton(2,true)
			btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Style,'tl') end)
			btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
			btn:SetHandler('OnMouseDown',function(self,button) if button == 2 then ToChat(self.data.link) end end)
			btn.data = { link = link, buttons = {L.TT[6]} }
			
			local lbl = WM:CreateControl('CS_StylePanelScrollChildName'..id,p,CT_LABEL)
			lbl:SetAnchor(2,bg,2,50,0)
			lbl:SetDimensions(nil,32)
			lbl:SetFont('CSFont')
			lbl:SetText(name)
			lbl:SetColor(1,0.66,0.2,1)
			lbl:SetHorizontalAlignment(0)
			lbl:SetVerticalAlignment(1)

			local av = WM:CreateControl('CS_StylePanelScrollChildAchievment'..id,p,CT_BUTTON)
			av:SetAnchor(2,lbl,8,15,0)
			av:SetDimensions(300,32)
			av:SetFont('CSFont')
			av:SetNormalFontColor(1,0.66,0.2,0.5)
			av:SetMouseOverFontColor(1,0.66,0.2,1)
			av:SetHorizontalAlignment(0)
			av:SetVerticalAlignment(1)
			av:EnableMouseButton(2,true)
			av:SetText('['..aName..']')
			av:SetHandler('OnMouseDown',function(self,button)
				if button == 2 then	ToChat(aLink) else
					ACHIEVEMENTS:ShowAchievementPopup(unpack(popup))
					ZO_PopupTooltip_Hide()
				end 
			end)
			for z,y in pairs(icons) do
				icon, link = cs_style.GetIconAndLink(id,y)
				local btn = WM:CreateControl('CS_StylePanelScrollChild'..id..'Button'..y,p,CT_BUTTON)
				btn:SetAnchor(3,bg,6,4+(z-1)*52,2)
				btn:SetDimensions(52,50)
				btn:EnableMouseButton(2,true)
				btn:SetClickSound('Click')
				btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,true,CS_Style,'tl') end)
				btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false,true) end)
				btn:SetHandler('OnMouseDown',function(self,button) if button == 2 then ToChat(self.data.link) end end)
				btn.data = { link = link, buttons = {L.TT[6]} }
				local tex = WM:CreateControl('$(parent)Texture',btn,CT_TEXTURE)
				tex:SetAnchor(128,btn,128,0,0)
				tex:SetDimensions(45,45)
				tex:SetColor(1,0,0,0.5)
				tex:SetTexture(icon)
			end
			pre = id
		end
	end
	for x = 1,50 do
		local btn = WM:CreateControl('CS_RecipePanelScrollChildButton'..x,CS_RecipePanelScrollChild,CT_BUTTON)
		btn:SetAnchor(3,nil,3,8,5 + (x-1) * 22)
		btn:SetDimensions(508,22)
		btn:SetFont('CSFont')
		btn:SetHidden(true)
		btn:EnableMouseButton(2,true)
		btn:SetClickSound('Click')
		btn:SetMouseOverFontColor(1,0.66,0.2,1)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Recipe,'tl') end)
		btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnMouseDown',function(self,button) CS.RecipeMark(self,button) end)
		btn = WM:CreateControl('CS_CookFoodSectionScrollChildButton'..x,CS_CookFoodSectionScrollChild,CT_BUTTON)
		btn:SetAnchor(3,nil,3,8,5 + (x-1) * 24)
		btn:SetDimensions(508,24)
		btn:SetFont('ZoFontGame')
		btn:EnableMouseButton(2,true)
		btn:EnableMouseButton(3,true)
		btn:SetClickSound('Click')
		btn:SetMouseOverFontColor(1,0.66,0.2,1)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Cook,'tl') end)
		btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnMouseDown',function(self,button) CS.CookStart(self,button) end)
	end
	for x = 1,25 do
		local btn = WM:CreateControl('CS_RuneGlyphSectionScrollChildButton'..x,CS_RuneGlyphSectionScrollChild,CT_BUTTON)
		btn:SetAnchor(3,nil,3,8,5 + (x-1) * 30)
		btn:SetDimensions(508,30)
		btn:SetFont('ZoFontGame')
		btn:EnableMouseButton(2,true)
		btn:EnableMouseButton(3,true)
		btn:SetClickSound('Click')
		btn:SetMouseOverFontColor(1,0.66,0.2,1)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetHandler('OnMouseEnter',function(self) CS.Tooltip(self,true,false,CS_Rune,'tl') end)
		btn:SetHandler('OnMouseExit',function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnMouseDown',function(self,button) CS.RuneCreate(self,button) end)
	end
	local function Split(level)
		local basename = ZOSF('<<t:1>>', GetItemLinkName(CS.RuneGetLink(26580,0,0)))
		local basedata = { zo_strsplit(' ', basename) }
		local name = ZOSF('<<t:1>>', GetItemLinkName(CS.RuneGetLink(26580,3,level)))
		local namedata = { zo_strsplit(' ', name) }
		for j = #namedata, 1, -1 do
			for i = #basedata, 1, -1 do
			if namedata[j] == basedata[i] then
				table.remove(namedata, j)
				table.remove(basedata, i)
			end end
		end
		return ZOSF('<<C:1>>', table.concat(namedata,' '))
	end
	for x,level in pairs(RUNE.level) do
		local name = Split(x)
		local btn = WM:CreateControl('CS_RuneMenuButton'..x,CS_RuneMenu,CT_BUTTON)
		btn:SetAnchor(3,nil,3,8,5 + (x-1) * 24)
		btn:SetDimensions(240,24)
		btn:SetFont('ZoFontGame')
		btn:SetClickSound('Click')
		btn:SetNormalFontColor(0.9,0.87,0.68,1)
		btn:SetMouseOverFontColor(1,0.66,0.2,1)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetText(name..' |c888888('..level..')|r')
		btn.data = {level = x}
		btn:SetHandler('OnClicked',function(self)
			CS.RuneSetValue(3,self.data.level);
			CS_RuneLevelButton:SetText(L.level..': '..RUNE.level[self.data.level])
			CS_RuneMenu:SetHidden(true)
			CS.RuneShowMode()
		end)
	end
	CS_OptionPanel:SetDimensions(L.optionwidth,#L.option * 26 + 20)
	CS_SetPanelScrollChild:SetHeight(#sets * 22 + 10)
	CS_CharacterPanelBoxScrollChild:SetHeight(#CS.GetCharacters() * 204 - 10)
	CS_Panel:SetAnchor(TOPLEFT,GuiRoot,TOPLEFT,CS.account.position[1],CS.account.position[2])
	CS_Quest:SetAnchor(TOPLEFT,CS_QuestFrame,TOPLEFT,CS.account.questbox[1],CS.account.questbox[2])
	CS_ButtonFrameButtonBG:SetAnchor(TOPLEFT,CS_ButtonFrame,TOPLEFT,CS.account.button[1],CS.account.button[2])
	CS_PanelButtonCraftedSets:SetText(L.set)
	CS_CharacterPanelHeader:SetText(L.chars)
	if CS.account.mainchar then CS_PanelButtonCharacters:SetText(CS.account.mainchar) else CS_PanelButtonCharacters:SetText(CURRENT_PLAYER) end
	CS_RuneInfo:SetText(GetString(SI_CRAFTING_PERFORM_FREE_CRAFT))
	CS_RuneLevelButton:SetText(L.level..': '..RUNE.level[CS.character.potency])
	CS.OptionSet()
	-- Tooltips
	local control
	for x = 1,16 do
		control = WM:GetControlByName('CS_CookCategoryButton'..x)
		control.data = {info = ZOSF('|cFFFFFF<<C:1>>|r\n<<2>>',GetRecipeListInfo(x),COOK.category[x])}
		if x < 16 then control = WM:GetControlByName('CS_RecipeCategoryButton'..x)
		control.data = {info = ZOSF('|cFFFFFF<<C:1>>|r\n<<2>>',GetRecipeListInfo(x),COOK.category[x])} end
	end
	CS_PanelQuestButton.data = nil
	for line = 1, 2 do
		for trait = 1, MAXTRAITS do
			local tid = GetSmithingResearchLineTraitInfo(1,math.abs(line - 9),trait)
			local _,desc = GetSmithingResearchLineTraitInfo(1,math.abs(line - 9),trait)
			local _,name,icon = GetSmithingTraitItemInfo(tid + 1)
			control = WM:GetControlByName('CS_PanelTraitrow'..(trait + (line - 1) * 9))
			control:SetText(GetString('SI_ITEMTRAITTYPE',tid)..' |t25:25:'..icon..'|t|t5:25:x.dds|t')
			control.data = {info = ZOSF('|cFFFFFF<<C:1>>',name)..'|r\n'..desc}
		end
	end
	CS_PanelFenceGoldText.data = { info = L.TT[16] }
	CS_ButtonFrameButton.data = { info = 'CraftStore' }
	CS_RuneArmorButton.data =  { info = GetString('SI_ITEMTYPE',ITEMTYPE_GLYPH_ARMOR) }
	CS_RuneWeaponButton.data =  { info = GetString('SI_ITEMTYPE',ITEMTYPE_GLYPH_WEAPON) }
	CS_RuneJewelryButton.data =  { info = GetString('SI_ITEMTYPE',ITEMTYPE_GLYPH_JEWELRY) }
	CS_RuneCreateButton.data =  { info = GetString(SI_CRAFTING_PERFORM_FREE_CRAFT) }
	CS_RuneRefineButton.data =  { info = GetString(SI_CRAFTING_PERFORM_EXTRACTION) }
	CS_RuneFavoriteButton.data =  { info = L.TT[11] }
	CS_RuneRefineAllButton.data =  { info = L.TT[22], addline = {L.TT[9]} }
	CS_RuneHandmadeButton.data =  { info = L.TT[12] }
	CS_CookCategoryButton17.data = { info = L.TT[11] }
	for x = 1,5 do WM:GetControlByName('CS_RuneAspect'..x..'Button').data = { link = CS.RuneGetLink(RUNE.rune[ITEMTYPE_ENCHANTING_RUNE_ASPECT][x],x,1) } end
end
function CS.CharacterInitialize()
	local tex = {[false] = '|t16:16:esoui/art/buttons/checkbox_unchecked.dds|t', [true] = '|t16:16:esoui/art/buttons/checkbox_checked.dds|t'}
	for x,char in pairs(CS.GetCharacters()) do
		local frame = WM:CreateControl('CS_CharacterFrame'..x,CS_CharacterPanelBoxScrollChild,CT_CONTROL)
		frame:SetAnchor(TOPLEFT,CS_CharacterPanelBoxScrollChild,TOPLEFT,0,(x - 1) * 204)
		
		local bg = WM:CreateControl('CS_Character'..x..'NameBG',frame,CT_BACKDROP)
		bg:SetAnchor(TOPLEFT,frame,TOPLEFT,0,0)
		bg:SetDimensions(506,65)
		bg:SetCenterColor(0.06,0.06,0.06,1)
		bg:SetEdgeColor(0.12,0.12,0.12,1)
		bg:SetEdgeTexture('',1,1,1)

		local btn = WM:CreateControl('CS_Character'..x..'Name',frame,CT_BUTTON)
		btn:SetAnchor(TOPLEFT,frame,TOPLEFT,10,1)
		btn:SetDimensions(450,30)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetClickSound('Click')
		btn:EnableMouseButton(2,true)
		btn:EnableMouseButton(3,true)
		btn:SetFont('ZoFontWinH3')
		btn:SetNormalFontColor(1,1,1,1)
		btn:SetMouseOverFontColor(1,0.66,0.3,1)
		btn:SetHandler('OnMouseEnter', function(self) CS.Tooltip(self,true,false,self,'bl') end)
		btn:SetHandler('OnMouseExit', function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnMouseDown', function(self,button) CS.LoadCharacter(self,button) end)
		
		btn = WM:CreateControl('CS_Character'..x..'Info',frame,CT_BUTTON)
		btn:SetAnchor(TOPLEFT,frame,TOPLEFT,8,30)
		btn:SetDimensions(400,35)
		btn:SetHorizontalAlignment(0)
		btn:SetVerticalAlignment(1)
		btn:SetFont('ZoFontGame')
		btn:SetNormalFontColor(0.9,0.87,0.68,1)
		btn:SetHandler('OnMouseEnter', function(self) CS.Tooltip(self,true,false,self,'bl') end)
		btn:SetHandler('OnMouseExit', function(self) CS.Tooltip(self,false) end)
		
		btn = WM:CreateControl('CS_Character'..x..'Style',frame,CT_BUTTON)
		btn:SetAnchor(TOPLEFT,frame,TOPLEFT,415,7)
		btn:SetDimensions(80,25)
		btn:SetHorizontalAlignment(2)
		btn:SetVerticalAlignment(1)
		btn:SetFont('ZoFontGame')
		btn:SetClickSound('Click')
		btn:SetText(tex[CS.account.style.tracking[char]]..' |t22:22:esoui/art/icons/quest_book_001.dds|t')
		btn:SetNormalFontColor(0.9,0.87,0.68,1)
		btn:SetHandler('OnMouseEnter', function(self) CS.Tooltip(self,true,false,self,'bc') end)
		btn:SetHandler('OnMouseExit', function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnClicked', function(self) CS.account.style.tracking[char] = CS.OptionSelect(self,CS.account.style.tracking[char],'|t22:22:esoui/art/icons/quest_book_001.dds|t') end)
		btn.data = { info = L.TT[13] }

		btn = WM:CreateControl('CS_Character'..x..'Recipe',frame,CT_BUTTON)
		btn:SetAnchor(TOPLEFT,frame,TOPLEFT,415,36)
		btn:SetDimensions(80,25)
		btn:SetHorizontalAlignment(2)
		btn:SetVerticalAlignment(1)
		btn:SetFont('ZoFontGame')
		btn:SetClickSound('Click')
		btn:SetText(tex[CS.account.cook.tracking[char]]..' |t22:22:esoui/art/icons/quest_scroll_001.dds|t')
		btn:SetNormalFontColor(0.9,0.87,0.68,1)
		btn:SetHandler('OnMouseEnter', function(self) CS.Tooltip(self,true,false,self,'bc') end)
		btn:SetHandler('OnMouseExit', function(self) CS.Tooltip(self,false) end)
		btn:SetHandler('OnClicked', function(self) CS.account.cook.tracking[char] = CS.OptionSelect(self,CS.account.cook.tracking[char],'|t22:22:esoui/art/icons/quest_scroll_001.dds|t') end)
		btn.data = { info = L.TT[14] }
		
		local skills, xpos, ypos, res = {5,4,3,2,1,6}, 0, 66, {2,1,6}
		for y,z in pairs(skills) do 
			bg = WM:CreateControl('CS_Character'..x..'Skill'..z..'BG',frame,CT_BACKDROP)
			bg:SetAnchor(TOPLEFT,frame,TOPLEFT,xpos,ypos)
			bg:SetDimensions(168,28)
			bg:SetCenterColor(0.06,0.06,0.06,1)
			bg:SetEdgeColor(0.12,0.12,0.12,1)
			bg:SetEdgeTexture('',1,1,1)

			btn = WM:CreateControl('CS_Character'..x..'Skill'..z,frame,CT_BUTTON)
			btn:SetAnchor(TOPLEFT,frame,TOPLEFT,xpos + 5,ypos)
			btn:SetDimensions(165,28)
			btn:SetFont('CSFont')
			btn:SetNormalFontColor(0.9,0.87,0.68,1)
			btn:SetHorizontalAlignment(0)
			btn:SetVerticalAlignment(1)
			btn:SetHandler('OnMouseEnter', function(self) CS.Tooltip(self,true,false,self,'bl') end)
			btn:SetHandler('OnMouseExit', function(self) CS.Tooltip(self,false) end)
			xpos = xpos + 169
			if y == 3 then xpos = 0; ypos = 95; end
		end xpos = 0
		for _,z in pairs(res) do
			bg = WM:CreateControl('CS_Character'..x..'Research'..z..'BG',frame,CT_BACKDROP)
			bg:SetAnchor(TOPLEFT,frame,TOPLEFT,xpos,124)
			bg:SetDimensions(168,70)
			bg:SetCenterColor(0.06,0.06,0.06,1)
			bg:SetEdgeColor(0.12,0.12,0.12,1)
			bg:SetEdgeTexture('',1,1,1)
			xpos = xpos + 169
			for i = 1,3 do
				btn = WM:CreateControl('CS_Character'..x..'Research'..z..'Slot'..i,bg,CT_BUTTON)
				btn:SetAnchor(TOPLEFT,bg,TOPLEFT,5,1 + (i - 1) * 22)
				btn:SetDimensions(165,22)
				btn:SetFont('CSFont')
				btn:SetNormalFontColor(0.9,0.87,0.68,1)
				btn:SetHorizontalAlignment(0)
				btn:SetVerticalAlignment(1)
				btn:SetHandler('OnMouseEnter', function(self) CS.Tooltip(self,true,false,self,'bl') end)
				btn:SetHandler('OnMouseExit', function(self) CS.Tooltip(self,false) end)
				local lbl = WM:CreateControl('CS_Character'..x..'Research'..z..'Slot'..i..'Time',bg,CT_LABEL)
				lbl:SetAnchor(TOPRIGHT,bg,TOPRIGHT,-5,1 + (i - 1) * 22)
				lbl:SetDimensions(90,22)
				lbl:SetFont('CSFont')
				lbl:SetColor(0.9,0.87,0.68,1)
				lbl:SetHorizontalAlignment(2)
				lbl:SetVerticalAlignment(1)
			end
		end
	end
end
function CS.Tooltip(c,visible,scale,parent,pos)
	if not c then return end
	local function IconScale(c,from,to)
		local a,t = CreateSimpleAnimation(ANIMATION_SCALE,c)
		a:SetDuration(150)
		a:SetStartScale(from)
		a:SetEndScale(to)
		t:SetPlaybackType(ANIMATION_PLAYBACK_ONE_SHOT)
		t:PlayFromStart()
	end
	local function TooltipCraft(c,field,maxval)
		if EXTERN then return {L.TT[6],L.TT[4]} end
		if c.data.craftable and maxval > 0 then
			if maxval > MAXCRAFT then maxval = MAXCRAFT end
			local amount = tonumber(field:GetText()) or 1
			return {ZOSF(L.TT[2],amount),ZOSF(L.TT[3],maxval),L.TT[4]}
		end
		return {L.TT[4]}
	end	
	if scale then
		if visible then IconScale(c:GetNamedChild('Texture'),1,1.4)
		else IconScale(c:GetNamedChild('Texture'),1.4,1) end
	end
	if c.data == nil then return
	elseif visible then
		if not parent then parent = c end
		if not pos then pos = 0 end
		local anchor, first = {tl={9,2,1,3},tc={4,0,-2,1},tr={3,2,3,9},cl={8,-2,0,2},[0]={2,1,0,8},cr={2,2,0,8},bl={3,2,2,6},bc={1,0,2,4},br={6,2,-3,12}}, '\n'
		if c.data.link then
			c.text = ItemTooltip
			InitializeTooltip(c.text,parent,anchor[pos][1],anchor[pos][2],anchor[pos][3],anchor[pos][4])
			c.text:SetLink(c.data.link)
			ZO_ItemTooltip_ClearCondition(c.text)
			ZO_ItemTooltip_ClearCharges(c.text)
		elseif c.data.info then
			c.text = InformationTooltip
			InitializeTooltip(c.text,parent,anchor[pos][1],anchor[pos][2],anchor[pos][3],anchor[pos][4])
			SetTooltipText(c.text,c.data.info)
		end
		if c.data.addline then for _,text in pairs(c.data.addline) do c.text:AddLine(first..text,'CSFont'); first = '' end end
		if c.data.buttons then c.text:AddLine(first..table.concat(c.data.buttons,'\n'),'CSFont'); first = '' end
		if c.data.crafting then c.text:AddLine(first..table.concat(TooltipCraft(c,c.data.crafting[1],c.data.crafting[2]),'\n'),'CSFont'); first = '' end
		c.text:SetHidden(false)
	else
		if c.text == nil then return end
		ClearTooltip(c.text)
		c.text:SetHidden(true)
		c.text = nil
	end
end
function CS.TooltipShow(control,link,id)
	local it, store, need = GetItemLinkItemType(link), {}
	if it == ITEMTYPE_RACIAL_STYLE_MOTIF then need = CS.IsStyleNeeded(link)
	elseif it == ITEMTYPE_RECIPE then need = CS.IsRecipeNeeded(link)
	elseif it == ITEMTYPE_LURE then need = CS.IsBait(link)
	elseif it == ITEMTYPE_ENCHANTING_RUNE_POTENCY then need = CS.IsPotency(link)
	elseif CS.IsValidEquip(GetItemLinkEquipType(link)) then
		local craft,line,trait = CS.GetTrait(link)
		if CS.account.option[9] then control:AddLine('\n|cC5C29E'..ZOSF('<<ZC:1>>',GetString('SI_ITEMSTYLE',GetItemLinkItemStyle(link)))..'|r','ZoFontGameSmall')end
		if craft and line and trait then need = CS.IsItemNeeded(craft,line,trait,id,link) end
	end
	if need ~= '' then control:AddLine(need,'CSFont') end
	if CS.account.option[15] and CS.account.storage[link] then
		for x, stock in pairs(CS.account.storage[link]) do if stock and stock > 0 then table.insert(store,'|c8085FF'..x..':|r |cC0C5FF'..stock..'|r') end end
		if #store > 0 then control:AddLine(table.concat(store,', '),'CSFont') end
	end
	store = nil
end
function CS.TooltipHandler()
	local tt=ItemTooltip.SetBagItem
	ItemTooltip.SetBagItem=function(control,bagId,slotIndex,...)
		tt(control,bagId,slotIndex,...)
		CS.TooltipShow(control,GetItemLink(bagId,slotIndex),Id64ToString(GetItemUniqueId(bagId,slotIndex)))
	end
	local tt=ItemTooltip.SetLootItem
	ItemTooltip.SetLootItem=function(control,lootId,...)
		tt(control,lootId,...)
		CS.TooltipShow(control,GetLootItemLink(lootId))
	end
	local ResultTooltip=ZO_SmithingTopLevelCreationPanelResultTooltip
	local tt=ResultTooltip.SetPendingSmithingItem
	ResultTooltip.SetPendingSmithingItem=function(control,pid,mid,mq,sid,tid)
		tt(control,pid,mid,mq,sid,tid)
		CS.TooltipShow(control,GetSmithingPatternResultLink(pid,mid,mq,sid,tid))
	end	
	local tt=PopupTooltip.SetLink
	PopupTooltip.SetLink=function(control,link,...)
		tt(control,link,...)
		CS.TooltipShow(control,link)
	end
	local tt=ItemTooltip.SetAttachedMailItem
	ItemTooltip.SetAttachedMailItem=function(control,openMailId,attachmentIndex,...)
		tt(control,openMailId,attachmentIndex,...)
		CS.TooltipShow(control,GetAttachedItemLink(openMailId,attachmentIndex))
	end
	local tt=ItemTooltip.SetBuybackItem
	ItemTooltip.SetBuybackItem=function(control,index,...)
		tt(control,index,...)
		CS.TooltipShow(control,GetBuybackItemLink(index))
	end
	local tt=ItemTooltip.SetTradingHouseItem
	ItemTooltip.SetTradingHouseItem=function(control,tradingHouseIndex,...)
		tt(control,tradingHouseIndex,...)
		CS.TooltipShow(control,GetTradingHouseSearchResultItemLink(tradingHouseIndex))
	end
	local tt=ItemTooltip.SetTradingHouseListing
	ItemTooltip.SetTradingHouseListing=function(control,tradingHouseListingIndex,...)
		tt(control,tradingHouseListingIndex,...)
		CS.TooltipShow(control,GetTradingHouseListingItemLink(tradingHouseListingIndex))
	end
	local tt=ItemTooltip.SetTradeItem
	ItemTooltip.SetTradeItem=function(control,tradeWho,slotIndex,...)
		tt(control,tradeWho,slotIndex,...)
		CS.TooltipShow(control,GetTradeItemLink(slotIndex))
	end
	local tt=ItemTooltip.SetQuestReward
	ItemTooltip.SetQuestReward=function(control,rewardIndex,...)
		tt(control,rewardIndex,...)
		CS.TooltipShow(control,GetQuestRewardItemLink(rewardIndex))
	end
end
function CS.ControlCloseAll()
	CS_CharacterPanel:SetHidden(true)
	CS_OptionPanel:SetHidden(true)
	CS_Recipe:SetHidden(true)
	CS_Style:SetHidden(true)
	CS_SetPanel:SetHidden(true)
	SM:HideTopLevel(CS_Panel)
	CS.RuneView(2)
	MODE = 0
end
function CS.ControlShow(scene)
	local closed = scene:IsHidden()
	CS_CharacterPanel:SetHidden(true)
	CS_OptionPanel:SetHidden(true)
	CS_Recipe:SetHidden(true)
	CS_Style:SetHidden(true)
	CS_SetPanel:SetHidden(true)
	if closed then scene:SetHidden(false) end
end

function CS.ShowMain()
	SM:ToggleTopLevel(CS_Panel)
    if not CS_Panel:IsHidden() then
		CS.GetQuest()
		local questText = ''
		for _, quest in pairs(QUEST) do
			if questText ~= '' then questText = questText..'\n\n' end
			questText = questText..quest.name
			for _, step in pairs(quest.work) do questText = questText..'\n'..step end
		end
		if questText ~= '' then CS_PanelQuestButton.data = { info = questText } else CS_PanelQuestButton.data = nil end
		if CS.account.mainchar then SELECTED_PLAYER = CS.account.mainchar end
		CS.UpdatePlayer()
		CS.UpdateScreen()
		if CS.account.timer[12] > 0 then CS_Panel12Hours:SetText(CS.GetTime(CS.account.timer[12] - GetTimeStamp())) else CS_Panel12Hours:SetText('12:00h') end
		if CS.account.timer[24] > 0 then CS_Panel24Hours:SetText(CS.GetTime(CS.account.timer[24] - GetTimeStamp())) else CS_Panel24Hours:SetText('24:00h') end
	end
end

EM:RegisterForEvent('CSEE',EVENT_ADD_ON_LOADED,function(eventCode,addOnName)
    if addOnName ~= 'CraftStore' then return end
	cs_style = CS.STYLE()
	-- cs_flask = CS.FLASK()
	local account_init = {
		option = {true,false,true,true,true,true,true,true,true,true,true,true,true,false,true,true},
		mainchar = false,
		timer = { [12] = 0, [24] = 0},
		position = {350,100},
		questbox = {GuiRoot:GetWidth()-500,-20},
		button = {75,75},
		player = {},
		storage = {},
		announce = {},
		crafting = { research = {}, studies = {}, stored = {}, skill = {} },
		style = { tracking = {}, knowledge = {} },
		cook = { tracking = {}, knowledge = {}, ingredients = {} }
	}
	local character_init = {
		income = { GetDate(), GetCurrentMoney() },
		favorites = { {}, {}, {}, {}, {}, {} },
		recipe = 1,
		potency = 1,
		essence = 1,
		aspect = 1,
		potencytype = 1,
		enchant = ITEMTYPE_GLYPH_ARMOR,
		runemode = 'craft',
		hidestyles = false,
	}
	
	CS.account = ZO_SavedVars:NewAccountWide('CS_Account',1,nil,account_init)
	CS.character = ZO_SavedVars:New('CS_Character',1,nil,character_init)
	ZO_CreateStringId('SI_BINDING_NAME_SHOW_CS_WINDOW',L.TT[15])
	SM:RegisterTopLevel(CS_Panel,false)
    EM:RegisterForEvent('CSEE',EVENT_QUEST_CONDITION_COUNTER_CHANGED,function(eventCode,journalIndex) CS.UpdateQuest(journalIndex) end)
    EM:RegisterForEvent("CSEE",EVENT_RECIPE_LEARNED,function(eventCode,list,id) CS.RecipeLearned(list,id) end)
    EM:RegisterForEvent('CSEE',EVENT_STYLE_LEARNED,function() CS.UpdateStyleKnowledge(true) end)
	EM:RegisterForEvent('CSEE',EVENT_TRADING_HOUSE_RESPONSE_RECEIVED,CS.UpdateGuildStore)
    EM:RegisterForEvent('CSEE',EVENT_SMITHING_TRAIT_RESEARCH_STARTED,function(eventCode,craft,line,trait)
		local _,remaining = GetSmithingResearchLineTraitTimes(craft,line,trait)
		if remaining then CS.account.crafting.research[CURRENT_PLAYER][craft][line][trait] = remaining + GetTimeStamp() end
		CS.account.crafting.stored[craft][line][trait] = {}
		CS.UpdateResearchWindows()
		CS.UpdatePanelIcon(craft,line,trait)
		if CS.account.option[12] then CS.GetTimer() end
	end)
    EM:RegisterForEvent('CSEE',EVENT_STABLE_INTERACT_END,function() if CS.account.option[12] then CS.GetTimer() end end)
    EM:RegisterForEvent('CSEE',EVENT_SMITHING_TRAIT_RESEARCH_COMPLETED,function(eventCode,craft,line,trait)
		CS.account.crafting.research[CURRENT_PLAYER][craft][line][trait] = true
		CS.UpdateResearchWindows()
		CS.UpdatePanelIcon(craft,line,trait)
	end)
    EM:RegisterForEvent('CSEE',EVENT_CRAFTING_STATION_INTERACT,function(eventCode,craftSkill)
		if CS.account.option[7] then
			if craftSkill == CRAFTING_TYPE_PROVISIONING then
				COOK.craftLevel = GetNonCombatBonus(NON_COMBAT_BONUS_PROVISIONING_LEVEL)
				COOK.qualityLevel = GetNonCombatBonus(NON_COMBAT_BONUS_PROVISIONING_RARITY_LEVEL)
				CS.CookShowCategory(CS.character.recipe)
				CS_CookAmount:SetText('')
				CS_CookSearch:SetText(GetString(SI_GAMEPAD_HELP_SEARCH)..'...')
				CS_Cook:SetHidden(false)
				for x = 2, ZO_ProvisionerTopLevel:GetNumChildren() do ZO_ProvisionerTopLevel:GetChild(x):SetAlpha(0) end
				ZO_KeybindStripControl:SetHidden(true)
			end
		end
		if CS.account.option[8] then
			if craftSkill == CRAFTING_TYPE_ENCHANTING then
				EXTERN = false
				CS.RuneInitalize()
				for x = 2, ZO_EnchantingTopLevel:GetNumChildren() do ZO_EnchantingTopLevel:GetChild(x):SetHidden(true) end
				ZO_KeybindStripControl:SetHidden(true)
				local soundPlayer = CRAFTING_RESULTS.enchantSoundPlayer
				soundPlayer.PlaySound = function() return end
			end
		end
		-- if CS.account.option[8] then
			-- if craftSkill == CRAFTING_TYPE_ALCHEMY then
				-- CS_Flask:SetHidden(false)
			-- end
		-- end
		if CS.account.option[6] then
			CS.GetQuest()
			if QUEST[craftSkill] then
				local out = QUEST[craftSkill].name..'\n'
				for _, step in pairs(QUEST[craftSkill].work) do out = out..step..'\n' end
				CS_QuestText:SetText(out)
				CS_Quest:SetHidden(false)
			end
		end
	end)
    EM:RegisterForEvent('CSEE',EVENT_INVENTORY_FULL_UPDATE,CS.UpdateBag)
    EM:RegisterForEvent('CSEE',EVENT_CRAFT_COMPLETED,function(eventCode,craftSkill)
		local val = GetLastCraftingResultTotalInspiration()
		if val > 0 then INSPIRATION = '|t30:30:/esoui/art/currency/currency_inspiration.dds|t |c9095FF'..val..'|r' end
		if CS.account.option[7] and craftSkill == CRAFTING_TYPE_PROVISIONING then
			if COOK.job.amount > 0 then
				CraftProvisionerItem(COOK.job.list,COOK.job.id)
				PlaySound(COOK.job.sound)
				CS_CookAmount:SetText(COOK.job.amount)
				COOK.job.amount = COOK.job.amount - 1
			end
			zo_callLater(function() CS.CookShowCategory(CS.character.recipe) end,500)
		end
		if CS.account.option[8] and craftSkill == CRAFTING_TYPE_ENCHANTING then
			if RUNE.job.amount > 0 then
				local bagP, slotP = CS.ScanBag(RUNE.job.id[1])
				local soundP, lengthP = GetRunestoneSoundInfo(bagP,slotP)
				local bagE, slotE = CS.ScanBag(RUNE.job.id[2])
				local soundE, lengthE = GetRunestoneSoundInfo(bagE,slotE)
				local bagA, slotA = CS.ScanBag(RUNE.job.id[3])
				local soundA,_ = GetRunestoneSoundInfo(bagA,slotA)
				CraftEnchantingItem(bagP,slotP,bagE,slotE,bagA,slotA)
				if CS.account.option[13] then
					zo_callLater(function() PlaySound(soundP) end, 250)
					zo_callLater(function() PlaySound(soundE) end, lengthP + 250)
					zo_callLater(function() PlaySound(soundA) end, lengthE + lengthP + 250)
				else
					zo_callLater(function() PlaySound('Enchanting_Create_Tooltip_Glow') end, 250)
				end
				CS_RuneAmount:SetText(RUNE.job.amount)
				RUNE.job.amount = RUNE.job.amount - 1
			elseif RUNE.refine.glyphs[1] then
				if RUNE.refine.glyphs[1].crafted and not RUNE.refine.crafted then table.remove(RUNE.refine.glyphs,1) end
				if RUNE.refine.glyphs[1] then
					if GetNumBagFreeSlots(BAG_BACKPACK) >= 3 then
						ExtractEnchantingItem(RUNE.refine.glyphs[1].bag, RUNE.refine.glyphs[1].slot)
						PlaySound('Enchanting_Extract_Start_Anim')
						table.remove(RUNE.refine.glyphs,1)
					else d(L.nobagspace) end
				end
			end
			zo_callLater(CS.RuneShowMode,500)
		end
		CS.UpdateBag()
	end)
    EM:RegisterForEvent('CSEE',EVENT_END_CRAFTING_STATION_INTERACT,function()
		CS_Cook:SetHidden(true)
		CS_Quest:SetHidden(true)
		CS_Rune:SetHidden(true)
		CS_Flask:SetHidden(true)
		for x = 2, ZO_ProvisionerTopLevel:GetNumChildren() do ZO_ProvisionerTopLevel:GetChild(x):SetAlpha(1) end
		for x = 2, ZO_EnchantingTopLevel:GetNumChildren() do ZO_EnchantingTopLevel:GetChild(x):SetHidden(false) end
	end)
    EM:RegisterForEvent('CSEE',EVENT_NEW_MOVEMENT_IN_UI_MODE,function() if CS.account.option[3] and not CS_Panel:IsHidden() then CS.ControlCloseAll() end end)
    EM:RegisterForEvent('CSEE',EVENT_RETICLE_HIDDEN_UPDATE,function(eventCode,hidden) if not hidden and not CS_Rune:IsHidden() then CS.RuneView(2) end end)
	EM:RegisterForEvent('CSEE',EVENT_PLAYER_ACTIVATED,function()
		CS.UpdateAccountVars()
		CS.UpdatePlayer()
		CS.UpdateStyleKnowledge(true)
		CS.UpdateRecipeKnowledge()
		CS.UpdateAllStudies()
		CS.UpdateInventory()
		CS.CharacterInitialize()
		CS.GetTimer()
		CS.HideStyles(true)
		CS.init = true
		EM:UnregisterForEvent('CSEE',EVENT_PLAYER_ACTIVATED)
	end)
	EM:RegisterForEvent('CSEE',EVENT_PLAYER_DEACTIVATED,function()
		CS.UpdatePlayer()
		EM:UnregisterForEvent('CSEE',EVENT_PLAYER_DEACTIVATED)
	end)
	CHAMPION_PERKS_SCENE:RegisterCallback('StateChange',function(_,new)
		if new == SCENE_SHOWING then
			SM:HideTopLevel(CS_Panel)
			CS_ButtonFrame:SetHidden(true)
		elseif new == SCENE_HIDDEN then
			if CS.account.option[1] then CS_ButtonFrame:SetHidden(false) end
		end
	end)
	CS.PanelInitialize()
	CS.ClearStorage()
	local function OnSlotAdded(bag,slot,data)
		if bag > 2 then return end
		local link = GetItemLink(bag,slot)
		local a1, a2 = GetItemLinkStacks(link)
		if not CS.account.storage[link] then CS.account.storage[link] = {} end
		CS.account.storage[link][L.bank] = a2
		CS.account.storage[link][CURRENT_PLAYER] = a1
		data.uid = Id64ToString(GetItemUniqueId(bag,slot))
		data.lnk = link
		if CS.IsValidEquip(GetItemLinkEquipType(link)) then CS.UpdateStored('added',data) end
	end
	local function OnSlotRemoved(bag,_,data)
		if bag > 2 then return end
		local a1, a2 = GetItemLinkStacks(data.lnk)
		CS.account.storage[data.lnk][L.bank] = a2
		CS.account.storage[data.lnk][CURRENT_PLAYER] = a1
		if CS.IsValidEquip(GetItemLinkEquipType(data.lnk)) then CS.UpdateStored('removed',data) end
	end
	SHARED_INVENTORY:RegisterCallback('SlotAdded',OnSlotAdded)
	SHARED_INVENTORY:RegisterCallback('SlotRemoved',OnSlotRemoved)
	CS.ScrollText()
	CS.TooltipHandler()
	if CS.character.income[1] ~= GetDate()then
		CS.character.income[1] = GetDate()
		CS.character.income[2] = GetCurrentMoney()
	end
	ZO_PreHookHandler(ZO_StackSplit,'OnShow', function()
		if CS.account.option[16] then
			ZO_StackSplitSpinnerDisplay:TakeFocus()
			ZO_StackSplitSpinnerDisplay:SelectAll()
		end
	end)
	
    EM:UnregisterForEvent('CSEE',EVENT_ADD_ON_LOADED)
end)