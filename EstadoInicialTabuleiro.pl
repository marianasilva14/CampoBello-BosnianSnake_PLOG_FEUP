initialBoard(Board):-
Board = [initialBoard,
[piece1,empty,piece1,empty,piece1,empty,piece1],
[empty,piece1,empty,piece1,empty,piece1,empty],
[empty,empty,piece1,empty,piece1,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,piece2,empty,piece2,empty,empty],
[empty,piece2,empty,piece2,empty,piece2,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]].

gameBoard(Board):-
Board = [gameBoard,
[piece1,empty,noPiece,empty,piece2,empty,noPiece],
[empty,noPiece,empty,noPiece,empty,noPiece,empty],
[empty,empty,piece1,empty,noPiece,empty,empty],
[empty,empty,empty,piece1,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,noPiece,empty,piece2,empty,noPiece,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]].


finalBoard(Board):-
Board = [finalBoard,
[noPiece,empty,noPiece,empty,noPiece,empty,noPiece],
[empty,noPiece,empty,noPiece,empty,noPiece,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,noPiece,empty,piece2,empty,noPiece,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]].
