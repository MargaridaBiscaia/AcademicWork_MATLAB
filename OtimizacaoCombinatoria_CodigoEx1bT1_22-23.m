%Dados do problema
x = [];
y = [];
d=;

%Matriz X
n=length(x);
for i=1:n;
    for j=1:d+1;
        X(i,j)= x(i)^(j-1);
    end
    X(i,1)=1; %primeira coluna de X é toda igual a 1
end

%c da função objetivo [0 0 0 ... 1 1 1]
for j=1:(d+1);
    c(1,j)=0;
end
for j=(d+2):(d+1+n);
    c(1,j)=1;
end
c

I=eye(n);

%Matriz por blocos A
for i=1:n;
    for j=1:d+1;
        A(i,j)=X(i,j);
    end
    for j=(d+2):(d+1+n);
        A(i,j)=-I(i,j-d-1);
    end
end

for i=(n+1):2*n;
    for j=1:d+1;
        A(i,j)=-X(i-n,j);
    end
    for j=(d+2):(d+1+n);
        A(i,j)=-I(i-n,j-d-1);
    end
end

%Matriz por blocos Y
for i=1:n;
    Y(i,1)=y(i);
end
for i=(n+1):2*n;
    Y(i,1)=-y(i-n);
end

%Resolução do pl
w=linprog(c,A,Y)

%Vetor a
for i=1:d+1
    a(i,1)=w(i,1);
end
a

