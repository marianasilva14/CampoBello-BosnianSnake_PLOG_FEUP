getSymbol(empty, ' ').
getSymbol(piece1, 'X').
getSymbol(piece2, 'Y').
getSymbol(noPiece, 'NP').


initialBoard([
[piece1,empty,piece1,empty,piece1,empty,piece1],
[empty,piece1,empty,piece1,empty,piece1,empty],
[empty,empty,piece1,empty,piece1,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,noPiece,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,piece2,empty,piece2,empty,empty],
[empty,piece2,empty,piece2,empty,piece2,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]]).

gameBoard([
[piece1,empty,noPiece,empty,piece2,empty,noPiece],
[empty,noPiece,empty,noPiece,empty,noPiece,empty],
[empty,empty,piece1,empty,noPiece,empty,empty],
[empty,empty,empty,piece1,empty,empty,empty],
[empty,empty,noPiece,noPiece,piece2,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,noPiece,empty,piece2,empty,noPiece,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]]).


finalBoard([
[noPiece,empty,noPiece,empty,noPiece,empty,noPiece],
[empty,noPiece,empty,noPiece,empty,noPiece,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,noPiece,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,noPiece,empty,piece2,empty,noPiece,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]]).


printBoard([L|Ls]) :-
          printRow(L),nl,
          printBoard(Ls).
printBoard([]):-
          nl.
printRow([X|Xs]):-
        getSymbol(X,Piece),
        write(' '), write(Piece),write('  |'),
        printRow(Xs).
printRow([]).
