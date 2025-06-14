package artifacts;

import cartago.*;
import jason.stdlib.string;

public class Ctrl_velocidade extends Artifact {
    //int velocidade = 0;
    void init(int velAtual, boolean prep){
        defineObsProperty("velocidade", velAtual);
        defineObsProperty("ctrlvel_preparado", prep);
		ObsProperty prop = getObsProperty("ctrlvel_preparado");
        prop.updateValue(true);
        //this.velocidade = velAtual;
    }

    @OPERATION
    void aum_dim_vel(int velMax){
        ObsProperty prop = getObsProperty("velocidade");
        if(prop.intValue() < velMax){
            prop.updateValue(prop.intValue() + 5);
            System.out.println("Aumentando a velocidade do carro");
        } else if(prop.intValue() > velMax){
            prop.updateValue(prop.intValue() - 5);
            System.out.println("Diminuindo a velocidade do carro");
        } else {
            System.out.println("Velocidade máxima atingida");
        }
        System.out.println("Velocidade Nova: " + prop.intValue());
        //signal("velocidadeNova", prop.intValue());
    }

    @OPERATION
    void pisar_freio(){
        ObsProperty prop = getObsProperty("velocidade");
        while(prop.intValue() > 0){
            prop.updateValue(prop.intValue() - 20);
        }
        if(prop.intValue() < 0){
            prop.updateValue(0);
        }
    }
}
