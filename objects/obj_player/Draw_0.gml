/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region	//Desenha o ícone do mouse

//Desenha o ícone na posição X e Y do mouse
draw_sprite(spr_mouse, 0, mouse_x, mouse_y);

#endregion

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

#region //Desenha o shader de flash com cor personalizavel 

draw_flash();

#endregion

#region //Desenha a tecla de mudar de mundo na cabeça do player

// SE estou na zona da tecla, ela aparece na minha cabeça
if (global.tecla_cw)
{
	var offset = cos(float_time) * 3; // 3 = altura do movimento (bem leve)

	draw_sprite_ext(
		spr_q,
		1,
		x,
		y - sprite_height - 10 + offset,
		0.4,
		0.4,
		0,
		c_white,
		1
	);	
}

#endregion

if (global.debug)
{
	//Alinhando o texto
	draw_set_halign(1);
	draw_set_valign(1);

	draw_text(x, y - sprite_height - 20, life);

	//Resta os draw
	draw_set_halign(-1);
	draw_set_valign(-1);
}
