/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//SE EU MORRI, ESCREVE VOCÊ MORREU NO MEIO DA TELA
if (global.death)
{
	var _horizontal = display_get_gui_width() / 2;
	var _vertical   = display_get_gui_height() / 2;
	
	//Define a fonte grande
	draw_set_font(fnt_death);
	
	//Centraliza
	draw_set_valign(1);
	draw_set_halign(1);
	
	//Escreve VOCÊ MORREU
	draw_text(_horizontal, _vertical, "VOCÊ MORREU!");
	
	//reseta
	draw_set_font(-1);
	draw_set_halign(-1);
	draw_set_valign(-1);
	
	//Define a fonte grande
	draw_set_font(fnt_try_again);
	
	//Centraliza
	draw_set_valign(1);
	draw_set_halign(1);
	
	//Escreve "R" para tentar novamente
	draw_text(_horizontal, _vertical + 55, "'R' para tentar novamente");
	
	//reseta
	draw_set_font(-1);
	draw_set_halign(-1);
	draw_set_valign(-1);
	
	
}


