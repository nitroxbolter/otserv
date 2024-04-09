local config = {
    actionId = 33723, 
    bossName = "Srezz Yellow Eyes",
    bossPosition = Position(1719, 280, 9), 
    bossArea = {
        fromPos = Position(1714, 265, 9), 
        toPos = Position(1725, 283, 9), 
        entrancePos = Position(1719, 270, 9), 
        exitPosition = Position(1755, 266, 9) 
    },
    participantsAllowAnyCount = true, 
    participantsPos = {
        Position(1755, 268, 9),
    },
    attempts = {
        level = 100, 
        storage = 194508, 
        seconds = 14400 -- 4 h
    },
    kickParticipantAfterSeconds = 60 * 10, 
}

local function getSpectators()
    if not config.centerPosition then
        config.diffX = math.ceil((config.bossArea.toPos.x - config.bossArea.fromPos.x) / 2)
        config.diffY = math.ceil((config.bossArea.toPos.y - config.bossArea.fromPos.y) / 2)
        config.centerPosition = config.bossArea.fromPos + Position(config.diffX, config.diffY, 0)
    end
    return Game.getSpectators(config.centerPosition, false, false, config.diffX, config.diffX, config.diffY, config.diffY)
end

local srezzEyes = MoveEvent()

function srezzEyes.onStepIn(player, item, fromPosition, target, toPos, isHotkey)
    local participants = {}
    for index, pos in pairs(config.participantsPos) do
        local tile = Tile(pos)
        if not tile then error("[Warning - Tile not found]") end
        local participant = tile:getTopVisibleCreature(player)
        if participant and participant:isPlayer() then
            if index == 1 and participant ~= player then
                player:sendCancelMessage("Only the first participant can pull the lever.")
                return true
            end

            if participant:getStorageValue(config.attempts.storage) >= os.time() then
                player:sendCancelMessage(string.format("The player %s must wait 30 minuts before being able to enter again.", participant:getName()))
                return true
            elseif participant:getLevel() < config.attempts.level then
                player:sendCancelMessage(string.format("The player %s is not level %d.", participant:getName(), config.attempts.level))
                return true
            end
            participants[#participants +1] = participant    
        end
    end

    local spectators = getSpectators()
    for _, spectator in pairs(spectators) do
        if spectator:isPlayer() then
            player:sendCancelMessage("At this time the room is occupied, please try again later.")
            return true
        end
    end

    for _, spectator in pairs(spectators) do spectator:remove() end
    local boss = Game.createMonster(config.bossName, config.bossPosition)
    if not boss then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    for index, participant in pairs(participants) do
        config.participantsPos[index]:sendMagicEffect(CONST_ME_POFF)
        participant:teleportTo(config.bossArea.entrancePos, false)
        config.bossArea.entrancePos:sendMagicEffect(CONST_ME_TELEPORT)
        participant:setStorageValue(config.attempts.storage, os.time() + config.attempts.seconds)
    end

    config.kickEventId = addEvent(function ()
        for _, spectator in pairs(getSpectators()) do
            if spectator:isPlayer() then
                spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                spectator:teleportTo(config.bossArea.exitPosition, false)
                config.bossArea.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
                spectator:sendTextMessage(MESSAGE_INFO_DESCR, "It's been a long time and you haven't managed to defeat the boss.")
            else
                spectator:remove()
            end
        end
    end, config.kickParticipantAfterSeconds * 1000)
    return true
end

srezzEyes:aid(config.actionId)
srezzEyes:type("stepin")
srezzEyes:register()


local exit = MoveEvent()
function exit.onStepIn(player, item, fromPos, target, toPos, isHotkey)
    if not player then
        return false
    end
 player:teleportTo({x= 1755, y= 266, z= 9})
end

exit:aid(33724)
exit:type("stepin")
exit:register()



local config = {
    actionId = 33725, 
    bossName = "Yirkas blue scales",
    bossPosition = Position(1790, 287, 9), 
    bossArea = {
        fromPos = Position(1782, 269, 9), 
        toPos = Position(1799, 291, 9), 
        entrancePos = Position(1786, 276, 9), 
        exitPosition = Position(1763, 279, 9) 
    },
    participantsAllowAnyCount = true, 
    participantsPos = {
        Position(1763, 281, 9),
    },
    attempts = {
        level = 100, 
        storage = 194509, 
        seconds = 14400 -- 4h
    },
    kickParticipantAfterSeconds = 60 * 10, 
}

local function getSpectators()
    if not config.centerPosition then
        config.diffX = math.ceil((config.bossArea.toPos.x - config.bossArea.fromPos.x) / 2)
        config.diffY = math.ceil((config.bossArea.toPos.y - config.bossArea.fromPos.y) / 2)
        config.centerPosition = config.bossArea.fromPos + Position(config.diffX, config.diffY, 0)
    end
    return Game.getSpectators(config.centerPosition, false, false, config.diffX, config.diffX, config.diffY, config.diffY)
end

local yirkasBlue = MoveEvent()

function yirkasBlue.onStepIn(player, item, fromPosition, target, toPos, isHotkey)
    local participants = {}
    for index, pos in pairs(config.participantsPos) do
        local tile = Tile(pos)
        if not tile then error("[Warning - Tile not found]") end
        local participant = tile:getTopVisibleCreature(player)
        if participant and participant:isPlayer() then
            if index == 1 and participant ~= player then
                player:sendCancelMessage("Only the first participant can pull the lever.")
                return true
            end

            if participant:getStorageValue(config.attempts.storage) >= os.time() then
                player:sendCancelMessage(string.format("The player %s must wait 30 minuts before being able to enter again.", participant:getName()))
                return true
            elseif participant:getLevel() < config.attempts.level then
                player:sendCancelMessage(string.format("The player %s is not level %d.", participant:getName(), config.attempts.level))
                return true
            end
            participants[#participants +1] = participant    
        end
    end

    local spectators = getSpectators()
    for _, spectator in pairs(spectators) do
        if spectator:isPlayer() then
            player:sendCancelMessage("At this time the room is occupied, please try again later.")
            return true
        end
    end

    for _, spectator in pairs(spectators) do spectator:remove() end
    local boss = Game.createMonster(config.bossName, config.bossPosition)
    if not boss then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    for index, participant in pairs(participants) do
        config.participantsPos[index]:sendMagicEffect(CONST_ME_POFF)
        participant:teleportTo(config.bossArea.entrancePos, false)
        config.bossArea.entrancePos:sendMagicEffect(CONST_ME_TELEPORT)
        participant:setStorageValue(config.attempts.storage, os.time() + config.attempts.seconds)
    end

    config.kickEventId = addEvent(function ()
        for _, spectator in pairs(getSpectators()) do
            if spectator:isPlayer() then
                spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                spectator:teleportTo(config.bossArea.exitPosition, false)
                config.bossArea.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
                spectator:sendTextMessage(MESSAGE_INFO_DESCR, "It's been a long time and you haven't managed to defeat the boss.")
            else
                spectator:remove()
            end
        end
    end, config.kickParticipantAfterSeconds * 1000)
    return true
end

yirkasBlue:aid(config.actionId)
yirkasBlue:type("stepin")
yirkasBlue:register()


local exit = MoveEvent()
function exit.onStepIn(player, item, fromPos, target, toPos, isHotkey)
    if not player then
        return false
    end
 player:teleportTo({x= 1763, y= 279, z= 9})
end

exit:aid(33726)
exit:type("stepin")
exit:register()



local config = {
    actionId = 33727, 
    bossName = "katex blood tongue",
    bossPosition = Position(1784, 320, 9), 
    bossArea = {
        fromPos = Position(1776, 307, 9), 
        toPos = Position(1793, 324, 9), 
        entrancePos = Position(1780, 314, 9), 
        exitPosition = Position(1755, 292, 9) 
    },
    participantsAllowAnyCount = true, 
    participantsPos = {
        Position(1755, 294, 9),
    },
    attempts = {
        level = 100, 
        storage = 194510, 
        seconds = 14400 -- 4 h
    },
    kickParticipantAfterSeconds = 60 * 10, 
}

local function getSpectators()
    if not config.centerPosition then
        config.diffX = math.ceil((config.bossArea.toPos.x - config.bossArea.fromPos.x) / 2)
        config.diffY = math.ceil((config.bossArea.toPos.y - config.bossArea.fromPos.y) / 2)
        config.centerPosition = config.bossArea.fromPos + Position(config.diffX, config.diffY, 0)
    end
    return Game.getSpectators(config.centerPosition, false, false, config.diffX, config.diffX, config.diffY, config.diffY)
end

local katex = MoveEvent()

function katex.onStepIn(player, item, fromPosition, target, toPos, isHotkey)
    local participants = {}
    for index, pos in pairs(config.participantsPos) do
        local tile = Tile(pos)
        if not tile then error("[Warning - Tile not found]") end
        local participant = tile:getTopVisibleCreature(player)
        if participant and participant:isPlayer() then
            if index == 1 and participant ~= player then
                player:sendCancelMessage("Only the first participant can pull the lever.")
                return true
            end

            if participant:getStorageValue(config.attempts.storage) >= os.time() then
                player:sendCancelMessage(string.format("The player %s must wait 30 minuts before being able to enter again.", participant:getName()))
                return true
            elseif participant:getLevel() < config.attempts.level then
                player:sendCancelMessage(string.format("The player %s is not level %d.", participant:getName(), config.attempts.level))
                return true
            end
            participants[#participants +1] = participant    
        end
    end

    local spectators = getSpectators()
    for _, spectator in pairs(spectators) do
        if spectator:isPlayer() then
            player:sendCancelMessage("At this time the room is occupied, please try again later.")
            return true
        end
    end

    for _, spectator in pairs(spectators) do spectator:remove() end
    local boss = Game.createMonster(config.bossName, config.bossPosition)
    if not boss then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    for index, participant in pairs(participants) do
        config.participantsPos[index]:sendMagicEffect(CONST_ME_POFF)
        participant:teleportTo(config.bossArea.entrancePos, false)
        config.bossArea.entrancePos:sendMagicEffect(CONST_ME_TELEPORT)
        participant:setStorageValue(config.attempts.storage, os.time() + config.attempts.seconds)
    end

    config.kickEventId = addEvent(function ()
        for _, spectator in pairs(getSpectators()) do
            if spectator:isPlayer() then
                spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                spectator:teleportTo(config.bossArea.exitPosition, false)
                config.bossArea.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
                spectator:sendTextMessage(MESSAGE_INFO_DESCR, "It's been a long time and you haven't managed to defeat the boss.")
            else
                spectator:remove()
            end
        end
    end, config.kickParticipantAfterSeconds * 1000)
    return true
end

katex:aid(config.actionId)
katex:type("stepin")
katex:register()


local exit = MoveEvent()
function exit.onStepIn(player, item, fromPos, target, toPos, isHotkey)
    if not player then
        return false
    end
 player:teleportTo({x= 1755, y= 292, z= 9})
end

exit:aid(33728)
exit:type("stepin")
exit:register()


local config = {
    actionId = 33729, 
    bossName = "Utua stone sting",
    bossPosition = Position(1753, 315, 9), 
    bossArea = {
        fromPos = Position(1746, 303, 9), 
        toPos = Position(1761, 321, 9), 
        entrancePos = Position(1751, 309, 9), 
        exitPosition = Position(1746, 279, 9) 
    },
    participantsAllowAnyCount = true, 
    participantsPos = {
        Position(1746, 281, 9),
    },
    attempts = {
        level = 100, 
        storage = 194511, 
        seconds = 14400 -- 4 h
    },
    kickParticipantAfterSeconds = 60 * 10, 
}

local function getSpectators()
    if not config.centerPosition then
        config.diffX = math.ceil((config.bossArea.toPos.x - config.bossArea.fromPos.x) / 2)
        config.diffY = math.ceil((config.bossArea.toPos.y - config.bossArea.fromPos.y) / 2)
        config.centerPosition = config.bossArea.fromPos + Position(config.diffX, config.diffY, 0)
    end
    return Game.getSpectators(config.centerPosition, false, false, config.diffX, config.diffX, config.diffY, config.diffY)
end

local utua = MoveEvent()

function utua.onStepIn(player, item, fromPosition, target, toPos, isHotkey)
    local participants = {}
    for index, pos in pairs(config.participantsPos) do
        local tile = Tile(pos)
        if not tile then error("[Warning - Tile not found]") end
        local participant = tile:getTopVisibleCreature(player)
        if participant and participant:isPlayer() then
            if index == 1 and participant ~= player then
                player:sendCancelMessage("Only the first participant can pull the lever.")
                return true
            end

            if participant:getStorageValue(config.attempts.storage) >= os.time() then
                player:sendCancelMessage(string.format("The player %s must wait 30 minuts before being able to enter again.", participant:getName()))
                return true
            elseif participant:getLevel() < config.attempts.level then
                player:sendCancelMessage(string.format("The player %s is not level %d.", participant:getName(), config.attempts.level))
                return true
            end
            participants[#participants +1] = participant    
        end
    end

    local spectators = getSpectators()
    for _, spectator in pairs(spectators) do
        if spectator:isPlayer() then
            player:sendCancelMessage("At this time the room is occupied, please try again later.")
            return true
        end
    end

    for _, spectator in pairs(spectators) do spectator:remove() end
    local boss = Game.createMonster(config.bossName, config.bossPosition)
    if not boss then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    for index, participant in pairs(participants) do
        config.participantsPos[index]:sendMagicEffect(CONST_ME_POFF)
        participant:teleportTo(config.bossArea.entrancePos, false)
        config.bossArea.entrancePos:sendMagicEffect(CONST_ME_TELEPORT)
        participant:setStorageValue(config.attempts.storage, os.time() + config.attempts.seconds)
    end

    config.kickEventId = addEvent(function ()
        for _, spectator in pairs(getSpectators()) do
            if spectator:isPlayer() then
                spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                spectator:teleportTo(config.bossArea.exitPosition, false)
                config.bossArea.exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
                spectator:sendTextMessage(MESSAGE_INFO_DESCR, "It's been a long time and you haven't managed to defeat the boss.")
            else
                spectator:remove()
            end
        end
    end, config.kickParticipantAfterSeconds * 1000)
    return true
end

utua:aid(config.actionId)
utua:type("stepin")
utua:register()


local exit = MoveEvent()
function exit.onStepIn(player, item, fromPos, target, toPos, isHotkey)
    if not player then
        return false
    end
 player:teleportTo({x= 1746, y= 279, z= 9})
end

exit:aid(33730)
exit:type("stepin")
exit:register()