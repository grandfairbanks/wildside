// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_back_get_color(){
var _tempSurf = surface_create(1,8);
var color;
surface_set_target(_tempSurf);
pal_swap_draw_palette(spr_theme_bkg_pal,level_theme,0,0);
color =  draw_getpixel(0,0);
surface_reset_target();
surface_free(_tempSurf);
return color;
}