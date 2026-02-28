/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Métodos do power

take = function()
{
	//SE o player colidir comigo, eu dou mais um pulo extra para ele
	var _player_collide = instance_place(x, y, obj_player);

	if (_player_collide)
	{
		//Toca o som do item
		audio_play_sound(sfx_item_pickup, 4, false, 2);
		
		//Dou mais um pulo para ele
		global.dash = true;
		
		//Me destruo
		instance_destroy(id);
	}
	
}

#endregion


/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor




