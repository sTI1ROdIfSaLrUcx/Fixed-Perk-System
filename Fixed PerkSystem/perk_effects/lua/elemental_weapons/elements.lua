


elemental_weapons = elemental_weapons or {}

game.AddParticles("particles/chilled.pcf")

PrecacheParticleSystem("chilled")



function elemental_weapons:FireEffect( ply, duration, power, attacker )

	ply:Ignite(duration)

	ply.FlameBurst = true

end



hook.Add("EntityTakeDamage", "ElementFireHook", function(target, dmginfo)	

	if target.FlameBurst and not dmginfo:IsDamageType(DMG_BURN) and dmginfo:GetAttacker() then

		

	end

end)



local frozen_color = Color(220,220,255,255)

local white = Color(255,255,255,255)



function elemental_weapons:FreezeEffect( ply, duration )

	if CLIENT then return end

	if not ply:IsPlayer() then return end

	net.Start("ElementFreezeEffect")

		net.WriteEntity(ply)

		net.WriteDouble(duration)

	net.Broadcast()

	if not ply.FormerSpeeds then

		ply.FormerSpeeds = {ply:GetWalkSpeed(), ply:GetCrouchedWalkSpeed(), ply:GetRunSpeed(), ply.armorSuit, ply._oldRunSpeed}

		ply:SetColor(frozen_color)

		ply:SetWalkSpeed(60)

		ply:SetCrouchedWalkSpeed(30)

		ply:SetRunSpeed(70)

	end

	timer.Create( (ply:SteamID64() or 1).."_freeze_timer", duration, 1, function()

		if ply.FormerSpeeds and ply.armorSuit==ply.FormerSpeeds[4] then

			ply:SetWalkSpeed( ply.FormerSpeeds[1] )

			ply:SetCrouchedWalkSpeed( ply.FormerSpeeds[2] )

			ply:SetRunSpeed( ply.FormerSpeeds[3] )

		else

			ply:SetWalkSpeed( ply.FormerSpeeds[1] )

			ply:SetCrouchedWalkSpeed( ply.FormerSpeeds[2] )

			ply:SetRunSpeed( ply.FormerSpeeds[5] or 600 )

		end

		ply:SetColor(white)

		ply.FormerSpeeds = nil

	end)

end



if SERVER then

	util.AddNetworkString("ElementFreezeEffect")

end



if CLIENT then

	net.Receive( "ElementFreezeEffect", function()

		local ent = net.ReadEntity()

		if ent and ent:IsValid() and ent.Health and ent:Health()>0 then

			local particle = ent:CreateParticleEffect( "chilled", 8, {{attachtype = PATTACH_POINT_FOLLOW, position = Vector(0,0,40)}} )

			timer.Simple(net.ReadDouble(), function() if particle and particle:IsValid() then particle:StopEmission() end end)

		end

	end )

end