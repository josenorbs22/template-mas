
package artifacts;

import cartago.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import jason.stdlib.string;

public class GPS extends Artifact {
	private String[][] cruzamentos = {
		{"Rua2", "Rua1P1"},
		{"Rua1P1", "Rua3P1", "Rua1P2"}, 
		{"Rua1P2", "Rua4P1"},
		{"Rua3P1", "Rua3P2", "Rua5"},
		{"Rua4P1", "Rua5", "RuaP2"},
		{"Rua2", "Rua6P1"},
		{"Rua3P2", "Rua6P1", "Rua6P2"},
		{"Rua4P2", "Rua6P3", "Rua6P4"},
		{"Rua6P2", "Rua7", "Rua6P3"},
		{"Rua6P4", "Rua8"},
		{"Rua7", "Rua9"},
		{"Rua8", "Rua9"}
	};
	void init(boolean prep) {
		defineObsProperty("gps_preparado", prep);
		ObsProperty prop = getObsProperty("gps_preparado");
        prop.updateValue(true);
		System.out.println("GPS Inicializado");
	}

	@OPERATION
	void tracar_rota(String ruaAtual, String destino, String veiculo) {
		System.out.println("Traçando rota de " + ruaAtual + " até " + destino);
		String nome1 = "corolla";
		String nome2 = "porsche911";
		List<String> ruas = new ArrayList<>();
		if(veiculo.equals("corolla")){
			ruas.add(ruaAtual);
			ruas.add("Rua3P1");
			ruas.add("Rua3P2");
			ruas.add("Rua6P2");
			ruas.add("Rua7");
			
		} else if(veiculo.equals("porsche911")){
			ruas.add(ruaAtual);
			ruas.add("Rua5");
			ruas.add("Rua3P2");
			ruas.add("Rua6P1");
			ruas.add("Rua2");
			
		}
		defineObsProperty("rota", ruas);
		signal("rotaNova", ruas.toArray(), veiculo);
	}

	@OPERATION
	void achar_cruzamento(String entrada, String saida, String veiculo) {
		for(int i = 0; i < cruzamentos.length; i++){
			if(Arrays.asList(cruzamentos[i]).contains(entrada) && Arrays.asList(cruzamentos[i]).contains(saida)){
				signal("achou_cruzamento", i, veiculo);
				return;
			} 
			
		}
	}
}
