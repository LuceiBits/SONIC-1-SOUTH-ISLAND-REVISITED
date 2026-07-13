			
switch(state){
	case 0:
		animation_set_frame(sonic_ani,0);
		if (obj_global.fade.timer == 512){
			state = 1;	
		}
	break;
	case 1:
		animation_set_frame(sonic_ani,0);
		sonic_offset -= 8;
		if (sonic_offset < 0) {
			sonic_offset = 0;
			state = 2;
		}
	break;
	case 2:
		if (animation_has_finished(sonic_ani) && animation_is_playing(sonic_ani,0)){
			animation_play(sonic_ani,1);
			state = 3;
		}
	break;
	default:
	break;
}

animator_update(sonic_ani);

if (state > 1 && state < 4){
	if (input_press(INPUT.START)){
		state = 4;
		fade_to_room_next(5)
	}
}