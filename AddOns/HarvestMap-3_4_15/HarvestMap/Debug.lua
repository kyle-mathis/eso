if not Harvest then
	Harvest = {}
end

function Harvest.GenerateDebugInfo()
	list = {}
	table.insert(list, "[spoiler][code]\n")
	table.insert(list, "Version:")
	table.insert(list, Harvest.displayVersion)
	table.insert(list, "\n")
	for key, value in pairs(Harvest.defaultSettings) do
		value = Harvest.savedVars["settings"][key]
		if type(value) ~= "table" then
			table.insert(list, key)
			table.insert(list, ":")
			table.insert(list, tostring(value))
			table.insert(list, "\n")
		else
			local k, v = next(value)
			if type(v) == "boolean" then
				table.insert(list, key)
				table.insert(list, ":")
				for k, v in ipairs(value) do
					if v then
						table.insert(list, "y")
					else
						table.insert(list, "n")
					end
				end
				table.insert(list, "\n")
			end
		end
	end
	table.insert(list, "Addons:\n")
	local addonManager = GetAddOnManager()
	for addonIndex = 1, addonManager:GetNumAddOns() do
		local name, _, _, _, enabled = addonManager:GetAddOnInfo(addonIndex)
		if enabled then
			table.insert(list, name)
			table.insert(list, "\n")
		end
	end
	table.insert(list, "[/code][/spoiler]")
	return table.concat(list)
end