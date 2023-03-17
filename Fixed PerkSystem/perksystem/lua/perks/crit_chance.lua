local PERK =  {}

PERK.key = "shotluck"

PERK.category = "Attack"

PERK.color = Color(55,0,0,100)

PERK.max_points = 5

PERK.name = "Shotluck"

PERK.description = "Increases the chance of Lucky Shot to activate."

PERK.icon = ""

PERK.apply = function() end

PERK.reset = function() end

table.insert(perks, PERK)