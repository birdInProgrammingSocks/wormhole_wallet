dofile("settings.lua")

local perks_to_remove = {
  GOLD_IS_FOREVER = false,
  EXPLODING_GOLD = false,
  ATTRACT_ITEMS = false
}
-- only removes gold is forever if it's disabled and also running classic mode
if (ModSettingGetNextValue("wormhole_wallet.ww_goldisforever") == "false" and ModSettingGetNextValue("wormhole_wallet.ww_classicmode") == "true") -- v1.3.1 enclosed the 2nd mod check with quotation marks as expected
then
	perks_to_remove.GOLD_IS_FOREVER = true
end

if (ModSettingGetNextValue("wormhole_wallet.ww_explodinggold") == "false")
then
	perks_to_remove.EXPLODING_GOLD = true
end

if (ModSettingGetNextValue("wormhole_wallet.ww_goldmagnet") == "false")
then
	perks_to_remove.ATTRACT_ITEMS = true
end

for i, perk in ipairs(perk_list) do
  if perks_to_remove[perk.id] then
    perk.not_in_default_perk_pool = true
  end
end
