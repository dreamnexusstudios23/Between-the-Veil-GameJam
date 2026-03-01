/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (image_index >= image_number - 1)
{
    var _player = instance_find(obj_player, 0);
    
    _player.x = x;
    _player.y = y - 3;
    
    instance_activate_object(_player);
    
    camera_set_view_target(view_camera[0], _player);
	
	//Inicia o player
	with (obj_player)
	{
		init_player = true;	
	}
    
    instance_destroy();
}
