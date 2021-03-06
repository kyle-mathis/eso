-------------------------------------------------------------------------------
-- SkyShards Data v2.2.2
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

--achievementIDs for skyshards:
local achievementIDs = {
   [556] = true, -- Alik'r Desert Skyshards
   [695] = true, -- Auridon Skyshards
   [405] = true, -- Bal Foyen Skyshards
   [557] = true, -- Bangkorai Skyshards
   [408] = true, -- Betnikh Skyshards
   [398] = true, -- Bleakrock Skyshards
   [686] = true, -- Coldharbour Skyshards
   [727] = true, -- Lower Craglorn Skyshards
   [912] = true, -- Upper Craglorn Skyshards
   [694] = true, -- Cyrodiil Aldmeri Skyshards
   [693] = true, -- Cyrodiil Daggerfall Skyshards
   [692] = true, -- Cyrodiil Ebonheart Skyshards
   [547] = true, -- Deshaan Skyshards
   [688] = true, -- Eastmarch Skyshards
   [409] = true, -- Glenumbra Skyshards
   [682] = true, -- Grahtwood Skyshards
   [683] = true, -- Greenshade Skyshards
   [431] = true, -- Khenarthi's Roost Skyshards
   [684] = true, -- Malabal Tor Skyshards
   [748] = true, -- Mountain Skyshard
   [685] = true, -- Reaper's March Skyshards
   [554] = true, -- Rivenspire Skyshards
   [687] = true, -- Shadowfen Skyshards
   [397] = true, -- Stonefalls Skyshards
   [515] = true, -- Stormhaven Skyshards
   [407] = true, -- Stros M'Kai Skyshards
   [689] = true, -- The Rift Skyshards
   [1160] = true, --Imperial City Skyshards
	[1320] = true, --Wrothgar Skyshard Hunter
}


local skyshardsData = {}
-- format: locX, locY, achievementId, criteriaIndex, [moreInfo]
--    moreInfo:
--       nil = default
--       1 = on city map
--       2 = in delve
--       3 = in public dungeon
--       4 = under ground
--       5 = in group delve
skyshardsData["alikr"] = {
--Alik'r Desert (Daggerfall, lvl 31-37)
   ["alikr_base"] = {            --Alik'r Desert
      { 0.2462, 0.4904, 556, 1, 1 }, --Sentinel                     --0.206, 0.488
      { 0.4077, 0.6275, 556, 2 },                                   --0.391, 0.646
      { 0.2314, 0.7011, 556, 3 },                                   --0.189, 0.731
      { 0.5214, 0.6649, 556, 4, 1 }, --Bergama                      --0.523, 0.689
      { 0.5854, 0.5002, 556, 5 },                                   --0.595, 0.500
      { 0.5584, 0.3471, 556, 6 },                                   --0.564, 0.324
      { 0.7738, 0.4364, 556, 7, 1 }, --Kozanset                     --0.811, 0.427
      { 0.7516, 0.4092, 556, 8 },                                   --0.786, 0.395
      { 0.8811, 0.5490, 556, 9 },                                   --0.934, 0.556
      { 0.6412, 0.6435, 556, 10, 2 }, --Aldunz                      --0.659, 0.665
      { 0.6482, 0.3484, 556, 11, 2 }, --Coldrock Diggings           --0.667, 0.326
      { 0.4054, 0.5892, 556, 12, 2 }, --Divad's Chagrin Mine        --0.382, 0.596
      { 0.8312, 0.5806, 556, 13, 2 }, --Sandblown Mine              --0.877, 0.592
      { 0.2224, 0.5678, 556, 14, 2 }, --Santaki                     --0.178, 0.578
      { 0.9008, 0.5207, 556, 15, 2 }, --Yldzuun                     --0.957, 0.524
      { 0.7050, 0.3890, 556, 16, 3 }, --Lost City of the Na-Totambu --0.732, 0.373
   },
   ["sentinel_base"] = {
      { 0.3814, 0.6455, 556, 1 },
   },
   ["bergama_base"] = {
      { 0.4265, 0.6168, 556, 4 },
   },
   ["kozanset_base"] = {
      { 0.6501, 0.3348, 556, 7 },
   },
   ["aldunz_base"] = {
      { 0.146, 0.436, 556, 10 },    --Update 5
   },
   ["coldrockdiggings_base"] = {
      { 0.903, 0.262, 556, 11 },    --Update 5
   },
   ["divadschagrinmine_base"] = {
      { 0.408, 0.533, 556, 12 },    --Update 5
   },
   ["sandblownmine_base"] = {
      { 0.854, 0.347, 556, 13 },    --Update 5
   },
   ["santaki_base"] = {
      { 0.917, 0.709, 556, 14 },    --Update 5
   },
   ["yldzuun_base"] = {
      { 0.695, 0.329, 556, 15 },    --Update 5
   },
   ["lostcity_base"] = {
      { 0.471, 0.580, 556, 16 },
   },
}

skyshardsData["auridon"] = {
--Auridon (Aldmeri lvl 5-15)
   ["auridon_base"] = { --Auridon
      { 0.6023, 0.8952, 695, 1, 1 }, --Vulkhel Guard
      { 0.708, 0.829, 695, 2 },
      { 0.437, 0.775, 695, 3 },
      { 0.6896, 0.5177, 695, 4, 1 }, --Skywatch
      { 0.5981, 0.4013, 695, 5 },
      { 0.4760, 0.5340, 695, 6 },
      { 0.4223, 0.3228, 695, 7 },
      { 0.4757, 0.3569, 695, 8 },
      { 0.419, 0.136, 695, 9 },
      { 0.439, 0.406, 695, 10, 2 }, --Bewan
      { 0.583, 0.852, 695, 11, 2 }, --Del's Claim
      { 0.563, 0.560, 695, 12, 2 }, --Entila's Folly
      { 0.203, 0.217, 695, 13, 2 }, --Mehrunes' Spite
      { 0.546, 0.698, 695, 14, 2 }, --Ondil
      { 0.579, 0.326, 695, 15, 2 }, --Wansalen
      { 0.423, 0.676, 695, 16, 3 }, --Toothmaul Gully
   },
   ["vulkhelguard_base"] = {
      { 0.3950, 0.4045, 695, 1 }, --Update 6
   },
   ["skywatch_base"] = {
      { 0.5469, 0.5537, 695, 4 },
   },
   ["bewan_base"] = {
      { 0.9172, 0.8361, 695, 10 },    --Update 6
   },
   ["delsclaim_base"] = {
      { 0.316, 0.219, 695, 11 },    --Update 5
   },
   ["entilasfolly_base"] = {
      { 0.8189, 0.7917, 695, 12 },    --Update 6
   },
   ["mehrunesspite_base"] = {
      { 0.694, 0.256, 695, 13 },    --Update 6
   },
   ["ondil_base"] = {
      { 0.835, 0.624, 695, 14 },    --Update 6
   },
   ["wansalen_base"] = {
      { 0.2766, 0.5446, 695, 15 },    --Update 6
   },
   ["toothmaulgully_base"] = {
      { 0.635, 0.669, 695, 16 },
   },
--Khenarthi's Roost (Aldmeri, lvl 1-5)
   ["khenarthisroost_base"] = {  --Khenarthi's Roost
      { 0.5893, 0.8093, 431, 1 },
      { 0.5370, 0.7000, 431, 2 },
      { 0.1628, 0.5554, 431, 3 },
      { 0.6827, 0.5788, 431, 4 },
      { 0.4294, 0.4062, 431, 5, 1 }, --Mistral
      { 0.2809, 0.3642, 431, 6 },
   },
   ["mistral_base"] = {
      { 0.1479, 0.3446, 431, 5 },
   },
}

skyshardsData["bangkorai"] = {
--Bangkorai (Daggerfall, lvl 37-43)
   ["bangkorai_base"] = {        --Bangkorai
      { 0.387, 0.390, 557, 1, 1 }, --Evermore
      { 0.582, 0.248, 557, 2 },
      { 0.602, 0.096, 557, 3 },  --bug #334
      { 0.560, 0.476, 557, 4 },  --bug #215, #340
      { 0.377, 0.448, 557, 5 },
      { 0.539, 0.332, 557, 6 },  --bug #330
      { 0.465, 0.830, 557, 7 },  --bug #396
      { 0.358, 0.590, 557, 8 },
      { 0.630, 0.725, 557, 9 },
      { 0.454, 0.504, 557, 10, 2 }, --Crypt of the Exiles
      { 0.557, 0.752, 557, 11, 2 }, --Klathzgar
      { 0.332, 0.270, 557, 12, 2 }, --Torog's Spite
      { 0.246, 0.660, 557, 13, 2 }, --Rubble Butte
      { 0.712, 0.198, 557, 14, 2 }, --Troll's Toothpick
      { 0.647, 0.421, 557, 15, 2 }, --Viridian Watch
      { 0.233, 0.899, 557, 16, 3 }, --Razak's Wheel
   },
   ["evermore_base"] = {
      { 0.355, 0.680, 557, 1 },
   },
   ["cryptoftheexiles_base"] = {
      { 0.678, 0.342, 557, 10 }, --Update 4
   },
   ["jaggerjaw_base"] = {        --Klathzgar
      { 0.532, 0.826, 557, 11 }, --Update 4
   },
   ["murciensclaim_base"] = {    --Torog's Spite
      { 0.188, 0.237, 557, 12 }, --Update 4
   },
   ["rubblebutte_base"] = {
      { 0.656, 0.857, 557, 13 }, --Update 4
   },
   ["trollstoothpick_base"] = {
      { 0.656, 0.334, 557, 14 }, --Update 4
   },
   ["viridianwatch_base"] = {
      { 0.119, 0.333, 557, 15 }, --Update 4
   },
   ["razakswheel_base"] = {
      { 0.69, 0.45, 557, 16 },
   },
}

skyshardsData["coldharbor"] = {
--Coldharbour (all, lvl 45-50)
   ["coldharbour_base"] = {      --Coldharbour
      { 0.4147, 0.6252, 686, 1 },
      { 0.4550, 0.7381, 686, 2 },
      { 0.2037, 0.6285, 686, 3 },
      { 0.6133, 0.6482, 686, 4 },
      { 0.6980, 0.6462, 686, 5 },
      { 0.6745, 0.7866, 686, 6 },
      { 0.4796, 0.5828, 686, 7 },
      { 0.4454, 0.4147, 686, 8 },
      { 0.6758, 0.4035, 686, 9 },
      { 0.4127, 0.5344, 686, 10, 2 }, --Aba-Loria
      { 0.6838, 0.7244, 686, 11, 2 }, --The Vault of Haman Forgefire
      { 0.4223, 0.7878, 686, 12, 2 }, --The Grotto of Depravity
      { 0.4541, 0.5096, 686, 13, 2 }, --Mal Sorra's Tomb
      { 0.6704, 0.5746, 686, 14, 2 }, --The Cave of Trophies
      { 0.6604, 0.3758, 686, 15, 2 }, --The Wailing Maw
      { 0.7116, 0.6352, 686, 16, 3 }, --Village of the Lost
   },
-- ["wailingprison7_base"] = {
--    { 0.495, 0.557, ,  }, --tutorial area
-- },
   ["aba-loria_base"] = {
      { 0.2696, 0.4304, 686, 10 }, --updated for 1.3.x
   },
   ["vaultofhamanforgefire_base"] = {
      { 0.5268, 0.1484, 686, 11 }, --updated for 1.6.x
   },
   ["depravedgrotto_base"] = {
      { 0.2820, 0.2672, 686, 12 }, --updated for 1.3.x
   },
   ["malsorrastomb_base"] = {
      { 0.3663, 0.4108, 686, 13 }, --updated for 1.3.x
   },
   ["caveoftrophies_base"] = {   --updated for 1.3.x
      { 0.5614, 0.7433, 686, 14 },
   },
   ["wailingmaw_base"] = {       --updated for 1.3.x
      { 0.7675, 0.7018, 686, 15 },
   },
   ["villageofthelost_base"] = {
      { 0.3271, 0.5004, 686, 16 },
   },
}

skyshardsData["craglorn"] = {
   ["craglorn_base"] = {
      --Lower Craglorn SkyShards
      { 0.7478, 0.7250, 727, 1, 5 }, --Molavar U7
      { 0.6853, 0.5995, 727, 2, 5 }, --Rkundzelft U7
      { 0.2847, 0.4599, 727, 3, 5 }, --Ruins of Kardala U7
      { 0.4415, 0.4684, 727, 4, 5 }, --Rkhardahrk U7
      { 0.6674, 0.6733, 727, 5, 5 }, --Haddock's Market U7
      { 0.7198, 0.4387, 727, 6, 5 }, --Chiselshriek Mine U7
      { 0.1468, 0.4594, 727, 7, 5 }, --Buried Sands U7
      { 0.2149, 0.5750, 727, 8, 5 }, --Mtharnaz U7
      { 0.8132, 0.5757, 727, 9, 5 }, --Balamath U7
      { 0.4686, 0.6635, 727, 10, 5 }, --Zalgaz's Den U7
      { 0.3219, 0.6543, 727, 11, 5 }, --Tombs of the Na-Totambu U7
      { 0.5375, 0.5407, 727, 12, 5 }, --Hircine's Haunt U7
      --Upper Craglorn SkyShards
      { 0.2825, 0.2640, 912, 1, 5 }, --Serpent's Nest U7
      { 0.5827, 0.4257, 912, 2, 5 }, --Ilthag's Undertower U7
      { 0.4002, 0.3094, 912, 3, 5 }, --Loth'Na Caverns U7
      { 0.6622, 0.3317, 912, 4, 5 }, --The Howling Sepulchers U7
      { 0.0868, 0.3064, 912, 5, 5 }, --Fearfangs Cavern U7
      { 0.5478, 0.2512, 912, 6, 5 }, --Exarch's Stronghold U7
   },
   ["molavar_base"] = {
      { 0.747, 0.352, 727, 1 },
   },
   ["rkundzelft_base"] = {
      { 0.715, 0.382, 727, 2 },
   },
   ["kardala_base"] = {
      { 0.612, 0.455, 727, 3 },
   },
   ["rkhardahrk_0"] = {
      { 0.463, 0.381, 727, 4 },
   },
   ["haddock_base"] = {
      { 0.656, 0.233, 727, 5 },
   },
   ["chiselshriek_base"] = {
      { 0.863, 0.224, 727, 6 },
   },
   ["burriedsands_base"] = {
      { 0.692, 0.151, 727, 7 },
   },
   ["mtharnaz_base"] = {
      { 0.884, 0.625, 727, 8 },
   },
   ["balamath_base"] = {
      { 0.643, 0.575, 727, 9 },
   },
   ["thaliasretreat_base"] = { --Zalgaz's Den
      { 0.463, 0.292, 727, 10 },
   },
   ["cryptoftarishzizone_base"] = { --Tombs of the Na-Totambu
      { 0.830, 0.446, 727, 11 },
   },
   ["hircineshaunt_base"] = {
      { 0.329, 0.661, 727, 12 },
   },
   --Upper Craglorn
   ["serpentsnest_base"] = {
      { 0.632, 0.507, 912, 1 },
   },
   ["ilthagsundertower_base"] = {
      { 0.370, 0.147, 912, 2 },
   },
   ["lothna_base"] = {
      { 0.416, 0.425, 912, 3 },
   },
   ["howlingsepulchersoverland_base"] = {
      { 0.528, 0.534, 912, 4 },
   },
   ["fearfang_base"] = {
      { 0.572, 0.510, 912, 5 },
   },
   ["exarchsstronghold_base"] = {
      { 0.626, 0.558, 912, 6 },
   },
}

skyshardsData["cyrodiil"] = {
--Cyrodiil (all, lvl 10+)
   ["ava_whole"] = {          --Cyrodiil
   --Aldmeri
      { 0.574, 0.851, 694, 1 },
      { 0.413, 0.842, 694, 2 },
      { 0.311, 0.659, 694, 3 },
      { 0.629, 0.681, 694, 4 },
      { 0.482, 0.534, 694, 5 },
      { 0.184, 0.458, 694, 6 },
      { 0.259, 0.531, 694, 7 },
      { 0.501, 0.761, 694, 8 },
      { 0.330, 0.770, 694, 9 },
      { 0.5377, 0.8100, 694, 10, 2 }, --Bloodmayne Cave
      { 0.2893, 0.4848, 694, 11, 2 }, --Breakneck Cave
      { 0.3165, 0.5627, 694, 12, 2 }, --Haynote Cave
      { 0.3628, 0.6982, 694, 13, 2 }, --Nisin Cave
      { 0.4548, 0.7252, 694, 14, 2 }, --Pothole Caverns
      { 0.2056, 0.5074, 694, 15, 2 }, --Serpent Hollow Cave
   --Daggerfall
      { 0.105, 0.267, 693, 1 },
      { 0.153, 0.152, 693, 2 },
      { 0.176, 0.371, 693, 3 },
      { 0.467, 0.172, 693, 4 },
      { 0.210, 0.397, 693, 5 },
      { 0.375, 0.330, 693, 6 },
      { 0.271, 0.229, 693, 7 },
      { 0.2945, 0.1286, 693, 8 },
      { 0.535, 0.224, 693, 9 },
      { 0.4217, 0.1465, 693, 10, 2 }, --Capstone Cave
      { 0.3547, 0.1348, 693, 11, 2 }, --Echo Cave
      { 0.1544, 0.2411, 693, 12, 2 }, --Lipsand Tarn
      { 0.5831, 0.1949, 693, 13, 2 }, --Red Ruby Cave
      { 0.5027, 0.2148, 693, 14, 2 }, --Toadstool Hollow
      { 0.3612, 0.2210, 693, 15, 2 }, --Underpall Cave
   --Ebonheart
      { 0.8105, 0.1672, 692, 1 },
      { 0.8874, 0.3297, 692, 2 },
      { 0.7023, 0.6259, 692, 3 },
      { 0.7793, 0.3877, 692, 4 },
      { 0.7238, 0.5086, 692, 5 },
      { 0.6542, 0.3785, 692, 6 },
      { 0.8068, 0.3047, 692, 7 },
      { 0.7796, 0.2086, 692, 8, 4 },
      { 0.6789, 0.1857, 692, 9 },
      { 0.6726, 0.5961, 692, 10, 2 }, --Cracked Wood Cave
      { 0.8074, 0.2506, 692, 11, 2 }, --Kingscrest Cavern
      { 0.7103, 0.4903, 692, 12, 2 }, --Muck Valley Cavern
      { 0.7211, 0.6949, 692, 13, 2 }, --Newt Cave
      { 0.7587, 0.3474, 692, 14, 2 }, --Quickwater Cave
      { 0.8067, 0.4610, 692, 15, 2 }, --Vahtacen
   --Mountain
      { 0.7525, 0.2966, 748, 1 },
   },
   --Aldmeri
   ["bloodmaynecave_base"] = {
      { 0.153, 0.486, 694, 10 },
   },
   ["breakneckcave_base"] = {
      { 0.488, 0.242, 694, 11 },
   },
   ["haynotecave_base"] = {
      { 0.539, 0.186, 694, 12 },
   },
   ["nisincave_base"] = {
      { 0.194, 0.723, 694, 13 },
   },
   ["potholecavern_base"] = {
      { 0.60, 0.45, 694, 14 },
   },
   ["serpenthollowcave_base"] = {
      { 0.257, 0.637, 694, 15 },
   },
   --Dagerrfall
   ["capstonecave_base"] = {
      { 0.694, 0.134, 693, 10 },
   },
   ["echocave_base"] = {
      { 0.421, 0.227, 693, 11 },
   },
   ["lipsandtarn_base"] = {
      { 0.733, 0.196, 693, 12},
   },
   ["redrubycave_base"] = {
      { 0.760, 0.291, 693, 13 },
   },
   ["toadstoolhollowlower_base"] = { --Toadstool Hollow lower floor
      { 0.40, 0.64, 693, 14 },
   },
   ["toadstoolhollow_base"] = {     --Toadstool Hollow
      { 0.48, 0.53, 693, 14 },
   },
   ["underpallcave_base"] = {
      { 0.770, 0.441, 693, 15 },
   },
   --Ebonheart
   ["crackedwoodcave_base"] = {
      { 0.3558, 0.3702, 692, 10 },
   },
   ["kingscrest_base"] = {
      { 0.7250, 0.4530, 692, 11 },
   },
   ["muckvalleycavern_base"] = {
      { 0.1752, 0.6967, 692, 12 },
   },
   ["newtcave_base"] = {
      { 0.380, 0.324, 692, 13 },
   },
   ["quickwatercave_base"] = {
      { 0.3965, 0.5494, 692, 14 },
   },
   ["vahtacen_base"] = {
      { 0.14, 0.78, 692, 15 },
   },
   --Imperial City
   ["imperialcity_base"] = {
      { 0.6110, 0.6370, 1160, 1 },
      { 0.8396, 0.3816, 1160, 2 },
      { 0.3934, 0.3604, 1160, 3 },
      { 0.4154, 0.3465, 1160, 4 },
      { 0.1589, 0.5419, 1160, 5 },
      { 0.4670, 0.6719, 1160, 6 },
   },
   ["imperialsewers_ebon1"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewers_ebon2"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewers_aldmeri1"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewers_aldmeri2"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewer_daggerfall1"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewer_daggerfall2"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewershub_base"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewer_ebonheart3"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewers_aldmeri3"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
   ["imperialsewer_daggerfall3"] = {
      { 0.4477, 0.3309, 1160, 7 },
      { 0.4142, 0.4021, 1160, 8 },
      { 0.9000, 0.6213, 1160, 9 },
      { 0.7540, 0.5502, 1160, 10 },
      { 0.1977, 0.6310, 1160, 11 },
      { 0.3200, 0.5578, 1160, 12 },
      { 0.5252, 0.5487, 1160, 13 },
   },
}

skyshardsData["deshaan"] = {
--Deshaan (Ebonheart, lvl 16-23)
   ["deshaan_base"] = {              --"Deshaan"
      { 0.0881, 0.4721, 547, 1 },
      { 0.1835, 0.5147, 547, 2, 1 }, --Narsis
      { 0.3316, 0.6391, 547, 3 },
      { 0.4181, 0.4808, 547, 4, 1 }, --Mournhold
      { 0.4721, 0.3958, 547, 5 },
      { 0.6735, 0.6527, 547, 6 },
      { 0.7798, 0.5881, 547, 7 },
      { 0.8044, 0.4728, 547, 8 },
      { 0.8591, 0.4870, 547, 9 },
      { 0.2012, 0.4485, 547, 10, 3 }, --Forgotten Crypts
      { 0.9128, 0.4383, 547, 11, 2 }, --Knife Ear Grotto
      { 0.2372, 0.4607, 547, 12, 2 }, --Lady Llarel's Shelter
      { 0.3049, 0.5682, 547, 13, 2 }, --Lower Bthanual
      { 0.5793, 0.4572, 547, 14, 2 }, --The Triple Circle Mine
      { 0.6249, 0.6112, 547, 15, 2 }, --Taleon's Crag
      { 0.7298, 0.3882, 547, 16, 2 }, --The Corpse Garden
   },
   ["narsis_base"] = {
      { 0.5269, 0.3668, 547, 2 },
   },
   ["mournhold_base"] = {
      { 0.3770, 0.3403, 547, 4 }, --Update 6
   },
   ["forgottencrypts_base"] = {
      { 0.5902, 0.3052, 547, 10 },
   },
   ["desolatecave_base"] = {     --Knife Ear Grotto
      { 0.5007, 0.6418, 547, 11 },
   },
   ["kwamacolony_base"] = {      --Lady Llarel's Shelter
      { 0.5273, 0.7025, 547, 12 },
   },
   ["lowerbthanuel_base"] = {
      { 0.5126, 0.1854, 547, 13 },
   },
   ["triplecirclemine_base"] = {
      { 0.5084, 0.3642, 547, 14 },
   },
   ["unexploredcrag_base"] = {   --Taleon's Crag
      { 0.3886, 0.3671, 547, 15 },
   },
   ["corpsegarden_base"] = {
      { 0.5762, 0.8077, 547, 16 },
   },
}

skyshardsData["eastmarch"] = {
--Eastmarch (Ebonheart, lvl 31-37)
   ["eastmarch_base"] = {        --Eastmarch
      { 0.333, 0.408, 688, 1 },
      { 0.584, 0.346, 688, 2 },
      { 0.611, 0.254, 688, 3 },
      { 0.406, 0.503, 688, 4 },
      { 0.308, 0.582, 688, 5, 1 }, --Fort Amol
      { 0.143, 0.592, 688, 6 },
      { 0.653, 0.512, 688, 7 },
      { 0.634, 0.585, 688, 8 },
      { 0.558, 0.650, 688, 9 },
      { 0.725, 0.623, 688, 10, 2 }, --The Bastard's Tomb
      { 0.624, 0.264, 688, 11, 2 }, --The Chill Hollow
      { 0.176, 0.558, 688, 12, 2 }, --The Frigid Grotto
      { 0.564, 0.432, 688, 13, 2 }, --Icehammer's Vault
      { 0.511, 0.618, 688, 14, 2 }, --Old Sord's Cave
      { 0.637, 0.653, 688, 15, 2 }, --Stormcrag Crypt
      { 0.474, 0.283, 688, 16, 3 }, --Hall of the Dead
   },
   ["fortamol_base"] = {
      { 0.733, 0.109, 688, 5 },
   },
   ["thebastardstomb_base"] = {
      { 0.543, 0.133, 688, 10 },    --Update 5
   },
   ["thechillhollow_base"] = {
      { 0.338, 0.887, 688, 11 },    --Update 5
   },
   ["thefrigidgrotto_base"] = {
      { 0.541, 0.719, 688, 12 },    --Update 5
   },
   ["icehammersvault_base"] = {
      { 0.130, 0.376, 688, 13 },    --Update 5
   },
   ["oldsordscave_base"] = {
      { 0.314, 0.731, 688, 14 },    --Update 5
   },
   ["stormcragcrypt_base"] = {
      { 0.322, 0.317, 688, 15 },    --Update 5
   },
   ["hallofthedead_base"] = {
      { 0.505, 0.525, 688, 16 },
   },
}

skyshardsData["glenumbra"] = {
--Glenumbra (Daggerfall, lvl 5-15)
   ["glenumbra_base"] = {        --Glenumbra
      { 0.319, 0.755, 409, 1, 1 }, --Dagerfall
      { 0.454, 0.540, 409, 2 },
      { 0.274, 0.628, 409, 3 },
      { 0.386, 0.418, 409, 4 },
      { 0.459, 0.485, 409, 5 },
      { 0.676, 0.442, 409, 6 },
      { 0.695, 0.191, 409, 7 },
      { 0.782, 0.309, 409, 8 },
      { 0.787, 0.116, 409, 9, 1 }, --Crosswych
      { 0.350, 0.727, 409, 10, 2 }, --Ilessan Tower
      { 0.272, 0.678, 409, 11, 2 }, --Silumm
      { 0.698, 0.530, 409, 12, 2 }, --Mines of Khuras
      { 0.343, 0.333, 409, 13, 2 }, --Enduum
      { 0.608, 0.185, 409, 14, 2 }, --Ebon Crypt
      { 0.766, 0.138, 409, 15, 2 }, --Cryptwatch Fort
      { 0.200, 0.739, 409, 16, 3 }, --Bad Man's Hallows
   },
   ["daggerfall_base"] = {
      { 0.695, 0.447, 409, 1 },
   },
   ["crosswych_base"] = {
      { 0.377, 0.325, 409, 9 },
      { 0.253, 0.461, 409, 15 },
   },
   ["ilessantower_base"] = {
      { 0.841, 0.312, 409, 10 },    --Update 6
   },
   ["silumm_base"] = {
      { 0.256, 0.213, 409, 11 },    --Update 6
   },
   ["minesofkhuras_base"] = {
      { 0.446, 0.664, 409, 12 },    --Update 6
   },
   ["enduum_base"] = {
      { 0.406, 0.861, 409, 13 },    --Update 6
   },
   ["eboncrypt_base"] = {
      { 0.402, 0.116, 409, 14 },    --Update 6
   },
   ["cryptwatchfort_base"] = {
      { 0.746, 0.264, 409, 15 },    --Update 5
   },
   ["badmanscave_base"] = {
      { 0.332, 0.509, 409, 16 },
   },
--Betnikh (Daggerfall, lvl 1-5)
   ["betnihk_base"] = {
      { 0.407, 0.271, 408, 1 },
      { 0.619, 0.605, 408, 2 },
      { 0.370, 0.595, 408, 3 },
   },
--Stros M'Kai (Daggerfall, lvl 1-5)
   ["strosmkai_base"] = {
      { 0.4249, 0.5167, 407, 1 },
      { 0.6431, 0.3978, 407, 2 },
      { 0.5407, 0.8067, 407, 3 },
   },
   ["porthunding_base"] = {
      { 0.4655, 0.4487, 407, 2 },
   },
}

skyshardsData["grahtwood"] = {
--Grahtwood (Aldmeri, lvl 16-23)
   ["grahtwood_base"] = {        --Grahtwood
      { 0.739, 0.678, 682, 1, 1 }, --Haven
      { 0.446, 0.723, 682, 2 },
      { 0.649, 0.667, 682, 3 },
      { 0.621, 0.526, 682, 4, 1 }, --Elden Root
      { 0.648, 0.363, 682, 5 },
      { 0.590, 0.319, 682, 6 },
      { 0.288, 0.224, 682, 7 },
      { 0.325, 0.599, 682, 8 },
      { 0.474, 0.537, 682, 9 },
      { 0.562, 0.665, 682, 10, 2 }, --Ne Salas
      { 0.806, 0.509, 682, 11, 2 }, --The Scuttle Pit
      { 0.484, 0.445, 682, 12, 2 }, --Burroot Kwama Mine
      { 0.722, 0.362, 682, 13, 2 }, --Vinedeath Cave
      { 0.185, 0.145, 682, 14, 2 }, --Wormroot Depths
      { 0.523, 0.598, 682, 15, 2 }, --Mobar Mine
      { 0.658, 0.597, 682, 16, 3 }, --Root Sunder Ruins
   },
   ["haven_base"] = {
      { 0.384, 0.249, 682, 1 },
   },
   ["eldenrootgroundfloor_base"] = {
      { 0.754, 0.626, 682, 4 },
   },
   ["nesalas_base"] = {
      { 0.575, 0.577, 682, 10 },
   },
   ["dessicatedcave_base"] = {   --The Scuttle Pit
      { 0.620, 0.463, 682, 11 },
   },
   ["burrootkwamamine_base"] = {
      { 0.781, 0.443, 682, 12 },
   },
   ["vindeathcave_base"] = {
      { 0.738, 0.746, 682, 13 },
   },
   ["wormrootdepths_base"] = {
      { 0.186, 0.706, 682, 14 },
   },
   ["mobarmine_base"] = {
      { 0.396, 0.477, 682, 15 },
   },
   ["rootsunder_base"] = {
      { 0.289, 0.661, 682, 16 },
   },
}

skyshardsData["greenshade"] = {
--Greenshade (Aldmeri lvl 25-30)
   ["greenshade_base"] = {       --Greenshade
      { 0.629, 0.795, 683, 1 },
      { 0.528, 0.656, 683, 2 },
      { 0.679, 0.484, 683, 3, 1 }, --Marbruk
      { 0.159, 0.699, 683, 4, 1 }, --Woodheart
      { 0.345, 0.733, 683, 5 },
      { 0.297, 0.573, 683, 6 },
      { 0.302, 0.156, 683, 7 },
      { 0.558, 0.473, 683, 8 },
      { 0.603, 0.404, 683, 9 },
      { 0.742, 0.613, 683, 10, 2 }, --Gurzag's Mine
      { 0.579, 0.895, 683, 11, 2 }, --Carac Dena
      { 0.369, 0.684, 683, 12, 2 }, --Naril Nagaia
      { 0.308, 0.399, 683, 13, 2 }, --The Underroot
      { 0.630, 0.450, 683, 14, 2 }, --Harridan's Lair
      { 0.294, 0.152, 683, 15, 2 }, --Barrow Trench
      { 0.388, 0.449, 683, 16, 3 }, --Rulanyil's Fall
   },
   ["marbruk_base"] = {
      { 0.334, 0.197, 683, 3 }, --Update 6
   },
   ["woodhearth_base"] = {
      { 0.486, 0.741, 683, 4 },
   },
   ["gurzagsmine_base"] = {
      { 0.613, 0.573, 683, 10 },
   },
   ["caracdena_base"] = {
      { 0.541, 0.492, 683, 11 },
   },
   ["narilnagaia_base"] = {
      { 0.266, 0.732, 683, 12 },
   },
   ["theunderroot_base"] = {
      { 0.47, 0.24, 683, 13 },
   },
   ["harridanslair_base"] = {
      { 0.737, 0.748, 683, 14 },
   },
   ["barrowtrench_base"] = {
      { 0.540, 0.562, 683, 15 },
   },
   ["rulanyilsfall_base"] = {
      { 0.681, 0.415, 683, 16 },
   },
}

skyshardsData["malabaltor"] = {
--Malabal Tor (Aldmeri, lvl 31-37)
   ["malabaltor_base"] = { --Malabal Tor
      { 0.187, 0.499, 684, 1, 1 }, --Velyn Harbor
      { 0.214, 0.451, 684, 2 },
      { 0.341, 0.594, 684, 3 },
      { 0.507, 0.585, 684, 4 },
      { 0.545, 0.444, 684, 5, 1 }, --Vulkwasten
      { 0.491, 0.668, 684, 6 },
      { 0.788, 0.571, 684, 7 },
      { 0.774, 0.341, 684, 8 },
      { 0.647, 0.242, 684, 9 },
      { 0.788, 0.298, 684, 10, 2 }, --Black Vine Ruins
      { 0.349, 0.412, 684, 11, 2 }, --Dead Man's Drop
      { 0.473, 0.563, 684, 12, 2 }, --Hoarvor Pit
      { 0.708, 0.492, 684, 13, 2 }, --Roots of Silvenar
      { 0.623, 0.829, 684, 14, 2 }, --Shael Ruins
      { 0.380, 0.623, 684, 15, 2 }, --Tomb of the Apostates
      { 0.385, 0.406, 684, 16, 3 }, --Crimson Cove
   },
   ["velynharbor_base"] = {
      { 0.790, 0.450, 684, 1 },
   },
   ["vulkwasten_base"] = {
      { 0.462, 0.250, 684, 5 }
   },
   ["baandaritradingpost_base"] = {
      { 0.196, 0.259, 684, 10, 2 }, --Black Vine Ruins
   },
   ["blackvineruins_base"] = {
      { 0.379, 0.875, 684, 10 },    --Update 5
   },
   ["deadmansdrop_base"] = {
      { 0.191, 0.135, 684, 11 },    --Update 5
   },
   ["hoarvorpit_base"] = {
      { 0.440, 0.128, 684, 12 },    --Update 5
   },
   ["rootsofsilvenar_base"] = {
      { 0.571, 0.403, 684, 13 },    --Update 5
   },
   ["shaelruins_base"] = {
      { 0.312, 0.898, 684, 14 },    --Update 5
   },
   ["tomboftheapostates_base"] = {
      { 0.541, 0.168, 684, 15 },    --Update 5
   },
   ["crimsoncove_base"] = {
      { 0.83, 0.46, 684, 16 },
   },
}

skyshardsData["reapersmarch"] = {
--Reaper's March (Aldmeri, lvl 37-43)
   ["reapersmarch_base"] = {     --Reaper's March
      { 0.378, 0.199, 685, 1 },
      { 0.429, 0.334, 685, 2 },
      { 0.343, 0.149, 685, 3 },
      { 0.334, 0.538, 685, 4 },
      { 0.281, 0.624, 685, 5 },
      { 0.397, 0.644, 685, 6 },
      { 0.7800, 0.3495, 685, 7, 1 }, --Dune
      { 0.7681, 0.1668, 685, 8 },
      { 0.507, 0.364, 685, 9 },
      { 0.541, 0.301, 685, 10, 2 }, --Kuna's Delve
      { 0.361, 0.409, 685, 11, 2 }, --Thibaut's Cairn
      { 0.505, 0.755, 685, 12, 2 }, --Weeping Wind Cave
      { 0.239, 0.607, 685, 13, 2 }, --Claw's Strike
      { 0.753, 0.128, 685, 14, 2 }, --Fardir's Folly
      { 0.633, 0.395, 685, 15, 2 }, --Jode's Light
      { 0.282, 0.163, 685, 16, 3 }, --The Vile Manse
   },
   ["dune_base"] = {
      { 0.5870, 0.3386, 685, 7 },
   },
   ["kunasdelve_base"] = {
      { 0.752, 0.434, 685, 10 }, --Update 4
   },
   ["thibautscairn_base"] = {
      { 0.778, 0.666, 685, 11 }, --Update 4
   },
   ["weepingwindcave_base"] = {
      { 0.3760, 0.8308, 685, 12 }, --Update 4
   },
   ["clawsstrike_base"] = {
      { 0.116, 0.395, 685, 13 }, --Update 4
   },
   ["fardirsfolly_base"] = {
      { 0.332, 0.402, 685, 14 }, --Update 4
   },
   ["jodeslight_base"] = {
      { 0.1511, 0.2623, 685, 15 }, --Update 4
   },
   ["thevilemansefirstfloor_base"] = {    --first floor
      { 0.40, 0.42, 685, 16 },
   },
   ["thevilemansesecondfloor_base"] = {   --second floor
      { 0.65, 0.33, 685, 16 },
   },
}

skyshardsData["rivenspire"] = {
--Rivenspire (Daggerfall, lvl 25-30)
   ["rivenspire_base"] = {       --Rivenspire
      { 0.447, 0.602, 554, 1, 1 }, -- Stornhelm
      { 0.155, 0.568, 554, 2 },
      { 0.297, 0.507, 554, 3 },
      { 0.593, 0.539, 554, 4 },
      { 0.640, 0.543, 554, 5 },
      { 0.831, 0.166, 554, 6, 1 }, --Northpoint
      { 0.386, 0.366, 554, 7 },
      { 0.700, 0.127, 554, 8 },
      { 0.579, 0.441, 554, 9 },
      { 0.357, 0.490, 554, 10, 2 }, --Crestshade Mine
      { 0.400, 0.311, 554, 11, 2 }, --Erokii Ruins
      { 0.145, 0.592, 554, 12, 2 }, --Flyleaf Catacombs
      { 0.699, 0.184, 554, 13, 2 }, --Hildune's Secret Refuge
      { 0.809, 0.351, 554, 14, 2 }, --Orc's Finger Ruins
      { 0.670, 0.604, 554, 15, 2 }, --Tribulation Crypt
      { 0.556, 0.456, 554, 16, 3 }, --Obsidian Scar
   },
   ["shornhelm_base"] = {
      { 0.614, 0.804, 554, 1 },
      { 0.036, 0.077, 554, 10, 2 }, --Crestshade Mine
   },
   ["northpoint_base"] = {
      { 0.731, 0.201, 554, 6 },
   },
   ["crestshademine_base"] = {
      { 0.5223, 0.4445, 554, 10 },
   },
   ["erokii_base"] = {
      { 0.526, 0.879, 554, 11 },
   },
   ["flyleafcatacombs_base"] = {
      { 0.611, 0.354, 554, 12 },
   },
   ["hildunessecretrefuge_base"] = {
      { 0.578, 0.502, 554, 13 },
   },
   ["orcsfingerruins_base"] = {
      { 0.179, 0.348, 554, 14 },
   },
   ["tribulationcrypt_base"] = {
      { 0.3343, 0.7741, 554, 15 },
   },
   ["obsidianscar_base"] = {
      { 0.846, 0.595, 554, 16 },
   },
}

skyshardsData["shadowfen"] = {
--Shadowfen (Ebonheart, lvl 25-30)
   ["shadowfen_base"] = {        --Shadowfen
      { 0.4450, 0.2722, 687, 1, 1 }, --Stormhold
      { 0.2268, 0.2854, 687, 2 },
      { 0.5672, 0.4158, 687, 3 },
      { 0.6575, 0.5916, 687, 4, 1 }, --Alten Corimont
      { 0.7913, 0.7121, 687, 5 },
      { 0.5747, 0.7991, 687, 6 },
      { 0.3737, 0.7212, 687, 7 },
      { 0.1233, 0.7823, 687, 8 },
      { 0.2515, 0.5493, 687, 9 },
      { 0.8497, 0.5956, 687, 10, 2 }, --Atanaz Ruins
      { 0.8263, 0.3771, 687, 11, 2 }, --Broken Tusk
      { 0.2540, 0.7958, 687, 12, 2 }, --Chid-Moska Ruins
      { 0.4482, 0.6214, 687, 13, 2 }, --Gandranen Ruins
      { 0.6681, 0.7689, 687, 14, 2 }, --Onkobra Kwama Mine
      { 0.2899, 0.1693, 687, 15, 2 }, --Shrine of the Black Maw
      { 0.6513, 0.2719, 687, 16, 3 }, --Sanguine's Demesne
   },
   ["stormhold_base"] = {
      { 0.4468, 0.4943, 687, 1 },
   },
   ["altencorimont_base"] = {
      { 0.3629, 0.5262, 687, 4 },
   },
   ["atanazruins_base"] = {
      { 0.3601, 0.7318, 687, 10 },
   },
   ["brokentuskcave_base"] = {
      { 0.3523, 0.3464, 687, 11 },
   },
   ["chidmoskaruins_base"] = {
      { 0.7038, 0.6914, 687, 12 },
   },
   ["gandranen_base"] = {
      { 0.7728, 0.3154, 687, 13 },
   },
   ["onkobrakwamamine_base"] = {
      { 0.7378, 0.5210, 687, 14 },
   },
   ["shrineofblackworm_base"] = {
      { 0.8597, 0.6901, 687, 15 },
   },
   ["sanguinesdemesne_base"] = {
      { 0.6437, 0.6056, 687, 16 },
   },
}

skyshardsData["stonefalls"] = {
--Stonefalls (Ebonheart, lvl 5-15)
   ["stonefalls_base"] = {       --Stonefalls
      { 0.7770, 0.3460, 397, 1, 1 }, --Davon's Watch
      { 0.9437, 0.4716, 397, 2 },
      { 0.6138, 0.6115, 397, 3 },
      { 0.3910, 0.4678, 397, 4 },
      { 0.2535, 0.4110, 397, 5 },
      { 0.4664, 0.6038, 397, 6 },
      { 0.3364, 0.6818, 397, 7 },
      { 0.0868, 0.4452, 397, 8 },
      { 0.1299, 0.6103, 397, 9 },
      { 0.7166, 0.3932, 397, 10, 2 }, --Inner Sea Armature
      { 0.6432, 0.5915, 397, 11, 2 }, --Emberflint Mine
      { 0.5833, 0.5944, 397, 12, 2 }, --Mephala's Nest
      { 0.3575, 0.4488, 397, 13, 2 }, --Hightide Hollow
      { 0.2900, 0.5582, 397, 14, 2 }, --Softloam Cavern
      { 0.2110, 0.5405, 397, 15, 2 }, --Sheogorath's Tongue
      { 0.9334, 0.3608, 397, 16, 3 }, --Crow's Wood
   },
   ["davonswatch_base"] = {
      { 0.0953, 0.5117, 397, 1 },
      { 0.8752, 0.5854, 397, 16, 3 }, --Crow's Wood
   },
   ["innerseaarmature_base"] = {
      { 0.4384, 0.2726, 397, 10 },    --Update 6
   },
   ["emberflintmine_base"] = {
      { 0.7284, 0.5864, 397, 11 },    --Update 5
   },
   ["mephalasnest_base"] = {
      { 0.5612, 0.3496, 397, 12 },    --Update 6
   },
   ["hightidehollow_base"] = {        --Update 6
      { 0.6713, 0.6660, 397, 13 },
   },
   ["softloamcavern_base"] = {        --Update 6
      { 0.4197, 0.7056, 397, 14 }
   },
   ["sheogorathstongue_base"] = {
      { 0.5813, 0.2625, 397, 15 },    --Update 6
   },
   ["crowswood_base"] = {
      { 0.2447, 0.9636, 397, 16 },
   },
--Bal Foyen (Ebonheart lvl 1-5)
   ["balfoyen_base"] = {      --Bal Foyen
      { 0.5505, 0.5609, 405, 1, 1 }, --Dhalmora
      { 0.2462, 0.7440, 405, 2 },
      { 0.3775, 0.3160, 405, 3 },
   },
   ["dhalmora_base"] = {
      { 0.3312, 0.4539, 405, 1 },
   },
--Bleakrock Isle (Ebonheart, lvl 1-5)
   ["bleakrock_base"] = {  --Bleakrock Isle
      { 0.7744, 0.4388, 398, 1 },
      { 0.4985, 0.2252, 398, 2 },
      { 0.2547, 0.3964, 398, 3, 4 }, --Hozzin's Folly entrance
   },
   ["hozzinsfolley_base"] = {
      { 0.3296, 0.8098, 398, 3 },
   },
}

skyshardsData["stormhaven"] = {
--Stormhaven (Daggerfall, lvl 16-23)
   ["stormhaven_base"] = {       --Stormhaven
      { 0.150, 0.348, 515, 1 },
      { 0.220, 0.203, 515, 2 },
      { 0.222, 0.466, 515, 3 },
      { 0.644, 0.383, 515, 4 },
      { 0.684, 0.492, 515, 5 },
      { 0.394, 0.640, 515, 6 },
      { 0.776, 0.414, 515, 7 },
      { 0.825, 0.423, 515, 8 },
      { 0.867, 0.464, 515, 9 },
      { 0.786, 0.433, 515, 10, 2 }, --Bearclaw Mine
      { 0.389, 0.653, 515, 11, 2 }, --Farangel's Delve
      { 0.237, 0.494, 515, 12, 2 }, --Koeglin Mine
      { 0.605, 0.367, 515, 13, 2 }, --Norvulk Ruins
      { 0.458, 0.430, 515, 14, 2 }, --Pariah Catacombs
      { 0.308, 0.323, 515, 15, 2 }, --Portdun Watch
      { 0.317, 0.496, 515, 16, 3 }, --Bonesnap Ruins
   },
   ["bearclawmine_base"] = {
      { 0.178, 0.479, 515, 10 },
   },
   ["farangelsdelve_base"] = {
      { 0.754, 0.087, 515, 11 },
   },
   ["koeglinmine_base"] = {
      { 0.40, 0.12, 515, 12 },
   },
   ["norvulkruins_base"] = {
      { 0.352, 0.532, 515, 13 },
   },
   ["pariahcatacombs_base"] = {
      { 0.752, 0.319, 515, 14 },
   },
   ["portdunwatch_base"] = {
      { 0.706, 0.446, 515, 15 },
   },
   ["bonesnapruinssecret_base"] = {
      { 0.25, 0.73, 515, 16 },
   },
   ["bonesnapruins_base"] = {
      { 0.25, 0.64, 515, 16 },
   },
}

skyshardsData["therift"] = {
--The Rift (Ebonheart, lvl 37-43)
   ["therift_base"] = {          --The Rift
      { 0.429, 0.272, 689, 1 },
      { 0.647, 0.291, 689, 2 }, --Shor's Stone (you can't go there from city, so no "city" label on tooltip)
      { 0.319, 0.378, 689, 3 },
      { 0.330, 0.513, 689, 4 },
      { 0.393, 0.563, 689, 5 },
      { 0.110, 0.451, 689, 6 },     --bug #221
      { 0.837, 0.512, 689, 7 },
      { 0.782, 0.621, 689, 8 },
      { 0.719, 0.445, 689, 9 }, --Riften
      { 0.385, 0.574, 689, 10, 2 }, --Avanchnzel
      { 0.828, 0.588, 689, 11, 2 }, --Broken Helm Hollow entrance
      { 0.498, 0.472, 689, 12, 2 }, --Faldar's Tooth
      { 0.718, 0.404, 689, 13, 2 }, --Fort Greenwall
      { 0.134, 0.294, 689, 14, 2 }, --Shroud Hearth Barrow
      { 0.317, 0.234, 689, 15, 2 }, --Snapleg Cave
      { 0.059, 0.427, 689, 16, 3 }, --The Lion's Den
   },
   ["shorsstone_base"] = {
      { 0.292, 0.446, 689, 2 },
   },
   ["riften_base"] = {
      { 0.798, 0.185, 689, 9 },
   },
   ["avancheznel_base"] = {
      { 0.110, 0.640, 689, 10 }, --Update 4
   },
   ["brokenhelm_base"] = {
      { 0.872, 0.645, 689, 11 }, --Update 4
   },
   ["ebonmeretower_base"] = {    --Faldar's Tooth
      { 0.398, 0.419, 689, 12 }, --Update 4
   },
   ["fortgreenwall_base"] = {
      { 0.525, 0.447, 689, 13 }, --Update 4
   },
   ["shroudhearth_base"] = {
      { 0.779, 0.612, 689, 14 }, --Update 4
   },
   ["snaplegcave_base"] = {
      { 0.801, 0.770, 689, 15 }, --Update 4
   },
   ["thelionsden_base"] = {
      { 0.630, 0.399, 689, 16 },
   },
}

skyshardsData["wrothgar"] = {
--Wrothgar (Orsinium DLC)
   ["wrothgar_base"] = {          --Wrothgar
      { 0.1944, 0.8285, 1320, 1 },
      { 0.3342, 0.7521, 1320, 2 },
      { 0.1886, 0.6740, 1320, 3 },
      { 0.5300, 0.7857, 1320, 4 },
      { 0.4653, 0.4621, 1320, 5, 1 },
      { 0.4325, 0.6275, 1320, 6 },
      { 0.5316, 0.3541, 1320, 7 },
      { 0.6411, 0.4958, 1320, 8 },
      { 0.8448, 0.4297, 1320, 9 },
      { 0.1718, 0.6599, 1320, 10, 3 }, --Old Orsinium
      { 0.8950, 0.4718, 1320, 11, 3 }, --Rkindaleft
      { 0.5405, 0.5826, 1320, 12, 2 }, --Argent Mine
      { 0.8116, 0.5960, 1320, 13, 2 }, --Coldperch Cavern
      { 0.2957, 0.7386, 1320, 14, 2 }, --Thukhozod's Sanctum
      { 0.7107, 0.3779, 1320, 15, 2 }, --Zthenganaz
      { 0.5689, 0.6969, 1320, 16, 2 }, --Nikolvara's Kennel
      { 0.1984, 0.8451, 1320, 17, 2 }, --Watcher's Hold
   },
	["morkul_base"] = {
      { 0.1247, 0.4609, 1320, 5, 1 },
   },
   ["oldorsiniummap06_base"] = {
      { 0.6095, 0.7278, 1320, 10, 3 },
   },
   ["rkindaleftoutside_base"] = {
      { 0.2644, 0.3887, 1320, 11, 3 },
   },
   ["argentmine2_base"] = {
      { 0.1854, 0.8436, 1320, 12, 2 },
   },
   ["coldperchcavern_base"] = {
      { 0.3289, 0.8272, 1320, 13, 2 },
   },
   ["thukozods_base"] = {
      { 0.2869, 0.4652, 1320, 14, 2 },
   },
	["zthenganaz_base"] = {
      { 0.1164, 0.1165, 1320, 15, 2 },
   },
   ["kennelrun_base"] = {
      { 0.9001, 0.7077, 1320, 16, 2 },
   },
   ["watchershold_base"] = {
      { 0.7644, 0.6611, 1320, 17, 2 },
   },
}

function SkyShards_GetAchievementIDs()
   return achievementIDs
end

function SkyShards_GetLocalData(zone, subzone)
   if type(zone) == "string" and type(subzone) == "string" and skyshardsData[zone] and skyshardsData[zone][subzone] then
      return skyshardsData[zone][subzone]
   end
end

function SkyShards_SetLocalData(zone, subzone, data)
   if type(zone) == "string" and type(subzone) == "string" and type(data) == "table" then
      skyshardsData[zone] = skyshardsData[zone] or {}
      skyshardsData[zone][subzone] = skyshardsData[zone][subzone] or {}
      table.insert(skyshardsData[zone][subzone], data)
   end
end