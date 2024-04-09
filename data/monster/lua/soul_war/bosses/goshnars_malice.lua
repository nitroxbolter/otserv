local mType = Game.createMonsterType("Goshnar's Malice")
local monster = {}

monster.description = "Goshnar's Malice"
monster.experience = 200000
monster.outfit = {
	lookType = 1053,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0
}

monster.health = 300000
monster.maxHealth = 300000
monster.race = "undead"
monster.corpse = 26691
monster.speed = 550

monster.changeTarget = {
	interval = 2000,
	chance = 10
}


monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
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
	staticAttackChance = 95,
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

monster.summon = {
	maxSummons = 4,
	summons = {
		{name = "dreadful harvester", chance = 40, interval = 1000, count = 2},
		{name = "malicious soul", chance = 30, interval = 1000, count = 2}
	}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "GOSHNAR'S MALICE PREPARES TO DEVOUR A TRAPPED SOUL!", yell = true}
}

monster.loot = {
	{id = "crystal coin", chance = 55000, minCount = 70, maxCount = 75},
	{id = 7632, chance = 1150}, -- giant shimmering pearl (green)
	{id = "giant sapphire", chance = 10000, maxCount = 1},
	{id = "giant topaz", chance = 10000, maxCount = 1},
	{id = "violet gem", chance = 6000, maxCount = 1},
	{id = "blue gem", chance = 10000, maxCount = 3},
	{id = 2156, chance = 10000, maxCount = 3}, -- red gem
	{id = "green gem", chance = 10000, maxCount = 3},
	{id = "yellow gem", chance = 10000, maxCount = 3},
	{id = "white gem", chance = 6000, maxCount = 3},
	{id = "dragon figurine", chance = 10000, maxCount = 1},
	{id = "bullseye potion", chance = 15000, minCount = 10, maxCount = 25},
	{id = "mastermind potion", chance = 15000, minCount = 10, maxCount = 25},
	{id = "berserk potion", chance = 15000, minCount = 10, maxCount = 25},
	{id = "ultimate mana potion", chance = 18000, minCount = 50, maxCount = 100},
	{id = "supreme health potion", chance = 18000, minCount = 50, maxCount = 100},
	{id = "ultimate spirit potion", chance = 18000, minCount = 50, maxCount = 100},
	{id = "malice's spine", chance = 2000, maxCount = 1},
	{id = "malice's horn", chance = 2000, maxCount = 1},
	{id = "bracelet of strengthening", chance = 400},
	{id = "spectral horseshoe", chance = 400},
	{id = "the skull of a beast", chance = 400},
	{id = "figurine of malice", chance = 400},
	{id = "bag you desire", chance = 100},
}

monster.attacks = {
	{name ="melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -2000},
	{name ="combat", interval = 2000, chance = 22, type = COMBAT_ICEDAMAGE, minDamage = -450, maxDamage = -1400, length = 10, spread = 4, effect = CONST_ME_ICEAREA, target = false},
	{name ="combat", interval = 2000, chance = 30, type = COMBAT_ICEDAMAGE, minDamage = -350, maxDamage = -1000, range = 7, radius = 4, shootEffect = CONST_ANI_ICE, effect = CONST_ME_ICEAREA, target = true}
}

monster.defenses = {
	defense = 160,
	armor = 160,
	{name = "speed", chance = 15, interval = 2*1000, speed = 650, effect = CONST_ME_MAGIC_RED},
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_HEALING, minDamage = 350, maxDamage = 1250, effect = 185, target = false},
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 0},
	{type = COMBAT_ENERGYDAMAGE, percent = 15},
	{type = COMBAT_EARTHDAMAGE, percent = 15},
	{type = COMBAT_FIREDAMAGE, percent = 15},
	{type = COMBAT_LIFEDRAIN, percent = 100},
	{type = COMBAT_MANADRAIN, percent = 0},
	{type = COMBAT_DROWNDAMAGE, percent = 100},
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