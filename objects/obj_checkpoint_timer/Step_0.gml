/// @description Script

//Update the position
y += y_speed;
	
//Friction
y_speed = min(y_speed + spx(12), 0)
	
//timer timer
timer += 1;
	
//Destroy after some frames
if(timer >= 60*5) instance_destroy();