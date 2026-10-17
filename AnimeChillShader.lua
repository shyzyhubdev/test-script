-- Anime Chill Shader (client-side visual preset)
-- For Roblox Studio: put this LocalScript in StarterPlayer > StarterPlayerScripts.
-- Works with normal Roblox APIs; no executor-only functions.

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then
    return
end

-- =========================
-- CONFIG: pastel anime / chill map
-- =========================
local CONFIG = {
    Brightness = 2.0,
    GlobalShadows = true,
    ShadowSoftness = 0.55,
    EnvironmentDiffuseScale = 0.85,
    EnvironmentSpecularScale = 0.70,

    BloomIntensity = 0.22,
    BloomSize = 28,
    BloomThreshold = 1.15,

    ColorBrightness = 0.015,
    ColorContrast = 0.08,
    ColorSaturation = 0.18,
    -- Warm highlights with a soft pastel tone
    ColorTint = Color3.fromRGB(255, 244, 238),

    SunRaysIntensity = 0.055,
    SunRaysSpread = 0.78,

    AtmosphereColor = Color3.fromRGB(199, 222, 255),
    AtmosphereDecay = Color3.fromRGB(255, 214, 205),
    AtmosphereDensity = 0.18,
    AtmosphereOffset = 0.05,
    AtmosphereHaze = 1.1,
    AtmosphereGlare = 0.12,

    -- Depth of field is off by default to keep the whole chill map clear.
    EnableDepthOfField = false,
    DepthFarIntensity = 0.08,
    DepthFocusDistance = 35,
    DepthInFocusRadius = 50,
    DepthNearIntensity = 0.05,
}

local NAMES = {
    Bloom = "AnimeChill_Bloom",
    Color = "AnimeChill_ColorCorrection",
    Rays = "AnimeChill_SunRays",
    DOF = "AnimeChill_DepthOfField",
    Atmosphere = "AnimeChill_Atmosphere",
    Gui = "AnimeChillShaderGui",
}

-- Snapshot lighting properties so turning the shader off restores them.
local originalLighting = {
    Brightness = Lighting.Brightness,
    GlobalShadows = Lighting.GlobalShadows,
    ShadowSoftness = Lighting.ShadowSoftness,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
}

local originalAtmosphere = nil
local originalAtmosphereProperties = nil
local createdAtmosphere = false
local enabled = false
local guiButton

local function destroyOurEffects()
    for _, name in pairs({NAMES.Bloom, NAMES.Color, NAMES.Rays, NAMES.DOF}) do
        local effect = Lighting:FindFirstChild(name)
        if effect then
            effect:Destroy()
        end
    end

    local atmosphere = Lighting:FindFirstChild(NAMES.Atmosphere)
    if atmosphere and atmosphere:IsA("Atmosphere") then
        atmosphere:Destroy()
    end
end

-- Clean up only this shader's previous instances, not the map's original effects.
destroyOurEffects()

local function applyLighting()
    Lighting.Brightness = CONFIG.Brightness
    Lighting.GlobalShadows = CONFIG.GlobalShadows
    Lighting.ShadowSoftness = CONFIG.ShadowSoftness
    Lighting.EnvironmentDiffuseScale = CONFIG.EnvironmentDiffuseScale
    Lighting.EnvironmentSpecularScale = CONFIG.EnvironmentSpecularScale
end

local function createEffect(className, name)
    local effect = Instance.new(className)
    effect.Name = name
    effect.Enabled = true
    effect.Parent = Lighting
    return effect
end

local function setupAtmosphere()
    originalAtmosphere = Lighting:FindFirstChildOfClass("Atmosphere")

    if originalAtmosphere then
        originalAtmosphereProperties = {
            Color = originalAtmosphere.Color,
            Decay = originalAtmosphere.Decay,
            Density = originalAtmosphere.Density,
            Offset = originalAtmosphere.Offset,
            Haze = originalAtmosphere.Haze,
            Glare = originalAtmosphere.Glare,
        }
        createdAtmosphere = false
    else
        originalAtmosphere = Instance.new("Atmosphere")
        originalAtmosphere.Name = NAMES.Atmosphere
        originalAtmosphere.Parent = Lighting
        createdAtmosphere = true
    end

    originalAtmosphere.Color = CONFIG.AtmosphereColor
    originalAtmosphere.Decay = CONFIG.AtmosphereDecay
    originalAtmosphere.Density = CONFIG.AtmosphereDensity
    originalAtmosphere.Offset = CONFIG.AtmosphereOffset
    originalAtmosphere.Haze = CONFIG.AtmosphereHaze
    originalAtmosphere.Glare = CONFIG.AtmosphereGlare
end

local function enableShader()
    if enabled then
        return
    end

    applyLighting()

    local bloom = createEffect("BloomEffect", NAMES.Bloom)
    bloom.Intensity = CONFIG.BloomIntensity
    bloom.Size = CONFIG.BloomSize
    bloom.Threshold = CONFIG.BloomThreshold

    local color = createEffect("ColorCorrectionEffect", NAMES.Color)
    color.Brightness = CONFIG.ColorBrightness
    color.Contrast = CONFIG.ColorContrast
    color.Saturation = CONFIG.ColorSaturation
    color.TintColor = CONFIG.ColorTint

    local rays = createEffect("SunRaysEffect", NAMES.Rays)
    rays.Intensity = CONFIG.SunRaysIntensity
    rays.Spread = CONFIG.SunRaysSpread

    if CONFIG.EnableDepthOfField then
        local dof = createEffect("DepthOfFieldEffect", NAMES.DOF)
        dof.FarIntensity = CONFIG.DepthFarIntensity
        dof.FocusDistance = CONFIG.DepthFocusDistance
        dof.InFocusRadius = CONFIG.DepthInFocusRadius
        dof.NearIntensity = CONFIG.DepthNearIntensity
    end

    setupAtmosphere()
    enabled = true
end

local function disableShader()
    if not enabled then
        return
    end

    destroyOurEffects()

    -- Restore the map's original Atmosphere, if we modified one.
    if originalAtmosphere and originalAtmosphere.Parent and not createdAtmosphere and originalAtmosphereProperties then
        for property, value in pairs(originalAtmosphereProperties) do
            pcall(function()
                originalAtmosphere[property] = value
            end)
        end
    end

    -- Restore the map's original Lighting properties.
    for property, value in pairs(originalLighting) do
        pcall(function()
            Lighting[property] = value
        end)
    end

    enabled = false
end

local function toggleShader()
    if enabled then
        disableShader()
    else
        enableShader()
    end

    if guiButton then
        guiButton.Text = enabled and "ANIME CHILL: ON" or "ANIME CHILL: OFF"
        guiButton.BackgroundColor3 = enabled and Color3.fromRGB(91, 125, 165) or Color3.fromRGB(65, 69, 82)
    end
end

-- Touch-friendly toggle button for phones/tablets.
task.spawn(function()
    local playerGui = player:WaitForChild("PlayerGui")
    local oldGui = playerGui:FindFirstChild(NAMES.Gui)
    if oldGui then
        oldGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = NAMES.Gui
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 20
    screenGui.Parent = playerGui

    local button = Instance.new("TextButton")
    button.Name = "ToggleShader"
    button.AnchorPoint = Vector2.new(1, 0)
    button.Position = UDim2.new(1, -14, 0, 58)
    button.Size = UDim2.new(0, 154, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(91, 125, 165)
    button.BackgroundTransparency = 0.12
    button.BorderSizePixel = 0
    button.Text = "ANIME CHILL: ON"
    button.TextColor3 = Color3.fromRGB(255, 250, 248)
    button.TextSize = 13
    button.Font = Enum.Font.GothamSemibold
    button.AutoButtonColor = true
    button.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(221, 232, 255)
    stroke.Transparency = 0.55
    stroke.Thickness = 1
    stroke.Parent = button

    guiButton = button
    button.Activated:Connect(toggleShader)
end)

-- Keyboard toggle for PC; phones can use the on-screen button.
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.RightControl then
        toggleShader()
    end
end)

-- Start with the shader enabled.
enableShader()
print("Anime Chill Shader loaded. Tap the button or press RightControl to toggle.")
