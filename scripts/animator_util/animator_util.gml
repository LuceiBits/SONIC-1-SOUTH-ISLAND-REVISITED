/// @self								
/// @description								A constructor that creates an animation system
function animator_create() constructor
{
	animation_current = -1;
	animation_sprite = other.sprite_index;
	animation_frame = 0;
	animation_speed = 0;
	animation_loop_frame = 0;
	animation_loop = true;
	animation_finished = false;
	animation_use_duration = false;
	animation_duration = 0;
	animation_sub_image = 0;
	animation_to_set = 0;
	animator_reset_flag = false;
}

/// @self								
/// @description								Function that resets the animation system
/// @param {Struct.animator_create} animator					The animation system struct that will be used
function animator_reset(animator)
{
	animator.animator_reset_flag = true;
}

/// @self								
/// @description								Function that runs the animation system
/// @param {Struct.animator_create} animator					The animation system struct that will be used
function animator_update(animator)
{
	if(!animator.animation_use_duration)
	{
		animator.animation_frame += animator.animation_speed;
	}
	else
	{
		
		var new_duration;
		if(is_array(animator.animation_duration))
		{
			var arr_size, result;
				
			arr_size = array_length(animator.animation_duration);
				
			result = min(animator.animation_frame, arr_size - 1);
				
			new_duration = animator.animation_duration[result];
		}
		else
		{
			new_duration = animator.animation_duration;
		}
			if(animator.animation_sub_image < new_duration)
			{
				animator.animation_sub_image++
			}
			else
			{
				animator.animation_frame++
				animator.animation_sub_image = 0;
			}
		
	}
	
	if(animator.animation_frame < sprite_get_number(animator.animation_sprite) - 1)
	{
		animator.animation_finished = false;	
	}
	
	if(animator.animation_frame >= sprite_get_number(animator.animation_sprite))
	{
		if(animator.animation_loop) 
		{
			animator.animation_frame = animator.animation_loop_frame;
			animator.animation_finished = true;
		}
		else 
		{
			animator.animation_frame = sprite_get_number(animator.animation_sprite) - 1;
			animator.animation_finished = true;
		}
	}
	
	
	

			
	//If current animation is not matching the animation ID, then update it and reset its properties
	if(animator.animator_reset_flag)
	{
		//If animation doesn't exist just don't update anything
		if(animator.animation_to_set >= 0 && animator.animation_to_set <= array_length(list_animation_sprite) - 1)
		{
			//Update the current animation
			animator.animation_current = animator.animation_to_set;
		
			//Reset animation's properties
			animator.animation_frame = 0;
			animator.animation_finished = false;
			animator.animator_reset_flag = false;
			
			//Update information from the list
			animator.animation_sprite = list_animation_sprite[animator.animation_to_set];
			animator.animation_speed = list_animation_speed[animator.animation_to_set];
			animator.animation_loop_frame = list_animation_loop_frame[animator.animation_to_set];
			animator.animation_loop = list_animation_loop_flag[animator.animation_to_set];
			animator.animation_use_duration = list_animation_duration_flag[animator.animation_to_set];
			animator.animation_duration = list_animation_duration[animator.animation_to_set];
			animator.animation_sub_image = 0//is_array(animator.animation_duration) ? animator.animation_duration[0] : animator.animation_duration;
		}
	}
	
	
}

/// @self								
/// @description								Function that adds an animation to the list
/// @param {Real} animation_id					To which animation ID the new animation is going to be registered at in the list
/// @param {Asset.GMSprite} animation_sprite	Which sprite is going to be used for the animation
/// @param {Real|Array} animation_speed			The speed of the animation (Array: This is for how long every frame will last, only works with durations)
/// @param {Real} [animation_loop_frame]		The animation frame will be set to this value after the animation looping happens (The default is 0)
/// @param {Bool} [animation_loop_flag]			A flag that makes the animation loopable or not (This is on by the default)
/// @param {Bool} [use_duration]				A flag that changes the animation speed to use durations instead of frame speed (This is off by the default)
function animation_add(animation_id, animation_sprite, animation_speed, animation_loop_frame = 0, animation_loop_flag = true, use_duration = false)
{
	list_animation_sprite[animation_id] = animation_sprite;
	list_animation_loop_frame[animation_id] = animation_loop_frame;
	list_animation_loop_flag[animation_id] = animation_loop_flag;
	list_animation_duration_flag[animation_id] = use_duration;
	list_animation_speed[animation_id] = animation_speed;	
	list_animation_duration[animation_id] = animation_speed;
}

/// @self								
/// @description								Function that plays an animation without the usage of the animation list
/// @param {Struct.animator_create} animator					The animation system struct that will be used
/// @param {Asset.GMSprite} sprite				Which sprite is going to be used for the animation
/// @param {Real|Array} spd						The speed of the animation (Array: This is for how long every frame will last, only works with durations)	
/// @param {Bool} [loop]						A flag that makes the animation loopable or not (This is on by the default)
/// @param {Real} [loop_frame]					The animation frame will be set to this value after the animation looping happens (The default is 0)
/// @param {Bool} [use_duration]				A flag that changes the animation speed to use durations instead of frame speed (This is off by the default)
/// @param {Bool} [dont_reset_frame]			A flag that will not reset the animation system upon it being play (This is off by the default)
function animation_play_no_list(animator, sprite, spd, loop = true, loop_frame = 0, use_duration = false, dont_reset_frame = false)
{
	// Mark as listless
	animator.animation_to_set = -1;

	//Update the current animation
	animator.animation_current = -1;
		
	//Reset animation's properties
	if (!dont_reset_frame) 
	{
		animator.animation_frame = 0;
	}
	animator.animation_finished = false;
	animator.animator_reset_flag = false;
	
	//Update information from the list
	animator.animation_sprite = sprite;
	animator.animation_speed = spd;
	animator.animation_loop_frame = loop_frame;
	animator.animation_loop = loop;
	animator.animation_use_duration = use_duration;
	animator.animation_duration = spd;
	
	if (!dont_reset_frame) 
	{
		animator.animation_sub_image = 0;
	}
	
}

/// @self								
/// @description								Function that plays an animation from the animation list
/// @param {Struct.animator_create} animator					The animation system struct that will be used
/// @param {Real} animation_id					The animation ID that will be played from the list
/// @param {Bool} [dont_reset_frame]			A flag that will not reset the animation system upon it being play (This is off by the default)
function animation_play(animator, animation_id, dont_reset_frame = false)
{
	animator.animation_to_set = animation_id;
	
	//If current animation is not matching the animation ID, then update it and reset its properties
	if(animator.animation_current != animation_id)
	{
		//If animation doesn't exist just don't update anything
		if(animation_id > array_length(list_animation_sprite)-1)
		{
			exit;	
		}
		
		//Update the current animation
		animator.animation_current = animation_id;
		
		//Reset animation's properties
		if (!dont_reset_frame) {
			animator.animation_frame = 0;
		}
		animator.animation_finished = false;
		animator.animator_reset_flag = false;
			
		//Update information from the list
		animator.animation_sprite = list_animation_sprite[animator.animation_to_set];
		animator.animation_speed = list_animation_speed[animator.animation_to_set];
		animator.animation_loop_frame = list_animation_loop_frame[animator.animation_to_set];
		animator.animation_loop = list_animation_loop_flag[animator.animation_to_set];
		animator.animation_use_duration = list_animation_duration_flag[animator.animation_to_set];
		animator.animation_duration = list_animation_duration[animator.animation_to_set];
		if (!dont_reset_frame) {
			animator.animation_sub_image = 0;
		}
	}
}

/// @self								
/// @description								Function that checks if the animation has finished playing
/// @param {Struct.animator_create} animator					The animation system struct that will be used
function animation_has_finished(animator)
{
	if(animator.animation_finished)
		return true;	
}

/// @self								
/// @description								Function that checks if the specified animation from the list is being played
/// @param {Struct.animator_create} animator					The animation system struct that will be used
/// @param {Real} animation_id					Which animation ID from the list are we checking
function animation_is_playing(animator, animation_id)
{
	if(animator.animation_current == animation_id)
		return true;	
}

/// @self								
/// @description								Function that returns the currently playing animation from the animation system
/// @param {Struct.animator_create} animator					The animation system struct that will be used
/// @return {Real}
function animation_get_current_animation(animator)
{
	return animator.animation_current;
}

///@self
///@description Function that returns the sprite an animation from the animator struct.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
///@returns {real} 
function animation_get_sprite(animator, ani = animator.animation_current)
{
	return list_animation_sprite[ani];
}


///@self								
///@description								Function that returns the current frame from the playing animation
///@param {Struct.animator_create} animator					The animation system struct that will be used
///@return {Real}
function animation_get_frame(animator)
{
	return animator.animation_frame;	
}



///@self
///@description Function that returns the speed of an animation from the animator struct. Will return 0 if the animation uses duration and not speed.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
///@returns {real} 
function animation_get_speed(animator, ani = animator.animation_current)
{
	if (ani != animator.animation_current){
		if(list_animation_duration_flag[ani])
			return 0;	
	
		return list_animation_speed[ani];
	} else {
		if(animator.animation_use_duration)
			return 0;	
	
		return animator.animation_speed;	
	}
}

///@self
///@description Function that returns the frame count of an animation from the animator struct.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
///@returns {real} 
function animation_get_frame_count(animator, ani = animator.animation_current)
{
	return sprite_get_number(list_animation_sprite[ani]);	
}

///@self
///@description Function that returns the loop index of an animation from the animator struct.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
///@returns {real} 
function animation_get_loop_index(animator, ani = animator.animation_current)
{
	if (ani != animator.animation_current){
		return list_animation_loop_frame[ani];
	} else {
		return animator.animation_loop_frame	
	}
}

///@self
///@description Function that returns the frame duration of an animation from the animator struct. Returns 0 if the animation uses speed instead of duration.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
///@returns {real} 							
function animation_get_duration(animator, ani = animator.animation_current)
{
	if (ani != animator.animation_current){
		if(!list_animation_duration_flag[ani])
			return 0;	
	
		return list_animation_duration[ani];
	} else {
		if(!animator.animation_use_duration){
			return 0;	
		}
		return animator.animation_duration;
	}
}

///@self
///@description Function that sets the speed of an animation in the animation system struct. Note: this will do nothing if the animation uses duration and not speed.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} animation_speed The new speed for the animation
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
function animation_set_speed(animator, animation_speed, ani = animator.animation_current)
{
	if (ani != animator.animation_current){
		list_animation_speed[ani] = animation_speed;
	} else {
		animator.animation_speed = animation_speed;
	}
}

///@self
///@description Function that sets the frame duration of an animation in the animation system struct. Note: this will do nothing if the animation uses speed and not duration.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} animation_duration The new frame duration for the animation
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
function animation_set_duration(animator, animation_duration, ani = animator.animation_current)
{
	if (ani != animator.animation_current){
		list_animation_duration[ani] = animation_duration;	
	} else {
		animator.animation_duration = animation_duration;
	}
}

///@self
///@description Function that sets the loop index of an animation in the animation system struct.
///@param {Struct.animator_create} animator The animation system struct that will be used.
///@param {real} loop_frame The new frame for the animation to loop back to.
///@param {real} [animation] Refrence to the animation from the animation system struct. Defaults to the current playing animation from the animator.
function animation_set_loop_index(animator, loop_frame, ani = animator.animation_current)
{
	if (ani != animator.animation_current){
		list_animation_loop_frame[ani] = loop_frame;
	} else {
		animator.animation_loop_frame = loop_frame;	
	}
}

/// @self								
/// @description								Function that changes the animation frame
/// @param {Struct.animator_create} animator					The animation system struct that will be used
/// @param {real} frame								The frame that will be set
function animation_set_frame(animator, frame)
{
	animator.animation_frame = frame;	
}