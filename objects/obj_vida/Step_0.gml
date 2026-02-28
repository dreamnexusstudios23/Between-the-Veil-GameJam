/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Faz subir e descer

float_timer += float_speed;

y = y_base + sin(float_timer) * float_height;

#endregion


//Quando colidir com o player, dou uma vida para ele
if (instance_exists(obj_player))
{
	if (instance_place(x, y, obj_player))
	{
		//Toca o som de vida
		audio_play_sound(sfx_extra_jump, 7, false, 2);
		
		//Só ganho vida se ela ainda não estiver no máximo
		if (obj_player.life < 3) obj_player.life = 3;
		
		//Ai me destruo
		instance_destroy(id);
	}
}


