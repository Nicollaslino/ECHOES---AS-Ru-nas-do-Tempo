//Ajustar profundidade
depth = -bbox_bottom;
if(transparente)
{



 //Ficar transparente quando o jogador ficar atras do objeto
  if (instance_exists(obj_player))
   {
	if (obj_player.y < y)
	 {
	     //Observar se o jogador está atras do objeto
	     if (point_in_rectangle(obj_player.x, obj_player.y, bbox_left - 10, bbox_top - 25, bbox_right + 10, bbox_top))
	     {
		    //Ficando transparente
		    image_alpha = lerp(image_alpha, .5 , .02);
	     }
		 else
		 {
			image_alpha = lerp(image_alpha, 1 , .1);
		 }
	 }	
   }
}