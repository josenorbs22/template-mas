package artifacts;
import javax.swing.*;
import java.awt.event.*;
import cartago.*;
import cartago.tools.*;

public class MySimpleGUI extends GUIArtifact {

	private MyFrame frame;
	
	public void setup() {
		frame = new MyFrame();
		
		linkActionEventToOp(frame.okButton,"ok");
		linkWindowClosingEventToOp(frame, "closed");
		
		defineObsProperty("temperaturaAtual",0);
		defineObsProperty("temperaturaDesejada",0);
		defineObsProperty("umidadeAtual",0);
		defineObsProperty("umidadeDesejada",0);
		frame.setVisible(true);		
	}

	@INTERNAL_OPERATION void ok(ActionEvent ev){
		getObsProperty("temperaturaAtual").updateValue(Integer.parseInt(frame.getTemperaturaA()));
		getObsProperty("temperaturaDesejada").updateValue(Integer.parseInt(frame.getTemperatura()));
		getObsProperty("umidadeAtual").updateValue(Integer.parseInt(frame.getUmidadeA()));
		getObsProperty("umidadeDesejada").updateValue(Integer.parseInt(frame.getUmidade()));
		signal("ok");
		
	}

	@INTERNAL_OPERATION void closed(WindowEvent ev){
		signal("closed");
	}
	
	@OPERATION void println(String value){
		System.out.println(value);;
	}

	class MyFrame extends JFrame {		
		
		private JButton okButton;
		private JTextField temperaturaA;
		private JTextField umidadeA;
		private JTextField temperatura;
		private JTextField umidade;
		
		public MyFrame(){
			setTitle("Simple GUI ");
			setSize(200,300);
			
			JPanel panel = new JPanel();
			JLabel tempA = new JLabel();
			tempA.setText("Temperatura Atual:");
			JLabel temp = new JLabel();
			temp.setText("Temperatura Desejada:");
			JLabel umiA = new JLabel();
			umiA.setText("Umidade Atual:");
			JLabel umi = new JLabel();
			umi.setText("Umiade Desejada");
			setContentPane(panel);
			
			okButton = new JButton("ok");
			okButton.setSize(80,50);
			
			temperaturaA = new JTextField(10);
			temperaturaA.setText("30");
			temperaturaA.setEditable(true);
			
			umidadeA = new JTextField(10);
			umidadeA.setText("40");
			umidadeA.setEditable(true);
			
			temperatura = new JTextField(10);
			temperatura.setText("20");
			temperatura.setEditable(true);
			
			umidade = new JTextField(10);
			umidade.setText("60");
			umidade.setEditable(true);
			
			panel.add(tempA);
			panel.add(temperaturaA);
			panel.add(umiA);
			panel.add(umidadeA);
			panel.add(temp);
			panel.add(temperatura);
			panel.add(umi);
			panel.add(umidade);
			panel.add(okButton);
			
		}
		
		public String getTemperaturaA(){
			return temperaturaA.getText();
		}
		
		public String getTemperatura(){
			return temperatura.getText();
		}
		
		public String getUmidadeA(){
			return umidadeA.getText();
		}
		
		public String getUmidade(){
			return umidade.getText();
		}
	}
}
