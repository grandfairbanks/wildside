/// @description pal_swap_enable_layer Enables pal swapping for the given layer.
///***This script sets layer start and end scripts.  And, as suggested by the documentation,
///   this script should not be called in either a step event or a draw event.  It should
///   only be called once.
/// @param layer_index
function pal_swap_enable_layer(argument0) {
	var _layer_index = argument0;

	if(!layer_exists(_layer_index)) return;

	var _data = ds_list_create();

	ds_list_add(_data,undefined,undefined,undefined);

	layer_script_begin(_layer_index,_pal_swap_layer_start);	
	layer_script_end(_layer_index,_pal_swap_layer_end);

	ds_map_add_list(Pal_Layer_Map,_layer_index,_data);
	ds_priority_add(Pal_Layer_Priority,_layer_index,layer_get_depth(_layer_index));



}
