/// @description Script
	// Rotate sparkles
	angle_offset += 11.25 * player.facing;
	
	// Make sure they are in front of the player object
	depth = player.depth - 10;
	
	// Destroy if the player is not invincible anymore
	if(!player.invincible) 
		instance_destroy();