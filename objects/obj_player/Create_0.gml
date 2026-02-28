/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Variáveis de controle do player

//Variáveis de polimento visual
dash_ready		= true; // controla se já mostrou o efeito
pitao_feedback	= false; //Ativa o feedback visual da parede do pitao

//Variáveis de velocidade e gravidade e escala
velh		= 0;
velv		= 0;
max_velv	= 8;
max_velh	= 4;
grav		= 0.4;
dir			= 1;
scale_base  = 1.5;

//Variáveis de controle da tela de morte
dead = false;

//Desativa o cursor do mouse
window_set_cursor(cr_none);

//Variáveis de vida
life		   = 3;
cooldown_life  = 1; //1 Segundos
life_timer	   = cooldown_life;
damage		   = false;
invencible     = false;

//variáveis de fazer a tecla Q na cabeça do player flutuar
float_time = 0;

//Variáveis do shader piscada
init_flash();

//Variáveis de estado
enum PlayerState
{
    IDLE,
    RUN,
    JUMP,
    FALL,
    WALL,
    DASH,
	PITAO,
	ATTACK
}

state = PlayerState.IDLE;

//Variáveis de controle de colisão
chao = noone;

//Variável de queda livre
caindo = false;

//Variáveis para o double jump
jumps_air = 1; //Qtd de pulos que eu tenho para dar no Ar (sem contar o pulo normal)
qtd_jumps = jumps_air;
one_way_disabled = false; //Cuida da colisão de plataformas entre mundos

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
attacking = false;

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
	//Se estiver atacando eu fico parado
	if (attacking) velh = 0;
	
	//Utiliza os inputs
	inputs();
	
	#region //Movimento e direção
	//Movimento horizontal SE não estou em ataque
	if (!attacking) velh = (right - left) * max_velh;

	if (velh != 0 && !wall)
	{
	    dir = sign(velh);
	}

	image_xscale = dir * scale_base;
	
	#endregion
	
	#region //Chão e gravidade
	
	//SE estou no chão, eu posso pular
	if (chao)
	{
		//Movimento do pulo SE não estou na parede
		if (up && !wall)
		{
			//Cria a particula
			instance_create_depth(x, y, 100, obj_part_jump);
			
			//Pula
			velv -= 2;
			velv = clamp(velv, max_velv , -max_velv) //Limita a altura do pulo
			
			one_way_disabled = true;

			if (!global.world) global.one_way_collision_a = false;
			else global.one_way_collision_b = false;
			
		}
		
		//Reseto meus double jumps
		qtd_jumps = jumps_air;
		
		//Reseto meus dash
		qtd_dash = dash_mov;
		
	}
	else
	{	
		//SE não estou no chão, eu estou caindo
		caindo = true;
		
		//SE estou na parede a gravidade é menor
		if (wall)
		{
			//Diminui a gravidade
			grav = 0.04;
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
	#endregion
	
	#region //One way colisão
	
	// Se eu desativei a one way
	if (one_way_disabled)
	{
	    // Só reativa quando eu começar a cair
	    if (velv > 0)
	    {
	        one_way_disabled = false;
        
	        if (!global.world)
	            global.one_way_collision_a = true;
	        else
	            global.one_way_collision_b = true;
	    }
	}
	
	//SE eu estou no chão e caindo ainda é true, eu crio a particula
	//e SE a particula foi criada, então não estou caindo mais.
	if (chao && caindo)
	{
		if (instance_exists(obj_part_fall))
		{
			//Não estou mais caindo
			caindo = false;
		}
		else
		{
			//Crio a particula	
			instance_create_depth(x, y, 100, obj_part_fall);
		}
	}

	
	#endregion
	
}

//Update de estados do player
update_state = function()
{
	// SE já está atacando, mantém o estado
    if (attacking)
    {
        state = PlayerState.ATTACK;
        return;
    }
	
	// Começa ataque
	if (attack_mb)
	{
	    attacking = true;
	    state = PlayerState.ATTACK;
	    return;
	}
	
	// DASH tem prioridade máxima
    if (dash_ativado)
    {
        state = PlayerState.DASH;
        return;
    }

	//Quando está usando o pitao
	if (pitao_ativado && wall)
	{
		state = PlayerState.PITAO;
		return;
	}

    // WALL
    if (wall)
    {
        state = PlayerState.WALL;
        return;
    }

    // NO AR
    if (!chao)
    {
        if (velv < 0)
            state = PlayerState.JUMP;
        else
            state = PlayerState.FALL;

        return;
    }

    // NO CHÃO
    if (velh != 0)
    {
        state = PlayerState.RUN;
    }
    else
    {
        state = PlayerState.IDLE;
    }

}

//Máquina de estados do player
state_machine = function()
{
	//Variável para nova sprite
	var _new_sprite;
	
    switch(state)
    {
        case PlayerState.IDLE:
            if (!global.world) _new_sprite = spr_player_idle;
			else _new_sprite = spr_player_idle_mask;
        break;
		
		case PlayerState.ATTACK:
	    if (!global.world) _new_sprite = spr_player_attack;
		else _new_sprite = spr_player_attack_mask;

	    velh = 0;

	    // Se ainda não terminou
	    if (image_index < image_number - 1)
	    {
	        image_speed = 1;
	    }
	    else
	    {
	        image_speed = 0; // PARA no último frame
	        attacking = false;
	    }
		break;

        case PlayerState.RUN:
            if (!global.world) _new_sprite = spr_player_walk;
			else _new_sprite = spr_player_walk_mask;
        break;

        case PlayerState.JUMP:
            if (!global.world) _new_sprite = spr_player_jump;
			else _new_sprite = spr_player_jump_mask;
        break;

        case PlayerState.FALL:
            if (!global.world) _new_sprite = spr_player_fall;
			else _new_sprite = spr_player_fall_mask;
        break;

        case PlayerState.WALL:
            if (!global.world) _new_sprite = spr_player_wall;
			else _new_sprite = spr_player_wall_mask;
        break;

        case PlayerState.DASH:
           _new_sprite = spr_player_dash;
        break;
		
		case PlayerState.PITAO:
            if (!global.world) _new_sprite = spr_player_pitao;
			else _new_sprite = spr_player_pitao_mask;
        break;
		
	}
	
	if (sprite_index != _new_sprite)
	{
	    sprite_index = _new_sprite;
	    image_index = 0;     // <<< ESSENCIAL
	    image_speed = 1;     // garante que animação rode
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
	
	//Joga o player para fora das colisões
	sai_colisao();
	
	
	//SE estou dentro da área de mudar de mundo, então eu posso mudar
	if (place_meeting(x, y, obj_change_world))
	{
		global.cw_permission = true;	
	}
	else //SE não tiver na área não posso mudar
	{
		global.cw_permission = false;	
	}
}

//Pulo duplo
double_jump = function()
{
	//SE eu não estou no chão, e ainda tenho pulos, então eu pulo de novo
	if (!chao && qtd_jumps > 0)
	{
		//Se apertar a seta para cima, eu pulo e gasto meu pulo E não estou na parede
		if (up && !wall)
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
		//Diminui o timer do cooldown
		dash_cooldown--;
		
		// enquanto está em cooldown, marca como não pronto
		 dash_ready = false;
	}
	
	// Quando o cooldown ACABA (transição)
	if (dash_cooldown <= 0 && !dash_ready)
	{
	    dash_ready = true;
	    start_flash(1, 0, 0.7, 20, 0.4); // roxinho suave
	}
	
	// ATIVAR DASH (SE o dash não está ativado, e tem dash pra usar, aperto espaço, o cooldown
	//Está zerado, e não estou na parede)
	if (!dash_ativado && qtd_dash > 0 && space && dash_cooldown <= 0 && !wall && !attacking)
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
			dash_cooldown = 20; 
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
		//Feedback visual que está na parede para usala SE tiver o item
		if (global.pitao && !pitao_feedback) 
		{
			//Meio dourado
			start_flash(0.7, 0.85, 0, 20, 0.3);
			//Ativa o feedback
			pitao_feedback = true;
		}
	}
	else
	{
		//SE sair da parede 
		pitao_wall	   = false;
		pitao_ativado  = false;
		pitao_feedback = false;
		
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
	//Ao pressionar a tecla Q, troca entre os mundos SE não estiver atacando
	if (change_w && !attacking && global.cw_permission) global.world = !global.world;
	
	//SE world for false, é o mundo normal, se for true, é o mundo paralelo
	if (global.world)
	{
		//Torna só a layer plataform_b visivel
		layer_set_visible("plataform_b", true);
		layer_set_visible("plataform_a", false);
		
		//Torna visivel só a camada de layer world b
		layer_set_visible("world_b", true);
		layer_set_visible("world_a", false);

	}
	else
	{
		//Torna só a layer plataform_a visivel
		layer_set_visible("plataform_b", false);
		layer_set_visible("plataform_a", true);
		
		//Torna visivel só a camada de layer world a
		layer_set_visible("world_b", false);
		layer_set_visible("world_a", true);
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
		var offset = 45;
		var hit_x;
		
		// Descobre lado do mouse
		if (mouse_x < x)
		{
			// esquerda
			hit_x = x - offset;
			//Vira o personagem para esquerda também
			dir = -1;
		}
		else
		{
			// direita
			hit_x = x + offset;
			//Vira o personagem para direita também
			dir = 1;
		}
		
		// altura do ataque
		var hit_y = y - sprite_height / 2;
		
		//Cria a hitbox SE eu estiver no 3 frame da animação
		instance_create_layer(hit_x, hit_y, layer, obj_hitbox);
		
		//Reseta o tempo
		atk_cooldown = 0.7; // 0.7 segundo
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

//Flash / Piscada
update_flash = function()
{
    if (flash_timer > 0)
    {
        flash_timer--;

        var progress = flash_timer / flash_duration;

        // Curva suave (ease out)
        flash_intensity = progress * progress;
    }
    else
    {
        flash_intensity = 0;
    }
}

//Aplica o flash conforme colisões com itens
flash_collision = function()
{
	//Itens 
	var _wall_jump = place_meeting(x, y, obj_wall_jump);
	var _dash	   = place_meeting(x, y, obj_dash);
	var _ex_jump   = place_meeting(x, y, obj_extra_jump);
	var _pitao	   = place_meeting(x, y, obj_pitao);
	var _vida	   = place_meeting(x, y, obj_vida);
	
	//Se colidir com o extra jump, fica ciano / esverdedo
	if (_ex_jump)			start_flash(0, 1, 1, 20, 0.5);
	if (_dash)				start_flash(1, 0, 1, 15, 0.5);
	if (_wall_jump)			start_flash(0, 0.7, 0.7, 15, 0.5);
	if (_pitao)				start_flash(1, 1, 1, 15, 0.3);
	if (_vida)				start_flash(0.7, 0, 0, 15, 0.6);
}

//Sistema de dano sofrido
damage_player = function()
{
	//SE eu morri eu não sofro mais dano
	if (dead) return;
	
	var _hitbox = place_meeting(x, y, obj_hitbox_enemy);
	var _enemy  = place_meeting(x, y, obj_inimigo);
	var _saw	= instance_place(x, y, obj_saw);
	
	#region	//Colisões
	
	//SE eu colidir com a hitbox do inimigo, eu perco vida e fico invencivel um tempo
	if (_hitbox && !damage && !invencible)
	{		
		//Treme um pouco a tela
		tremor(4);
		
		//Cor vermelha do flash
		start_flash(1, 0, 0, 15, 1);
		
		//Sofro o dano
		life--;
		
		damage = true;
		invencible = true;
	}
	
	//SE eu colidir com a hitbox do inimigo, eu perco vida e fico invencivel um tempo
	if (_enemy && !damage && !invencible)
	{		
		//Treme um pouco a tela
		tremor(4);
		
		//Cor vermelha do flash
		start_flash(1, 0, 0, 15, 1);
		
		//Sofro o dano
		life--;
		
		damage = true;
		invencible = true;
	}
	
	//SE eu colidir com a hitbox do inimigo, eu perco vida e fico invencivel um tempo
	if (_saw != noone && !damage && !invencible && _saw.saw_world == global.world)
	{
	    //Treme um muito a tela
		tremor(10);
		
		start_flash(1, 0, 0, 15, 1);

	    life -= 2;
	    damage = true;
	    invencible = true;
	}
	
	#endregion
	
	//Fica invencivel
	if (life_timer > 0 && damage)
	{		
		//Diminui o timer
		life_timer -= delta_time / 1000000;
	}
	else
	{
		//SE for zero ou menor, ele sai do estado de dano
		damage = false;
		
		//Acaba invencibilidade
		invencible = false;
		
		//Fica visivel novamente
		image_alpha = 1;
		
		//Reseta o timer
		life_timer = cooldown_life;
	}
	
	//SE a vida chegar a 0, o player morre
	if (life <= 0 && !dead)
	{		
		dead = true;
	    global.cutscene = true;
    
	    // Para o movimento
	    velh = 0;
	    velv = 0;
		image_alpha = 0;
		
		//Cria a instancia do personagem morte
		if (object_exists(obj_player_death))
		{
			if (!instance_exists(obj_player_death))
			{
				//Cria a instancia
				instance_create_layer(x, y, "player", obj_player_death);
				global.death = true;
			}
			else
			{
				//SE já criou então o player se destroi
				instance_destroy(id);
			}
		}
	}
	
}

#endregion