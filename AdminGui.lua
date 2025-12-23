-- ===== ADMIN AYARI =====
local Admins = {
    [itoshisaecikarma] = true -- BURAYA KENDİ USERID'İN
}

local Players = game:GetService("Players")
local player = Players.LocalPlayer

if not Admins[player.UserId] then
    warn("Admin değilsin")
    return
end

local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "AdminGUI"
gui.Parent = player.PlayerGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,420,0,320)
main.Position = UDim2.new(0.3,0,0.25,0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.Active = true
main.Draggable = true

-- Tabs
local tab1 = Instance.new("TextButton", main)
tab1.Text = "Hareket"
tab1.Size = UDim2.new(0.5,0,0,40)
tab1.BackgroundColor3 = Color3.fromRGB(45,45,45)

local tab2 = Instance.new("TextButton", main)
tab2.Text = "Speed / Jump"
tab2.Size = UDim2.new(0.5,0,0,40)
tab2.Position = UDim2.new(0.5,0,0,0)
tab2.BackgroundColor3 = Color3.fromRGB(45,45,45)

-- Pages
local page1 = Instance.new("Frame", main)
page1.Position = UDim2.new(0,0,0,40)
page1.Size = UDim2.new(1,0,1,-40)
page1.BackgroundTransparency = 1

local page2 = page1:Clone()
page2.Parent = main
page2.Visible = false

-- ===== PAGE 1 =====
local flyBtn = Instance.new("TextButton", page1)
flyBtn.Text = "Fly Aç / Kapat"
flyBtn.Size = UDim2.new(0.8,0,0,40)
flyBtn.Position = UDim2.new(0.1,0,0.25,0)

local sitBtn = flyBtn:Clone()
sitBtn.Text = "Otur"
sitBtn.Position = UDim2.new(0.1,0,0.5,0)
sitBtn.Parent = page1

-- ===== PAGE 2 =====
local speedBox = Instance.new("TextBox", page2)
speedBox.PlaceholderText = "Speed (örn: 32)"
speedBox.Size = UDim2.new(0.8,0,0,35)
speedBox.Position = UDim2.new(0.1,0,0.2,0)

local speedBtn = Instance.new("TextButton", page2)
speedBtn.Text = "Speed Ayarla"
speedBtn.Size = UDim2.new(0.8,0,0,35)
speedBtn.Position = UDim2.new(0.1,0,0.35,0)

local jumpBox = speedBox:Clone()
jumpBox.PlaceholderText = "Jump (örn: 80)"
jumpBox.Position = UDim2.new(0.1,0,0.55,0)
jumpBox.Parent = page2

local jumpBtn = speedBtn:Clone()
jumpBtn.Text = "Jump Ayarla"
jumpBtn.Position = UDim2.new(0.1,0,0.7,0)
jumpBtn.Parent = page2

-- ===== TAB GEÇİŞ =====
tab1.MouseButton1Click:Connect(function()
    page1.Visible = true
    page2.Visible = false
end)

tab2.MouseButton1Click:Connect(function()
    page1.Visible = false
    page2.Visible = true
end)

-- ===== FLY =====
local flying = false
local bg, bv

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        bg = Instance.new("BodyGyro", hrp)
        bv = Instance.new("BodyVelocity", hrp)
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)

        RunService.RenderStepped:Connect(function()
            if flying then
                bg.CFrame = workspace.CurrentCamera.CFrame
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
            end
        end)
    else
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
    end
end)

-- ===== OTUR =====
sitBtn.MouseButton1Click:Connect(function()
    hum.Sit = true
end)

-- ===== SPEED =====
speedBtn.MouseButton1Click:Connect(function()
    local v = tonumber(speedBox.Text)
    if v then hum.WalkSpeed = v end
end)

-- ===== JUMP =====
jumpBtn.MouseButton1Click:Connect(function()
    local v = tonumber(jumpBox.Text)
    if v then hum.JumpPower = v end
end)

print("Admin GUI yüklendi")
