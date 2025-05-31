/* !entrar_em_rua.
!frear.
!desacelerar.
!acelerar.
!chegar_destino.
!verificar_obstaculo. */
//!entrar_em_rua.

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

distancia(Rua1, 300).
distancia(Rua2, 240).
distancia(Rua3, 250).
distancia(Rua4, 210).
distancia(Rua5, 235).
distancia(Rua6, 300).
distancia(Rua7, 400).
distancia(Rua8, 325).
distancia(Rua9, 320).

vel_maxima(Rua1, 60).
vel_maxima(Rua2, 50).
vel_maxima(Rua3, 80).
vel_maxima(Rua4, 90).
vel_maxima(Rua5, 80).
vel_maxima(Rua6, 40).
vel_maxima(Rua7, 40).
vel_maxima(Rua8, 30).
vel_maxima(Rua9, 60).
!start.

+!start
  <-    createWorkspace(carro);
       	joinWorkspace(carro,Ofa);
        makeArtifact("gui","artifacts.MySimpleGUI",[],D);
        makeArtifact("gps","artifacts.GPS",[],GPS);
        makeArtifact("ctrl_velocidade","artifacts.Ctrl_velocidade",[],ACELFREIO);
        //makeArtifact("antena","artifacts.MySimpleGUI",[],ANT);
        //makeArtifact("cambio","artifacts.MySimpleGUI",[],CAMBIO);
  		focus(D);
  		println("Hello").

+!chegar_destino: ~chegou    
    <-  //Percorrer distância dentro da rua de destino até o ponto de chegada
        !achar_caminho;
        !entrar_em_rua.

+!chegar_destino: chegou    
    <-  //Percorrer distância dentro da rua de destino até o ponto de chegada
        .print("Chegou ao destino").

+!achar_caminho
    <-  .send(orquestrador, achieve)

+!achar_caminho(caminho)[source(Orquestrador)]
    <- //consultar GPS para achar melhor caminho para o destino
        caminho_atual(caminho).

+!entrar_em_rua: rua_atual(X) & destino(Y) & X \== Y
    <-  .queue.remove(caminho, R);
        -rua_atual(X);
        +rua_atual(R);
        .print("Andando por ", R);
        !moverse.

+!entrar_em_rua: rua_atual(X) & destino(X)
    <- .queue.remove(caminho, R);
        -rua_atual(X);
        +rua_atual(R);
        .print("Chegando no destino ", R);
        chegou;
        !chegar_destino.

+!moverse: tem_obstaculo
    <- !frear;
        .drop_intention(acelerar).

+!moverse: rua_atual(X)
    <- !!acelerar;
        !!verificar_obstaculo;
        .print("Movendo-se pela rua: ", X).

+!acelerar: velocidade(Vel) & rua_atual(X) & vel_maxima(X, VelMax) & Vel <= VelMax
    <-  aum_vel;
        -velocidade(Vel);
        +velocidade(Vel + 5);
        .print("Acelerando. Velocidade nova: ", Vel).

+!desacelerar: velocidade(Vel) & rua_atual(X) & vel_maxima(X, VelMax) & Vel >= VelMax
    <-  dim_vel;
        -velocidade(Vel);
        +velocidade(Vel - 5);
        .print("Desacelerando. Velocidade nova: ", Vel).

+!frear 
    <-  //acionar_freios
        pisar_freio;
        .print("Freiando").


+!verificar_obstaculo 
    <- .print("").

