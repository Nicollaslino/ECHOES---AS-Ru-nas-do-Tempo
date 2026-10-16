meu_dano = noone


//Iniciar estado idle
estado_idle = new estado();

//Iniciar estado walk
estado_walk = new estado();

//Iniciar estado walk
estado_walk = new estado();

//Iniciar estado attack
estado_attack = new estado();

#region estado_idle

estado_idle.inicia = function()
{
	
	var _sprite = define_sprite(dir, spr_player_idle_side, spr_player_idle_front, spr_player_idle_back);
	
	sprite_index = _sprite;
	
	//Animação começa do 1º frame
	image_index = 0;
}

estado_idle.roda = function()
{
	// Garante que o espelhamento do idle na ultima direção olhada
	if (dir == 2) {
		image_xscale = -1;
	} else {
		image_xscale = 1;
	}

	if (up xor down or left xor right)
	{
		troca_estado(estado_walk);
	}
	
	
    if (attack)
    {
        velh = 0; // Força a parada imediata
        velv = 0;
        troca_estado(estado_attack);
    }
}

#endregion

#region estado_walk
estado_walk.inicia = function()
{
    // Primeiro calcula as velocidades baseadas nas teclas
    velv = (down - up) * velocidade;
    velh = (right - left) * velocidade;

    // Depois calcula a direção correta
    if (velh != 0 || velv != 0) {
        dir = (point_direction(0, 0, velh, velv) div 90);
    }
  
    sprite_index = define_sprite(dir, spr_player_walk_side, spr_player_walk_front, spr_player_walk_back);
    image_index  = 0;
}

estado_walk.roda = function()
{
     //Atualiza as velocidades
     velv = (down - up) * velocidade;
     velh = (right - left) * velocidade;
     
     //Se o jogador está se movendo, atualiza a direção
     if (velh != 0 || velv != 0)
     {
          dir = (point_direction(0, 0, velh, velv) div 90); 
     }
     
     // Aplica o espelhamento correto baseado na direção (0 = Direita, 2 = Esquerda)
     if (dir == 2) 
     {
          image_xscale = -1; // Inverte para a esquerda
     } 
     else 
     {
          image_xscale = 1;  // Normal para Direita, Cima e Baixo
     }
     
     // Define o sprite
     sprite_index = define_sprite(dir, spr_player_walk_side, spr_player_walk_front, spr_player_walk_back);
	
     // Se parou de mover, volta para o IDLE
     if (velh == 0 && velv == 0)
     {
         troca_estado(estado_idle); 
     }
	 
	 //Indo para o estado de ataque
     if (attack)
    {
       velh = 0; // Evita que ele deslize um frame para frente
       velv = 0;
       troca_estado(estado_attack);
    }

}
 
#endregion

#region estado_attack
estado_attack.inicia = function()
{
   velh = 0;
   velv = 0;
   
   sprite_index = define_sprite(dir, spr_player_attack_side, spr_player_attack_front, spr_player_attack_back);
   image_index = 0;
   
   //Criando dano
   var _x = x + lengthdir_x(16, dir * 90);
   var _y = y + lengthdir_y(16, dir * 90);
   
   meu_dano = instance_create_depth(x, y, depth, obj_dano_player);
   
   
}

estado_attack.roda = function()
{
   // Garante o fim do ataque assim que passar do último frame
   if (image_index + image_speed >= image_number)
   {
	   troca_estado(estado_idle);   
   }
}
estado_attack.finaliza = function()
{
   //Encerro meu dano
   instance_destroy(meu_dano);
	
}

#endregion



//Iniciar variáveis
#region iniciando as variáveis

//Controles
up = noone;
down = noone;
left = noone;
right = noone;
attack = noone;

//Variáveis de movimento
//Começa parado
velh = 0;
velv = 0;

//Velocidade do jogador
velocidade = 3;

//Controlar a direção em que o jogador está olhando
dir = 0;

#endregion
//Inicia máquina de estado
inicia_estado(estado_idle);