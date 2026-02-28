/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Variáveis de controle para o COS
y_base = y;        // posição original
float_speed = 0.1; // velocidade da oscilação
float_height = 6;  // altura máxima que sobe/desce
float_timer = 0;   // contador

//Começa menor
image_xscale = 0.8;
image_yscale = 0.8;

//Método de pegar o item
pickup = function()
{
	//Se colidir com o player, ativo a global pitão
	if (instance_exists(obj_player))
	{
		if (place_meeting(x, y, obj_player))
		{
			//Toca o som do item
			audio_play_sound(sfx_item_pickup, 4, false, 3);
			
			global.pitao = true;
			
			//Me destruo
			instance_destroy(id);
		}
	}
}


