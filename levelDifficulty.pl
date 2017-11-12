
evaluateBoards(Board,Board2,Row,Col,LastRow,LastCol,BestCol,BestRow):-user_is(Curr_user),
      if_then_else(Curr_user=='pcX',
      (saveElements(Board,'pieceX1',List),
      saveElements(Board,'pieceX2',List2),
      append(List,List2,FinalList),
      getNrowNcol(FinalList,0,Points,'playerX'),

      saveElements(Board2,'pieceX1',ListBoard2),
      saveElements(Board2,'pieceX2',ListBoard2_2),
    append(ListBoard2,ListBoard2_2,FinalListBoard2),
    length(FinalListBoard2,LengthOfFinalListBoard2)),
   getNrowNcol(FinalListBoard2,0,Points_Board2,'playerX'),

      (saveElements(Board,'pieceY1',List),
      saveElements(Board,'pieceY2',List2),
      append(List,List2,FinalList),
      getNrowNcol(FinalList,0,Points,'playerY'),

    saveElements(Board2,'pieceY1',ListBoard2),
    saveElements(Board2,'pieceY2',ListBoard2_2),
    append(ListBoard2,ListBoard2_2,FinalListBoard2),
    getNrowNcol(FinalListBoard2,0,Points_Board2,'playerY'))),

      if_then_else(Points@<Points_Board2,(BestCol is LastCol, BestRow is LastRow),(BestCol is Col,BestRow is Row)).

listOfBestMovements([Nrow-Ncol|Rest],FinalList,Board,BestRow,BestCol):-
          setof(Nrow-Ncol,(validateMovePC(Area,LastCol,LastRow,Ncol,Nrow,Board),getPiece(Board,Nrow,Ncol,Piece),
                            setPiece(Board,LastRow,LastCol,Piece,BoardOut2),setPiece(BoardOut2,Nrow,Ncol,'noPiece',BoardOut),
                            evaluateBoards(Board,Nrow,Ncol,LastRow,LastCol,BestCol,BestRow)),List).
