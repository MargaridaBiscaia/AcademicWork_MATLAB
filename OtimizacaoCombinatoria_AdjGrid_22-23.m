%Dado n a função AdjGrid devolve a matriz de adjência da grelha nxn
function adj=AdjGrid(n)
%Matriz com os vértices numerados de 1 a n^2
vertices=zeros(n);
for j=1:n
    vertices(1,j)=j;
    for i=2:n
        vertices(i,j)=vertices(i-1,j)+n;
    end
end

%Matriz de adjacência
diagVec1 = repmat([ones(n-1, 1); 0], n, 1);  % Primeiro vetor diagonal (para as arestas horizontais)                                          
diagVec1 = diagVec1(1:end-1);                % Remover o último elemento
diagVec2 = ones(n*(n-1), 1);                 % Segundo vetor diagonal (para as arestas verticais)   
adj = diag(diagVec1, 1)+diag(diagVec2, n);   % Diagonal = zeros
adj = adj+adj.';                             % Somar à matriz obtida a sua transposta para que seja simétrica
end