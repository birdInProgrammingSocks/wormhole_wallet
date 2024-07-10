dofile("settings.lua")

--Implement the entire core functionality of the mod
ModLuaFileAppend("data/scripts/items/drop_money.lua", "mods/wormhole_wallet/files/drop_money.lua")

--Implement auto pickup of chest drops
--DISABLED: Unfixable bug (as far as I can tell) makes chests only drop 10 gold.
--By all means please feel free to fix it yourself. Friend me (the author) on steam if you've written a patch you'd like to merge.'
--ModLuaFileAppend("data/scripts/items/chest_random.lua", "mods/wormhole_wallet/files/replace_chest_gold_code.lua")

--Implement useless perk removal (setting check within the appended file)
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/wormhole_wallet/files/remove_useless_perks.lua")

--Implement ability to remove XML attributes
local nxml = dofile_once("mods/wormhole_wallet/nxml.lua")
function removecomponents(files, componentname, count)
	for i, filename in ipairs(files) do
		local content = ModTextFileGetContent(filename)
		local xml = nxml.parse(content)
		for x=1,count,1 do
			local TargetComp = xml:first_of(componentname)
			xml:remove_child(TargetComp)
		end
		ModTextFileSetContent(filename, tostring(xml))
	end
end

--If sound disabled, remove sound property from xml (known working, even alongside disable sparkles)
if (ModSettingGetNextValue("wormhole_wallet.ww_goldaudio") == "false")
then
local files = {"data/entities/particles/gold_pickup.xml", "data/entities/particles/gold_pickup_large.xml", "data/entities/particles/gold_pickup_huge.xml"}
removecomponents(files,"AudioComponent",1)
end


-- If sparkles disabled, remove SpriteParticleEmitterComponents (known working, even alongside disable sound)
if (ModSettingGetNextValue("wormhole_wallet.ww_goldsparkles") == "false")
then
local files = {"data/entities/particles/gold_pickup.xml", "data/entities/particles/gold_pickup_large.xml", "data/entities/particles/gold_pickup_huge.xml", "data/entities/items/pickup/goldnugget.xml", "data/entities/items/pickup/goldnugget_10.xml", "data/entities/items/pickup/goldnugget_50.xml", "data/entities/items/pickup/goldnugget_200.xml", "data/entities/items/pickup/goldnugget_1000.xml", "data/entities/items/pickup/goldnugget_10000.xml", "data/entities/items/pickup/goldnugget_200000.xml"}
removecomponents(files,"SpriteParticleEmitterComponent",4)
end

-- If light disabled, remove light component
if (ModSettingGetNextValue("wormhole_wallet.ww_goldpickupglow") == "false")
then
local files = {"data/entities/particles/gold_pickup.xml", "data/entities/particles/gold_pickup_large.xml", "data/entities/particles/gold_pickup_huge.xml"}
removecomponents(files,"LightComponent",1)
end

-- If blood particles disabled, remove SpriteParticleEmitterComponents
if (ModSettingGetNextValue("wormhole_wallet.ww_healingparticles") == "false")
then
local files = {"data/entities/particles/heal.xml", "data/entities/particles/heal_effect.xml"}
removecomponents(files,"SpriteParticleEmitterComponent",1)
end

-- If healing audio disabled, remove audio component
if (ModSettingGetNextValue("wormhole_wallet.ww_healingaudio") == "false")
then
local files = {"data/entities/particles/heal_effect.xml"}
removecomponents(files,"AudioComponent",1)
end

