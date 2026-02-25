/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Métodos do power

take = function()
{
	//SE o player colidir comigo, eu dou mais um pulo extra para ele
	var _player_collide = instance_place(x, y, obj_player);
	
	if (instance_exists(obj_player))
	{
		if (_player_collide)
		{
			//Dou mais um pulo para ele
			global.wall_jump = true;
		
			//Me destruo
			instance_destroy(id);
		}
	}
}

#endregion


