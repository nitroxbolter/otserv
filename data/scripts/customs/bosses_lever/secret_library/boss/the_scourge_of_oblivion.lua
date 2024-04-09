local config = {
    actionId = 27105, 
    bossName = "the scourge of oblivion",
    scourgeRoomOne = "Enhanced Fire Book",
    scourgeRoomTwo = "Enhanced Death Book",
    scourgeRoomThree = "Enhanced Electric Book", 
    scourgeRoomFour = "Enhanced Frosty Book",
    bossPosition = Position(863, 1549, 9), 
    scourgeRoomOnePosition = Position(844, 1530, 9), 
    scourgeRoomTwoPosition = Position(882, 1528, 9), 
    scourgeRoomThreePosition = Position(844, 1569, 9), 
    scourgeRoomFourPosition = Position(882, 1569, 9), 
    bossArea = {
        fromPos = Position(850, 1537, 9), 
        toPos = Position(877, 1562, 9), 
        entrancePos = Position(836, 1522, 9), 
        exitPosition = Position(814, 1553, 9) 
    },
    participantsAllowAnyCount = true, 
    participantsPos = {
        Position(813, 1557, 9),
        Position(813, 1558, 9),
        Position(813, 1559, 9), 
        Position(813, 1556, 9),
        Position(813, 1555, 9),
        Position(814, 1555, 9),
        Position(814, 1556, 9),
        Position(814, 1557, 9),
        Position(814, 1558, 9),
        Position(814, 1559, 9)
    },
    attempts = {
        level = 200, 
        storage = 720119, 
        seconds = 14400 -- 1 Day
    },
    createTeleportPos = Position(863, 1537, 9), 
    teleportToPosition = Position(814, 1553, 9), 
    teleportRemoveSeconds = 120, 
    kickParticipantAfterSeconds = 60 * 35, 
    leverIds = {1945, 1946},

    scourgeOneCreateTeleportPos = Position(852, 1538, 9),
    scourgeTwoCreateTeleportPos = Position(873, 1538, 9),
    scourgeThreeCreateTeleportPos = Position(852, 1562, 9),
    scourgeFourCreateTeleportPos = Position(873, 1562, 9),

    scourgeRoomOneTeleportPos = Position(890, 1522, 9),
    scourgeRoomTwoTeleportPos = Position(835, 1577, 9),
    scourgeRoomThreeTeleportPos = Position(890, 1577, 9),
    scourgeRoomFourTeleportPos = Position(863, 1562, 9),
}

local function getSpectators()
    if not config.centerPosition then
        config.diffX = math.ceil((config.bossArea.toPos.x - config.bossArea.fromPos.x) / 2)
        config.diffY = math.ceil((config.bossArea.toPos.y - config.bossArea.fromPos.y) / 2)
        config.centerPosition = config.bossArea.fromPos + Position(config.diffX, config.diffY, 0)
    end
    return Game.getSpectators(config.centerPosition, false, false, config.diffX, config.diffX, config.diffY, config.diffY)
end

local theScourgeAction = Action()

function theScourgeAction.onUse(player, item, fromPos, target, toPos, isHotkey)
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
                player:sendCancelMessage(string.format("The player %s must wait 4 hours before being able to enter again.", participant:getName()))
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
    local roomOne = Game.createMonster(config.scourgeRoomOne, config.scourgeRoomOnePosition)
    local roomTwo = Game.createMonster(config.scourgeRoomTwo, config.scourgeRoomTwoPosition)
    local roomThree = Game.createMonster(config.scourgeRoomThree, config.scourgeRoomThreePosition)
    local roomFour = Game.createMonster(config.scourgeRoomFour, config.scourgeRoomFourPosition)
    if not boss then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    if not roomOne then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    if not roomTwo then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    if not roomThree then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    if not roomFour then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    boss:registerEvent("theScourgeSystemDeath")
    roomOne:registerEvent("enhancedFireBook")
    roomTwo:registerEvent("enhancedDeathBook")
    roomThree:registerEvent("enhancedElectricBook")
    roomFour:registerEvent("enhancedFrostyBook")
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

    item:transform(item:getId() == config.leverIds[1] and config.leverIds[2] or config.leverIds[1])
    return true
end

theScourgeAction:aid(config.actionId)
theScourgeAction:register()

local creatureEvent = CreatureEvent("theScourgeSystemDeath")

function creatureEvent.onDeath()
    stopEvent(config.kickEventId)
    local teleport = Game.createItem(1387, 1, config.createTeleportPos)
    if teleport then
        teleport:setDestination(config.teleportToPosition)
        addEvent(function ()
            local tile = Tile(config.createTeleportPos)
            if tile then
                local teleport = tile:getItemById(1387)
                if teleport then
                    teleport:remove()
                    config.teleportToPosition:sendMagicEffect(CONST_ME_POFF)
                end
            end

            for _, spectator in pairs(getSpectators()) do
                if spectator:isPlayer() then
                    spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                    spectator:teleportTo(config.teleportToPosition, false)
                    config.teleportToPosition:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end, config.teleportRemoveSeconds * 1000)
    end
    return true
end

creatureEvent:register()


local creatureEvent = CreatureEvent("enhancedFireBook")

function creatureEvent.onDeath()
    local teleport = Game.createItem(1387, 1, config.scourgeOneCreateTeleportPos)
    if teleport then
        teleport:setDestination(config.scourgeRoomOneTeleportPos)
        addEvent(function ()
            local tile = Tile(config.scourgeOneCreateTeleportPos)
            if tile then
                local teleport = tile:getItemById(1387)
                if teleport then
                    teleport:remove()
                    config.scourgeRoomOneTeleportPos:sendMagicEffect(CONST_ME_POFF)
                end
            end

            for _, spectator in pairs(getSpectators()) do
                if spectator:isPlayer() then
                    spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                    spectator:teleportTo(config.scourgeRoomOneTeleportPos, false)
                    config.scourgeRoomOneTeleportPos:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end, config.teleportRemoveSeconds * 1000)
    end
    return true
end

creatureEvent:register()

local creatureEvent = CreatureEvent("enhancedDeathBook")

function creatureEvent.onDeath()
    local teleport = Game.createItem(1387, 1, config.scourgeTwoCreateTeleportPos)
    if teleport then
        teleport:setDestination(config.scourgeRoomTwoTeleportPos)
        addEvent(function ()
            local tile = Tile(config.scourgeTwoCreateTeleportPos)
            if tile then
                local teleport = tile:getItemById(1387)
                if teleport then
                    teleport:remove()
                    config.scourgeRoomTwoTeleportPos:sendMagicEffect(CONST_ME_POFF)
                end
            end

            for _, spectator in pairs(getSpectators()) do
                if spectator:isPlayer() then
                    spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                    spectator:teleportTo(config.scourgeRoomTwoTeleportPos, false)
                    config.scourgeRoomTwoTeleportPos:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end, config.teleportRemoveSeconds * 1000)
    end
    return true
end

creatureEvent:register()

local creatureEvent = CreatureEvent("enhancedElectricBook")

function creatureEvent.onDeath()
    local teleport = Game.createItem(1387, 1, config.scourgeThreeCreateTeleportPos)
    if teleport then
        teleport:setDestination(config.scourgeRoomThreeTeleportPos)
        addEvent(function ()
            local tile = Tile(config.scourgeThreeCreateTeleportPos)
            if tile then
                local teleport = tile:getItemById(1387)
                if teleport then
                    teleport:remove()
                    config.scourgeRoomThreeTeleportPos:sendMagicEffect(CONST_ME_POFF)
                end
            end

            for _, spectator in pairs(getSpectators()) do
                if spectator:isPlayer() then
                    spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                    spectator:teleportTo(config.scourgeRoomThreeTeleportPos, false)
                    config.scourgeRoomThreeTeleportPos:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end, config.teleportRemoveSeconds * 1000)
    end
    return true
end

creatureEvent:register()


local creatureEvent = CreatureEvent("enhancedFrostyBook")

function creatureEvent.onDeath()
    local teleport = Game.createItem(1387, 1, config.scourgeFourCreateTeleportPos)
    if teleport then
        teleport:setDestination(config.scourgeRoomFourTeleportPos)
        addEvent(function ()
            local tile = Tile(config.scourgeFourCreateTeleportPos)
            if tile then
                local teleport = tile:getItemById(1387)
                if teleport then
                    teleport:remove()
                    config.scourgeRoomFourTeleportPos:sendMagicEffect(CONST_ME_POFF)
                end
            end

            for _, spectator in pairs(getSpectators()) do
                if spectator:isPlayer() then
                    spectator:getPosition():sendMagicEffect(CONST_ME_POFF)
                    spectator:teleportTo(config.scourgeRoomFourTeleportPos, false)
                    config.scourgeRoomFourTeleportPos:sendMagicEffect(CONST_ME_TELEPORT)
                end
            end
        end, config.teleportRemoveSeconds * 1000)
    end
    return true
end

creatureEvent:register()