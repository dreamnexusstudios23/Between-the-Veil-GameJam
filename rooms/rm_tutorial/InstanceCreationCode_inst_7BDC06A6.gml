
//Personaliza o trigger
trigger = function()
{
	//Faz com que apareça o tutorial de movimento SE ainda não apareceu
	if (!instance_exists(obj_player_scene))
	{
		with (obj_tutorial_move)
		{
			tutorial_on = true;	
		
		}
	}	
}