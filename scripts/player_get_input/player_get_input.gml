/// @self					obj_player	
/// @description			Function that handles player's interaction with the input system
function player_get_input()
{
	//Button holds
	hold_up = input_hold(INPUT.UP);
	hold_down = input_hold(INPUT.DOWN);
	hold_left = input_hold(INPUT.LEFT);
	hold_right = input_hold(INPUT.RIGHT);
	hold_a = input_hold(INPUT.A);
	hold_b = input_hold(INPUT.B);
	hold_c = input_hold(INPUT.C);
	hold_action = hold_a || hold_b || hold_c;
	
	//Button holds
	press_up = input_press(INPUT.UP);
	press_down = input_press(INPUT.DOWN);
	press_left = input_press(INPUT.LEFT);
	press_right = input_press(INPUT.RIGHT);
	press_a = input_press(INPUT.A);
	press_b = input_press(INPUT.B);
	press_c = input_press(INPUT.C);
	press_action = press_a || press_b || press_c;	
	
	//Disable inputs
	if(input_disable)
	{
		//Button holds
		hold_up = false;
		hold_down = false;
		hold_left = false;
		hold_right = false;
		hold_a = false;
		hold_b = false;
		hold_c = false;
		hold_action = false;
	
		//Button holds
		press_up = false;
		press_down = false;
		press_left = false;
		press_right = false;
		press_a = false;
		press_b = false;
		press_c = false;
		press_action = false;	
	}
	
	//Shell related
	if(instance_exists(obj_shell) && obj_shell.isOpen)
	{
		//Button holds
		hold_up = false;
		hold_down = false;
		hold_left = false;
		hold_right = false;
		hold_a = false;
		hold_b = false;
		hold_c = false;
		hold_action = false;
	
		//Button holds
		press_up = false;
		press_down = false;
		press_left = false;
		press_right = false;
		press_a = false;
		press_b = false;
		press_c = false;
		press_action = false;	
	}
}