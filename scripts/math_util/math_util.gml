/// @self
/// @description				Function used for mirroring angle at both sides
/// @param {Real} angle			The angle value to use
/// @returns {Real}
function math_uangle(angle)
{
	if(angle < 180)
		return angle;

	return 360 - angle;
}

/// @self
/// @description				Function used for moving a value to the target
/// @param {Real} val			The value to use
/// @param {Real} target		The target that the value will reach
/// @param {Real} steps			The amount of steps the value will move towards the target
/// @returns {Real}
function math_approach(val, target, steps) 
{
	// Moves from start, to end at the rate of step.
	if(val < target)
		return min(val + steps, target);
	else
		return max(val - steps, target);
}

/// @self
/// @description				Function used for wrapping a value
/// @param {Real} val			The value used for wrapping
/// @param {Real} min			The minimum wrapping value
/// @param {Real} max			The maximum wrapping value
/// @returns {Real}
function math_wrap(val, minimum, maximum)
{
	if(val < minimum)
	{
		return maximum;	
	}
	
	if(val > maximum)
	{
		return minimum;	
	}
	
	return val;
}

/// @self
/// @description				Function used for angle's linear interpolation
/// @param {Real} value			The value used for lerping
/// @param {Real} angle			The target angle value (in degrees)
/// @param {Real} amount		The amount to interpolate
/// @returns {Real}
function math_lerp_angle(value, angle, amount)
{
	//Move value to the target:
	value += (((angle - value + 540) mod 360) - 180) * amount;
	
	//Preventing from going to negative:
	value = (value + 360) mod 360;	
	
	//Return the result
	return value;
}

/// @self
/// @description				Function used for getting the sin (in 256 degrees)
/// @param {Real} _angle		The angle to return the sine of
/// @returns {Real}
function sin256(_angle)
{
	static _t = __trig256_build(true);
	return _t[_angle & 0xFF];
}

/// @self
/// @description				Function used for getting the cos (in 256 degrees)
/// @param {Real} _angle		The angle to return the cos of
/// @returns {Real}
function cos256(_angle)
{
	static _t = __trig256_build(false);
	return _t[_angle & 0xFF];
}

// ===========================================================================================================
// Internal utility functions
// ===========================================================================================================

/// @self
/// @description				An internal function used for building a 256 degree sin/cos table
/// @param {bool} _is_sin		Is the table going to be sine or not
/// @returns {Array}
function __trig256_build(_is_sin)
{
	var t = array_create(256);
	for (var i = 0; i < 256; i++)
	{
		var v = (_is_sin ? sin(i / 128 * pi) : cos(i / 128 * pi)) * 512;
		var iv = (v < 0) ? ceil(v) : floor(v); // (int32) truncate toward zero
		t[i] = floor(iv / 2);                  // >> 1
	}
	if (_is_sin) { t[0] = 0; t[64] = 256; t[128] = 0; t[192] = -256; }
	else { t[0] = 256; t[64] = 0; t[128] = -256; t[192] = 0; }
	return t;
}