/// @description Player end scripts

	//Cancel when in debug mode
	if(debug)
	{
		exit;	
	}
	
	// Position the shield
	with(shield_obj)
	{
		// Position the shield to the player object
		x = floor(parent.x);
		y = floor(parent.y);	
	}