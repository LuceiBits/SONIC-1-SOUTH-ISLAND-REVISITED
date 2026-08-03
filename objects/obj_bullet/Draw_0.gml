var _prevBlend = gpu_get_blendmode()
if sprite_index = spr_projectile
	gpu_set_blendmode(bm_add)

draw_self()
gpu_set_blendmode(_prevBlend)