/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//SE não está no mundo alternativo, a plataforma B n existe colisão
if (!global.world) 
{
	//N permite a colisão voltar
	global.plataform_b_colission = true;
	mask_index = spr_one_way_plataform_no_collision;
}
else 
{
	global.plataform_b_colission = false;
	mask_index = spr_one_way_plataform;
}

//SE a colisão one way for false, ela não tem colisão
if (!global.one_way_collision_b) mask_index = spr_one_way_plataform_no_collision;
else mask_index = spr_one_way_plataform;
