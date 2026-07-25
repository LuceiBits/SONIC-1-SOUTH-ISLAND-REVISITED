/// @description Add background
	
	//Inherit the parent event
	event_inherited();
	
	//Add backgrounds, ID starting out from 0, increments by 1 with each background added
	//Note: THE "FRAME" ARGUMENT IN THE BG'S IS NOT THE ID! IT'S THE FRAME OF THE BACKGROUND'S SPRITE ON CREATE!
	background_add(spr_bg_aaz_bottom, 5, 1, 1, 0, 0, 0, 0, false); //ID 0
	
	// You may use fractions as parallax factors too!
	background_add(spr_bg_aaz_ruins, 0, 2/3, 2/3, 0, 0, 0, 354, false); //ID 1
	background_add(spr_bg_aaz_ruins, 1, 2/3, 2/3, 0, 0, 0, 930, false); //ID 2
	background_add(spr_bg_aaz_ruins, 2, 1, 2/3, 0, 0, 0, 930, false); //ID 3
	background_add(spr_bg_aaz_ruins, 3, 0.9, 2/3, 0, 0, 0, 930, false); //ID 4
	background_add(spr_bg_aaz_ruins, 4, 0.85, 2/3, 0, 0, 0, 930, false); //ID 5
	background_add(spr_bg_aaz_ruins, 5, 0.82, 2/3, 0, 0, 0, 930, false); //ID 6
	background_add(spr_bg_aaz_ruins, 6, 0.78, 2/3, 0, 0, 0, 930, false); //ID 7
	background_add(spr_bg_aaz_ruins, 7, 0.76, 2/3, 0, 0, 0, 930, false); //ID 8
	background_add(spr_bg_aaz_ruins, 8, 0.7, 2/3, 0, 0, 0, 930, false); //ID 9
	background_add(spr_bg_aaz_ruins, 9, 0.6, 2/3, 0, 0, 0, 930, false); //ID 10
	background_add(spr_bg_aaz_ruins, 10, 0.55, 2/3, 0, 0, 0, 930, false); //ID 11
	background_add(spr_bg_aaz_ruins, 11, 1/2, 2/3, 0, 0, 0, 930, false); //ID 12
	
	// HCZ-like 3d water parallax
	background_add_line(spr_bg_aaz_water, 1, 2/3, 2/3, 0, 0, 0, 930, 1, (2/3)/96); //ID 13 - this will be accessed later in Draw
	
	/* In the above example, 2/3 is the X factor of the top part of the water, and 96 is the height.
	This allows for the top of the water parallax to be the same speed as the horizon and the bottom
	of the water parallax to be the same speed as the foreground. In previous versions of Harmony
	Framework the calculation for the speeds was done in a way that required extra math to be done
	for this effect, but now it can be done with a single divison!*/
