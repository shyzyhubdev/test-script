--// FPS BOOST v0.9 - TSB LOW-RAM / LOW-OVERHEAD
--// Tuned for Android: Unisoc T7250, Mali-G57 MP1, 60 Hz, about 3.7 GB total RAM.
--// Goal: lower client-side visual load without repeatedly scanning Workspace,
--// retaining spawned-instance queues, recoloring the map, or forcing the camera.
--// Important: this can reduce client rendering load, but cannot fix server/network lag
--// or guarantee stable FPS if the device is thermally throttling.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
if not Player then
    warn("FPS Boost v0.9 must run on the client.")
    return
end

--==============================
-- SETTINGS
--==============================
local LOWEST_QUALITY = true
local DISABLE_SHADOWS = true
local FLATTEN_WATER = true
local DISABLE_POST_EFFECTS = true
local FILTER_COMBAT_VFX = true       -- Turn off newly spawned visual effects locally.
local FILTER_CURRENT_CHARACTERS = true
local SHOW_HUD = true
local FPS_UPDATE_INTERVAL = 1.0       -- Fewer HUD updates than earlier versions.
local MEMORY_UPDATE_INTERVAL = 5.0
local TARGET_FPS_CAP = 60              -- Only applied if the runtime exposes setfpscap.

--==============================
-- RE-RUN CLEANUP
--==============================
local env = _G
pcall(function()
    if type(getgenv) == "function" then
        env = getgenv()
    end
end)
if type(env.__FPSBoostCleanup) == "function" then
    pcall(env.__FPSBoostCleanup)
end

local active = true
local connections = {}
local hud = nil

local function connect(signal, callback)
    local connection = signal:Connect(callback)
    connections[#connections + 1] = connection
    return connection
end

local function cleanup()
    if not active then
        return
    end
    active = false
    for i = #connections, 1, -1 do
        local connection = connections[i]
        connections[i] = nil
        pcall(function()
            connection:Disconnect()
        end)
    end
    if hud then
        pcall(function()
            hud:Destroy()
        end)
        hud = nil
    end
end

env.__FPSBoostCleanup = cleanup

-- Clean up the specifically named render-step binding used by older versions.
-- This does not alter the game's own camera; it removes only the old script binding.
pcall(function()
    RunService:UnbindFromRenderStep("AntiScreenShake")
end)

--==============================
-- VISUAL EFFECT FILTER
-- Only handles known visual effect classes. No global object queue/cache.
--==============================
local function quietVisualEffect(obj)
    if not active or not obj then
        return
    end

    local className = obj.ClassName
    if className == "ParticleEmitter" then
        pcall(function()
            obj.Enabled = false
            obj:Clear()
        end)
    elseif className == "Trail" or className == "Beam" or className == "Smoke"
        or className == "Fire" or className == "Sparkles" or className == "Highlight" then
        pcall(function()
            obj.Enabled = false
        end)
    elseif className == "PointLight" or className == "SpotLight" or className == "SurfaceLight" then
        pcall(function()
            obj.Enabled = false
            obj.Shadows = false
        end)
    elseif className == "Explosion" then
        -- Visual-only change. Do not modify blast pressure or gameplay properties.
        pcall(function()
            obj.Visible = false
        end)
    elseif className == "ForceField" then
        pcall(function()
            obj.Visible = false
        end)
    end
end

-- The initial scan is limited to character models only; never build a huge
-- Workspace:GetDescendants() array on a low-memory phone.
local function scanCharacter(character)
    if not FILTER_CURRENT_CHARACTERS or not character or not active then
        return
    end
    task.spawn(function()
        if not active or not character.Parent then
            return
        end
        local descendants
        local ok = pcall(function()
            descendants = character:GetDescendants()
        end)
        if not ok or type(descendants) ~= "table" then
            return
        end
        for i = 1, #descendants do
            if not active then
                break
            end
            quietVisualEffect(descendants[i])
            -- Yield briefly so a large avatar/accessory set does not block one frame.
            if i % 80 == 0 then
                task.wait()
            end
        end
        descendants = nil
    end)
end

if FILTER_COMBAT_VFX then
    -- Only one Workspace connection; callback immediately ignores non-effect classes.
    connect(Workspace.DescendantAdded, quietVisualEffect)
end

-- Existing players and future characters.
if FILTER_CURRENT_CHARACTERS then
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer.Character then
            scanCharacter(otherPlayer.Character)
        end
        connect(otherPlayer.CharacterAdded, scanCharacter)
    end
    connect(Players.PlayerAdded, function(otherPlayer)
        connect(otherPlayer.CharacterAdded, scanCharacter)
        if otherPlayer.Character then
            scanCharacter(otherPlayer.Character)
        end
    end)
end

--==============================
-- LIGHTING: limited to Lighting, not Workspace
--==============================
local POST_EFFECT_CLASSES = {
    BloomEffect = true,
    BlurEffect = true,
    ColorCorrectionEffect = true,
    DepthOfFieldEffect = true,
    SunRaysEffect = true,
}

local function quietLightingObject(obj)
    if not active or not DISABLE_POST_EFFECTS or not obj then
        return
    end
    local className = obj.ClassName
    if POST_EFFECT_CLASSES[className] then
        pcall(function()
            obj.Enabled = false
        end)
    elseif className == "Atmosphere" then
        pcall(function()
            obj.Density = 0
            obj.Haze = 0
            obj.Glare = 0
        end)
    elseif className == "Clouds" then
        pcall(function()
            obj.Enabled = false
        end)
    end
end

if DISABLE_POST_EFFECTS then
    local lightingDescendants = Lighting:GetDescendants()
    for i = 1, #lightingDescendants do
        quietLightingObject(lightingDescendants[i])
    end
    lightingDescendants = nil
    connect(Lighting.DescendantAdded, quietLightingObject)
end

pcall(function()
    if DISABLE_SHADOWS then
        Lighting.GlobalShadows = false
        Lighting.ShadowSoftness = 0
    end
end)

if FLATTEN_WATER then
    pcall(function()
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
        end
    end)
end

if LOWEST_QUALITY then
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
end

-- A 60 FPS cap can avoid wasting power above this phone's 60 Hz screen; it does not
-- create FPS if the game/device cannot render fast enough.
if type(setfpscap) == "function" then
    pcall(setfpscap, TARGET_FPS_CAP)
end

--==============================
-- MINIMAL FPS / GAME MEMORY HUD
-- GetTotalMemoryUsageMb reports Roblox's process memory, NOT free phone RAM.
--==============================
if SHOW_HUD then
    local playerGui = Player:WaitForChild("PlayerGui", 10)
    if playerGui then
        -- Remove HUDs created by previous script versions to avoid stacked overlays.
        for _, oldName in ipairs({"FPSBoostHUD", "UltraFPSCounter"}) do
            local oldHud = playerGui:FindFirstChild(oldName)
            if oldHud then
                pcall(function()
                    oldHud:Destroy()
                end)
            end
        end

        hud = Instance.new("ScreenGui")
        hud.Name = "FPSBoostHUD"
        hud.ResetOnSpawn = false
        hud.IgnoreGuiInset = false
        hud.DisplayOrder = 20
        hud.Parent = playerGui

        local panel = Instance.new("Frame")
        panel.Name = "Panel"
        panel.Size = UDim2.new(0, 198, 0, 54)
        panel.Position = UDim2.new(0, 10, 0, 8)
        panel.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
        panel.BackgroundTransparency = 0.18
        panel.BorderSizePixel = 0
        panel.Parent = hud

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = panel

        local fpsLabel = Instance.new("TextLabel")
        fpsLabel.Name = "FPSLabel"
        fpsLabel.BackgroundTransparency = 1
        fpsLabel.Position = UDim2.new(0, 9, 0, 2)
        fpsLabel.Size = UDim2.new(1, -18, 0, 25)
        fpsLabel.Font = Enum.Font.GothamBold
        fpsLabel.TextSize = 18
        fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
        fpsLabel.Text = "FPS: --"
        fpsLabel.TextColor3 = Color3.fromRGB(90, 255, 130)
        fpsLabel.Parent = panel

        local detail = Instance.new("TextLabel")
        detail.Name = "DetailLabel"
        detail.BackgroundTransparency = 1
        detail.Position = UDim2.new(0, 9, 0, 29)
        detail.Size = UDim2.new(1, -18, 0, 17)
        detail.Font = Enum.Font.GothamMedium
        detail.TextSize = 10
        detail.TextXAlignment = Enum.TextXAlignment.Left
        detail.TextColor3 = Color3.fromRGB(220, 226, 235)
        detail.Text = "Game Mem: -- | VFX FILTER: ON"
        detail.Parent = panel

        local frames = 0
        local elapsed = 0
        local timeSinceMemory = MEMORY_UPDATE_INTERVAL
        local memoryText = "Game Mem: --"

        connect(RunService.RenderStepped, function(dt)
            if not active then
                return
            end
            frames += 1
            elapsed += dt
            timeSinceMemory += dt
            if elapsed < FPS_UPDATE_INTERVAL then
                return
            end

            local fps = math.floor(frames / math.max(elapsed, 0.001) + 0.5)
            fpsLabel.Text = "FPS: " .. tostring(fps)
            if fps >= 50 then
                fpsLabel.TextColor3 = Color3.fromRGB(90, 255, 130)
            elseif fps >= 30 then
                fpsLabel.TextColor3 = Color3.fromRGB(255, 214, 90)
            else
                fpsLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            end

            if timeSinceMemory >= MEMORY_UPDATE_INTERVAL then
                local mb
                local ok = pcall(function()
                    mb = Stats:GetTotalMemoryUsageMb()
                end)
                if ok and type(mb) == "number" and mb > 0 then
                    memoryText = "Game Mem: ~" .. tostring(math.floor(mb + 0.5)) .. " MB"
                elseif type(gcinfo) == "function" then
                    local heap
                    pcall(function()
                        heap = gcinfo()
                    end)
                    if type(heap) == "number" then
                        memoryText = "Lua Heap: ~" .. tostring(math.floor(heap + 0.5)) .. " KB"
                    end
                end
                timeSinceMemory = 0
            end

            detail.Text = memoryText .. " | VFX FILTER: ON"
            frames = 0
            elapsed = 0
        end)
    end
end

print("FPS Boost v0.9 loaded | low RAM | no camera force | combat VFX filter on")
