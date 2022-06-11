/// @description pal_swap_set_layer draws the specified layer using the specified palette in the specified event.
/// @param pal_sprite the palette to use (sprite or surface).
/// @param pal_index
/// @param layer_index
/// @param pal_is_surface
function pal_swap_set_layer(argument0, argument1, argument2, argument3) {
	var _pal_sprite = argument0,
			_pal_index = argument1,
			_layer_index = argument2,
			_pal_is_surface = argument3;

	var _data = ds_map_find_value(Pal_Layer_Map,_layer_index);
	if(_data == undefined) return;  //Swapping not enabled on this layer
	ds_list_clear(_data);
	ds_list_add(_data,_pal_sprite,_pal_index,_pal_is_surface);


	//Remove from queue if it's already there
	/*if(ds_priority_find_priority(Pal_Layer_Priority,_layer_index) != undefined)
		ds_priority_delete_value(Pal_Layer_Priority,_layer_index);
	if(ds_exists(Pal_Layer_Temp_Priority, ds_type_priority) && 
			ds_priority_find_priority(Pal_Layer_Temp_Priority,_layer_index) != undefined)
		ds_priority_delete_value(Pal_Layer_Temp_Priority,_layer_index);

	//If the layer doesn't exist or pal is 0, clean up pal swapping for that layer.
	if(!_layer_exists || _pal_index == 0)
	{
		if(ds_map_exists(Pal_Layer_Map,_layer_index))
		{
			_data = ds_map_find_value(Pal_Layer_Map,_layer_index);
			ds_map_delete(Pal_Layer_Map,_layer_index);
			if(ds_exists(_data,ds_type_list)) ds_list_destroy(_data);
		}
		
		if(_layer_exists)
		{
			layer_script_begin(_layer_index,noone);	
			layer_script_end(_layer_index,noone);
		}
		return false; //Palswapping on the given layer couldn't be started or you are using your default palette.
	}

	//Else, setup pal swapping for that layer.
	_data = ds_list_create();
	ds_list_add(_data,_pal_sprite,_pal_index,_pal_is_surface);
	layer_script_begin(_layer_index,_pal_swap_layer_start);	
	layer_script_end(_layer_index,_pal_swap_layer_end);
	ds_map_replace(Pal_Layer_Map,_layer_index,_data);
	ds_priority_add(Pal_Layer_Priority,_layer_index,layer_get_depth(_layer_index));

	return true; //Pal Swapping succesfull


/* end pal_swap_set_layer */
}
