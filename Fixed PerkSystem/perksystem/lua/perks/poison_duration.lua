local PERK =  {}

PERK.key = "longrelease"

PERK.category = "Elemental"

PERK.color = Color(155,155,0,100)

PERK.max_points = 5

PERK.name = "Long Release"

PERK.description = "Increases how long poison lasts."

PERK.icon = "materials/prestige_levelling/icons/poison.png"

PERK.apply = function() end

PERK.reset = function() end

table.insert(perks, PERK)