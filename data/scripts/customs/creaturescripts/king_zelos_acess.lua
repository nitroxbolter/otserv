local teleportBoss = MoveEvent()
function teleportBoss.onStepIn(player, item, position, fromPosition)
	if item:getActionId() == 57392 then
	local storageOne = player:getStorageValue(81467)
	local storageTwo = player:getStorageValue(81468)
	local storageThree = player:getStorageValue(81469)
	local storageFour = player:getStorageValue(81470)
	

	if storageOne >= 1 and storageTwo >= 1 and storageThree >= 1 and storageFour >= 1 then
		player:teleportTo({x= 848, y = 517, z= 9})
		player:setStorageValue(81467, 0)
		player:setStorageValue(81468, 0)
		player:setStorageValue(81469, 0)
		player:setStorageValue(81470, 0)
		else
			player:say("You must kill every Mini Boss in order to fight King Zelos", TALKTYPE_MONSTER_SAY)
			player:teleportTo(fromPosition)
		end
	end

end

teleportBoss:aid(57392)
teleportBoss:type("stepIn")
teleportBoss:register()