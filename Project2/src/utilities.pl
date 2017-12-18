execute:-reconsult('/Users/francisca/Documents/FEUP/3 ano/1 semestre/PLOG/feup-PLOG/Project2/src/bosnianSnake.pl').

putRestrictionsonBoard(List, Nrow, NCol, Nrow2, Ncol2, NR, NumberIn, NumberIn2) :-
  getPosition(NR,Nrow, NCol,Position),
  getPosition(NR,Nrow2,NCol2,Position2),
  nth1(Position,List,Element),
  nth1(Position2,List,Element2),
  Element=NumberIn,
  Element2=NumberIn.
