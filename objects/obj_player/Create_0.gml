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

//Variáveis do pitao
pitao_ativado = false;
pitao_timer	  = 5; //5 segundos
p_timer_atual = pitao_timer;
pitao_wall	  = false;

//Variáveis de ataque
atk_cooldown = 0; //1 segundo, porém está 0 por que eu já posso começar atacando
atk_timer = atk_cooldown;
del_hitbox = 0.3; //Leva 0.3 segundos para sumir a hitbox criada


#endregion

#region //Métodos

//Pega inputs
inputs = function()
{
	//Pega as teclas
	up			= keyboard_check_pressed(ord("W"));
	left		= keyboard_check(ord("A"));
	right		= keyboard_check(ord("D"));	
	space		= keyboard_check_pressed(vk_space);
	pitao		= keyboard_check_pressed(ord("F"));
	change_w	= keyboard_check_pressed(ord("Q"));
	attack_mb	= mouse_check_button_pressed(mb_left);
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
			//SE não estou na parede e nem na parede do pitao a gravidade é normal	
			if (!pitao_wall)
			{
				grav = 0.4;
			
				//SE não estou no chão, então aplico a gravidade
				velv += grav;
			}
		}
	}
	
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

//Checa a colisão
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

//Pulo duplo
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

//Pulo na parede
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

//Dash
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

//Item pitão
pitao_item = function()
{
	
	//Pega o colisor do pitao
	var _pitao_parede_esq = place_meeting(x - 1, y, obj_pitao_colisor);
	var _pitao_parede_dir = place_meeting(x + 1, y, obj_pitao_colisor);
	
	//Verifica se estou em algum lado de alguma parede de pitão
	if (_pitao_parede_esq or _pitao_parede_dir)
	{
		//Está na parede de pitão
		pitao_wall = true;
	}
	else
	{
		//SE sair da parede 
		pitao_wall = false;
		pitao_ativado = false;
		
		//Reseta o timer do pitão
		p_timer_atual = pitao_timer;
	}
	
	//SE eu estiver colidindo com o objeto pitao e tiver o pitao e usa-lo
	if (pitao && global.pitao && pitao_wall)
	{
		//Ativa o uso do pitão
		pitao_ativado = true;
	}
	
	//SE pitao foi ativado, então fico preso na parede até acabar o timer
	if (pitao_ativado && pitao_wall)
	{
		//Fica preso na parede
		velv = 0;
		
		//Começa a diminuir o timer de 5 segundos de ficar preso
		p_timer_atual -= delta_time / 1000000;
	}

	
	//SE o timer do pitão for 0, então ele cai e desativa
	if (p_timer_atual <= 0)
	{
		pitao_ativado = false;
		pitao_wall = false;
		
		//Reseta o timer do pitão
		p_timer_atual = pitao_timer;

	}

}

//Mecânica de trocar de mundos
change_world = function()
{
	//Ao pressionar a tecla Q, troca entre os mundos
	if (change_w) global.world = !global.world;
	
	//SE world for false, é o mundo normal, se for true, é o mundo paralelo
	if (global.world)
	{
		//Torna só a layer plataform_b visivel
		layer_set_visible("plataform_b", true);
		layer_set_visible("plataform_a", false);

	}
	else
	{
		//Torna só a layer plataform_b visivel
		layer_set_visible("plataform_b", false);
		layer_set_visible("plataform_a", true);	
	}
}

//Mecânica de ataque
attack = function()
{
	//Diminui o timer do ataque
	atk_timer -= delta_time / 100000;
	//Limitando a descida do timer do ataque
	atk_timer = clamp(atk_timer, 0, atk_cooldown);
	
	if (attack_mb && atk_timer <= 0)
	{
		var offset = 80;
		var hit_x;
		
		// Descobre lado do mouse
		if (mouse_x < x)
		{
			// esquerda
			hit_x = x - offset;
		}
		else
		{
			// direita
			hit_x = x + offset;
		}
		
		// altura do ataque
		var hit_y = y - sprite_height / 1.5;
		
		//Cria a hitbox
		instance_create_layer(hit_x, hit_y, layer, obj_hitbox);
		
		//Reseta o tempo
		atk_cooldown = 1; // 1 segundo
		atk_timer = atk_cooldown;
	}
	
	//SE a instancia da hitbox foi criada, então diminui o timer até ela se destruir
	if (instance_exists(obj_hitbox))
	{
		//Diminui o timer
		del_hitbox -= delta_time / 1000000;
		del_hitbox = clamp(del_hitbox, 0, 0.3);
		
		//Quando o timer chegar a zero, ela se deleta
		if (del_hitbox <= 0)
		{
			instance_destroy(obj_hitbox);	
			
			//Reseta o timer
			del_hitbox = 0.3;
		}
	}
}

#endregion





