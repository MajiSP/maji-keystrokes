-- player id 
function GetPlayerIdentifiers(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    local steamId, discordId = nil, nil

    for _, v in pairs(identifiers) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamId = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordId = v
        end
    end

    return steamId, discordId
end

-- does directory exist, if not create
function DirectoryExists(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

-- create directory if it doesn't exist
function EnsureDirectoryExists(path)
    local exists, err = DirectoryExists(path)
    if exists == false then
        os.execute("mkdir -p " .. path)
    end
end