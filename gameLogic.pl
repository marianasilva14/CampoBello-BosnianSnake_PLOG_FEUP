:-use_module(library(lists)).
  :-use_module(library(random)).

  play(Board) :- chooseSourceCoords(RowSource, ColSource, Board, Piece),
                 chooseDestinyCoords(RowSource, ColSource, Board, Piece, BoardOut),nl,nl,
                 if_then_else(endGame(Board),play(BoardOut),(nl,write('End Game'),nl,checkWinner(PointsXOut,PointsYOut))).

  chooseSourceCoords(RowSource, ColSource,Board,Piece) :-  repeat,
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

  chooseDestinyCoords(RowSource, ColSource, Board,Piece, BoardOut) :- repeat,nl,
                                                                      write('What is the destiny of your piece?'),
                                                                      nl,
                                                                      write('Please enter a position (A...I)'),
                                                                      nl,
                                                                      getChar(ColLetter),
                                                                      once(letterToNumber(ColLetter, ColDestiny)),
                                                                      write('Please enter a position (1...9)'),
                                                                      nl,
                                                                      getCode(RowDestiny),
                                                                      validateDestinyPiece(ColSource,RowSource,ColDestiny, RowDestiny,Board,Piece, BoardOut),
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

validateDestinyPiece(LastCol,LastRow,Ncol,Nrow,Board, Piece, BoardOut) :- if_then_else((Piece=='pieceX1';Piece=='pieceX2'),
                                                                            checkIfCanMoveX(Ncol, Nrow, LastCol,LastRow,Board,Piece,BoardOut),
                                                                            checkIfCanMoveY(Ncol, Nrow, LastCol,LastRow,Board,Piece,BoardOut)).

checkIfIsNotNoPiece(Board,Row,Col,FinalRow,FinalCol,SecondPiece):-repeat,chooseNewJump(Row, Col,FinalRow,FinalCol,'pieceX1'),
                                                        getPiece(Board, FinalRow, FinalCol, SecondPiece),
                                                        SecondPiece \= 'noPiece'.

printBoardAfterJump(Row,Col,Board,Piece) :- setPiece(Board,Row,Col,Piece,BoardOut),
                                           printFinalBoard(BoardOut),nl.


checkIfCanMoveX(Ncol,Nrow,LastCol,LastRow,Board,Piece,BoardOut) :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                          NewPiece \= 'empty',
                                                          if_then_else((NewPiece=='noPiece'),
                                                                    (printBoardAfterJump(Nrow,Ncol,Board,Piece),(chooseNewJump(Nrow, Ncol,Row,Col,Piece,Board,BoardOut2),getPiece(BoardOut2,Row,Col,Piece2),
                                                                if_then_else(Piece2=='noPiece', (checkIfIsNotNoPiece(BoardOut2,Row,Col,FinalRow,FinalCol,SecondPiece),
                                                                                                (if_then_else((SecondPiece=='pieceY1';SecondPiece=='pieceY2'),
                                                                (validateMove(Piece, Col, Row, FinalCol, FinalRow),choosePieceToRemove(BoardOut, BoardOut2, Piece),
                                                                setPiece(BoardOut2,FinalRow,FinalCol,Piece,BoardOut)),(validateMove(SecondPiece, Col, Row, FinalCol, FinalRow),
                                                                setPiece(BoardOut2,Row,Col,'noPiece',BoardOut3), setPiece(BoardOut3,FinalRow,FinalCol,Piece,BoardOut))))),
                                                                                                (if_then_else((Piece2=='pieceY1';Piece2=='pieceY2'),
                                                                                                (validateMove(Piece, Ncol, Nrow, Col, Row),choosePieceToRemove(BoardOut2, BoardOut3, Piece),
                                                                                                setPiece(BoardOut3,Row,Col,Piece,BoardOut)),(validateMove(Piece2, Ncol, Nrow, Col, Row),
                                                                                                setPiece(BoardOut2,Nrow,Ncol,'noPiece',BoardOut3), setPiece(BoardOut3,Row,Col,Piece,BoardOut))))))),
                                                                        (if_then_else((NewPiece=='pieceY1';NewPiece=='pieceY2'), (validateMove(Piece, LastCol, LastRow, Ncol, Nrow),
                                                                        choosePieceToRemove(Board, BoardOut2, Piece),setPiece(BoardOut2,Nrow,Ncol,Piece,BoardOut)),
                                                                        (validateMove(Piece, LastCol, LastRow, Ncol, Nrow),setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                                        setPiece(BoardOut2,LastRow,LastCol,Piece,BoardOut))))).

checkIfCanMoveY(Ncol,Nrow,LastCol,LastRow,Board,Piece,BoardOut) :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                      NewPiece \= 'empty',
                                                      if_then_else((NewPiece=='noPiece'),
                                                                (printBoardAfterJump(Nrow,Ncol,Board,BoardOut2,Piece),(chooseNewJump(Nrow, Ncol,Row,Col,Piece,BoardOut2,BoardOut3),getPiece(BoardOut3,Row,Col,Piece2),
                                                            if_then_else(Piece2=='noPiece', (checkIfIsNotNoPiece(BoardOut3,Row,Col,FinalRow,FinalCol,SecondPiece),
                                                                                                (if_then_else((SecondPiece=='pieceX1';SecondPiece=='pieceX2'),
                                                            (validateMove(Piece, Col, Row, FinalCol, FinalRow),choosePieceToRemove(BoardOut3, BoardOut4, Piece),
                                                            setPiece(BoardOut4,FinalRow,FinalCol,Piece,BoardOut)),(validateMove(SecondPiece, Col, Row, FinalCol, FinalRow),
                                                            setPiece(BoardOut3,Row,Col,'noPiece',BoardOut4), setPiece(BoardOut4,FinalRow,FinalCol,Piece,BoardOut))))),
                                                                                        (if_then_else((Piece2=='pieceX1';Piece2=='pieceX2'),
                                                                                        (validateMove(Piece, Ncol, Nrow, Col, Row),choosePieceToRemove(BoardOut3, BoardOut4, Piece),
                                                                                        setPiece(BoardOut4,Row,Col,Piece,BoardOut)),(validateMove(Piece2, Ncol, Nrow, Col, Row),
                                                                                        setPiece(BoardOut3,Nrow,Ncol,'noPiece',BoardOut4), setPiece(BoardOut4,Row,Col,Piece,BoardOut))))))),
                                                                    (if_then_else((NewPiece=='pieceX1';NewPiece=='pieceX2'), (validateMove(Piece, LastCol, LastRow, Ncol, Nrow),
                                                                    choosePieceToRemove(Board, BoardOut2, Piece),setPiece(BoardOut2,Nrow,Ncol,Piece,BoardOut)),
                                                                    (validateMove(Piece, LastCol, LastRow, Ncol, Nrow),setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                                    setPiece(BoardOut2,LastRow,LastCol,Piece,BoardOut))))).


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


chooseNewJump(LastRow,LastCol,Row,Col,Piece,Board,BoardOut) :- repeat,write('You need jump one more time!'),
                                                    nl,
                                                    write('Please enter a position (A...I)'),
                                                    nl,
                                                    getChar(ColLetter),
                                                    once(letterToNumber(ColLetter, Col)),
                                                    write('Please enter a position (1...9)'),
                                                    nl,
                                                    getCode(Row),
                                                    /*trace,*/
                                                    validateMove(Piece, LastCol, LastRow, Col, Row),
                                                    printBoardAfterJump(Row,Col,Board,BoardOut,Piece).


choosePieceToRemove(Board, BoardOut, Piece) :- repeat, write('What is the piece that you want remove?'),
                                          nl,
                                          write('Please enter a position (A...I)'),
                                          nl,
                                          getChar(ColLetter),
                                          once(letterToNumber(ColLetter, Col)),
                                          write('Please enter a position (1...9)'),
                                          nl,
                                          getCode(Row),
                                          if_then_else((Piece=='pieceX1';Piece=='pieceX2'),
                                          checkIfCanRemoveX(Board, Col, Row, Piece),
                                          checkIfCanRemoveY(Board, Col, Row, Piece)).
                                          setPiece(Board,Row,Col,'noPiece',BoardOut),
                                          printFinalBoard(BoardOut).

checkIfCanRemoveX(Board, Col, Row, Piece) :- getPiece(Board, Row, Col, NewPiece),
                                                NewPiece \= 'empty',
                                                NewPiece \= 'pieceY1',
                                                NewPiece \= 'pieceY2',
                                                NewPiece \= 'noPiece'.

checkIfCanRemoveY(Board, Col, Row, Piece) :- getPiece(Board, Row, Col, NewPiece),
                                                NewPiece \= 'empty',
                                                NewPiece \= 'pieceX1',
                                                NewPiece \= 'pieceX2',
                                                NewPiece \= 'noPiece'.


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
  areaX(Nrow,Ncol):- (Ncol@>1,
                      Ncol@<6,
                      Nrow@>0,
                      Nrow@<5);
                      (Ncol@>0,
                      Ncol@<5,
                      Nrow@>4,
                      Nrow@<9).

  areaY(Nrow,Ncol):- (Ncol@>5,
                      Ncol@<10,
                      Nrow@>1,
                      Nrow@<6);
                      (Ncol@>4,
                      Ncol@<9,
                      Nrow@>5,
                      Nrow@<10).


  saveElements(Board,'pieceX1',List):- setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceX1'),List).
  saveElements(Board,'pieceX2',List):- setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceX2'),List).
  saveElements(Board,'pieceY1',List):- setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceY1'),List).
  saveElements(Board,'pieceY2',List):- setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceY2'),List).

  getNrowNcol([],PointsXIn,PointsXOut,'playerX').
  getNrowNcol([],PointsYIn,PointsYOut,'playerY').
  getNrowNcol([Nrow-Ncol|Rest],PointsXIn,PointsXOut,'playerX'):-
                                                    if_then_else(areaX(Nrow,Ncol),PointsXOut is PointsXIn+3,
                                                                                  PointsXOut is PointsXIn+1),nl,
                                                                                  write(Nrow-Ncol),
                                                                      getNrowNcol(Rest,PointsXIn,PointsXOut,'playerX').
  getNrowNcol([Nrow-Ncol|Rest],PointsYIn,PointsYOut,'playerY'):-
                                                    if_then_else(areaY(Nrow,Ncol),PointsYOut is PointsYIn+3,
                                                                                  PointsYOut is PointsYIn+1),
                                                                      getNrowNcol(Rest,PointsYIn,PointsYOut,'playerY').

  calculatePoints(Board):- saveElements(Board,'pieceX1',List),
                           saveElements(Board,'pieceX2',List2),
                           append(List,List2,FinalListX),
                           getNrowNcol(FinalListX,0,PointsX,'playerX'),
                           saveElements(Board,'pieceY1',List3),
                           saveElements(Board,'pieceY2',List4),
                           append(List3,List4,FinalListY),
                           getNrowNcol(FinalListY,0,PointsY,'playerY'),
                           nl,
                           write('Points of playerX:'), write(PointsX),nl,
                           write('Points of playerY:'), write(PointsY),nl.

  checkWinner(PointsX,PointsY) :- if_then_else(PointsX@>PointsY,write('The winner is PlayerY'),write('The winner is PlayerX')).
