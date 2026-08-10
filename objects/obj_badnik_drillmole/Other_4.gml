/// @description Destroy if stored
if (!instance_exists(obj_bonus_cont)) 
{
	if (global.store_object_state[| id]) 
	{
		instance_destroy()	
	}
}
