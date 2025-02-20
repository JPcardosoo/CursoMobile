package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.aluno;
import Model.professor;

public class cursos {
    //Atributos
    private String nomeCurso;
    private professor professor;
    private List<aluno> alunos;
    //Construtor
    public cursos(String nomeCurso, Model.professor professor, List<aluno> alunos) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunos = new ArrayList<>();
    }
    //adicionarAluno
    public void adicionarAluno(aluno aluno){
        alunos.add(aluno);
    }
    //Exibir informações do curso
    public void exibirInformacoesCurso(){
        System.out.println("Nome do Curso" +nomeCurso);
        System.out.println("=============");
        System.out.println("Nome professor" +professor.getNome);
        System.out.println("=============");
        System.out.println("Lista de Alunos");
        int i = 1;
        
    }
}
