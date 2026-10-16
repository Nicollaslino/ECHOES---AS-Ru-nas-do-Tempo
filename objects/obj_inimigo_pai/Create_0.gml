//Iniciando as variáveis aos inimigos
xscale = 1;
//Iniciando estado padrão em todos os inimigos

estado_idle = new estado()
estado_walk = new estado()
estado_attack = new estado()
estado_hurt = new estado()
estado_death = new estado()

//Iniciando o estado idle por padrão
inicia_estado(estado_idle);