/// @description Input checks	
	if(instance_exists(obj_shell) && !obj_shell.isOpen || !instance_exists(obj_shell))
	{
		var player_shoulder_down = instance_exists(obj_player) ? gamepad_button_check(global.gamepad_slot, gp_shoulderlb) || gamepad_button_check(global.gamepad_slot, gp_shoulderrb) : false;
		var player_shoulder_down_press = instance_exists(obj_player) ? gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderlb) || gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderrb) : false;
		
		Up = keyboard_check(global.up) || gamepad_button_check(global.gamepad_slot, gp_padu);
		Down = keyboard_check(global.down) || gamepad_button_check(global.gamepad_slot, gp_padd) || player_shoulder_down;
		Left = keyboard_check(global.left) || gamepad_button_check(global.gamepad_slot, gp_padl);
		Right = keyboard_check(global.right) || gamepad_button_check(global.gamepad_slot, gp_padr);
		A = keyboard_check(global.a) || gamepad_button_check(global.gamepad_slot, gp_face1);
		B = keyboard_check(global.b) || gamepad_button_check(global.gamepad_slot, gp_face2);
		C = keyboard_check(global.c) || gamepad_button_check(global.gamepad_slot, gp_face3);
		Action = A || B || C;
		Start = keyboard_check(global.start) || gamepad_button_check(global.gamepad_slot, gp_start);
		BumperL = gamepad_button_check(global.gamepad_slot, gp_shoulderl);
		BumperR = gamepad_button_check(global.gamepad_slot, gp_shoulderr);
		
		axis_l_h = 0.0;
		axis_l_v = 0.0;
		axis_r_h = 0.0;
		axis_r_v = 0.0;
		
		var lh = gamepad_axis_value(global.gamepad_slot, 0);
		var lv = gamepad_axis_value(global.gamepad_slot, 1);
		var rh = gamepad_axis_value(global.gamepad_slot, 2);
		var rv = gamepad_axis_value(global.gamepad_slot, 4);
		
		if (abs(lh) >= deadzone_x) axis_l_h = sign(lh) * ((abs(lh) - deadzone_x) / (1.0 - deadzone_x));
		if (abs(lv) >= deadzone_y) axis_l_v = sign(lv) * ((abs(lv) - deadzone_y) / (1.0 - deadzone_y));
		if (abs(rh) >= deadzone_x) axis_r_h = sign(rh) * ((abs(rh) - deadzone_x) / (1.0 - deadzone_x));
		if (abs(rv) >= deadzone_y) axis_r_v = sign(rv) * ((abs(rv) - deadzone_y) / (1.0 - deadzone_y));
		
		//Pressed
		UpPress = keyboard_check_pressed(global.up) || gamepad_button_check_pressed(global.gamepad_slot, gp_padu);
		DownPress = keyboard_check_pressed(global.down) || gamepad_button_check_pressed(global.gamepad_slot, gp_padd) || player_shoulder_down_press;
		LeftPress = keyboard_check_pressed(global.left) || gamepad_button_check_pressed(global.gamepad_slot, gp_padl);
		RightPress = keyboard_check_pressed(global.right) || gamepad_button_check_pressed(global.gamepad_slot, gp_padr);
		APress = keyboard_check_pressed(global.a) || gamepad_button_check_pressed(global.gamepad_slot, gp_face1);
		BPress = keyboard_check_pressed(global.b) || gamepad_button_check_pressed(global.gamepad_slot, gp_face2);
		CPress = keyboard_check_pressed(global.c) || gamepad_button_check_pressed(global.gamepad_slot, gp_face3);
		ActionPress = APress || BPress || CPress;
		StartPress = keyboard_check_pressed(global.start) || gamepad_button_check_pressed(global.gamepad_slot, gp_start);
		BumperLPress = gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderl);
		BumperRPress = gamepad_button_check_pressed(global.gamepad_slot, gp_shoulderr);
		
		//Analog input presses
		event_user(0);
	}else
	{
		//Hold keys
		Up = false;
		Down = false;
		Left = false;
		Right = false;
		A = false;
		B = false;
		C = false;
		Action = false;
		Start = false;
		BumperL = false;
		BumperR = false;
		axis_l_h = 0.0;
		axis_r_h = 0.0;
	}
	
	if(vibration_timer > 0)
	{
		gamepad_set_vibration(global.gamepad_slot, vibration_strenght, vibration_strenght);
	}
	else
	{
		gamepad_set_vibration(global.gamepad_slot, 0, 0);
	}
	
	vibration_timer = max(vibration_timer-1, 0);