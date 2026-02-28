/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Desenha o HUD na tela SE não está em cutscene
if (!global.cutscene)
{
	//Posição X
	var _pos_x = 0;
	
	//Deseha a vida
	repeat(life)
	{		
		//Desenha a sprite 
		draw_sprite_ext(spr_vida, 0, 20 + _pos_x, 20, 2, 2, image_angle, image_blend, image_alpha);
		
		//Sempre depois de desenhar, da um espaço a mais no eixo X
		_pos_x += 35;
	}
	
	//Posição X Espaçamento Dash
	var _dash_x = 0;
	
	//Desenha a quantidade de Dash
	repeat(qtd_dash)
	{
		//Desenha a sprite de dash	
		draw_sprite_ext(spr_dash_HUD, 0, 20 + _dash_x, 45, 2, 2, image_angle, image_blend, image_alpha);
		
		//Sempre da um espaço entre os icones
		_dash_x += 35;
	}
}

#endregion


