local function Draw3DText( pos, ang, scale, text, flipView )
    if ( flipView ) then
        -- Flip the angle 180 degrees around the UP axis
        ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
    end
    cam.Start3D2D( pos, ang, scale )
        -- Actually draw the text. Customize this to your liking.
        draw.DrawText( text, "Trebuchet24", 0, 0, Color( 53, 200, 200, 255 ), TEXT_ALIGN_CENTER )
    cam.End3D2D()
end

function drawStatusEffects(ply)
    if ( !IsValid( ply ) ) then return end 
	if ( ply == LocalPlayer() ) then return end -- Don't draw anything on yourself
	if ( !ply:Alive() ) then return end -- Check if the player is alive 
 
	local Distance = LocalPlayer():GetPos():Distance( ply:GetPos() ) -- Get the distance between you and the player
	
    if ( Distance < 1000 ) then --If the distance is less than 1000 units, it will draw the status effects
 
	local offset = Vector(0, 0, 80)
    local ang = LocalPlayer():EyeAngles()

    local aimVector = ply:GetAimVector()
    
    if aimVector.x > aimVector.y then
        offset.y = 40
    else
        offset.x = 40
    end

	local pos = ply:GetPos() + offset
 
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
 
    Draw3DText(pos, Angle( 0, ang.y, 90), 0.4, ply:GetNWString("statusinfo", ""), false)
    end
end

hook.Add("PostPlayerDraw", "statusEffectHeadHud", function(ply)
    for k, v in ipairs(player.GetAll()) do
        drawStatusEffects(v)
    end
end)

hook.Add("Think", "CheckPlayerF8", function()
	if panelOpen ~= nil and input.IsKeyDown(KEY_F8) and not panelOpen then
        net.Start("getPerks")
        net.SendToServer()
        
        timer.Create("openPerkHUD", 0.3, 1, function() OpenMenu() end)
	end
end)                  

