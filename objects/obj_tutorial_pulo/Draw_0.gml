/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//SÓ aparece que foi ativado o tutorial pelo trigger
if (tutorial_on)
{	
	//Defino a fonte e centralizo o texto
	draw_set_font(fnt_pixel);
	draw_set_valign(1);
	draw_set_halign(1);

	//Escrevo na tela o tutorial de pulo
	draw_text(x, y, "Para pular aperte    \nE para pulo duplo aperte 2x");
	
	//Desenho a tecla no espaço 
	draw_sprite_ext(spr_w, 0, x + 60, y - 10, 0.4, 
	0.4, image_angle, image_blend, image_alpha);

	//Reseto os draws
	draw_set_font(-1);
	draw_set_valign(-1);
	draw_set_halign(-1);
}

