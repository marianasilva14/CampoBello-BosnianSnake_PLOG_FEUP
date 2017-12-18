printFinalBoard([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,Size):-
    nl,
    printBoard([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,RRow2,NumberOut2,Size),
    printLine(Size).

printFinalBoard2([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,CCol,NumberOut,CCol2,NumberOut2,Size):-
    S is Size+1,
    write('     '),
    printCol(CCol,NumberOut,CCol2,NumberOut2,S,1),nl,
    printBoard2([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,CCol,NumberOut,CCol2,NumberOut2,Size),
    printLine(Size).

printFinalBoard3([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,CCol,NumberOut2,Size):-
    S is Size+1,
    write('     '),
    printCol(CCol,NumberOut2,S,1),nl,
    printBoard3([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,Size),
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

printBoard2([],_,_,_,_,_,_,_,_,_,_,_,_,_).
printBoard2([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,CCol,NumberOut,CCol2,NumberOut2,Size) :-
          S is Size+1,
          printLine(Size),nl,
          printSpaces(S),nl,
          printFinalRow2(L,Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2),nl,
          Row2 is Row+1,
          printSpaces(S),nl,
          printBoard2(Ls,Row2,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,CCol,NumberOut,CCol2,NumberOut2,Size).

printBoard3([],_,_,_,_,_,_,_,_,_,_,_).
printBoard3([L|Ls],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,Size) :-
          printLine(Size),nl,
          S is Size+1,
          printSpaces(S),nl,
          printFinalRow(L,Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut),nl,
          Row2 is Row+1,
          printSpaces(S),nl,
          printBoard3(Ls,Row2,1,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,Size).

printCol(_,_,S,S).
printCol(CCol,NumberOut2,Size,N):-
        N==CCol,
        write('  '),
        write(NumberOut2),
        write('  '),
        N1 is N+1,
        printCol(CCol,NumberOut2,Size,N1).

printCol(CCol,NumberOut2,Size,N):-
        N\=CCol,
        write('     '),
        N1 is N+1,
        printCol(CCol,NumberOut2,Size,N1).

printCol(_,_,_,_,S,S).
printCol(CCol,NumberOut,CCol2,NumberOut2,Size,N):-
        N==CCol,
        write('  '),
        write(NumberOut),
        write('  '),
        N1 is N+1,
        printCol(CCol,NumberOut,CCol2,NumberOut2,Size,N1).

printCol(CCol,NumberOut,CCol2,NumberOut2,Size,N):-
        N==CCol2,
        write('  '),
        write(NumberOut2),
        write('  '),
        N1 is N+1,
        printCol(CCol,NumberOut,CCol2,NumberOut2,Size,N1).

printCol(CCol,NumberOut,CCol2,NumberOut2,Size,N):-
        N\=CCol2,
        N\=CCol,
        write('     '),
        N1 is N+1,
        printCol(CCol,NumberOut,CCol2,NumberOut2,Size,N1).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,_,_,RRow2,NumberOut2):-
        Row==RRow2,
        write(NumberOut2),
        write('   |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut,_,_):-
        Row==RRow,
        write(NumberOut),
        write('   |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,_,RRow2,_):-
        Row\=RRow,
        Row\=RRow2,
        write('    |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,NumberOut):-
        Row==RRow,
        write(NumberOut),
        write('   |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2,RRow,_):-
        Row\=RRow,
        write('    |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printFinalRow2([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
        write('    |'),
        printRow([X|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).

printRow([_|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
        IntRow==Row,
        IntCol==Col,
        write(' '),
        write(NumberIn),
        write('  '),write('|'),
        Col2 is Col+1,
        printRow(Xs,Row,Col2,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2).


printRow([_|Xs],Row,Col,IntRow,IntCol,IntRow2,IntCol2,NumberIn,NumberIn2):-
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
