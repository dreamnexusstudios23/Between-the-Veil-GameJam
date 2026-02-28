// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Global para debug
global.debug = false;

#region	//Globais tutorial

//Tutorial de mostrar a tecla para mudar de mundo
global.tecla_cw = false;

#endregion

#region	//Global de cutscene

global.cutscene = false;
global.death	= false;

#endregion

#region //Globais de itens

global.pitao = false;

global.world = false;

//Global que só permite mudar de mundo se estiver dentro da área
global.cw_permission = false;

//Controle das variáveis das plataformas A e B
global.one_way_collision_a = true;
global.one_way_collision_b = true;


//Variável que verifica se a serra está no mundo A ou B
global.saw_world = false;

#endregion

#region //Global de habilidades

global.wall_jump = true; //Pulo na parede	
global.dash		 = true; //Dash

#endregion

#region	//Functions

function sai_colisao()
{
	//SE colidir com as plataformas A ou B
    if (
        place_meeting(x, y, obj_one_way_plataform_a) or
        place_meeting(x, y, obj_one_way_plataform_b)
    )
    {
		//Pega os alvos X e Y
        var target_x = x;
        var target_y = y;

		//Se o Velv ou Velh for diferente de zero, o alvo é - 4 pixels
        if (velh != 0) target_x -= sign(velh) * 4;
        if (velv != 0) target_y -= sign(velv) * 4;

		//SE ambos forem 0, o alvo é - 4
        if (velh == 0 && velv == 0)
        {
            target_y -= 4;
        }

		//Movimenta suavemente
        x = lerp(x, target_x, 1);
        y = lerp(y, target_y, 1);
		
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

function tremor(_forca = 1)
{
	if (instance_exists(obj_teste_room))
	{
		with (obj_teste_room)
		{
			if (_forca > treme)
			{
				treme = _forca;
			}
		}
	}
}


#endregion
