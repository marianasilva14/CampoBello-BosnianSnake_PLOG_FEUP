%Predicate that validates the plays of the pc in the area X1
validateMovePC('areaX1',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else(((LastCol==5,LastRow==3);(LastCol==5,LastRow==4);(LastCol==5,LastRow==2)),
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
%Predicate that validates the plays of the pc in the area X2
validateMovePC('areaX2',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else((LastCol==2,LastRow==5),
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

%Predicate that validates the plays of the pc in the area Y1
validateMovePC('areaY1',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else(((LastCol==7,LastRow==5);(LastCol==8,LastRow==5);(LastCol==6,LastRow==5)),
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
Piece\='empty'))),

if_then_else((LastCol==7,LastRow==4),
(Nrow is LastRow+2,
Ncol is LastCol-2),true).

%Predicate that validates the plays of the pc in the area Y2
validateMovePC('areaY2',LastCol,LastRow,Ncol,Nrow,Board) :-
  if_then_else(((LastCol==5,LastRow==8);(LastCol==5,LastRow==7);(LastCol==5,LastRow==6)),
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
  %Predicate that validates the plays of the player in the area X1
  validateMove('areaX1',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else(((LastCol==5,LastRow==3);(LastCol==5,LastRow==4);(LastCol==5,LastRow==2)),
  (RowTemp is LastRow+2,
  Nrow == RowTemp,
  Ncol == LastCol),
  ((ColTemp is LastCol+2,
  RowTemp is LastRow+2,
  Ncol == ColTemp,
  Nrow == RowTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (ColTemp is LastCol+2,
  Nrow == LastRow,
  Ncol == ColTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (RowTemp is LastRow+2,
  Nrow == RowTemp,
  Ncol == LastCol,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty'))),
  if_then_else((LastCol==4,LastRow==3),
  (RowTemp is LastRow+2,
  ColTemp is LastCol+2,
  Nrow == RowTemp,
  Ncol == ColTemp),true).

  %Predicate that validates the plays of the player in the area X2
  validateMove('areaX2',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else((LastCol==2,LastRow==5),
  (RowTemp is LastRow+2,
  Nrow == RowTemp,
  Ncol == LastCol;
  (ColTemp is LastCol+2,
  Nrow == LastRow,
  Ncol == ColTemp)),
  ((ColTemp is LastCol+2,
  RowTemp is LastRow-2,
  Nrow == RowTemp,
  Ncol == ColTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (ColTemp is LastCol+2,
  Nrow == LastRow,
  Ncol == ColTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (RowTemp is LastRow+2,
  Nrow == RowTemp,
  Ncol == LastCol,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty'))),

  if_then_else((LastCol==3,LastRow==5),
  (ColTemp is LastCol+2,
  Nrow == LastRow,
  Ncol == ColTemp),true),

  if_then_else((LastCol==3,LastRow==6),
  (ColTemp is LastCol+2,
  RowTemp is LastRow-2,
  Nrow == RowTemp,
  Ncol == ColTemp),true).

  %Predicate that validates the plays of the player in the area Y1
  validateMove('areaY1',LastCol,LastRow,Ncol,Nrow,Board) :- if_then_else(((LastCol==7,LastRow==5);(LastCol==8,LastRow==5);(LastCol==6,LastRow==5)),
  (ColTemp is LastCol-2,
  Ncol == ColTemp,
  Nrow == LastRow),
  ((ColTemp is LastCol-2,
  Ncol == ColTemp,
  RowTemp is LastRow+2,
  Nrow == RowTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (Ncol == LastCol,
  RowTemp is LastRow+2,
  Nrow == RowTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (ColTemp is LastCol-2,
  Ncol == ColTemp,
  Nrow == LastRow,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty'))),

  if_then_else((LastCol==7,LastRow==4),
  (RowTemp is LastRow+2,
  Nrow == RowTemp,
  ColTemp is LastCol-2,
  Ncol == ColTemp),true).

  %Predicate that validates the plays of the player in the area Y2
  validateMove('areaY2',LastCol,LastRow,Ncol,Nrow,Board) :-  if_then_else(((LastCol==5,LastRow==8);(LastCol==5,LastRow==7);(LastCol==5,LastRow==6)),
  (RowTemp is LastRow-2,
  Ncol == LastCol,
  Nrow == RowTemp),
  ((ColTemp is LastCol-2,
  RowTemp is LastRow-2,
  Ncol == ColTemp,
  Nrow == RowTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (ColTemp is LastCol-2,
  Ncol == ColTemp,
  Nrow == LastRow,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty');
  (RowTemp is LastRow-2,
  Ncol == LastCol,
  Nrow == RowTemp,
  getPiece(Board,Nrow,Ncol,Piece),
  Piece\='empty'))),

  if_then_else((LastCol==6,LastRow==5),
  (ColTemp is LastCol-2,
  Ncol == ColTemp,
  Nrow == LastRow),true).
