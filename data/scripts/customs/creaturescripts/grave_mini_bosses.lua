local bosses = {
	["magnor mournbringer"] = {storage = 81467},
	["the red knight"] = {storage = 81468},
	["nargol the impaler"] = {storage = 81469},
	["rewar the bloody"] = {storage = 81470},
}

local graveDanger = CreatureEvent("graveMiniBossesDeath")
function graveDanger.onKill(creature, target)
	local targetMonster = target:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end
	local bossConfig = bosses[targetMonster:getName():lower()]
	if not bossConfig then
		return true
	end
	for key, value in pairs(targetMonster:getDamageMap()) do
		local attackerPlayer = Player(key)
		if attackerPlayer then
			if bossConfig.storage > -1 or bossConfig.storage < 1 then
				attackerPlayer:setStorageValue(bossConfig.storage, 1)
			end
		end
	end
	return true
end
graveDanger:register()
