/// @description Add background
	
	//Inherit the parent event
	event_inherited();
	
	//Vertical scroll factor
	var v_scroll = 0.7;
	
	//Add backgrounds, ID starting out from 0, increments by 1 with each background added
	background_add(temp_bg, 0, 1, 1, 0, -0.50, 0, 0, true); // ID: 0
	background_add(temp_bg_1, 0, 0.8, 0.8, -0.25, 0, 0, 0, true); // ID: 1