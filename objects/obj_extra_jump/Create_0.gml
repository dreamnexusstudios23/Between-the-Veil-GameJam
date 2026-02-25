/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Variáveis de controle
exist		= true; //Já começo existindo
exist_timer = 0; //Já começa existindo

#region //Métodos do power

take = function()
{
	//SE o player colidir comigo, eu dou mais um pulo extra para ele
	var _player_collide = instance_place(x, y, obj_player);
	
	if (instance_exists(obj_player))
	{
		if (_player_collide && exist)
		{
			//Dou mais um pulo para ele
			_player_collide.qtd_jumps++;
		
			//Sumo por um tempinho
			exist = false;
		}
	}
	
	//Se não existo, diminui o timer para voltar a existir
	if (!exist)
	{
		//Fico invisivel
		image_alpha = 0;
		
		exist_timer -= delta_time / 1000000;	
	}
	
	//SE o timer zerar, volto a existir e reseto o timer
	if (exist_timer <= 0)
	{
		exist = true;
		
		//Volto a ficar visivel
		image_alpha = 1;
		
		exist_timer = 3; // 3 segundos
	}
	
	show_debug_message(exist_timer);
}

#endregion


