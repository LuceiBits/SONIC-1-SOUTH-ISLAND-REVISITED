/// @self
/// @description							Function used for playing a sound effect
/// @param {Asset.Sound} sound				The index of the sound to use
/// @param {Bool} loop						The flag to make sound loop or not
/// @param {Real} gain						Sets the gain of the sound effect
/// @param {Bool} interrupt					The flag to make the sound interrupt when played or not
/// @param {Id.AudioEmitter} emitter		The index of the sound emitter to use
/// @returns {Id.Sound}

function sound_play(sound, loop = false, gain = 1.0, interrupt = true, emitter = obj_global.sfx_emitter)
{
	//Stop the audio before playing so it doesn't overlay
	if(interrupt)
		audio_stop_sound(sound);
	
	//Play the sound
	return audio_play_sound_on(emitter, sound, 0, loop, global.sfx_volume * gain);
}