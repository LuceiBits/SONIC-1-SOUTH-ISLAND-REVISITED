    var col = player_act_solid(id);
    
    if (state == DOOR.MOVING){
        x = math_approach(x, reach_x, image_yscale*4);
        y = math_approach(y, reach_y, image_yscale*4);
        
        if (x == reach_x && y == reach_y) {
            moved = !moved;
            state = DOOR.IDLE;
        }
    }
    else {
        reach_x = x + sprite_height * ((moved)? -1 : 1) * ((reverse)? -1 : 1) * dsin(image_angle);
        reach_y = y + sprite_height * ((moved)? -1 : 1) * ((reverse)? -1 : 1) * dcos(image_angle);
    }