/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Se desenha
draw_self()

//Desenha a tela vermelha
#region //Fica tudo vermelho

//Desenha tela vermelha
var _horizontal = display_get_gui_width();
var _vertical   = display_get_gui_height();

//Escolhe a cor
draw_set_color(make_color_rgb(125, 0, 0));
draw_rectangle(0, 0, _horizontal, _vertical, false);

//Reseta a cor
draw_set_color(-1);


#endregion


