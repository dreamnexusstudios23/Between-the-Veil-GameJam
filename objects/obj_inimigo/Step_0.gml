/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Método utilizados

//Método de sofrer dano
damage();

//Método de aplicar a colisão com o chão
pixel_perfect();

//Método de bater no colisor da serra e voltar, bate volta
back_turn();

//Aplica a máquina de estados
state_machine();

//Atualiza animação
update_animation();

//Checa a gravidade
grav_check();

//Checa se ainda sou alvo
targed_check();

//Atualiza a direção para onde está olhando (gambiarra) :)
image_xscale = dir * 2;

#endregion


