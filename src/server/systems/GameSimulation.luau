-- GameSimulation.luau
-- Handles the core game simulation: stats updates, bills, elections

local GameState = require(game.ReplicatedStorage.Shared.GameState)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameSimulation = {}

-- Update country statistics each year
local function updateStats()
	for country, stats in pairs(GameState.Countries) do
		stats.GDP = stats.GDP + math.random(-50, 50)
		stats.Unemployment = math.max(0, math.min(100, stats.Unemployment + math.random(-2, 2)))
		stats.Immigration = math.max(0, stats.Immigration + math.random(-1, 1))
		stats.Approval = math.max(0, math.min(100, stats.Approval + math.random(-5, 5)))
	end
end

-- Process active bills and apply effects
local function processBill()
	if GameState.ActiveBill then
		local elapsed = os.time() - GameState.ActiveBill.startTime
		if elapsed >= GameState.ActiveBill.duration * GameState.YearDuration then
			local country = GameState.Countries[GameState.Player.Country]
			for stat, change in pairs(GameState.ActiveBill.effects) do
				if country[stat] then
					country[stat] = math.max(0, math.min(100, country[stat] + change))
				end
			end
			GameState.Player.BillsPassed = GameState.Player.BillsPassed + 1
			print("✓ Bill passed: " .. GameState.ActiveBill.type)
			
			local BillCompleteEvent = ReplicatedStorage:FindFirstChild("BillComplete")
			if BillCompleteEvent then
				BillCompleteEvent:FireAllClients("BILL_PASSED", GameState.ActiveBill.type)
			end
			GameState.ActiveBill = nil
		end
	end
end

-- Check for elections every 4 years
local function checkElection()
	if GameState.CurrentYear % 4 == 0 then
		local approval = GameState.Countries[GameState.Player.Country].Approval
		local result = "CLOSE_ELECTION"
		if approval > 60 then
			result = "LANDSLIDE_VICTORY"
		elseif approval < 40 then
			result = "DEFEAT"
		end
		print("🗳️ Election: " .. result .. " (Approval: " .. math.floor(approval) .. "%)")
		
		local BillCompleteEvent = ReplicatedStorage:FindFirstChild("BillComplete")
		if BillCompleteEvent then
			BillCompleteEvent:FireAllClients("ELECTION_HELD", result, approval)
		end
	end
end

-- Main simulation loop
function GameSimulation.start()
	local UpdateEvent = ReplicatedStorage:WaitForChild("UpdateStats")
	
	while true do
		wait(GameState.YearDuration)
		GameState.CurrentYear = GameState.CurrentYear + 1
		updateStats()
		processBill()
		checkElection()
		UpdateEvent:FireAllClients(GameState.Countries, GameState.Player, GameState.CurrentYear)
	end
end

return GameSimulation