/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Restart na room
if (keyboard_check_pressed(ord("R"))) 
{
	room_restart();
	//Reseta as globais;
	global.world = false;
	
	//SE eu to na fase 2 eu perco o pitão
	if (level02_pitao) global.pitao = false;
	
	//SE tiver no level 01 reseta tudo
	if (level01_jump_dash)
	{
		global.dash = false;
		global.wall_jump = false;
	}
}


