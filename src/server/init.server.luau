-- Server initialization script
-- Orchestrates all server-side systems

local RemoteEvents = require(script.Parent.systems.RemoteEvents)
local GameSimulation = require(script.Parent.systems.GameSimulation)

print("🖥️  Server initialized - State of Nations")

-- Setup all remote events
RemoteEvents.setup()

-- Start the game simulation
GameSimulation.start()
