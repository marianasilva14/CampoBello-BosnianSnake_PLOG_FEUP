:-use_module(library(lists)).

play(Board,Points) :- chooseSourceCoords(RowSource, ColSource, Board, Piece),
               chooseDestinyCoords(RowSource, ColSource, Board, Piece, BoardOut,Points,PointsOut),
               if_then_else(endGame(Board),play(BoardOut,PointsOut),write('End Game')).

chooseSourceCoords(RowSource, ColSource,Board,Piece) :-  repeat,nl,
                                                          player(Curr_player),nl,
                                                          write('It is the turn of '),
                                                          write(Curr_player), nl,nl,
                                                          write('Please choose the piece that you want move:'), nl,
                                                          write('Please enter a position (A...I)'),nl,
                                                          getChar(ColLetter),
                                                          once(letterToNumber(ColLetter, ColSource)),
                                                          write('Please enter a position (1...9)'),
                                                          nl,
                                                          getCode(RowSource),
                                                          validateSourcePiece(ColSource, RowSource,Board,Piece).

chooseDestinyCoords(RowSource, ColSource, Board,Piece, BoardOut,PointsIn,PointsOut) :- repeat,nl,
                                                                                write('What is the destiny of your piece?'),
                                                                                 nl,
                                                                                 write('Please enter a position (A...I)'),
                                                                                 nl,
                                                                                 getChar(ColLetter),
                                                                                 once(letterToNumber(ColLetter, ColDestiny)),
                                                                                 write('Please enter a position (1...9)'),
                                                                                 nl,
                                                                                 getCode(RowDestiny),
                                                                                 validateDestinyPiece(ColSource,RowSource,ColDestiny, RowDestiny,Board,Piece, BoardOut,PointsIn,PointsOut),
                                                                                 printFinalBoard(BoardOut),
                                                                                 player(Curr_player),
                                                                                 if_then_else(Curr_player == 'playerX', set_player('playerY'),set_player('playerX')).



letterToNumber('A',1).
letterToNumber('B',2).
letterToNumber('C',3).
letterToNumber('D',4).
letterToNumber('E',5).
letterToNumber('F',6).
letterToNumber('G',7).
letterToNumber('H',8).
letterToNumber('I',9).

validateSourcePiece(Ncol, Nrow,Board,Piece) :- player(Curr_player),
                                               getPiece(Board, Nrow, Ncol, Piece),
                                               if_then_else(Curr_player == 'playerX',
                                               (Piece \= 'pieceY1',
                                               Piece \= 'pieceY2'),
                                               (Piece \= 'pieceX1',
                                               Piece \= 'pieceX2')),
                                               Piece \= 'empty',
                                               Piece \= 'noPiece'.

validateDestinyPiece(LastCol,LastRow,Ncol,Nrow,Board, Piece, BoardOut,PointsIn,PointsOut) :-
                                                                          checkIfCanMove(Ncol, Nrow, Board,NewPiece,Piece),
                                                                          validateMove(Piece, LastCol, LastRow, Ncol, Nrow),
                                                                          setPiece(Board,Nrow,Ncol,Piece,BoardOut2),
                                                                          setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut),
                                                                          updatePoints(NewPiece,Piece,PointsIn,PointsOut),
                                                                          write(PointsOut),nl.


checkIfCanMove(Ncol,Nrow,Board,NewPiece,'pieceX1') :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                      NewPiece \= 'pieceY1',
                                                      NewPiece \= 'pieceY2'.

checkIfCanMove(Ncol,Nrow,Board,NewPiece,'pieceX2') :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                      NewPiece \= 'pieceY1',
                                                      NewPiece \= 'pieceY2'.

checkIfCanMove(Ncol,Nrow,Board,NewPiece,'pieceY1') :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                      NewPiece \= 'pieceX1',
                                                      NewPiece \= 'pieceX2'.

checkIfCanMove(Ncol,Nrow,Board,NewPiece,'pieceY2') :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                      NewPiece \= 'pieceX1',
                                                      NewPiece \= 'pieceX2'.

updatePoints(NewPiece,'pieceX1',PointsIn,PointsOut) :- ((NewPiece \= 'pieceY1',
                                          NewPiece \= 'pieceY2',
                                          NewPiece \= 'noPiece',
                                          PointsOut is PointsIn + 3);
                                          (NewPiece \= 'pieceX1',
                                          NewPiece \= 'pieceX2',
                                          NewPiece \= 'noPiece',
                                          PointsOut is PointsIn +1);
                                          (NewPiece == 'noPiece',
                                          PointsOut is PointsIn)).

updatePoints(NewPiece,'pieceX2',PointsIn,PointsOut) :- ((NewPiece \= 'pieceY1',
                                                    NewPiece \= 'pieceY2',
                                                    NewPiece \= 'noPiece',
                                                    PointsOut is PointsIn + 3);
                                                    (NewPiece \= 'pieceX1',
                                                    NewPiece \= 'pieceX2',
                                                    NewPiece \= 'noPiece',
                                                    PointsOut is PointsIn +1);
                                                    (NewPiece == 'noPiece',
                                                    PointsOut is PointsIn)).

updatePoints(NewPiece,'pieceY1',PointsIn,PointsOut) :- ((NewPiece \= 'pieceY1',
                                                    NewPiece \= 'pieceY2',
                                                    NewPiece \= 'noPiece',
                                                    PointsOut is PointsIn + 1);
                                                    (NewPiece \= 'pieceX1',
                                                    NewPiece \= 'pieceX2',
                                                    NewPiece \= 'noPiece',
                                                    PointsOut is PointsIn +3);
                                                    (NewPiece == 'noPiece',
                                                    PointsOut is PointsIn)).

updatePoints(NewPiece,'pieceY2',PointsIn,PointsOut) :- ((NewPiece \= 'pieceY1',
                                                    NewPiece \= 'pieceY2',
                                                    NewPiece \= 'noPiece',
                                                    PointsOut is PointsIn + 1);
                                                    (NewPiece \= 'pieceX1',
                                                    NewPiece \= 'pieceX2',
                                                    NewPiece \= 'noPiece',
                                                    PointsOut is PointsIn +3);
                                                    (NewPiece == 'noPiece',
                                                    PointsOut is PointsIn)).

validateMove('pieceX1', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol+2,
                                                 Nrow is LastRow+2);
                                                 (Ncol is LastCol,
                                                 Nrow is LastRow+2);
                                                 (Nrow is LastRow,
                                                 Ncol is LastCol+2).

validateMove('pieceX2', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol+2,
                                                Nrow is LastRow);
                                                (Ncol is LastCol,
                                                Nrow is LastRow+2);
                                                (Nrow is LastRow-2,
                                                Ncol is LastCol+2).

validateMove('pieceY1', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol-2,
                                                Nrow is LastRow+2);
                                                (Ncol is LastCol+2,
                                                Nrow is LastRow+2);
                                                (Nrow is LastRow,
                                                Ncol is LastCol-2).

validateMove('pieceY2', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol-2,
                                                Nrow is LastRow-2);
                                                (Ncol is LastCol-2,
                                                Nrow is LastRow);
                                                (Nrow is LastRow-2,
                                                Ncol is LastCol).


getPiece(Board, Nrow, Ncol, Piece) :- getElePos(Nrow, Board, Row),
                                      getElePos(Ncol, Row, Piece).

getElePos(1, [Element|_], Element).
getElePos(Pos, [_|Remainder], Element) :- Pos > 1,
                                          Next is Pos-1,
                                          getElePos(Next, Remainder, Element).

setPiece(BoardIn, Nrow, Ncol, Piece, BoardOut) :- setOnRow(Nrow, BoardIn, Ncol, Piece, BoardOut).

setOnRow(1, [Row|Remainder], Ncol, Piece, [Newrow|Remainder]):- setOnCol(Ncol, Row, Piece, Newrow).
setOnRow(Pos, [Row|Remainder], Ncol, Piece, [Row|Newremainder]):- Pos > 1,
                                                                  Next is Pos-1,
                                                                  setOnRow(Next, Remainder, Ncol, Piece, Newremainder).

setOnCol(1, [_|Remainder], Piece, [Piece|Remainder]).
setOnCol(Pos, [X|Remainder], Piece, [X|Newremainder]):- Pos > 1,
                                                        Next is Pos-1,
                                                        setOnCol(Next, Remainder, Piece, Newremainder).

if_then_else(If, Then,_):- If,!, Then.
if_then_else(_, _, Else):- Else.

getElement(Board,Nrow,Ncol,Element) :- nth1(Nrow, Board, Row),
                                       nth1(Ncol,Row,Element).

checkPieces('pieceX1',Board) :- getElement(Board,_,_,'pieceX1').

checkPieces('pieceX2',Board) :- getElement(Board,_,_,'pieceX2').

checkPieces('pieceY1',Board) :- getElement(Board,_,_,'pieceY1').

checkPieces('pieceY2',Board) :- getElement(Board,_,_,'pieceY2').

checkMoves('pieceX1', Board) :- getElement(Board, Nrow, Ncol, 'pieceX1'),
                            NewRow is Nrow+2,
                            Newcol is Ncol+2,
                            (getPiece(Board,NewRow,Newcol,Piece),
                            Piece \='empty');
                            (getPiece(Board,Nrow,Newcol,Piece),
                            Piece \='empty');
                            (getPiece(Board,NewRow,Ncol,Piece),
                            Piece \='empty').

checkMoves('pieceX2', Board) :- getElement(Board, Nrow, Ncol, 'pieceX2'),
                           NewRow is Nrow+2,
                           Newcol is Ncol+2,
                           Newrow is Nrow-2,
                          (getPiece(Board,Nrow,Newcol,Piece),
                          Piece \='empty');
                          (getPiece(Board,NewRow,Ncol,Piece),
                          Piece \='empty');
                          (getPiece(Board,Newrow,Newcol,Piece),
                          Piece \='empty').

checkMoves('pieceY1', Board) :- getElement(Board, Nrow, Ncol, 'pieceY1'),
                          NewRow is Nrow+2,
                          Newcol is Ncol+2,
                          NewCol is Ncol-2,
                          (getPiece(Board,NewRow,NewCol,Piece),
                          Piece \='empty');
                          (getPiece(Board,NewRow,Newcol,Piece),
                          Piece \='empty');
                          (getPiece(Board,Nrow,NewCol,Piece),
                          Piece \='empty').

checkMoves('pieceY2', Board) :- getElement(Board, Nrow, Ncol, 'pieceY2'),
                          NewRow is Nrow-2,
                          Newcol is Ncol-2,
                          (getPiece(Board,NewRow,Newcol,Piece),
                          Piece \='empty');
                          (getPiece(Board,Nrow,Newcol,Piece),
                          Piece \='empty');
                          (getPiece(Board,NewRow,Ncol,Piece),
                          Piece \='empty').

endGame(Board) :- player(Curr_player),
                  if_then_else(Curr_player==playerX, (checkPieces('pieceX1',Board),checkPieces('pieceX2',Board),
                                                    checkMoves('pieceX1',Board),checkMoves('pieceX2',Board)),
                                                              (checkPieces('pieceY1',Board),checkPieces('pieceY2',Board),
                                                               checkMoves('pieceY1',Board),checkMoves('pieceY2',Board))).
