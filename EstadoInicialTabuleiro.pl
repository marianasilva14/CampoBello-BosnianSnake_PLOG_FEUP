boards(initialBoard,[piece1,empty,piece1,empty,piece1,empty,piece1],
[empty,piece1,empty,piece1,empty,piece1,empty],
[empty,empty,piece1,empty,piece1,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,piece2,empty,piece2,empty,empty],
[empty,piece2,empty,piece2,empty,piece2,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]]).

boards(gameBoard,
[piece1,empty,noPiece,empty,piece2,empty,noPiece],
[empty,noPiece,empty,noPiece,empty,noPiece,empty],
[empty,empty,piece1,empty,noPiece,empty,empty],
[empty,empty,empty,piece1,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,noPiece,empty,piece2,empty,noPiece,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]]).


boards(finalBoard,
[noPiece,empty,noPiece,empty,noPiece,empty,noPiece],
[empty,noPiece,empty,noPiece,empty,noPiece,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,noPiece,empty,empty],
[empty,empty,empty,noPiece,empty,empty,empty],
[empty,empty,noPiece,empty,piece2,empty,empty],
[empty,noPiece,empty,piece2,empty,noPiece,empty],
[piece2,empty,piece2,empty,piece2,empty,piece2]]).
