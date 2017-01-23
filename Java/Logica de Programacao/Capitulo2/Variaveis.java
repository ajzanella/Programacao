class Variaveis{
	public static void main(String[] args){

		int idadeDaAna = 20;
		char letra = 'A';
		char letra2 = 75; //letra K maiuscula
//		int populacao = 7_000_000_000; // o inteiro so aceita até 2 bilhões
		long populacao = 7_000_000_000L; //para inserir um numero maior que 2 bilhoes, precisa terminar com o L ou l no final
		long populacao2 = 7_000_000_000L; //para inserir um numero maior que 2 bilhoes, precisa terminar com o L ou l no final
		double altura = 1.85; //pode ser float ou double. O float armazena 32 bits e o double armazena 64 bits. Se tem ponto, ele deve ser double.
		float altura2 = 1.85f; //colocando o f depois do numero podemos usar o float em numeros quebrados.
		boolean habilitado = true;
		String nome = "Angelo Zanella";
		nome = "Angelo José Zanella";

		System.out.println("Idade: " + idadeDaAna);
		System.out.println(idadeDaAna);
		System.out.println("Idade");
		System.out.println(letra2);
		System.out.println(letra);
		System.out.println(populacao);
		System.out.println(7_000_000_000L); //
		System.out.println(populacao2); //
		System.out.println(altura);


	}

}