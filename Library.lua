-- [[ RYOSEN UI LIBRARY ENGINE - V2.7 (MODIFIED) ]] --
-- [[ REQ: NO LOADING, BLUE STROKE, LEGACY FONT, IMAGE FLOATING ]] --

local RyosenLib = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

function RyosenLib:CreateWindow(Config)
    local HubName = Config.Name or "RYOSEN HUB"
    
    if CoreGui:FindFirstChild("RyosenHub_Ultimate") then 
        CoreGui.RyosenHub_Ultimate:Destroy() 
    end

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "RyosenHub_Ultimate"
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.ResetOnSpawn = false
    Gui.Parent = CoreGui

    -- [[ FLOATING ICON ]] --
    local FloatingIcon = Instance.new("ImageButton", Gui)
    FloatingIcon.Size = UDim2.new(0, 50, 0, 50)
    FloatingIcon.Position = UDim2.new(0, 20, 0, 20)
    FloatingIcon.Image = "rbxassetid://111106303127375" -- Ikon Standar
    FloatingIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    FloatingIcon.Draggable = true
    FloatingIcon.Active = true
    Instance.new("UICorner", FloatingIcon).CornerRadius = UDim.new(0, 8)
    local IconStroke = Instance.new("UIStroke", FloatingIcon)
    IconStroke.Color = Color3.fromRGB(0, 120, 255)
    IconStroke.Thickness = 2

    -- [[ MAIN WINDOW ]] --
    local Main = Instance.new("Frame", Gui)
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 560, 0, 400)
    Main.Position = UDim2.new(0.5, -280, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Visible = true -- Langsung muncul
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
    
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Color3.fromRGB(0, 120, 255)
    MainStroke.Thickness = 2

    -- [[ TITLE TOP LEFT ]] --
    local TitleLabel = Instance.new("TextLabel", Main)
    TitleLabel.Size = UDim2.new(0, 150, 0, 40)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = HubName
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.Legacy
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- [[ MINIMIZE ]] --
    local MinBtn = Instance.new("TextButton", Main)
    MinBtn.Size = UDim2.new(0, 30, 0, 30)
    MinBtn.Position = UDim2.new(1, -40, 0, 10)
    MinBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.Font = Enum.Font.Legacy
    MinBtn.TextSize = 16
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
    MinBtn.MouseButton1Click:Connect(function() Main.Visible = false; FloatingIcon.Visible = true end)
    FloatingIcon.MouseButton1Click:Connect(function() FloatingIcon.Visible = false; Main.Visible = true end)

    -- [[ SIDEBAR ]] --
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 160, 1, -50)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)
    
    local SideLayout = Instance.new("UIListLayout", Sidebar)
    SideLayout.Padding = UDim.new(0, 6)
    SideLayout.HorizontalAlignment = "Center"

    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -180, 1, -60)
    Container.Position = UDim2.new(0, 170, 0, 45)
    Container.BackgroundTransparency = 1

    local WindowObj = {}
    local FirstTab = true

    function WindowObj:CreateTab(TabName)
        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = FirstTab
        Page.ScrollBarThickness = 0
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0, 8)
        
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
        end)
        
        local Btn = Instance.new("TextButton", Sidebar)
        Btn.Size = UDim2.new(0.9, 0, 0, 36)
        Btn.BackgroundColor3 = FirstTab and Color3.fromRGB(35, 35, 45) or Color3.fromRGB(25, 25, 30)
        Btn.Text = TabName
        Btn.TextColor3 = Color3.new(1, 1, 1)
        Btn.Font = Enum.Font.Legacy
        Btn.TextSize = 12
        Instance.new("UICorner", Btn)
        local BtnStroke = Instance.new("UIStroke", Btn)
        BtnStroke.Color = Color3.fromRGB(0, 120, 255)
        BtnStroke.Thickness = 1

        Btn.MouseButton1Click:Connect(function()
            for _, p in pairs(Container:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 25, 30) end end
            Page.Visible = true
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end)

        FirstTab = false
        local TabObj = {}

        function TabObj:CreateButton(Config)
            local BtnElm = Instance.new("TextButton", Page)
            BtnElm.Size = UDim2.new(0.95, 0, 0, 40)
            BtnElm.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
            BtnElm.Text = Config.Name or "Button"
            BtnElm.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnElm.Font = Enum.Font.Legacy
            BtnElm.TextSize = 12
            Instance.new("UICorner", BtnElm).CornerRadius = UDim.new(0, 6)
            local Stroke = Instance.new("UIStroke", BtnElm)
            Stroke.Color = Color3.fromRGB(0, 120, 255)
            Stroke.Thickness = 1

            BtnElm.MouseButton1Click:Connect(function()
                Config.Callback()
            end)
        end
        return TabObj
    end
    return WindowObj
end

return RyosenLib
