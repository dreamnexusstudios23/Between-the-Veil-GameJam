/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Cria sistema
ps_spark = part_system_create();
part_system_depth(ps_spark, -20);

// Cria tipo
pt_spark = part_type_create();

// Forma pequena
part_type_shape(pt_spark, pt_shape_pixel);

// Tamanho bem pequeno
part_type_size(pt_spark, 1, 3, 0, 0);

// Cor ciano / aqua
part_type_color1(pt_spark, make_color_rgb(0, 255, 255));

// Transparência (nasce forte e morre rápido)
part_type_alpha3(pt_spark, 1, 0.8, 0);

// Vida bem curta
part_type_life(pt_spark, 60, 80);

// Espalha em todas direções
part_type_direction(pt_spark, 0, 360, 0, 0);

// Velocidade baixa (não vai longe)
part_type_speed(pt_spark, 0.5, 1.2, 0, 0);

// Sem gravidade
part_type_gravity(pt_spark, 0, 0);

// Controle de tempo
spark_timer = 0;
spark_interval = room_speed * 1.5; // 1.5 segundos


