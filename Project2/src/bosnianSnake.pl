:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- include('continuity.pl').

puz(1, [1-1, 6-6], 6-6, [2-2,5-1], [], [3-5-6, 4-2-6]).


bosnianSnake(N) :-
  puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, [RRow-RCol,RRow2-RCol2], [], [IntRow-IntCol-Number,IntRow2-IntCol2-Number2]),
  write(IntRow),
  board(NR, NC, Board),
  nl, write('Board'),nl,
  write(Board),
  nl,nl,nl,
  write('Celulas a volta do 6'), nl,
  getCellsAround(Board, ListOut, IntRow, IntCol),
  write(ListOut),
  nl, nl, nl,
  write('Celulas c/ restricao'), nl,
  getCellsOfRestrictionOut(Board,RRow,NR,[],ListOut2),
  write(ListOut2).

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
  global_cardinality(ListOut,[1-Number],[0-Number2]).

cellsAround(Board, Nrow, Ncol, Number) :-
  Number2 is (8 - Number),
  getCellsAround(Board, ListOut, Nrow, Ncol),
  global_cardinality(ListOut,[1-Number,0-Number2]).

board(_,0,[]).
board(Size, NumberOfLists, [HList|TList]) :-
  length(HList, Size),
  TempNumberOfLists is NumberOfLists-1,
  board(Size, TempNumberOfLists, TList).

setPiece(BoardIn, Nrow, Ncol, Piece, BoardOut) :-
  setOnRow(Nrow, BoardIn, Ncol, Piece, BoardOut).

setOnRow(1, [Row|Remainder], Ncol, Piece, [Newrow|Remainder]):-
  setOnCol(Ncol, Row, Piece, Newrow).
setOnRow(Pos, [Row|Remainder], Ncol, Piece, [Row|Newremainder]):-
  Pos @> 1,
  Next is Pos-1,
  setOnRow(Next, Remainder, Ncol, Piece, Newremainder).

setOnCol(1, [_|Remainder], Piece, [Piece|Remainder]).
setOnCol(Pos, [X|Remainder], Piece, [X|Newremainder]):-
  Pos @> 1,
  Next is Pos-1,
  setOnCol(Next, Remainder, Piece, Newremainder).
