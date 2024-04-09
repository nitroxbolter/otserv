local azurePortals = {
    [1] = {
        city = "Arkeron",
        mapName = "portal_rivendell",
        exitPosition = Position(1745, 1312, 7)
    },
    [2] = {
        city = "Death Valley",
        mapName = "portal_deathValley",
        exitPosition = Position(1501, 366, 7)
    },
    [3] = {
        city = "Dolwatha",
        mapName = "portal_dolwatha",
        exitPosition = Position(351, 176, 7)
    },
    [4] = {
        city = "Freewind",
        mapName = "portal_freewind",
        exitPosition = Position(1337, 1043, 7)
    },
}

local currentPortal = nil

local azurePortal = GlobalEvent("azurePortals")

function azurePortal.onStartup(interval)
    local gateId = math.random(1, 4)

    currentPortal = azurePortals[gateId]
    Game.loadMap('data/world/portals/' .. currentPortal.mapName .. '.otbm')

    print(string.format("Azure Portal will be active in %s today.", currentPortal.city))

    Game.setStorageValue(Storage.AzureGates, gateId)

    return true
end

azurePortal:register()

local teleport = MoveEvent()

function teleport.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return true
    end

    -- Retrieve the gateId from the global storage value
    local gateId = Game.getStorageValue(Storage.AzureGates)

    if not azurePortals[gateId] then
        return true
    end

    position:sendMagicEffect(CONST_ME_TELEPORT)

    if item.actionid == 22710 then
        local destination = Position(956, 1193, 8)
        player:teleportTo(destination)
        destination:sendMagicEffect(CONST_ME_TELEPORT)
    elseif item.actionid == 22715 then
        player:teleportTo(azurePortals[gateId].exitPosition)
        azurePortals[gateId].exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
    end

    return true
end

teleport:type("stepin")
teleport:aid(22710, 22715)
teleport:register()
