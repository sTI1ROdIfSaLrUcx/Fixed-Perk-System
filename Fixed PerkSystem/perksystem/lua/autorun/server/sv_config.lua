PerkSystem = PerkSystem or {}

-- PerkSystem config

PerkSystem.ResetPrice = 5000000-- How much should it cost to reset your perk points
PerkSystem.ResetPercentage = 100 -- What percentage of your perk points should you keep after paying for a reset
PerkSystem.PerkPrice = 20000 -- What should spending a perk point cost

PerkSystem.WeaponBlacklist = {"weapon_gblaster_asriel_rainbow_elite","weapon_gblaster_badtime_elite","weapon_supreme_badtime_bm_gblaster_elite"} -- Weapons that don't apply any perks

-- Perks
PerkSystem.FrugalAmmoChance = 5 -- Chance per level that you get your ammo back 

PerkSystem.ArmorPerLevel = 10 -- Base armor per level 
PerkSystem.RechargeRate = 2 -- How many times per second should armor get a recharge?


PerkSystem.CritChance = 0.5 -- Chance per level to crit (Lucky Shot)
PerkSystem.CritDamage = 0.125 -- The damage a critical hit deals (Lucky Shot)

PerkSystem.ShotLuckMultiplier = 1.2 -- For each level of the shotluck skill, how many times should the critical chance be multiplied

PerkSystem.DefensePercentage = 2 -- By what percentage should the damage be decreased for each level of the defense skill

PerkSystem.DodgePercentage = 2 -- Chance to fully dodge an attack (per Dodge skill level)

PerkSystem.BurnChance = 0.5 -- Chance per Phosphor level to burn a player
PerkSystem.BurnDuration = 1 -- If a burn triggers, how long should a player burn for per phosphor level

PerkSystem.FrostChance = 2 -- Chance per frost time level to freeze a player
PerkSystem.FrostDuration = 0.333 -- If frost triggers, how long should a player be frozen for

PerkSystem.HeadshotMultiplier = 0.05 -- Damage multiplier for headshots (per level)

PerkSystem.HealRate = 0.5 -- How many times should a player be healed up each second
PerkSystem.HealthPerLevel = 5 -- How much extra health should a player get for each Healthy skill level

PerkSystem.JumpPower = 25 -- The buff to jump power per level

PerkSystem.ShockChance = 0.5 -- The chance that a player will get shocked per level

PerkSystem.LockpickAdvantage = 3 -- The duration to take off of lockpicking per level

PerkSystem.PoisonChance = 0.2 -- Chance per poison tip level to poison a player
PerkSystem.PoisonDamage = 0.2 -- Damage, per poison potency level, to inflict per occurence of poison

PerkSystem.RaiseRatio = 0.5 -- What should the salary be multiplied by per level of the Raise skill

PerkSystem.ReflectPercent = 0.4 -- Chance to completely reflect an attack (per Deflection level)

PerkSystem.SpeedRatio = 22 -- How much to buff up player speed per sprint speed level

PerkSystem.ExperienceBonus = 20 -- XP bonus per level of the 'experienced' skill
