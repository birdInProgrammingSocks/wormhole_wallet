-- List of files that use settings registered in this file:
-- -> files/drop_money.lua
-- -> init.lua
-- -> files/remove_useless_perks.lua

dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.

-- This file can't access other files from this or other mods in all circumstances.
-- Settings will be automatically saved.
-- Settings don't have access unsafe lua APIs.

-- Use ModSettingGet() in the game to query settings.
-- For some settings (for example those that affect world generation) you might want to retain the current value until a certain point, even
-- if the player has changed the setting while playing.
-- To make it easy to define settings like that, each setting has a "scope" (e.g. MOD_SETTING_SCOPE_NEW_GAME) that will define when the changes
-- will actually become visible via ModSettingGet(). In the case of MOD_SETTING_SCOPE_NEW_GAME the value at the start of the run will be visible
-- until the player starts a new game.
-- ModSettingSetNextValue() will set the buffered value, that will later become visible via ModSettingGet(), unless the setting scope is MOD_SETTING_SCOPE_RUNTIME.

local mod_id = "wormhole_wallet" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings = 
{
	{
		id = "_",
		ui_name = "Balancing issues? Customize your settings here.",
		not_setting = true,
	},
	{
		category_id = "modmode",
		ui_name = "Game Mode - Applies on New Game",
		ui_description = "Choose whether to run the mod in Classic Mode or Perk Mode.\nDefault: Classic Mode.",
		settings = {
			{
				id = "ww_classicmode",
				ui_name = "Mod Mode",
				ui_description = "In Classic Mode, Wormhole Wallet is always active.\nIn Perk Mode, the effect applies only when you have Gold is Forever.\nPerk Mode forces Gold is Forever to remain in perk pool regardless of removal setting.",
				value_default = "true",
				values = { {"true","Classic Mode"}, {"false","Perk Mode"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
		},
	},
	{
		category_id = "multipliers",
		ui_name = "Multipliers - Applies Immediately",
		ui_description = "Use these settings to control money and HP multipliers for the Wormhole Wallet.",
		settings = {
			{
				id = "ww_moneymultiplier",
				ui_name = "Money Multiplier",
				ui_description = "Modifies the value of gold nuggets.\nReduce if you're earning too much money.\nDoes not apply to nuggets from chests.\nDefault: 100%\nWARN: Money collected will round down to next integer!",
				value_default = 100,
				value_min = 0,
				value_max = 200,
				value_display_formatting = " $0%"
			},
			{
				id = "ww_healmultiplier",
				ui_name = "Healing Multiplier",
				ui_description = "Modifies the healing of blood nuggets.\nReduce if you're getting too much health from blood greed.\nDefault: 100%",
				value_default = 100,
				value_min = 0,
				value_max = 200,
				value_display_formatting = " $0%"
			},
		},
	},
	{
		category_id = "optionaleffects",
		ui_name = "Cosmetic Effects - Applies on Game Restart\nWARN: May Reduce Mod Compatibility",
		ui_description = "Use these settings to control optional cosmetic effects.\nThese settings apply on game restart.\nWARN: While unlikely, this may reduce compatibility with other mods.",
		settings = {
			{
				id = "ww_goldaudio",
				ui_name = "Gold Audio",
				ui_description = "Controls whether audio will play as gold is picked up.\nEnabled by default",
				value_default = "true",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
			{
				id = "ww_goldsparkles",
				ui_name = "Gold Sparkle Particles",
				ui_description = "Controls whether gold will generate sparkle particles when picked up.\nEnabled by default",
				value_default = "true",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
			{
				id = "ww_goldpickupglow",
				ui_name = "Gold Pickup Glow",
				ui_description = "Controls whether gold will leave a residual glow when picked up.\nEnabled by default",
				value_default = "true",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},			
            {
				id = "ww_healingparticles",
				ui_name = "Healing Particles",
				ui_description = "Controls whether blood gold will leave green particles when picked up.\nEnabled by default\nWARN: Disabling will break particles from sources like Healthy Exploration as well!",
				value_default = "true",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
            {
				id = "ww_healingaudio",
				ui_name = "Healing Audio",
				ui_description = "Controls whether blood gold will play the healing sound effect.\nEnabled by default\nWARN: Disabling will break audio from sources like Healthy Exploration as well!",
				value_default = "true",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},

		},
	},
	{
		category_id = "killperks",
		ui_name = "Spawn Useless Perks - Applies on Game Restart\nCannot change existing spawned perks",
		ui_description = "Use these settings to control whether useless perks spawn.\nEnabled will spawn, disabled will not spawn.",
		settings = {
			{
				id = "ww_goldisforever",
				ui_name = "Gold is Forever",
				ui_description = "Controls whether Gold is Forever is in the perk pool.\nDisabled by default.\nWill stay in the pool anyway if Perk Mode is on.",
				value_default = "false",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
			{
				id = "ww_explodinggold",
				ui_name = "Exploding Gold",
				ui_description = "Controls whether Exploding Gold is in the perk pool.\nDisabled by default.",
				value_default = "false",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
			{
				id = "ww_goldmagnet",
				ui_name = "Attract Gold",
				ui_description = "Controls whether Attract Gold is in the perk pool.\nDisabled by default.",
				value_default = "false",
				values = { {"true","Enabled"}, {"false","Disabled"} },
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
		},
	},
}

-- This function is called to ensure the correct setting values are visible to the game via ModSettingGet(). your mod's settings don't work if you don't have a function like this defined in settings.lua.
-- This function is called:
--		- when entering the mod settings menu (init_scope will be MOD_SETTINGS_SCOPE_ONLY_SET_DEFAULT)
-- 		- before mod initialization when starting a new game (init_scope will be MOD_SETTING_SCOPE_NEW_GAME)
--		- when entering the game after a restart (init_scope will be MOD_SETTING_SCOPE_RESTART)
--		- at the end of an update when mod settings have been changed via ModSettingsSetNextValue() and the game is unpaused (init_scope will be MOD_SETTINGS_SCOPE_RUNTIME)
function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

-- This function should return the number of visible setting UI elements.
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic.
-- The value will be used to determine whether or not to display various UI elements that link to mod settings.
-- At the moment it is fine to simply return 0 or 1 in a custom implementation, but we don't guarantee that will be the case in the future.
-- This function is called every frame when in the settings menu.
function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )

	--example usage:
	--[[
	GuiLayoutBeginLayer( gui )

	GuiBeginAutoBox( gui )

	GuiZSet( gui, 10 )
	GuiZSetForNextWidget( gui, 11 )
	GuiText( gui, 50, 50, "Gui*AutoBox*")
	GuiImage( gui, im_id, 50, 60, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiZSetForNextWidget( gui, 13 )
	GuiImage( gui, im_id, 60, 150, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )

	GuiZSetForNextWidget( gui, 12 )
	GuiEndAutoBoxNinePiece( gui )

	GuiZSetForNextWidget( gui, 11 )
	GuiImageNinePiece( gui, 12368912341, 10, 10, 80, 20 )
	GuiText( gui, 15, 15, "GuiImageNinePiece")

	GuiBeginScrollContainer( gui, 1233451, 500, 100, 100, 100 )
	GuiLayoutBeginVertical( gui, 0, 0 )
	GuiText( gui, 10, 0, "GuiScrollContainer")
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiImage( gui, im_id, 10, 0, "data/ui_gfx/game_over_menu/game_over.png", 1, 1, 0 )
	GuiLayoutEnd( gui )
	GuiEndScrollContainer( gui )

	local c,rc,hov,x,y,w,h = GuiGetPreviousWidgetInfo( gui )
	print( tostring(c) .. " " .. tostring(rc) .." " .. tostring(hov) .." " .. tostring(x) .." " .. tostring(y) .." " .. tostring(w) .." ".. tostring(h) )

	GuiLayoutEndLayer( gui )]]--
end
