///You should not be calling this script directly
function _pal_swap_layer_end() {
	if(event_type==ev_draw)
	{
		pal_swap_reset();
		if(ds_priority_empty(Pal_Layer_Priority))
		{
			ds_priority_copy(Pal_Layer_Priority,Pal_Layer_Temp_Priority);
			ds_priority_clear(Pal_Layer_Temp_Priority);
		}
	}


}
