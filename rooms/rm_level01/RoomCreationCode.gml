
//Roda a sequence de fade in
//Depois sai da cutscene

layer_sequence_create("sequence", 0, 0, sq_fade_in_01);

//ja inicia o player dessa room podendo atacar
with (obj_player)
{
	init_player = true;	
}

global.cutscene = false;