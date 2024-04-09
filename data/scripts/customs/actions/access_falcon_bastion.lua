local falconBastion = Action()

function falconBastion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getActionId() == 21607 then
	player:teleportTo({x = 646, y = 271, z = 7})
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	if item:getActionId() == 21608 then
		player:teleportTo({x = 626, y = 254, z = 7})
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	if item:getActionId() == 21609 then
		player:teleportTo({x = 683, y = 215, z = 7})
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	if item:getActionId() == 21610 then
		player:teleportTo({x = 675, y = 233, z = 7})
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
end

falconBastion:aid(21607, 21608, 21609, 21610)
falconBastion:register()
