/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Variáveis de controle da particula
grav = 0.2;
chao = false;

timer_death = 4; //4 segundos
t_death_atual = timer_death;


//Método de aplicar a gavidade e verificar se está ou não no chão
collision_and_gravity_check = function()
{
	//Verifica se estou colidindo com o chão ou paredes
	var _chao		= place_meeting(x, y + 1, obj_colisor_a);
	var _parede_dir = place_meeting(x + 1, y, obj_colisor_a);
	var _parede_esq = place_meeting(x - 1, y, obj_colisor_a);
	
	//SE estou colidindo com o chão e define se estou ou não no chão
	if (_chao)
	{
		chao = true; //Estou no chão
	}
	else
	{
		//Não estou no chão
		chao = false;
	}
	
	//SE estou colidindo com algumas das paredes eu Zero meu vspeed
	if (_parede_dir or _parede_esq)
	{
		hspeed = 0;	
	}
	
	//SE não estou no chão, então eu aplico gravidade
	if (!chao)
	{
		vspeed += grav;	
	}
	else
	{
		hspeed = 0;
		vspeed = 0;	
	}
}	


