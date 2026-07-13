//draw backing
draw_self_floor();

//setup mask
gpu_set_stencil_enable(true);	
draw_clear_stencil(0); //resets to nothing
gpu_set_stencil_func(cmpfunc_always);
gpu_set_stencil_pass(stencilop_replace);
gpu_set_stencil_ref(128); //setup the mask values
draw_set_alpha(0); //make sure the mask doesnt show up
draw_sprite(spr_emblem_mask,0,floor(x),floor(y)); //apply it
draw_set_alpha(1); 

//then draw sonic
gpu_set_stencil_func(cmpfunc_equal); //only applies sonic sprite if it overlaps the masked area
gpu_set_stencil_pass(stencilop_incr_wrap);
gpu_set_stencil_ref(128);
draw_animator(sonic_ani,x-7,y - 24 + sonic_offset); //the sonic sprite
			
gpu_set_stencil_enable(false);
//end


