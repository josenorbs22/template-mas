package artifacts;

import cartago.*;

public class SyncManager extends Artifact {

    void init() {
        defineObsProperty("pronto", false);  // Inicialmente, os artefatos não estão prontos
    }

    @OPERATION
    void artefatoInicializado() {
        ObsProperty prop = getObsProperty("pronto");
        prop.updateValue(true);  // Atualiza a propriedade quando todos os artefatos estiverem prontos
        signal("artefatos_prontos");  // Envia um sinal para os agentes
    }
}