/// @description Add background
	
	//Inherit the parent event
	event_inherited();
	
	//Add backgrounds, ID starting out from 0, increments by 1 with each background added
	//Note: THE "FRAME" ARGUMENT IN THE BG'S IS NOT THE ID! IT'S THE FRAME OF THE BACKGROUND'S SPRITE ON CREATE!
	
	// You may use fractions as parallax factors too!
	background_add(bg_labyrinth_hl, 0, 2/3, 2/3, 0, 0, 0, 512, true); //ID 0
	background_add_line(spr_bg_aaz_water, 1, 2/3, 2/3, 0, 0, 0, 4100, 1, (2/3)/96); //ID 1
	

	
	// HCZ-like 3d water parallax
	//background_add_line(spr_bg_aaz_water, 1, 2/3, 2/3, 0, 0, 0, 930, 1, (2/3)/96); //ID 17 - this will be accessed later in Draw
	
	/* In the above example, 2/3 is the X factor of the top part of the water, and 96 is the height.
	This allows for the top of the water parallax to be the same speed as the horizon and the bottom
	of the water parallax to be the same speed as the foreground. In previous versions of Harmony
	Framework the calculation for the speeds was done in a way that required extra math to be done
	for this effect, but now it can be done with a single divison!*/
