    enum DOOR {
    	IDLE, MOVING
    }
    state = DOOR.IDLE;
    
    reach_x = 0;
    reach_y = 0;
    moved = false;
    
    image_angle = abs(image_angle%180);