/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (text)
{
	//Define a fonte
	draw_set_font(fnt_death);

	//Centraliza
	draw_set_halign(1);
	draw_set_valign(1);

	//Escreve você venceu!
	draw_text(x, y, "APERTE ESPAÇO PARA COMEÇAR");

	//Reseta
	draw_set_font(-1);
	draw_set_halign(-1);
	draw_set_valign(-1);
}

