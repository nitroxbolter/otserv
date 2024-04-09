
local potion = Action()

 
function potion.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
	if player:getStorageValue(Jobs.Herbalist.NimbleManaPotion) == 1 then
		player:say("You have already learned the recipe of nimble mana potion.", TALKTYPE_MONSTER_SAY)
	else
	player:setStorageValue(Jobs.Herbalist.NimbleManaPotion, 1)
	item:remove(1)
end
end
potion:id(26750)
potion:register()