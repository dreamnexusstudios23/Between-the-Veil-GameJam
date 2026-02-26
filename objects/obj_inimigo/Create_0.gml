/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Variáveis de controle do inimigo

//Variáveis de velocidade e gravidade
velh = 0;
velv = 0;
grav = 0.4;
max_velh = 2;
max_velv = 10;
dir = choose(-1, 1); //Escolhe pra onde começa indo

//Variáveis de controle do tamanho
image_xscale = 2.2;
image_yscale = 2.2;

//Variáveis de vida
life		 = 1;
dmg_cooldown = 0; //Já começa em 0 ou seja, podendo já ser atacado
dmg_timer	 = dmg_cooldown;

//Variáveis de estado
state		   = "idle";
t_change_state = 2; // 2 Segundos
t_move_state   = 3; //5 segundos
alvo		   = noone;
collision_rain = false; //Identifica se entrou no raio
rain_size	   = 180;
chao		   = noone;

//Variáveis do estado de perseguição
t_chase_state = 4; //4 segundos
t_chase_run	  = 3; //3 segundos
t_atk		  = 0.6 // 1.3 segundos
del_atk		  = 0.7 // 0.7 segundos para deletar o hitbox

#endregion

#region //Métodos

//Sofrendo dano
damage = function()
{
	//Diminui o timer do cooldown para receber ataque do player
	dmg_timer -= delta_time / 1000000;
	dmg_timer = clamp(dmg_timer, 0, dmg_cooldown);
	
	//SE colidir com a hitbox do ataque do player, sofre dano
	if (place_meeting(x, y, obj_hitbox) && dmg_timer <= 0)
	{		
		//Perco vida
		life--;
		
		//Reseto o timer e adiciono um tempo pela primeira vez
		dmg_cooldown = 0.6;
		dmg_timer	 = dmg_cooldown;
	}
	
	
	//SE a vida chegar a 0 eu morro
	if (life <= 0)
	{
		instance_destroy(id);	
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

//Checa a gravidade
grav_check = function()
{
	//SE não tem chão, ele aplica a gravidade
	if (!chao) velv += grav;
}

//Checa o raio de ação
rain_entrance_check = function()
{
	#region //Identificador se entrou no raio de visão do inimigo
	//Cria o raio de ação
	var _player = collision_circle(x, y, rain_size, obj_player, false, true);
	
	//SE estiver no raio do inimigo
	if (_player)
	{	
		//Aumenta o raio
		rain_size = 250;
		
		//Identifica que entrou no raio
		collision_rain = true;
		
		//SE já entrou no raio, então ele reseta o timer que muda o estado do inimigo
		t_change_state = 2; //2 segundos
		
		//vai para o estado de perseguição SE já não estiver nele
		if (state != "chase") state = "chase";
	}
	else
	{
		//Volta para o estado parado, apenas se tiver em chase
		if (state == "chase") state = "walk";
		
		//SE não estiver mais no raio, ele volta ao tamanho normal
		rain_size = 180;
		
		//Identifica que saiu no raio
		collision_rain = false;	
	}
		
	#endregion	
}

//Checa o alvo
targed_check = function()
{
	//SE a instancia do player existe
	if (instance_exists(obj_player))
	{
		//SE estou dentro do raio
		if (collision_rain)
		{
			alvo = obj_player;	
		}	
		else
		{
			alvo = noone;	
		}
	}
	
}

//Atualiza animação
update_animation = function()
{
    switch(state)
    {
        case "idle":
            sprite_index = spr_enemy_idle;
            image_speed = 1;
        break;

        case "walk":
            sprite_index = spr_enemy_walk;
            image_speed = 1;
        break;

        case "chase":
            sprite_index = spr_enemy_walk;
            image_speed = 1;
        break;

        case "run":
            sprite_index = spr_enemy_run;
            image_speed = 1;
        break;

        case "load_attack":
            sprite_index = spr_enemy_load;
            image_speed = 1;
        break;

        case "attack":
            sprite_index = spr_enemy_attack;
			image_speed = 1;
        break;
    }
}

//Máquina de estados
state_machine = function()
{	
	switch(state)
	{
		#region //Parado
		case "idle":
		
			//Sempre checando se entrei no raio do inimigo
			rain_entrance_check();
			
			//Diminui o tempo de ficar parado
			t_change_state -= delta_time / 1000000;
			t_change_state = clamp(t_change_state, 0, 2);
			
			//Fica parado
			velh = 0;
			//SE estiver no chão, o velv também zera
			if (chao) velv = 0;
			
			//SE ainda não entrou no raio, e o tempo acabou ele muda de estado
			if (!collision_rain && t_change_state <= 0)
			{
				//Muda para o estado de andando
				state = "walk";
				
				//Reseta o timer
				t_change_state = 2;
			}

		break;
		#endregion
		
		#region //Andando
		case "walk":
		
			//Faz a checagem se estou no raio
			rain_entrance_check();
			
			//Diminui o timer de caminhada
			t_move_state -= delta_time / 1000000;
			
		    // Movimento horizontal simples
		    velh = dir * max_velh;

		    // Se bater na parede, troca direção
		    if (place_meeting(x + sign(velh), y, obj_colisor_a))
		    {
		        dir *= -1;
		    }
			
			//SE o timer de movimento zerar E eu não estiver no raio do inimigo, 
			//ele pode escolher entre seguir se
			//movendo ou ficar parado
			if (t_move_state <= 0 && !collision_rain)
			{
				state = choose("idle", "walk");	
				
				//Reseta o timer
				t_move_state = 3;
			}

		break;
		#endregion
		
		#region //Perseguindo o player
		case "chase":
			
			//Continua chegando se estou no raio
			rain_entrance_check();
			
			//Velocidade volta ao normal
			max_velh = 2;
			
			//Diminui o timer e limita ele
			t_chase_state -= delta_time / 1000000;
			//t_chase_state = clamp(t_change_state, 0, 4);
			
			//SE eu tenho alvo
		    if (instance_exists(alvo))
		    {
		        // Decide direção baseada na posição do player
		        if (alvo.x > x)
		        {
		            dir = 1;
		        }
		        else
		        {
		            dir = -1;
		        }

		        // Move horizontalmente
		        velh = dir * max_velh;
		    }
			
			//Verifica a distância para o player
			if (instance_exists(alvo)) var _dist_player = point_distance(x, y, alvo.x, alvo.y);
			
			//SE eu estiver próximo ao player, eu entro no estado de preparando ataque
			if (instance_exists(alvo))
			{
				if (_dist_player < 70)
				{
					state = "load_attack";	
				}
			}
			
			//Depois de passar o tempo, ele escolhe se quer correr ou continuar em chase
			//padrão
			if (t_chase_state <= 0)
			{
				//Escolhe se quer correr ou continuar caminhando na chase
				state = choose("chase", "run", "run");
				
				//Reseta o timer
				t_chase_state = 4;
			}

		break;
		#endregion
		
		#region	//Correndo
		case "run":
			//Muda animação
			
			//Diminui o timer para mudar de estado e limita
			t_chase_run -= delta_time / 1000000;
			t_chase_run = clamp(t_chase_run, 0, 3);
			
			//Aumenta a velocidade
			max_velh = 5;
			
			velh = dir * max_velh;
			
			//Verifica a distância para o player SE eu tenho alvo
			if (instance_exists(alvo)) var _dist_player = point_distance(x, y, alvo.x, alvo.y);
			
			//SE eu estiver próximo ao player, eu entro no estado de preparando ataque
			if (instance_exists(alvo))
			{
				if (_dist_player < 70)
				{
					state = "load_attack";	
				}
			}
			
			//SE o timer zerar, ele volta para o estado de chase
			//Ou se colidir com algo
			var _colidiu_dir = place_meeting(x + 1, y, obj_colisor_a);
			var _colidiu_esq = place_meeting(x - 1, y, obj_colisor_a);
			
			if (t_chase_run <= 0 or _colidiu_dir or _colidiu_esq)
			{
				state = "chase";
				
				//Reseta o timer
				t_chase_run = 3;
			}
		
		break;
		#endregion
		
		#region //Carregando ataque
		case "load_attack":
			//Diminui o timer e limita ele
			t_atk -= delta_time / 1000000;
			
			//Fica parado
			velh = 0;
			
			//Animação carregando ataque
			
			//Quando zerar o timer, entra no estado de ataque
			if (t_atk <= 0)
			{
				state = "attack";	
				image_index = 0
				
				//Reseta o timer
				t_atk = 0.6;
			}
			
		break;
		#endregion
		
		#region //Atacando
		case "attack":

			//Cria a hitbox com base na direção que o inimigo está olhando por último
			if (dir == -1)
			{
				//Distância da hitbox
				var _offset = 70;
				
				//Cria hitbox para esquerda
				instance_create_layer(x - _offset, y - sprite_height, layer, obj_hitbox_enemy);
			}
			else if (dir == 1)
			{
				//Distância da hitbox
				var _offset = 22;
				
				//Cria hitbox para esquerda
				instance_create_layer(x + _offset, y - sprite_height, layer, obj_hitbox_enemy);	
			}
			
			//SE foi criado a hitbox
			if (instance_exists(obj_hitbox_enemy))
			{
				//Diminui o timer para destruir ela
				del_atk -= delta_time / 1000000;
				del_atk = clamp(del_atk, 0, 0.7);
				
				//Se o timer zerar destroi a hitbox
				if (del_atk <= 0)
				{
					instance_destroy(obj_hitbox_enemy);
					
					//Reseta o timer
					del_atk = 0.7;
					
					//E sai do estado
					state = "idle";
					
				}
			}
			
			//Se o inimigo morreu, também destroi a hitbox
			if (life <= 0)
			{
				instance_destroy(obj_hitbox_enemy);	
			}
			
		break;
		#endregion
		
	}
}

back_turn = function()
{
	// SE bater no colisor de serra ele volta
	if (place_meeting(x, y, obj_saw_collide))
	{
		dir *= -1;          // Inverte direção
		velh = dir * max_velh; // Atualiza a velocidade já na nova direção
	}
}

#endregion
