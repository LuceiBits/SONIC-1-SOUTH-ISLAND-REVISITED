function math_uangle(angle)
{
	if(angle < 180)
	{
		return angle;
	}

	return 360 - angle;
}