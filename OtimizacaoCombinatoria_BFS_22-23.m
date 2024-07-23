function v=BFS(A,s)

%Input: A - matriz de adjacência de um grafo
%       s - vértice inicial

%Inicialização:
n=size(A,1);
l=[s];
v=zeros(n,1);
v(s)=-1;

while not(isempty(l))
   i=l(1);
   for j=1:n
       if A(i,j)==1&&v(j)==0
           v(j)=i;
           l=[l,j];
       end  
   end
   l=l(2:end);
end

