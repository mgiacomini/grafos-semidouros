    Para esse trabalho, foi criado um algoritmo que conta quantos caminhos diferentes existem a partir de qualquer nodo nao sumidouro ate um nodo sumidouro (que possui um atributo associado a si)
em um grafo G representado em um arquivo .dot,Por exemplo. A arvore A possui dois nodos sumidouros com atributo FIM. Queremos contar quantos caminhos diferentes existem de A ate algum nodo com
atributo FIM. No caso, A possui FIM=2.

Estrategia:
    Para contar o numero de caminhos diferentes, utilizamos a seguinte estrategia (explicacao do algoritmo).

    1. Iniciamos uma pilha (para busca em profundidade) contendo apenas a raiz;
    2. Enquanto houverem elementos na pilha, desempilhamos o primeiro elemento,
        3. Para o elemento desempilhado (o chamaremos de Pai), fazemos um loop analizando todos os seus filhos,
            (No loop)
            4. Se o filho atual tem atributos, adicionamos todos os seus atributos ao pai;
            5. Se o filho atual nao tem atributos,
                6. se o pai ainda nao foi enfileirado, enfileiramos o pai;
                7. se o pai tem atributos, limpamos seus atributos;
                8. enfileiramos o filho;

    Ao fim do algoritmo, todos os nos terao um atributo para cada caminho que leva ate esse atributo

Entrada e Saida:
    Para a entrada do arquivo .dot, fizemos nosso proprio parser que gera as listas graph e attrs.
        A lista graphs e um dicionario, onde o nome do nodo e uma chave, e seus vertices, valores.
        A lista attrs tambem e um dicionario, onde o nome do nodo tambem e chave, e seus atributos sao o valor.

    Para a saida do arquivo tambem criamos um parse que escreve todos os caminhos antes da representacao do grafo
    no arquivo dot correspondente (Conforme expecificacao do trabalho).


Execucao:
    Para executar o algoritmo, utilizar o comando: ./conta-caminhos grafo.dot (troque grafo.dot pelo caminho do seu arquivo .dot)
