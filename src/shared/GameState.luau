-- GameState.luau
-- Shared game state for State of Nations

local GameState = {}

-- Define countries
GameState.Countries = {
    ["USA"] = {
        GDP = 1000,  -- in billions
        Unemployment = 5,  -- percentage
        Immigration = 10,  -- rate
        Approval = 50,  -- percentage
    },
    ["China"] = {
        GDP = 1500,
        Unemployment = 3,
        Immigration = 5,
        Approval = 60,
    },
    ["Russia"] = {
        GDP = 500,
        Unemployment = 7,
        Immigration = 2,
        Approval = 40,
    },
}

-- Player data (for prototype, assume one player controls USA)
GameState.Player = {
    Country = "USA",
    Approval = 50,
    BillsPassed = 0,
}

-- Active bill
GameState.ActiveBill = nil  -- {type, startTime, duration}

-- Time
GameState.CurrentYear = 2024
GameState.YearDuration = 10  -- 10 seconds for testing, normally 8*60

-- Bill types
GameState.BillTypes = {
    ["Increase Taxes"] = {GDP = 100, Approval = -10, duration = 1},  -- 1 year
    ["Immigration Reform"] = {Immigration = 5, Unemployment = -2, duration = 1},
    ["Welfare Program"] = {Unemployment = -3, GDP = -50, Approval = 5, duration = 1},
}

return GameState