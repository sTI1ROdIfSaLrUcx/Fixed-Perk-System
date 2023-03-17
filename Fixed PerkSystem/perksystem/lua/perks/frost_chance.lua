local PERK =  {}

PERK.key = "frostchance"

PERK.category = "Elemental"

PERK.color = Color(69,69,155,100)

PERK.max_points = 5

PERK.name = "Frost Chance"

PERK.description = "Increases the chance to freeze enemies."

PERK.icon = "materials/prestige_levelling/icons/frost.png"

PERK.apply = function() end

PERK.reset = function() end

table.insert(perks, PERK)