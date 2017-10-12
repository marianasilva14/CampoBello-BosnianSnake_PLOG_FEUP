getSymbol(empty, ' ').
getSymbol(piece1, 'X').
getSymbol(piece2, 'Y').
getSymbol(noPiece, 'N').


initialBoard([
[empty,piece1,piece1,piece1,piece1,empty,empty,empty,empty],
[empty,empty,piece1,piece1,piece1,empty,empty,empty,piece2],
[empty,empty,empty,piece1,piece1,empty,empty,piece2,piece2],
[empty,empty,empty,empty,noPiece,empty,piece2,piece2,piece2],
[piece1,piece1,piece1,noPiece,noPiece,noPiece,piece2,piece2,piece2],
[piece1,piece1,piece1,empty,noPiece,empty,empty,empty,empty],
[piece1,piece1,empty,empty,piece2,piece2,empty,empty,empty],
[piece1,empty,empty,empty,piece2,piece2,piece2,empty,empty],
[empty,empty,empty,empty,piece2,piece2,piece2,piece2,empty]]).

gameBoard([
[empty,piece1,noPiece,piece1,noPiece,empty,empty,empty,empty],
[empty,empty,piece1,piece1,piece1,empty,empty,empty,piece2],
[empty,empty,empty,piece1,noPiece,empty,empty,piece2,noPiece],
[empty,empty,empty,empty,noPiece,empty,piece2,piece2,piece2],
[piece1,noPiece,piece1,noPiece,piece2,noPiece,noPiece,piece2,noPiece],
[piece1,piece1,noPiece,empty,noPiece,empty,empty,empty,empty],
[noPiece,piece1,empty,empty,piece2,piece2,empty,empty,empty],
[piece1,empty,empty,empty,piece2,noPiece,piece2,empty,empty],
[empty,empty,empty,empty,piece2,piece2,piece2,noPiece,empty]]).

finalBoard([
[empty,noPiece,noPiece,noPiece,noPiece,empty,empty,empty,empty],
[empty,empty,noPiece,noPiece,noPiece,empty,empty,empty,noPiece],
[empty,empty,empty,noPiece,noPiece,empty,empty,piece2,piece2],
[empty,empty,empty,empty,piece2,empty,noPiece,piece2,piece2],
[noPiece,noPiece,noPiece,noPiece,noPiece,noPiece,piece2,piece2,noPiece],
[noPiece,noPiece,noPiece,empty,noPiece,empty,empty,empty,empty],
[noPiece,noPiece,empty,empty,piece2,noPiece,empty,empty,empty],
[noPiece,empty,empty,empty,piece2,piece2,piece2,empty,empty],
[empty,empty,empty,empty,noPiece,piece2,noPiece,piece2,empty]]).


printFinalBoard([L|Ls]):-
    printLetters,nl,
    printBoard([L|Ls],0),
    printLine.

printLetters:-write('     A     B     C     D     E     F     G     H     I').

printBoard([],_).
printBoard([L|Ls],Y) :-
          printLine,nl,
          Y1 is Y+1,
          printFinalRow(L,Y1),nl,
          printBoard(Ls,Y1).

printFinalRow([X|Xs],Y):-
        write(Y),
        write('  |'), printRow([X|Xs]).
printRow([X|Xs]):-
        getSymbol(X,Piece),
        write(' '), write(Piece),write('  | '),
        printRow(Xs).
printLine:-write('   ------------------------------------------------------').
printRow([]).
