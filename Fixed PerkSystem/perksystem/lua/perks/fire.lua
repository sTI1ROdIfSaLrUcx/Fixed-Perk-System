local PERK =  {}

PERK.key = "phosphor"

PERK.category = "Elemental"

PERK.color = Color(155,0,0,100)

PERK.max_points = 5

PERK.name = "Phosphor"

PERK.description = "Increases the duration which phosphor burns for."

PERK.icon = "materials/prestige_levelling/icons/fire.png"

PERK.apply = function() end

PERK.reset = function() end




hook.Add("EntityTakeDamage", "PrestigeFireHook", function(target, dmginfo)	

	if (target:IsNPC() or target:IsPlayer()) and !target:HasShields() and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and not isBlacklisted(dmginfo:GetAttacker():GetActiveWeapon():GetClass()) and dmginfo:GetAttacker():getPerkData()["burnchance"] > 0 then

		if (dmginfo:GetDamage()/50)*((dmginfo:GetAttacker():getPerkData()["burnchance"] or 0)+1)*PerkSystem.BurnChance > math.random(0, 100) and dmginfo:GetDamage() > 0 then

            statusinfo = target:GetNWString("statusinfo", "")

			if not string.find(statusinfo, "Burned!") then
            statusinfo = (statusinfo.."\n" or "").."Burned!"

			target:SetNWString("statusinfo",statusinfo)
			end

			target:Ignite(PerkSystem.BurnDuration*((dmginfo:GetAttacker():getPerkData()["phosphor"] or 0)+1))

			timer.Simple(3, function() target:SetNWString("statusinfo", "") end)

		end

	end

end)

table.insert(perks, PERK)