local PERK =  {}

PERK.key = "defense"

PERK.category = "Defense"

PERK.color = Color(139,69,19,100)

PERK.max_points = 4

PERK.name = "Defense"

PERK.description = "Decreases all incoming damage by a percent of damage inflicted."

PERK.icon = ""

PERK.apply = function() end

PERK.reset = function() end

hook.Add("EntityTakeDamage", "PrestigeDefenseHook", function(target, dmginfo)	

	if IsValid(target) and target:IsPlayer() and target:getPerkData()["defense"] > 0  then

		dmginfo:ScaleDamage(1-(PerkSystem.DefensePercentage/100*target:getPerkData()["defense"]))

	end

end)

table.insert(perks, PERK)