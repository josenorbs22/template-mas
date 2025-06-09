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
    void aum_vel(){
        ObsProperty prop = getObsProperty("velocidade");
        prop.updateValue(prop.intValue() + 5);
        System.out.println("Aumentando a velocidade do carro");
        signal("velocidadeNova", prop.intValue());
    }

    @OPERATION
    void dim_vel(){
        ObsProperty prop = getObsProperty("velocidade");
        prop.updateValue(prop.intValue() - 5);
        System.out.println("Diminuindo a velocidade do carro");
        signal("velocidadeNova", prop.intValue());
    }

    @OPERATION
    void pisar_freio(){
        System.out.println("Parando");
        ObsProperty prop = getObsProperty("velocidade");
        while(prop.intValue() > 0){
            prop.updateValue(prop.intValue() - 20);
        }
        if(prop.intValue() < 0){
            prop.updateValue(0);
        }
    }
}
