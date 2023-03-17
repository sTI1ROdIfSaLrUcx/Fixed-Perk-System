local PERK =  {}

PERK.key = "burnchance"

PERK.category = "Elemental"

PERK.color = Color(155,0,0,100)

PERK.max_points = 5

PERK.name = "Burn Chance"

PERK.description = "Increases the chance to inflict extra fire damage."

PERK.icon = "materials/prestige_levelling/icons/fire.png"

PERK.apply = function() end

PERK.reset = function() end

table.insert(perks, PERK)