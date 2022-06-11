/// @description pal_swap_reset();
/// @function pal_swap_reset
function pal_swap_reset() {
	//Resets the shader
	if(Pal_Shader_Is_Set)
	{
		shader_reset();
	}
	Pal_Shader_Is_Set=false;


}
