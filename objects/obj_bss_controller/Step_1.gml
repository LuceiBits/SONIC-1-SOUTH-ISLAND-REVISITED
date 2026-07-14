//Pause (Has to be done here I am afraid.)
if (input_active && input_press(INPUT.START) && !instance_exists(obj_pause) && !instance_exists(obj_game_over))
{
	instance_create_depth(0, 0, -100, obj_pause);
	obj_pause.allow_restart = false;
}