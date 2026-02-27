/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Sempre que eu estiver dentro da zona, ele ativa a global que mostra
//a tecla para mudar de mundo
if (instance_exists(obj_player))
{
	if (place_meeting(x, y, obj_player))
	{
		//Habilita o tutorial
		global.tecla_cw = true;
	}
	else
	{
		global.tecla_cw = false;	
	}
}

