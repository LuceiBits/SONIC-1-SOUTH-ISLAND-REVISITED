	//Essential values
	zone_sel = 0;
	act_sel = 0;
	sound_sel = 0;
	sound_arr = ds_map_keys_to_array(global.music_map);
	
	show_debug_message("key for map 0")
	show_debug_message(sound_arr[0])
	
	//The lists
	zone_list = [["ARBOREAL AGATE", rm_arboreal_agate1, rm_arboreal_agate2],
	["TEST STAGE", rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone],
	["TEST STAGE1", rm_your_zone],
	["TEST STAGE2", rm_your_zone],
	["TEST STAGE3", rm_your_zone],
	["TEST STAGE4", rm_your_zone],
	["TEST STAGE5", rm_your_zone],
	["TEST STAGE6", rm_your_zone],
	["TEST STAGE7", rm_your_zone],
	["TEST STAGE8", rm_your_zone],
	["TEST STAGE9", rm_your_zone],
	["TEST STAGE67", rm_your_zone],
	["TEST STAGE69", rm_your_zone],
	["TEST STAGE420", rm_your_zone],
	["TEST STAGElol", rm_your_zone],
	["TEST STAGE6969", rm_your_zone],
	["TEST STAGE420", rm_your_zone],
	["TEST STAGE720", rm_your_zone],
	["TEST STAGErtter", rm_your_zone],
	["TEST STAGEbigger", rm_your_zone],
	["TEST STAGEcritter", rm_your_zone],
	["TEST STAGElitter", rm_your_zone],
	["TEST STAGEnagger", rm_your_zone],
	["TEST STAGEblitter", rm_your_zone],
	["TEST STAGEbitter", rm_your_zone],
	["TEST STAGEwiitter", rm_your_zone],
	["TEST STAGEmitter", rm_your_zone],
	["TEST STAGEwriyrte", rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone, rm_your_zone]];
	
	level_reset_data();
	level_reset_bg_visibility();
	global.score = 0;

	quotes = ["WELCOME TO HARMONY FRAMEWORK!"];
	
	quote_index = irandom(array_length(quotes)-1);
	
	//Randomize the BG
	image_speed = 0;
	image_index = 0//irandom(image_number);
	
	fade_in_room(5);
	play_music(MUSIC.MENU);
	
	//Create stage data
	for (var i = 0; i < 128; ++i) 
	{
	    deform_data[i] = 12 * dsin((360 / 128) * i);
	}