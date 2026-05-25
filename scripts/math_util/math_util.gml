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