:-use_module(library(lists)).
:-use_module(library(random)).
:-use_module(library(system)).

  play(Board) :- mode_game(Curr_mode),
                 user_is(Curr_user),
                 chooseSourceCoords(RowSource, ColSource, Board, Piece),
                 chooseDestinyCoords(RowSource, ColSource, Board, Piece,Area, BoardOut),nl,nl,
                 if_then_else((Curr_mode==2,Curr_user==pcX),set_user_is('player'),(set_user_is('pcX'),
                 if_then_else((Curr_mode==3,Curr_user==pcX),set_user_is('pcY'),set_user_is('pcX')))),
                 if_then_else(endGame(BoardOut),play(BoardOut),(nl,write('End Game'),nl,checkWinner(BoardOut,PointsXOut,PointsYOut))).

  chooseSourceCoords(RowSource, ColSource,Board,Piece) :-   mode_game(Curr_mode),
                                                            user_is(Curr_user),
                                                            if_then_else((Curr_mode == 1; Curr_user=='player'),
                                                            (repeat,
                                                            player(Curr_player),nl,
                                                            write('It is the turn of '),
                                                            if_then_else(Curr_mode==1,write(Curr_player),write(Curr_user)),
                                                            nl,nl,
                                                            write('Please choose the piece that you want move:'), nl,
                                                            write('Please enter a position (A...I)'),nl,
                                                            getChar(ColLetter),
                                                            once(letterToNumber(ColLetter, ColSource)),
                                                            write('Please enter a position (1...9)'),
                                                            nl,
                                                            getCode(RowSource),

                                                            validateSourcePiece(ColSource, RowSource,Board,Piece)),
                                                            (if_then_else((Curr_user=='pcX'),
                                                            listOfPiecesThatHasPossibleMoveX(FinalList,Board),
                                                            listOfPiecesThatHasPossibleMoveY(FinalList,Board)),
                                                            length(FinalList,LengthOfList),
                                                                              random(0,LengthOfList,Index),
                                                                              nth0(Index,FinalList,Piece-RowSource-ColSource))),
                                                            write(' chosen '), write(Piece),write(' ,Row: '),write(RowSource),write(' ,Col: '),
                                                            numberToLetter(ColSource,Letter),write(Letter).

  chooseDestinyCoords(RowSource, ColSource, Board,Piece,Area, BoardOut) :- mode_game(Curr_mode),
                                                                      user_is(Curr_user),
                                                                      if_then_else(areaX1(RowSource,ColSource),Area='areaX1',
                                                                            (if_then_else(areaX2(RowSource,ColSource),Area='areaX2',
                                                                            (if_then_else(areaY1(RowSource,ColSource),Area='areaY1',
                                                                            (if_then_else(areaY2(RowSource,ColSource),Area='areaY2',true))))))),
                                                                      write('  Area of the Piece:'),write(Area),nl,
                                                                      listOfValidDestinyMove(List,RowSource,ColSource,Area,Board),length(List,LengthOfList),
                                                                      write(LengthOfList),nl,write(List),
                                                                      if_then_else(LengthOfList\=0,
                                                                      (if_then_else((Curr_mode == 1; Curr_user=='player'),
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
                                                                          write(ColDestiny),
                                                                      validateDestinyPiece(ColSource,RowSource,ColDestiny, RowDestiny,Board,Piece,Area, BoardOut),
                                                                      player(Curr_player),
                                                                      if_then_else(Curr_player == 'playerX', set_player('playerY'),set_player('playerX'))),
                                                                      (listOfValidDestinyMove(List, RowSource,ColSource,Area,Board),write(List),trace,length(List,LengthOfList),
                                                                                        random(0,LengthOfList,Index),
                                                                                        nth0(Index,List,RowDestiny-ColDestiny),
                                                                                        validateDestinyPiece(ColSource,RowSource,ColDestiny,RowDestiny,Board,Piece, Area,BoardOut)))),
                                                                                        if_then_else(Curr_player == 'playerX', set_player('playerY'),set_player('playerX'))),nl,
                                                                                        write('List Of Possible Moves: '),
                                                                                        write(List), write(' chosen '), write(' Row: '),write(RowDestiny), write(' Col: '),
                                                                                        numberToLetter(ColDestiny,Letter),write(Letter),nl.


  letterToNumber('A',1).
  letterToNumber('B',2).
  letterToNumber('C',3).
  letterToNumber('D',4).
  letterToNumber('E',5).
  letterToNumber('F',6).
  letterToNumber('G',7).
  letterToNumber('H',8).
  letterToNumber('I',9).

  numberToLetter(1,'A').
  numberToLetter(2,'B').
  numberToLetter(3,'C').
  numberToLetter(4,'D').
  numberToLetter(5,'E').
  numberToLetter(6,'F').
  numberToLetter(7,'G').
  numberToLetter(8,'H').
  numberToLetter(9,'I').

  listOfValidSourceMoveX(Board,FinalListX):- setof('pieceX1'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX1'),List),
                                setof('pieceX2'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX2'),List2),
                                append(List,List2,FinalListX).

  listOfValidSourceMoveY(Board,FinalListY):-setof('pieceY1'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX1'),List),
                                setof('pieceY2'-Nrow-Ncol,validateSourcePiece(Ncol,Nrow,Board,'pieceX2'),List2),
                                append(List,List2,FinalListY).

  listOfPiecesThatHasPossibleMoveX(FinalList,Board):-
                                listOfValidSourceMoveX(Board,ListOfDestiny),
                                write(ListOfDestiny),
                                scrollList(ListOfDestiny,FinalList,Board),
                                write(FinalList).

                                scrollList([],_,_).
                                scrollList([Piece-Nrow-Ncol|Rest], FinalList,Board):-
                                  if_then_else(areaX1(Nrow,Ncol),Area='areaX1',
                                        (if_then_else(areaX2(Nrow,Ncol),Area='areaX2',
                                        (if_then_else(areaY1(Nrow,Ncol),Area='areaY1',
                                        (if_then_else(areaY2(Nrow,Ncol),Area='areaY2',true))))))),
                                  if_then_else(
                                    % IF
                                    (validateMovePC(Area,Ncol,Nrow,Col,Row,Board)),
                                    % THEN
                                    (scrollList(Rest, List_Temp,Board), append(List_Temp, [Piece-Nrow-Ncol], FinalList)),
                                    % ELSE
                                    scrollList(Rest, FinalList,Board)).

  listOfPiecesThatHasPossibleMoveY(FinalList,Board):-
                                listOfValidSourceMoveY(Board,ListOfDestiny),
                                write(ListOfDestiny),
                                scrollList(ListOfDestiny,FinalList,Board),
                                write(FinalList).

                                scrollList([],_,_).
                                scrollList([Piece-Nrow-Ncol|Rest], FinalList,Board):-
                                  if_then_else(areaX1(Nrow,Ncol),Area='areaX1',
                                        (if_then_else(areaX2(Nrow,Ncol),Area='areaX2',
                                        (if_then_else(areaY1(Nrow,Ncol),Area='areaY1',
                                        (if_then_else(areaY2(Nrow,Ncol),Area='areaY2',true))))))),
                                  if_then_else(
                                    % IF
                                    (validateMovePC(Area,Ncol,Nrow,Col,Row,Board)),
                                    % THEN
                                    (scrollList(Rest, List_Temp,Board), append(List_Temp, [Piece-Nrow-Ncol], FinalList)),
                                    % ELSE
                                    scrollList(Rest, FinalList,Board)).

  listOfValidDestinyMove(List,LastRow,LastCol,Area,Board) :-
          if_then_else(setof(Nrow-Ncol,validateMovePC(Area,LastCol,LastRow,Ncol,Nrow,Board),List),true,
                findall(Nrow-Ncol,validateMovePC(Area,LastCol,LastRow,Ncol,Nrow,Board),List)).


  validateSourcePiece(Ncol, Nrow,Board,Piece) :- getPiece(Board, Nrow, Ncol, Piece),
                                                  user_is(Curr_user),
                                                  player(Curr_player),
                                                  mode_game(Curr_mode),
                                                  if_then_else(Curr_mode==1,if_then_else(Curr_player=='playerX',
                                                 (Piece \= 'pieceY1',
                                                 Piece \= 'pieceY2'),
                                                 (Piece \= 'pieceX1',
                                                 Piece \= 'pieceX2')),
                                                 if_then_else(Curr_user='pcX',
                                                 (Piece \= 'pieceY1',
                                                 Piece \= 'pieceY2'),
                                                 (Piece \= 'pieceX1',
                                                 Piece \= 'pieceX2'))),
                                                 Piece \= 'empty',
                                                 Piece \= 'noPiece'.

validateDestinyPiece(LastCol,LastRow,Ncol,Nrow,Board, Piece,Area,BoardOut) :- if_then_else((Piece=='pieceX1';Piece=='pieceX2'),
                                                                            checkIfCanMoveX(Ncol, Nrow, LastCol,LastRow,Board,Piece,BoardOut,Area),
                                                                            checkIfCanMoveY(Ncol, Nrow, LastCol,LastRow,Board,Piece,BoardOut,Area)).

checkIfIsNotNoPiece(Board,BoardOut,LastColPiece,LastRowPiece,Row,Col,FinalRow,FinalCol,Piece,Area,NewContinue):-repeat,trace,
                                                        chooseNewJump(Board,BoardOut,LastColPiece,LastRowPiece,Row, Col,FinalRow,FinalCol,Piece,Area,NewContinue),
                                                        if_then_else(NewContinue\=1,
                                                        (getPiece(BoardOut, FinalRow, FinalCol, SecondPiece),
                                                        SecondPiece \= 'noPiece'),true).

printBoardAfterJump(Row,Col,LastRow,LastCol,Board,BoardOut,Piece) :- setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                                    setPiece(BoardOut2,Row,Col,Piece,BoardOut),
                                                                    printFinalBoard(BoardOut),nl.

checkIfIsNotRedo(LastColPiece,LastRowPiece,ColPiece,RowPiece):-LastColPiece==ColPiece,
                                                                LastRowPiece==RowPiece.

checkIfCanMoveX(Ncol,Nrow,LastCol,LastRow,Board,Piece,BoardOut,Area) :-
                                                          validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),
                                                          getPiece(Board, Nrow, Ncol, NewPiece),
                                                          if_then_else((NewPiece=='noPiece'),
                                                                    (printBoardAfterJump(Nrow,Ncol,LastRow,LastCol,Board,BoardOut2,Piece),(trace,chooseNewJump(BoardOut2,BoardOut3,LastCol,LastRow,Nrow, Ncol,Row,Col,Piece,Area,Continue),
                                                                    if_then_else(Continue\=1,(getPiece(Board,Row,Col,Piece2),
                                                                    if_then_else(areaX1(Row,Col),Area2='areaX1',
                                                                          (if_then_else(areaX2(Row,Col),Area2='areaX2',
                                                                          (if_then_else(areaY1(Row,Col),Area2='areaY1',
                                                                          (if_then_else(areaY2(Row,Col),Area2='areaY2',Area2=Area))))))), write(Area2),nl,
                                                                if_then_else(Piece2=='noPiece',(checkIfIsNotNoPiece(BoardOut3,BoardOut4,Ncol,Nrow,Row,Col,FinalRow,FinalCol,SecondPiece,Area2,NewContinue),
                                                                if_then_else(NewContinue\=1,
                                                                (if_then_else(areaX1(FinalRow,FinalCol),Area3='areaX1',
                                                                      (if_then_else(areaX2(FinalRow,FinalCol),Area3='areaX2',
                                                                      (if_then_else(areaY1(FinalRow,FinalCol),Area3='areaY1',
                                                                      (if_then_else(areaY2(FinalRow,FinalCol),Area3='areaY2',Area3=Area2))))))),    write(Area3),nl,
                                                                                                (if_then_else((SecondPiece=='pieceY1';SecondPiece=='pieceY2'),
                                                                (choosePieceToRemove(BoardOut4, BoardOut5, Piece),
                                                                setPiece(BoardOut5,FinalRow,FinalCol,Piece,BoardOut6), setPiece(BoardOut6,FinalRow,FinalCol,'noPiece',BoardOut)),(validateMove(Area3, Col, Row, FinalCol, FinalRow,BoardOut4),
                                                                setPiece(BoardOut4,FinalRow,FinalCol,Piece,BoardOut))))),duplicate(BoardOut4,BoardOut))),
                                                                                                (if_then_else((Piece2=='pieceY1';Piece2=='pieceY2'),
                                                                                                (choosePieceToRemove(BoardOut3, BoardOut4, Piece),
                                                                                                setPiece(BoardOut4,Row,Col,Piece,BoardOut)),(setPiece(BoardOut3,Row,Col,Piece,BoardOut)))))),duplicate(BoardOut3,BoardOut)))),
                                                                        (if_then_else((NewPiece=='pieceY1';NewPiece=='pieceY2'), (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),
                                                                        choosePieceToRemove(Board, BoardOut2, Piece),setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut3),setPiece(BoardOut3,Nrow,Ncol,Piece,BoardOut)),
                                                                        (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                                                                        setPiece(BoardOut2,Nrow,Ncol,Piece,BoardOut))))),
                                                                printFinalBoard(BoardOut).

checkIfCanMoveY(Ncol,Nrow,LastCol,LastRow,Board,Piece,BoardOut,Area) :-
  validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),
  getPiece(Board, Nrow, Ncol, NewPiece),
  if_then_else((NewPiece=='noPiece'),
            (printBoardAfterJump(Nrow,Ncol,LastRow,LastCol,Board,BoardOut2,Piece),(trace,chooseNewJump(BoardOut2,BoardOut3,LastCol,LastRow,Nrow, Ncol,Row,Col,Piece,Area,Continue),
            if_then_else(Continue\=1,(getPiece(Board,Row,Col,Piece2),
            if_then_else(areaX1(Row,Col),Area2='areaX1',
                  (if_then_else(areaX2(Row,Col),Area2='areaX2',
                  (if_then_else(areaY1(Row,Col),Area2='areaY1',
                  (if_then_else(areaY2(Row,Col),Area2='areaY2',Area2=Area))))))), write('CHECK AREA: '),write(Area2),nl,
        if_then_else(Piece2=='noPiece',(checkIfIsNotNoPiece(BoardOut3,BoardOut4,Ncol,Nrow,Row,Col,FinalRow,FinalCol,SecondPiece,Area2,NewContinue),
        if_then_else(NewContinue\=1,
        (if_then_else(areaX1(FinalRow,FinalCol),Area3='areaX1',
              (if_then_else(areaX2(FinalRow,FinalCol),Area3='areaX2',
              (if_then_else(areaY1(FinalRow,FinalCol),Area3='areaY1',
              (if_then_else(areaY2(FinalRow,FinalCol),Area3='areaY2',Area3=Area2))))))),    write(Area3),nl,
                                        (if_then_else((SecondPiece=='pieceX1';SecondPiece=='pieceX2'),
        (choosePieceToRemove(BoardOut4, BoardOut5, Piece),
        setPiece(BoardOut5,FinalRow,FinalCol,Piece,BoardOut6), setPiece(BoardOut6,FinalRow,FinalCol,'noPiece',BoardOut)),(validateMove(Area3, Col, Row, FinalCol, FinalRow,BoardOut4),
        setPiece(BoardOut4,FinalRow,FinalCol,Piece,BoardOut))))),duplicate(BoardOut3,BoardOut))),
                                        (if_then_else((Piece2=='pieceX1';Piece2=='pieceX2'),
                                        (choosePieceToRemove(BoardOut3, BoardOut4, Piece),
                                        setPiece(BoardOut4,Row,Col,Piece,BoardOut)),(setPiece(BoardOut3,Row,Col,Piece,BoardOut)))))),duplicate(BoardOut2,BoardOut)))),
                (if_then_else((NewPiece=='pieceX1';NewPiece=='pieceX2'), (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),
                choosePieceToRemove(Board, BoardOut2, Piece),setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut3),setPiece(BoardOut3,Nrow,Ncol,Piece,BoardOut)),
                (validateMove(Area, LastCol, LastRow, Ncol, Nrow,Board),setPiece(Board,LastRow,LastCol,'noPiece',BoardOut2),
                setPiece(BoardOut2,Nrow,Ncol,Piece,BoardOut))))),
        printFinalBoard(BoardOut).
chooseNewJump(Board,BoardOut,LastColPiece,LastRowPiece,LastRow,LastCol,Row,Col,Piece,Area,Continue) :-
                                                  write('ESTA AREA: '), write(Area),
                                                  if_then_else(areaX1(LastRow,LastCol),AreaDestiny='areaX1',
                                                        (if_then_else(areaX2(LastRow,LastCol),AreaDestiny='areaX2',
                                                        (if_then_else(areaY1(LastRow,LastCol),AreaDestiny='areaY1',
                                                        (if_then_else(areaY2(LastRow,LastCol),AreaDestiny='areaY2',AreaDestiny=Area2))))))),
                                                              mode_game(Curr_mode),
                                                              user_is(Curr_user),
                                                              listOfValidDestinyMove(List,LastRow,LastCol,AreaDestiny,Board),length(List,LengthOfList),
                                                              write(LengthOfList),nl,
                                                              if_then_else(LengthOfList\=0,
                                                              if_then_else((Curr_mode == 1; Curr_user=='player'),
                                                    (repeat,write('You need jump one more time!'),
                                                    nl,
                                                    write('Please enter a position (A...I)'),
                                                    nl,
                                                    getChar(ColLetter),
                                                    once(letterToNumber(ColLetter, Col)),
                                                    write('Please enter a position (1...9)'),
                                                    nl,
                                                    getCode(Row),
                                                    if_then_else(checkIfIsNotRedo(LastColPiece,LastRowPiece,Col,Row),
                                                    if_then_else(LengthOfList==1,(write('Cant move to this Piece'),
                                                    Continue is 1,setPiece(Board,LastRowPiece,LastColPiece,Piece,BoardOut2),
                                                    getPiece(Board,Row,Col,PieceChoosen),setPiece(BoardOut2,Row,Col,PieceChoosen,BoardOut)),
                                                    (Continue is 0,write('entrei'),
                                                    chooseNewJump(Board,BoardOut,LastColPiece,LastRowPiece,LastRow,LastCol,Row,Col,Piece,Area,Continue),
                                                    validateMove(AreaDestiny, LastCol, LastRow, Col, Row,Board),
                                                    setPiece(Board,Row,Col,Piece,BoardOut2),
                                                    setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut),
                                                    printFinalBoard(BoardOut))),
                                                    (Continue is 0,
                                                    validateMove(AreaDestiny, LastCol, LastRow, Col, Row,Board),
                                                    setPiece(Board,Row,Col,Piece,BoardOut2),
                                                    setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut),
                                                    (nl,write('List Of Possible Moves: '),write(List),
                                                    write(' Row: '),write(Row),write('  Col: '),write(Col),
                                                    printFinalBoard(BoardOut))))),
                                                    (nl,write('Row: '),write(LastRow),write('  Col: '),write(LastCol),nl,write(AreaDestiny),
                                                    nl,write('Lista: '),write(List),
                                                                      random(0,LengthOfList,Index),
                                                                      nth0(Index,List,Row-Col),
                                                                      setPiece(Board,Row,Col,Piece,BoardOut2),
                                                                      setPiece(BoardOut2,LastRow,LastCol,'noPiece',BoardOut),
                                                                      nl,write('List Of Possible Moves: '),write(List),
                                                                      write(' Row: '),write(Row),write('  Col: '),write(Col),
                                                                      printFinalBoard(BoardOut))),
                                                    (write('Without Possible Moves!'),
                                                    duplicate(Board,BoardOut),
                                                    printFinalBoard(BoardOut))).




choosePieceToRemove(Board, BoardOut, Piece) :-mode_game(Curr_mode),
                                              user_is(Curr_user),
                                              player(Curr_player),
                                              if_then_else((Curr_mode == 1; Curr_user == 'player'),
                                          (repeat,nl, write('What is the piece that you want remove?'),
                                          nl,
                                          write('Please enter a position (A...I)'),
                                          nl,
                                          getChar(ColLetter),
                                          once(letterToNumber(ColLetter, Col)),
                                          write('Please enter a position (1...9)'),
                                          nl,
                                          getCode(Row),
                                          if_then_else(Curr_mode==1,
                                          if_then_else(Curr_player=='playerX',
                                          checkIfCanRemoveX(Board, Col, Row),
                                          checkIfCanRemoveY(Board, Col, Row)),
                                          if_then_else(Curr_user=='pcX',
                                          checkIfCanRemoveX(Board, Col, Row),
                                          checkIfCanRemoveY(Board, Col, Row)))),
                                          (if_then_else(Curr_user=='pcX',
                                          listOfPiecesThatCanRemoveX(Board,List),
                                          listOfPiecesThatCanRemoveX(Board,List)),
                                          length(List,LengthOfList),
                                                            random(0,LengthOfList,Index),
                                                            nth0(Index,List,Row-Col))),
                                          setPiece(Board,Row,Col,'noPiece',BoardOut).


listOfPiecesThatCanRemoveX(Board,List):-if_then_else(setof(Nrow-Ncol,checkIfCanRemoveX(Board,Ncol,Nrow),List),true,
                                                      findall(Nrow-Ncol,checkIfCanRemoveX(Board,Ncol,Nrow),List)).

listOfPiecesThatCanRemoveY(Board,List):-if_then_else(setof(Nrow-Ncol,checkIfCanRemoveY(Board,Ncol,Nrow),List),true,
                                                      findall(Nrow-Ncol,checkIfCanRemoveY(Board,Ncol,Nrow),List)).

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

  endGame(Board) :- mode_game(Curr_mode),
                    user_is(Curr_user),
                    player(Curr_player),
                    if_then_else(((Curr_mode == 1,Curr_player=='playerX');(Curr_mode == 2, Curr_user=='pcX');(Curr_mode == 3, Curr_user=='pcX')),
                    (checkPieces('pieceX1',Board),checkPieces('pieceX2',Board),
                    checkMoves('pieceX1',Board),checkMoves('pieceX2',Board)),
                        (checkPieces('pieceY1',Board),checkPieces('pieceY2',Board),
                        checkMoves('pieceY1',Board),checkMoves('pieceY2',Board))).

  areaPiece(Nrow,Ncol,Area):-if_then_else(areaX1(Nrow,Ncol),Area=='areaX1',
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


  saveElements(Board,'pieceX1',List):- if_then_else(setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceX1'),List),
                                            true,findall(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceX1'),List)).
  saveElements(Board,'pieceX2',List):- if_then_else(setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceX2'),List),
                                            true,findall(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceX2'),List)).
  saveElements(Board,'pieceY1',List):- if_then_else(setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceY1'),List),
                                            true,findall(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceY1'),List)).
  saveElements(Board,'pieceY2',List):- if_then_else(setof(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceY2'),List),
                                            true,findall(Nrow-Ncol,getElement(Board,Nrow,Ncol,'pieceY2'),List)).

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

  calculatePoints(Board,PointsX,PointsY):- saveElements(Board,'pieceX1',List),
                           saveElements(Board,'pieceX2',List2),
                           append(List,List2,FinalListX),
                           write(FinalListX),
                           getNrowNcol(FinalListX,0,PointsX,'playerX'),
                           length(FinalListX,LengthOfFinalListX),
                           if_then_else(LengthOfFinalListX==0,PointsX is 0,true),
                           write(PointsX),
                           saveElements(Board,'pieceY1',List3),
                           saveElements(Board,'pieceY2',List4),
                           append(List3,List4,FinalListY),
                           getNrowNcol(FinalListY,0,PointsY,'playerY'),
                           length(FinalListY,LengthOfFinalListY),
                           if_then_else(LengthOfFinalListY==0,PointsY is 0,true),
                           nl,
                           write('Points of playerX:'), write(PointsX),nl,
                           write('Points of playerY:'), write(PointsY),nl.

  checkWinner(Board,PointsX,PointsY) :- trace,calculatePoints(Board,PointsX,PointsY),
                  if_then_else(PointsX@>PointsY,write('The winner is PlayerY'),write('The winner is PlayerX')).
