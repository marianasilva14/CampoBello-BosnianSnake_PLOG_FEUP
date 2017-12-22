printFinalBoard([L|Ls],Row,Col,CellsAround,RowCells,ColCells,Size):-
  nl,
  write('     '),
  printCol(ColCells,Size,1),nl,
  printBoard([L|Ls],Row,Col,CellsAround,RowCells,Size),
  printLine(Size).


printBoard([],_,_,_,_,_).
printBoard([L|Ls],Row,Col,CellsAround,[Row1-Number|Tail],Size):-
      Row==Row1,
      printLine(Size),nl,
      write('    |'),
      printSpaces(L),nl,
      write('  '),
      write(Number),
      write(' |'),
      printRow(L,Row,Col,CellsAround,CellsAround2),nl,
      write('    |'),
      printSpaces(L),nl,
      Row2 is Row+1,
      printBoard(Ls,Row2,Col,CellsAround2,Tail,Size).

printBoard([L|Ls],Row,Col,CellsAround,[Row1-Number|Tail],Size):-
      Row\=Row1,
      printLine(Size),nl,
      write('    |'),
      printSpaces(L),nl,
      write('    |'),
      printRow(L,Row,Col,CellsAround,CellsAround2),nl,
      write('    |'),
      printSpaces(L),nl,
      Row2 is Row+1,
      printBoard(Ls,Row2,Col,CellsAround2,[Row1-Number|Tail],Size).

printBoard([L|Ls],Row,Col,CellsAround,[],Size):-
      printLine(Size),nl,
      write('    |'),
      printSpaces(L),nl,
      write('    |'),
      printRow(L,Row,Col,CellsAround,CellsAround2),nl,
      write('    |'),
      printSpaces(L),nl,
      Row2 is Row+1,
      printBoard(Ls,Row2,Col,CellsAround2,[],Size).

printCol(_,S,S).
printCol([Col-Number|Tail],Size,N):-
        N==Col,
        write('  '),
        write(Number),
        write('  '),
        N1 is N+1,
        printCol(Tail,Size,N1).

printCol([Col-Number|Tail],Size,N):-
        N\=Col,
        write('     '),
        N1 is N+1,
        printCol([Col-Number|Tail],Size,N1).

printCol([],Size,N):-
        write('     '),
        N1 is N+1,
        printCol([],Size,N1).

printRow([],_,_,S,S).
printRow([_|Xs],Row,Col,[Row1-Col1-Number|Tail],S):-
        Row==Row1,
        Col==Col1,
        write('  '),
        write(Number),
        write(' |'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,Tail,S).

printRow([X|Xs],Row,Col,[],S):-
        X==0,
        write('    '),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,[],S).

printRow([X|Xs],Row,Col,[],S):-
        X==1,
        write('****'),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,[],S).

printRow([X|Xs],Row,Col,[Row1-Col1-Number|Tail],S):-
        ((Row\=Row1,
        Col\=Col1);
        (Row==Row1,
        Col\=Col1);
        (Row\=Row1,
        Col==Col1)),
        X==0,
        write('    '),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,[Row1-Col1-Number|Tail],S).

printRow([X|Xs],Row,Col,[Row1-Col1-Number|Tail],S):-
      ((Row\=Row1,
      Col\=Col1);
      (Row==Row1,
      Col\=Col1);
      (Row\=Row1,
      Col==Col1)),
      X==1,
      write('****'),write('|'),
      Col2 is Col+1,
      printRow(Xs,Row,Col2,[Row1-Col1-Number|Tail],S).


printSpaces([]).
printSpaces([X|Xs]):-
X==0,
write('    |'),
printSpaces(Xs).

printSpaces([X|Xs]):-
X==1,
write('****|'),
printSpaces(Xs).

printLine(Size):-
  write('    '),
  printLineAux(Size).
printLineAux(0).
printLineAux(Size):-
  write('-----'),
  S is Size-1,
  printLineAux(S).
