% Dado n a função FronteiraGrid devolve um vetor com os pontos da fronteira
%da frelha nxn
%-> os pontos da fronteira serão a primeira e última linhas, e primeira e
%última colunas da matriz com os vértices numerados de 1 a n^2
function fronteira=FronteiraGrid(n)
%Matriz com os vértices numerados de 1 a n^2
vertices=zeros(n);
for j=1:n
    vertices(1,j)=j;
    for i=2:n
        vertices(i,j)=vertices(i-1,j)+n;
    end
end

k=1;
for j=1:n
    fronteira(k)=j; %primeira linha
    k=k+1;
end
for i=2:n
    fronteira(k)=vertices(i,1); %primeira coluna
    k=k+1;
end
for i=2:n
    fronteira(k)=vertices(i,n); %última coluna
    k=k+1;
end
for j=2:(n-1)
    fronteira(k)=vertices(n,j); %última linha
    k=k+1;
end
end 