--// FPS BOOST v0.6 - TSB LONG-SESSION / LOW RAM
--// Bounded VFX queue, destroy visual-only FX instances, preserve normal colors, compact FPS + memory HUD
--// Camera is NOT modified: no Camera.CFrame writes, no CameraOffset forcing.
--// Generic client-side cleanup cannot remove all game/server-side lag.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
if not Player then
    warn("FPS Boost: LocalPlayer not found; run this as a client script.")
    return
end

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local REMOVE_TEXTURE = true       -- Remove decorative textures locally
local REMOVE_EFFECTS = true       -- Disable visual emitters/trails/beams locally
local REMOVE_EXPLOSIONS = true    -- Hide explosion visuals
local REMOVE_LIGHTS = true        -- Remove point/spot/surface lights locally
local REMOVE_POST_EFFECTS = true  -- Disable post effects, atmosphere and clouds
local DISABLE_SHADOWS = true
local LOW_WATER_TERRAIN = true
local LOWEST_QUALITY = true
local MUTE_SOUNDS = false

local SET_FPS_CAP = true
local FPS_CAP = 60                -- Stable mobile default; set to 90 only if your screen supports it

local HIDE_NAMED_FX_PARTS = true  -- Hide clearly named VFX parts, including effects attached to characters locally
local SHOW_FPS = true

local BATCH_SIZE = 48             -- Small batches limit temporary CPU spikes on low-RAM phones
local MAX_PENDING_OBJECTS = 256  -- Hard cap: never retain an unbounded queue during VFX-heavy moves
local HUD_UPDATE_SECONDS = 0.5

--------------------------------------------------
-- RELOAD SAFETY
--------------------------------------------------

local env = _G
pcall(function()
    if type(getgenv) == "function" then
        env = getgenv()
    end
end)

if type(env.__FPSBoostCleanup) == "function" then
    pcall(env.__FPSBoostCleanup)
end

local runActive = true
local connections = {}
local hud
local function keepConnection(connection)
    table.insert(connections, connection)
    return connection
end

local clearRunQueues
local function cleanupThisRun()
    runActive = false
    if clearRunQueues then
        pcall(clearRunQueues)
    end
    for _, connection in ipairs(connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end
    table.clear(connections)
    if hud then
        pcall(function()
            hud:Destroy()
        end)
        hud = nil
    end
end

env.__FPSBoostCleanup = cleanupThisRun

--------------------------------------------------
-- CLEAN OBJECTS ONCE ONLY
--------------------------------------------------

local pending = setmetatable({}, { __mode = "k" })
-- Fixed-size ring queue prevents a huge burst of TSB VFX from growing RAM without limit.
local queue = {}
local queueHead, queueTail, queueCount = 1, 0, 0
local queueWorkerRunning = false

clearRunQueues = function()
    for i = 1, MAX_PENDING_OBJECTS do
        queue[i] = nil
    end
    table.clear(pending)
    queueHead, queueTail, queueCount = 1, 0, 0
end


-- Only hide parts whose own/ancestor names strongly suggest temporary visual effects.
-- Avoid hiding a player's character, accessories, or equipped tools.
local FX_NAME_HINTS = {
    "effect", "vfx", "fx", "afterimage", "shockwave", "slash", "impact",
    "hitflash", "aura", "projectile", "blast", "particle", "stomp",
    "meteor", "explosion", "sparks", "windring", "wind_ring"
}

local BODY_PART_NAMES = {
    Head = true, Torso = true, HumanoidRootPart = true,
    ["Left Arm"] = true, ["Right Arm"] = true,
    ["Left Leg"] = true, ["Right Leg"] = true,
    UpperTorso = true, LowerTorso = true,
    LeftUpperArm = true, LeftLowerArm = true, LeftHand = true,
    RightUpperArm = true, RightLowerArm = true, RightHand = true,
    LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true,
    RightUpperLeg = true, RightLowerLeg = true, RightFoot = true,
}

local function looksLikeTransientFX(part)
    if not HIDE_NAMED_FX_PARTS or not part:IsA("BasePart") then
        return false
    end
    -- Never hide standard body parts. Tools and accessories are preserved unless
    -- the actual part itself is clearly named as a temporary visual effect.
    if BODY_PART_NAMES[part.Name] then
        return false
    end

    local inToolOrAccessory = part:FindFirstAncestorOfClass("Tool") ~= nil
        or part:FindFirstAncestorWhichIsA("Accoutrement") ~= nil
    local current = part
    local depth = 0
    while current and current ~= workspace and depth < 7 do
        local name = string.lower(current.Name)
        for _, hint in ipairs(FX_NAME_HINTS) do
            local matches = name == hint or (hint ~= "fx" and hint ~= "vfx" and string.find(name, hint, 1, true) ~= nil)
            if matches then
                if inToolOrAccessory and current ~= part then
                    return false
                end
                return true
            end
        end
        current = current.Parent
        depth += 1
    end
    return false
end

local function clean(obj)
    if not runActive or not obj then
        return
    end

    -- Keep animation controllers and animation assets intact.
    if obj:IsA("Animator") or obj:IsA("Animation") or obj:IsA("AnimationController") then
        return
    end

    if obj:IsA("BasePart") then
        if looksLikeTransientFX(obj) then
            pcall(function()
                obj.LocalTransparencyModifier = 1
                obj.CastShadow = false
            end)
            return
        end

        pcall(function()
            -- Preserve original colors/brightness; only reduce expensive rendering features.
            obj.Reflectance = 0
            if DISABLE_SHADOWS then
                obj.CastShadow = false
            end
        end)

        if obj:IsA("MeshPart") then
            pcall(function()
                obj.RenderFidelity = Enum.RenderFidelity.Performance
            end)
            if REMOVE_TEXTURE then
                pcall(function()
                    obj.TextureID = ""
                end)
            end
        end
        return
    end

    if REMOVE_TEXTURE then
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
            pcall(function()
                obj:Destroy()
            end)
            return
        elseif obj:IsA("SpecialMesh") then
            pcall(function()
                obj.TextureId = ""
            end)
            return
        end
    end

    if REMOVE_EFFECTS and (
        obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or
        obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or
        obj:IsA("Highlight")
    ) then
        pcall(function()
            if obj:IsA("ParticleEmitter") then
                obj.Enabled = false
                obj:Clear()
            end
            obj:Destroy()
        end)
        return
    end

    if REMOVE_EXPLOSIONS and obj:IsA("Explosion") then
        pcall(function()
            obj.Visible = false
        end)
        return
    end

    if REMOVE_LIGHTS and (
        obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight")
    ) then
        pcall(function()
            obj:Destroy()
        end)
        return
    end

    if REMOVE_POST_EFFECTS then
        if obj:IsA("PostEffect") then
            pcall(function()
                obj.Enabled = false
            end)
            return
        elseif obj:IsA("Atmosphere") then
            pcall(function()
                obj.Density = 0
                obj.Haze = 0
                obj.Glare = 0
            end)
            return
        elseif obj:IsA("Clouds") then
            pcall(function()
                obj.Enabled = false
            end)
            return
        end
    end

    if MUTE_SOUNDS and obj:IsA("Sound") then
        pcall(function()
            obj.Volume = 0
        end)
    end
end

--------------------------------------------------
-- BOUNDED NEW-OBJECT QUEUE
--
local function emergencyClean(obj)
    -- Used only if a burst exceeds the queue cap. Keep this path short and avoid
    -- ancestor scans so overload itself does not create another CPU spike.
    if not obj then return end
    pcall(function()
        if obj:IsA("ParticleEmitter") then
            obj.Enabled = false
            obj:Clear()
            obj:Destroy()
        elseif obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Smoke")
            or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Highlight")
            or obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight")
            or obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            local name = string.lower(obj.Name)
            if string.find(name, "effect", 1, true)
                or string.find(name, "vfx", 1, true)
                or string.find(name, "shockwave", 1, true)
                or string.find(name, "slash", 1, true)
                or string.find(name, "projectile", 1, true)
                or string.find(name, "afterimage", 1, true)
                or string.find(name, "aura", 1, true)
                or string.find(name, "impact", 1, true) then
                obj.LocalTransparencyModifier = 1
                obj.CastShadow = false
            end
        end
    end)
end

local function processQueue()
    while runActive and queueCount > 0 do
        local itemsThisBatch = math.min(BATCH_SIZE, queueCount)
        for _ = 1, itemsThisBatch do
            local obj = queue[queueHead]
            queue[queueHead] = nil
            queueHead = (queueHead % MAX_PENDING_OBJECTS) + 1
            queueCount -= 1

            if obj then
                pending[obj] = nil
                if obj.Parent then
                    pcall(clean, obj)
                end
            end
        end
        task.wait()
    end

    queueWorkerRunning = false
    -- No yield between checking queue state and this restart: handles any tail work safely.
    if runActive and queueCount > 0 then
        queueWorkerRunning = true
        task.spawn(processQueue)
    end
end

local function startQueueWorker()
    if queueWorkerRunning then return end
    queueWorkerRunning = true
    task.spawn(processQueue)
end

local function enqueue(obj)
    if not runActive or not obj or pending[obj] then
        return
    end

    if queueCount >= MAX_PENDING_OBJECTS then
        emergencyClean(obj)
        return
    end

    pending[obj] = true
    queueTail = (queueTail % MAX_PENDING_OBJECTS) + 1
    queue[queueTail] = obj
    queueCount += 1
    startQueueWorker()
end

local function cleanAll(root)
    -- Iterative depth-first traversal avoids creating one huge GetDescendants() array.
    local stack
    local ok = pcall(function()
        stack = root:GetChildren()
    end)
    if not ok or not stack then
        return
    end

    local count = 0
    while runActive and #stack > 0 do
        local obj = stack[#stack]
        stack[#stack] = nil

        if obj then
            pcall(clean, obj)

            local children
            pcall(function()
                children = obj:GetChildren()
            end)
            if children then
                for _, child in ipairs(children) do
                    stack[#stack + 1] = child
                end
                table.clear(children)
            end

            count += 1
            if count % BATCH_SIZE == 0 then
                task.wait()
            end
        end
    end

    table.clear(stack)
    stack = nil
end

-- Connect first so objects added during the initial scan are also handled.
keepConnection(workspace.DescendantAdded:Connect(enqueue))
keepConnection(Lighting.DescendantAdded:Connect(enqueue))

task.spawn(function()
    cleanAll(workspace)
    cleanAll(Lighting)
end)

--------------------------------------------------
-- LIGHTING / TERRAIN / QUALITY
--------------------------------------------------

pcall(function()
    Lighting.GlobalShadows = false
    -- Do not force Brightness: preserve the game's normal visibility.
    Lighting.FogEnd = 100000
    Lighting.ShadowSoftness = 0
    -- Leave environment diffuse/specular scales unchanged to avoid darkening the map.
end)

pcall(function()
    if type(sethiddenproperty) == "function" then
        sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
    end
end)

if LOW_WATER_TERRAIN then
    pcall(function()
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            if type(sethiddenproperty) == "function" then
                sethiddenproperty(terrain, "Decoration", false)
            end
        end
    end)
end

if LOWEST_QUALITY then
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
end

if SET_FPS_CAP and type(setfpscap) == "function" then
    pcall(function()
        setfpscap(FPS_CAP)
    end)
end

--------------------------------------------------
-- CAMERA
--------------------------------------------------
-- Intentionally do not change Camera.CFrame or Humanoid.CameraOffset.
-- Game-authored cutscenes/forced camera sequences are separate and cannot be
-- reliably removed by a generic visual-only optimizer.

--------------------------------------------------
-- FPS + MEMORY HUD (TOP-LEFT, BELOW ROBLOX TOP BAR)
--------------------------------------------------

if SHOW_FPS then
    local playerGui = Player:WaitForChild("PlayerGui", 10)
    if playerGui then
        local oldHud = playerGui:FindFirstChild("FPSBoostHUD")
        if oldHud then
            pcall(function()
                oldHud:Destroy()
            end)
        end

        hud = Instance.new("ScreenGui")
        hud.Name = "FPSBoostHUD"
        hud.ResetOnSpawn = false
        hud.IgnoreGuiInset = false
        hud.DisplayOrder = 20
        hud.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        hud.Parent = playerGui

        local panel = Instance.new("Frame")
        panel.Name = "Panel"
        panel.Size = UDim2.new(0, 174, 0, 48)
        panel.Position = UDim2.new(0, 10, 0, 8)
        panel.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
        panel.BackgroundTransparency = 0.18
        panel.BorderSizePixel = 0
        panel.Parent = hud

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = panel

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(110, 125, 145)
        stroke.Transparency = 0.45
        stroke.Thickness = 1
        stroke.Parent = panel

        local fpsLabel = Instance.new("TextLabel")
        fpsLabel.Name = "FPSLabel"
        fpsLabel.BackgroundTransparency = 1
        fpsLabel.Position = UDim2.new(0, 9, 0, 2)
        fpsLabel.Size = UDim2.new(1, -18, 0, 24)
        fpsLabel.Font = Enum.Font.GothamBold
        fpsLabel.TextSize = 18
        fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
        fpsLabel.TextYAlignment = Enum.TextYAlignment.Center
        fpsLabel.TextColor3 = Color3.fromRGB(90, 255, 130)
        fpsLabel.Text = "FPS: --"
        fpsLabel.Parent = panel

        local detailLabel = Instance.new("TextLabel")
        detailLabel.Name = "DetailLabel"
        detailLabel.BackgroundTransparency = 1
        detailLabel.Position = UDim2.new(0, 9, 0, 25)
        detailLabel.Size = UDim2.new(1, -18, 0, 17)
        detailLabel.Font = Enum.Font.GothamMedium
        detailLabel.TextSize = 10
        detailLabel.TextXAlignment = Enum.TextXAlignment.Left
        detailLabel.TextYAlignment = Enum.TextYAlignment.Center
        detailLabel.TextColor3 = Color3.fromRGB(220, 226, 235)
        detailLabel.Text = "RAM: --  |  LOW FX"
        detailLabel.Parent = panel

        local frameCount = 0
        local elapsed = 0
        local lastMemoryRead = 0
        local memoryText = "RAM: --"

        local function readMemoryText()
            local memoryMB
            local ok = pcall(function()
                memoryMB = Stats:GetTotalMemoryUsageMb()
            end)
            if ok and type(memoryMB) == "number" and memoryMB > 0 then
                return "RAM ~" .. tostring(math.floor(memoryMB + 0.5)) .. " MB"
            end

            -- Fallback is Lua heap only, not the whole Roblox process.
            local heapKB
            pcall(function()
                if type(gcinfo) == "function" then
                    heapKB = gcinfo()
                end
            end)
            if type(heapKB) == "number" then
                return "Lua ~" .. tostring(math.floor(heapKB / 1024 * 10) / 10) .. " MB"
            end
            return "RAM: --"
        end

        keepConnection(RunService.RenderStepped:Connect(function(dt)
            frameCount += 1
            elapsed += dt
            if elapsed < HUD_UPDATE_SECONDS then
                return
            end

            local fps = math.floor(frameCount / math.max(elapsed, 0.001) + 0.5)
            fpsLabel.Text = "FPS: " .. tostring(fps)

            if fps >= 50 then
                fpsLabel.TextColor3 = Color3.fromRGB(90, 255, 130)
            elseif fps >= 30 then
                fpsLabel.TextColor3 = Color3.fromRGB(255, 214, 90)
            else
                fpsLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            end

            local now = os.clock()
            if now - lastMemoryRead >= 1 then
                memoryText = readMemoryText()
                lastMemoryRead = now
            end
            detailLabel.Text = memoryText .. "  |  LOW FX"

            frameCount = 0
            elapsed = 0
        end))
    end
end

print("FPS BOOST v0.6 loaded - bounded low-RAM VFX queue, no camera forcing, FPS/RAM HUD")
