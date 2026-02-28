/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Sempre que o player colidir comigo ele começa a ficar invisivel até se 
//destruir
if (place_meeting(x, y, obj_player))
{
	with (obj_player)
	{
		//Faz ele ficar parado
		velv = 0;
		velh = 0;
	
		//Diminui com lerp a visibilidade
		image_alpha = lerp(image_alpha, 0, 0.2);
	
		//SE for 0 ele se destroi
		if (image_alpha <= 0.2)
		{
			instance_destroy(obj_player);	
		}
	}
	
}

