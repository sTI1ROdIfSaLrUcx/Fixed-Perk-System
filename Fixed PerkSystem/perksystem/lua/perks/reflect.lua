local PERK =  {}

PERK.key = "deflection"

PERK.category = "Defense"

PERK.color = Color(0,0,0,100)

PERK.max_points = 5

PERK.name = "Deflection"

PERK.description = "Grants a chance to reflect damage back against your enemies."

PERK.icon = "materials/prestige_levelling/icons/reflect.png"

PERK.apply = function() end

PERK.reset = function() end



--[[

    Weapon Deflection Blacklist. 

    Format is ["weapon_class"] = true for any blacklisted weapons.

]] 

local blacklist = {

    ["weapon_gblaster_badtime_elite"] = true,

}


hook.Add("EntityTakeDamage", "PrestigeReflectHook", function(target, dmginfo, att)	

    if target:IsPlayer() and target:getPerkData()["deflection"] > 0 and target:getPerkData()["deflection"]* PerkSystem.ReflectPercent > math.random(0, 100) then

        if IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() then

            if IsValid(dmginfo:GetAttacker():GetActiveWeapon()) and blacklist[dmginfo:GetAttacker():GetActiveWeapon():GetClass()] then return end
            if dmginfo:GetAttacker():HasShields() then
                dmginfo:GetAttacker():AddShields(-1) 
            else
                dmginfo:GetAttacker():TakeDamage(dmginfo:GetDamage())
            end

        end 

		

        statusinfo = target:GetNWString("statusinfo") or ""

        if not string.find(statusinfo, "Reflected!") then
        statusinfo = (statusinfo.."\n" or "").."Reflected!"

        target:SetNWString("statusinfo",statusinfo)
        end

        dmginfo:SetDamage(0)
        
        timer.Simple(3, function() target:SetNWString("statusinfo", "") end)

	end

end)
table.insert(perks, PERK)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
      