/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region /// ===== CONFIGURAÇÃO DA NÉVOA =====
/// CREATE EVENT

// Sistema
ps_fog = part_system_create();
part_system_depth(ps_fog, -10);

// Tipo
pt_fog = part_type_create();

// Forma mais suave
part_type_shape(pt_fog, pt_shape_cloud);

// Tamanho grande e parecido
part_type_size(pt_fog, 0.2, 0.4, 0, 0);

// Cor cinza claro
part_type_color1(pt_fog, make_color_rgb(180,180,180));

// Transparência suave
part_type_alpha3(pt_fog, 0, 0.05, 0);

// Vida longa
part_type_life(pt_fog, 30, 50);

// Movimento só para esquerda
part_type_direction(pt_fog, 180, 180, 0, 0);

// Velocidade bem baixa
part_type_speed(pt_fog, 0.01, 0.02, 0, 0);

// Sem gravidade
part_type_gravity(pt_fog, 0, 0);

// Área horizontal da névoa
fog_width = 300;

// Controle de densidade
density = 6;

#endregion

