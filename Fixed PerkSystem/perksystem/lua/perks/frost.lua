local PERK =  {}

PERK.key = "freezetime"

PERK.category = "Elemental"

PERK.color = Color(69,69,155,100)

PERK.max_points = 5

PERK.name = "Freeze Time"

PERK.description = "Increases the duration an enemy will be frozen for."

PERK.icon = "materials/prestige_levelling/icons/frost.png"

PERK.apply = function() end

PERK.reset = function() end

local freeze_color = Color(100,100,255)


hook.Add("EntityTakeDamage", "PrestigeFrostHook", function(target, dmginfo)	

	if (target:IsNPC() or target:IsPlayer()) and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and not isBlacklisted(dmginfo:GetAttacker():GetActiveWeapon():GetClass()) and dmginfo:GetAttacker():getPerkData()["freezetime"] > 0  and dmginfo:GetDamage()>0 then

		if math.min(1,(dmginfo:GetDamage()/100)^1.5)*((dmginfo:GetAttacker():getPerkData()["frostchance"] or 0)+1) * PerkSystem.FrostChance > math.random(0, 100) then
			
            statusinfo = target:GetNWString("statusinfo") or ""
 
			if not string.find(statusinfo, "Frozen!") then
            statusinfo = (statusinfo.."\n" or "").."Frozen!"

			target:SetNWString("statusinfo",statusinfo)
			end

			if elemental_weapons then

				elemental_weapons:FreezeEffect(target, 1.5*((dmginfo:GetAttacker():getPerkData()["freezetime"] or 0)+1))

			end

			timer.Simple(3, function() target:SetNWString("statusinfo", "") end)

		end

	end

end)

table.insert(perks, PERK)