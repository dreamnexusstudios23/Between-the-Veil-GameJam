
//Personaliza o trigger
trigger = function()
{
	//Faz com que apareça o tutorial de pulo SE ainda não apareceu
	//E se peguei o item wall jump
	if (global.wall_jump)
	{
		with (obj_tutorial_wall_jump)
		{
			tutorial_on = true;	
		}
	}	
}