/// @description Script
	for(var w = 0; w < array_length(dust); w++)
	{
		for(var h = 0; h < array_length(dust[w]); h++)
		{
			//If the info array is empty, continue to the next loop
			if(array_length(dust[w][h]) == 0) continue;
			
			//Add speeds
			if(dust[w][h][DUST.TIMER] > array_length(dust[w]) - h && type == 1 || type == 0)
			{
				dust[w][h][DUST.X] += dust[w][h][DUST.XSPD];
				dust[w][h][DUST.Y] += dust[w][h][DUST.YSPD];
			}
			
			//Timer
			dust[w][h][DUST.TIMER]++;
			
			//Destroy dust info
			if(dust[w][h][DUST.TIMER] > dust[w][h][DUST.TIMER_END] + 4)
				dust[w][h] = [];
		}
	}
	
	//Filter out the empty info arrays
	dust = array_filter(dust,
	function(element, index)
	{
		//Checks if the info array is empty
		return (array_length(element) != 0);
	});
	
	//Destroy the effect if there's no more dust
	if(array_length(dust) == 0) instance_destroy();