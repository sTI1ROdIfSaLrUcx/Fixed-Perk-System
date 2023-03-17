local PERK =  {}

PERK.key = "sprintspeed"

PERK.category = "Movement"

PERK.color = Color(255,255,150,100)

PERK.max_points = 5

PERK.name = "Sprint Speed"

PERK.description = "Increases sprint speed."

PERK.icon = "materials/prestige_levelling/icons/sprint.png"

PERK.apply = function(level, player)

	timer.Simple(0,function() player:SetRunSpeed(320 + PerkSystem.SpeedRatio*level) end)

end

PERK.reset = function(level, player) 

	player:SetRunSpeed(320)

end

table.insert(perks, PERK)