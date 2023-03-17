surface.CreateFont("LevelDefault", {

	font = "Quicksand",

	size = 16,

	weight = 600,

	outline = false

})



surface.CreateFont("LevelBorder", {

	font = "Quicksand",

	size = 22,

	weight = 600,

	outline = false

})



local function XPReduction( xp )

	if not xp then return "0" end

	if xp/1000000000000000000>1 then

		return math.Round(xp/1000000000000000000, 1).."E"

	elseif xp/1000000000000000>1 then

		return math.Round(xp/1000000000000000, 1).."P"

	elseif xp/1000000000000>1 then

		return math.Round(xp/1000000000000, 1).."t"

	elseif xp/1000000000>1 then

		return math.Round(xp/1000000000, 1).."B"

	elseif xp/1000000>1 then

		return math.Round(xp/1000000, 1).."M"

	elseif xp/1000>1 then

		return math.Round(xp/1000, 1).."K"

	end

	return math.Round(xp)

end

function GetNextLevel()
	local PlayerLevel = LocalPlayer():getDarkRPVar("level")
	local PlayerXP = LocalPlayer():getDarkRPVar("xp")
	return (((10+(((PlayerLevel or 1)*((PlayerLevel or 1)+1)*90))))*LevelSystemConfiguration.XPMult)
end



hook.Add( "HUDPaint", "PrestigeDrawXPBar", function()

	surface.SetDrawColor( 0, 0, 0, 100 )

	draw.NoTexture()

	surface.DrawRect( ScrW()*.25, 23, ScrW()*.5, 9 )

	surface.SetDrawColor( 50, 40, 40, 255 )

	local PlayerLevel = LocalPlayer():getDarkRPVar("level") or 0
	local PlayerXP = LocalPlayer():getDarkRPVar("xp") or 0

	surface.DrawRect( ScrW()*.25+2, 24, (ScrW()*.5*(PlayerXP)/GetNextLevel())-5, 7 )

	if PlayerLevel>=50 then

		draw.DrawText( "Max Level", "LevelDefault", ScrW()*.5, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER)

	else
		
		draw.DrawText( XPReduction(PlayerXP).."/"..XPReduction(GetNextLevel()).." ["..math.floor(100*PlayerXP/GetNextLevel()).."%]", "LevelDefault", ScrW()*.5, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER)

	end

	

	draw.DrawText( PlayerLevel, "LevelBorder", ScrW()*.25-2, 14.5, Color(255,255,255,255), TEXT_ALIGN_RIGHT)

		draw.DrawText( (PlayerLevel<50 and PlayerLevel+1) or "MAX", "LevelBorder", ScrW()*.75+2, 14.5, Color(255,255,255,255), TEXT_ALIGN_LEFT)



	

end )