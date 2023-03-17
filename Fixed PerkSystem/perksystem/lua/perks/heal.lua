local PERK =  {}

PERK.key = "regeneration"

PERK.category = "Defense"

PERK.color = Color(255,200,200,100)

PERK.max_points = 4

PERK.name = "Regeneration"

PERK.description = "Regenerates health over time."

PERK.icon = "materials/prestige_levelling/icons/heal.png"

PERK.apply = function() end

PERK.reset = function() end


if SERVER then

	timer.Create("HealPerk", 1/PerkSystem.HealRate, 0, function()

		for k,v in pairs(player.GetAll()) do

			if v:getPerkData()["regeneration"]  > 0 and v:Health() < v:GetMaxHealth() then

				v:SetHealth(math.min(v:GetMaxHealth(),v:Health()+v:getPerkData()["regeneration"]))

			end

		end

	end)

end

table.insert(perks, PERK)