local mType = Game.createMonsterType("Energuardian of Tales")
local monster = {}

monster.description = "an energuardian of tales"
monster.experience = 11361
monster.outfit = {
	lookType = 991,
	lookHead = 66,
	lookBody = 85,
	lookLegs = 82,
	lookFeet = 93,
	lookAddons = 3,
	lookMount = 0
}


monster.health = 14000
monster.maxHealth = 14000
monster.race = "undead"
monster.corpse = 26691
monster.speed = 420
monster.manaCost = 0
monster.maxSummons = 0

monster.changeTarget = {
	interval = 5000,
	chance = 8
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
	canWalkOnPoison = false,
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
	{id = "Book Page", chance = 10000, maxCount = 5},
	{id = "Glowing Rune", chance = 4500, maxCount = 5},
	{id = "Small Amethyst", chance = 10000, maxCount = 5},
	{id = "Flash Arrow", chance = 10000, maxCount = 5},
	{id = "Lightning Legs", chance = 250},
	{id = "Might Ring", chance = 500},
	{id = "Platinum Amulet", chance = 2500},
	{id = "Spellbook of Warding", chance = 350},
	{id = "Ultimate Health Potion", chance = 33000, maxCount = 5},
	{id = "Ultimate Mana Potion", chance = 33000, maxCount = 5},
	{id = "Wand of Starstorm", chance = 300},
	{id = "Wand of Defiance", chance = 280},
	{id = "Spellweaver's Robe", chance = 300},
	{id = "Shockwave amulet", chance = 800}
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = -10, maxDamage = -550},
	{name ="combat", interval = 1000, chance = 13, type = COMBAT_ENERGYDAMAGE, minDamage = -100, maxDamage = -555, radius = 3, effect = CONST_ME_ENERGYAREA, target = false}
}

monster.defenses = {
	defense = 40,
	armor = 82
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 50},
	{type = COMBAT_EARTHDAMAGE, percent = 30},
	{type = COMBAT_FIREDAMAGE, percent = 80},
	{type = COMBAT_LIFEDRAIN, percent = 0},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 0},
	{type = COMBAT_ICEDAMAGE, percent = 50},
	{type = COMBAT_HOLYDAMAGE , percent = 50},
	{type = COMBAT_DEATHDAMAGE , percent = 50}
}

monster.immunities = {
	{type = "paralyze", condition = false},
	{type = "outfit", condition = false},
	{type = "invisible", condition = true},
	{type = "bleed", condition = false}
}

mType:register(monster)
