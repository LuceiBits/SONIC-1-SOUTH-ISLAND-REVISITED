	if(inst)
	{
		instance_deactivate_object(inst)	
	}
	
	if(keyboard_check_pressed(vk_space))
	{
		instance_activate_object(inst);
		inst = noone;
	}