
play(Board) :- chooseSourceCoords(RowSource, ColSource, Board, TypePiece),
chooseDestinyCoords(RowSource, ColSource, RowDestiny, ColDestiny, Board, TypePiece).

chooseSourceCoords(RowSource, ColSource,Board,TypePiece) :- nl, write('Please choose the piece that you want move:'), nl,
                                                            write('Please enter a position (A...I)'),nl,
                                                            getChar(ColLetter),
                                                            letterToNumber(ColLetter, ColSource),
                                                            write('Please enter a position (1...9)'),
                                                            nl,
                                                            getCode(RowSource),
                                                            validateSourcePiece(ColSource, RowSource,Board,TypePiece).


chooseDestinyCoords(RowSource, ColSource, RowDestiny, ColDestiny,Board,TypePiece) :- write('What is the position of Piece that you want move?'),
                                                                                     nl,
                                                                                     write('Please enter a position (A...I)'),
                                                                                     nl,
                                                                                     getChar(ColLetter),
                                                                                     letterToNumber(ColLetter, ColDestiny),
                                                                                     write('Please enter a position (1...9)'),
                                                                                     nl,
                                                                                     getCode(RowDestiny),
                                                                                     validateDestinyPiece(ColSource,RowSource,ColDestiny, RowDestiny,Board,TypePiece).


letterToNumber('A',1).
letterToNumber('B',2).
letterToNumber('C',3).
letterToNumber('D',4).
letterToNumber('E',5).
letterToNumber('F',6).
letterToNumber('G',7).
letterToNumber('H',8).
letterToNumber('I',9).

validateSourcePiece(Ncol, Nrow,Board,Piece) :- getPiece(Board, Nrow, Ncol, Piece),
                                                 Piece \= 'empty',
                                                 Piece \= 'N'.

validateDestinyPiece(LastCol,LastRow,Ncol,Nrow,Board, TypePiece) :- validateMove(TypePiece, LastCol, LastRow, Ncol, Nrow),
                                                                    setPiece(Board,Nrow,Ncol,Piece,BoardOut).

validateMove('X1', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol+2,
                                                 Nrow is LastRow+2);
                                                 (Ncol is LastCol,
                                                 Nrow is LastRow+2);
                                                 (Nrow is LastRow,
                                                 Ncol is LastCol+2).

validateMove('X2', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol+2,
                                                Nrow is LastRow);
                                                (Ncol is LastCol,
                                                Nrow is LastRow+2);
                                                (Nrow is LastRow-2,
                                                Ncol is LastCol+2).

validateMove('Y1', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol-2,
                                                Nrow is LastRow+2);
                                                (Ncol is LastCol+2,
                                                Nrow is LastRow+2);
                                                (Nrow is LastRow,
                                                Ncol is LastCol-2).

validateMove('Y2', LastCol,LastRow,Ncol,Nrow) :- (Ncol is LastCol-2,
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

setOnRow(Pos, [Row|Remainder], NCol, Piece, [Row|Newremainder]):- Pos > 1,
                                                                  Next is Pos-1,
                                                                  setOnRow(Next, Remainder, Ncol, Piece, Newrow).

setOnCol(1, [_|Remainder], Piece, [Piece|Remainder]).

setOnCol(Pos, [X|Remainder], Piece, [X|Newremainder]):- Pos > 1,
                                                        Next is Pos-1,
                                                        setOnCol(Next, Remainder, Piece, Newremainder).
