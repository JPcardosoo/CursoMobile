package Model;

public class professor extends pessoa {
    //Atributos
    private String salario;
    //Construtor
    public professor(final String salario) {
        this.salario = salario;
    }
    //Getters and setters
    public String getSalario() {
        return salario;
    }
    public void setSalario(final String salario) {
        this.salario = salario;
    }
    //SobreEscita exibirInformações
    
}
