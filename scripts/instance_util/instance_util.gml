function instance_act_solid(o, hitbox_other = noone, this = id, this_hitbox = noone)
{	
	// Temps
	var sideH = 0;
	var sideV = 0;
	var colX = o.x;
	var colY = o.y;
	
	// Make hitboxes
	var thisHitbox = _instance_evaluate_hitbox(this, this_hitbox);
	var otherHitbox = _instance_evaluate_hitbox(o, hitbox_other);
	
	// Orientate hitboxes depending on scale
	thisHitbox = _instance_orient_hitbox(this, thisHitbox);
	otherHitbox = _instance_orient_hitbox(o, otherHitbox);
	
	// Horizontal collision
	if(this.y + thisHitbox[BBOX.TOP] < o.y + otherHitbox[BBOX.BOTTOM] && this.y + thisHitbox[BBOX.BOTTOM] > o.y + otherHitbox[BBOX.TOP])
	{
		var cenX = this.x + (thisHitbox[BBOX.RIGHT] + thisHitbox[BBOX.LEFT]) * 0.5;
		if(o.x <= cenX)
		{
			if(o.x + otherHitbox[BBOX.RIGHT] + 1 >= this.x + thisHitbox[BBOX.LEFT])
			{
				sideH = C_LEFT;
				colX = this.x + (thisHitbox[BBOX.LEFT] - otherHitbox[BBOX.RIGHT]) - 1;
			}
		} 
		else if(o.x + otherHitbox[BBOX.LEFT] <= this.x + thisHitbox[BBOX.RIGHT] + 1)
		{
			sideH = C_RIGHT;
			colX = this.x + (thisHitbox[BBOX.RIGHT] - otherHitbox[BBOX.LEFT]) + 1;
		}
	}
	
	// Vertical collision
	var cenY = this.y + (thisHitbox[BBOX.TOP] + thisHitbox[BBOX.BOTTOM]) * 0.5;
	if(this.x + thisHitbox[BBOX.LEFT] < o.x + otherHitbox[BBOX.RIGHT] && this.x + thisHitbox[BBOX.RIGHT] > o.x + otherHitbox[BBOX.LEFT])
	{
		if(o.y < cenY)
		{
			if(o.y + otherHitbox[BBOX.BOTTOM] + 1 >= this.y + thisHitbox[BBOX.TOP])
			{
				sideV = C_TOP;	
				colY = this.y + (thisHitbox[BBOX.TOP] - otherHitbox[BBOX.BOTTOM]) - 1;
			}
		} 
		else if(o.y + otherHitbox[BBOX.TOP] <= this.y + thisHitbox[BBOX.BOTTOM])
		{
			sideV = C_BOTTOM;	
			colY = this.y + (thisHitbox[BBOX.BOTTOM] - otherHitbox[BBOX.TOP]);
		}
	}
	
	// Temps
	var side = 0;
	var deltaX = colX - o.x;
	var deltaY = colY - o.y;
	 
	// Get the correct collision side
	if((deltaX * deltaX >= deltaY * deltaY && (sideV || !sideH)) || (!sideH && sideV))
	{
		side = sideV;	
	}
	else
	{
		side = sideH;	
	}
	
	// Build the result struct
	var r = {
		object : o,
		this_object : this,
		this_box : thisHitbox,
		col_side : side,
		col_x : colX,
		col_y : colY
	}
	
	// Check if this is a player object
	var isPlayer = o.object_index == obj_player;
	
	if(side != 0)
	{
		// If the other object is the player, then execute player's reaction to solid object
		if(isPlayer)
		{
			if(o.debug || !o.collision_allow)
				return 0;
		
			player_react_solid(r);
		}
		else
			_instance_react_solid(r);
	}
	
	return side;
}

function instance_act_semi_solid(o, hitbox_other = noone, this = id, this_hitbox = noone)
{	
	// Make hitboxes
	var thisHitbox = _instance_evaluate_hitbox(this, this_hitbox);
	var otherHitbox = _instance_evaluate_hitbox(o, hitbox_other);
	
	// Orientate hitboxes depending on scale
	thisHitbox = _instance_orient_hitbox(this, thisHitbox);
	otherHitbox = _instance_orient_hitbox(o, otherHitbox);
	
	var otherEdge = o.y + otherHitbox[BBOX.BOTTOM];
	var otherEdgePrev = (o.y - o.y_speed) + otherHitbox[BBOX.BOTTOM];
	
	var platformTop = this.y + thisHitbox[BBOX.TOP] - 1;
	var platformBottom = this.y + thisHitbox[BBOX.TOP] + 4;
	
	var isColliding = (this.x + thisHitbox[BBOX.LEFT] < o.x + otherHitbox[BBOX.RIGHT]) &&
		(this.x + thisHitbox[BBOX.RIGHT] > o.x + otherHitbox[BBOX.LEFT]) &&
		o.y_speed >= 0 && otherEdge >= platformTop - 1 && otherEdgePrev <= platformBottom;
		
	if(isColliding)
	{
		o.y = platformTop - otherHitbox[BBOX.BOTTOM];
		
		// Check if this is a player object
		var isPlayer = o.object_index == obj_player;
		
		if(isPlayer)
		{
			// Flag player as on object
			o.on_object = true;
			
			// Make sure the ground is flat
			o.ground_angle = 0;
			
			// Ledge direction
			if(o.ground && o.x < this.x + thisHitbox[BBOX.LEFT])
				o.ledge = -1;
				
			if(o.ground && o.x > this.x + thisHitbox[BBOX.RIGHT])
				o.ledge = 1;
		
			// Going down
			if(o.y_speed > 0)
			{
				// Land the player
				if(!o.ground)
				{
					// Stop falling
					o.y_speed = 0;
				
					// Transfer speed
					if(!o.ground)
						o.ground_speed = o.x_speed;
				
					o.ground = true;	
					with(o)
						player_land_callback();
				}
			}
		}
		
		return true;
	}
}

function instance_collide(o, hitbox_other = noone, this = id, this_hitbox = noone)
{
	// Make hitboxes
	var thisHitbox = _instance_evaluate_hitbox(this, this_hitbox);
	var otherHitbox = _instance_evaluate_hitbox(o, hitbox_other);
	
	// Orientate hitboxes depending on scale
	thisHitbox = _instance_orient_hitbox(this, thisHitbox);
	otherHitbox = _instance_orient_hitbox(o, otherHitbox);
	
	if(!instance_exists(this))
	{
		return false;	
	}
	
	// Horizontal collision
	if(rectangle_in_rectangle(this.x + thisHitbox[BBOX.LEFT], this.y + thisHitbox[BBOX.TOP], this.x + thisHitbox[BBOX.RIGHT] - 1, this.y + thisHitbox[BBOX.BOTTOM] - 1,
		o.x + otherHitbox[BBOX.LEFT], o.y + otherHitbox[BBOX.TOP], o.x + otherHitbox[BBOX.RIGHT] - 1, o.y + otherHitbox[BBOX.BOTTOM]) - 1)
		return true;
}

function instance_position_hitbox(px, py, hitbox = noone, this = id)
{
	// Do not do anything if the object doesn't exist
	if(!instance_exists(this))
		return noone;
	
	// Make a hitbox
	var b = _instance_evaluate_hitbox(this, hitbox);
	
	// Get the difference between the current position and a new position
	var diffX = px - this.x;
	var diffY = py - this.y;
	
	// Offset the hitbox by the difference
	b[BBOX.LEFT] += diffX;
	b[BBOX.RIGHT] += diffX;
	b[BBOX.TOP] += diffY;
	b[BBOX.BOTTOM] += diffY;
	
	// All done
	return b;
}

function instance_register_culling(culling_region = noone, on_culling = noone, flags = CULL_FLAG.CHECK_ENTITY_POS)
{
	var c = {left : -32, right : 32, top : -32, bottom : 32}
	
	if(is_array(culling_region))
	{
		c.left = culling_region[BBOX.LEFT];	
		c.right = culling_region[BBOX.RIGHT];	
		c.top = culling_region[BBOX.TOP];	
		c.bottom = culling_region[BBOX.BOTTOM];	
	}
	else if(culling_region)
	{
		c = culling_region;	
	}
	
	// Make a default struct
	culling_struct =
	{
		inst_id : id,
		region : c,
		type : CULL_TYPE.DEACTIVATE,
		cull_flag : false,
		culled : on_culling,
		flag : flags
	}
	
	// Add the object to the list
	ds_list_add(obj_level.instance_list, culling_struct);	
}

function instance_flash(interval, offset = 0, timer = FRAME_TIMER)
{
	if((timer + offset) mod (interval * 2) < interval)
		return true;
}

function instance_recorder_init(size = 60) constructor
{
	timer = 0;
	value_id = 0;
	record_size = size;
	instance_list = [];
	variable_list = [];
	update_list = [[]];
}

function instance_recorder_add(recorder, variable_name, inst_id = id)
{
	// Store the old ID
	var oldID = recorder.value_id;
	
	// Store the data
	recorder.variable_list[oldID] = variable_name;
	recorder.instance_list[oldID] = inst_id;
	
	// Increment the ID
	recorder.value_id++;
	
	// Return it
	return oldID;
}

function instance_recorder_update(recorder)
{
	// Get the recording list
	var s = array_length(recorder.variable_list);
	
	// Update the timer
	recorder.timer++;
	
	// Update all of the values
	for (var i = 0; i < s; ++i) 
	{
		//if(variable_instance_get(recorder.instance_list[i], recorder.variable_list))
		recorder.update_list[i][recorder.timer mod recorder.record_size] = variable_instance_get(recorder.instance_list[i], recorder.variable_list[i]);
	}
}

function instance_recorder_get_value(recorder, value_id, offset)
{
	return recorder.update_list[value_id][(max(recorder.timer - offset, 0) mod recorder.record_size)];
}

function instance_create_bullet(sprite, animation_speed, x, y, obj_depth, x_speed, y_speed, grav = 0.2)
{
	//Create bullet object
	var bullet = instance_create_depth(x, y, obj_depth, obj_bullet);
	
	//Change its properties
	bullet.sprite_index = sprite;
	bullet.x_speed = x_speed;
	bullet.y_speed = y_speed;
	bullet.grav = grav;
	
	//Play animation
	with(bullet)
		animation_play_no_list(animator, sprite, animation_speed);
	
	//Return the bullet's ID
	return bullet;
}

function instance_on_screen(RegionW = 16, RegionH = 16) 
{
	var c, cx, cy, sw, sh;
	c = view_camera[view_current]
	cx = camera_get_view_x(c)
	cy = camera_get_view_y(c)
	sw = global.window_width;
	sh = global.window_height;
 
	if(bbox_right > cx-RegionW && bbox_left < cx + sw +  RegionW && bbox_bottom > cy - RegionH && (bbox_top < cy + sh+RegionH)) 
		return true;
}

function instance_origin_on_screen(RegionW = 16, RegionH = 16, origin_x = xstart, origin_y = ystart) 
{
	var c, cx, cy, sw, sh;
	c = view_camera[view_current]
	cx = camera_get_view_x(c)
	cy = camera_get_view_y(c)
	sw = global.window_width;
	sh = global.window_height;
 
	if(origin_x > cx-RegionW && origin_x < cx + sw +  RegionW && origin_y > cy - RegionH && (origin_y < cy + sh+RegionH)) 
		return true;
}

function instance_create_particle(X, Y, sprite, anim_speed, obj_depth = depth - 1, x_speed = 0, y_speed = 0, x_accel = 0, y_accel = 0)
{
	//Create and get the object
	var o = instance_create_depth(X, Y, obj_depth, obj_effect);
	
	//Set the sprite and animation speed
	o.sprite = sprite;
	o.sprite_speed = anim_speed;
	
	// Play the animation
	with(o)
		animation_play_no_list(animator, sprite, anim_speed, false);
	
	//Physics properties
	o.x_speed = x_speed;
	o.y_speed = y_speed;
	o.x_accel = x_accel;
	o.y_accel = y_accel;
	
	//Return the instance
	return o;
}

function instance_create_debris(posx, posy, sprite, anim_speed, x_speed, y_speed, anim_frame = 0, grav = 0.2, angle = 0, angle_speed = 0, obj_depth = depth-1, xscale = 1, yscale = 1)
{
	var debris = instance_create_depth(posx, posy, obj_depth, obj_debris);
	debris.sprite_index = sprite;
	debris.image_speed = anim_speed;
	debris.image_index = anim_frame;
	debris.image_angle = angle;
	debris.image_xscale = xscale;
	debris.image_yscale = yscale;
	debris.angle_speed = angle_speed;
	debris.x_speed = x_speed;
	debris.y_speed = y_speed;
	debris.grav = grav;
}

function instance_create_score(offx = 0, offy = 0)
{
	//Crate score object
	var Object = instance_create_depth(x+offx, y+offy, depth-1, obj_score_effect);
	
	//Add score depending on the chain
	if(obj_level.badnik_chain = 1){
		Object.image_index = 0;
		global.score += 100;
	}
	
	if(obj_level.badnik_chain = 2){
		Object.image_index = 1;
		global.score += 200;
	}
	
	if(obj_level.badnik_chain = 3){
		Object.image_index = 2;
		global.score += 500;
	}
	
	if(obj_level.badnik_chain >= 4 && obj_level.badnik_chain <= 15){
		Object.image_index = 3;
		global.score += 1000;
	}
	
	if(obj_level.badnik_chain >= 16){
		Object.image_index = 4;
		global.score += 10000;
	}
}

function instance_create_ringloss(ring_counter)
{
	var ring_angle = 101.25;
	var flip = false
	var spd = 4
	var max_ring = min(ring_counter, 32);
	
	//Create rings
	for (var i = 1; i <= max_ring; ++i)
	{
	    //Create ring objects
	    var ring = instance_create_depth(x, y, depth, obj_ring);
	    ring.x_speed = dcos(ring_angle) * spd;
	    ring.y_speed = -dsin(ring_angle) * spd;
		ring.ringloss = true;
		ring.culling_struct.type = CULL_TYPE.DISABLE;
		
	    //Make ring go in circle
	    if(flip)
	    {
			ring.x_speed *= -1;
	        ring_angle += 22.5;
	    }
    
	    //Toggle flip flag
	    flip = !flip;
    
	    //Inner circle
	    if (i = 16)
	    {
	        spd = 2;
			ring_angle = 101.25;
	    }
	}
}
// ===========================================================================================================
// Utilities internal functions
// ===========================================================================================================
function _instance_react_solid(result)
{
	// Get values from the struct
	var o = result.object;
	var side = result.col_side;
	var colX = result.col_x;
	var colY = result.col_y
	
	// Vertical collision sides
	if(side == C_TOP || side == C_BOTTOM)
	{
		// Position the object
		o.y = colY;	
		
		// Stop object's vertical movement if it exists
		if(variable_instance_exists(o, "y_speed"))
		{
			if(side == C_TOP && o.y_speed > 0 || side == C_BOTTOM && o.y_speed < 0)
				o.y_speed = 0;
		}
	}
	
	// Horizontal collision sides
	if(side == C_LEFT || side == C_RIGHT)
	{
		// Position the object
		o.x = colX;	
			
		// Stop object's horizontal movement if it exists
		if(variable_instance_exists(o, "y_speed"))
		{
			if(side == C_LEFT && o.x_speed > 0 || side == C_RIGHT && o.x_speed < 0)
				o.x_speed = 0;
		}
	}
}

function _instance_orient_hitbox(this, hitbox) 
{
	var dstBox
	
	if(!instance_exists(this))
	{
		dstBox[BBOX.LEFT] = hitbox[BBOX.LEFT];
		dstBox[BBOX.RIGHT] = hitbox[BBOX.RIGHT];
		dstBox[BBOX.TOP] = hitbox[BBOX.TOP];
		dstBox[BBOX.BOTTOM] = hitbox[BBOX.BOTTOM];
		return dstBox;
	}
	
	dstBox[BBOX.LEFT] = hitbox[BBOX.LEFT] * this.image_xscale;
	dstBox[BBOX.RIGHT] = hitbox[BBOX.RIGHT] * this.image_xscale;
	dstBox[BBOX.TOP] = hitbox[BBOX.TOP] * this.image_yscale;
	dstBox[BBOX.BOTTOM] = hitbox[BBOX.BOTTOM] * this.image_yscale;

	if (dstBox[BBOX.LEFT] > dstBox[BBOX.RIGHT]) 
	{
		var s = dstBox[BBOX.LEFT]
		dstBox[BBOX.LEFT] = dstBox[BBOX.RIGHT];
		dstBox[BBOX.RIGHT] = s;
	}
	
	if (dstBox[BBOX.TOP] > dstBox[BBOX.BOTTOM]) 
	{
		var s = dstBox[BBOX.TOP]
		dstBox[BBOX.TOP] = dstBox[BBOX.BOTTOM];
		dstBox[BBOX.BOTTOM] = s;
	}
	
	return dstBox;
}

function _instance_make_hitbox(inst)
{
	var newBox;
	
	// Fallback
	if(!instance_exists(inst))
	{
		newBox[BBOX.LEFT] = 0;
		newBox[BBOX.RIGHT] = 0;
		newBox[BBOX.TOP] = 0;
		newBox[BBOX.BOTTOM] = 0;
		return newBox;
	}
	
	var s = inst.sprite_index;
	
	if(inst.mask_index)
		s = mask_index;
	
	newBox[BBOX.LEFT] = sprite_get_bbox_left(s) - sprite_get_xoffset(s);
	newBox[BBOX.RIGHT] = sprite_get_bbox_right(s) - sprite_get_xoffset(s) + 1;
	newBox[BBOX.TOP] = sprite_get_bbox_top(s) - sprite_get_yoffset(s);
	newBox[BBOX.BOTTOM] = sprite_get_bbox_bottom(s) - sprite_get_yoffset(s) + 1;
	
	return newBox;
}

function _instance_evaluate_hitbox(this, hitbox)
{
	var newBox;
	
	// Check if hitbox is a valid array
	if(is_array(hitbox))
	{
		newBox = hitbox;
	}
	else if(is_struct(hitbox))
	{
		// If it's not an array, check if it's a struct
		newBox[BBOX.LEFT] = hitbox.left;
		newBox[BBOX.RIGHT] = hitbox.right;
		newBox[BBOX.TOP] = hitbox.top;
		newBox[BBOX.BOTTOM] = hitbox.bottom;

	}
	else
	{
		// If it's not a struct either, build a new hitbox
		newBox = _instance_make_hitbox(this);
	}	
	
	return newBox;
}