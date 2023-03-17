local PERK =  {}

PERK.key = "frugal"

PERK.category = "Attack"

PERK.color = Color(0,0,0,100)

PERK.max_points = 4

PERK.name = "Frugal"

PERK.description = "Sometimes conserve light ammo when reloading."

PERK.icon = ""

PERK.apply = function() end

PERK.reset = function() end

if SERVER then

	util.AddNetworkString("AmmoPerk")

	local last_weapon = "" 

	local ammo_types = {}

	ammo_types[1] = true

	ammo_types[3] = true

	ammo_types[4] = true

	ammo_types[5] = true

	ammo_types[12] = true

	ammo_types[23] = true

	hook.Add("PlayerTick", "AmmoPerk", function(ply, cmove)

		if IsValid(ply) and ply:Alive() and ply:getPerkData()["frugal"] > 0  then

			if not ply:GetActiveWeapon():IsValid() then return end

			local id64 = ply:SteamID64() or 1

			local random_number = math.random(0, 100)

			if ammo_types[ply:GetActiveWeapon():GetPrimaryAmmoType()] then
				if PerkSystem.FrugalAmmoChance*ply:getPerkData()["frugal"]>random_number and ply:GetVar("last_ammo", 0) ~= 0 then

					ply:GetActiveWeapon():SetClip1(ply:GetVar("last_ammo", 0))

				end

				ply:SetVar("last_weapon", ply:GetActiveWeapon():GetClass())
				ply:SetVar("last_ammo", ply:GetActiveWeapon():Clip1())

			end

		end

	end)

end

table.insert(perks, PERK)