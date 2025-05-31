package artifacts;

import cartago.*;
import jason.stdlib.string;

public class Ctrl_velocidade extends Artifact {
    int velocidade = 0;
    void init(int velAtual){
        this.velocidade = velAtual;
    }

    void aum_vel(){
        velocidade += 5;
        System.out.println("Aumentando a velocidade do carro");
    }

    void dim_vel(){
        velocidade -= 5;
        System.out.println("Diminuindo a velocidade do carro");
    }

    void pisar_freio(){
        System.out.println("Parando");
        while(velocidade > 0){
            velocidade -= 20;
        }
        if(velocidade < 0){
            velocidade = 0;
        }
    }
}
