package Model;

public class aluno extends pessoa{
    //Atributos
    private String matricula;
    private String nota;
    //Construtor
    public aluno(String nome, String cpf, String matricula, String nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }
    //Gatters and setters
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    public void setNota(String nota) {
        this.nota = nota;
    }
    //Exibir informações - SobreEscrita
    @Override
    public void exibirInformacoes(){
        super.exibirInformacoes();
        System.out.println("matricula:" +matricula);
        System.out.println("Nota:" +nota);
    }
}
