// Atualiza timer do piscar
blink_timer += blink_speed;

// Se apertar espaço, vai para o tutorial
if (keyboard_check_pressed(vk_space))
{
    //Mostrar sequence, e iniciar alarme
	layer_sequence_create(layer, 0, 0, sq_fade_out_menu);
	
	alarm[0] = 60; 
}