live_auto_call

if !surface_exists(surf)
	surf = surface_create(sprite_width, sprite_height)
else
{
	surface_set_target(surf)
	
	var _scroll = global.object_timer
	draw_sprite_tiled_ext(spr_platform_tube, 0, 0, _scroll, 1, 0.5, c_white, 1)
	
	surface_reset_target()
	
	// this is really really really finnicky i don't know what any of this does but it works
	var deform_x		= 1
	var deform_y		= 1
	var deform_size		= 1
	var max_distortion	= sqrt(0.25 - power(-deform_x * 0.5, 2.0)) * deform_size + deform_size * 0.5;
	
	shader_set(shd_tube)
	shader_set_uniform_f(u_deform, deform_x, deform_y, deform_size, max_distortion);	
	draw_surface(surf, x, y)
	shader_reset()
	
	
	var _sub_color = #480024
	_sub_color = colour_add_hsv(_sub_color, 0, 0, 0)
	_sub_color = colour_get_inverse(_sub_color)
	
	gpu_set_blendmode(bm_subtract)
	gpu_set_tex_filter(true)
	draw_sprite_stretched_ext(spr_platform_tube_substract, 0, x, y, sprite_width, sprite_height, _sub_color, 1)
	gpu_set_tex_filter(false)
	gpu_set_blendmode(bm_normal)
}