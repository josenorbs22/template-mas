
package artifacts;

import cartago.*;
import jason.stdlib.string;

public class GPS extends Artifact {
	void init(char ruaAtual) {
		System.out.println("GPS Inicializado");
	}

	@OPERATION
	void tracar_rota() {
		System.out.println("Rota traçada.");
	}
	
	@OPERATION
	void aquecer() {
		ObsProperty prop = getObsProperty("temperatura");
		prop.updateValue(prop.intValue()+1);
	}
}
