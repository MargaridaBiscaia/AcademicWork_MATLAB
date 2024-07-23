%Dados do problema tarefa 2
x = [-3.0000;
-2.8776;
-2.7551;
];
y=[-23.9998;
-17.2839;
6.5866;
];

d=9;

%Matriz X
n=length(x);

for i=1:n;
    for j=1:d+1;
        X(i,j)= x(i)^(j-1);
    end
    X(i,1)=1; %primeira coluna de X é toda igual a 1
end
a = lsqminnorm(X,y) 
X*a
 
plot(x,y,"blue")
hold on
plot(x,X*a,"red")



