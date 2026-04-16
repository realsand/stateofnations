-- UIManager.luau
-- Manages the in-game UI for State of Nations

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameState = require(game.ReplicatedStorage.Shared.GameState)

local UIManager = {}

-- Create country selection UI
function UIManager.createCountrySelect(screenGui)
	-- Country Select Frame
	local countrySelectFrame = Instance.new("Frame")
	countrySelectFrame.Name = "CountrySelect"
	countrySelectFrame.Size = UDim2.new(1, 0, 1, 0)
	countrySelectFrame.Position = UDim2.new(0, 0, 0, 0)
	countrySelectFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	countrySelectFrame.BackgroundTransparency = 0
	countrySelectFrame.Parent = screenGui

	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
	titleLabel.Position = UDim2.new(0, 0, 0.05, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "Select Your Country"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextScaled = true
	titleLabel.TextSize = 40
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Parent = countrySelectFrame

	-- Scroll frame for buttons
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ScrollFrame"
	scrollFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
	scrollFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
	scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	scrollFrame.BackgroundTransparency = 0.3
	scrollFrame.ScrollBarThickness = 15
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrollFrame.Parent = countrySelectFrame

	-- UIGridLayout for organizing country buttons
	local gridLayout = Instance.new("UIGridLayout")
	gridLayout.CellSize = UDim2.new(0.25, 0, 0.1, 0)
	gridLayout.CellPadding = UDim2.new(0.01, 0, 0.01, 0)
	gridLayout.Parent = scrollFrame

	-- Get the select country event or create it
	local selectCountryEvent = ReplicatedStorage:WaitForChild("SelectCountry", 5) or Instance.new("RemoteEvent")
	if selectCountryEvent.Parent == nil then
		selectCountryEvent.Name = "SelectCountry"
		selectCountryEvent.Parent = ReplicatedStorage
	end

	-- Create buttons for each country
	local yIndex = 0
	for countryName, countryData in pairs(GameState.Countries) do
		local countryButton = Instance.new("TextButton")
		countryButton.Name = countryName
		countryButton.Size = UDim2.new(1, 0, 1, 0)
		countryButton.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
		countryButton.Text = countryName
		countryButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		countryButton.TextScaled = true
		countryButton.Font = Enum.Font.Gotham
		countryButton.Parent = scrollFrame

		-- Button click handler
		countryButton.MouseButton1Click:Connect(function()
			print("🖱️ Country button clicked: " .. countryName)
			selectCountryEvent:FireServer(countryName)
			print("🚀 Event fired to server for: " .. countryName)
			countrySelectFrame.Visible = false
		end)

		yIndex = yIndex + 1
	end

	-- Update scroll frame canvas size
	scrollFrame.CanvasSize = UDim2.new(0, 0, (math.ceil(yIndex / 4) * 0.12), 0)

	return countrySelectFrame
end

-- Update UI values (call this from server or local scripts)
function UIManager.updateStats(countries, player, year)
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local nationUI = playerGui:FindFirstChild("NationUI")
	if nationUI then
		local hud = nationUI:FindFirstChild("HUD")
		if hud then
			local country = countries[player.Country]
			if country then
				hud.GDP.Text = "GDP: $" .. country.GDP .. "B"
				hud.Unemployment.Text = "Unemployment: " .. country.Unemployment .. "%"
				hud.Immigration.Text = "Immigration: " .. country.Immigration
				hud.Approval.Text = "Approval: " .. country.Approval .. "%"
			end
		end
	end
end

return UIManager
