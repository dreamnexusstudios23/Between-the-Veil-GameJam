// intensidade bem baixa
var _time = current_time * 0.001;

// Micro variação no scale
var _scale = 1 + sin(_time * 3) * 0.015;

// Micro variação na posição
var _xoff = sin(_time * 2.3) * 0.5;
var _yoff = cos(_time * 1.7) * 0.5;

// Micro variação na intensidade
var _alpha = 0.9 + sin(_time * 4.1) * 0.05;

gpu_set_blendmode(bm_add);

draw_sprite_ext(
    sprite_index,
    image_index,
    x + _xoff,
    y + _yoff,
    _scale,
    _scale,
    0,
    c_white,
    _alpha
);

gpu_set_blendmode(bm_normal);