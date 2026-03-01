/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Faz o alpha do letreiro começar
alpha = lerp(alpha, 1, 0.01);

//Faz o timer diminuir
timer_restart -= delta_time / 1000000;

if (timer_restart <= 0)
{
	global.cutscene = true;
	
	//Para todos os sons
	audio_stop_all();
	
	//Inicia o timer que volta pro menu
	timer_menu -= delta_time / 1000000;
	
	text = false;
}

//Quando o timer chegar a zero, ele cria a sequence de fade
layer_sequence_create("sequence", 0, 0, sq_fade_out_final);

//Quando timer menu for 0, eu volto pro menu
if (timer_menu <= 0)
{
	room_goto(rm_menu);
	
	//Reinicia as globais
	global.dash = false;
	global.death = false;
	global.pitao = false;
	global.wall_jump = false;
	global.saw_world = false;
	global.world = false;
	
	timer_menu = 2;
	timer_restart = 4;
}