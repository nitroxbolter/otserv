local slotBits = {
	[CONST_SLOT_HEAD] = SLOTP_HEAD,
	[CONST_SLOT_NECKLACE] = SLOTP_NECKLACE,
	[CONST_SLOT_BACKPACK] = SLOTP_BACKPACK,
	[CONST_SLOT_ARMOR] = SLOTP_ARMOR,
	[CONST_SLOT_RIGHT] = SLOTP_RIGHT,
	[CONST_SLOT_LEFT] = SLOTP_LEFT,
	[CONST_SLOT_LEGS] = SLOTP_LEGS,
	[CONST_SLOT_FEET] = SLOTP_FEET,
	[CONST_SLOT_RING] = SLOTP_RING,
	[CONST_SLOT_AMMO] = SLOTP_AMMO,
	[CONST_SLOT_DECK] = SLOTP_DECK,
	[CONST_SLOT_BADGE] = SLOTP_BADGE,
	[CONST_SLOT_SHIP] = SLOTP_SHIP,
	[CONST_SLOT_WINGS] = SLOTP_WINGS,
	[CONST_SLOT_AURA] = SLOTP_AURA,
}

function ItemType.usesSlot(self, slot)
	return bit.band(self:getSlotPosition(), slotBits[slot] or 0) ~= 0
end
