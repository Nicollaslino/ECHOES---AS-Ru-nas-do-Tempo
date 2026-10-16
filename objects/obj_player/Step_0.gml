// Procura se o obj_fim existe na fase
if (instance_exists(obj_fim)) {
    // Calcula a distância entre o jogador e o obj_fim
    var distancia = distance_to_object(obj_fim);
    
    // Se o jogador chegar a menos de 10 pixels de distância, muda de fase!
    if (distancia < 10) {
        room_goto(Cena2);
    }
}


//Ajustar profundidade
depth = -y;


//Inputs


up     = keyboard_check(vk_up) or keyboard_check(ord("W"));
down   = keyboard_check(vk_down) or keyboard_check(ord("S"));
right  = keyboard_check(vk_right)  or keyboard_check(ord("D"));
left   = keyboard_check(vk_left) or  keyboard_check(ord("A"));
attack = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("J"));

//Rodar maquina de estados
roda_estado()