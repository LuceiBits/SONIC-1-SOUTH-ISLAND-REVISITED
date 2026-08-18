var g = (bbox_bottom - obj_water.y) + 4 // get offset from origin of sprite and position of water to properly cull

draw_sprite_part(sprite_index,image_index,0,0,sprite_width,sprite_height - g,x,y) // cull by subtracting offset (g) from sprite_height (relative bottom bound)