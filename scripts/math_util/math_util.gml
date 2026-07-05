function math_uangle(angle)
{
	if(angle < 180)
	{
		return angle;
	}

	return 360 - angle;
}

function math_approach(val, target, steps) 
{
	// Moves from start, to end at the rate of step.
	if(val < target)
		return min(val + steps, target);
	else
		return max(val - steps, target);
}

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

function math_lerp_angle(value, angle, amount)
{
	//This function is used for lerping angles (angles with easing)
	
	//Move value to the target:
	value += (((angle - value + 540) mod 360)-180) * amount;
	
	//Preventing from going to negative:
	value = (value + 360) mod 360;	
	
	//Return the result
	return value;
}

// 256-step sin/cos matching RSDK's Sin256/Cos256 tables, built once from the formula
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

function sin256(_angle)
{
	static _t = __trig256_build(true);
	return _t[_angle & 0xFF];
}

function cos256(_angle)
{
	static _t = __trig256_build(false);
	return _t[_angle & 0xFF];
}