/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Se estiver ativado, fade in
if (tutorial_on)
{
    alpha_tutorial = lerp(alpha_tutorial, 1, 0.1);
}
else // Se estiver desativado, fade out
{
    alpha_tutorial = lerp(alpha_tutorial, 0, 0.1);
}

// Só desenha se não estiver totalmente invisível
if (alpha_tutorial > 0.01)
{
    // Define transparência
    draw_set_alpha(alpha_tutorial);

    // Fonte e alinhamento
    draw_set_font(fnt_pixel);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);

    // Texto
    draw_text(x, y, "Aperte     \npara usar o \nPITÃO na \nparede");
    
    // Tecla
    draw_sprite_ext(
        spr_f, 
        0, 
        x + 26, 
        y - 25, 
        0.4, 
        0.4, 
        image_angle, 
        image_blend, 
        alpha_tutorial // usa a mesma alpha
    );

    // Reset
    draw_set_alpha(1);
    draw_set_font(-1);
    draw_set_valign(-1);
    draw_set_halign(-1);
}