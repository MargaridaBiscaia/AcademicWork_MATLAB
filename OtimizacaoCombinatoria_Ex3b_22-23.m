clc;clear;
%Dados do problema
n=10;
m=30;
p=randperm(n*n,m); %gerar os m pontos
%Matriz de adjacências por blocos
I=eye(n*n);
Adj=AdjGrid(n); %matriz de adjacências da grelha inicial 
A=zeros(2*n*n+2);
for i=1:(n*n)
    for j=(n*n+1):(2*n*n)
        A(i,j)=I(i,j-n*n);
    end
end

for i=(n*n+1):(2*n*n)
    for j=1:(n*n)
        A(i,j)=Adj(i-n*n,j);
    end
end

%linha da matriz A correspondente a s
for k=1:m 
    for j=1:(n*n)
        if j == p(k)
            A(2*n*n+1,j)=1;
        end
    end
end

%coluna da matriz A correspondente a t
fronteira=FronteiraGrid(n);
for i=(n*n+1):(2*n*n)
    for k=1:length(fronteira)
        if i==fronteira(k)+n*n
            A(i,2*n*n+2)=1;
        end
    end
end

C = A; %matriz dos custos
s=2*n*n+1; %vértice inicial
t=2*n*n+2; %vértice final

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
                if X(caminho(j),caminho(j-1))>0
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
    
    %Resultados
    disp('Para os m pontos seguintes');
    disp(sort(p));
    disp('o fluxo máximo é ');
    disp (f)
    if f==m
        disp('Resposta positiva!');
    else
        disp('Resposta negativa!');
    end