local mType = Game.createMonsterType("Duke Krule")
local monster = {}

monster.description = "a Duke Krule"
monster.experience = 55000
monster.outfit = {
	lookType = 1009,
	lookHead = 19,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 3,
	lookMount = 0
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "undead"
monster.corpse = 26691
monster.speed = 250
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10
}

monster.strategiesTarget = {
	nearest = 100,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false
}

monster.light = {
	level = 0,
	color = 0
}

monster.voices = {
	interval = 5000,
	chance = 10,
}

monster.loot = {
	{id = "platinum coin", minCount = 1, maxCount = 5, chance = 100000},
	{id = "crystal coin", minCount = 0, maxCount = 2, chance = 50000},
	{id = "supreme health potion", minCount = 0, maxCount = 6, chance = 35000},
	{id = "ultimate mana potion", minCount = 0, maxCount = 20, chance = 32000},
	{id = "ultimate spirit potion", minCount = 0, maxCount = 20, chance = 32000},
	{id = "bullseye potion", minCount = 0, maxCount = 10, chance = 12000},
	{id = "mastermind potion", minCount = 0, maxCount = 10, chance = 12000},
	{id = "berserk potion", minCount = 0, maxCount = 10, chance = 12000},
	{id = "piece of draconian steel", minCount = 0, maxCount = 3, chance = 9000},
	{id = "green gem", minCount = 0, maxCount = 2, chance = 12000},
	{id = "silver token", minCount = 0, maxCount = 2, chance = 9500},
	{id = "blue gem", chance = 11000},
	{id = "crusader helmet", chance = 6400},
	{id = "gold ingot", minCount = 0, maxCount = 1, chance = 10000},
	{id = "red gem", chance = 11000},
	{id = "terra hood", chance = 7800},
	{id = "yellow gem", chance = 9500},
	{id = "young lich worm", chance = 5800},
	{id = "bear skin", chance = 1800},
	{id = "noble amulet", chance = 800},
	{id = "rotten heart", chance = 1700},
	{id = "terra helmet", chance = 700},
	{id = "final judgement", chance = 460},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -200, maxDamage = -600},
	{name ="combat", interval = 1800, chance = 60, type = COMBAT_MANADRAIN, minDamage = -400, maxDamage = -1000, length = 7, spread = 2, effect = CONST_ME_EXPLOSIONHIT, target = false},
	{name ="combat", interval = 1800, chance = 19, type = COMBAT_PHYSICALDAMAGE, minDamage = -400, maxDamage = -1000, length = 7, spread = 3, effect = CONST_ME_BLOCKHIT, target = false},
	{name ="combat", interval = 1800, chance = 40, type = COMBAT_FIREDAMAGE, minDamage = -300, maxDamage = -500, radius = 10, effect = CONST_ME_HITBYFIRE, target = false}
}

monster.defenses = {
	defense = 25,
	armor = 78,
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_HEALING, minDamage = 150, maxDamage = 350, effect = 185, target = false}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 0},
	{type = COMBAT_EARTHDAMAGE, percent = 0},
	{type = COMBAT_FIREDAMAGE, percent = 20},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 0},
	{type = COMBAT_HOLYDAMAGE , percent = 0},
	{type = COMBAT_DEATHDAMAGE , percent = 0}
}

monster.immunities = {
	{type = "paralyze", condition = true},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType.onThink = function(monster, interval)
end

mType.onAppear = function(monster, creature)
end

mType.onDisappear = function(monster, creature)
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
end

mType.onSay = function(monster, creature, type, message)
end

mType:register(monster)
