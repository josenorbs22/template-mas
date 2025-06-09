
package artifacts;

import cartago.*;
import java.util.List;
import java.util.Arrays;
import jason.stdlib.string;

public class GPS extends Artifact {
	void init(boolean prep) {
		defineObsProperty("gps_preparado", prep);
		ObsProperty prop = getObsProperty("gps_preparado");
        prop.updateValue(true);
		System.out.println("GPS Inicializado");
	}

	@OPERATION
	void tracar_rota(String ruaAtual, String destino, String veiculo) {
		System.out.println("Traçando rota de " + ruaAtual + " até " + destino);

		//List<String> ruas = Arrays.asList("Rua1", "Rua3", "Rua4");
		String[] ruas = {"Rua1", "Rua3", "Rua4"} ;
		defineObsProperty("rota", ruas);
		signal("rotaNova", ruas, veiculo);
	}
	
}
