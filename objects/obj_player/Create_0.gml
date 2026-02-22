/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Variáveis de controle do player

//Variáveis de velocidade e gravidade
velh		= 0;
velv		= 0;
max_velv	= 10;
max_velh	= 6;
grav		= 0.4;

//Variáveis de controle de colisão
chao = noone;

//Variáveis para o double jump
jumps_air = 1; //Qtd de pulos que eu tenho para dar no Ar (sem contar o pulo normal)
qtd_jumps = jumps_air;

//Variáveis para o wall jump
wall	  = false;
side_wall = 0;

//Variáveis para o dash
dash_mov	  = 2;
qtd_dash	  = dash_mov;
dash_vel	  = 15; // + 15 de velocidade quando aplicado no velh apenas
dash_cooldown = 0; //já começa em 0
timer_dash	  = 12; //12 frames
t_dash_atual  = 0;
dash_ativado  = false;
dash_dir	  = 0;

#endregion

#region //Métodos

//Pega inputs
inputs = function()
{
	//Pega as teclas
	up		= keyboard_check_pressed(ord("W"));
	left	= keyboard_check(ord("A"));
	right	= keyboard_check(ord("D"));	
	space	= keyboard_check_pressed(vk_space);
}

//Aplica os movimentos com base nos controles
move = function()
{
	//Utiliza os inputs
	inputs();
	
	//Movimento horizontal
	velh = (right - left) * max_velh;
	
	//SE estou no chão, eu posso pular
	if (chao)
	{
		//Movimento do pulo
		if (up)
		{
			//Pula
			velv -= 2;
			velv = clamp(velv, max_velv , -max_velv) //Limita a altura do pulo
		}
		
		//Reseto meus double jumps
		qtd_jumps = jumps_air;
		
		//Reseto meus dash
		qtd_dash = dash_mov;
		
	}
	else
	{	
		//SE estou na parede a gravidade é menor
		if (wall)
		{
			//Diminui a gravidade
			grav = 0.2;
			//Aplica a gravidade
			velv += grav;
		}
		else
		{
			//SE não estou na parede a gravidade é normal	
			grav = 0.4;
			
			//SE não estou no chão, então aplico a gravidade
			velv += grav;
		}
	}
	
	show_debug_message(side_wall)
}

//Aplica colisão e movimento
pixel_perfect = function()
{
	//Colisão horizontal
	var _velh = sign(velh);
	
	repeat(abs(velh))
	{
		if (place_meeting(x + _velh, y, obj_colisor_a))
		{
			//SE eu colidi com ele, eu paro e saio do laço
			velh = 0;
		
			break;
		}
		else
		{
			//SE ainda não colidi, eu me movo um pixel por vez
			x += _velh;
		}
	
	}


	//Colisão vertical
	var _velv = sign(velv);
	
	repeat(abs(velv))
	{
		if (place_meeting(x, y + _velv, obj_colisor_a))
		{
			//SE eu colidi com ele, eu paro e saio do laço
			velv = 0;
		
			break;
		}
		else
		{
			//SE ainda não colidi, eu me movo um pixel por vez
			y += _velv;
		}
	
	}
}

collision_check = function()
{
	//Checa se estou colidindo com o chão
	if (place_meeting(x, y + 1, obj_colisor_a))
	{
		//SE sim então estou no chão
		chao = true;
	}
	else
	{
		//SE não estou colidindo com o chão, então não estou nele
		chao = false;
	}
	
}

double_jump = function()
{
	//SE eu não estou no chão, e ainda tenho pulos, então eu pulo de novo
	if (!chao && qtd_jumps > 0)
	{
		//Se apertar a seta para cima, eu pulo e gasto meu pulo
		if (up)
		{
			//Pulo
			velv -= 2;
			velv = clamp(velv, max_velv , -max_velv) //Limita o pulo
			
			//gasto um pulo
			qtd_jumps--;
		}
	}
}

wall_jump = function()
{
	
	#region //Pega os lados da parede
	
	//Pega em qual parede estou colidindo
	var _wall_left = place_meeting(x - 1, y, obj_colisor_a);
	var _wall_right = place_meeting(x + 1, y, obj_colisor_a);
	
	#endregion
		
	#region //Descobre em qual parede está
	
	//SE estou colidindo com a parede da esquerda
	if (_wall_left && !chao)
	{
		//Parede é true
		wall = true;
		side_wall = -1;
	}
	else if (_wall_right && !chao) //SE estou colidindo com a da direita
	{
		//Parede é true
		wall = true;
		side_wall = 1;
	}
	else
	{
		//SE não estou em nenhuma das duas, então é false e 0
		wall = false;
		side_wall = 0;
	}
	
	#endregion
	
	#region //Faz o movimento na parede
	
	//SE estou na parede da esquerda e aperto a seta para direita
	if (side_wall == -1 && right)
	{
		//Força ele ir para direita e para cima
		velh += max_velh;
		//Limta o velh
		velh = clamp(velh, -max_velh, max_velh);
		
		velv -= max_velv;
		//Limta o velv
		velv = clamp(velv, -max_velv, max_velv);
	}
	
	//SE estou na parede da direita, e aperto para esquerda
	if (side_wall == 1 && left)
	{
		//Força ele ir para esquerda
		velh -= max_velh;
		//Limta o velh
		velh = clamp(velh, -max_velh, max_velh);
		
		velv -= max_velv;
		//Limta o velv
		velv = clamp(velv, -max_velv, max_velv);
	}
	
	#endregion
	
}

dash = function()
{
	// DIMINUI COOLDOWN
	if (dash_cooldown > 0)
	{
		dash_cooldown--;
	}
	
	// ATIVAR DASH (SE o dash não está ativado, e tem dash pra usar, aperto espaço, o cooldown
	//Está zerado, e não estou na parede)
	if (!dash_ativado && qtd_dash > 0 && space && dash_cooldown <= 0 && !wall)
	{
		dash_ativado = true;
		t_dash_atual = timer_dash;
		
		// pega direção baseada no input
		dash_dir = right - left;
		
		// se não estiver apertando nada, usa direção que está olhando
		if (dash_dir == 0)
			dash_dir = image_xscale;
		
		qtd_dash--;
	}
	
	// SE ESTÁ DASHANDO
	if (dash_ativado)
	{
		velh = dash_dir * (max_velh + dash_vel);
		velv = 0; // cancela gravidade
		
		t_dash_atual--;
		
		if (t_dash_atual <= 0)
		{
			dash_ativado = false;
			dash_cooldown = 30; 
		}
	}
	
}

#endregion





