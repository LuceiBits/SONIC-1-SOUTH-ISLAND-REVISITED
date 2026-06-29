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
		else if(o.x + otherHitbox[BBOX.LEFT] <= this.x + thisHitbox[BBOX.RIGHT])
		{
			sideH = C_RIGHT;
			colX = this.x + (thisHitbox[BBOX.RIGHT] - otherHitbox[BBOX.LEFT]);
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
	
	// Horizontal collision
	if(rectangle_in_rectangle(this.x + thisHitbox[BBOX.LEFT], this.y + thisHitbox[BBOX.TOP], this.x + thisHitbox[BBOX.RIGHT], this.y + thisHitbox[BBOX.BOTTOM],
		o.x + otherHitbox[BBOX.LEFT], o.y + otherHitbox[BBOX.TOP], o.x + otherHitbox[BBOX.RIGHT], o.y + otherHitbox[BBOX.BOTTOM]))
		return true;
}

function instance_act_badnik()
{
	//Destroy the enemy
	if(player_collide_object())
	{
		var fly_angle = 90 - point_direction(obj_player.x, obj_player.y,x,y) 
		var fly_cond = (obj_player.state == player_state_tailsfly && abs(fly_angle) < 45)
		if(obj_player.attacking || obj_player.invincible || fly_cond)
		{
			//Create flickies instead
			instance_create_depth(x, y, depth, obj_flicky);
		
			//Player bounce
			obj_player.y_speed = -abs(obj_player.y_speed);
		
			//Create score object and add combo and badnik chain
			obj_level.badnik_chain += 1;
			create_score();
		
			//Create explosion effect
			create_effect(x, y, spr_effect_explosion01, 0.3);
		
			//Play destroying sound
			play_sound(sfx_destroy);
		
			//Destroy badnik
			if (!instance_exists(obj_bonus_level)) {
				global.store_object_state[| id] = true
			}
			instance_destroy();	
		}
		else
		{
			//Player getting hurt
			player_hurt();
		}
	}	
}

function instance_register_culling(culling_region = noone, on_culling = noone, flags = CULL_FLAG.CHECK_ENTITY_POS)
{
	var c = {left : 0, right : 0, top : 0, bottom : 0}
	
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
		//newBox = new instance_hitbox(hitbox[0], hitbox[1], hitbox[2], hitbox[3]);
		newBox = hitbox;
	}
	else if(is_struct(hitbox))
	{
		// If it's not an array, check if it's a struct
		//newBox = new instance_hitbox(hitbox.left, hitbox.top, hitbox.right, hitbox.bottom);
		newBox[BBOX.LEFT] = hitbox.left;
		newBox[BBOX.RIGHT] = hitbox.right;
		newBox[BBOX.TOP] = hitbox.top;
		newBox[BBOX.BOTTOM] = hitbox.bottom;

	}
	else
	{
		// If it's not a struct either, build a new hitbox
		//newBox = new instance_hitbox();
		newBox = _instance_make_hitbox(this);
	}	
	
	return newBox;
}

// ===========================================================================================================
// Utilities constructors
// ===========================================================================================================
function instance_hitbox(box_left = 0, box_top = 0, box_right = 0, box_bottom = 0) constructor
{
	left = box_left;
	top = box_top;
	right = box_right;
	bottom = box_bottom;
}