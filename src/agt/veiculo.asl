distancia("Rua1", 300).
distancia("Rua2", 240).
distancia("Rua3", 250).
distancia("Rua4", 210).
distancia("Rua5", 235).
distancia("Rua6", 300).
distancia("Rua7", 400).
distancia("Rua8", 325).
distancia("Rua9", 320).

vel_maxima("Rua1", 60).
vel_maxima("Rua2", 50).
vel_maxima("Rua3", 80).
vel_maxima("Rua4", 90).
vel_maxima("Rua5", 80).
vel_maxima("Rua6", 40).
vel_maxima("Rua7", 40).
vel_maxima("Rua8", 30).
vel_maxima("Rua9", 60).
!start.

+!start
  <-    createWorkspace(carro);
       	joinWorkspace(carro,Ofa);
        //makeArtifact("gui","artifacts.MySimpleGUI",[],D);
        makeArtifact("gps","artifacts.GPS",[false],GPS);
        
        //makeArtifact("antena","artifacts.MySimpleGUI",[],ANT);
        //makeArtifact("cambio","artifacts.MySimpleGUI",[],CAMBIO);
  		focus(GPS);
        !chegar_destino.

+!chegar_destino: not caminho(Caminho)
    <-  //Percorrer distância dentro da rua de destino até o ponto de chegada
        //focus(GPS);
        !requerer_caminho.
        //.wait(200);
        //?caminho(Lista);
        //caminho_atual(caminho);
        //!entrar_em_rua(Lista).

+!chegar_destino: chegou(true)  
    <-  //Percorrer distância dentro da rua de destino até o ponto de chegada
        .print("Chegou ao destino").

+!requerer_caminho: gps_preparado(Prep) & rua_atual(X) & destino(Y)
    <-  //.send(orquestrador, achieve, achar_caminho(X, Y)).
        
        .my_name(Eu);
        tracar_rota(X, Y, Eu).
        //+caminho(["Rua1", "Rua3", "Rua4"]).
        
+!requerer_caminho: not gps_preparado(true)
    <-  //.send(orquestrador, achieve, achar_caminho(X, Y)).
        .print("Esperando GPS inicializar");
        .wait(10);
        !requerer_caminho.
        //+caminho(["Rua1", "Rua3", "Rua4"]).

+rotaNova(Ruas, Veiculo): velocidade(Vel)
    <-  +caminho(Ruas);
        makeArtifact("ctrl_velocidade","artifacts.Ctrl_velocidade",[Vel, false],ACELFREIO);
        focus(ACELFREIO);
        !entrar_em_rua(Ruas).

+!achar_caminho(Caminho)[source(Orquestrador)]
    <- //consultar GPS para achar melhor caminho para o destino
        .split(StringStringSemBarra, ',', ListaFinal);

        +caminho(ListaFinal);
        .print("Passou aqui?");
        !entrar_em_rua(ListaFinal).

+!entrar_em_rua([R | Rs]): rua_atual(X) & destino(Y) & X \== Y & vel_maxima(X, VelMax) & distancia(X, Dist)
    <-  //.queue.remove(caminho, R);
        -rua_atual(X);
        +rua_atual(R);
        .print("Entrando em ", R);
        !moverse;
        .wait(Dist / (VelMax / 3.6));
        !frear;
        !entrar_em_rua(Rs).

+!entrar_em_rua([]): rua_atual(X) & destino(X)
    <- //.queue.remove(caminho, R);
        //-rua_atual(X);
        //+rua_atual(R);
        .print("Chegando no destino ", X);
        +chegou(true);
        !chegar_destino.

+!moverse: not ctrlvel_preparado(true)
    <-  .print("Aguardando controle de velocidade.");
        .wait(10);
        !moverse.

+!moverse: tem_obstaculo
    <- !frear;
        .drop_intention(acelerar).

+!moverse: rua_atual(X) & vel_maxima(X, VelMax) & distancia(X, Dist) & ctrlvel_preparado(Prep)
    <-  !!des_acelerar;
        !!verificar_obstaculo;
        .print("Movendo-se pela rua: ", X).
        //.wait(Dist / (VelMax / 3.6)).

+!des_acelerar: velocidade(Vel) & rua_atual(X) & vel_maxima(X, VelMax) & Vel <= VelMax
    <-  //focus(ACELFREIO);
        aum_vel.
        //.wait(100);
        //-velocidade(Vel);
        //+velocidade(Vel + 5);
        //.print("Acelerando. Velocidade nova: ", Vel);
        //!des_acelerar.

+velocidadeNova(Vel): vel_maxima(X, VelMax) & Vel <= VelMax
    <-  .print("Acelerando. Velocidade nova: ", Vel);
        .wait(100);
        aum_vel.

+velocidadeNova(Vel): vel_maxima(X, VelMax) & Vel >= VelMax
    <-  .print("Desacelerando. Velocidade nova: ", Vel);
        .wait(100);
        dim_vel.

+velocidadeNova(Vel): vel_maxima(X, VelMax) & Vel == VelMax
    <-  .print("Velocidade máxima da via atingida: ", Vel).

/*+!des_acelerar: velocidade(Vel) & rua_atual(X) & vel_maxima(X, VelMax) & Vel >= VelMax
    <-  //focus(ACELFREIO);
        dim_vel;
        //-velocidade(Vel);
        //+velocidade(Vel - 5);
        .print("Desacelerando. Velocidade nova: ", Vel);
        !des_acelerar.

+!des_acelerar: velocidade(Vel) & rua_atual(X) & vel_maxima(X, VelMax) & Vel == VelMax
    <-  
        .print("Velocidade máxima da via atingida: ", Vel).*/

+!frear 
    <-  //acionar_freios
        //focus(ACELFREIO);
        pisar_freio;
        .print("Freiando").


+!verificar_obstaculo 
    <- .print("").

