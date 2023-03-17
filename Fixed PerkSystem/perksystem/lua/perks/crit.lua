local PERK =  {}

PERK.key = "luckyshot"

PERK.category = "Attack"

PERK.color = Color(55,0,0,100)

PERK.max_points = 5

PERK.name = "Lucky Shot"

PERK.description = "Increases the damage of critical hits."

PERK.icon = "materials/prestige_levelling/icons/crit.png"

PERK.apply = function() end

PERK.reset = function() end


hook.Add("EntityTakeDamage", "PrestigeCritHook", function(target, dmginfo)    

    if (target:IsNPC() or target:IsPlayer()) and IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and not isBlacklisted(dmginfo:GetAttacker():GetActiveWeapon():GetClass()) and dmginfo:GetAttacker():getPerkData()["luckyshot"] > 0  then

        if (PerkSystem.CritChance * (dmginfo:GetAttacker():getPerkData()["luckyshot"] or 0)+1) * (dmginfo:GetAttacker():getPerkData()["shotluck"] * PerkSystem.ShotLuckMultiplier) > math.random(0, 100) and dmginfo:GetDamage()>0 then

            if target.isAdminSuit or target:HasGodMode() then return end -- They're in a suit.

            statusinfo = target:GetNWString("statusinfo") or ""

            if not string.find(statusinfo, "Critical!") then
            statusinfo = (statusinfo.."\n" or "").."Critical! (x"..(PerkSystem.CritDamage*((dmginfo:GetAttacker():getPerkData()["luckyshot"] or 0)))..")"

            target:SetNWString("statusinfo",statusinfo)
            end

            dmginfo:ScaleDamage(PerkSystem.CritDamage*((dmginfo:GetAttacker():getPerkData()["luckyshot"] or 0))+1)
            
            timer.Simple(3, function() target:SetNWString("statusinfo", "") end)
        end

    end

end)

table.insert(perks, PERK)