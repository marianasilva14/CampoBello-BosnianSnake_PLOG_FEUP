:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).

bosnianSnake :-
  board(6, 6, BoardIn),
  setPiece(BoardIn, 3, 5, '6', Board),
  setPiece(Board, 4, 2, '6', BoardOut),
  nl, write('Board'),nl,
  write(BoardOut),
  nl,nl,nl,
  write('Celulas a volta do 6'), nl,
  getCellsAround(BoardOut, ListOut, 3, 5),
  write(ListOut).

getCellsAround(Board, ListOut, Nrow, Ncol) :-
  FinalRow1 is (Nrow + 1),
  FinalRow2 is (Nrow - 1),
  FinalCol1 is (Ncol + 1),
  FinalCol2 is (Ncol - 1),
  setof(Element,
                (getElement(Board,FinalRow1,Ncol,Element),
                getElement(Board,Nrow,FinalCol1,Element),
                getElement(Board,FinalRow1,FinalCol1,Element),
                getElement(Board,FinalRow2,Ncol,Element),
                getElement(Board,Nrow,FinalCol2,Element),
                getElement(Board,FinalRow2,FinalCol2,Element),
                getElement(Board,FinalRow1,FinalCol2,Element),
                getElement(Board,FinalRow2,FinalCol1,Element)),ListOut).

getElement(Board,Nrow,Ncol,Element) :-
  nth1(Nrow, Board, Row),
  nth1(Ncol,Row,Element).

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
