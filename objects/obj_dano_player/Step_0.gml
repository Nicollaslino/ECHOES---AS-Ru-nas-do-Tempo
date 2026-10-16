var _lista = ds_list_create()

var _qtd = instance_place_list(x, y, obj_inimigo_pai, _lista, false);

//Pegar os inimigos da lista e passa-los para a lista de inimigos
for (var i = 0; i < ds_list_size(_lista); i++)
{
  //Pegando o inimigo atual da lista
  var _atual = _lista[| i];
  
  //Checando se o inimigo atual não existe na lista de inimigos
  var _existe = array_contains(lista_inimigos, _atual);
  
  if(!_existe)
  {
     array_push(lista_inimigos, _atual);
	 // Será dado o dano
	 with(_atual)
	 {
		troca_estado(estado_hurt);
	 }
   }
}

//Depois que usei a lsita, eu zero ela
ds_list_destroy(_lista);