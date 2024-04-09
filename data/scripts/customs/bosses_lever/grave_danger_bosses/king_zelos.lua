local config = {
    actionId = 42586, 
    bossName = "king zelos",
    miniBossOne = "magnor mournbringer",
    miniBossTwo = "nargol the impaler",
    miniBossThree = "the red knight",
    miniBossFour = "rewar the bloody",
    bossPosition = Position(848, 527, 9), 
    minibossOnePosition = Position(868, 510, 9), 
    minibossTwoPosition = Position(828, 510, 9), 
    minibossThreePosition = Position(828, 543, 9), 
    minibossFourPosition = Position(868, 543, 9), 
    bossArea = {
        fromPos = Position(815, 498, 9), 
        toPos = Position(879, 560, 9), 
        entrancePos = Position(868, 526, 9), 
        exitPosition = Position(895, 527, 9) 
    },
    participantsAllowAnyCount = true, 
    participantsPos = {
        Position(890, 527, 9),
        Position(890, 528, 9),
        Position(890, 529, 9), 
        Position(890, 526, 9),
        Position(890, 525, 9),
        Position(891, 529, 9),
        Position(891, 528, 9),
        Position(891, 527, 9),
        Position(891, 526, 9),
        Position(891, 525, 9)
    },
    attempts = {
        level = 100, 
        storage = 739428, 
        seconds = 14400 -- 4 hours
    },
    createTeleportPos = Position(838, 526, 9), 
    teleportToPosition = Position(895, 527, 9), 
    teleportRemoveSeconds = 60, 
    kickParticipantAfterSeconds = 60 * 30, 
    leverIds = {1945, 1946} 
}

local function getSpectators()
    if not config.centerPosition then
        config.diffX = math.ceil((config.bossArea.toPos.x - config.bossArea.fromPos.x) / 2)
        config.diffY = math.ceil((config.bossArea.toPos.y - config.bossArea.fromPos.y) / 2)
        config.centerPosition = config.bossArea.fromPos + Position(config.diffX, config.diffY, 0)
    end
    return Game.getSpectators(config.centerPosition, false, false, config.diffX, config.diffX, config.diffY, config.diffY)
end

local kingZelosAction = Action()

function kingZelosAction.onUse(player, item, fromPos, target, toPos, isHotkey)
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
    local minibossOne = Game.createMonster(config.miniBossOne, config.minibossOnePosition)
    local minibossTwo = Game.createMonster(config.miniBossTwo, config.minibossTwoPosition)
    local minibossThree = Game.createMonster(config.miniBossThree, config.minibossThreePosition)
    local miniBossFour = Game.createMonster(config.miniBossFour, config.minibossFourPosition)
    if not boss and not minibossOne and not minibossTwo and not minibossThree and not miniBossFour then error(Game.getReturnMessage(RETURNVALUE_NOTENOUGHROOM)) end
    boss:registerEvent("kingZelosSystemDeath")
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

kingZelosAction:aid(config.actionId)
kingZelosAction:register()

local creatureEvent = CreatureEvent("kingZelosSystemDeath")

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
