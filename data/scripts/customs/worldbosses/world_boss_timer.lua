local worldBoss = GlobalEvent("DreadscaleTheAncient")

function worldBoss.onTime()
    if(os.date("%A") == "Monday") then 
        local bossPosition = Position(676, 105, 10)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Dreadscale The Ancient") then
            Game.broadcastMessage("World Boss Dreadscale The Ancient has appeared!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Dreadscale The Ancient", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()


local worldBoss = GlobalEvent("DrakTulTheSovereign")

function worldBoss.onTime()
    if(os.date("%A") == "Tuesday") then 
        local bossPosition = Position(322, 663, 10)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Drak'thul The Void Sovereign") then
            Game.broadcastMessage("World Boss Drak'thul The Void Sovereign has merged!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Drak'thul The Void Sovereign", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()


local worldBoss = GlobalEvent("ThaladorTheStormbringer")

function worldBoss.onTime()
    if(os.date("%A") == "Wednesday") then 
        local bossPosition = Position(1022, 1045, 5)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Thalador The Stormbringer") then
            Game.broadcastMessage("World Boss Thalador The Stormbringer has appeared!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Thalador The Stormbringer", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()



local worldBoss = GlobalEvent("AquaticOverlord")

function worldBoss.onTime()
    if(os.date("%A") == "Monday") then 
        local bossPosition = Position(1935, 1227, 11)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Aquatic Overlord Thalassa") then
            Game.broadcastMessage("World Boss Aquatic Overlord Thalassa has emerged!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Aquatic Overlord Thalassa", bossPosition)
        end
    end
    return true
end

worldBoss:time("16:00:00")
worldBoss:register()


local worldBoss = GlobalEvent("VorondorEternalFlames")

function worldBoss.onTime()
    if(os.date("%A") == "Thursday") then 
        local bossPosition = Position(1968, 974, 7)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Vorondor The Eternal Flames") then
            Game.broadcastMessage("World Boss: Vorondor The Eternal Flames blazes into existence!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Vorondor The Eternal Flames", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()


local worldBoss = GlobalEvent("AzazelSeraphim")

function worldBoss.onTime()
    if(os.date("%A") == "Friday") then 
        local bossPosition = Position(1766, 258, 6)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Azazel The Infernal Seraph") then
            Game.broadcastMessage("World Boss: The skies darken as Azazel The Infernal Seraph descends!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Azazel The Infernal Seraph", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()


local worldBoss = GlobalEvent("mortisAndDreadbone")

function spawnBoss(bossName, bossPosition)
    local topCreature = Tile(bossPosition):getTopCreature()
    if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= bossName) then
        Game.broadcastMessage("World Boss: The realm trembles as " .. bossName .. " descend upon us!", MESSAGE_EVENT_ADVANCE)
        Game.createMonster(bossName, bossPosition)
    end
end

function worldBoss.onTime()
   if(os.date("%A") == "Saturday") then 
        local mortisPosition = Position(1319, 214, 8)
        local dreadbonePosition = Position(1322, 215, 8)
        
        spawnBoss("Mortis The Sovereign", mortisPosition)
        spawnBoss("Dreadbone The Eternal", dreadbonePosition)
    end
    return true
end

worldBoss:time("12:00:00")
worldBoss:register()



local worldBoss = GlobalEvent("TymagronTheEarthshaker")

function worldBoss.onTime()
    if(os.date("%A") == "Saturday") then 
        local bossPosition = Position(1079, 765, 7)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Tymagron The Earthshaker") then
            Game.broadcastMessage("World Boss: Behold! Tymagron The Earthshaker has emerged with a thunderous roar!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Tymagron The Earthshaker", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()



local worldBoss = GlobalEvent("GorgulTheFrienzied")

function worldBoss.onTime()
    if(os.date("%A") == "Sunday") then 
        local bossPosition = Position(528, 801, 9)
        local topCreature = Tile(bossPosition):getTopCreature()
        
        if topCreature == nil or (topCreature:isMonster() and topCreature:getName() ~= "Gor'gul The Frienzied") then
            Game.broadcastMessage("World Boss: Hear the thundering rage of Gor'Gul The Frenzied as he crashes into our realm, fueled by primal fury!", MESSAGE_EVENT_ADVANCE)
            Game.createMonster("Gor'gul The Frienzied", bossPosition)
        end
    end
    return true
end

worldBoss:time("20:00:00")
worldBoss:register()