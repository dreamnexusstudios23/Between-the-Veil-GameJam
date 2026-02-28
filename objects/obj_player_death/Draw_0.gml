
//Muda o alpha
draw_set_alpha(1)

//Muda a cor
draw_set_color(make_color_rgb(235, 0, 0));

//Desenha na tela
draw_rectangle(
    camera_get_view_x(view_camera[0]),
    camera_get_view_y(view_camera[0]),
    camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]),
    camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]),
    false
);

//Reseta e desenha o player
draw_set_alpha(1);
draw_set_color(-1)
draw_self();