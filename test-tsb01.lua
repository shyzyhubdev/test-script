local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

local Config = {
    Enabled = true,
    MaxDistance = 12,
    M1Distance = 6.5,
    HoldDuration = 0.25,
    GuardHealthMax = 100,
    GuardDrainRate = 30,
    GuardRecoverRate = 45,
    DashThreshold = 30,
    
    -- Cấu hình phản công M1 sau khi đỡ
    CounterAttackEnabled = true,
    CounterDelay = 0.1, -- Độ trễ ngắn sau khi nhả khiên để tung M1 phản đòn
}

local isBlocking = false
local lastAttackTick = 0
local currentGuard = Config.GuardHealthMax
local lastTick = tick()
local isDashing = false
local wasEnemyAttackingLastFrame = false

local function setBlock(state)
    if isBlocking ~= state then
        isBlocking = state
        VirtualInputManager:SendKeyEvent(state, Enum.KeyCode.F, false, game)
    end
end

-- Hàm thực hiện cú đấm M1 phản công
local function performCounterM1()
    if not Config.CounterAttackEnabled then return end
    task.wait(Config.CounterDelay) -- Chờ khoảnh khắc vừa nhả khiên
    
    -- Giả lập click chuột trái để đấm M1
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait(0.02)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

local function performEmergencyDash()
    if isDashing then return end
    isDashing = true
    setBlock(false)
    
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
    task.wait(0.02)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.06)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
    
    currentGuard = Config.GuardHealthMax * 0.6
    task.wait(0.15)
    isDashing = false
end

RunService.Stepped:Connect(function()
    if not Config.Enabled or isDashing then return end
    
    local now = tick()
    local dt = now - lastTick
    lastTick = now
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local enemyDetected = false
    local targetToAttack = nil
    local shortestDist = Config.MaxDistance
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local enemyChar = player.Character
            local distance = (character.HumanoidRootPart.Position - enemyChar.HumanoidRootPart.Position).Magnitude
            
            if distance <= Config.MaxDistance then
                local animator = enemyChar:FindFirstChildOfClass("Humanoid") and enemyChar.Humanoid:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        local animName = track.Name:lower()
                        if string.find(animName, "punch") or string.find(animName, "m1") or string.find(animName, "attack") then
                            enemyDetected = true
                            lastAttackTick = now
                            break
                        end
                    end
                end
                
                if distance < shortestDist then
                    shortestDist = distance
                    targetToAttack = enemyChar
                end
            end
        end
    end
    
    -- Xử lý chuyển giao trạng thái: Đang đỡ -> Vừa ngớt đòn -> Phản công M1
    if enemyDetected then
        setBlock(true)
        currentGuard = math.clamp(currentGuard - (Config.GuardDrainRate * dt), 0, Config.GuardHealthMax)
        
        if currentGuard <= Config.DashThreshold then
            task.spawn(performEmergencyDash)
            return
        end
        wasEnemyAttackingLastFrame = true
    else
        -- Nếu trước đó đang block mà bây giờ địch ngừng đánh -> Thời cơ phản công!
        if isBlocking and wasEnemyAttackingLastFrame then
            setBlock(false) -- Nhả khiên ra ngay lập tức
            wasEnemyAttackingLastFrame = false
            
            -- Nếu địch ở trong tầm M1 thì kích hoạt phản đòn liền
            if targetToAttack and shortestDist <= Config.M1Distance then
                task.spawn(performCounterM1)
            end
        end
        
        if isBlocking and (now - lastAttackTick > Config.HoldDuration) then
            setBlock(false)
            wasEnemyAttackingLastFrame = false
        end
        
        currentGuard = math.clamp(currentGuard + (Config.GuardRecoverRate * dt), 0, Config.GuardHealthMax)
    end
end)
