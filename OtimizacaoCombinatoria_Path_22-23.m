%Dados s e t, a função Path cria um caminho entre s e t através de v
%calculado com a função BFS
function caminho=Path(s,t,v)

%Input: v obtido através de BFS
%       s - vértice inicial
%       t - vértice final

%Inicialização
caminho(1)= t;
j=2;

% t ← v(t) ← v(v(t)) ← v(v(v(t)))... ← v(v(..(v(t)))) = s.
while caminho(j-1)~= s
    caminho(j) = v(caminho(j-1));
    j=j+1;
end