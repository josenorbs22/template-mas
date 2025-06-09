!start.

+!start: true
    <-  createWorkspace(trafego);
        joinWorkspace(trafego,Ofa).
        //makeArtifact("gps","artifacts.GPS",[false],GPS);
        //focus(GPS).

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
//+!join[source(Veiculo)]