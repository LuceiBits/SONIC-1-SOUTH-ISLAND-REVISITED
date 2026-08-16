show_collision = true
layer_set_visible("CollisionTriggers", show_collision);
layer_set_visible(global.col_tile[0], show_collision);
layer_set_visible(global.col_tile[1], show_collision);
layer_set_visible(global.col_tile[2], obj_player.plane == 0 ? show_collision : false);
layer_set_visible(global.col_tile[3], obj_player.plane == 1 ? show_collision : false);
