

if timer > 0
timer -= 1

if timer <= 0
{
	
	
	if spawn_type = "both_sides"
	{
	if alternator = 0
	{
	instance_create_depth(bbox_left,bbox_top,0,obj_log_platform)	
	}
	else
	instance_create_depth(bbox_right,bbox_top,0,obj_log_platform)
	}

	if spawn_type = "center_only"
	{
		if alternator = 0
		{
		// do nothing
		}
		else
		instance_create_depth(x,bbox_top,0,obj_log_platform)
	}

if spawn_type = "three"
{
	if alternator = 0
	{
	instance_create_depth(bbox_left,bbox_top,0,obj_log_platform)
	}

	if alternator = 1 || alternator = 3
	{
	instance_create_depth(x,bbox_top,0,obj_log_platform)
	}

	if alternator = 2
	{
	instance_create_depth(bbox_right,bbox_top,0,obj_log_platform)
	}

}

alternator += 1
timer = timer_init_log 
}

if spawn_type != "three"
{
if alternator > 1
alternator = 0
}
else
{
if alternator > 3
alternator = 0	
}