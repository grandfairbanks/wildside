///You should not be calling this script directly
function _pal_swap_layer_start() {
	if(event_type == ev_draw)
	{
		var _id = ds_priority_delete_min(Pal_Layer_Priority);
		var _data = Pal_Layer_Map[? _id];
		if(ds_list_find_index(_data,undefined)!=-1) exit;
		pal_swap_set(_data[|0],
								 _data[|1],
								 _data[|2]);
		ds_priority_add(Pal_Layer_Temp_Priority,_id,layer_get_depth(_id));
	}


}
