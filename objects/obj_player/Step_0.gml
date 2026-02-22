/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Utilza os métodos

//Aplica a colisão e movimento
pixel_perfect();

//Checa se estou no chão
collision_check();

//Método de movimento
move();

//Método do pulo duplo
double_jump();

//Método de pular na parede
wall_jump();

//Método para usar o dash
dash();

#endregion

//SE apertar o TAB, ativa o debug
if (keyboard_check_pressed(vk_tab)) global.debug = !global.debug;



