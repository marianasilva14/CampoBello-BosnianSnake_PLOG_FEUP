:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- include('conectivity.pl').

puz(1, [1-1, 6-6], 6-6, [2-2,5-1], [], [3-5-6, 4-2-6]).
puz(2, [1-1, 12-12], 12-12, [], [2-2,5-1], [3-5-6, 4-2-6]).
puz(3, [1-1, 8-8], 8-8, [2-2,5-1], [], [3-5-6, 4-2-6]).
puz(4, [1-1, 24-24], 24-24, [2-2,5-1], [], [3-5-6, 4-2-6]).

bosnianSnake(N, List) :-
puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, [RRow-NumberOut,RRow2-NumberOut2], [], [IntRow-IntCol-NumberIn,IntRow2-IntCol2-NumberIn2]),
board(NR, NC, Board),
matrixToListOfLists(Board,List),
headAndTailCells(List, BeginRow,BeginCol,EndRow,EndCol,NR),
cellsAround(List, IntRow, IntCol, NumberIn, NR),
cellsAround(List, IntRow2, IntCol2, NumberIn2, NR),
cellsOfRestrictionOut_ROW(List,NumberOut,RRow,NR),
cellsOfRestrictionOut_ROW(List,NumberOut2,RRow2,NR),
imposeConectivity(List,List,NR,1),
labeling([], List),
list_to_matrix(List,NR,Board),
printFinalBoard(Board,1,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,NR).

bosnianSnake(N, List) :-
puz(N, [BeginRow-BeginCol,EndRow-EndCol],NR-NC, [], [CCol-NumberOut,CCol2-NumberOut2], [IntRow-IntCol-NumberIn,IntRow2-IntCol2-NumberIn2]),
board(NR, NC, Board),
matrixToListOfLists(Board,List),
headAndTailCells(List, BeginRow,BeginCol,EndRow,EndCol,NR),
cellsAround(List, IntRow, IntCol, NumberIn, NR),
cellsAround(List, IntRow2, IntCol2, NumberIn2, NR),
cellsOfRestrictionOut_COL(List,NumberOut,CCol,NR),
cellsOfRestrictionOut_COL(List,NumberOut2,CCol2,NR),
write('aquiii'),nl,nl,
%imposeConectivity(List,List,NR,1),
labeling([], List),
list_to_matrix(List,NR,Board),
printFinalBoard(Board,1,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,CCol,NumberOut,CCol2,NumberOut2,NR).


printFinalBoard([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,Size):-
    nl,
    printBoard([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,Size),
    printLine(Size).

printSpaces(0).
printSpaces(Size):-
write('    |'),
NewSize is Size-1,
printSpaces(NewSize).

printLine(Size):-
  write('    '),
  printLineAux(Size).
printLineAux(0).
printLineAux(Size):-
  write('-----'),
  S is Size-1,
  printLineAux(S).


printBoard([],_,_,_,_,_,_,_,_,_,_,_,_,_).
printBoard([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,Size) :-
          printLine(Size),nl,
          S is Size+1,
          printSpaces(S),nl,
          printFinalRow(L,Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2),nl,
          Row2 is Row+1,
          printSpaces(S),nl,
          printBoard(Ls,Row2,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,Size).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2):-
        Row==RRow2,
        write(NumberOut2),
        write('   |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2):-
        Row==RRow,
        write(NumberOut),
        write('   |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2):-
        Row\=RRow,
        Row\=RRow2,
        write('    |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
        IntRow==Row,
        IntCol==Col,
        write(' '),
        write(NumberIn),
        write('  '),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).


printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
        IntRow2==Row,
        IntCol2==Col,
        write(' '),
        write(NumberIn2),
        write('  '),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
        ((IntRow2\=Row,
        IntCol2\=Col);
        (IntRow2==Row,
        IntCol2\=Col);
        (IntRow2\=Row,
        IntCol2==Col)),
        X==1,
        write('****'),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
        ((IntRow2\=Row,
        IntCol2\=Col);
        (IntRow2==Row,
        IntCol2\=Col);
        (IntRow2\=Row,
        IntCol2==Col)),
        X==0,
        write('    '),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printRow([],_,_,_,_,_,_,_,_).

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

getCellsAround(List, ListOut,Position,NR) :-
  PositionUp is (Position -NR),
  PositionUpLeft is PositionUp-1,
  PositionUpRight is PositionUp+1,
  PositionDown is (Position +NR),
  PositionDownRight is PositionDown+1,
  PositionDownLeft is PositionDown-1,
  PositionRight is (Position + 1),
  PositionLeft is (Position - 1),
  setof(Element,
              (nth1(PositionUp,List,Element);
              nth1(PositionDown,List,Element);
              nth1(PositionLeft,List,Element);
              nth1(PositionRight,List,Element);
              nth1(PositionUpLeft,List,Element);
              nth1(PositionUpRight,List,Element);
              nth1(PositionDownLeft,List,Element);
              nth1(PositionDownRight,List,Element)),ListOut).

getRowAux(_,L,L,Size,Size).
getRowAux(List,ListaAux,ListOut,First,FinalRow):-
  nth1(FinalRow,List,Element),
  append([Element],ListaAux,Return),
  FinalRow2 is FinalRow-1,
  getRowAux(List,Return,ListOut,Size,FinalRow2).

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

getColAux(List,ListaAux,ListOut,First,FinalCol,Size):-
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
  write('DEPOIS'),nl,nl,
  write(ListOut),nl,nl,
  global_cardinality(ListOut,[1-Number, 0-Number2]).

cellsAround(List, Nrow, Ncol, Number, NR) :-
  getPosition(NR,Nrow,Ncol,Position),
  Number2 is (8 - Number),
  getCellsAround(List, ListOut, Position, NR),
  global_cardinality(ListOut,[1-Number,0-Number2]).

board(_,0,[]).
board(Size, NumberOfLists, [HList|TList]) :-
length(HList, Size),
domain(HList, 0, 1),
TempNumberOfLists is NumberOfLists-1,
board(Size, TempNumberOfLists, TList).
