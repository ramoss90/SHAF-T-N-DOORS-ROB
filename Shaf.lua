--[[
    سكربت الشافطين v3.0
    الإصدار المتميز مع تصميم جديد
    مع كشف الكتب في المرحلة 50
--]]

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إنشاء الواجهة المتميزة
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("ImageButton")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local UIStroke = Instance.new("UIStroke")
local TitleLabel = Instance.new("TextLabel")
local DoorCounterLabel = Instance.new("TextLabel")
local Gradient = Instance.new("UIGradient")

ScreenGui.Name = "AlShaftenScript"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- زر التبديل المتميز
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 25, 0, 100)
ToggleButton.Image = "rbxassetid://6525356216"
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ToggleButton.BackgroundTransparency = 0.5
ToggleButton.Draggable = true
ToggleButton.Active = true

-- زينة زر التبديل
local toggleCorner = Instance.new("UICorner", ToggleButton)
toggleCorner.CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new("UIStroke", ToggleButton)
toggleStroke.Color = Color3.fromRGB(0, 255, 255)
toggleStroke.Thickness = 2

-- الإطار الرئيسي المتميز
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 370, 0, 400)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- زوايا متدرجة للإطار
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 15)
UIStroke.Parent = MainFrame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- تدرج لوني للإطار
Gradient.Parent = MainFrame
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 50, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 20, 30))
})
Gradient.Rotation = 90

-- عنوان السكربت المزين
TitleLabel.Parent = MainFrame
TitleLabel.Text = "🌟 الشافطين v3.0 | Doors 🌟"
TitleLabel.Size = UDim2.new(0, 300, 0, 45)
TitleLabel.Position = UDim2.new(0.5, -150, 0, 15)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.TextSize = 24
TitleLabel.TextStrokeTransparency = 0.7
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 100, 150)

-- عداد الأبواب المزين
DoorCounterLabel.Name = "DoorCounter"
DoorCounterLabel.Parent = MainFrame
DoorCounterLabel.Text = "🚪 الباب الحالي: 0"
DoorCounterLabel.Size = UDim2.new(0, 300, 0, 35)
DoorCounterLabel.Position = UDim2.new(0.5, -150, 0, 65)
DoorCounterLabel.BackgroundTransparency = 1
DoorCounterLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
DoorCounterLabel.Font = Enum.Font.GothamBold
DoorCounterLabel.TextSize = 18
DoorCounterLabel.TextStrokeTransparency = 0.7
DoorCounterLabel.TextStrokeColor3 = Color3.fromRGB(100, 80, 0)

-- زر الإغلاق المزين
CloseButton.Parent = MainFrame
CloseButton.Text = "✕"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.AutoButtonColor = false

-- زينة زر الإغلاق
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(1, 0)
local closeStroke = Instance.new("UIStroke", CloseButton)
closeStroke.Color = Color3.fromRGB(255, 255, 255)
closeStroke.Thickness = 2

-- تأثيرات زر الإغلاق
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 20, 20)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
end)

-- وظائف التبديل والإغلاق
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if MainFrame.Visible then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 370, 0, 400)}):Play()
    end
end)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- دالة إضافة زر مزينة
local function addToggle(name, emoji, callback, defaultState)
    local button = Instance.new("TextButton")
    button.Parent = MainFrame
    button.Size = UDim2.new(0, 300, 0, 40)
    button.Position = UDim2.new(0.5, -150, 0, (#MainFrame:GetChildren() - 6) * 45 + 110)
    button.Text = emoji .. " " .. name .. (defaultState and " [🟢]" or " [🔴]")
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.AutoButtonColor = false
    
    -- زينة الأزرار
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 10)
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Color = Color3.fromRGB(0, 200, 200)
    buttonStroke.Thickness = 1
    
    -- تأثيرات الأزرار
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
    end)
    
    local state = defaultState or false
    button.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        button.Text = emoji .. " " .. name .. (state and " [🟢]" or " [🔴]")
    end)
end

-- ======== نظام متعقب الأبواب ========
local function setupDoorTracker()
    local currentDoor = 0
    local doorParts = {}
    
    -- البحث عن جميع الأبواب في الماب
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Door" and obj:IsA("Model") then
            table.insert(doorParts, obj)
        end
    end
    
    -- تحديث العداد كل إطار
    RunService.Heartbeat:Connect(function()
        local char = Player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local hrp = char.HumanoidRootPart
        local closestDoor, closestDist = nil, math.huge
        
        for _, door in pairs(doorParts) do
            local doorPrimary = door.PrimaryPart or door:FindFirstChildWhichIsA("BasePart")
            if doorPrimary then
                local dist = (doorPrimary.Position - hrp.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestDoor = door
                end
            end
        end
        
        if closestDoor then
            local doorNumber = tonumber(closestDoor.Name:match("%d+")) or 0
            if doorNumber ~= currentDoor then
                currentDoor = doorNumber
                DoorCounterLabel.Text = "🚪 الباب الحالي: " .. currentDoor
            end
        end
    end)
end

-- تهيئة متعقب الأبواب
task.spawn(setupDoorTracker)

-- ======== كاشف العناصر المحسن ========
addToggle("كاشف العناصر", "🔍", function(state)
    local highlights = {
        KeyObtain = Color3.fromRGB(255, 255, 0),    -- مفاتيح
        Lighter = Color3.fromRGB(255, 100, 0),      -- قداحة
        Flashlight = Color3.fromRGB(100, 100, 255), -- مصباح
        Book = Color3.fromRGB(255, 0, 255)          -- كتب (في المرحلة 50)
    }

    local connection
    local highlightedItems = {}

    local function cleanHighlights()
        for _, v in pairs(highlightedItems) do
            if v and v:FindFirstChild("Highlight") then
                v.Highlight:Destroy()
            end
        end
        highlightedItems = {}
    end

    if state then
        connection = RunService.RenderStepped:Connect(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and not obj:FindFirstChild("Highlight") then
                    -- كشف العناصر الأساسية
                    if highlights[obj.Name] then
                        local part = obj:FindFirstChildWhichIsA("BasePart")
                        if part and (part.Position - Camera.CFrame.Position).Magnitude < 50 then
                            local h = Instance.new("Highlight", obj)
                            h.FillColor = highlights[obj.Name]
                            h.OutlineColor = Color3.new(1, 1, 1)
                            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            table.insert(highlightedItems, obj)
                        end
                    end
                    
                    -- كشف الكتب في المرحلة 50
                    if obj.Name:lower():find("book") and DoorCounterLabel.Text:find("50") then
                        local part = obj:FindFirstChildWhichIsA("BasePart")
                        if part and (part.Position - Camera.CFrame.Position).Magnitude < 50 then
                            local h = Instance.new("Highlight", obj)
                            h.FillColor = highlights.Book
                            h.OutlineColor = Color3.new(1, 1, 1)
                            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            table.insert(highlightedItems, obj)
                        end
                    end
                end
            end
        end)
    else
        if connection then connection:Disconnect() end
        cleanHighlights()
    end
end, false)

-- ======== الخيارات الأخرى ========

-- إضاءة كاملة
addToggle("إضاءة كاملة", "💡", function(state)
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 12
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    end
end, false)

-- سرعة المشي
addToggle("مشروب السرعة", "⚡", function(state)
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.WalkSpeed = state and 30 or 16
    end
end, false)

-- منع ضرر السقوط
addToggle("منع ضرر السقوط", "🛡️", function(state)
    if Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not state)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, not state)
        end
    end
end, false)

-- إشعار التحميل
task.spawn(function()
    wait(1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🌟 الشافطين v3.0 🌟",
        Text = "تم تحميل السكربت بنجاح!",
        Duration = 6,
        Icon = "rbxassetid://6722534400"
    })
end)

-- تأثيرات جمالية إضافية
local function createParticles()
    local particles = Instance.new("ParticleEmitter")
    particles.Parent = ToggleButton
    particles.Texture = "rbxassetid://243664672"
    particles.LightEmission = 1
    particles.Size = NumberSequence.new(0.5)
    particles.Transparency = NumberSequence.new(0.5)
    particles.Speed = NumberRange.new(2)
    particles.Lifetime = NumberRange.new(1)
    particles.Rate = 5
    particles.Rotation = NumberRange.new(0, 360)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.VelocityInheritance = 0.5
    return particles
end

local particles = createParticles()
ToggleButton.MouseEnter:Connect(function()
    particles.Enabled = true
    TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Size = UDim2.new(0, 70, 0, 70)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    particles.Enabled = false
    TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Size = UDim2.new(0, 60, 0, 60)}):Play()
end)
