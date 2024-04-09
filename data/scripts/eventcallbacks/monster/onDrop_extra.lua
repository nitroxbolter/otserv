local ec = EventCallback


ec.onDropLoot = function(self, corpse)

	local mType = self:getType()

	local player = Player(corpse:getCorpseOwner())
	if not player or player:getStamina() > 840 then
		local monsterLoot = mType:getLoot()
		local monsterLevel = self:getMonsterLevel()
		
		local lootMultiplier = 1
		if monsterLevel >= 0 and monsterLevel < 4 then
			return true
		elseif monsterLevel >= 5 and monsterLevel < 50 then
			lootMultiplier = 1.15
		elseif monsterLevel >= 51 and monsterLevel < 100 then
			lootMultiplier = 1.35
		elseif monsterLevel >= 101 and monsterLevel < 200 then
			lootMultiplier = 1.65
		elseif monsterLevel >= 201 and monsterLevel < 300 then
			lootMultiplier = 1.95
		elseif monsterLevel >= 301 and monsterLevel < 500 then
			lootMultiplier = 2.50
		elseif monsterLevel >= 501 and monsterLevel < 10000 then
			lootMultiplier = 3.00
		end


		
		for i = 1, #monsterLoot do
			for _ = 1, lootMultiplier do
				local additionalItem = corpse:createLootItem(monsterLoot[i], charmBonus)
				if not additionalItem then
					Spdlog.warn(string.format("[3][Monster:onDropLoot] - Could not add additional loot item to monster: %s, from corpse id: %d.", self:getName(), corpse:getId()))
				end
			end
		end
	end
end

ec:register()