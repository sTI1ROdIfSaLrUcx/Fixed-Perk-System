local PERK =  {}

PERK.key = "lightfeet"

PERK.category = "Movement"

PERK.color = Color(255,255,255,30)

PERK.max_points = 1

PERK.name = "Light Feet"

PERK.description = "Protects you from fall damage."

PERK.icon = ""

PERK.apply = function() end

PERK.reset = function() end


hook.Add("EntityTakeDamage", "PrestigeFallHook", function(target, dmginfo)	

	if dmginfo:GetDamageType()==DMG_FALL and target:getPerkData()["lightfeet"] > 0 then

		dmginfo:SetDamage(0)

	end

end)

table.insert(perks, PERK)