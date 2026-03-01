
// Define fonte
draw_set_font(fnt_try_again);

// Centraliza texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Desenha na posição do objeto
draw_text(x, y, "Aperte ENTER para \nficar em tela cheia");

// Reseta
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);