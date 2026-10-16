//Timer para mudar de estado
tempo_estado = game_get_speed(gamespeed_fps) * 15;
timer_estado = tempo_estado;

destino_x = 0;
destino_y = 0;
alvo = noone;

// Inherit the parent event
event_inherited();

estado_hunt = new estado();

#region estado.idle
estado_idle.inicia = function()
{
	//definir a sprite que será usada
	sprite_index = spr_javali_idle_left
	//inciar a animação do início;
	image_index = 0;
	
	timer_estado = tempo_estado;
	
	image_blend = c_white;
}

estado_idle.roda = function()
{
    //Diminuindo o timer do estado
    timer_estado--;
    
	var _tempo = irandom(timer_estado);
	
    if(_tempo <= tempo_estado *.01)
	{
		var _estado_novo = choose(estado_idle, estado_walk, estado_walk);
		troca_estado(_estado_novo);
	}
}

#endregion


#region estado_walk

estado_walk.inicia = function()
{
  sprite_index = spr_javali_walk_left;
  image_index = 0;
  
  //Resetando o timer do estado
  timer_estado = tempo_estado;
  
  //Escolhendo um local no mapa indo ate o personagem
  
  //Escolhendo de forma aleatória um local do mapa
  destino_x = irandom(room_width);
  destino_y = irandom(room_height);
  
  //Definindo o xscale no destino x
  xscale = sign(destino_x - x);
}

estado_walk.roda = function()
{
	//Diminuindo o timer do estado
    timer_estado--;
	
	var _tempo = irandom(timer_estado);
 
    if(_tempo <= 5)
	{
		var _estado_novo = choose(estado_idle, estado_walk);
		
		troca_estado(_estado_novo);
	}
	
	
	
	//Indo até o destino do personagem, desviando de colisores
	mp_potential_step_object(destino_x, destino_y, 1, obj_colisor);
	
}
#endregion

#region estado_attack 
estado_attack.inicia = function()
{
sprite_index = spr_javali_attack_left;
image_index = 0;
}	
estado_attack.roda = function()
{
	
	//Saindo do estado de ataque
	if(image_index >= image_number - .5)
	{
		troca_estado(estado_idle);
	}
	
	
}
estado_attack.finaliza = function()
{ 
	alvo = noone;
}

#endregion

#region estado_hurt
estado_hurt.inicia = function()
{
	sprite_index = spr_javali_idle_down
	image_index = 0;
	
	//Perde a vida
	vida--;
}

estado_hurt.roda = function()
{
	 //Sair do estado de dano
	 if (image_index >= image_index -.5)
	 {
		 
	   if (vida > 0)
	    {
		  troca_estado(estado_hunt);
		}
		else // VIDA = 0, o inimigo morre
		{
		  troca_estado(estado_death);	
		}
	 } 
 }

#endregion

#region estado_death

estado_death.inicia = function()
{
 sprite_index = spr_javali_death_left;
 image_index = 0;
}

estado_death.roda = function()
{
	if(image_index >= image_number - .5)
	{
		instance_destroy();
	}
}

#endregion

#region estado_hunt
estado_hunt.inicia = function()
{
  sprite_index = spr_javali_walk_down;
  image_index = 0;
  
  image_blend = c_yellow
  
  if(instance_exists(obj_player))
   {
	  alvo = obj_player.id;
   }
   
}

estado_hunt.roda = function()
{   
	//Se o alvo não existir, o inimigo para
	if (!instance_exists(obj_player))
	{
	    alvo = noone;
		troca_estado(estado_idle);
		
	}
	//Definindo o meu alvo como o player
	//Seguindo o alvo
	mp_potential_step_object(alvo.x, alvo.y, 1, obj_colisor);
	
	//Atacando o player
	//Checando a distância para o player
	var _dist = point_distance(x, y, alvo.x, alvo.y);
	
	if( _dist <= 10)
	{
		troca_estado(estado_attack);
	}
	
	xscale = sign(alvo.x - x);
	//Avisando aos outros javalis que o atacado precisa de ajuda
	//Checando quantos existem
	var _n = instance_number(object_index);
	// Procurar um loop de javalis
	for (var i = 0; i < _n; i++)
	{
		var _javali = instance_find(object_index, i);
		if(_javali == id)
		{
			//Não faz nada
		}
		else
		{
			if(_javali.alvo != alvo)
			{
				//Checar a distância do javali
				var _dist = point_distance(x, y, _javali.x, _javali.y);
				if (_dist < 80)
				{
				   //Ajuda
				   with(_javali)
                   {
					 troca_estado(estado_hunt);
				   }
				}
		    }  
		}
	}
}

#endregion






//Iniciando estado com as modificações
inicia_estado(estado_idle);