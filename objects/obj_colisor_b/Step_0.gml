/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//SE o global world for true, desativa a colisão deste objeto
if (!global.world) sprite_index = spr_no_collision;

//SE o global world for false, volta a colisão deste objeto
if (global.world) sprite_index = spr_colisor_b;

