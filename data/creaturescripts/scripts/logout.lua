function onLogout(player)
	local playerId = player:getGuid() -- get playerid
    local outfit = player:getOutfit()  -- get player outfit
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end
	local wingsClientId = outfit.lookWings or 0
    local shaderClientId = outfit.lookShader or 0 -- check lookShader
    local auraClientId = outfit.lookAura or 0    -- check lookAura

    local query = "UPDATE players SET wings_id = " .. wingsClientId .. ", shader_id = " .. shaderClientId .. ", aura_id = " .. auraClientId .. " WHERE id = " .. playerId
    db.query(query)

    return true
end
