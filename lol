
--// DREAMSCAPE RT-STYLE 🌸
--// Cozy anime lighting for Roblox chill games
--// LocalScript > StarterPlayerScripts

local Lighting = game:GetService("Lighting")

-- Warm afternoon lighting
Lighting.GlobalShadows = true
Lighting.Brightness = 2.3
Lighting.ClockTime = 16.2
Lighting.ExposureCompensation = 0.05
Lighting.Ambient = Color3.fromRGB(110, 115, 145)
Lighting.OutdoorAmbient = Color3.fromRGB(165, 180, 190)
Lighting.EnvironmentDiffuseScale = 0.7
Lighting.EnvironmentSpecularScale = 0.7

local function makeEffect(className, name)
    local obj = Lighting:FindFirstChild(name)
    if not obj then
        obj = Instance.new(className)
        obj.Name = name
        obj.Parent = Lighting
    end
    return obj
end

-- Pastel color grading
local cc = makeEffect("ColorCorrectionEffect", "Dream_Color")
cc.Enabled = true
cc.Brightness = 0.025
cc.Contrast = 0.08
cc.Saturation = 0.12
cc.TintColor = Color3.fromRGB(255, 242, 225)

-- Soft glow
local bloom = makeEffect("BloomEffect", "Dream_Bloom")
bloom.Enabled = true
bloom.Intensity = 0.18
bloom.Size = 18
bloom.Threshold = 1.2

-- Sunlight through trees/windows
local sun = makeEffect("SunRaysEffect", "Dream_Sunlight")
sun.Enabled = true
sun.Intensity = 0.07
sun.Spread = 0.75

-- Gentle atmospheric depth
local atm = makeEffect("Atmosphere", "Dream_Atmosphere")
atm.Density = 0.025
atm.Offset = 0.1
atm.Color = Color3.fromRGB(195, 220, 255)
atm.Decay = Color3.fromRGB(255, 220, 195)
atm.Glare = 0.1
atm.Haze = 0.6

print("Dreamscape Chill Shader enabled 🌸")
