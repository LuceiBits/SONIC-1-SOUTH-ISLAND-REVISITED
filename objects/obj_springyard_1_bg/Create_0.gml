/// @description Add background
	
	//Inherit the parent event
	event_inherited();
	

	//Add backgrounds, ID starting out from 0, increments by 1 with each background added
	//Note: THE "FRAME" ARGUMENT IN THE BG'S IS NOT THE ID! IT'S THE FRAME OF THE BACKGROUND'S SPRITE ON CREATE!
	
	// You may use fractions as parallax factors too!
	var scroll_x = 0.70
	var scroll_y = 0.88
	
	background_add(bg_springyard_far, 0, scroll_x,scroll_y, 0, 0, 0, 0 + general_offset,false); //ID 0
	
	scroll_x = 0.80
	
	background_add(bg_springyard_far, 1, scroll_x,scroll_y, 0, 0, 0, 0 + general_offset, false); //ID 1
	
	scroll_x = 10
	
	var g = 2

	
	repeat(7)
	{

		background_add(bg_springyard_far, g,0.95 - ((g)/100),scroll_y, (0 + g/2 / 4) * -1, 0, 0, 0 + general_offset, false); //ID 2
		g += 1	
	}
	
	// GRASS AT BOTTOM
	
	scroll_x = 0.60
	var init_offset = 304 - 16.5
	g = 1
	var g_save = g
	var frame = 0
	
	repeat(7)
	{	
		
	if g < 9
	frame = 3
	if g < 8
	frame = 2
	if g < 6
	frame = 1	
	if g < 2
	frame = 0
	
	background_add(bg_springyard_grass,frame,scroll_x - (0.05 * g),scroll_y, 0, 0, 0 + (16 * g),16 * g + init_offset + general_offset, false);
		g += 1
	}
	//background_add_line(bg_springyard_grass,1,scroll_x,scroll_y, 0, 0, 0,32, false);	
	//background_add_line(bg_springyard_grass,2,scroll_x,scroll_y, 0, 0, 0,48, false);	
	//background_add_line(bg_springyard_grass,3,scroll_x,scroll_y, 0, 0, 0,48, false);	
	//background_add_line(bg_springyard_grass,4,scroll_x,scroll_y, 0, 0, 0,64, false);
	//background_add_line(bg_springyard_grass,5,scroll_x,scroll_y, 0, 0, 0,80, false);
	//background_add_line(bg_springyard_grass,6,scroll_x,scroll_y, 0, 0, 0,96, false);
	
	scroll_x = 0.20
	init_offset += (16*g) - 8
	// add by 8 from this point on
	g = 1
	repeat(13)
	{
	background_add(bg_springyard_grass,4,scroll_x - (0.02 * g),scroll_y, 0, 0, 0,(8 * g) + init_offset + general_offset, false);
	g += 1
	}

	
	
	//background_add(bg_springyard_far, 2, scroll_x,scroll_y, 1, 0, 0, 0, false); //ID 2
	//background_add(bg_springyard_far, 3, scroll_x,scroll_y, 2, 0, 0, 0, false); //ID 3
	//background_add(bg_springyard_far, 4, scroll_x,scroll_y, 3, 0, 0, 0, false); //ID 4
	//background_add(bg_springyard_far, 5, scroll_x,scroll_y, 4, 0, 0, 0, false); //ID 5
	//background_add(bg_springyard_far, 6, scroll_x,scroll_y, 5, 0, 0, 0, false); //ID 6
	//background_add(bg_springyard_far, 7, scroll_x,scroll_y, 6, 0, 0, 0, false); //ID 7
	//background_add(bg_springyard_far, 8, scroll_x,scroll_y, 7, 0, 0, 0, true); //ID 8
	
	

	
	// HCZ-like 3d water parallax
	//background_add_line(spr_bg_aaz_water, 1, 2/3, 2/3, 0, 0, 0, 930, 1, (2/3)/96); //ID 17 - this will be accessed later in Draw
	
	/* In the above example, 2/3 is the X factor of the top part of the water, and 96 is the height.
	This allows for the top of the water parallax to be the same speed as the horizon and the bottom
	of the water parallax to be the same speed as the foreground. In previous versions of Harmony
	Framework the calculation for the speeds was done in a way that required extra math to be done
	for this effect, but now it can be done with a single divison!*/
