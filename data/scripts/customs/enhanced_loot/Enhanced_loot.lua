local config = {
    ["prince skeletal"] = {
        chance = 10000,
        tiers = {
            [{1, 4000}] = {
                tier = {"Rare", true},
                effect = {192, true},
                itemList = {{7437, 1, 1, 5000}, {7452, 1, 1, 4000}, {2079, 1, 1, 3500}},
                bag = 26691 
            },
            [{4001, 6000}] = {
                tier = {"Very Rare", true},
                effect = {189, true},
                itemList = {{8878, 1, 1, 3000}, {7404, 1, 1, 2000}},
                bag = 26691 
            },
            [{6001, 8000}] = {
                tier = {"Epic", true},
                effect = {190, true},
                itemList = {{2492, 1, 1, 5000}, {8885, 1, 1, 2000}},
                bag = 26691 
            },
            [{8001, 9500}] = {
                tier = {"Legendary", true},
                effect = {193, true},
                itemList = {{26711, 1, 1, 4000}, {26709, 1, 1, 3000}},
                bag = 26691 
            },
            [{9501, 10000}] = {
                tier = {"Exotic", true},
                effect = {191, true},
                itemList = {{26710, 1, 1, 3000}, {26708, 1, 1, 4000}},
                bag = 26691 
            }
        }
    },
    ["azure"] = {
        chance = 6000,
        tiers = {
            [{1, 4000}] = {
                tier = {"Rare", true},
                effect = {192, true},
                itemList = {{26764, 1, 1, 3000}, {26769, 1, 1, 2000},  {26773, 1, 1, 2000}, {26777, 1, 1, 2000}},
                bag = 26691 
            },
            [{4001, 6000}] = {
                tier = {"Very Rare", true},
                effect = {189, true},
                itemList = {{26761, 1, 1, 5000}, {26766, 1, 1, 4000}, {26770, 1, 1, 3500}, {26774, 1, 1, 3500}},
                bag = 26691 
            },
            [{6001, 8000}] = {
                tier = {"Epic", true},
                effect = {190, true},
                itemList = {{26763, 1, 1, 5000}, {26768, 1, 1, 4000}, {26772, 1, 1, 3000}, {26776, 1, 1, 2500}},
                bag = 26691 
            },
            [{8001, 9500}] = {
                tier = {"Legendary", true},
                effect = {193, true},
                itemList = {{26762, 1, 1, 4000}, {26767, 1, 1, 3000}, {26771, 1, 1, 3000}, {26775, 1, 1, 3000}},
                bag = 26691 
            },
            [{9501, 10000}] = {
                tier = {"Exotic", true},
                effect = {191, true},
                itemList = {{26756, 1, 1, 3000}, {26757, 1, 1, 4000},  {26758, 1, 1, 3000}, {26759, 1, 1, 3000}, {26760, 1, 1, 3000}, {26765, 1, 1, 3000}},
                bag = 26691 
            }
        }
    },
    ["master of the elements"] = {
        chance = 6000,
        tiers = {
            [{1, 4000}] = {
                tier = {"Rare", true},
                effect = {192, true},
                itemList = {{24774, 1, 10, 3000}, {27149, 1, 2, 2000}},
                bag = 26691 
            },
            [{4001, 6000}] = {
                tier = {"Very Rare", true},
                effect = {189, true},
                itemList = {{27140, 1, 2, 5000}, {27141, 1, 1, 4000}, {27142, 1, 1, 3500}, {24740, 1, 1, 3500}},
                bag = 26691 
            },
            [{6001, 8000}] = {
                tier = {"Epic", true},
                effect = {190, true},
                itemList = {{27143, 1, 1, 5000}, {27144, 1, 1, 4000}, {27145, 1, 1, 3000}},
                bag = 26691 
            },
            [{8001, 9500}] = {
                tier = {"Legendary", true},
                effect = {193, true},
                itemList = {{27146, 1, 1, 4000}, {27147, 1, 1, 3000}, {27148, 1, 1, 3000}, {24718, 1, 1, 3000}},
                bag = 26691 
            },
            [{9501, 10000}] = {
                tier = {"Exotic", true},
                effect = {191, true},
                itemList = {{27146, 1, 3, 3000}, {27147, 1, 3, 4000},  {27148, 1, 3, 3000}, {24718, 1, 1, 3000}},
                bag = 26691 
            }
        }
    },
}

local creatureevent = CreatureEvent("onDeath_randomTierDrops")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    local monster = config[creature:getName():lower()]
    if monster then
        if math.random(10000) > monster.chance then
            return true
        end
        local rand = math.random(10000)
        for chance, index in pairs(monster.tiers) do
            if chance[1] <= rand and chance[2] >= rand then
                local rewardItems = {}
                for i = 1, #index.itemList do
                    if math.random(10000) <= index.itemList[i][4] then
                        rewardItems[#rewardItems + 1] = i
                    end
                end
                if rewardItems[1] then
                    rand = math.random(#rewardItems)
                    local itemId = index.itemList[rand][1]
                    local itemCount = math.random(index.itemList[rand][2], index.itemList[rand][3])
                    
                    local position = creature:getPosition()
                    local direction = math.random(0, 3)
                    if direction == 0 then
                        position.y = position.y - 1
                    elseif direction == 1 then
                        position.x = position.x + 1
                    elseif direction == 2 then
                        position.y = position.y + 1
                    else
                        position.x = position.x - 1
                    end
                    local bagId = index.bag
                    local bag = Game.createItem(bagId, 1, position)
                    bag:addItem(itemId, itemCount)
                    
                    local bagPosition = bag:getPosition()
                    if index.tier[2] == true then
                        creature:say(index.tier[1], TALKTYPE_MONSTER_SAY, false, nil, creature:getPosition())
                        addEvent(function()
                            creature:say("", TALKTYPE_MONSTER_SAY, false, nil, creature:getPosition())
                        end, 10000)
                    end
                    if index.effect[2] == true then
                        for i = 1, 12 do
                            addEvent(function() bagPosition:sendMagicEffect(index.effect[1]) end, (i - 1) * 1600)
                        end
                    end
                end
                return true
            end
        end
    end
    return true
end

creatureevent:register()
