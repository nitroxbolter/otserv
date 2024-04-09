local config = {
    [41731] = {
        object = {
            position = Position(876, 1066, 13),
            itemId = 6739,
            removeTimer = 120
        }
    },
    [41732] = {
        object = {
            position = Position(904, 1076, 13),
            itemId = 6739,
            removeTimer = 120
        }
    },
    [41733] = {
        object = {
            position = Position(930, 1105, 13),
            itemId = 6739,
            removeTimer = 120
        }
    },
    [41734] = {
        object = {
            position = Position(968, 1085, 13),
            itemId = 6740,
            removeTimer = 120
        }
    },
}

local function removeAndReAddObject(position, objectId, timer)
    position:sendMagicEffect(CONST_ME_POFF)
    if timer > 0 then
        Tile(position):getItemById(objectId):remove()
        addEvent(removeAndReAddObject, timer, position, objectId, 0)
    else
        Game.createItem(objectId, 1, position)
    end
end

local menhirOpen = Action()

function menhirOpen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local actionId = item:getActionId()
    local index = config[actionId]
    if not index then
        print("LUA error: ActionId not in table." .. actionId)
        return false
    end

    removeAndReAddObject(index.object.position, index.object.itemId, index.object.removeTimer * 1000)
    doSendMagicEffect(toPosition, 184)
    doSendMagicEffect(player:getPosition(), 186) 
    return true
end

for actionid, _ in pairs(config) do
    menhirOpen:aid(actionid)
end

menhirOpen:register()
