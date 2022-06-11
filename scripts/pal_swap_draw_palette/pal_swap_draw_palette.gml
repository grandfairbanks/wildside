/// @description pal_swap_draw_palette(palette_sprite,pal_index,x,y);
/// @function pal_swap_draw_palette
/// @param palette_sprite
/// @param pal_index
/// @param x
/// @param y
/// @param horizontal_or_vertical/(true_or_false)
function pal_swap_draw_palette() {
	//Draws only the specified palette from the given palette sprite.
	draw_sprite_part(argument[0],0,argument[1],0,1,sprite_get_height(argument[0]),argument[2],argument[3]);



}
