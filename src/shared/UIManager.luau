-- UIManager.luau
-- Manages the in-game UI for State of Nations

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameState = require(game.ReplicatedStorage.Shared.GameState)

local UIManager = {}

-- Create the main UI
function UIManager.createUI()
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	-- Main ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NationUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	-- HUD Frame
	local hudFrame = Instance.new("Frame")
	hudFrame.Name = "HUD"
	hudFrame.Size = UDim2.new(1, 0, 0.1, 0)
	hudFrame.Position = UDim2.new(0, 0, 0.9, 0)
	hudFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	hudFrame.BackgroundTransparency = 0.5
	hudFrame.Parent = screenGui

	-- GDP Label
	local gdpLabel = Instance.new("TextLabel")
	gdpLabel.Name = "GDP"
	gdpLabel.Size = UDim2.new(0.2, 0, 1, 0)
	gdpLabel.Position = UDim2.new(0, 0, 0, 0)
	gdpLabel.BackgroundTransparency = 1
	gdpLabel.Text = "GDP: $0B"
	gdpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	gdpLabel.TextScaled = true
	gdpLabel.Parent = hudFrame

	-- Unemployment Label
	local unempLabel = Instance.new("TextLabel")
	unempLabel.Name = "Unemployment"
	unempLabel.Size = UDim2.new(0.2, 0, 1, 0)
	unempLabel.Position = UDim2.new(0.2, 0, 0, 0)
	unempLabel.BackgroundTransparency = 1
	unempLabel.Text = "Unemployment: 0%"
	unempLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	unempLabel.TextScaled = true
	unempLabel.Parent = hudFrame

	-- Immigration Label
	local immLabel = Instance.new("TextLabel")
	immLabel.Name = "Immigration"
	immLabel.Size = UDim2.new(0.2, 0, 1, 0)
	immLabel.Position = UDim2.new(0.4, 0, 0, 0)
	immLabel.BackgroundTransparency = 1
	immLabel.Text = "Immigration: 0"
	immLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	immLabel.TextScaled = true
	immLabel.Parent = hudFrame

	-- Approval Label
	local apprLabel = Instance.new("TextLabel")
	apprLabel.Name = "Approval"
	apprLabel.Size = UDim2.new(0.2, 0, 1, 0)
	apprLabel.Position = UDim2.new(0.6, 0, 0, 0)
	apprLabel.BackgroundTransparency = 1
	apprLabel.Text = "Approval: 0%"
	apprLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
	apprLabel.TextScaled = true
	apprLabel.Parent = hudFrame

	-- Nation Management Panel (hidden by default)
	local nationPanel = Instance.new("Frame")
	nationPanel.Name = "NationPanel"
	nationPanel.Size = UDim2.new(0.5, 0, 0.5, 0)
	nationPanel.Position = UDim2.new(0.25, 0, 0.25, 0)
	nationPanel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	nationPanel.BackgroundTransparency = 0.2
	nationPanel.Visible = false
	nationPanel.Parent = screenGui

	local panelTitle = Instance.new("TextLabel")
	panelTitle.Size = UDim2.new(1, 0, 0.1, 0)
	panelTitle.BackgroundTransparency = 1
	panelTitle.Text = "Nation Management"
	panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	panelTitle.TextScaled = true
	panelTitle.Parent = nationPanel

	-- Close Button
	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
	closeButton.Position = UDim2.new(0.9, 0, 0, 0)
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeButton.Parent = nationPanel

	closeButton.MouseButton1Click:Connect(function()
		nationPanel.Visible = false
	end)

	-- Bill buttons
	local yPos = 0.2
	for billType, effects in pairs(GameState.BillTypes) do
		local billButton = Instance.new("TextButton")
		billButton.Size = UDim2.new(0.8, 0, 0.1, 0)
		billButton.Position = UDim2.new(0.1, 0, yPos, 0)
		billButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
		billButton.Text = billType
		billButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		billButton.Parent = nationPanel

		billButton.MouseButton1Click:Connect(function()
			local startBillEvent = ReplicatedStorage:FindFirstChild("StartBill") or Instance.new("RemoteEvent")
			startBillEvent.Name = "StartBill"
			startBillEvent.Parent = ReplicatedStorage
			startBillEvent:FireServer(billType)
			nationPanel.Visible = false
		end)

		yPos = yPos + 0.12
	end

	-- Settings Button
	local settingsButton = Instance.new("TextButton")
	settingsButton.Name = "Settings"
	settingsButton.Size = UDim2.new(0.1, 0, 0.8, 0)
	settingsButton.Position = UDim2.new(0.9, 0, 0.1, 0)
	settingsButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
	settingsButton.Text = "Settings"
	settingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	settingsButton.Parent = hudFrame

	settingsButton.MouseButton1Click:Connect(function()
		print("Settings button clicked")
		nationPanel.Visible = true
	end)

	return screenGui
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
