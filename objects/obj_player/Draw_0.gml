/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region	//Desenha o efeito do DASH
// Desenha rastros só se estiver dashando
if (dash_ativado)
{
    var trail_count = 10;
    var trail_space = 6;

    for (var i = 1; i <= trail_count; i++)
    {
        draw_sprite_ext(
            sprite_index,
            image_index,
            x - (dash_dir * trail_space * i),
            y,
            image_xscale,
            image_yscale,
            0,
            c_white,
            0.20
        );
    }
}
#endregion

// Desenha normal
draw_self();

if (global.debug)
{
	//Alinhando o texto
	draw_set_halign(1);
	draw_set_valign(1);

	draw_text(x, y - sprite_height - 20, image_number);

	//Resta os draw
	draw_set_halign(-1);
	draw_set_valign(-1);
}
