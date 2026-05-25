
var str = string_split(target_layer,",", true)
for (var i = 0; i < array_length(str); ++i) {
    ds_list_destroy(tile_memory[i])
}
ds_list_destroy(collision_memory[0])
ds_list_destroy(collision_memory[1])
