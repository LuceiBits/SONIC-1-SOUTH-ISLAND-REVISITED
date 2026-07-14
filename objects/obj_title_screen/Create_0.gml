sonic_offset = 80
state = 0
timer = 0

sonic_ani = new animator_create()
animation_add(0,spr_sonic_emblem,0.1,0,false)
animation_add(1,spr_sonic_emblem_wag,0.1,0,true)

animation_play(sonic_ani,0)

fade_in_room(5)