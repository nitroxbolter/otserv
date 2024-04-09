local info = {
	bossName = "Scarlett Etzel",
	middle = Position(309, 208, 11),
	fromPos = Position(295, 194, 11),
	toPos = Position(324, 225, 11),
	exitPos = Position(347, 195, 11),
	timer = 24853,
	armorId = 27245,
	armorPos = Position(309, 201, 11),
}

local entry = {
	metalWallId = 1544,
	roomEntryPos = Position(309, 218, 11),
	roomExitPos = Position(347, 195, 11)
}

local transformTo = {
	[27237] = 27238,
	[27238] = 27239,
	[27239] = 27240,
	[27240] = 27237
}

local function createArmor(id, amount, pos)
	local armor = Game.createItem(id, amount, pos)
	if armor then armor:setActionId(40003) end
end

local mirror = {
	fromPos = Position(302, 203, 11),
	toPos = Position(316, 217, 11),
	mirrors = {27237, 27238, 27239, 27240}
}

local function backMirror()
    for x = mirror.fromPos.x, mirror.toPos.x do
		for y = mirror.fromPos.y, mirror.toPos.y do
			local sqm = Tile(Position(x, y, 11))
			if sqm then
				for _, id in pairs(mirror.mirrors) do
					local item = sqm:getItemById(id)
					if item then
						item:transform(mirror.mirrors[math.random(#mirror.mirrors)])
						item:getPosition():sendMagicEffect(CONST_ME_POFF)
					end
				end
			end
		end
	end
end

local graveScarlettUid = Action()
function graveScarlettUid.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playersTable = {}
    if item:getUniqueId() == 40028 then
        if player:doCheckBossRoom(info.bossName, info.fromPos, info.toPos) then
            for x = info.middle.x - 1, info.middle.x + 1 do
                for y = info.middle.y - 1, info.middle.y + 1 do
                    local sqm = Tile(Position(x, y, 6))
                    if sqm and sqm:getGround():getId() == 18013 then
                        local player_ = sqm:getTopCreature()
                        if player_ and player_:isPlayer() then
                            if player_:getStorageValue(info.timer) > os.time() then
                                player_:getPosition():sendMagicEffect(CONST_ME_POFF)
                                player_:sendCancelMessage('You are still exhausted from your last battle.')
                                return true
                            end
                            table.insert(playersTable, player_:getId())
                        end
                    end
                end
            end
			player:teleportTo(Position(309, 218, 11))
			player:setStorageValue(info.timer, os.time() + 20 * 60 * 60)
            local scarlett = Game.createMonster("Scarlett Etzel", Position(309, 203, 11))
            if scarlett then
                scarlett:setStorageValue(24854, 1)
				addEvent(backMirror, 5*1000)
            end
            SCARLETT_MAY_TRANSFORM = 0
            addEvent(kickPlayersAfterTime, 30 * 60 * 1000, playersTable, info.fromPos, info.toPos, info.exitPos)
        end
    end
    return true
end

graveScarlettUid:uid(40028)
graveScarlettUid:register()



local graveScarlettAid = Action();
function graveScarlettAid.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.actionid == 40003 then
		if isInArray(transformTo, item.itemid) then
			local pilar = transformTo[item.itemid]
			if pilar then
				item:transform(pilar)
				item:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		elseif item.itemid == info.armorId then
			item:getPosition():sendMagicEffect(CONST_ME_THUNDER)
			item:remove(1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hold the old chestplate of Galthein in front of you. It does not fit and far too old to withstand any attack.")
			addEvent(createArmor, 35*1000, info.armorId, 1, info.armorPos)
			addEvent(backMirror, 10*1000)
			SCARLETT_MAY_TRANSFORM = 1
			addEvent(function()
				SCARLETT_MAY_TRANSFORM = 0
			end, 1 * 1000)
		elseif item.itemid == entry.metalWallId then
			if player:getPosition().y == entry.roomExitPos.y then
				player:teleportTo(entry.roomEntryPos)
			else
				player:teleportTo(entry.roomExitPos)
			end
		end
	end
	return true
end

graveScarlettAid:aid(40003)
graveScarlettAid:register()


local storage = 24854
local rooms = {
	[1] = {fromPos = Position(303, 204, 11), toPos = Position(307, 208, 11)},
	[2] = {fromPos = Position(303, 208, 11), toPos = Position(307, 212, 11)},
	[3] = {fromPos = Position(303, 212, 11), toPos = Position(307, 216, 11)},
	[4] = {fromPos = Position(307, 204, 11), toPos = Position(311, 208, 11)},
	[5] = {fromPos = Position(307, 208, 11), toPos = Position(311, 212, 11)},
	[6] = {fromPos = Position(307, 212, 11), toPos = Position(311, 216, 11)},
	[7] = {fromPos = Position(311, 204, 11), toPos = Position(315, 208, 11)},
	[8] = {fromPos = Position(311, 208, 11), toPos = Position(315, 212, 11)},
	[9] = {fromPos = Position(311, 212, 11), toPos = Position(315, 216, 11)}
}

local function isMirrorsCorrect(fromPosition, toPosition)
    local Pillar1 = Tile(fromPosition):getItemById(27237)
    local Pillar2 = Tile(Position(fromPosition.x + 4, fromPosition.y, fromPosition.z)):getItemById(27238)
    local Pillar3 = Tile(Position(toPosition.x - 4, toPosition.y, toPosition.z)):getItemById(27240)
    local Pillar4 = Tile(toPosition):getItemById(27239)

    if Pillar1 and Pillar2 and Pillar3 and Pillar4 then
        return true
    end

    return false
end


local eventDoDamage = function(creatureid, attackerid, type)
	local creature = Creature(creatureid)
	local attacker = Creature(attackerid)
	if not creature or not attacker then
		return
	end

	local damage = creature:getMaxHealth()/18
	creature:say('AHHHHHHHHHHH!', TALKTYPE_MONSTER_SAY)
	doTargetCombatHealth(attackerid, creature, type, -damage, -damage, CONST_ME_POFF, ORIGIN_NONE)
end


local function changeScarlett(creatureid)
	local creature = Creature(creatureid)
	if not creature then
		return
	end
	creature:say('Galthen... is that you?', TALKTYPE_MONSTER_SAY)
	SCARLETT_MAY_DIE = 1
	SCARLETT_MAY_TRANSFORM = 0
end

local scarlettThink = CreatureEvent("scarlettThink")
function scarlettThink.onThink(creature)
    if not creature:isMonster() then
        return true
    end

    if SCARLETT_MAY_TRANSFORM ~= 1 then
        return true
    end

    local mirrorsCount = 0
    for _, p in pairs(rooms) do
        if creature:getPosition():isInRange(p.fromPos, p.toPos) then
            if isMirrorsCorrect(p.fromPos, p.toPos) then
				creature:setStorageValue(24856, 1)
                addEvent(changeScarlett, 0.5 * 1000, creature:getId())
                return true
            end
        end
    end
    return true
end

scarlettThink:register()

local scarlettHealth = CreatureEvent("scarlettHealth")
function scarlettHealth.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if not creature:isMonster() then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end

	if creature:getStorageValue(storage) ~= 1 then
		return primaryDamage, primaryType, secondaryDamage, secondaryType
	end
	if creature:getStorageValue(24856) >= 1 then
	local spec = Game.getSpectators(creature:getPosition(), false, false, 4, 4, 4, 4)
	for _, c in pairs(spec) do
		if c and (c:isPlayer() or c:getMaster()) then
			doTargetCombatHealth(creature:getId(), c, COMBAT_EARTHDAMAGE, -3500, -3500, CONST_ME_GROUNDSHAKER)
			addEvent(function() creature:setStorageValue(24856, 0) end, 4 * 1000)
		end
	end
	else
		if creature then
			return primaryDamage*0.01, primaryType, secondaryDamage*0.01, secondaryType
		end
	end

	addEvent(eventDoDamage, 200, creature:getId(), attacker:getId(), primaryType)
	SCARLETT_MAY_DIE = 0
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

scarlettHealth:register()
