/// @description Insert description here
// You can write your code in this editor

#region END FADE TEST
if (obj_system.endlvl_active)
	{
	if !(obj_system.endfade_active)
		{
		obj_system.endfade_active=true;
		}
	else
		{	
		}
	}
	
if (obj_system.endfade_active)
	{
	if obj_system.end_alpha>0
	obj_system.end_alpha-=0.1;
	}
	
#endregion