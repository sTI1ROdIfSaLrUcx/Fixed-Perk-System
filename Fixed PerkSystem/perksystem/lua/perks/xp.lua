local PERK =  {}

PERK.key = "experienced"

PERK.category = "Miscellaneous"

PERK.color = Color(50,100,30,100)

PERK.max_points = 10

PERK.name = "Experienced"

PERK.description = "Increases XP earned over time."

PERK.icon = "materials/prestige_levelling/icons/xp.png"

PERK.apply = function() end

PERK.reset = function() end

hook.Add("playerGetSalary", "PrestigeRaiseSalary", function(player, amount)	

	if player:getPerkData()["experienced"]  > 0  then

		player:AddXP(player:getPerkData()["experienced"]*PerkSystem.ExperienceBonus)

	end

end)

table.insert(perks, PERK)