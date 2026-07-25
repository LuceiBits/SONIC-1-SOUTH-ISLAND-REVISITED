/// @description Stage start
	//Play stage music
	music_play(stage_music, 0);
	
	//Reset stage data
	global.stage_timer = 0;
	global.allow_stage_restart = level_state = LEVEL_STATE.NORMAL ? true : false;
	
	//Position player to the checkpoint
	if(global.checkpoint_id != noone && instance_exists(global.checkpoint_id) && global.checkpoint_type = CHECKPOINT.NORMAL)
	{
		obj_player.x = global.checkpoint_id.x;
		obj_player.y = global.checkpoint_id.bbox_bottom - obj_player.hitbox_h;
		obj_camera.target_x = obj_player.x;
		obj_camera.target_y = obj_player.y-16;
		global.stage_timer = global.time_store;
		if (global.checkpoint_id.face_left) 
		{
			obj_player.facing = -1	
		}
	}
	
	if(global.checkpoint_type = CHECKPOINT.SPECIAL_RING)
	{
		obj_player.x = global.special_ring_x;
		obj_player.y = global.special_ring_y;
		
		obj_camera.target_x = obj_player.x;
		obj_camera.target_y = obj_player.y - 16;
		
		global.stage_timer = global.time_store;
		
		global.checkpoint_type = CHECKPOINT.NORMAL;
	}
	
	if(level_state == LEVEL_STATE.BONUS)
		exit;
		
	var force_visible_for_new_keys = level_state != LEVEL_STATE.BONUS && array_length(variable_struct_get_names(global.store_background_visibility)) == 0;

	for (var i = 0; i < instance_number(par_background); ++i)
	{
		var bg = instance_find(par_background, i);
		var name = object_get_name(bg.object_index);
		
		if (variable_struct_exists(global.store_background_visibility, name)) 
		{
			bg.visible = global.store_background_visibility[$ name];
			continue; 
		}
		
		global.store_background_visibility[$ name] = force_visible_for_new_keys ? bg.visible : false;
		
		bg.visible = global.store_background_visibility[$ name];
	}
	
	show_debug_message(global.store_background_visibility);
	