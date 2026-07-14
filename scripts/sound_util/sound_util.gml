function sound_play(sound, loop = false, gain = 1.0, interrupt = true)
{
	//Stop the audio before playing so it doesn't overlay
	if(interrupt)
		audio_stop_sound(sound);
	
	//Play the sound
	return audio_play_sound_on(obj_global.sfx_emitter, sound, 0, loop, global.sfx_volume * gain);
}