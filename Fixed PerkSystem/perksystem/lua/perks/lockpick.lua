local PERK =  {}

PERK.key = "stickyfingers"

PERK.category = "Miscellaneous"

PERK.color = Color(0,90,90,100)

PERK.max_points = 4

PERK.name = "Sticky Fingers"

PERK.description = "Decreases the time it takes to pick a lock."

PERK.icon = "materials/prestige_levelling/icons/lockpick.png"

PERK.apply = function() end

PERK.reset = function() end

local max_points = PERK.max_points

hook.Add("lockpickTime", "PrestigeLockpick", function(player, ent)	

	local modifier = 1

	if player:GetActiveWeapon() and player:GetActiveWeapon():GetClass() then

		local wep = player:GetActiveWeapon():GetClass()

		if wep=="factory_lockpick" then

			modifier = 1

		elseif wep=="rusty_lockpick" or wep=="ghost_lockpick" then

			modifier = 0.5

		elseif wep=="staff_lockpick" or wep=="admin_lockpick" then

			modifier = 100

		elseif wep=="broken_lockpick" then

			modifier = 0.25

		end

	end

	if player:getPerkData()["stickyfingers"] > 0  then

		return ((max_points+1)-player:getPerkData()["stickyfingers"])*PerkSystem.LockpickAdvantage/modifier

	else

		return (max_points+1)*PerkSystem.LockpickAdvantage/modifier

	end

end)

table.insert(perks, PERK)