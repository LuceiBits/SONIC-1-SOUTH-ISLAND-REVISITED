image_yscale -= 0.5
if image_yscale < 0
	image_yscale = 0
if in_camera()
{
	if sound != noone
		audio_stop_sound(sound)
	sound = sound_play(sfx_break1, , 0.5)
	audio_sound_pitch(sound, 2)
}

instance_create_particle(x + 8 + irandom_range(-8, 8), bbox_bottom - 8 + irandom_range(-8, 8), spr_effect_explosion01, 0.3);

if image_yscale <= 0
	instance_destroy()
else
	alarm[0] = 10