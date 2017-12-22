:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- include('conectivity.pl').
:- include('board.pl').

puz(1, [1-1, 6-6], 6-6, [2-2,5-1], [], [3-5-6, 4-2-6]).
puz(2, [1-1, 12-12], 12-12, [], [7-6,12-4], [6-4-7, 4-8-5]).%
puz(3, [1-1, 8-8], 8-8, [2-4,_], [5-1,_], [3-5-6, 4-2-7]).
puz(4, [1-1, 7-7], 7-7, [5-3,_], [3-1,_], [4-2-3, 3-5-3]).
puz(5, [1-1, 15-15], 15-15, [9-1,_], [6-1,_], [9-3-5, 10-8-2]).%
puz(6, [1-1, 10-10], 10-10, [9-6,_], [6-2,_], [6-1-5, 10-5-4]).
puz(7, [1-1, 5-5], 5-5, [2-2,4-3], [], [1-3-3, 3-5-2]).
puz(8, [1-1, 3-3], 3-3, [], [1-2,2-1], [3-1-2, 1-3-2]).

randomPuzzle:-random(1,8,Puzzle),
              bosnianSnake(Puzzle).

bosnianSnake(N,L) :-
puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, RowCells, ColCells, CellsAround),
board(NR, NC, Board),
matrixToListOfLists(Board,List),
headAndTailCells(List, BeginRow,BeginCol,EndRow,EndCol,NR),
imposeConectivity(List,List,NR,1),
scroolCellsAround(CellsAround,List,NR),
scrollRestrictionsRow(RowCells,List,NR),
scrollRestrictionsCol(ColCells,List,NR),
count(1,List,#=,Count),
labeling([minimize(Count)], List),
list_to_matrix(List,NR,Board),
write('passei'),
printFinalBoard(Board,1,1,CellsAround,RowCells,ColCells,NR).
/*
bosnianSnake(N) :-
puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, [], [CCol-NumberOut,CCol2-NumberOut2], [IntRow-IntCol-NumberIn,IntRow2-IntCol2-NumberIn2]),
board(NR, NC, Board),
matrixToListOfLists(Board,List),
headAndTailCells(List, BeginRow,BeginCol,EndRow,EndCol,NR),
imposeConectivity(List,List,NR,1),
cellsAround(List, IntRow, IntCol, NumberIn, NR),
cellsAround(List, IntRow2, IntCol2, NumberIn2, NR),
cellsOfRestrictionOut_COL(List,NumberOut,CCol,NR),
cellsOfRestrictionOut_COL(List,NumberOut2,CCol2,NR),
count(1,List,#=,Count),
labeling([minimize(Count),ffc], List),
list_to_matrix(List,NR,Board),
printFinalBoard2(Board,1,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,CCol,NumberOut,CCol2,NumberOut2,NR).

bosnianSnake(N) :-
puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, [RRow-NumberOut,_], [CCol-NumberOut2,_], [IntRow-IntCol-NumberIn,IntRow2-IntCol2-NumberIn2]),
board(NR, NC, Board),
matrixToListOfLists(Board,List),
headAndTailCells(List, BeginRow,BeginCol,EndRow,EndCol,NR),
imposeConectivity(List,List,NR,1),
cellsAround(List, IntRow, IntCol, NumberIn, NR),
cellsAround(List, IntRow2, IntCol2, NumberIn2, NR),
cellsOfRestrictionOut_ROW(List,NumberOut,RRow,NR),
cellsOfRestrictionOut_COL(List,NumberOut2,CCol,NR),
count(1,List,#=,Count),
labeling([minimize(Count),ffc], List),
list_to_matrix(List,NR,Board),
printFinalBoard3(Board,1,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,CCol,NumberOut2,NR).
*/
list_to_matrix([], _, []).
list_to_matrix(List, Size, [Row|Matrix]):-
  list_to_matrix_row(List, Size, Row, Tail),
  list_to_matrix(Tail, Size, Matrix).

list_to_matrix_row(Tail, 0, [], Tail).
list_to_matrix_row([Item|List], Size, [Item|Row], Tail):-
  NSize is Size-1,
  list_to_matrix_row(List, NSize, Row, Tail).

headAndTailCells(List, BeginRow,BeginCol,EndRow,EndCol,NR) :-
getPosition(NR,BeginRow,BeginCol,Position),
getPosition(NR,EndRow,EndCol,EndPosition),
nth1(Position,List,Element),
nth1(EndPosition,List,Element2),
Element=1,
Element2=1.

getRowAux(_,L,L,Size,Size).
getRowAux(List,ListaAux,ListOut,_,FinalRow):-
  nth1(FinalRow,List,Element),
  append([Element],ListaAux,Return),
  FinalRow2 is FinalRow-1,
  getRowAux(List,Return,ListOut,_,FinalRow2).

getRow(List,Row,ListOut,Size):-
  Final is Row*Size,
  First is Final-Size,
  getRowAux(List,[],ListOut,First,Final).


getColAux(List,ListaAux,ListOut,First,FinalCol,Size):-
  nth1(FinalCol,List,Element),
  append([Element],ListaAux,Return),
  FinalCol\=First,
  FinalCol2 is FinalCol-Size,
  getColAux(List,Return,ListOut,First,FinalCol2,Size).

getColAux(List,ListaAux,ListOut,First,FinalCol,_):-
  nth1(FinalCol,List,Element),
  append([Element],ListaAux,ListOut),
  FinalCol==First.


getCol(List,Col,ListOut,Size):-
  Dim is Size*Size,
  Value is Dim-Size,
  Final is Value+Col,
  getColAux(List,[],ListOut,Col,Final,Size).

cellsOfRestrictionOut_ROW(List,Number,Row,Size) :-
  Number2 is (Size - Number),
  getRow(List,Row,ListOut,Size),
  global_cardinality(ListOut,[1-Number, 0-Number2]).

cellsOfRestrictionOut_COL(List,Number,Col,Size) :-
  Number2 is (Size - Number),
  getCol(List,Col,ListOut,Size),
  global_cardinality(ListOut,[1-Number, 0-Number2]).

scrollRestrictionsRow([],_,_).
scrollRestrictionsRow([Row-Number|Tail],List,Size):-
  cellsOfRestrictionOut_ROW(List,Number,Row,Size),
  scrollRestrictionsRow(Tail,List,Size).

scrollRestrictionsCol([],_,_).
scrollRestrictionsCol([Col-Number|Tail],List,Size):-
  cellsOfRestrictionOut_COL(List,Number,Col,Size),
  scrollRestrictionsCol(Tail,List,Size).

scroolCellsAround([],_,_).
scroolCellsAround([Row-Col-Number|Tail],List,Size):-
  cellsAround(List,Row,Col,Number,Size),
  scroolCellsAround(Tail,List,Size).

cellsAround(List, Nrow, Ncol, Number, NR) :-
  getPosition(NR,Nrow,Ncol,Position),
  Mod is Position mod NR,
  Mod \=0,
  Mod \=1,
  Dim is NR*NR,
  Value is Dim-NR,
  Value1 is Value+1,
  Position >NR,
  Position < Value1,
  Number2 is (8 - Number),
  getAllNeighbours(Position, ListOut, List, NR),
  global_cardinality(ListOut,[1-Number,0-Number2]).

  cellsAround(List, Nrow, Ncol, Number, NR) :-
    getPosition(NR,Nrow,Ncol,Position),
    Dim is NR*NR,
    Value is Dim-NR,
    Value1 is Value+1,
    Position\=1,
    Position\=Value1,
    Position\=NR,
    Position\=Dim,
    Mod is Position mod NR,
    (Mod ==1;
    Mod==0),
    Number2 is (5 - Number),
    getAllNeighbours(Position, ListOut, List, NR),
    global_cardinality(ListOut,[1-Number,0-Number2]).


cellsAround(List, Nrow, Ncol, Number, NR) :-
  getPosition(NR,Nrow,Ncol,Position),
  Dim is NR*NR,
  Value is Dim-NR,
  Value1 is Value+1,
  (Position==1;
  Position==Value1;
  Position==NR;
  Position==Dim),
  Number2 is (3 - Number),
  getAllNeighbours(Position, ListOut, List, NR),
  global_cardinality(ListOut,[1-Number,0-Number2]).


cellsAround(List, Nrow, Ncol, Number, NR) :-
  getPosition(NR,Nrow,Ncol,Position),
  Dim is NR*NR,
  Value is Dim-NR,
  Value1 is Value+1,
  ((Position < NR,
  Position\=1);
  (Position > Value1,
  Position\=Dim)),
  Number2 is (5 - Number),
  getAllNeighbours(Position, ListOut, List, NR),
  nth1(Position,List,Element),
  Element#=0,
  global_cardinality(ListOut,[1-Number,0-Number2]).

board(_,0,[]).
board(Size, NumberOfLists, [HList|TList]) :-
length(HList, Size),
domain(HList, 0, 1),
TempNumberOfLists is NumberOfLists-1,
board(Size, TempNumberOfLists, TList).
