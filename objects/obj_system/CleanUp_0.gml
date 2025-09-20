/// @description Insert description here
// You can write your code in this editor
for (var i=0; i<ds_list_size(level_windows); i++) {
    var spr = ds_list_find_value(level_windows, i);
    if (spr != -1 && sprite_exists(spr)) sprite_delete(spr);
}
ds_list_destroy(level_windows);
level_windows = undefined;