/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Variáveis de controle do inimigo

//Variáveis de vida
life		 = 1;
dmg_cooldown = 0; //Já começa em 0 ou seja, podendo já ser atacado
dmg_timer	 = dmg_cooldown;

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

#endregion
