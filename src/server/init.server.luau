print("Hello world, from server!")

local GameState = require(game.ReplicatedStorage.Shared.GameState)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- RemoteEvent for updating clients
local UpdateEvent = Instance.new("RemoteEvent")
UpdateEvent.Name = "UpdateStats"
UpdateEvent.Parent = ReplicatedStorage

-- RemoteEvent for starting bills
local StartBillEvent = Instance.new("RemoteEvent")
StartBillEvent.Name = "StartBill"
StartBillEvent.Parent = ReplicatedStorage

StartBillEvent.OnServerEvent:Connect(function(player, billType)
	if not GameState.ActiveBill and GameState.BillTypes[billType] then
		GameState.ActiveBill = {
			type = billType,
			effects = GameState.BillTypes[billType],
			startTime = os.time(),
			duration = GameState.BillTypes[billType].duration
		}
		print("Bill started: " .. billType)
	end
end)

-- Function to update stats
local function updateStats()
    for country, stats in pairs(GameState.Countries) do
        -- Simulate changes
        stats.GDP = stats.GDP + math.random(-50, 50)
        stats.Unemployment = math.max(0, math.min(100, stats.Unemployment + math.random(-2, 2)))
        stats.Immigration = math.max(0, stats.Immigration + math.random(-1, 1))
        stats.Approval = math.max(0, math.min(100, stats.Approval + math.random(-5, 5)))
    end
    -- Fire event to clients
    UpdateEvent:FireAllClients(GameState.Countries, GameState.Player, GameState.CurrentYear)
end

-- Process active bill
local function processBill()
    if GameState.ActiveBill then
        local elapsed = os.time() - GameState.ActiveBill.startTime
        if elapsed >= GameState.ActiveBill.duration * GameState.YearDuration then
            -- Apply bill effects
            local country = GameState.Countries[GameState.Player.Country]
            for stat, change in pairs(GameState.ActiveBill.effects) do
                if country[stat] then
                    country[stat] = country[stat] + change
                end
            end
            GameState.Player.BillsPassed = GameState.Player.BillsPassed + 1
            GameState.ActiveBill = nil
            print("Bill passed!")
        end
    end
end

-- Election
local function checkElection()
    if GameState.CurrentYear % 4 == 0 then  -- Every 4 years
        local approval = GameState.Countries[GameState.Player.Country].Approval
        if approval > 60 then
            print("Election won! High approval.")
        elseif approval > 30 then
            print("Election close.")
        else
            print("Election lost! Low approval.")
        end
    end
end

-- Main loop
while true do
    wait(GameState.YearDuration)  -- Wait 1 year
    GameState.CurrentYear = GameState.CurrentYear + 1
    updateStats()
    processBill()
    checkElection()
end
