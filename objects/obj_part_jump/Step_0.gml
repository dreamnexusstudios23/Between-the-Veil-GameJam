/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Se foi criado, diminui o alpha
if (image_alpha > 0)
{
	//Vai diminuindo o alpha
	image_alpha -= 0.015;
}

//Quando o alpha for zero eu me destruo e acabou a animação
if (image_alpha <= 0 && image_index >= image_number - 1)
{
	instance_destroy(id);	
}


