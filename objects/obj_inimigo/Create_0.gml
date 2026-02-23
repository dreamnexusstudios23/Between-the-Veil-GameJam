/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Variáveis de controle do inimigo

//Variáveis de velocidade e gravidade
velh		= 0;
velv		= 0;
max_velv	= 10;
max_velh	= 3;
grav		= 0.4;

//Variáveis de vida
life		 = 1;
dmg_cooldown = 0; //Já começa em 0 ou seja, podendo já ser atacado
dmg_timer	 = dmg_cooldown;

//Variáveis de estado
state		   = "idle";
t_change_state = 2; // 2 Segundos
alvo		   = noone;
collision_rain = false; //Identifica se entrou no raio
rain_size	   = 180;
chao		   = noone;

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
		//Debug
		show_message("fui atacado");
		
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

//Máquina de estados
state_machine = function()
{
	#region //Identificador se entrou no raio de visão do inimigo
	//Cria o raio de ação
	var _player = collision_circle(x, y, rain_size, obj_player, false, true);
	
	//SE estiver no raio do inimigo
	if (_player)
	{
		//Define o player como alvo se a instancia do player existir
		if (instance_exists(obj_player)) alvo = _player
		
		//Aumenta o raio
		rain_size = 250;
		
		//Identifica que entrou no raio
		collision_rain = true;
		
		//SE já entrou no raio, então ele reseta o timer que muda o estado do inimigo
		t_change_state = 2; //2 segundos
		
		//vai para o estado de perseguição
		state = "chase";
	}
	else
	{
		//SE não estiver mais no raio, ele volta ao tamanho normal
		rain_size = 180;
		
		//Não tenho mais alvo
		alvo = noone;
		
		//Identifica que saiu no raio
		collision_rain = false;
		
		//Volto para o estado parado
		state = "idle";
	}
	#endregion
	
	switch(state)
	{
		#region //Parado
		case "idle":
			
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
			}

		break;
		#endregion
		
		#region //Andando
		case "walk" :
			
		
		break;
		#endregion
	}
}

#endregion
