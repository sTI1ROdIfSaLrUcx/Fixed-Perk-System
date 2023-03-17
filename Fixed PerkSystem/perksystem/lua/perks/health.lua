local PERK =  {}

PERK.key = "healthy"

PERK.category = "Defense"

PERK.color = Color(155,155,0,100)

PERK.max_points = 20

PERK.name = "Healthy"

PERK.description = "Increases your starting health."

PERK.icon = "materials/prestige_levelling/icons/health.png"

PERK.apply = function(level, player) 
    timer.Simple(0, function()
    player:SetMaxHealth(100 + level*PerkSystem.HealthPerLevel)
    player:SetHealth(player:GetMaxHealth())
    end)
end

PERK.reset = function(level, player) player:SetMaxHealth(player:GetMaxHealth()) end

table.insert(perks, PERK)