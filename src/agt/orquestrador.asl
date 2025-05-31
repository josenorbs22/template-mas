!start.

+!start
    <- createWorkspace(transito);
    makeArtifact("gps","artifacts.GPS",[],GPS).

+!achar_caminho[source(Veiculo)]
    <-  tracar_rota;
        .queue.create(caminho);
        .queue.add_all(caminho, [Rua1, Rua3, Rua4]);
        send(Veiculo, tell, achar_caminho(caminho)).

//+!join[source(Veiculo)]