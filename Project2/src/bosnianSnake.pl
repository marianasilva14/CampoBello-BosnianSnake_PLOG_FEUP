:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- include('conectivity.pl').

puz(1, [1-1, 6-6], 6-6, [2-2,5-1], [], [3-5-6, 4-2-6]).


bosnianSnake(N, List) :-
  puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, [RRow-NumberOut,RRow2-NumberOut2], [], [IntRow-IntCol-NumberIn,IntRow2-IntCol2-NumberIn2]),
  write(IntRow),
  board(NR, NC, Board),
  nl, write('Board'),nl,
  write(Board),
  nl,nl,nl,
  Aux is NR+1,
  checkConectivity(Board,BeginRow,BeginCol, NR,Aux),
  write('Fez check connectivity'),
  %cellsOfRestrictionOut(Board, NumberOut, RRow, NR),
  %cellsOfRestrictionOut(Board, NumberOut2, RRow2, NR),
  write('Fez cellsOfRestrictionOut'), nl, nl,
  %cellsAround(Board, IntRow, IntCol, NumberIn),
  %cellsAround(Board, IntRow2, IntCol2, NumberIn2),
  write('Fez cellsAround'), nl, nl,
  nl, nl, nl,
  matrixToListOfLists(Board,List),
  write(List),
  labeling([], List).

getCellsAround(Board, ListOut, Nrow, Ncol) :-
  FinalRow1 is (Nrow + 1),
  FinalRow2 is (Nrow - 1),
  FinalCol1 is (Ncol + 1),
  FinalCol2 is (Ncol - 1),
  setof(Element,
                (getElement(Board,FinalRow1,Ncol,Element);
                getElement(Board,Nrow,FinalCol1,Element);
                getElement(Board,FinalRow1,FinalCol1,Element);
                getElement(Board,FinalRow2,Ncol,Element);
                getElement(Board,Nrow,FinalCol2,Element);
                getElement(Board,FinalRow2,FinalCol2,Element);
                getElement(Board,FinalRow1,FinalCol2,Element);
                getElement(Board,FinalRow2,FinalCol1,Element)),ListOut).

getElement(Board,Nrow,Ncol,Element) :-
  nth1(Nrow, Board, Row),
  nth1(Ncol,Row,Element).

getCellsOfRestrictionOut(_,_,0,L,L).
getCellsOfRestrictionOut(Board,Row,Size,ListIn,ListOut):-
  getElement(Board,Row,Size,Element),
  append([Element],ListIn,ListAux),
  FinalSize is Size-1,
  getCellsOfRestrictionOut(Board,Row,FinalSize,ListAux,ListOut).

cellsOfRestrictionOut(Board,Number,Row,Size) :-
  Number2 is (Size - Number),
  getCellsOfRestrictionOut(Board,Row,Size,[],ListOut),
  global_cardinality(ListOut,[1-Number, 0-Number2]).

cellsAround(Board, Nrow, Ncol, Number) :-
  Number2 is (8 - Number),
  getCellsAround(Board, ListOut, Nrow, Ncol),
  global_cardinality(ListOut,[1-Number,0-Number2]).

board(_,0,[]).
board(Size, NumberOfLists, [HList|TList]) :-
  length(HList, Size),
  domain(HList, 0, 1),
  TempNumberOfLists is NumberOfLists-1,
  board(Size, TempNumberOfLists, TList).
