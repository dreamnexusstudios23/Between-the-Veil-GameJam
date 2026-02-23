/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Se desenha
draw_self();

if (global.debug)
{
	//Desenha o raio de visão
	draw_circle(x, y, rain_size, true);
	
	//Desenha em que estado ele está
	draw_set_halign(1);
	draw_set_valign(1);
	draw_text(x, y - sprite_height, state);
	draw_set_halign(-1);
	draw_set_valign(-1);
}


