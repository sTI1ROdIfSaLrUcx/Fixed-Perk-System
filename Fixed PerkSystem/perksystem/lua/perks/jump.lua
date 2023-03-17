local PERK =  {}

PERK.key = "jump"

PERK.category = "Movement"

PERK.color = Color(100,150,50,100)

PERK.max_points = 5

PERK.name = "Jump"

PERK.description = "Increases jump height."

PERK.icon = "materials/prestige_levelling/icons/jump.png"

PERK.apply = function(level, player) timer.Simple(0,function() player:SetJumpPower(200+PerkSystem.JumpPower*level) end) end

PERK.reset = function(level, player) player:SetJumpPower(200) end

table.insert(perks, PERK)