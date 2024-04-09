local mType = Game.createMonsterType("Bulltauren Forgepriest")
local monster = {}
monster.description = "a Bulltauren Forgepriest"
monster.experience = 9600
monster.outfit = {
	lookType = 982
}

monster.health = 8800
monster.maxHealth = 8800
monster.corpse = 26691
monster.speed = 650
monster.maxSummons = 0
monster.race = "undead"

monster.changeTarget = {
	interval = 4000,
	chance = 20
}


monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	challengeable = true,
	convinceable = false,
	ignoreSpawnBlock = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	targetDistance = 3,
	staticAttackChance = 90,
	runHealth = 5000
}

monster.summons = {

}

monster.voices = {
}

monster.loot = {
	{id = 2152, chance = 100000, maxCount = 17}, 
	{id = 7591, chance = 11400, maxCount = 2}, 
	{id = 7590, chance = 10300, maxCount = 2}, 
	{id = "lesser marksman gem", chance = 12000, maxCount = 3},
	{id = "marksman gem", chance = 8000, maxCount = 2},
	{id = "greater marksman gem", chance = 6000},
	{id = "bulltaur horn", chance = 30000, maxCount = 3},
	{id = "bulltaur hoof", chance = 65000, maxCount = 3},
	{id = "strange substance", chance = 15000},
	{id = "staff piece", chance = 10000},
	{id = "nimmersatt's seal", chance = 2950},
	{id = "crystallised blood", chance = 5800},
	{id = "sacred tree amulet", chance = 8000},
	{id = "northwind rod", chance = 7000},
	{id = "wand of draconia", chance = 7000},
	{id = "mystic turban", chance = 21000},
	{id = "strange helmet", chance = 17000},
	{id = "focus cape", chance = 3800},
	{id = "yalahari mask", chance = 2000},
	{id = "yalahari leg piece", chance = 1800},
	{id = "common star inlay stone", chance = 9000},
	{id = "common two stars inlay stone", chance = 7000},
	{id = "common three stars inlay stone", chance = 6000},
	{id = "rare star inlay stone", chance = 6000},
	{id = "rare two stars inlay stone", chance = 4500},
	{id = "rare three stars inlay stone", chnace = 3000},
	{id = "star extractor", chance = 4000}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -100, maxDamage = -380, condition = {type = CONDITION_POISON, totalDamage = 8, interval = 4000}},
	{name ="combat", interval = 3000, chance = 70, type = COMBAT_EARTHDAMAGE, minDamage = -160, maxDamage = -300, range = 5, shootEffect = 30, effect = 196, target = false},
	{name ="combat", interval = 1000, chance = 20, type = COMBAT_LIFEDRAIN, minDamage = -280, maxDamage = -420, range = 1, target = false},
	{name ="combat", interval = 1000, chance = 17, type = COMBAT_HOLYDAMAGE, minDamage = -150, maxDamage = -540, range = 7, shootEffect = 38, effect = 201, target = false},
	{name ="combat", interval = 1000, chance = 17, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -340, range = 7, shootEffect = 5, effect = 214, target = false}
}

monster.defenses = {
	defense = 60,
	armor = 60,
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = -5},
	{type = COMBAT_ENERGYDAMAGE, percent = 20},
	{type = COMBAT_EARTHDAMAGE, percent = 100},
	{type = COMBAT_FIREDAMAGE, percent = -5},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = -5},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "fire", combat = true, condition = true},
	{type = "drown", condition = true},
	{type = "lifedrain", combat = true},
	{type = "paralyze", condition = true},
	{type = "invisible", condition = true}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
	if monster:getId() == creature:getId() then
	end
end

mType.onDisappear = function(monster, creature)
	if monster:getId() == creature:getId() then
	end
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
	if monster:getId() == creature:getId() then
	end
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)