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
		obj_player.life++;
		
		//Ai me destruo
		instance_destroy(id);
	}
}


