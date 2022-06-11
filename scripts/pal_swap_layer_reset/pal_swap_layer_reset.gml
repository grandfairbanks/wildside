/// @description pal_swap_layer_reset();  Resets the layer data structures that may already exist.
function pal_swap_layer_reset() {
	// Should be called once before setting up any layers to pal swap.
	ds_map_clear(Pal_Layer_Map);
	ds_priority_clear(Pal_Layer_Priority);
	ds_priority_clear(Pal_Layer_Temp_Priority);


}
