-- UIManager.luau
-- Manages the in-game UI for State of Nations

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

	-- Population Label
	local popLabel = Instance.new("TextLabel")
	popLabel.Name = "Population"
	popLabel.Size = UDim2.new(0.2, 0, 1, 0)
	popLabel.Position = UDim2.new(0, 0, 0, 0)
	popLabel.BackgroundTransparency = 1
	popLabel.Text = "Population: 0"
	popLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	popLabel.TextScaled = true
	popLabel.Parent = hudFrame

	-- Money Label
	local moneyLabel = Instance.new("TextLabel")
	moneyLabel.Name = "Money"
	moneyLabel.Size = UDim2.new(0.2, 0, 1, 0)
	moneyLabel.Position = UDim2.new(0.2, 0, 0, 0)
	moneyLabel.BackgroundTransparency = 1
	moneyLabel.Text = "Money: $0"
	moneyLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
	moneyLabel.TextScaled = true
	moneyLabel.Parent = hudFrame

	-- Happiness Label
	local happyLabel = Instance.new("TextLabel")
	happyLabel.Name = "Happiness"
	happyLabel.Size = UDim2.new(0.2, 0, 1, 0)
	happyLabel.Position = UDim2.new(0.4, 0, 0, 0)
	happyLabel.BackgroundTransparency = 1
	happyLabel.Text = "Happiness: 50%"
	happyLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	happyLabel.TextScaled = true
	happyLabel.Parent = hudFrame

	-- Build Button
	local buildButton = Instance.new("TextButton")
	buildButton.Name = "Build"
	buildButton.Size = UDim2.new(0.1, 0, 0.8, 0)
	buildButton.Position = UDim2.new(0.8, 0, 0.1, 0)
	buildButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
	buildButton.Text = "Build"
	buildButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	buildButton.Parent = hudFrame

	buildButton.MouseButton1Click:Connect(function()
		print("Build button clicked")
		-- TODO: Open build menu
	end)

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
		-- TODO: Open settings panel
	end)

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

	-- Add more elements as needed

	return screenGui
end

-- Update UI values (call this from server or local scripts)
function UIManager.updateStats(population, money, happiness)
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local nationUI = playerGui:FindFirstChild("NationUI")
	if nationUI then
		local hud = nationUI:FindFirstChild("HUD")
		if hud then
			hud.Population.Text = "Population: " .. population
			hud.Money.Text = "Money: $" .. money
			hud.Happiness.Text = "Happiness: " .. happiness .. "%"
		end
	end
end

return UIManager