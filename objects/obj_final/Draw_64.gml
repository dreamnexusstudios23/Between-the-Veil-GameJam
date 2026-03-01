/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (text)
{
	//Define a fonte
	draw_set_font(fnt_death);

	//Centraliza
	draw_set_halign(1);
	draw_set_valign(1);

	//Pega o meio da tela
	var _horizontal = display_get_gui_width() / 2;
	var _vertical = display_get_gui_height() / 2;

	//Escreve você venceu!
	draw_text(_horizontal, _vertical, "VOCÊ ESCAPOU!");

	//Reseta
	draw_set_font(-1);
	draw_set_halign(-1);
	draw_set_valign(-1);
}

