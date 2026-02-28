/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region screenshake

//Tremendo a tela
if (treme > 0.1)
{
	//Ele treme a tela 
	var _x = random_range(-treme, treme) //Altera no eixo X entre positivo e negativo
	var _y = random_range(-treme, treme) //altera no eixo Y entre positivo e negativo
	
	view_set_xport(view_current, _x); //Mexe a câmera atual no eixo X 
	view_set_yport(view_current, _y); //Mexe a câmare atual no eixo Y
		
}
else //Chego perto de zero, eu garanto que seja zerada
{
	treme = 0;
	view_set_xport(view_current, 0); 
	view_set_yport(view_current, 0);
	
}


//Lerp faz a tela parar de tremer gradativamente.
treme = lerp(treme, 0, 0.1);

#endregion

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


