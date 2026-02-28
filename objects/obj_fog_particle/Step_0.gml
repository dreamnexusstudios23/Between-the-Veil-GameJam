/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Utiliza a particula
//SÓ CRIA SE EU NÃO MORRI
if (!global.death)
{
	for (var i = 0; i < density; i++)
	{
	    part_particles_create(
	        ps_fog,
	        x + random_range(-fog_width/2, fog_width/2),
	        y + random_range(-8, 8), // pouco espalhamento vertical
	        pt_fog,
	        1
	    );
	}
}