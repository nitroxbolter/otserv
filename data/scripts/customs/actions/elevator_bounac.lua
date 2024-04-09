
local elevatorBounacAction = MoveEvent()
function elevatorBounacAction.onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:teleportTo(Position(2135, 764, 3))
		Position(2135, 765, 3):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
elevatorBounacAction:aid(59604)
elevatorBounacAction:register()

local elevatorBounacMoveEvent = MoveEvent()
function elevatorBounacMoveEvent.onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:teleportTo(Position(2132, 764, 7))
		Position(2132, 763, 7):sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
elevatorBounacMoveEvent:aid(59605)
elevatorBounacMoveEvent:register()