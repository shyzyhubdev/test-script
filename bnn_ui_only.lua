-- UI-only rebuild extracted from bnn.lua.txt. All controls are inert; no game actions or remote calls.

local A = loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/refs/heads/main/zzzz.lua"))()

local Main = A.CreateMain({ Title = "Blox Fruit", Desc = "Blox Fruit - UI Only" })

local PageShop = Main.CreatePage({ Page_Name = 'Shop', Page_Title = 'Shop' })

local PageStatusAndServer = Main.CreatePage({ Page_Name = 'Status And Server', Page_Title = 'Status And Server' })

local LocalPlayerMain = Main.CreatePage({ Page_Name = 'LocalPlayer', Page_Title = 'LocalPlayer' })

local SettingFarmMain = Main.CreatePage({ Page_Name = 'Setting Farm', Page_Title = 'Setting Farm' })

local SettingSkillMain = Main.CreatePage({ Page_Name = 'Hold and Select Skill', Page_Title = 'Setting Hold and Select Skill' })

local FarmMain = Main.CreatePage({ Page_Name = 'Farming', Page_Title = 'Farming' })

local stackFarmMain = Main.CreatePage({ Page_Name = 'Stack Farming', Page_Title = 'Stack Farming' })

local FarmotherMain = Main.CreatePage({ Page_Name = 'Farming Other', Page_Title = 'Farming Other' })

local DFRaidMain = Main.CreatePage({ Page_Name = 'Fruit and Raid, Dungeon', Page_Title = 'Fruit and Raid and Dungeon Tab' })

local SeaEventTab = Main.CreatePage({ Page_Name = 'Sea Event', Page_Title = 'Sea Event Tab' })

local RaceMain = Main.CreatePage({ Page_Name = 'Upgrade Race', Page_Title = 'Upgrade Race Tab' })

local GetItemsMain = Main.CreatePage({ Page_Name = 'Get and Upgrade Items', Page_Title = 'Get and Upgrade Items Tab' })

local VolcanoTab = Main.CreatePage({ Page_Name = 'Volcano Event', Page_Title = 'Volcano Event Tab' })

local ESPTab = Main.CreatePage({ Page_Name = 'ESP', Page_Title = 'ESP Tab' })

local PvpTab = Main.CreatePage({ Page_Name = 'PVP', Page_Title = 'PVP Tab' })

local TabWebhook = Main.CreatePage({ Page_Name = 'Tab Webhook', Page_Title = 'Tab Webhook' })

local SettingPage = Main.CreatePage({ Page_Name = 'Setting', Page_Title = 'Setting Tab' })

local SectionShopMisc = PageShop.CreateSection('Misc Shop')

local SectionShopFighting = PageShop.CreateSection('Fighting Shop')

local SectionShopAbilities = PageShop.CreateSection('Abilities Shop')

local SectionStatus = PageStatusAndServer.CreateSection('Status')

local SectionServer = PageStatusAndServer.CreateSection('Server')

local SectionLocalPlayerMain = LocalPlayerMain.CreateSection('Local Player')

local SettingFarmMainSection = SettingFarmMain.CreateSection('Setting Farm')

local SelectSkillsSection = SettingSkillMain.CreateSection('Select Skills')

local HoldSkillsSection = SettingSkillMain.CreateSection('Hold Skills')

local SettingAutoFarmSection = FarmMain.CreateSection('Setting Farm')

local MasteryFarmSection = FarmMain.CreateSection('Mastery Farm')

local FarmingMaterialSection = FarmMain.CreateSection('Farming Material')

local AutoWorldSection = stackFarmMain.CreateSection('Auto World')

local StackDevilFruitSection = stackFarmMain.CreateSection('Devil Fruit')

local EventGameSection = stackFarmMain.CreateSection('Event Game')

local BossRipIndraSection = stackFarmMain.CreateSection('Boss Rip Indra')

local BossSoulReaperSection = stackFarmMain.CreateSection('Boss Soul Reaper')

local BossDoughKingSection = stackFarmMain.CreateSection('Boss Dough King')

local BossDarkbeardSection = stackFarmMain.CreateSection('Boss Darkbeard')

local EventEasterSection = FarmotherMain.CreateSection('Event Easter')

local FishingSection = FarmotherMain.CreateSection('Fishing')

local QuestDragonSection = FarmotherMain.CreateSection('Quest Dragon')

local AttackAllMobSection = FarmotherMain.CreateSection('Attack All Mobs')

local BerrySection = FarmotherMain.CreateSection('Berry')

local FarmChestSection = FarmotherMain.CreateSection('Farm Chest')

local RaidLawSection = FarmotherMain.CreateSection('Raid Law')

local FarmObservationSection = FarmotherMain.CreateSection('Farm Observation')

local AutoKillMobSection = FarmotherMain.CreateSection('Auto Kill Mob')

local AutoKillBossSection = FarmotherMain.CreateSection('Auto Boss')

local DevilFruitSection = DFRaidMain.CreateSection('Devil Fruit')

local RaidsSection = DFRaidMain.CreateSection('Raids')

local MultiRaidsSection = DFRaidMain.CreateSection('Multi Raid')

local DungeonJoinSection = DFRaidMain.CreateSection('Join Dungeon')

local DungeonSection = DFRaidMain.CreateSection('Dungeon')

local SettingSeaEventSection = SeaEventTab.CreateSection('Setting')

local FarmingSeaEventSection = SeaEventTab.CreateSection('Farming')

local KitsuneEventSection = SeaEventTab.CreateSection('Kitsune Event')

local LeviathanEventSection = SeaEventTab.CreateSection('Leviathan Event')

local BoatSettingSection = SeaEventTab.CreateSection('Boat Setting')

local RaceDracoSection = RaceMain.CreateSection('Race Draco')

local RaceNormalSection = RaceMain.CreateSection('Race Normal')

local RaceV4Section = RaceMain.CreateSection('Race V4')

local KillTrialSection = RaceMain.CreateSection('Kill Trial')

local GetItemsSection = GetItemsMain.CreateSection('Get Items')

local MasteryWeaponSection = GetItemsMain.CreateSection('Mastery Weapon')

local UpgradeWeaponSection = GetItemsMain.CreateSection('Upgrade Weapon')

local SettingsVolcanoSection = VolcanoTab.CreateSection('Settings Volcano')

local FarmingVolcanoSection = VolcanoTab.CreateSection('Farming Volcano')

local FullyVolcanoSection = VolcanoTab.CreateSection('Fully Volcano')

local ESPSection = ESPTab.CreateSection('ESP')

local SettingsAimbotSection = PvpTab.CreateSection('PVP')

local MISCPVPSection = PvpTab.CreateSection('MISC PVP')

local SectionWebhook = TabWebhook.CreateSection('Webhook')

local a = SettingPage.CreateSection('Settings')

SectionShopMisc.CreateButton({ Title = "Redeem Code" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Teleport Old World" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Teleport New World" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Teleport Thid Sea" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Buy Dual Flintlock" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Reroll Race" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Reset Stats" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Buy Race Cyborg" }, function(...) end)

SectionShopMisc.CreateButton({ Title = "Buy Race Ghoul" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Black Leg" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Fishman Karate" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Electro" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Dragon Breath" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "SuperHuman" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Death Step" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Sharkman Karate" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Electric Claw" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Dragon Talon" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "God Human" }, function(...) end)

SectionShopFighting.CreateToggle({ Title = "Sanguine Art" }, function(...) end)

SectionShopAbilities.CreateButton({ Title = "Skyjump [ $10,000 Beli ]" }, function(...) end)

SectionShopAbilities.CreateButton({ Title = "Buso Haki [ $25,000 Beli ]" }, function(...) end)

SectionShopAbilities.CreateButton({ Title = "Observation haki [ $750,000 Beli ]" }, function(...) end)

SectionShopAbilities.CreateButton({ Title = "Soru [ $100,000 Beli ]" }, function(...) end)

SectionStatus.CreateLabel({ Title = "Timer" })

SectionStatus.CreateLabel({ Title = "Timer Server" })

SectionStatus.CreateLabel({ Title = "Next Time Spawn Fist of Darkness or God's Chalice" })

SectionStatus.CreateLabel({ Title = "Elite" })

SectionStatus.CreateLabel({ Title = "Eyes Summon Tyrant" })

SectionStatus.CreateLabel({ Title = "Summon Katakuri" })

SectionStatus.CreateLabel({ Title = "Status SPY" })

SectionStatus.CreateLabel({ Title = "Mirage" })

SectionStatus.CreateLabel({ Title = "Prehistoric Island" })

SectionStatus.CreateLabel({ Title = "Frozen Dimension" })

SectionStatus.CreateLabel({ Title = "Moon" })

SectionStatus.CreateLabel({ Title = "Acient One Status" })

SectionServer.CreateButton({ Title = "Open Gui Server Browser (Low Player and Ping)" }, function(...) end)

SectionServer.CreateLabel({ Title = "PlaceId:" })

SectionServer.CreateToggle({ Title = "Spam Join" }, function(...) end)

SectionServer.CreateButton({ Title = "Join JobId" }, function(...) end)

SectionServer.CreateButton({ Title = "Copy JobId" }, function(...) end)

SectionServer.CreateButton({ Title = "Hop Server" }, function(...) end)

SectionServer.CreateButton({ Title = "Hop Server Less People" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Auto Translate" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Stop Tween" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Fix UI Button Game" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Load config in Web" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Push Data To Web ( just push when join game,if push again plz rejoin )" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Show Item" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop Mirage" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Open Title" }, function(...) end)

SectionLocalPlayerMain.CreateButton({ Title = "Open Color" }, function(...) end)

SectionLocalPlayerMain.CreateDropdown({ Title = "Select Stats" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Auto Stats" }, function(...) end)

SectionLocalPlayerMain.CreateDropdown({ Title = "Select Team" }, function(...) end)

SectionLocalPlayerMain.CreateDropdown({ Title = "Change Team" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Noclip" }, function(...) end)

SectionLocalPlayerMain.CreateDropdown({ Title = "Select Npc" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Npc" }, function(...) end)

SectionLocalPlayerMain.CreateDropdown({ Title = "Select Island" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Island" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Teleport Mirage" }, function(...) end)

SectionLocalPlayerMain.CreateToggle({ Title = "Teleport Prehistoric Island" }, function(...) end)

SettingFarmMainSection.CreateDropdown({ Title = "Select Weapon" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Attack No Animation" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Kill Aura Only Raid And Volcano" }, function(...) end)

SettingFarmMainSection.CreateSlider({ Title = "Time Delay Kill" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Auto Click" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Kill Aura With DragonStorm" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Auto Turn On Buso" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Auto Turn On Observation" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Auto Turn On V4" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Auto Turn On V3" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Auto Dodge Skill Mobs" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Teleport Y if low health" }, function(...) end)

SettingFarmMainSection.CreateSlider({ Title = "% Health Player" }, function(...) end)

SettingFarmMainSection.CreateSlider({ Title = "Distance Teleport Y" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Tween Safe if have Items" }, function(...) end)

SettingFarmMainSection.CreateSlider({ Title = "Time Hop Server" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Use Portal Teleport" }, function(...) end)

SettingFarmMainSection.CreateSlider({ Title = "Bring Mob Count" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Bring Mob" }, function(...) end)

SettingFarmMainSection.CreateToggle({ Title = "Reset Teleport [ Beta ]" }, function(...) end)

SettingFarmMainSection.CreateSlider({ Title = "Speed Tween" }, function(...) end)

SettingFarmMainSection.CreateLabel({ Title = "Recommended: 350. If you\\226\\128\\153re farming spots close to each other, use a higher speed" })

SelectSkillsSection.CreateDropdown({ Title = "Dropdown" }, function(...) end)

HoldSkillsSection.CreateDropdown({ Title = "Set Delay" }, function(...) end)

HoldSkillsSection.CreateToggle({ Title = "Use skill fast dont hold" }, function(...) end)

SettingAutoFarmSection.CreateDropdown({ Title = "Select Method Farm" }, function(...) end)

SettingAutoFarmSection.CreateSlider({ Title = "Distance Farm Aura" }, function(...) end)

SettingAutoFarmSection.CreateToggle({ Title = "Ignore Attack Katakuri" }, function(...) end)

SettingAutoFarmSection.CreateToggle({ Title = "Hop Find Katakuri" }, function(...) end)

SettingAutoFarmSection.CreateToggle({ Title = "Auto Quest [Katakuri/Bone/Tyrant]" }, function(...) end)

SettingAutoFarmSection.CreateToggle({ Title = "Start Farm" }, function(...) end)

MasteryFarmSection.CreateDropdown({ Title = "Select Method Farm Mastery" }, function(...) end)

MasteryFarmSection.CreateSlider({ Title = "Health %" }, function(...) end)

MasteryFarmSection.CreateToggle({ Title = "Farm Mastery" }, function(...) end)

FarmingMaterialSection.CreateDropdown({ Title = "Select Material" }, function(...) end)

FarmingMaterialSection.CreateToggle({ Title = "Farm Material" }, function(...) end)

AutoWorldSection.CreateToggle({ Title = "Auto New World" }, function(...) end)

AutoWorldSection.CreateToggle({ Title = "Auto Third World" }, function(...) end)

StackDevilFruitSection.CreateToggle({ Title = "Collect Chest When Server Spawn\\10God's Chalice or Fist of Darkness" }, function(...) end)

StackDevilFruitSection.CreateToggle({ Title = "Teleport To Fruit" }, function(...) end)

StackDevilFruitSection.CreateToggle({ Title = "Teleport To Fruit [ Hop Server ]" }, function(...) end)

EventGameSection.CreateToggle({ Title = "Auto Factory" }, function(...) end)

EventGameSection.CreateToggle({ Title = "Auto Pirate Raid" }, function(...) end)

BossRipIndraSection.CreateToggle({ Title = "Auto Elite Hunter" }, function(...) end)

BossRipIndraSection.CreateToggle({ Title = "Hop Server Elite Hunter\"" }, function(...) end)

BossRipIndraSection.CreateToggle({ Title = "Auto Touch Pad Haki" }, function(...) end)

BossRipIndraSection.CreateToggle({ Title = "Auto Summon Rip Indra" }, function(...) end)

BossRipIndraSection.CreateToggle({ Title = "Attack Rip Indra" }, function(...) end)

BossSoulReaperSection.CreateToggle({ Title = "Attack Soul Reaper" }, function(...) end)

BossSoulReaperSection.CreateToggle({ Title = "Summon Soul Reaper" }, function(...) end)

BossDoughKingSection.CreateToggle({ Title = "Attack Dough King" }, function(...) end)

BossDoughKingSection.CreateToggle({ Title = "Summon Dough King" }, function(...) end)

BossDoughKingSection.CreateToggle({ Title = "Hop Find Dough King" }, function(...) end)

BossDarkbeardSection.CreateToggle({ Title = "Attack Darkbeard" }, function(...) end)

BossDarkbeardSection.CreateToggle({ Title = "Summon Darkbeard" }, function(...) end)

BossDarkbeardSection.CreateToggle({ Title = "Hop Find Darkbeard" }, function(...) end)

EventEasterSection.CreateButton({ Title = "Open Easter Shop" }, function(...) end)

EventEasterSection.CreateToggle({ Title = "Auto Collect Egg Easter" }, function(...) end)

FishingSection.CreateToggle({ Title = "Change Size Reel" }, function(...) end)

FishingSection.CreateToggle({ Title = "Auto Slap Battle" }, function(...) end)

FishingSection.CreateLabel({ Title = "Label" })

FishingSection.CreateButton({ Title = "Save Position Fishing" }, function(...) end)

FishingSection.CreateDropdown({ Title = "Select Bait" }, function(...) end)

FishingSection.CreateLabel({ Title = "Status Fishing :" })

FishingSection.CreateToggle({ Title = "Auto Tween To Event Fishing Spot" }, function(...) end)

FishingSection.CreateToggle({ Title = "Auto Fishing" }, function(...) end)

FishingSection.CreateToggle({ Title = "Auto Sell Fishing" }, function(...) end)

FishingSection.CreateToggle({ Title = "Auto Open Chest" }, function(...) end)

FishingSection.CreateDropdown({ Title = "Select Quest Fishing" }, function(...) end)

FishingSection.CreateToggle({ Title = "Auto Accept Quest Fishing" }, function(...) end)

AttackAllMobSection.CreateToggle({ Title = "Auto Attack All Mob and Boss" }, function(...) end)

QuestDragonSection.CreateToggle({ Title = "Auto Quest Dojo Trainer" }, function(...) end)

QuestDragonSection.CreateToggle({ Title = "Auto Quest Dragon Hunter" }, function(...) end)

BerrySection.CreateToggle({ Title = "Hop Find Berry" }, function(...) end)

BerrySection.CreateToggle({ Title = "Auto Collect Berry" }, function(...) end)

FarmChestSection.CreateSlider({ Title = "Value Collect Chest to Hop" }, function(...) end)

FarmChestSection.CreateToggle({ Title = "Auto Chest Hop" }, function(...) end)

FarmChestSection.CreateToggle({ Title = "Use Method Teleport [ Risk ]" }, function(...) end)

FarmChestSection.CreateToggle({ Title = "Auto Chest" }, function(...) end)

RaidLawSection.CreateToggle({ Title = "Auto Buy Chip and Attack Law" }, function(...) end)

FarmObservationSection.CreateToggle({ Title = "Auto UP Observation V2" }, function(...) end)

FarmObservationSection.CreateToggle({ Title = "Farm Observation" }, function(...) end)

FarmObservationSection.CreateToggle({ Title = "Farm Observation [ Hop Server ]" }, function(...) end)

AutoKillMobSection.CreateDropdown({ Title = "Select Mob" }, function(...) end)

AutoKillMobSection.CreateToggle({ Title = "Kill Mob" }, function(...) end)

AutoKillBossSection.CreateDropdown({ Title = "Select Boss" }, function(...) end)

AutoKillBossSection.CreateButton({ Title = "Refresh Boss" }, function(...) end)

AutoKillBossSection.CreateToggle({ Title = "Kill Boss" }, function(...) end)

AutoKillBossSection.CreateToggle({ Title = "Kill All Boss" }, function(...) end)

AutoKillBossSection.CreateToggle({ Title = "Hop Server Find Boss" }, function(...) end)

DevilFruitSection.CreateToggle({ Title = "Random Devil Fruit" }, function(...) end)

DevilFruitSection.CreateToggle({ Title = "Auto Store Fruit" }, function(...) end)

DevilFruitSection.CreateDropdown({ Title = "Blox Fruit Sniper Shop" }, function(...) end)

DevilFruitSection.CreateToggle({ Title = "Buy Blox Fruit Sniper Shop" }, function(...) end)

RaidsSection.CreateDropdown({ Title = "Select Raid" }, function(...) end)

RaidsSection.CreateToggle({ Title = "Get Fruit In Inventory Low Beli" }, function(...) end)

RaidsSection.CreateToggle({ Title = "Auto Raid" }, function(...) end)

RaidsSection.CreateToggle({ Title = "Hop Sever Raid" }, function(...) end)

RaidsSection.CreateToggle({ Title = "Auto Awake Fruit" }, function(...) end)

MultiRaidsSection.CreateDropdown({ Title = "Select Player Multi Raid" }, function(...) end)

MultiRaidsSection.CreateButton({ Title = "Refresh Player" }, function(...) end)

MultiRaidsSection.CreateToggle({ Title = "Account Buy Chip" }, function(...) end)

MultiRaidsSection.CreateToggle({ Title = "Account Pick Slot Raid" }, function(...) end)

MultiRaidsSection.CreateToggle({ Title = "Auto Multi Raid" }, function(...) end)

DungeonJoinSection.CreateDropdown({ Title = "Select Account Join" }, function(...) end)

DungeonJoinSection.CreateButton({ Title = "Refresh Player" }, function(...) end)

DungeonJoinSection.CreateSlider({ Title = "Min Player Join Dungeon" }, function(...) end)

DungeonJoinSection.CreateDropdown({ Title = "Select Difficulty" }, function(...) end)

DungeonJoinSection.CreateToggle({ Title = "Account Start Dungeon" }, function(...) end)

DungeonJoinSection.CreateToggle({ Title = "Auto Join Dungeon" }, function(...) end)

DungeonSection.CreateDropdown({ Title = "Select Weapon Dungeon" }, function(...) end)

DungeonSection.CreateDropdown({ Title = "Select Card Priority" }, function(...) end)

DungeonSection.CreateToggle({ Title = "Auto Attack Dungeon" }, function(...) end)

DungeonSection.CreateToggle({ Title = "Auto Pick Card Dungeon" }, function(...) end)

SettingSeaEventSection.CreateDropdown({ Title = "Select Zone" }, function(...) end)

SettingSeaEventSection.CreateDropdown({ Title = "Select Sea Events" }, function(...) end)

SettingSeaEventSection.CreateDropdown({ Title = "Select Boat" }, function(...) end)

SettingSeaEventSection.CreateDropdown({ Title = "Select Weapons Use Skill" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Use Dragonstorm For Sea Event" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Use Click M1 Skull Guitar For Sea Event" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Auto Change Dragonstorm With Skull Guitar" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Auto Change Dragonstorm When Kill Boat" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Use Click M1 Fruit For Sea Event" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Reset Character Buy Boat" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Auto Dodge Skill Terrorshark" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Auto Dodge Skill Seabeast" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Teleport Boat Other CFrame if Rough Sea" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Tween Until Have Sea Event" }, function(...) end)

SettingSeaEventSection.CreateToggle({ Title = "Will Back When over 10km" }, function(...) end)

FarmingSeaEventSection.CreateDropdown({ Title = "Select Friend" }, function(...) end)

FarmingSeaEventSection.CreateButton({ Title = "Refresh Player" }, function(...) end)

FarmingSeaEventSection.CreateToggle({ Title = "Auto Sea Event With Friend" }, function(...) end)

FarmingSeaEventSection.CreateToggle({ Title = "Auto Repair Ur Ship" }, function(...) end)

FarmingSeaEventSection.CreateToggle({ Title = "Auto Sea Event" }, function(...) end)

FarmingSeaEventSection.CreateToggle({ Title = "Auto Find Mirage" }, function(...) end)

KitsuneEventSection.CreateToggle({ Title = "Teleport To Kitsune Island" }, function(...) end)

KitsuneEventSection.CreateToggle({ Title = "Hop Server [ Next Night or Near Full Moon > 2m ]" }, function(...) end)

KitsuneEventSection.CreateToggle({ Title = "Auto Spawn Kitsune Island" }, function(...) end)

KitsuneEventSection.CreateToggle({ Title = "Auto Summon Soul Ember" }, function(...) end)

KitsuneEventSection.CreateToggle({ Title = "Auto Collect Soul Ember" }, function(...) end)

KitsuneEventSection.CreateSlider({ Title = "Values Azure Ember" }, function(...) end)

KitsuneEventSection.CreateToggle({ Title = "Auto Trade Azure Ember" }, function(...) end)

LeviathanEventSection.CreateButton({ Title = "Buy Spy" }, function(...) end)

LeviathanEventSection.CreateButton({ Title = "Teleport your boat to current Position" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Buy Spy" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Buy Boat Beast Hunter" }, function(...) end)

LeviathanEventSection.CreateDropdown({ Title = "Select Owner Boat Find Leviathan" }, function(...) end)

LeviathanEventSection.CreateButton({ Title = "Refresh Player" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Multi Find Leviathan" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Find Leviathan" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Start Leviathan" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Destroy IDK" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Attack Multi Segments Leviathan" }, function(...) end)

LeviathanEventSection.CreateSlider({ Title = "Value Damage Multi Segments" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Attack Leviathan" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Use Click M1 Fruit Leviathan" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Use Click M1 Skull Guitar Leviathan" }, function(...) end)

LeviathanEventSection.CreateDropdown({ Title = "Select Owner Boat Beast Hunter Shoot Heart" }, function(...) end)

LeviathanEventSection.CreateButton({ Title = "Refresh Player" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Use Your Boat Beast Hunter" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Auto Fire Shoot Heart Leviathan" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Teleport Frozen Dimension" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Tween Boat To Frozen Dimension" }, function(...) end)

LeviathanEventSection.CreateSlider({ Title = "Speed Boat Auto Drive" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Drive Boat To Tiki" }, function(...) end)

LeviathanEventSection.CreateToggle({ Title = "Drive Boat To Hydra" }, function(...) end)

BoatSettingSection.CreateToggle({ Title = "Fly Boat" }, function(...) end)

BoatSettingSection.CreateSlider({ Title = "Value Speed Boat" }, function(...) end)

BoatSettingSection.CreateSlider({ Title = "Value Speed Tween Boat" }, function(...) end)

BoatSettingSection.CreateSlider({ Title = "Value Speed Fly Boat" }, function(...) end)

BoatSettingSection.CreateToggle({ Title = "Change Speed Boat" }, function(...) end)

RaceDracoSection.CreateToggle({ Title = "Auto Upgrade Race V2-V3 Draco" }, function(...) end)

RaceDracoSection.CreateLabel({ Title = "Acient One Draco Status" })

RaceDracoSection.CreateToggle({ Title = "Auto Trial Draco" }, function(...) end)

RaceDracoSection.CreateToggle({ Title = "Fully Trial Draco" }, function(...) end)

RaceDracoSection.CreateToggle({ Title = "Ignore Craft Volcanic Magnet [ Fully Draco ]" }, function(...) end)

RaceDracoSection.CreateToggle({ Title = "Auto Buy Gear Draco" }, function(...) end)

RaceDracoSection.CreateToggle({ Title = "Auto Finish Train Draco Quest" }, function(...) end)

RaceNormalSection.CreateToggle({ Title = "Auto Upgrade Race V2-V3" }, function(...) end)

RaceNormalSection.CreateToggle({ Title = "Auto Get Fully Cyborg" }, function(...) end)

RaceNormalSection.CreateToggle({ Title = "Auto Get Cyborg Hop Collect Chest" }, function(...) end)

RaceNormalSection.CreateToggle({ Title = "Auto Get Cyborg" }, function(...) end)

RaceNormalSection.CreateToggle({ Title = "Hop Server Find Boss Cursed Captain" }, function(...) end)

RaceNormalSection.CreateToggle({ Title = "Auto Get Ghoul" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "No Frog" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Teleport Acient Clock" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Buy Gear" }, function(...) end)

RaceV4Section.CreateDropdown({ Title = "Select Gear V4" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Choose Gears" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Finish Train Quest" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Stack Train With Trial Race" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Hop Server [Trial Or Pull Lever]" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Pull Lever" }, function(...) end)

RaceV4Section.CreateDropdown({ Title = "Select Players Multi" }, function(...) end)

RaceV4Section.CreateButton({ Title = "Refresh Player" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Multi Trial" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Reset Character" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Trial" }, function(...) end)

RaceV4Section.CreateToggle({ Title = "Auto Turn On V3 Near Door" }, function(...) end)

KillTrialSection.CreateDropdown({ Title = "Select Weapon Attack Trial" }, function(...) end)

KillTrialSection.CreateToggle({ Title = "Kill players When complete Trial" }, function(...) end)

KillTrialSection.CreateToggle({ Title = "Use Skill when Kill Player" }, function(...) end)

KillTrialSection.CreateToggle({ Title = "Just Use Skill when Player Active Ken" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Trade Bone" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Buy Legendary Sword" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Buy Haki Color" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Hop Server [ Haki color or Legendary Sword]" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Get Rainbow Haki" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Soul Guitar" }, function(...) end)

GetItemsSection.CreateDropdown({ Title = "Select Method Hop CDK" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto CDK" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Yama" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Tushita" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto TTK" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Saber" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Craft Item Shark Anchor" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Yoru Mini" }, function(...) end)

GetItemsSection.CreateToggle({ Title = "Auto Yoru Mini (Hop Server)" }, function(...) end)

MasteryWeaponSection.CreateToggle({ Title = "Auto Farm Mastery 600 Melees" }, function(...) end)

MasteryWeaponSection.CreateToggle({ Title = "Auto Farm Mastery 600 Sword In Inventory" }, function(...) end)

UpgradeWeaponSection.CreateLabel({ Title = "" })

UpgradeWeaponSection.CreateToggle({ Title = "Auto Upgrade Sword Inventory" }, function(...) end)

UpgradeWeaponSection.CreateToggle({ Title = "Auto Upgrade Gun Inventory" }, function(...) end)

SettingsVolcanoSection.CreateDropdown({ Title = "Select Weapon Kill Golem" }, function(...) end)

SettingsVolcanoSection.CreateDropdown({ Title = "Select Weapons Fix Lava" }, function(...) end)

SettingsVolcanoSection.CreateDropdown({ Title = "Select Method Kill Golem" }, function(...) end)

FarmingVolcanoSection.CreateToggle({ Title = "Auto Crafting Volcanic Magnet" }, function(...) end)

FarmingVolcanoSection.CreateToggle({ Title = "Auto Find Prehistoric Island" }, function(...) end)

FarmingVolcanoSection.CreateToggle({ Title = "Auto Event Prehistoric Island" }, function(...) end)

FarmingVolcanoSection.CreateToggle({ Title = "Auto Collect Bone" }, function(...) end)

FarmingVolcanoSection.CreateToggle({ Title = "Auto Collect Egg" }, function(...) end)

FullyVolcanoSection.CreateToggle({ Title = "Ignore Craft Volcanic Magnet [ Fully ]" }, function(...) end)

FullyVolcanoSection.CreateToggle({ Title = "Ignore Collect Bone [ Fully ]" }, function(...) end)

FullyVolcanoSection.CreateToggle({ Title = "Fully Event Prehistoric Island" }, function(...) end)

ESPSection.CreateToggle({ Title = "ESP Berry" }, function(...) end)

ESPSection.CreateToggle({ Title = "ESP Island" }, function(...) end)

ESPSection.CreateToggle({ Title = "ESP Fruit" }, function(...) end)

ESPSection.CreateToggle({ Title = "ESP Player" }, function(...) end)

SettingsAimbotSection.CreateDropdown({ Title = "Select Player PVP" }, function(...) end)

SettingsAimbotSection.CreateDropdown({ Title = "Select Method Aimbot" }, function(...) end)

SettingsAimbotSection.CreateButton({ Title = "Refresh Player" }, function(...) end)

SettingsAimbotSection.CreateToggle({ Title = "Teleport Player" }, function(...) end)

SettingsAimbotSection.CreateToggle({ Title = "Auto Aimbot" }, function(...) end)

SettingsAimbotSection.CreateToggle({ Title = "Auto Aimbot Gun" }, function(...) end)

MISCPVPSection.CreateSlider({ Title = "Input WalkSpeed" }, function(...) end)

MISCPVPSection.CreateSlider({ Title = "Input JumpPower" }, function(...) end)

MISCPVPSection.CreateToggle({ Title = "Change JumpPower" }, function(...) end)

MISCPVPSection.CreateToggle({ Title = "Change WalkSpeed" }, function(...) end)

MISCPVPSection.CreateToggle({ Title = "Walk On Water" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Ping Everyone/Id Discord" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Noti Profile" }, function(...) end)

SectionWebhook.CreateDropdown({ Title = "Select Rarity Fruit" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Webhook Store Fruit" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Webhook Find Prehistoric Island" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Webhook Find Leviathan" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Webhook Destroy IDK" }, function(...) end)

SectionWebhook.CreateToggle({ Title = "Webhook Find Mirage" }, function(...) end)

a.CreateToggle({ Title = "White Screen" }, function(...) end)

a.CreateToggle({ Title = "Black Screen" }, function(...) end)

a.CreateToggle({ Title = "Remove Notifications" }, function(...) end)

a.CreateToggle({ Title = "Auto rejoin Disconnect" }, function(...) end)

a.CreateToggle({ Title = "Auto Load Script" }, function(...) end)

a.CreateToggle({ Title = "Boost Fps" }, function(...) end)

a.CreateButton({ Title = "Copy Config" }, function(...) end)
