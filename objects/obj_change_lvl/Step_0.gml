

//SE colidir com o player cria a sequence de fade apenas uma vez
if (!ativado && place_meeting(x, y, obj_player))
{
    ativado = true;
    
    // Cria a sequence
    layer_sequence_create("sequence", 0, 0, seq);
    
    // Inicia o alarm para trocar de room
    alarm[0] = 60;
}

if (ativado)
{
    with (obj_player)
    {	
        image_alpha = lerp(image_alpha, 0, 0.2);

        if (image_alpha <= 0.05)
        {
            instance_destroy();
        }
    }
}