
//var targetAngle = point_direction(x,y,obj_player.x,obj_player.y)
	if obj_player.x > x
	badnikdirection = 1
	else
	badnikdirection = -1

image_xscale = badnikdirection

var hMove = 0
var vMove = 0
var movespeed = 2

hMove = movespeed * badnikdirection
vMove = movespeed
//hMove = lengthdir_x(movespeed,targetAngle)
//vMove = lengthdir_y(movespeed,targetAngle)



instance_create_bullet(spr_projectile,0,x,y,,hMove,vMove,0)