/* !entrar_em_rua.
!frear.
!desacelerar.
!acelerar.
!chegar_destino.
!verificar_obstaculo. */
!entrar_em_rua.

/* .map.create(Rua1)
.map.put(Rua1, dist, 300)
.map.put(Rua1, vel_max, 60)
.map.create(Rua2)
.map.put(Rua2, dist, 240)
.map.put(Rua2, vel_max, 50)
.map.create(Rua3)
.map.put(Rua3, dist, 250)
.map.put(Rua3, vel_max, 80)
.map.create(Rua4)
.map.put(Rua4, dist, 210)
.map.put(Rua4, vel_max, 90)
.map.create(Rua5)
.map.put(Rua5, dist, 235)
.map.put(Rua5, vel_max, 80)
.map.create(Rua6)
.map.put(Rua6, dist, 300)
.map.put(Rua6, vel_max, 40)
.map.create(Rua7)
.map.put(Rua7, dist, 400)
.map.put(Rua7, vel_max, 40)
.map.create(Rua8)
.map.put(Rua8, dist, 325)
.map.put(Rua8, vel_max, 30)
.map.create(Rua9)
.map.put(Rua9, dist, 320)
.map.put(Rua9, vel_max, 60)

.set.create(Ruas)
.set.add(Ruas, Rua1)
.set.add(Ruas, Rua2)
.set.add(Ruas, Rua3)
.set.add(Ruas, Rua4)
.set.add(Ruas, Rua5)
.set.add(Ruas, Rua6)
.set.add(Ruas, Rua7)
.set.add(Ruas, Rua8)
.set.add(Ruas, Rua9) */

distancia(rua1, 300).
distancia(rua2, 240).
distancia(rua3, 250).
distancia(rua4, 210).
distancia(rua5, 235).
distancia(rua6, 300).
distancia(rua7, 400).
distancia(rua8, 325).
distancia(rua9, 320).

vel_maxima(rua1, 60).
vel_maxima(rua2, 50).
vel_maxima(rua3, 80).
vel_maxima(rua4, 90).
vel_maxima(rua5, 80).
vel_maxima(rua6, 40).
vel_maxima(rua7, 40).
vel_maxima(rua8, 30).
vel_maxima(rua9, 60).

+!chegar_destino    
    <-  //Percorrer distância dentro da rua de destino até o ponto de chegada
        .print("Chegou ao destino").

+!achar_caminho 
    <- //consultar GPS para achar melhor caminho para o destino
        .queue.create(caminho);
        .queue.add_all(caminho, [rua1, rua3, rua4]);
        rua_atual(rua1).

+!entrar_em_rua: rua_atual(x) & destino(y) & x \== y
    <-  .queue.remove(caminho, r);
        -rua_atual(x);
        +rua_atual(r);
        .print("Andando por ", r);
        !moverse.

+!entrar_em_rua: rua_atual(x) & destino(x)
    <- .queue.remove(caminho, r);
        -rua_atual(x);
        +rua_atual(r);
        .print("Chegando no destino ", r);
        !chegar_destino.

+!moverse: tem_obstaculo
    <- !frear;
        .drop_intention(acelerar).

+!moverse: rua_atual(x)
    <- !!acelerar;
        !!verificar_obstaculo;
        .print("Movendo-se pela rua: ", x).

+!acelerar: velocidade(Vel) & rua_atual(x) & vel_maxima(x, VelMax) & Vel <= VelMax
    <- -velocidade(Vel);
        +velocidade(Vel + 5);
        .print("Acelerando. Velocidade nova: ", Vel).

+!desacelerar: velocidade(Vel) & rua_atual(x) & vel_maxima(x, velMax) & Vel >= VelMax
    <- -velocidade(Vel);
        +velocidade(Vel - 5);
        .print("Desacelerando. Velocidade nova: ", Vel).

+!frear 
    <-  //acionar_freios
        .print("Freiando").


+!verificar_obstaculo 
    <- .print("").

