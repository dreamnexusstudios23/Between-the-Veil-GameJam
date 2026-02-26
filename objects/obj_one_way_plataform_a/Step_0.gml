/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//SE está no mundo alternativo, a plataforma A n existe colisão
if (global.world) 
{
	//N permite a colisão voltar
	global.plataform_a_colission = true;
	mask_index = spr_one_way_plataform_no_collision;
}
else 
{
	global.plataform_a_colission = false;
	mask_index = spr_one_way_plataform;
}

//SE a colisão one way for false, ela não tem colisão
if (!global.one_way_collision_a) mask_index = spr_one_way_plataform_no_collision;
else mask_index = spr_one_way_plataform;


