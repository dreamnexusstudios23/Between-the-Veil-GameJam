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

//Método do item pitao
pitao_item();

//Método de alternar entre os mundos
change_world();

//Método de ataque
attack();

//Faz update dos estados
update_state();

//Método da máquina de estados do player
state_machine();

//Gambiarra que arruma a escala do boneco pq eu fiz ele mt pequeno ;(
image_xscale = dir * scale_base;
image_yscale = scale_base;

#endregion

//SE apertar o TAB, ativa o debug
if (keyboard_check_pressed(vk_tab)) global.debug = !global.debug;



