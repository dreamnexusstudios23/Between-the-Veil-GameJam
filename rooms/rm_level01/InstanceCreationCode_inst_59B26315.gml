
//Personaliza o trigger
trigger = function()
{
	//Faz com que apareça o tutorial de pulo SE ainda não apareceu
	//E se peguei o item wall jump
	if (global.dash)
	{
		with (obj_tutorial_dash)
		{
			tutorial_on = false;	
		}
	}	
}