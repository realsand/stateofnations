-- UIController.luau
-- Client-side UI management and updates

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIManager = require(ReplicatedStorage.Shared.UIManager)
local GameState = require(ReplicatedStorage.Shared.GameState)

local UIController = {}

function UIController.initialize()
	print("🎮 State of Nations loaded!")
	
	-- Create the UI
	UIManager.createUI()
	
	-- Connect to server events
	local UpdateEvent = ReplicatedStorage:WaitForChild("UpdateStats")
	local BillEvent = ReplicatedStorage:WaitForChild("BillComplete")
	
	-- Handle stat updates from server
	UpdateEvent.OnClientEvent:Connect(function(countries, player, year)
		UIManager.updateStats(countries, player, year)
	end)
	
	-- Handle game events from server
	BillEvent.OnClientEvent:Connect(function(eventType, ...)
		if eventType == "BILL_STARTED" then
			local billName = select(1, ...)
			print("📋 Bill enacted: " .. billName)
		elseif eventType == "BILL_PASSED" then
			local billName = select(1, ...)
			print("✓ Bill passed: " .. billName)
		elseif eventType == "ELECTION_HELD" then
			local result = select(1, ...)
			local approval = select(2, ...)
			print("🗳️ Election: " .. result .. " (Approval: " .. math.floor(approval) .. "%)")
		end
	end)
	
	-- Send initial update
	UIManager.updateStats(GameState.Countries, GameState.Player, GameState.CurrentYear)
end

return UIController