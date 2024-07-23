clc;clear;
%Dados do problema
A = []; %matriz de adjacências
C = []; %matriz dos custos
s= ; %vértice inicial
t= ; %vértice final

%Inicialização
X = zeros(length(A));
B = A;
terminado = false;

%% Algoritmo de Ford-Fulkerson
    while terminado ~= true
        v = BFS(B,s); %aplicar BFS a B e obter v
        
        if v(t) == 0 %se v(t) = 0
            terminado = true;
        else
            caminho = Path(s,t,v); %construir um caminho de s para t a partir de v
            
            %Procurar capacidade de incremento e determinar delta
            incremento = max(max(C));
            for j = 2:length(caminho)
                if C(caminho(j),caminho(j-1)) > X(caminho(j),caminho(j-1))
                    incremento = min(incremento,C(caminho(j),caminho(j-1))-X(caminho(j),caminho(j-1))); 
                else
                    incremento = min(incremento,C(caminho(j),caminho(j-1)));
                end
            end
            
            for j= 2:length(caminho) %adicionar delta em X a todas as entradas que correspondem a arestas do caminho
                X(caminho(j),caminho(j-1))= X(caminho(j),caminho(j-1)) + incremento; 
                X(caminho(j-1),caminho(j))= X(caminho(j-1),caminho(j)) - incremento;
            end
            
            %Alterar B
            for j = 2:length(caminho)
                if C(caminho(j),caminho(j-1)) > X(caminho(j),caminho(j-1)) 
                    B(caminho(j),caminho(j-1))=1;
                else 
                    B(caminho(j),caminho(j-1))=0;
                end
                if X(caminho(j),caminho(j-1)) > 0
                    B(caminho(j-1),caminho(j))=1;
                end
            end
        end
        
    end
    
    %Fluxo máximo
    f=0;
    for i = 1:length(X)
        f = f + X(i,t);
    end
    disp('O fluxo máximo é ');
    disp (f)
    
    
    
    