local playerKeyHistory = {}

-- record players key presses
function RecordPlayerKeys(playerId)
    local steamId, discordId = GetPlayerIdentifiers(playerId)
    local playerName = GetPlayerName(playerId)

    -- Initialize players key history if it doesn't exist
    if not playerKeyHistory[playerId] then
        playerKeyHistory[playerId] = {
            name = playerName,
            steamId = steamId,
            discordId = discordId,
            keyHistory = {}
        }
    end

    for key = 0, 349 do
        if IsControlPressed(1, key) then
            -- If the key is being pressed, add it to the player's key history
            table.insert(playerKeyHistory[playerId].keyHistory, GetControlInstructionalButton(1, key, true) .. " (held)")
        elseif IsControlJustReleased(1, key) then
            -- If the key has just been released, add it to the player's key history
            table.insert(playerKeyHistory[playerId].keyHistory, GetControlInstructionalButton(1, key, true))
        end
    end

    local directoryPath = "root folder/keypresses/" .. playerName
    EnsureDirectoryExists(directoryPath)

    local file = io.open(directoryPath .. "/keystrokes.txt", "w")
    for _, v in pairs(playerKeyHistory[playerId].keyHistory) do
        file:write(v .. "\n")
    end
    file:close()
end