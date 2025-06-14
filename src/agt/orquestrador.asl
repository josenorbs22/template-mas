/*cruzamento("Rua1P1", "Rua2", "", "", 0).
cruzamento("Rua1P1", "Rua3", "Rua1P2", "", 1).
cruzamento("Rua1P2", "Rua4P1", "", "", 2).
cruzamento("Rua3P1", "Rua5", "Rua3P2", "", 3).
cruzamento("Rua5", "Rua4P1", "Rua4P2", "", 4).
cruzamento("Rua2", "Rua6P1", "", "", 5).
cruzamento("Rua3P2", "Rua6P1", "Rua6P2", "",6).
cruzamento("Rua4P2", "Rua6P3", "Rua6P4", "", 7).
cruzamento("Rua6P2", "Rua7", "Rua6P3", "", 8).
cruzamento("Rua6P4", "Rua8", "", "", 9).
cruzamento("Rua7", "Rua9", "", "", 10).
cruzamento("Rua8", "Rua9", "", "", 11).*/

cruzamento(0, []).
cruzamento(1, []).
cruzamento(2, []).
cruzamento(3, []).
cruzamento(4, []).
cruzamento(5, []).
cruzamento(6, []).
cruzamento(7, []).
cruzamento(8, []).
cruzamento(9, []).
cruzamento(10, []).
cruzamento(11, []).

!start.

+!start: true
    <-  createWorkspace(trafego);
        createWorkspace(carro);
        joinWorkspace(trafego,Ofa);
        makeArtifact("gps","artifacts.GPS",[false],GPS);
        focus(GPS).

+!achar_caminho(RuaAtual, Destino)[source(Veiculo)]: not preparado(Prep)
    <-  .print("Esperando GPS inicializar");
        .wait(10);
        !achar_caminho(RuaAtual, Destino, Veiculo).

+!achar_caminho(RuaAtual, Destino, Veiculo): not preparado(Prep)
    <-  .print("Esperando GPS inicializar");
        .print(Prep);
        .wait(10);
        !achar_caminho(RuaAtual, Destino, Veiculo).

+!achar_caminho(RuaAtual, Destino, Veiculo): preparado(Prep) & Prep == true
    <-  tracar_rota(RuaAtual, Destino, Veiculo).
        //.wait(100);
        //?rota(Caminho);
        //.print(Caminho);
        //send(Veiculo, tell, achar_caminho(Caminho)).

+!achar_caminho(RuaAtual, Destino)[source(Veiculo)]: preparado(Prep) & Prep == true
    <-  tracar_rota(RuaAtual, Destino, Veiculo).
        //.wait(100);
        //?rota(Caminho);
        //.print(Caminho);
        //send(Veiculo, tell, achar_caminho(Caminho)).

+rotaNova(Ruas, Veiculo)
    <-  send(Veiculo, achieve, achar_caminho(Ruas)).

+!add_veiculo_cruzamento(Entrada, Saida)[source(Veiculo)]
    <-  achar_cruzamento(Entrada, Saida, Veiculo).

+achou_cruzamento(I, Veiculo): cruzamento(I, Lista) & Lista == []
    <-  ListaNova = [Veiculo];
        -cruzamento(I, Lista);
        +cruzamento(I, ListaNova);
        !liberar_cruzamento(I).

+achou_cruzamento(I, Veiculo): cruzamento(I, Lista)
    <-  !append(Lista, Veiculo, ListaNova);
        -cruzamento(I, Lista);
        +cruzamento(I, ListaNova);
        !liberar_cruzamento(I).

+!liberar_cruzamento(I): cruzamento(I, [Carro | Lista]) & Lista == []
    <-  .send(Carro, achieve, entrar_em_rua);
        .print("Liberando ", Carro, " no cruzamento ", I);
        -cruzamento(I, _);
        +cruzamento(I, Lista);
        .print(Lista);
        .wait(3000).

+!liberar_cruzamento(I): cruzamento(I, [Carro | Lista])
    <-  .send(Carro, achieve, entrar_em_rua);
        .print("Liberando ", Carro, " no cruzamento ", I);
        -cruzamento(I, _);
        +cruzamento(I, Lista);
        .print(Lista);
        .wait(3000);
        !liberar_cruzamento(I).

//+!join[source(Veiculo)]

+!append([], L, L) <- .print("").
+!append([H | T], L, [H | R]) <- 
    !append(T, L, R).