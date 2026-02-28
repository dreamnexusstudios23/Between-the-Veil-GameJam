/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Sistema
ps_ring = part_system_create();
part_system_depth(ps_ring, -15);

// Tipo da partícula
pt_ring = part_type_create();

// Forma pequena e brilhante
part_type_shape(pt_ring, pt_shape_pixel);

// Tamanho pequeno
part_type_size(pt_ring, 0.3, 0.6, 0, 0);

// Cor ciano vibrante
part_type_color1(pt_ring, make_color_rgb(0, 255, 255));

// Alpha nasce forte e morre rápido
part_type_alpha3(pt_ring, 0.6, 0.7, 0);

// Vida curta
part_type_life(pt_ring, 10, 20);

// Todas direções
part_type_direction(pt_ring, 0, 360, 0, 0);

// Mais rápidas que a fenda
part_type_speed(pt_ring, 1.5, 3, 0, 0);

// Sem gravidade
part_type_gravity(pt_ring, 0, 0);

// Densidade (quantas por emissão)
density = 3;


