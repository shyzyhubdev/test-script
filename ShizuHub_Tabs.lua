-- Check Executor 
local executor = getexecutorname() or identifyexecutor()

if executor then
    local supportedExecutors = {
        "Velocity",
        "Wave",
        "Arceus",
        "Swift",
        "AWP",
        "Macsploit",
        "Delta",
        "Fluxus",
        "CodeX",
        "Krnl",
        "Trigon",
        "Evon",
        "Cryptic",
        "SynapeX",
        "Potassium",
        "Argon",
        "Xeno",
        "Nezur",
        "Revelix",
        "Cubix",
        "Solara",
        "Dynamic",
        "Nebula",
        "Ronix",
        "Atlant",
    }

    local isExecutorSupported = false
    for _, name in ipairs(supportedExecutors) do
        if string.find(executor, name) then
            isExecutorSupported = true
            break
        end
    end

    if isExecutorSupported then
        print("Supported Executor!")
    else
        game.Players.LocalPlayer:Kick("Not supported TNG Skid executor!") -- kick nếu exec ko support
    end
end

repeat
    wait()
until game:IsLoaded() and game.Players.LocalPlayer

print("Whitelist success!")
wait(.5)
game.StarterGui:SetCore("SendNotification", {
     Title = "Tên Hub";
     Text = "Loading";
     Icon = "";
     Duration = "2";
})

wait(.1)


----------------------------------------ToogleUi----------------------------------------

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")  
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.1, 0.1)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 0
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.BorderSizePixel = 1
Frame.Position = UDim2.new(0, 20, 0.1, -6)  
Frame.Size = UDim2.new(0, 50, 0, 50)
Frame.Name = "dut dit"

ImageLabel.Parent = Frame
ImageLabel.Name = "Banana Test"
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0, 40, 0, 40)
ImageLabel.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 1
ImageLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Image = "http://www.roblox.com/asset/?id=126234343701615"

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Frame

TextButton.Name = "TextButton"
TextButton.Parent = Frame
TextButton.AnchorPoint = Vector2.new(0, 0)
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
TextButton.BackgroundTransparency = 1
TextButton.BorderSizePixel = 1
TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
TextButton.TextColor3 = Color3.fromRGB(27, 42, 53)
TextButton.Text = ""
TextButton.Font = Enum.Font.SourceSans
TextButton.TextSize = 8
TextButton.TextTransparency = 0

local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local zoomedIn = false
local originalSize = UDim2.new(0, 40, 0, 40)
local zoomedSize = UDim2.new(0, 30, 0, 30)
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local faded = false
local fadeInTween = TweenService:Create(Frame, tweenInfo, {BackgroundTransparency = 0.25})
local fadeOutTween = TweenService:Create(Frame, tweenInfo, {BackgroundTransparency = 0})

TextButton.MouseButton1Down:Connect(function()

    if zoomedIn then
        TweenService:Create(ImageLabel, tweenInfo, {Size = originalSize}):Play()
    else
        TweenService:Create(ImageLabel, tweenInfo, {Size = zoomedSize}):Play()
    end
    zoomedIn = not zoomedIn

    if faded then
        fadeOutTween:Play()
    else
        fadeInTween:Play()
    end
    faded = not faded

    VirtualInputManager:SendKeyEvent(true, "LeftControl", false, game)
end)

print("Loading Main Ui")
wait(.1)
game.StarterGui:SetCore("SendNotification", {
     Title = "Lonely Hub";
     Text = "Loading Main Ui";
     Icon = "";
     Duration = "2";
})
wait(.1)

----------------------------------------Fluent----------------------------------------
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "shizu Hub",
    SubTitle = "by devshizu",
    TabWidth = 160,
    Size = UDim2.fromOffset(500, 350),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

----------------------------------------Tabs----------------------------------------
local Tabs = {
    BloxFruit = Window:AddTab({ Title = "Blox Fruit", Icon = "" }),
    Nights = Window:AddTab({ Title = "99 Nights in the Forest", Icon = "" }),
    Rivals = Window:AddTab({ Title = "RIVALS", Icon = "" }),
    Doors = Window:AddTab({ Title = "DOORS", Icon = "" }),
    DeadRails = Window:AddTab({ Title = "Dead Rails", Icon = "" }),
    StrongestBattlegrounds = Window:AddTab({ Title = "The Strongest Battlegrounds", Icon = "" }),
    JujutsuShenanigans = Window:AddTab({ Title = "Jujutsu Shenanigans", Icon = "" }),
    StealAnEgg = Window:AddTab({ Title = "Steal an Egg", Icon = "" }),
    BladeBall = Window:AddTab({ Title = "Blade Ball", Icon = "" }),
    Evade = Window:AddTab({ Title = "Evade", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "" }),
}

----------------------------------------LoadedNotify----------------------------------------
game.StarterGui:SetCore("SendNotification", {
    Title = "Shizu Hub";
    Text = "Loaded!";
    Icon = "";
    Duration = 2;
})
print("Shizu Hub loaded — tabs created.")
