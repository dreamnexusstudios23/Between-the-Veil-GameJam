/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

spark_timer++;

//Só crio a particula se Estou no mundo alternativo
if (!global.world && !global.death)
{
	if (spark_timer >= spark_interval)
	{
	    spark_timer = 0;
    
	    part_particles_create(
	        ps_spark,
	        x,
	        y,
	        pt_spark,
	        1
	    );
	}
}



