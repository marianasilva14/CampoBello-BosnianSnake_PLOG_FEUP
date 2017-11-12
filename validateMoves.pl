validateMove('areaX1',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else(((LastCol==5,LastRow==3);(LastCol==5,LastRow==4);(LastCol==5,LastRow==2)),
                                                              (Nrow is LastRow+2,
                                                              Ncol is LastCol),
                                                              ((Ncol is LastCol+2,
                                                              Nrow is LastRow+2,
                                                              getPiece(Board,Nrow,Ncol,Piece),
                                                              Piece\='empty');
                                                              (Nrow is LastRow,
                                                              Ncol is LastCol+2,
                                                              getPiece(Board,Nrow,Ncol,Piece),
                                                              Piece\='empty');
                                                              (Nrow is LastRow+2,
                                                              Ncol is LastCol,
                                                              getPiece(Board,Nrow,Ncol,Piece),
                                                              Piece\='empty'))),
                                                              if_then_else((LastCol==4,LastRow==3),
                                                                  (Nrow is LastRow+2,
                                                                  Ncol is LastCol+2),true).

validateMove('areaX2',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else((LastCol==2,LastRow==5),
                                                              (Nrow is LastRow+2,
                                                              Ncol is LastCol;
                                                              (Nrow is LastRow,
                                                              Ncol is LastCol+2)),
                                                              ((Nrow is LastRow-2,
                                                              Ncol is LastCol+2,
                                                              getPiece(Board,Nrow,Ncol,Piece),
                                                              Piece\='empty');
                                                              (Nrow is LastRow,
                                                              Ncol is LastCol+2,
                                                              getPiece(Board,Nrow,Ncol,Piece),
                                                              Piece\='empty');
                                                              (Nrow is LastRow+2,
                                                              Ncol is LastCol,
                                                              getPiece(Board,Nrow,Ncol,Piece),
                                                              Piece\='empty'))),

                                                              if_then_else((LastCol==3,LastRow==5),
                                                              (Nrow is LastRow,
                                                              Ncol is LastCol+2),true),

                                                              if_then_else((LastCol==3,LastRow==6),
                                                              (Nrow is LastRow-2,
                                                              Ncol is LastCol+2),true).

  validateMove('areaY1',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else(((LastCol==7,LastRow==5);(LastCol==8,LastRow==5);(LastCol==6,LastRow==5)),
                                                                (Ncol is LastCol-2,
                                                                Nrow is LastRow),
                                                                ((Ncol is LastCol-2,
                                                                Nrow is LastRow+2,
                                                                getPiece(Board,Nrow,Ncol,Piece),
                                                                Piece\='empty');
                                                                (Ncol is LastCol,
                                                                Nrow is LastRow+2,
                                                                getPiece(Board,Nrow,Ncol,Piece),
                                                                Piece\='empty');
                                                                (Ncol is LastCol-2,
                                                                Nrow is LastRow,
                                                                getPiece(Board,Nrow,Ncol,Piece),
                                                                Piece\='empty'))).


  validateMove('areaY2',LastCol,LastRow,Ncol,Nrow,Board) :-  if_then_else(((LastCol==5,LastRow==8);(LastCol==5,LastRow==7);(LastCol==5,LastRow==6)),
                                                                (Ncol is LastCol,
                                                                Nrow is LastRow-2),
                                                                ((Ncol is LastCol-2,
                                                                Nrow is LastRow-2,
                                                                getPiece(Board,Nrow,Ncol,Piece),
                                                                Piece\='empty');
                                                                (Ncol is LastCol-2,
                                                                Nrow is LastRow,
                                                                getPiece(Board,Nrow,Ncol,Piece),
                                                                Piece\='empty');
                                                                (Ncol is LastCol,
                                                                Nrow is LastRow-2,
                                                                getPiece(Board,Nrow,Ncol,Piece),
                                                                Piece\='empty'))),

                                                                if_then_else((LastCol==6,LastRow==5),
                                                                      (Ncol is LastCol-2,
                                                                      Nrow is LastRow),true).
