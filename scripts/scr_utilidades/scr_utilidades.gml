// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//Global para debug
global.debug = false;

#region //Globais de itens

global.pitao = true;

global.world = false;

global.one_way_collision = false;

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

function flash_choice(_red = 0, _green = 0, _blue = 0)
{
	//Cor vermelha da piscada
	flash_r = _red;
	flash_g = _green;
	flash_b = _blue;
}	

#endregion