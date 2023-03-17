local PERK =  {}

PERK.key = "precision"

PERK.category = "Attack"

PERK.color = Color(255,0,0,100)

PERK.max_points = 4

PERK.name = "Precision"

PERK.description = "Increases Headshot Damage"

PERK.icon = "materials/prestige_levelling/icons/headshot.png"

PERK.apply = function() end

PERK.reset = function() end

hook.Add("ScalePlayerDamage", "PrestigeHeadshotHook", function(target, hitgroup, dmginfo)    

    if IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and not isBlacklisted(dmginfo:GetAttacker():GetActiveWeapon():GetClass()) and dmginfo:GetAttacker():getPerkData()["precision"] then

        if target.isAdminSuit or target:HasGodMode() then return end -- THey're in a suit.

        if dmginfo:GetAttacker():getPerkData()["precision"] > 0  and dmginfo:GetDamage()>0 then

            if hitgroup==HITGROUP_HEAD then

                dmginfo:ScaleDamage((dmginfo:GetAttacker():getPerkData()["precision"]*PerkSystem.HeadshotMultiplier)+1)

            end

        end

    end

end)

table.insert(perks, PERK)