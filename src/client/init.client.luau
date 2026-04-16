print("Hello world, from client!")

local UIManager = require(game.ReplicatedStorage.Shared.UIManager)
local GameState = require(game.ReplicatedStorage.Shared.GameState)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create the UI
UIManager.createUI()

-- Connect to update event
local updateEvent = ReplicatedStorage:WaitForChild("UpdateStats")
updateEvent.OnClientEvent:Connect(function(countries, player, year)
	UIManager.updateStats(countries, player, year)
end)

-- Initial update
UIManager.updateStats(GameState.Countries, GameState.Player, GameState.CurrentYear)
