PERK = PERK or {}

PERK.key = "poisonpotency"

PERK.category = "Elemental"

PERK.color = Color(155,155,0,100)

PERK.max_points = 5

PERK.name = "Poison Potency"

PERK.description = "Increases the damage dealt over time to enemies."

PERK.icon = "materials/prestige_levelling/icons/poison.png"

PERK.apply = function() end

PERK.reset = function() end


hook.Add("EntityTakeDamage", "PoisonHook", function(target, dmginfo)

	if (target:IsNPC() or target:IsPlayer()) and !target:HasShields() and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and not isBlacklisted(dmginfo:GetAttacker():GetActiveWeapon():GetClass()) and dmginfo:GetAttacker():getPerkData()["poisontip"] > 0  then

		if (dmginfo:GetDamage()/50)*((dmginfo:GetAttacker():getPerkData()["poisontip"] or 0)+1*PerkSystem.PoisonChance ) > math.random(0, 100) then

            statusinfo = target:GetNWString("statusinfo") or ""

			if not string.find(statusinfo, "Poisoned!") then
            statusinfo = (statusinfo.."\n" or "").."Poisoned!"

			target:SetNWString("statusinfo",statusinfo)
			end

			local poison = ((dmginfo:GetAttacker():getPerkData()["poisonpotency"] or 0)+1)

			local index = target:EntIndex()

			local player = dmginfo:GetAttacker()

			timer.Create("poisoned_"..target:EntIndex(), .5, ((dmginfo:GetAttacker():getPerkData()["longrelease"] or 0)+1)*2, function()

				if target and not target:HasGodMode() and target:Health()>0 then

					target:TakeDamage(poison, player, nil)

				else 

					timer.Remove("poisoned_"..index)

				end

			end)

			timer.Simple(3, function() target:SetNWString("statusinfo", "") end)

		end

	end

end)

table.insert(perks, PERK)