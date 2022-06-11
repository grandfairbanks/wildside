/// @description pal_swap_draw_palette(palette_sprite,pal_index,x,y);
/// @function pal_swap_draw_palette
/// @param palette_sprite
/// @param pal_index
/// @param x
/// @param y
function pal_swap_draw_palette_h() {
	//Draws only the specified palette from the given palette sprite.
	draw_sprite_general(argument[0],0,argument[1],0,1,sprite_get_height(argument[0]),argument[2],argument[3],12,12,90,c_white,c_white,c_white,c_white,1);
}