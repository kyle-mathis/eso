local CS = CraftStoreFixedAndImprovedLongClassName

CS.Debug = (GetWorldName() == "PTS" or GetDisplayName()=="@VladislavAksjonov")
CS.Name = 'CraftStoreFixedAndImproved'
CS.Title = 'CraftStore Fixed'
CS.Version = '1.0'
CS.Account = nil
CS.Character = nil
CS.Init = false
CS.MaxTraits = select(3,GetSmithingResearchLineInfo(1,1))
CS.Loc = CS.Lang[GetCVar('language.2')] or CS.Lang.en
CS.Quest = {}
CS.Extern = false
CS.Inspiration = ''
CS.Quality = {
  [0] = {0.65,0.65,0.65,1}, --Trash
        {1,   1,   1,   1}, --Normal
        {0.17,0.77,0.05,1}, --Fine
        {0.22,0.57,1,   1}, --Superior
        {0.62,0.18,0.96,1}, --Epic
        {0.80,0.66,0.10,1}, --Legendary
}
CS.QualityHex = {
  [0] = 'B3B3B3', --Trash
        'FFFFFF', --Normal
        '2DC50E', --Fine
        '3A92FF', --Superior
        'A02EF7', --Epic
        'EECA2A', --Legendary
}
CS.HealthName  = GetString(SI_ATTRIBUTES1)
CS.MagickaName = GetString(SI_ATTRIBUTES2)
CS.StaminaName = GetString(SI_ATTRIBUTES3)
CS.CurrentPlayer  = zo_strformat('<<C:1>>',GetUnitName('player'))
CS.SelectedPlayer = CS.CurrentPlayer
CS.UIClosed = false
CS.ChampionPointsTexture = "|t16:16:esoui/art/champion/champion_icon_32.dds|t"
--TODO: Generate recipe and ingridients list on the init
CS.Cook = {
  category = {
    CS.HealthName, 
    CS.MagickaName, 
    CS.StaminaName, 
    CS.HealthName ..' + '..CS.MagickaName, 
    CS.HealthName ..' + '..CS.StaminaName, 
    CS.MagickaName..' + '..CS.StaminaName, 
    CS.HealthName ..' + '..CS.MagickaName..' + '..CS.StaminaName,
    CS.HealthName, 
    CS.MagickaName, 
    CS.StaminaName, 
    CS.HealthName ..' + '..CS.MagickaName, 
    CS.HealthName ..' + '..CS.StaminaName, 
    CS.MagickaName..' + '..CS.StaminaName, 
    CS.HealthName ..' + '..CS.MagickaName..' + '..CS.StaminaName,
    GetString(SI_ITEMFILTERTYPE5), 
    GetString(SI_ITEMFILTERTYPE5), 
    '', 
    ''
  },
  craftLevel = 0,
  qualityLevel = 0,
  job = {amount = 0, list = nil, id = nil},
  recipe = {},
  ingredient = {},
  recipelist = {
    45535,45539,45540,45541,45542,45543,45544,45545,45546,45547,45548,45549,
    45551,45552,45553,45554,45555,45556,45557,45559,45560,45561,45562,45563,
    45564,45565,45567,45568,45569,45570,45571,45572,45573,45574,45575,45576,
    45577,45579,45580,45581,45582,45583,45584,45587,45588,45589,45590,45591,
    45592,45594,45595,45596,45597,45598,45599,45600,45601,45602,45603,45604,
    45607,45608,45609,45610,45611,45612,45614,45615,45616,45617,45618,45619,
    45620,45621,45622,45623,45624,45625,45626,45627,45628,45629,45630,45631,
    45632,45633,45634,45636,45637,45638,45639,45640,45641,45642,45643,45644,
    45645,45646,45647,45648,45649,45650,45651,45652,45653,45654,45655,45656,
    45657,45658,45659,45660,45661,45662,45663,45664,45665,45666,45667,45668,
    45670,45671,45672,45673,45674,45675,45676,45677,45678,45679,45680,45681,
    45682,45683,45684,45685,45686,45687,45688,45689,45690,45691,45692,45693,
    45694,45695,45696,45697,45698,45699,45700,45701,45702,45703,45704,45705,
    45706,45707,45708,45709,45710,45711,45712,45713,45714,45715,45716,45717,
    45718,45719,45791,45887,45888,45889,45890,45891,45892,45893,45894,45895,
    45896,45897,45898,45899,45900,45901,45902,45903,45904,45905,45906,45907,
    45908,45909,45910,45911,45912,45913,45914,45915,45916,45917,45918,45919,
    45920,45921,45922,45923,45924,45925,45926,45927,45928,45929,45930,45931,
    45932,45933,45934,45935,45936,45937,45938,45939,45940,45941,45942,45943,
    45944,45945,45946,45947,45948,45949,45950,45951,45952,45953,45954,45955,
    45956,45957,45958,45959,45960,45961,45962,45963,45964,45965,45966,45967,
    45968,45969,45970,45971,45972,45973,45974,45975,45976,45977,45978,45979,
    45980,45981,45982,45983,45984,45985,45986,45987,45988,45989,45990,45991,
    45992,45993,45994,45995,45996,45997,45998,45999,46000,46001,46002,46003,
    46004,46005,46006,46007,46008,46009,46010,46011,46012,46013,46014,46015,
    46016,46017,46018,46019,46020,46021,46022,46023,46024,46025,46026,46027,
    46028,46029,46030,46031,46032,46033,46034,46035,46036,46037,46038,46039,
    46040,46041,46042,46043,46044,46045,46046,46047,46048,46049,46050,46051,
    46052,46053,46054,46055,46056,46079,46081,46082,54241,54242,54243,54369,
    54370,54371,56943,56944,56945,56946,56947,56948,56949,56950,56951,56952,
    56953,56954,56955,56956,56957,56958,56959,56961,56962,56963,56964,56965,
    56966,56967,56968,56969,56970,56971,56972,56973,56974,56975,56976,56977,
    56978,56979,56980,56981,56982,56983,56984,56985,56986,56987,56988,56989,
    56990,56991,56992,56993,56994,56995,56996,56997,56998,56999,57000,57001,
    57002,57003,57004,57005,57006,57007,57008,57009,57010,57011,57012,57013,
    57014,57015,57016,57017,57018,57019,57020,57021,57022,57023,57024,57025,
    57026,57027,57028,57029,57030,57031,57032,57033,57034,57035,57036,57037,
    57038,57039,57040,57041,57042,57043,57044,57045,57046,57047,57048,57049,
    57050,57051,57052,57053,57054,57055,57056,57057,57058,57059,57060,57061,
    57062,57063,57064,57065,57066,57067,57068,57069,57070,57071,57072,57073,
    57074,57075,57076,57077,57078,57079,64223,68189,68190,68191,68192,68193,
    68194,68195,68196,68197,68198,68199,68200,68201,68202,68203,68204,68205,
    68206,68207,68208,68209,68210,68211,68212,68213,68214,68215,68216,68217,
    68218,68219,68220,68221,68222,68223,68224,68225,68226,68227,68228,68229,
    68230,68231,68232,71060,71061,71062,71063,87682,87683,87684,87688,87689,
    87692,87693,87694,87698,96960,96961,96962,96963,96964,96965,96966,96967,
    96968,115029,96960,96961,96962,96963,96964,96965,96966,96967,96968
  },
  ingredientlist = {
    34349,34348,34347,34346,34345,34335,34334,34333,34330,34329,34324,34323,
    34321,34311,34309,34308,34307,34305,33774,33773,33772,33771,33768,33758,
    33756,33755,33754,33753,33752,29030,28666,28639,28636,28610,28609,28604,
    28603,27100,27064,27063,27059,27058,27057,27052,27049,27048,27043,27035,
    26954,26802--,46151,77584
  }
}
CS.Rune = {
  level = {
    '1 - 10',
    '5 - 15',
    '10 - 20',
    '15 - 25',
    '20 - 30',
    '25 - 35',
    '30 - 40',
    '35 - 45',
    '40 - 50',
    CS.ChampionPointsTexture..'10',
    CS.ChampionPointsTexture..'30',
    CS.ChampionPointsTexture..'50',
    CS.ChampionPointsTexture..'70',
    CS.ChampionPointsTexture..'100',
    CS.ChampionPointsTexture..'150',
    CS.ChampionPointsTexture..'160'
  },
  skillLevel = {1,1,2,2,3,3,4,4,5,5,6,7,8,9,10,10},
  aspectSkill = 1,
  potencySkill = 1,
  rune = {
    [ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = {
        45831,45832,45833,45834,45835,45836,
        45837,45838,45839,45840,45841,45842,
        45843,45846,45847,45848,45849,68342
      },
    [ITEMTYPE_ENCHANTING_RUNE_POTENCY] = { 
      {
        45855,45856,45857,45806,45807,45808,
        45809,45810,45811,45812,45813,45814,
        45815,45816,64509,68341
      }, 
      {
        45817,45818,45819,45820,45821,45822,
        45823,45824,45825,45826,45827,45828,
        45829,45830,64508,68340
      } 
    },
    [ITEMTYPE_ENCHANTING_RUNE_ASPECT] = {
        45850,45851,45852,45853,45854
      },
  },
  glyph = {
    [ITEMTYPE_GLYPH_ARMOR] = {
      {26580,45831,1,1}, -- health, oko
      {26582,45832,1,2}, -- magicka, makko
      {26588,45833,1,3}, -- stamina, deni
      {68343,68342,1,4}, -- prismatic defense, hakeijo 
    },
    [ITEMTYPE_GLYPH_WEAPON] = {
      {68344,68342,2, 1}, -- prismatic onslaught, hakeijo 
      {54484,45843,1, 2}, -- weapon damage, okori
      {26845,45842,2, 3}, -- crushing, deteri
      {43573,45831,2, 4}, -- absorb health, oko
      {45868,45832,2, 5}, -- absorb magicka, makko
      {45867,45833,2, 6}, -- absorb stamina, deni
      {45869,45834,2, 7}, -- decrease health, okoma
      { 5365,45839,1, 8}, -- frost weapon, dekeipa
      {26848,45838,1, 9}, -- flame weapon, rakeipa
      {26844,45840,1,10}, -- shock weapon, meip
      {26587,45837,1,11}, -- poison weapon, kuoko
      {26841,45841,1,12}, -- foul weapon, haoko
      { 5366,45842,1,13}, -- hardening, deteri
      {26591,45843,2,14}, -- weakening, okori
    },
    [ITEMTYPE_GLYPH_JEWELRY] = {
      {26581,45834,1, 1},  -- health recovery, okoma
      {26583,45835,1, 2},  -- magicka recovery, makkoma
      {26589,45836,1, 3},  -- stamina recovery, denima
      {45870,45835,2, 4},  -- reduce spell cost, makkoma
      {45871,45836,2, 5},  -- reduce feat cost, denima
      {45883,45847,1, 6},  -- increase physical harm, taderi
      {45884,45848,1, 7},  -- increase magical harm, makderi
      {45885,45847,2, 8},  -- decrease physical harm, taderi
      {45886,45848,2, 9},  -- decrease spell harm, makderi
      { 5364,45839,2,10},  -- frost resist, dekeipa
      {26849,45838,2,11},  -- flame resist, rakeipa
      {43570,45840,2,12},  -- shock resist, meip
      {26586,45837,2,13},  -- poison resist, kuoko
      {26847,45841,2,14},  -- disease resist, haoko
      {45872,45849,1,15},  -- bashing, kaderi
      {45873,45849,2,16},  -- shielding, kaderi
      {45874,45846,1,17},  -- potion boost, oru
      {45875,45846,2,18},  -- potion speed, oru
    },
  },
  job = { amount = 0, slot = {0,0,0}},
  refine = { glyphs = {nil}, crafted = false }
}
CS.Flask = {
  reagent = {},
  noBad = false,
  solvent = {883,1187,4570,23265,23266,23267,23268,64500,64501},
  reagentTrait = {
    {30165, 2,14,12,23},
    {30158, 9, 3,18,13},
    {30155, 6, 8, 1,22},
    {30152,18, 2, 9, 4},
    {30162, 7, 5,16,11},
    {30148, 4,10, 1,23},
    {30149,16, 2, 7, 6},
    {30161, 3, 9, 2,24},
    {30160,17, 1,10, 3},
    {30154,10, 4,17,12},
    {30157, 5, 7, 2,21},
    {30151, 2, 4, 6,20},
    {30164, 1, 3, 5,19},
    {30159,11,22,24,19},
    {30163,15, 1, 8, 5},
    {30153,13,21,23,19},
    {30156, 8, 6,15,12},
    {30166, 1,13,11,20}
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
CS.CraftIcon = {  
  'esoui/art/icons/ability_smith_007.dds',       -- BlackSmithing
  'esoui/art/icons/ability_tradecraft_008.dds',  -- Closier
  'esoui/art/icons/ability_enchanter_001b.dds',  -- Enchanting
  'esoui/art/icons/ability_alchemy_006.dds',     -- Alchemy
  'esoui/art/icons/ability_provisioner_002.dds', -- Provisioning
  'esoui/art/icons/ability_tradecraft_009.dds',  -- WoodWorking
}
CS.Flags = {
  'esoui/art/guild/guildbanner_icon_aldmeri.dds',    -- AD
  'esoui/art/guild/guildbanner_icon_ebonheart.dds',  -- EP
  'esoui/art/guild/guildbanner_icon_daggerfall.dds', -- DC
}
CS.Classes = {
  'esoui/art/icons/class/class_dragonknight.dds', -- Dragon Knight
  'esoui/art/icons/class/class_sorcerer.dds',     -- Sorcerer
  'esoui/art/icons/class/class_nightblade.dds',   -- NightBlade
  'esoui/art/icons/class/class_warden.dds',       -- Warden
  'esoui/art/icons/class/class_battlemage.dds',   -- Battle Mage
  'esoui/art/icons/class/class_templar.dds'       -- Templar
}
CS.Sets = {
  {traits=2,nodes={  7,175, 77},item=49575,zone={ 2,15,11}},  -- Aschengriff
  {traits=2,nodes={  1,177, 71},item=43805,zone={ 2,15,11}},  -- Todeswind
  {traits=2,nodes={216,121, 65},item=47279,zone={ 2,15,11}},  -- Stille der Nacht
  
  {traits=3,nodes={ 15,169,205},item=43808,zone={ 4, 7,10}},  -- Zwielicht
  {traits=3,nodes={ 23,164, 32},item=48042,zone={ 4, 7,10}},  -- Verführung
  {traits=3,nodes={ 19,165, 24},item=43979,zone={ 4, 7,10}},  -- Torugs Pakt
  {traits=3,nodes={237,237,237},item=69942,zone={27,27,27}},  -- Prüfungen
  
  {traits=4,nodes={  9,154, 51},item=51105,zone={ 3,16, 9}},  -- Histrinde
  {traits=4,nodes={ 82,151, 78},item=47663,zone={ 3,16, 9}},  -- Weißplanke
  {traits=4,nodes={ 13,148, 48},item=43849,zone={ 3,16, 9}},  -- Magnus
  
  {traits=5,nodes={ 58,101, 93},item=48425,zone={ 5, 8,13}},  -- Kuss des Vampirs
  {traits=5,nodes={137,103, 89},item=52243,zone={ 5, 8,13}},  -- Lied der Lamien
  {traits=5,nodes={155,105, 95},item=52624,zone={ 5, 8,13}},  -- Alessias Bollwerk
  {traits=5,nodes={199,201,203},item=60280,zone={26,26,26}},  -- Adelssieg
  {traits=5,nodes={257,257,257},item=71806,zone={28,28,28}},  -- Tavas Gunst
  {traits=5,nodes={254,254,254},item=75406,zone={29,29,29}},  -- DB:Kwatch Gladiator
  
  {traits=6,nodes={ 35,144,111},item=51486,zone={ 6,17,12}},  -- Weidenpfad
  {traits=6,nodes={ 39,161,113},item=51864,zone={ 6,17,12}},  -- Hundings Zorn
  {traits=6,nodes={ 34,156,118},item=49195,zone={ 6,17,12}},  -- Mutter der Nacht
  {traits=6,nodes={241,241,241},item=69592,zone={27,27,27}},  -- Julianos
  
  {traits=7,nodes={199,201,203},item=60630,zone={26,26,26}},  -- Umverteilung
  {traits=7,nodes={257,257,257},item=72156,zone={28,28,28}},  -- Schlauer Alchemist
  {traits=7,nodes={251,251,251},item=75756,zone={29,29,29}},  -- DB:Varen's Legacy
  
  {traits=8,nodes={135,135,135},item=43968,zone={23,23,23}},  -- Erinnerung
  {traits=8,nodes={133,133,133},item=43972,zone={23,23,23}},  -- Schemenauge
  {traits=8,nodes={ -1, -1, -1},item=44053,zone={ 6,17,12}},  -- Augen von Mara
  {traits=8,nodes={ -1, -1, -1},item=54149,zone={ 6,17,12}},  -- Shalidor's Fluch
  {traits=8,nodes={ -2, -2, -2},item=53772,zone={ 6,17,12}},  -- Karegnas Hoffnung
  {traits=8,nodes={ -2, -2, -2},item=53006,zone={ 6,17,12}},  -- Ogrumms Schuppen
  {traits=8,nodes={217,217,217},item=54963,zone={25,25,25}},  -- Arena
  
  {traits=9,nodes={234,234,234},item=58174,zone={25,25,25}},  -- Doppelstern
  {traits=9,nodes={199,201,203},item=60980,zone={26,26,26}},  -- Rüstungsmeister
  {traits=9,nodes={237,237,237},item=70642,zone={27,27,27}},  -- Morkuldin
  {traits=9,nodes={255,255,255},item=72506,zone={28,28,28}},  -- Ewige Jagd
  {traits=9,nodes={254,254,254},item=76106,zone={29,29,29}},  -- DB:Pelinal's Aptitude
}

CS.AccountInit = {
  option = {true,false,true,true,true,true,true,true,true,true,true,true,true,false,true,true},
  mainchar = false,
  timer = { [12] = 0, [24] = 0},
  position = {350,100},
  questbox = {GuiRoot:GetWidth()-500,-20},
  button = {75,75},
  player = {},
  storage = {},
  materials = {},
  announce = {},
  crafting = { research = {}, studies = {}, stored = {}, skill = {} },
  style = { tracking = {}, knowledge = {} },
  cook =  { tracking = {}, knowledge = {}, ingredients = {} }
}

CS.CharInit = {
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
  hideperfectedstyles = false,   
  previewtype = 1
}

CS.ItemLinkCache = {
  [BAG_BACKPACK]={},
  [BAG_BANK]={},
  [BAG_VIRTUAL]={},
}

CS.RawItemTypes = CS.Set{    
  ITEMTYPE_BLACKSMITHING_RAW_MATERIAL,
  ITEMTYPE_CLOTHIER_RAW_MATERIAL,
  ITEMTYPE_WOODWORKING_RAW_MATERIAL,
  ITEMTYPE_RAW_MATERIAL
}

CS.previewType = {
  [CS.Loc.previewType[1]] = 1,
  [CS.Loc.previewType[2]] = 2,
  [CS.Loc.previewType[3]] = 3,
  [CS.Loc.previewType[4]] = 4,
}

