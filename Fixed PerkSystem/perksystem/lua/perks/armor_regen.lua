local PERK = {}

PERK.key = "recharge"

PERK.category = "Defense"

PERK.color = Color(255,255,150,100)

PERK.max_points = 4

PERK.name = "Recharge"

PERK.description = "Regenerates armor over time, up to your starting amount."

PERK.icon = "materials/prestige_levelling/icons/recharge.png"

PERK.apply = function() end

PERK.reset = function() end


if SERVER then

	timer.Create("ArmorRecharge", 1/PerkSystem.RechargeRate, 0, function()

		for k,v in pairs(player.GetAll()) do

			if v:getPerkData()["armor"] > 0 and v:getPerkData()["recharge"] > 0 and v:Armor() < v:getPerkData()["armor"]*PerkSystem.ArmorPerLevel then

				v:SetArmor(math.min(v:getPerkData()["armor"]*PerkSystem.ArmorPerLevel,v:Armor()+(v:getPerkData()["recharge"]*1)))

			end

		end

	end)

end

table.insert(perks, PERK)