util.AddNetworkString("getPerks")
util.AddNetworkString("updatePerks")
util.AddNetworkString("spendPoint")
util.AddNetworkString("resetPoints")
util.AddNetworkString("givePoints")

perks = {}  
perkData = {}

-- Execute perk scripts
include("perks/ammo.lua")
include("perks/armor.lua")
include("perks/armor_regen.lua")
include("perks/crit.lua")
include("perks/crit_chance.lua")
include("perks/defense.lua")
include("perks/dodge.lua")
include("perks/fall_damage.lua")
include("perks/fire.lua")
include("perks/fire_chance.lua")
include("perks/frost.lua")
include("perks/frost_chance.lua")
include("perks/headshot.lua")
include("perks/heal.lua")
include("perks/health.lua")
include("perks/jump.lua")
include("perks/lightning.lua")
include("perks/lockpick.lua")
include("perks/poison.lua")
include("perks/poison_chance.lua")
include("perks/poison_duration.lua")
include("perks/raise.lua")
include("perks/reflect.lua")
include("perks/speed.lua")
include("perks/xp.lua")

local ply = FindMetaTable("Player")

-- Register CAMI privilege
CAMI.RegisterPrivilege{
    Name = "perksystem_admin",
    MinAccess = "admin"
}

function getPerkData()
    local JSONData = file.Read("perks.txt")

    if JSONData == nil then
        JSONData = "{}"
    end

    	-- JSONData is currently a JSON string - let's convert that into a table:
    perkData = util.JSONToTable(JSONData)
    return perkData
end

function ply:getPerkData()
   local playerId = self:SteamID()

    if perkData[playerId] == nil then
        newPerkData = {
            spentPoints = 0,
            frugal = 0,
            armor = 0,
            recharge = 0,
            luckyshot = 0,
            shotluck = 0,
            defense = 0,
            dodge = 0,
            lightfeet = 0,
            phosphor = 0,
            burnchance = 0,
            freezetime = 0,
            frostchance = 0,
            precision = 0,
            regeneration = 0,
            healthy = 0,
            jump = 0,
            shocking = 0,
            stickyfingers = 0,
            poisonpotency = 0,
            poisontip = 0,
            longrelease = 0,
            raise = 0,
            deflection = 0,
            sprintspeed = 0,
            experienced = 0,
        }

        perkData[playerId] = newPerkData
        savePerkData()
    end

    return perkData[playerId]
end
 
-- Function to find a perk in the perk list
function findPerk(perk) 
    for k, v in ipairs(perks) do
        if v.key == perk then
            return v
        end
    end
end

-- Function for a player to spend a perk point
function spendPerkPoint(ply, PerkKey)
    local perk = findPerk(PerkKey)

    if ply:getDarkRPVar("money") < PerkSystem.PerkPrice then
        DarkRP.notify(ply, 1, 5, "You don't have enough money to buy this perk.")
         return 
    end

    if ply:getDarkRPVar("level") > perkData[ply:SteamID()].spentPoints then
        if ply:getPerkData()[perk.key] < perk.max_points then
            ply:addMoney(-PerkSystem.PerkPrice)
            
            local spentPoints = ply:getPerkData()["spentPoints"] + 1
            local newLevel = ply:getPerkData()[perk.key] + 1
            perkData[ply:SteamID()][perk.key] = newLevel
            perkData[ply:SteamID()]["spentPoints"] = spentPoints
            savePerkData()
            perkData = getPerkData()
            DarkRP.notify(ply, NOTIFY_GENERIC, 5, "You leveled up your " .. perk.name .. " skill to level " .. newLevel .. "." )

            updateClient(nil, ply)
            ply:applyPerkEffects()
        else
            DarkRP.notify(ply, 1, 5, "You already have this perk maxed out.")
        end
    else
        DarkRP.notify(ply, 1, 5, "You don't have any perk points remaining.")
    end
end

-- Function to reset perk points
function resetPoints(ply)
    perkData = getPerkData()

    if ply:getDarkRPVar("money") < PerkSystem.ResetPrice then
        DarkRP.notify(ply, 1, 5, "You do not have enough money to reset your perk points.")
        return
    end

    if perkData[ply:SteamID()] == nil then 
        DarkRP.notify(ply, 1, 5, "You haven't spend any perk points yet.")
        return
    end

    ply:addMoney(-PerkSystem.ResetPrice)

    newPerkData = {
        spentPoints = math.ceil(perkData[ply:SteamID()].spentPoints * ((100 - PerkSystem.ResetPercentage) / 100)),
            frugal = 0,
            armor = 0,
            recharge = 0,
            luckyshot = 0,
            shotluck = 0,
            defense = 0,
            dodge = 0,
            lightfeet = 0,
            phosphor = 0,
            burnchance = 0,
            freezetime = 0,
            frostchance = 0,
            precision = 0,
            regeneration = 0,
            healthy = 0,
            jump = 0,
            shocking = 0,
            stickyfingers = 0,
            poisonpotency = 0,
            poisontip = 0,
            longrelease = 0,
            raise = 0,
            deflection = 0,
            sprintspeed = 0,
            experienced = 0,
    }

    perkData[ply:SteamID()] = newPerkData
    savePerkData()

    updateClient(nil, ply)
    ply:applyPerkEffects()
    DarkRP.notify(ply, NOTIFY_GENERIC, 5, "You succesfully recovered your spent perk points." )
end

-- Function to add perk points
function addPerkPoint(ply, points)
    perkData = getPerkData()

    local spentPoints = perkData[ply:SteamID()]["spentPoints"] - points
    perkData[ply:SteamID()]["spentPoints"] = spentPoints
    savePerkData()
end

-- Function to apply the perk effects
function ply:applyPerkEffects() 
    for k, v in pairs(self:getPerkData()) do
            if k ~= "spentPoints" then
            local perk = findPerk(k)
            perk.reset(v, self)
            if v > 0 then
                perk.apply(v, self)
            end
        end
    end
end

-- Function to save perkdata to perks.txt
function savePerkData()
    local converted = util.TableToJSON(perkData)
    file.Write("perks.txt", converted)
end

-- Function to update a clients information
function updateClient(len, ply)
    net.Start("updatePerks")
    net.WriteString(util.TableToJSON(perks))
    net.WriteString(util.TableToJSON(ply:getPerkData()))
    net.WriteInt(PerkSystem.ResetPrice, 32)
    net.Send(ply)
end

-- Function to check if a weapon is blacklisted
function isBlacklisted(weapon)
    for k, v in ipairs(PerkSystem.WeaponBlacklist) do
        if v == weapon then
            return true
        end
    end

    return false
end


net.Receive("getPerks", updateClient)

net.Receive("spendPoint", function(len, ply)
    spendPerkPoint(ply, net.ReadString())
end)

net.Receive("resetPoints", function(len, ply)
    resetPoints(ply)
end)

net.Receive("givePoints", function(len, ply)
    CAMI.PlayerHasAccess(ply, "perksystem_admin", function(allowed)
        if allowed then
            for k, v in ipairs(player.GetAll()) do
                if string.match(string.lower(v:Nick()), string.lower(net.ReadString())) then
                    addPerkPoint(v, net.ReadInt(32))
                    ply:PrintMessage(HUD_PRINTCONSOLE, "Operation succesful.")
                    return
                end
            end
            ply:PrintMessage(HUD_PRINTCONSOLE, "Player not found.")
        else
            ply:PrintMessage(HUD_PRINTCONSOLE, "No permission, nice try though!")
        end
    end)
end)




