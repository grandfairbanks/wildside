// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_tile_display()
	{
	tile_theme_surface=surface_create(256,256);
	var _layer=layer_create(-99);
	var _tmap = layer_tilemap_create(_layer,0,0,tileset,16,16);
	var _count=0;
	for(j=0; j<16; j++)
		{
		for(i=0; i<16; i++)
			{
			tilemap_set(_tmap,_count,i,j);
			_count++;
			}
		}
	surface_set_target(tile_theme_surface);
	draw_tilemap(_tmap,0,0);
	surface_reset_target();
	layer_tilemap_destroy(_tmap);
	layer_destroy(_layer);
	}