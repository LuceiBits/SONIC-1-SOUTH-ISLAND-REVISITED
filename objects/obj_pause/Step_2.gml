var actionPress = input_press(INPUT.A) || input_press(INPUT.B) || input_press(INPUT.C) || input_press(INPUT.START);

if(actionPress){
	if delay > 2 
	{
		global.process_objects = true;
		audio_resume_all();
		surface_free(pausemenu);
		pausemenu = -1;
		instance_destroy();
	}
}