/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Me desenhando
draw_self();

if (global.debug)
{
	//Alinhando o texto
	draw_set_halign(1);
	draw_set_valign(1);

	draw_text(x, y - sprite_height - 20, qtd_jumps);

	//Resta os draw
	draw_set_halign(-1);
	draw_set_valign(-1);
}
