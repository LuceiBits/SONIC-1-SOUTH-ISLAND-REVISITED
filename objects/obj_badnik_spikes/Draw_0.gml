var _wheelframe = -1
if waittimer > 0
	_wheelframe = 0

draw_sprite_ext(spr_spikes_wheel, _wheelframe, x, y, image_xscale, 1, image_angle, image_blend, image_alpha)

draw_animator(animator);