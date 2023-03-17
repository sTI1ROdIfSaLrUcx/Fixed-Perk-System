local PERK =  {}

PERK.key = "dodge"

PERK.category = "Defense"

PERK.color = Color(200,20,200,100)

PERK.max_points = 4

PERK.name = "Dodge"

PERK.description = "Allows you to dodge out of the way of attacks sometimes"

PERK.icon = "materials/prestige_levelling/icons/dodge.png"

PERK.apply = function() end

PERK.reset = function() end


hook.Add("EntityTakeDamage", "PrestigeDodgeHook", function(target, dmginfo)	

	if target:IsPlayer() and target:getPerkData()["dodge"] > 0  then

		if (target:getPerkData()["dodge"]*PerkSystem.DodgePercentage)>math.random(0, 100) then

            statusinfo = target:GetNWString("statusinfo") or ""

			if not string.find(statusinfo, "Dodged!") then
            statusinfo = (statusinfo.."\n" or "Dodged!")

			target:SetNWString("statusinfo",statusinfo)
			end

			dmginfo:SetDamage(0)

			timer.Simple(3, function() target:SetNWString("statusinfo", "") end)

		end

	end

end)

table.insert(perks, PERK)