%Dados do problema
x = [];
y = [] ;
d=;

%Matriz X
n=length(x);
for i=1:n;
    for j=1:d+1;
        X(i,j)= x(i)^(j-1);
    end
    X(i,1)=1; %primeira coluna de X é toda igual a 1
end

%Resolução
a = lsqminnorm(X,y)


