/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Utilza os métodos

//Aplica a colisão e movimento
pixel_perfect();

//Checa se estou no chão
collision_check();

//Desenha a tecla na cabeça do player (gambiarra kkk)
global.tecla_cw = place_meeting(x, y, obj_change_world);

//Método de movimento (SE não estou em cutscene)
if (!global.cutscene) move();

//Método do pulo duplo
if (!global.cutscene) double_jump();

//Método de pular na parede SE eu peguei a habilidade
if (global.wall_jump && !global.cutscene) wall_jump();

//Método para usar o dash
if (global.dash && !global.cutscene) dash();

//Método do item pitao
if (!global.cutscene) pitao_item();

//Método de alternar entre os mundos
if (!global.cutscene) change_world();

//Método de ataque
if (!global.cutscene) attack();

//Faz update dos estados
if (!global.cutscene) update_state();

//Método da máquina de estados do player
if (!global.cutscene) state_machine();

//Método de sofrer dano
if (!global.cutscene) damage_player();

//Usa o efeito de dano
if (!global.cutscene) update_flash();

//Método que identifica o objeto que colide e aplica o efeito de flash
if (!global.cutscene) flash_collision();

//Gambiarra que arruma a escala do boneco pq eu fiz ele mt pequeno ;(
image_xscale = dir * scale_base;
image_yscale = scale_base;

//Faz a tecla flutuar na cabeça do player
float_time += 0.05; 

#endregion

//SE apertar o TAB, ativa o debug
if (keyboard_check_pressed(vk_tab)) global.debug = !global.debug;



