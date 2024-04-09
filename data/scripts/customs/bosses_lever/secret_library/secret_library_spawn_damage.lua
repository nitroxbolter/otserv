local effects = {
	{fromPosition = Position(657, 1447, 8), toPosition = Position(657, 1450, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(671, 1447, 8), toPosition = Position(671, 1450, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(671, 1456, 8), toPosition = Position(671, 1458, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(657, 1456, 8), toPosition = Position(657, 1458, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(653, 1465, 8), toPosition = Position(655, 1465, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(659, 1472, 8), toPosition = Position(659, 1474, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(673, 1472, 8), toPosition = Position(673, 1474, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(714, 1521, 8), toPosition = Position(714, 1522, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(726, 1521, 8), toPosition = Position(726, 1522, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(765, 1521, 8), toPosition = Position(765, 1522, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(785, 1521, 8), toPosition = Position(785, 1522, 8), effect = CONST_ME_HOLYDAMAGE},
	{fromPosition = Position(664, 1447, 8), toPosition = Position(664, 1450, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(675, 1453, 8), toPosition = Position(677, 1453, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(664, 1456, 8), toPosition = Position(664, 1458, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(653, 1460, 8), toPosition = Position(655, 1460, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(653, 1470, 8), toPosition = Position(655, 1470, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(666, 1472, 8), toPosition = Position(666, 1474, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(708, 1521, 8), toPosition = Position(708, 1522, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(720, 1521, 8), toPosition = Position(720, 1522, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(732, 1521, 8), toPosition = Position(732, 1522, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(771, 1521, 8), toPosition = Position(771, 1522, 8), effect = CONST_ME_FIREAREA},
	{fromPosition = Position(791, 1521, 8), toPosition = Position(791, 1522, 8), effect = CONST_ME_FIREAREA},

	{fromPosition = Position(860, 1538, 9), toPosition = Position(860, 1562, 9), effect = 184},
	{fromPosition = Position(866, 1538, 9), toPosition = Position(866, 1562, 9), effect = 186},
	{fromPosition = Position(851, 1542, 9), toPosition = Position(875, 1542, 9), effect = 196},
	{fromPosition = Position(851, 1545, 9), toPosition = Position(875, 1545, 9), effect = 198},
	{fromPosition = Position(851, 1549, 9), toPosition = Position(875, 1549, 9), effect = 199},
	{fromPosition = Position(851, 1553, 9), toPosition = Position(875, 1553, 9), effect = 200},
	{fromPosition = Position(851, 1557, 9), toPosition = Position(875, 1557, 9), effect = 208},


	---- Falcon Bastion ----
	{fromPosition = Position(670, 257, 5), toPosition = Position(672, 257, 5), effect = 7},
	{fromPosition = Position(670, 265, 5), toPosition = Position(672, 265, 5), effect = 7},

	{fromPosition = Position(670, 241, 3), toPosition = Position(671, 241, 3), effect = 7},
	{fromPosition = Position(670, 245, 3), toPosition = Position(671, 245, 3), effect = 7},
	{fromPosition = Position(670, 247, 3), toPosition = Position(671, 247, 3), effect = 7},
	{fromPosition = Position(670, 251, 3), toPosition = Position(671, 251, 3), effect = 7},
	{fromPosition = Position(670, 253, 3), toPosition = Position(671, 253, 3), effect = 7},
	{fromPosition = Position(664, 255, 3), toPosition = Position(664, 257, 3), effect = 7},
	{fromPosition = Position(667, 255, 3), toPosition = Position(667, 257, 3), effect = 7},
	{fromPosition = Position(670, 259, 3), toPosition = Position(671, 259, 3), effect = 7},
	{fromPosition = Position(670, 262, 3), toPosition = Position(671, 262, 3), effect = 7},
}

local spawnDamage = GlobalEvent("spawn damage")
function spawnDamage.onThink(interval)
	local jolf
	for i = 1, #effects do
		local settings = effects[i]
		fromPosition = settings.fromPosition
		toPosition = settings.toPosition
		local spectators = Game.getSpectators(settings.fromPosition, false, true, 7, 7, 5, 5)
		if #spectators > 0 then
			if settings.effect then
				for y = fromPosition.y, toPosition.y do
					local newPosition = Position(fromPosition.x, y, fromPosition.z)
					newPosition:sendMagicEffect(settings.effect)

					jolf = Tile(newPosition):getTopCreature()
					if jolf and jolf:isPlayer() then
						doTargetCombatHealth(0, jolf, COMBAT_PHYSICALDAMAGE, -500, -1000, settings.effect)
					end
				end
				for x = fromPosition.x, toPosition.x do
					local newPosition2 = Position(x, fromPosition.y, fromPosition.z)
					newPosition2:sendMagicEffect(settings.effect)
					jolf = Tile(newPosition2):getTopCreature()
					if jolf and jolf:isPlayer() then
						doTargetCombatHealth(0, jolf, COMBAT_PHYSICALDAMAGE, -10, -500, settings.effect)
					end
				end
			end
		end
	end
	return true
end

spawnDamage:interval(7000)
spawnDamage:register()
