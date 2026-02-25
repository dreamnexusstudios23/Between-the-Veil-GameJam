// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Global para debug
global.debug = false;

#region //Globais de itens

global.pitao = true;

global.world = false;

global.one_way_collision = false;

#endregion

#region //Global de habilidades

global.wall_jump = false; //Pulo na parede	
global.dash		 = false; //Dash

#endregion

#region	//Functions

function sai_colisao()
{
    var _max = 50; // limite de segurança
    
    for (var i = 0; i < _max; i++)
    {
        if (
            place_meeting(x, y, obj_colisor_a) or
            place_meeting(x, y, obj_colisor_b) or
            place_meeting(x, y, obj_one_way_plataform)
        )
        {
            // Se tiver velocidade, usa ela
            if (velh != 0) x -= sign(velh);
            if (velv != 0) y -= sign(velv);
            
            // Se estiver parado, empurra para cima como fallback
            if (velh == 0 and velv == 0)
            {
                y -= 1;
            }
        }
        else
        {
            break;
        }
    }
}

function init_flash()
{
	// Controle do flash
	flash_intensity = 0;      // intensidade atual
	flash_timer = 0;          // tempo atual
	flash_duration = 0;       // duração total

	flash_r = 1;
	flash_g = 1;
	flash_b = 1;	
}

/// @function start_flash(_r, _g, _b, _duration, _max_intensity)
function start_flash(_r, _g, _b, _duration, _max_intensity)
{
    flash_r = _r;
    flash_g = _g;
    flash_b = _b;

    flash_duration = _duration;
    flash_timer = _duration;

    flash_intensity = _max_intensity;
}

function draw_flash()
{
	if (flash_intensity > 0)
	{
	    shader_set(sh_flash);

	    var _u_flash = shader_get_uniform(sh_flash, "u_flash");
	    var _u_color = shader_get_uniform(sh_flash, "u_flashColor");

	    shader_set_uniform_f(_u_flash, flash_intensity);
	    shader_set_uniform_f(_u_color, flash_r, flash_g, flash_b);

	    draw_self();

	    shader_reset();
	}
	else
	{
	    draw_self();
	}	
}


#endregion