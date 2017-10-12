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

printFinalBoard([L|Ls]):-
    printBoard([L|Ls]),
    printLine.
printBoard([L|Ls]) :-
          printLine,nl,
          printFinalRow(L),nl,
          printBoard(Ls).
printBoard([]).

printFinalRow([X|Xs]):-
        write('|'), printRow([X|Xs]).
printRow([X|Xs]):-
        getSymbol(X,Piece),
        write(' '), write(Piece),write('  | '),
        printRow(Xs).
printLine:-write('-----------------------------------------------------').
printRow([]).
