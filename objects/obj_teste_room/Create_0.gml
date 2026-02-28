/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//SE ainda não estiver tocando a música escolhida
if (!audio_is_playing(music))
{
	//Então ele começa a tocar a música escolhida	
	audio_play_sound(music, 0, true);
}

//Variáveis para screenshake
treme = 0;


