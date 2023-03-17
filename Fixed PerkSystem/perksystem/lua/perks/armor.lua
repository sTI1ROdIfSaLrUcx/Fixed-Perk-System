
local PERK =  {}

PERK.key = "armor"

PERK.category = "Defense"

PERK.color = Color(155,155,255,100)

PERK.max_points = 20

PERK.name = "Armor"

PERK.description = "Increases base armor on spawn."

PERK.icon = ""

PERK.apply = function(level, player) 

	if player then 

		if CLIENT then return false end

		timer.Simple(0, function() player:SetArmor(PerkSystem.ArmorPerLevel*player:getPerkData()["armor"]) end)

	end 

end

PERK.reset = function() end

table.insert(perks, PERK)