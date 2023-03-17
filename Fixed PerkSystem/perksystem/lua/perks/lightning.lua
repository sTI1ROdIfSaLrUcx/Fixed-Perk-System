local PERK =  {}

PERK.key = "shocking"

PERK.category = "Elemental"

PERK.color = Color(220,220,0,100)

PERK.max_points = 5

PERK.name = "Shocking!"

PERK.description = "Increases the chance to paralyze opponents."

PERK.icon = "materials/prestige_levelling/icons/lightning.png"

PERK.apply = function() end

PERK.reset = function() end

local lightning_color = Color(150,150,0)


hook.Add("EntityTakeDamage", "PrestigeShockHook", function(target, dmginfo)	
        
         local p_hp = target:Health()
         local check_hp = target:GetMaxHealth() / 4
	if (target:IsNPC() or target:IsPlayer())and p_hp < check_hp  and target:GetNWInt("SHEILDS::ActiveShields") < 1 and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and not isBlacklisted(dmginfo:GetAttacker():GetActiveWeapon():GetClass()) and dmginfo:GetAttacker():getPerkData()["shocking"] > 0  then

		if (dmginfo:GetDamage()/50)*(dmginfo:GetAttacker():getPerkData()["shocking"] or 0) * PerkSystem.ShockChance > math.random(0, 100) and dmginfo:GetDamage()>0 then

            statusinfo = target:GetNWString("statusinfo") or ""

			if not string.find(statusinfo, "Paralyzed!") then
            statusinfo = (statusinfo.."\n" or "").."Paralyzed!"

			target:SetNWString("statusinfo",statusinfo)
			end

			if target:IsPlayer() then

				target:SelectWeapon("keys")

			end

			timer.Simple(3, function() target:SetNWString("statusinfo", "") end)

		end

	end

end)

table.insert(perks, PERK)