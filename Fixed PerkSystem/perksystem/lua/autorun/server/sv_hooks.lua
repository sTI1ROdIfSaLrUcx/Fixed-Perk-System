hook.Add("Initialize", "perksystem_init", function()
    perkData = getPerkData()
end)

hook.Add("PlayerSpawn", "SpawnPerkRefresh", function(ply)
    ply:applyPerkEffects()
end)