	//Essential values
	zone_sel = 0;
	act_sel = 0;
	sound_sel = 0;
	sound_arr = ds_map_keys_to_array(global.music_map);
	
	show_debug_message("key for map 0")
	show_debug_message(sound_arr[0])
	
	//The lists
	zone_list = [["ARBOREAL AGATE", rm_arboreal_agate1, rm_arboreal_agate2],
	["TEST STAGE", rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower],
	["TEST STAGE1", rm_techdemo_tower],
	["TEST STAGE2", rm_techdemo_tower],
	["TEST STAGE3", rm_techdemo_tower],
	["TEST STAGE4", rm_techdemo_tower],
	["TEST STAGE5", rm_techdemo_tower],
	["TEST STAGE6", rm_techdemo_tower],
	["TEST STAGE7", rm_techdemo_tower],
	["TEST STAGE8", rm_techdemo_tower],
	["TEST STAGE9", rm_techdemo_tower],
	["TEST STAGE67", rm_techdemo_tower],
	["TEST STAGE69", rm_techdemo_tower],
	["TEST STAGE420", rm_techdemo_tower],
	["TEST STAGElol", rm_techdemo_tower],
	["TEST STAGE6969", rm_techdemo_tower],
	["TEST STAGE420", rm_techdemo_tower],
	["TEST STAGE720", rm_techdemo_tower],
	["TEST STAGErtter", rm_techdemo_tower],
	["TEST STAGEbigger", rm_techdemo_tower],
	["TEST STAGEcritter", rm_techdemo_tower],
	["TEST STAGElitter", rm_techdemo_tower],
	["TEST STAGEnagger", rm_techdemo_tower],
	["TEST STAGEblitter", rm_techdemo_tower],
	["TEST STAGEbitter", rm_techdemo_tower],
	["TEST STAGEwiitter", rm_techdemo_tower],
	["TEST STAGEmitter", rm_techdemo_tower],
	["TEST STAGEwriyrte", rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower, rm_techdemo_tower],
	["BLUE SPHERES", rm_blue_spheres]];
	
	level_reset_data();
	level_reset_bg_visibility();
	global.score = 0;

	quotes = ["WELCOME TO HARMONY FRAMEWORK!"];
	
	quote_index = irandom(array_length(quotes)-1);
	
	//Randomize the BG
	image_speed = 0;
	image_index = 0//irandom(image_number);
	
	fade_in_room(5);
	music_play(MUSIC.MENU);
	
	//Create stage data
	for (var i = 0; i < 128; ++i) 
	{
	    deform_data[i] = 12 * dsin((360 / 128) * i);
	}