/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Variáveis de controle

//Variáveis de velocidade e movimento
velh = 2;
velv = 2;

#endregion

#region //Controle das variáveis definitions

// Define sprite
if (saw_side == "horizontal")
{
	sprite_index = spr_half_saw_side;
}
else
{
	//SE a direction saw for -1 ela é rotacionada para esquerda
	if (direction_saw == -1) 
	{
		image_xscale = -1;
		sprite_index = spr_half_saw_ver;
	}
	
	//SE for 1 ela é rotacionada para direita
	if (direction_saw == 1) 
	{
		image_xscale = 1;
		sprite_index = spr_half_saw_ver	
	}
}

// Define direção inicial
if (side_move == "right")
{
	dir = 1;
}
else if (side_move == "left")
{
	dir = -1;
}
else if (side_move == "up")
{
	dir = -1;
}
else if (side_move == "down")
{
	dir = 1;	
}

	
#endregion

#region //Métodos

move_saw = function()
{
	if (saw_side == "horizontal")
	{
		// verifica colisão na frente
		if (place_meeting(x + dir * velh, y, obj_saw_collide))
		{
			dir *= -1; // inverte direção
		}
		
		x += dir * velh;
	}
	else
	{
		// versão vertical
		if (place_meeting(x, y + dir * velh, obj_saw_collide))
		{
			dir *= -1;
		}
		
		y += dir * velv;
	}
}

#endregion


