local PERK =  {}

PERK.key = "raise"

PERK.category = "Miscellaneous"

PERK.color = Color(0,255,0,100)

PERK.max_points = 4

PERK.name = "Raise"

PERK.description = "Increases base pay for most jobs."

PERK.icon = "materials/prestige_levelling/icons/printer.png"

PERK.apply = function() end

PERK.reset = function() end

hook.Add("playerGetSalary", "PrestigeRaiseSalary", function(player, amount)	

	if player:getPerkData()["raise"] > 0  then

		return false, "Payday! Your raise earned you "..DarkRP.formatMoney((1+(player:getPerkData()["raise"]*PerkSystem.RaiseRatio))*amount).."!", (1+(player:getPerkData()["raise"]*PerkSystem.RaiseRatio))*amount

	end

end)

table.insert(perks, PERK)