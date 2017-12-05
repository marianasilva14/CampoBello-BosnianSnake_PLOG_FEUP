getSymbol(empty, ' ').
getSymbol(pieceX1, 'X').
getSymbol(pieceX2, 'X').
getSymbol(pieceY1, 'Y').
getSymbol(pieceY2, 'Y').
getSymbol(noPiece, 'N').

initialBoard([[empty,pieceX1,pieceX1,pieceX1,pieceX1,empty,empty,empty,empty],
[empty,empty,pieceX1,pieceX1,pieceX1,empty,empty,empty,pieceY1],
[empty,empty,empty,pieceX1,pieceX1,empty,empty,pieceY1,pieceY1],
[empty,empty,empty,empty,noPiece,empty,pieceY1,pieceY1,pieceY1],
[pieceX2,pieceX2,pieceX2,noPiece,noPiece,noPiece,pieceY1,pieceY1,pieceY1],
[pieceX2,pieceX2,pieceX2,empty,noPiece,empty,empty,empty,empty],
[pieceX2,pieceX2,empty,empty,pieceY2,pieceY2,empty,empty,empty],
[pieceX2,empty,empty,empty,pieceY2,pieceY2,pieceY2,empty,empty],
[empty,empty,empty,empty,pieceY2,pieceY2,pieceY2,pieceY2,empty]]).

finalBoard([[empty,noPiece,noPiece,noPiece,noPiece,empty,empty,empty,empty],
[empty,empty,noPiece,noPiece,noPiece,empty,empty,empty,noPiece],
[empty,empty,empty,pieceX1,noPiece,empty,empty,noPiece,noPiece],
[empty,empty,empty,empty,pieceY1,empty,noPiece,noPiece,noPiece],
[noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece],
[noPiece,noPiece,pieceX2,empty,noPiece,empty,empty,empty,empty],
[noPiece,noPiece,empty,empty,noPiece,noPiece,empty,empty,empty],
[noPiece,empty,empty,empty,noPiece,noPiece,noPiece,empty,empty],
[empty,empty,empty,empty,noPiece,noPiece,noPiece,noPiece,empty]]).

middleBoard([[empty,pieceX1,noPiece,noPiece,noPiece,empty,empty,empty,empty],
[empty,empty,noPiece,noPiece,pieceY2,empty,empty,empty,noPiece],
[empty,empty,empty,pieceX1,noPiece,empty,empty,noPiece,noPiece],
[empty,empty,empty,empty,pieceY1,empty,noPiece,noPiece,noPiece],
[noPiece,pieceX1,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece],
[noPiece,noPiece,pieceX2,empty,noPiece,empty,empty,empty,empty],
[noPiece,noPiece,empty,empty,pieceY2,noPiece,empty,empty,empty],
[noPiece,empty,empty,empty,noPiece,noPiece,noPiece,empty,empty],
[empty,empty,empty,empty,noPiece,noPiece,noPiece,noPiece,empty]]).

printFinalBoard([L|Ls]):-
    nl,
    printLetters,nl,
    printBoard([L|Ls],0),
    printLine.

printLetters:-write('     A     B     C     D     E     F     G     H     I').

printSpaces:-write('   |    |     |     |     |     |     |     |     |     |').

printBoard([],_).
printBoard([L|Ls],Y) :-
          printLine,nl,
          printSpaces,nl,
          Y1 is Y+1,
          printFinalRow(L,Y1),nl,
          printSpaces,nl,
          printBoard(Ls,Y1).

printFinalRow([X|Xs],Y):-
        write(Y),
        write('  |'), printRow([X|Xs]).
printRow([X|Xs]):-
        getSymbol(X,Piece),
        write(' '), write(Piece),write('  | '),
        printRow(Xs).
printRow([]).
printLine:-write('   ------------------------------------------------------').
