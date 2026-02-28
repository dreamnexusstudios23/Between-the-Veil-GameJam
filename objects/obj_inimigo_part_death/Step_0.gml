/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Usa os métodos
collision_and_gravity_check(); //Verifica as colisões e aplica gravidade


//Depois que eu fui criado o timer diminui
t_death_atual -= delta_time / 1000000;

//SE o timer chegar a 0, então meu alpha começa a diminuir
if (t_death_atual <= 0)
{
	image_alpha -= 0.01; //Diminui o alpha devagar
	
	if (image_alpha <= 0.02)
	{
		instance_destroy();	
	}
}


