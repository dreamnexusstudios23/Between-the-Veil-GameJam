/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region	//Usa os métodos

//Verifica em qual mundo a serra está
if (global.world == saw_world)
{
    visible = true;

}
else
{
    visible = false;
}

//Método para movimentar a serra SE, ela se movimenta
if (saw_move) move_saw();

#endregion


