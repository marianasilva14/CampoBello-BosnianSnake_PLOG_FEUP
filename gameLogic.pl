:-use_module(library(lists)).
:-use_module(library(random)).
:-use_module(library(system)).

  play(Board) :- chooseSourceCoords(RowSource, ColSource, Board, Piece),
                 chooseDestinyCoords(RowSource, ColSource, Board, Piece,Area, BoardOut),nl,nl,
                 if_then_else(endGame(Board),play(BoardOut),(nl,write('End Game'),nl,checkWinner(PointsXOut,PointsYOut))).

  chooseSourceCoords(RowSource, ColSource,Board,Piece) :-   mode_game(Curr_mode),
                                                            user_is(Curr_user),
                                                            if_then_else((Curr_mode == 1; Curr_user=='player'),
                                                            (repeat,
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
                                                            validateSourcePiece(ColSource, RowSource,Board,Piece)),
                                                            (listOfValidSourceMoveX(Board,List),length(List,LengthOfList),
                                                                              random(0,LengthOfList,Index),
                                                                              nth0(Index,List,Piece-RowSource-ColSource))),
                                                                              write(List), write(' chosen '), write(Piece), write(RowSource), write(ColSource).

  chooseDestinyCoords(RowSource, ColSource, Board,Piece,Area, BoardOut) :- mode_game(Curr_mode),
                                                                      user_is(Curr_user),

                                                                      if_then_else(areaX1(RowSource,ColSource),Area='areaX1',
                                                                            (if_then_else(areaX2(RowSource,ColSource),Area='areaX2',
                                                                            (if_then_else(areaY1(RowSource,ColSource),Area='areaY1',
                                                                            (if_then_else(areaY2(RowSource,ColSource),Area='areaY2',true))))))),
                                                                      write(Area),
                                                                      if_then_else((Curr_mode == 1; Curr_user=='player'),
                                                                      (repeat,nl,
                                                                      write('What is the destiny of your piece?'),
                                                                      nl,
                                                                      write('Please enter a position (A...I)'),
                                                                      nl,
                                                                      getChar(ColLetter),
                                                                      once(letterToNumber(ColLetter, ColDestiny)),
                                                                      write('Please enter a position (1...9)'),
                                                                      nl,
                                                                      getCode(RowDestiny),
                                                                      validateDestinyPiece(ColSource,RowSource,ColDestiny, RowDestiny,Board,Piece,Area, BoardOut),
                                                                      player(Curr_player),
                                                                      if_then_else(Curr_player == 'playerX', set_player('playerY'),set_player('playerX'))),
                                                                      (listOfValidDestinyMove(List, Piece, RowSource,ColSource),length(List,LengthOfList),
                                                                                        random(0,LengthOfList,Index),
                                                                                        nth0(Index,List,RowDestiny-ColDestiny),
                                                                                        validateDestinyPiece(ColSource,RowSource,ColDestiny,RowDestiny,Board,Piece, BoardOut),
                                                                                        if_then_else(Curr_user=='pc',set_user_is('player'),set_user_is('pc')))),
                                                                                        write(List), write(' chosen '), write(RowDestiny), nl, write(ColDestiny).


  letterToNumber('A',1).
  letterToNumber('B',2).
  letterToNumber('C',3).
  letterToNumber('D',4).
  letterToNumber('E',5).
  letterToNumber('F',6).
  letterToNumber('G',7).
  letterToNumber('H',8).
  letterToNumber('I',9).


  listOfValidSourceMoveX(Board,FinalListX):- setof('pieceX1'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX1'),List),
                                setof('pieceX2'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX2'),List2),
                                append(List,List2,FinalListX).

  listOfValidSourceMoveY(Board,FinalListY):-setof('pieceY1'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX1'),List),
                                setof('pieceY2'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX2'),List2),
                                append(List,List2,FinalListY).

  listOfValidDestinyMove(List,LastRow,LastCol,Area) :-setof(Nrow-Ncol,validateMove(Area,LastCol,LastRow,Ncol,Nrow),List).


  validateSourcePiece(Ncol, Nrow,Board,Piece) :- getPiece(Board, Nrow, Ncol, Piece),
                                                 if_then_else((Piece=='pieceX1';Piece=='pieceX2'),
                                                 (Piece \= 'pieceY1',
                                                 Piece \= 'pieceY2'),
                                                 (Piece \= 'pieceX1',
                                                 Piece \= 'pieceX2')),
                                                 Piece \= 'empty',
                                                 Piece \= 'noPiece'.

validateDestinyPiece(LastCol,LastRow,Ncol,Nrow,Board, Piece,Area,BoardOut) :- if_then_else((Piece=='pieceX1';Piece=='pieceX2'),
                                                                            checkIfCanMoveX(Ncol, Nrow, LastCol,LastRow,Board,Piece,BoardOut,Area),
                                                                            checkIfCanMoveY(Ncol, Nrow, LastCol,LastRow,Board,Piece,BoardOut,Area)).

checkIfIsNotNoPiece(Board,BoardOut,Row,Col,FinalRow,FinalCol,Piece):-repeat,chooseNewJump(Board,BoardOut,Row, Col,FinalRow,FinalCol,Piece),
                                                        getPiece(BoardOut, FinalRow, FinalCol, SecondPiece),
                                                        SecondPiece \= 'noPiece'.

printBoardAfterJump(Row,Col,LastRow,LastCol,Board,BoardOut,Piece) :- setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                                    setPiece(BoardOut2,Row,Col,Piece,BoardOut),
                                                                    printFinalBoard(BoardOut),nl.


checkIfCanMoveX(Ncol,Nrow,LastCol,LastRow,Board,Piece,BoardOut,Area) :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                          if_then_else((NewPiece=='noPiece'),
                                                                    (printBoardAfterJump(Nrow,Ncol,LastRow,LastCol,Board,BoardOut2,Piece),(chooseNewJump(BoardOut2,BoardOut3,Nrow, Ncol,Row,Col,Piece),getPiece(Board,Row,Col,Piece2),
                                                                if_then_else(Piece2=='noPiece', (checkIfIsNotNoPiece(BoardOut3,BoardOut4,Row,Col,FinalRow,FinalCol,SecondPiece),
                                                                                                (if_then_else((SecondPiece=='pieceY1';SecondPiece=='pieceY2',areaPiece(Nrow,Ncol,Area2)),
                                                                (validateMove(Area, Col, Row, FinalCol, FinalRow,BoardOut4),choosePieceToRemove(BoardOut4, BoardOut5, Piece),
                                                                setPiece(BoardOut5,FinalRow,FinalCol,Piece,BoardOut)),(validateMove(Area2, Col, Row, FinalCol, FinalRow,BoardOut4),
                                                                setPiece(BoardOut4,Row,Col,'noPiece',BoardOut5), setPiece(BoardOut5,FinalRow,FinalCol,Piece,BoardOut))))),
                                                                                                (if_then_else((Piece2=='pieceY1';Piece2=='pieceY2',areaPiece(Nrow,Ncol,Area3)),
                                                                                                (validateMove(Area, Ncol, Nrow, Col, Row,BoardOut3),choosePieceToRemove(BoardOut3, BoardOut4, Piece),
                                                                                                setPiece(BoardOut4,Row,Col,Piece,BoardOut)),(validateMove(Area3, Ncol, Nrow, Col, Row,BoardOut),
                                                                                                setPiece(BoardOut3,Nrow,Ncol,'noPiece',BoardOut4), setPiece(BoardOut4,Row,Col,Piece,BoardOut))))))),
                                                                        (if_then_else((NewPiece=='pieceY1';NewPiece=='pieceY2'), (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),
                                                                        choosePieceToRemove(Board, BoardOut2, Piece),setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut3),setPiece(BoardOut3,Nrow,Ncol,Piece,BoardOut)),
                                                                        (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                                        setPiece(BoardOut2,Nrow,Ncol,Piece,BoardOut))))),
                                                                printFinalBoard(BoardOut).

checkIfCanMoveY(Ncol,Nrow,LastCol,LastRow,Board,Piece,BoardOut,Area) :- getPiece(Board, Nrow, Ncol, NewPiece),
                                                            if_then_else((NewPiece=='noPiece'),
                                                                    (printBoardAfterJump(Nrow,Ncol,LastRow,LastCol,Board,BoardOut2,Piece),(chooseNewJump(BoardOut2,BoardOut3,Nrow, Ncol,Row,Col,Piece),getPiece(Board,Row,Col,Piece2),
                                                            if_then_else(Piece2=='noPiece', (checkIfIsNotNoPiece(BoardOut3,BoardOut4,Row,Col,FinalRow,FinalCol,SecondPiece),
                                                                                            (if_then_else((SecondPiece=='pieceY1';SecondPiece=='pieceY2',areaPiece(Nrow,Ncol,Area2)),
                                                (validateMove(Area, Col, Row, FinalCol, FinalRow,BoardOut4),choosePieceToRemove(BoardOut4, BoardOut5, Piece),
                                                setPiece(BoardOut5,FinalRow,FinalCol,Piece,BoardOut)),(validateMove(Area2, Col, Row, FinalCol, FinalRow,BoardOut4),
                                                setPiece(BoardOut4,Row,Col,'noPiece',BoardOut5), setPiece(BoardOut5,FinalRow,FinalCol,Piece,BoardOut))))),
                                                (if_then_else((Piece2=='pieceX1';Piece2=='pieceX2',areaPiece(Nrow,Ncol,Area3)),
                                                (validateMove(Area, Ncol, Nrow, Col, Row,BoardOut3),choosePieceToRemove(BoardOut3, BoardOut4, Piece),
                                                setPiece(BoardOut4,Row,Col,Piece,BoardOut)),(validateMove(Area3, Ncol, Nrow, Col, Row,BoardOut3),
                                                setPiece(BoardOut3,Nrow,Ncol,'noPiece',BoardOut4), setPiece(BoardOut4,Row,Col,Piece,BoardOut))))))),
                                                  (if_then_else((NewPiece=='pieceX1';NewPiece=='pieceX2'), (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),
                                                  choosePieceToRemove(Board, BoardOut2, Piece),setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut3),setPiece(BoardOut3,Nrow,Ncol,Piece,BoardOut)),
                                                  (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                  setPiece(BoardOut2,Nrow,Ncol,Piece,BoardOut))))),
                                                  printFinalBoard(BoardOut).



  validateMove('areaX1',LastCol,LastRow,Ncol,Nrow,Board) :- user_is(Curr_user),
                                                  mode_game(Curr_mode),
                                                  if_then_else((LastCol==5,LastRow==3),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==7,Nrow==5),false,
                                                  (Ncol is LastCol+2,
                                                   Nrow is LastRow+2,
                                                   getPiece(Board,Nrow,Ncol,Piece),
                                                   Piece\='empty'))),true),
                                                   (Ncol is LastCol+2,
                                                    Nrow is LastRow+2,
                                                    getPiece(Board,Nrow,Ncol,Piece),
                                                    Piece\='empty'));
                                                   (Ncol is LastCol,
                                                   Nrow is LastRow+2,
                                                   getPiece(Board,Nrow,Ncol,Piece),
                                                   Piece\='empty');
                                                   (Nrow is LastRow,
                                                   Ncol is LastCol+2,
                                                   getPiece(Board,Nrow,Ncol,Piece),
                                                   Piece\='empty').

  validateMove('areaX2',LastCol,LastRow,Ncol,Nrow,Board) :- user_is(Curr_user),
                                                  mode_game(Curr_mode),
                                                  (Ncol is LastCol+2,
                                                  Nrow is LastRow,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty');
                                                  (Ncol is LastCol,
                                                  Nrow is LastRow+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty');
                                                  if_then_else((LastCol==2,LastRow==5),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==4,Nrow==3),false,
                                                  (Nrow is LastRow-2,
                                                  Ncol is LastCol+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'),true))),
                                                  (Nrow is LastRow-2,
                                                  Ncol is LastCol+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'));
                                                  if_then_else((LastCol==3,LastRow==5),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==5,Nrow==3),false,
                                                  (Nrow is LastRow-2,
                                                  Ncol is LastCol+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'))),true),
                                                  (Nrow is LastRow-2,
                                                  Ncol is LastCol+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty')).


    validateMove('areaY1',LastCol,LastRow,Ncol,Nrow,Board) :-user_is(Curr_user),
                                                  mode_game(Curr_mode),
                                                  if_then_else(Ncol@>9,false,true),
                                                  if_then_else((LastCol==7,LastRow==5),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==5,Nrow==7),false,
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'))),true),
                                                  if_then_else((LastCol==8,LastRow==5),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==6,Nrow==7),false,
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'))),
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'))));
                                                  (Ncol is LastCol,
                                                  Nrow is LastRow+2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty');
                                                  if_then_else((LastCol==7;LastRow==4),true,
                                                  (Nrow is LastRow,
                                                  Ncol is LastCol-2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty')).


    validateMove('areaY2',LastCol,LastRow,Ncol,Nrow,Board) :-
                                                  mode_game(Curr_mode),
                                                  user_is(Curr_user),
                                                  if_then_else(Ncol@>9,false,true),
                                                  if_then_else((LastCol==5,LastRow==8),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==3,Nrow==6),false,
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow-2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty')),
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow-2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'))),
                                                  if_then_else((LastCol==5,LastRow==7),if_then_else((Curr_mode == 1;Curr_user=='player'),
                                                  (if_then_else((Ncol==3,Nrow==5),false,
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow-2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty'))),true),
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow-2,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty')));
                                                  (Ncol is LastCol-2,
                                                  Nrow is LastRow,
                                                  getPiece(Board,Nrow,Ncol,Piece),
                                                  Piece\='empty').


chooseNewJump(Board,BoardOut,LastRow,LastCol,Row,Col,Piece) :-mode_game(Curr_mode),
                                                              user_is(Curr_user),
                                                              if_then_else((Curr_mode == 1; Curr_user=='player'),
                                                    (repeat,write('You need jump one more time!'),
                                                    nl,
                                                    write('Please enter a position (A...I)'),
                                                    nl,
                                                    getChar(ColLetter),
                                                    once(letterToNumber(ColLetter, Col)),
                                                    write('Please enter a position (1...9)'),
                                                    nl,
                                                    getCode(Row)),
                                                    (listOfValidDestinyMove(Board,List, Piece, LastRow,LastCol),length(List,LengthOfList),
                                                                      random(0,LengthOfList,Index),
                                                                      nth0(Index,List,Row-Col))),
                                                    validateMove(Piece, LastCol, LastRow, Col, Row,Board),
                                                    setPiece(Board,Row,Col,Piece,BoardOut2),
                                                    setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut),
                                                    printFinalBoard(BoardOut).



choosePieceToRemove(Board, BoardOut, Piece) :-mode_game(Curr_mode),
                                              user_is(Curr_user),
                                              if_then_else((Curr_mode == 1; Curr_user=='player'),
                                          (repeat,nl, write('What is the piece that you want remove?'),
                                          nl,
                                          write('Please enter a position (A...I)'),
                                          nl,
                                          getChar(ColLetter),
                                          once(letterToNumber(ColLetter, Col)),
                                          write('Please enter a position (1...9)'),
                                          nl,
                                          getCode(Row),
                                          if_then_else((Piece=='pieceX1';Piece=='pieceX2'),
                                          checkIfCanRemoveX(Board, Col, Row),
                                          checkIfCanRemoveY(Board, Col, Row))),
                                          (listOfPiecesThatCanRemoveX(Board,List),length(List,LengthOfList),
                                                            random(0,LengthOfList,Index),
                                                            nth0(Index,List,Row-Col))),
                                          setPiece(Board,Row,Col,'noPiece',BoardOut).


listOfPiecesThatCanRemoveX(Board,List):-setof(Nrow-Ncol,checkIfCanRemoveX(Board,Ncol,Nrow),List).
listOfPiecesThatCanRemoveY(Board,List):-setof(Nrow-Ncol,checkIfCanRemoveY(Board,Ncol,Nrow),List).

checkIfCanRemoveX(Board, Col, Row) :- getPiece(Board, Row, Col, NewPiece),
                                                NewPiece \= 'empty',
                                                NewPiece \= 'pieceY1',
                                                NewPiece \= 'pieceY2',
                                                NewPiece \= 'noPiece'.

checkIfCanRemoveY(Board, Col, Row) :- getPiece(Board, Row, Col, NewPiece),
                                                NewPiece \= 'empty',
                                                NewPiece \= 'pieceX1',
                                                NewPiece \= 'pieceX2',
                                                NewPiece \= 'noPiece'.


  getPiece(Board, Nrow, Ncol, Piece) :-  getElement(Board,Nrow,Ncol,Piece).

  setPiece(BoardIn, Nrow, Ncol, Piece, BoardOut) :- setOnRow(Nrow, BoardIn, Ncol, Piece, BoardOut).

  setOnRow(1, [Row|Remainder], Ncol, Piece, [Newrow|Remainder]):- setOnCol(Ncol, Row, Piece, Newrow).
  setOnRow(Pos, [Row|Remainder], Ncol, Piece, [Row|Newremainder]):- Pos @> 1,
                                                                    Next is Pos-1,
                                                                    setOnRow(Next, Remainder, Ncol, Piece, Newremainder).

  setOnCol(1, [_|Remainder], Piece, [Piece|Remainder]).
  setOnCol(Pos, [X|Remainder], Piece, [X|Newremainder]):- Pos @> 1,
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

  areaPiece(Nrow,Ncol,Area):-if_then_else(areaX1(Nrow,Ncol, Area),Area=='areaX1',
                                (if_then_else(areaX2(Nrow,Ncol),Area=='areaX2',
                                (if_then_else(areaY1(Nrow,Ncol),Area=='areaY1',
                                (if_then_else(areaY2(Nrow,Ncol),Area=='areaY2',true))))))).

  areaX1(Nrow,Ncol):- (Ncol@>1,
                      Ncol@<6,
                      Nrow@>0,
                      Nrow@<5).
  areaX2(Nrow,Ncol):- (Ncol@>0,
                      Ncol@<5,
                      Nrow@>4,
                      Nrow@<9).
  areaY1(Nrow,Ncol):- (Ncol@>5,
                      Ncol@<10,
                      Nrow@>1,
                      Nrow@<6).
  areaY2(Nrow,Ncol):-(Ncol@>4,
                      Ncol@<9,
                      Nrow@>5,
                      Nrow@<10).
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
