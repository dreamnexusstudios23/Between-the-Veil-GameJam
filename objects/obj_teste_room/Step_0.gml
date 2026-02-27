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
}


