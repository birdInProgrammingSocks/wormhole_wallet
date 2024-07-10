old_but_gold_func = chest_load_gold_entity

dofile_once("data/scripts/items/gold_pickup.lua")

function chest_load_gold_entity( entity_filename, x, y, remove_timer )
	local eid = load_gold_entity( entity_filename, x, y, remove_timer )
	local item_comp = EntityGetFirstComponent( eid, "ItemComponent" )

	--following line is original comment. i got rid of the delay :)
	-- auto_pickup e.g. gold should have a delay in the next_frame_pickable, since they get gobbled up too fast by the player to see
	if item_comp ~= nil then
		if( ComponentGetValue2( item_comp, "auto_pickup") ) then
			ComponentSetValue2( item_comp, "next_frame_pickable", GameGetFrameNum() + 30 )	
		end
	end

	local player_entity = EntityGetWithTag("player_unit")[1]
	item_pickup(eid, player_entity, "$item_goldnugget")
end