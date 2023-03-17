local PERK =  {}

PERK.key = "poisontip"

PERK.category = "Elemental"

PERK.color = Color(155,155,0,100)

PERK.max_points = 5

PERK.name = "Poison Tip"

PERK.description = "Increases the chance to poison enemies."

PERK.icon = "materials/prestige_levelling/icons/poison.png"

PERK.apply = function() end

PERK.reset = function() end

table.insert(perks, PERK)