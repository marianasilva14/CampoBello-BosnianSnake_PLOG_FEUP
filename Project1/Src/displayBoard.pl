getSymbol(empty, ' ').
getSymbol(pieceX, 'X').
getSymbol(pieceY, 'Y').
getSymbol(noPiece, 'N').

initialBoard([[empty,pieceX,pieceX,pieceX,pieceX,empty,empty,empty,empty],
[empty,empty,pieceX,pieceX,pieceX,empty,empty,empty,pieceY],
[empty,empty,empty,pieceX,pieceX,empty,empty,pieceY,pieceY],
[empty,empty,empty,empty,noPiece,empty,pieceY,pieceY,pieceY],
[pieceX,pieceX,pieceX,noPiece,noPiece,noPiece,pieceY,pieceY,pieceY],
[pieceX,pieceX,pieceX,empty,noPiece,empty,empty,empty,empty],
[pieceX,pieceX,empty,empty,pieceY,pieceY,empty,empty,empty],
[pieceX,empty,empty,empty,pieceY,pieceY,pieceY,empty,empty],
[empty,empty,empty,empty,pieceY,pieceY,pieceY,pieceY,empty]]).

finalBoard([[empty,noPiece,noPiece,noPiece,noPiece,empty,empty,empty,empty],
[empty,empty,noPiece,noPiece,noPiece,empty,empty,empty,noPiece],
[empty,empty,empty,pieceX,noPiece,empty,empty,noPiece,noPiece],
[empty,empty,empty,empty,pieceY,empty,noPiece,noPiece,noPiece],
[noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece],
[noPiece,noPiece,pieceX,empty,noPiece,empty,empty,empty,empty],
[noPiece,noPiece,empty,empty,noPiece,noPiece,empty,empty,empty],
[noPiece,empty,empty,empty,noPiece,noPiece,noPiece,empty,empty],
[empty,empty,empty,empty,noPiece,noPiece,noPiece,noPiece,empty]]).

middleBoard([[empty,pieceX,noPiece,noPiece,noPiece,empty,empty,empty,empty],
[empty,empty,noPiece,noPiece,pieceY,empty,empty,empty,noPiece],
[empty,empty,empty,pieceX,noPiece,empty,empty,noPiece,noPiece],
[empty,empty,empty,empty,pieceY,empty,noPiece,noPiece,noPiece],
[noPiece,pieceX,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,noPiece],
[noPiece,noPiece,pieceX,empty,noPiece,empty,empty,empty,empty],
[noPiece,noPiece,empty,empty,pieceY,noPiece,empty,empty,empty],
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
