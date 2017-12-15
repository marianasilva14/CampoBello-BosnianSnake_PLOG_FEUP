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
  if_then_else(Col=Dim,ValuePosition is 0,element(P,List,ValuePosition)),
  if_then_else(Col=1,ValuePosition2 is 0,element(P2,List,ValuePosition2)),
  if_then_else(Row=1,ValuePosition4 is 0, element(Position3,List,ValuePosition4)),
  if_then_else(Row=Dim,ValuePosition3 is 0,element(Position2,List,ValuePosition3)),
  element(Position, List, ValuePosition5),
  Value #= ValuePosition+ValuePosition2+ValuePosition3+ValuePosition4,
  Dim2 is Dim*Dim, trace,
  if_then_else((Position = 1; Position = Dim2),ValuePosition5 #= 1, ((ValuePosition5 #= 1) #=> (Value#=2))),
  Row2 is Row+1,
  Col2 is Col+1,
  if_then_else(Row=Dim,checkConectivity(Board,1,Col2,Dim),checkConectivity(Board,Row2,Col,Dim)).
