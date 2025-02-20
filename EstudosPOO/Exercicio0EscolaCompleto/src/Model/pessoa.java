package Model;

public abstract class pessoa {
    //Atributos privados (encapsulamento)
    private String nome;
    private String cpf;
    //Métodos
    //Construtor
    public pessoa(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }
    //Getters and setters
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getCpf() {
        return cpf;
    }
    public void setCpf(String cpf) {
        this.cpf = cpf;
    }
    //Métodos exibir informações
    public void exibirInformacoes() {
        System.out.println("None: " + nome);
        System.out.println("None: " + cpf);
    }
}