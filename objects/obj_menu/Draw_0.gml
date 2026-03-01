// Calcula alpha piscando (usando seno fica suave)
var _alpha = 0.5 + 0.5 * sin(blink_timer);

// Aplica alpha
draw_set_alpha(_alpha);

// Define fonte
draw_set_font(fnt_death);

// Centraliza texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Desenha na posição do objeto
draw_text(x, y, "APERTE ESPAÇO PARA\nCOMEÇAR");

// Reseta
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);