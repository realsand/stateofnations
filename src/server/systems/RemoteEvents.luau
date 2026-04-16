-- RemoteEvents.luau
-- Manages all RemoteEvents for server-client communication

local GameState = require(game.ReplicatedStorage.Shared.GameState)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")

local RemoteEvents = {}

function RemoteEvents.setup()
	-- Color palette for teams
	local teamColors = {
		BrickColor.new("Bright red"),
		BrickColor.new("Bright blue"),
		BrickColor.new("Bright green"),
		BrickColor.new("Bright yellow"),
		BrickColor.new("Bright magenta"),
		BrickColor.new("Cyan"),
		BrickColor.new("Bright orange"),
		BrickColor.new("Brown"),
		BrickColor.new("Dark stone grey"),
		BrickColor.new("Medium stone grey"),
	}

	-- Create or find teams for each country
	local function ensureTeams()
		local colorIndex = 1
		local teamsCreated = 0
		for countryName, _ in pairs(GameState.Countries) do
			local team = Teams:FindFirstChild(countryName)
			if not team then
				team = Instance.new("Team")
				team.Name = countryName
				team.TeamColor = teamColors[colorIndex]
				team.Parent = Teams
				teamsCreated = teamsCreated + 1
				colorIndex = colorIndex + 1
				if colorIndex > #teamColors then
					colorIndex = 1
				end
			end
		end
		print("✓ Teams initialized - Created: " .. teamsCreated .. ", Total: " .. #Teams:GetChildren())
	end

	ensureTeams()

	-- CreateUpdateStats event for broadcasting stat updates
	local UpdateEvent = Instance.new("RemoteEvent")
	UpdateEvent.Name = "UpdateStats"
	UpdateEvent.Parent = ReplicatedStorage

	-- Create StartBill event for bill submission
	local StartBillEvent = Instance.new("RemoteEvent")
	StartBillEvent.Name = "StartBill"
	StartBillEvent.Parent = ReplicatedStorage

	-- Create BillComplete event for game notifications
	local BillCompleteEvent = Instance.new("RemoteEvent")
	BillCompleteEvent.Name = "BillComplete"
	BillCompleteEvent.Parent = ReplicatedStorage

	-- Create SelectCountry event for country selection
	local SelectCountryEvent = Instance.new("RemoteEvent")
	SelectCountryEvent.Name = "SelectCountry"
	SelectCountryEvent.Parent = ReplicatedStorage

	-- Handle country selection from clients
	SelectCountryEvent.OnServerEvent:Connect(function(player, countryName)
		print("🌍 Country selection received from " .. player.Name .. ": " .. countryName)
		if GameState.Countries[countryName] then
			-- Update player's country in GameState
			GameState.Player.Country = countryName
			print("📍 Updated GameState to: " .. countryName)

			-- Assign player to the country's team
			local team = Teams:FindFirstChild(countryName)
			print("🔍 Looking for team: " .. countryName .. " - Found: " .. tostring(team ~= nil))
			
			if team then
				print("📋 Team found, assigning player...")
				player.Team = team
				print("✓ Player " .. player.Name .. " assigned to team: " .. countryName)
				print("  Team color: " .. team.TeamColor.Name)
			else
				print("✗ Team not found for: " .. countryName)
				print("  Available teams: " .. table.concat(Teams:GetChildren(), ", "))
			end

			-- Notify client that selection was successful
			BillCompleteEvent:FireClient(player, "COUNTRY_SELECTED", countryName)
		else
			print("✗ Invalid country selection: " .. countryName)
		end
	end)

	-- Handle bill submission from clients
	StartBillEvent.OnServerEvent:Connect(function(player, billType)
		if not GameState.ActiveBill and GameState.BillTypes[billType] then
			GameState.ActiveBill = {
				type = billType,
				effects = GameState.BillTypes[billType],
				startTime = os.time(),
				duration = GameState.BillTypes[billType].duration
			}
			print("📋 Bill enacted: " .. billType)
			BillCompleteEvent:FireAllClients("BILL_STARTED", billType)
		else
			print("✗ Cannot start bill - one already active")
		end
	end)

	return UpdateEvent, StartBillEvent, BillCompleteEvent
end

return RemoteEvents