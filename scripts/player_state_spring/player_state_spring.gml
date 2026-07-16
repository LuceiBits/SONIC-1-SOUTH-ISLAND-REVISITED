function player_state_spring(){
	
	//Change animation
	animation_play(animator, ANIM.SPRING);
	
	//Change state when falling
	if(y_speed >= 0 || ground) 
	{
		state = force_roll ? player_state_roll : player_state_normal;
	}
}