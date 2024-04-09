local config = {
	requiredLevel = 200,
	daily = true,
	roomCenterPosition = Position(1792, 728, 8),
	playerPositions = {
		Position(1791, 705, 8),
		Position(1792, 705, 8),
		Position(1793, 705, 8),
		Position(1794, 705, 8),
		Position(1795, 705, 8)
	},
	teleportPosition = Position(1792, 718, 8),
	bossPosition = Position(1792, 728, 8)
}

local leverboss = Action()

function leverboss.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= config.playerPositions[1] then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can\'t start the battle.")
			return true
		end
		
		local team, participant = {}

		for i = 1, #config.playerPositions do
			participant = Tile(config.playerPositions[i]):getTopCreature()
			
			if participant and participant:isPlayer() then
				if participant:getLevel() < config.requiredLevel then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
						"All the players need to be level ".. config.requiredLevel .." or higher.")
					return true
				end

				if config.daily and participant:getStorageValue(28177) > os.time() then
					player:getPosition():sendMagicEffect(CONST_ME_POFF)
					player:sendCancelMessage("Not all players are ready yet from last battle.")
					return true
				end

				team[#team + 1] = participant
			end
		end

		local specs, spec = Game.getSpectators(config.roomCenterPosition, false, false, 14, 14, 13, 13)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A team is already inside the boss room.")
				return true
			end

			spec:remove()
		end

		Game.createMonster("Urmahlullu the Immaculate", config.bossPosition)

		for i = 1, #team do
			team[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			team[i]:teleportTo(config.teleportPosition)
			team[i]:setStorageValue(28177, os.time() + 20*60*60) 
		end
		
		config.teleportPosition:sendMagicEffect(CONST_ME_ENERGYAREA)
	end

	item:transform(9826)
	return true
end

leverboss:uid(9545)
leverboss:register()
