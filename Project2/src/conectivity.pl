:- use_module(library(clpfd)).

if_then_else(If, Then,_) :- If,!, Then.
if_then_else(_, _, Else) :- Else.

matrixToListOfLists(Board,List) :-
  append(Board,List).

getPosition(Dim,Row,Col,Position) :-
  Position is (Row-1)*Dim+Col.

checkConectivity(_,_,7,_).
checkConectivity(Board,Row,Col,Dim) :-
  matrixToListOfLists(Board,List),
  getPosition(Dim,Row,Col,Position),
  C is Col+1,
  C2 is Col-1,
  getPosition(Dim,Row,C,Position2),
  getPosition(Dim,Row,C2,Position3),
  P is Position+1,
  P2 is Position-1,
  P3 is Position+Dim,
  P4 is Position mod Dim,
  Dim2 is Dim*Dim,
  element(Position, List, Value),
  element(P, List, ValuePosition),
  element(P2,List,ValuePosition2),
  element(P3,List,ValuePosition3),
  element(Position3,List,ValuePosition4),
  element(Position2,List,ValuePosition3),
  ((Position #= 1 #/\ (Value #=1 #/\ (ValuePosition #= 1 #\/ ValuePosition3#=1))) #\/
  (Position #= Dim2 #/\ Value#=1) #\/
  (1#=P4  #/\ (ValuePosition #= 1  #\/ ValuePosition4 #= 1 #\/ ValuePosition3#=1)) #\/
  (0#=P4  #/\ (ValuePosition2 #= 1 #\/ ValuePosition4#=1 #\/ValuePosition3#=1)) #\/
  ((0#\=P4 #/\ 1#\=P4), (ValuePosition=1 #\/ ValuePosition2#=1 #\/ ValuePosition3#=1 #\/ ValuePosition4#=1))),
  Col2 is Col+1,
  Row2 is Row+1,
  if_then_else(Row=Dim,checkConectivity(Board,1,Col2,Dim),checkConectivity(Board,Row2,Col,Dim)).
