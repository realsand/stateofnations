-- GameState.luau
-- Shared game state for State of Nations

local GameState = {}

-- Define countries
GameState.Countries = {
    ["Albania"] = { GDP = 15, Unemployment = 11, Immigration = 3, Approval = 50 },
    ["Andorra"] = { GDP = 3, Unemployment = 4, Immigration = 8, Approval = 55 },
    ["Armenia"] = { GDP = 12, Unemployment = 18, Immigration = 5, Approval = 45 },
    ["Austria"] = { GDP = 516, Unemployment = 4, Immigration = 10, Approval = 60 },
    ["Azerbaijan"] = { GDP = 46, Unemployment = 6, Immigration = 2, Approval = 50 },
    ["Belarus"] = { GDP = 64, Unemployment = 4, Immigration = 3, Approval = 35 },
    ["Belgium"] = { GDP = 594, Unemployment = 6, Immigration = 12, Approval = 55 },
    ["Bosnia and Herzegovina"] = { GDP = 20, Unemployment = 15, Immigration = 2, Approval = 40 },
    ["Bulgaria"] = { GDP = 84, Unemployment = 4, Immigration = 5, Approval = 45 },
    ["Canada"] = { GDP = 2140, Unemployment = 5, Immigration = 25, Approval = 55 },
    ["Croatia"] = { GDP = 69, Unemployment = 7, Immigration = 8, Approval = 48 },
    ["Cyprus"] = { GDP = 28, Unemployment = 5, Immigration = 10, Approval = 50 },
    ["Czechia"] = { GDP = 281, Unemployment = 2, Immigration = 6, Approval = 58 },
    ["Denmark"] = { GDP = 405, Unemployment = 4, Immigration = 8, Approval = 65 },
    ["Estonia"] = { GDP = 38, Unemployment = 5, Immigration = 9, Approval = 60 },
    ["Finland"] = { GDP = 300, Unemployment = 7, Immigration = 6, Approval = 68 },
    ["France"] = { GDP = 2780, Unemployment = 8, Immigration = 12, Approval = 52 },
    ["Georgia"] = { GDP = 20, Unemployment = 10, Immigration = 1, Approval = 48 },
    ["Germany"] = { GDP = 4080, Unemployment = 3, Immigration = 14, Approval = 58 },
    ["Greece"] = { GDP = 219, Unemployment = 12, Immigration = 10, Approval = 45 },
    ["Hungary"] = { GDP = 177, Unemployment = 3, Immigration = 7, Approval = 52 },
    ["Iceland"] = { GDP = 25, Unemployment = 3, Immigration = 10, Approval = 65 },
    ["Ireland"] = { GDP = 529, Unemployment = 4, Immigration = 14, Approval = 60 },
    ["Italy"] = { GDP = 2010, Unemployment = 8, Immigration = 9, Approval = 48 },
    ["Kosovo"] = { GDP = 9, Unemployment = 25, Immigration = 2, Approval = 42 },
    ["Latvia"] = { GDP = 40, Unemployment = 7, Immigration = 5, Approval = 50 },
    ["Liechtenstein"] = { GDP = 7, Unemployment = 2, Immigration = 30, Approval = 65 },
    ["Lithuania"] = { GDP = 68, Unemployment = 7, Immigration = 4, Approval = 55 },
    ["Luxembourg"] = { GDP = 84, Unemployment = 6, Immigration = 47, Approval = 60 },
    ["Malta"] = { GDP = 18, Unemployment = 3, Immigration = 25, Approval = 58 },
    ["Moldova"] = { GDP = 16, Unemployment = 3, Immigration = 2, Approval = 38 },
    ["Monaco"] = { GDP = 7, Unemployment = 2, Immigration = 50, Approval = 65 },
    ["Montenegro"] = { GDP = 6, Unemployment = 15, Immigration = 5, Approval = 45 },
    ["Netherlands"] = { GDP = 1120, Unemployment = 4, Immigration = 12, Approval = 62 },
    ["North Macedonia"] = { GDP = 14, Unemployment = 16, Immigration = 3, Approval = 40 },
    ["Norway"] = { GDP = 598, Unemployment = 3, Immigration = 8, Approval = 70 },
    ["Poland"] = { GDP = 688, Unemployment = 3, Immigration = 4, Approval = 50 },
    ["Portugal"] = { GDP = 251, Unemployment = 6, Immigration = 8, Approval = 52 },
    ["Romania"] = { GDP = 301, Unemployment = 5, Immigration = 2, Approval = 45 },
    ["Russia"] = { GDP = 1860, Unemployment = 3, Immigration = 1, Approval = 40 },
    ["San Marino"] = { GDP = 2, Unemployment = 8, Immigration = 20, Approval = 55 },
    ["Serbia"] = { GDP = 68, Unemployment = 10, Immigration = 3, Approval = 42 },
    ["Slovakia"] = { GDP = 115, Unemployment = 6, Immigration = 5, Approval = 50 },
    ["Slovenia"] = { GDP = 69, Unemployment = 4, Immigration = 11, Approval = 58 },
    ["Spain"] = { GDP = 1390, Unemployment = 12, Immigration = 10, Approval = 50 },
    ["Sweden"] = { GDP = 605, Unemployment = 7, Immigration = 10, Approval = 65 },
    ["Switzerland"] = { GDP = 920, Unemployment = 4, Immigration = 28, Approval = 70 },
    ["Turkey"] = { GDP = 905, Unemployment = 8, Immigration = 5, Approval = 45 },
    ["Ukraine"] = { GDP = 202, Unemployment = 8, Immigration = 1, Approval = 52 },
    ["United Kingdom"] = { GDP = 3070, Unemployment = 4, Immigration = 11, Approval = 48 },
    ["United States"] = { GDP = 27360, Unemployment = 4, Immigration = 13, Approval = 50 },
}

-- Player data (for prototype, assume one player controls United States)
GameState.Player = {
    Country = "United States",
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