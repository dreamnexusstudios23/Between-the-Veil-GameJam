/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region //Faz girar igual moeda

//Aumenta o valor do giro
var _giro = 5 * (get_timer() / 1000000); //5x a velocidade do giro do get timer que é 1 segundo.

image_xscale = sin(_giro);

#endregion

#region //Usa os métodos

//Usa o método de quando o player pega o power
take();

#endregion