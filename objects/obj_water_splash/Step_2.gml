	// Reposition splash
	y = (par.object_index = obj_water_pool)? par.pos_y : par.y;
	
	// Update the animator
	animator_update(animator);
	
	// Destroy if effect is off-screen or if the animation is done
	if(!instance_on_screen(16, 16) || animator.animation_finished)
	{
		instance_destroy();
	}