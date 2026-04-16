-- RemoteEvents.luau
-- Manages all RemoteEvents for server-client communication

local GameState = require(game.ReplicatedStorage.Shared.GameState)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvents = {}

function RemoteEvents.setup()
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