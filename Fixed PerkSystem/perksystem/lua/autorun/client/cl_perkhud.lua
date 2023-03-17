concommand.Add("perksystem_hud", function(ply)
    net.Start("getPerks")
    net.SendToServer()

    while #playerPerks == 0 do
    end

    OpenMenu()
end)

PIXEL.RegisterFont("Perks:20", "Open Sans SemiBold", 20)
PIXEL.RegisterFont("Perks:15", "Open Sans SemiBold", 15)

for i=12, 45 do
	surface.CreateFont( "ui."..i, { font = "Montserrat", size = i }) 
	surface.CreateFont( "uib."..i, { font = "Montserrat", size = i, weight = 1024 })
end
panelOpen = false
local perks = {}
local playerPerks = {}
local resetPrice = -1
local availablePoints = -1

-- When the server sends the perk values to the client
net.Receive("updatePerks", function(len, ply)
    perks = util.JSONToTable(net.ReadString())
    playerPerks = util.JSONToTable(net.ReadString())
    resetPrice = net.ReadInt(32)
    availablePoints = LocalPlayer():getDarkRPVar("level") - playerPerks.spentPoints
end)

PIXEL.RegisterFont("Perks:20", "Open Sans SemiBold", 20)
PIXEL.RegisterFont("Perks:15", "Open Sans SemiBold", 15)
local PANEL = {}

function PANEL:Init()
    self.ScrollPanel = self:Add("PIXEL.ScrollPanel")
    self.ScrollPanel:Dock(FILL)
    self.ScrollPanel.VBar:SetWide(0)

    for k, v in pairs(perks) do
        local panel = self.ScrollPanel:Add("DPanel")
        panel:Dock(TOP)
        panel:DockMargin(0, 0, 0, 5)
        panel:SetTall(80)

        panel.Paint = function(s, w, h)
            draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0))
        end

        panel.PerformLayout = function(s, w, h)
            panel.Icon:SetWide(h)
        end

        panel.Icon = panel:Add("DPanel")
        panel.Icon:Dock(LEFT)

        panel.Icon.Paint = function(s, w, h)
            PIXEL.DrawImgur(0, 0, w, h, v.icon, color_white)
        end

        local name = panel:Add("PIXEL.Label")
        name:Dock(TOP)
        name:DockMargin(5, 0, 0, 0)
        name:SetText(v.name)
        name:SetFont("Perks:20")
        name:SizeToContents()
        local description = panel:Add("PIXEL.Label")
        description:Dock(TOP)
        description:DockMargin(5, 0, 0, 0)
        description:SetText(v.description)
        description:SetFont("Perks:15")
        description:SizeToContents()
        local levels = panel:Add("PIXEL.Button")
        levels:Dock(FILL)
        levels:DockMargin(5, 0, 5, 5)

        levels.Paint = function(s, w, h)
            local font, playeramount = "Perks:20", playerPerks[v.key] and tonumber(playerPerks[v.key]) or 0

            if playeramount >= v.max_points then
                PIXEL.DrawRoundedBox(14, 0, 0, w, h, PIXEL.Colors.Primary)
                PIXEL.DrawSimpleText("MAXED", font, w / 2, h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            else
                PIXEL.DrawSimpleText(playeramount, font, 5, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                PIXEL.DrawSimpleText(v.max_points, font, w - 5, h / 2, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                surface.SetFont(PIXEL.GetRealFont(font))
                local w1, h1 = surface.GetTextSize(playeramount)
                local w2, h2 = surface.GetTextSize(v.max_points)
                w = w - w1 - w2 - 20
                PIXEL.DrawRoundedBox(14, w1 + 8, 0, w, h, Color(30, 30, 30))
                PIXEL.DrawRoundedBox(14, w1 + 8, 0, (w / v.max_points) * playeramount, h, PIXEL.Colors.Primary)
            end
        end

        levels.DoClick = function(s)
            net.Start("spendPoint")
            net.WriteString(v.key)
            net.SendToServer()
        end
    end
end

vgui.Register("Perks:PerkMenu", PANEL, "EditablePanel")

function OpenMenu()
    if IsValid(Menu) then
        Menu:Remove()
    end

    Menu = vgui.Create("PIXEL.Frame")
    Menu:SetTitle("Perk Points: " .. LocalPlayer():getDarkRPVar("level") or 0)
    Menu:MakePopup()
    Menu:SetSize(800, 500)
    Menu:Center()

    Menu.Think = function(s)
        s:SetTitle("Perk Points: " .. LocalPlayer():getDarkRPVar("level") - playerPerks.spentPoints)
    end

    local resetButton = vgui.Create("DButton", Menu)
    resetButton:SetFont("uib.22")
    resetButton:SetSize(320, 30)
    resetButton:SetPos(140, 0)
    resetButton:SetColor(Color(255, 255, 255))
    resetButton:SetText("Reset perk points for " .. resetPrice .. "$")

    resetButton.Paint = function(self, w, h)
        resetButton:SetColor(Color(255, 255, 255))

        if resetButton:IsHovered() then
            resetButton:SetColor(Color(0, 161, 255))
        end
    end

    resetButton.DoClick = function()
        net.Start("resetPoints")
        net.SendToServer()
    end

    local panel = Menu:Add("Perks:PerkMenu")
    panel:Dock(FILL)
end

-- Help function to draw circles
function draw.Circle(x, y, radius, seg)
    local cir = {}

    table.insert(cir, {
        x = x,
        y = y,
        u = 0.5,
        v = 0.5
    })

    for i = 0, seg do
        local a = math.rad((i / seg) * -360)

        table.insert(cir, {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        })
    end

    local a = math.rad(0) -- This is needed for non absolute segment counts

    table.insert(cir, {
        x = x + math.sin(a) * radius,
        y = y + math.cos(a) * radius,
        u = math.sin(a) / 2 + 0.5,
        v = math.cos(a) / 2 + 0.5
    })

    surface.DrawPoly(cir)
end