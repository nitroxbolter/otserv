local area = createCombatArea({
     {0, 1, 1, 1, 0},
     {1, 1, 1, 1, 1},
     {1, 1, 3, 1, 1},
     {1, 1, 1, 1, 1},
     {0, 1, 1, 1, 0},
 })

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_DIAMONDARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setArea(area)

function onGetFormulaValues(player, skill, attack, factor)
    local distanceSkill = player:getEffectiveSkillLevel(SKILL_DISTANCE)
    local min = (player:getLevel() / 5)
    local max = (0.09 * factor) * distanceSkill * 37 + (player:getLevel() / 5)
    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")


function onUseWeapon(player, variant)
    return combat:execute(player, variant)
end


