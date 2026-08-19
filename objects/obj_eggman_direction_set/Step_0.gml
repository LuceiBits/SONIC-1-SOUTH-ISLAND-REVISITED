if instance_place(x,y,obj_eggman_emeraldchase)
with instance_place(x,y,obj_eggman_emeraldchase)
{	
	
	
	
	if movedir_x != other.movedir_x || movedir_y != other.movedir_y
		{
		aligning = true
		x = math_approach(x,other.x,movespeed)
		y = math_approach(y,other.y,movespeed)
		}

	if point_distance(x,y,other.x,other.y) < 4
		{
		movedir_x = other.movedir_x
		movedir_y = other.movedir_y
		aligning = false
		}
}