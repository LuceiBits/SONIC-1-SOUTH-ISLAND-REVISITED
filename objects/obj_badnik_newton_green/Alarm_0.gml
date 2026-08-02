var hMove = 0
var vMove = 0
var movespeed = 3

hMove = movespeed * badnikdirection
vMove = 0
//hMove = lengthdir_x(movespeed,targetAngle)
//vMove = lengthdir_y(movespeed,targetAngle)

instance_create_bullet(spr_projectile,0,x,y,,hMove,vMove,0)
fired = true