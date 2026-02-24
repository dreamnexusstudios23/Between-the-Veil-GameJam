/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Restart na room
if (keyboard_check_pressed(ord("R"))) 
{
	room_restart();
	//Reseta as globais;
	global.world = false;
}


